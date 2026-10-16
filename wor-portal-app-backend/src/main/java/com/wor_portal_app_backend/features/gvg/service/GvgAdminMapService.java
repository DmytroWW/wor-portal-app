package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.exception.ValidationException;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapCreateRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileUpdateRequest;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import com.wor_portal_app_backend.features.gvg.enums.GvgTileType;
import com.wor_portal_app_backend.features.gvg.mapper.GvgMapMapper;
import com.wor_portal_app_backend.features.gvg.mapper.GvgMapTileMapper;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapTileRepository;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileBatchUpdateRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileBatchUpdateItemRequest;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgAdminMapService {

    private final GvgMapRepository mapRepository;
    private final GvgMapTileRepository tileRepository;

    private final GvgMapMapper mapMapper;
    private final GvgMapTileMapper tileMapper;

    @Transactional
    public GvgMapResponse createMap(
            GvgMapCreateRequest request
    ) {
        validateCreateRequest(request);

        if (mapRepository.findBySeasonNumberAndMapType(
                request.seasonNumber(),
                request.mapType()
        ).isPresent()) {
            throw new ValidationException(
                    "Map already exists for season "
                            + request.seasonNumber()
                            + " and type "
                            + request.mapType()
            );
        }

        int width = getWidth(request.mapType());
        int height = getHeight(request.mapType());

        GvgMap map = GvgMap.builder()
                .seasonNumber(request.seasonNumber())
                .mapType(request.mapType())
                .name(request.name().trim())
                .width(width)
                .height(height)
                .active(false)
                .build();

        GvgMap savedMap = mapRepository.save(map);

        List<GvgMapTile> tiles = java.util.stream.IntStream
                .range(0, height)
                .boxed()
                .flatMap(y ->
                        java.util.stream.IntStream
                                .range(0, width)
                                .mapToObj(x ->
                                        GvgMapTile.builder()
                                                .map(savedMap)
                                                .x(x)
                                                .y(y)
                                                .tileType(GvgTileType.EMPTY)
                                                .build()
                                )
                )
                .toList();

        tileRepository.saveAll(tiles);

        return mapMapper.toResponse(savedMap);
    }

    @Transactional
    public GvgMapTileResponse updateTile(
            Long mapId,
            Long tileId,
            GvgMapTileUpdateRequest request
    ) {
        if (request == null || request.tileType() == null) {
            throw new ValidationException(
                    "Tile type must not be null"
            );
        }

        GvgMap map = mapRepository.findById(mapId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG map not found: " + mapId
                        )
                );

        GvgMapTile tile = tileRepository.findById(tileId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG map tile not found: " + tileId
                        )
                );

        if (!tile.getMap().getId().equals(map.getId())) {
            throw new ValidationException(
                    "Tile does not belong to the specified map"
            );
        }

        tile.setTileType(request.tileType());

        return tileMapper.toResponse(
                tileRepository.save(tile)
        );
    }

    @Transactional
    public List<GvgMapTileResponse> updateTiles(
            Long mapId,
            GvgMapTileBatchUpdateRequest request
    ) {
        if (request == null || request.tiles() == null
                || request.tiles().isEmpty()) {
            throw new ValidationException(
                    "At least one tile must be provided"
            );
        }

        GvgMap map = mapRepository.findById(mapId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "GVG map not found: " + mapId
                ));

        // Завантажуємо клітинки карти одним запитом.
        List<GvgMapTile> existingTiles =
                tileRepository.findByMap_IdOrderByYAscXAsc(mapId);

        // Створюємо індекс клітинок за координатами.
        Map<String, GvgMapTile> tilesByPosition = new HashMap<>();

        for (GvgMapTile tile : existingTiles) {
            tilesByPosition.put(
                    tile.getX() + ":" + tile.getY(),
                    tile
            );
        }

        Set<String> processedPositions = new HashSet<>();
        List<GvgMapTile> tilesToSave = new java.util.ArrayList<>();

        for (GvgMapTileBatchUpdateItemRequest item : request.tiles()) {
            if (item == null
                    || item.x() == null
                    || item.y() == null
                    || item.tileType() == null) {
                throw new ValidationException(
                        "Tile coordinates and tile type must not be null"
                );
            }

            int x = item.x();
            int y = item.y();

            if (x < 0 || x >= map.getWidth()
                    || y < 0 || y >= map.getHeight()) {
                throw new ValidationException(
                        "Tile coordinates are outside the map: x="
                                + x + ", y=" + y
                );
            }

            String position = x + ":" + y;

            if (!processedPositions.add(position)) {
                throw new ValidationException(
                        "Duplicate tile coordinates: x="
                                + x + ", y=" + y
                );
            }

            GvgMapTile tile = tilesByPosition.get(position);

            if (tile == null) {
                throw new ResourceNotFoundException(
                        "Tile not found at x=" + x + ", y=" + y
                );
            }

            tile.setTileType(item.tileType());
            tilesToSave.add(tile);
        }

        return tileRepository.saveAll(tilesToSave)
                .stream()
                .sorted(
                        java.util.Comparator
                                .comparing(GvgMapTile::getY)
                                .thenComparing(GvgMapTile::getX)
                )
                .map(tileMapper::toResponse)
                .toList();
    }

    @Transactional
    public GvgMapResponse activateMap(Long mapId) {
        GvgMap mapToActivate = mapRepository.findById(mapId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "GVG map not found: " + mapId
                ));

        // Якщо карта вже активна, нічого не змінюємо.
        if (mapToActivate.isActive()) {
            return mapMapper.toResponse(mapToActivate);
        }

        // Знаходимо активну карту того самого типу.
        mapRepository.findByMapTypeAndActiveTrue(mapToActivate.getMapType())
                .ifPresent(activeMap -> {
                    activeMap.setActive(false);
                    mapRepository.save(activeMap);
                });

        // Активуємо вибрану карту.
        mapToActivate.setActive(true);

        GvgMap savedMap = mapRepository.save(mapToActivate);

        return mapMapper.toResponse(savedMap);
    }

    private int getWidth(GvgMapType mapType) {
        return switch (mapType) {
            case TOWER -> 10;
            case FORT -> 11;
        };
    }

    private int getHeight(GvgMapType mapType) {
        return switch (mapType) {
            case TOWER -> 7;
            case FORT -> 8;
        };
    }

    private void validateCreateRequest(
            GvgMapCreateRequest request
    ) {
        if (request == null) {
            throw new ValidationException(
                    "Map request must not be null"
            );
        }

        if (request.seasonNumber() == null
                || request.seasonNumber() < 1) {
            throw new ValidationException(
                    "Season number must be greater than zero"
            );
        }

        if (request.mapType() == null) {
            throw new ValidationException(
                    "Map type must not be null"
            );
        }

        if (request.name() == null
                || request.name().isBlank()) {
            throw new ValidationException(
                    "Map name must not be blank"
            );
        }

        if (request.name().trim().length() > 100) {
            throw new ValidationException(
                    "Map name must not exceed 100 characters"
            );
        }
    }
}