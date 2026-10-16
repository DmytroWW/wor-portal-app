package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.entity.DemonSoldier;
import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.exception.ValidationException;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import com.wor_portal_app_backend.features.gvg.enums.GvgTileType;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapTileRepository;
import com.wor_portal_app_backend.repository.DemonSoldierRepository;
import com.wor_portal_app_backend.repository.HeroRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgMapValidationService {

    private final GvgMapRepository gvgMapRepository;
    private final GvgMapTileRepository gvgMapTileRepository;
    private final HeroRepository heroRepository;
    private final DemonSoldierRepository demonSoldierRepository;

    public GvgMap getMap(Long mapId) {
        return gvgMapRepository.findById(mapId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG map not found: " + mapId
                        )
                );
    }

    public GvgMapTile getTile(Long tileId) {
        return gvgMapTileRepository.findById(tileId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG map tile not found: " + tileId
                        )
                );
    }

    public Hero getHero(Long heroId) {
        return heroRepository.findById(heroId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Hero not found: " + heroId
                        )
                );
    }

    public DemonSoldier getSoldier(Long soldierId) {
        return demonSoldierRepository.findById(soldierId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Demon soldier not found: " + soldierId
                        )
                );
    }

    public void validateTileBelongsToMap(
            GvgMapTile tile,
            GvgMap map
    ) {
        if (!tile.getMap().getId().equals(map.getId())) {
            throw new ValidationException(
                    "Tile does not belong to the specified GVG map"
            );
        }
    }

    public void validateHeroTileCompatibility(
            Hero hero,
            GvgMapTile tile
    ) {
        if (tile.getTileType() == null) {
            throw new ValidationException(
                    "Tile type is not defined"
            );
        }
        if (tile.getTileType() == GvgTileType.EMPTY) {
            throw new ValidationException(
                    "Cannot place a hero on an EMPTY tile"
            );
        }

        String heroClass = hero.getClassName();

        if (heroClass == null || heroClass.isBlank()) {
            throw new ValidationException(
                    "Hero class is not defined"
            );
        }

        boolean valid = switch (heroClass.toUpperCase()) {
            case "DEFENDER", "FIGHTER" ->
                    tile.getTileType() == GvgTileType.GROUND;

            case "MARKSMAN", "MAGE", "HEALER" ->
                    tile.getTileType() == GvgTileType.PLATFORM;

            case "TACTICIAN" ->
                    tile.getTileType() == GvgTileType.GROUND
                            || tile.getTileType() == GvgTileType.PLATFORM;

            default -> false;
        };

        if (!valid) {
            throw new ValidationException(
                    "Hero class " + heroClass
                            + " cannot be placed on tile type "
                            + tile.getTileType()
            );
        }
    }

    public void validateSoldierLevel(Integer level) {
        if (level == null || level < 1 || level > 10) {
            throw new ValidationException(
                    "Soldier level must be between 1 and 10"
            );
        }
    }
}