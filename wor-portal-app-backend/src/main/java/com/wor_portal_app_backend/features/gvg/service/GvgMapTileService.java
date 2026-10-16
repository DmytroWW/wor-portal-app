package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileResponse;
import com.wor_portal_app_backend.features.gvg.mapper.GvgMapTileMapper;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapTileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgMapTileService {

    private final GvgMapValidationService mapValidationService;
    private final GvgMapTileRepository mapTileRepository;
    private final GvgMapTileMapper mapTileMapper;

    public List<GvgMapTileResponse> getTiles(Long mapId) {
        // Якщо карти немає, повернеться ResourceNotFoundException.
        mapValidationService.getMap(mapId);

        return mapTileRepository.findByMap_IdOrderByYAscXAsc(mapId)
                .stream()
                .map(mapTileMapper::toResponse)
                .toList();
    }
}