package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgMapResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import org.springframework.stereotype.Component;

@Component
public class GvgMapMapper {

    public GvgMapResponse toResponse(GvgMap map) {
        return new GvgMapResponse(
                map.getId(),
                map.getSeasonNumber(),
                map.getMapType(),
                map.getName(),
                map.getWidth(),
                map.getHeight(),
                map.isActive(),
                map.getCreatedAt()
        );
    }
}