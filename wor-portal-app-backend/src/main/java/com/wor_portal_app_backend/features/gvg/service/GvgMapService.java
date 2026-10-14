package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import com.wor_portal_app_backend.features.gvg.mapper.GvgMapMapper;
import com.wor_portal_app_backend.features.gvg.repository.GvgMapRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgMapService {

    private final GvgMapRepository gvgMapRepository;
    private final GvgMapMapper gvgMapMapper;

    public List<GvgMapResponse> getAllMaps() {
        return gvgMapRepository.findAll()
                .stream()
                .map(gvgMapMapper::toResponse)
                .toList();
    }

    public GvgMapResponse getById(Long mapId) {
        GvgMap map = gvgMapRepository.findById(mapId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG map not found: " + mapId
                        )
                );

        return gvgMapMapper.toResponse(map);
    }

    public GvgMapResponse getActiveMap(GvgMapType mapType) {
        GvgMap map = gvgMapRepository
                .findByMapTypeAndActiveTrue(mapType)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Active GVG map not found for type: " + mapType
                        )
                );

        return gvgMapMapper.toResponse(map);
    }
}