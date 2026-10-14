package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgPresetResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgPreset;
import org.springframework.stereotype.Component;

@Component
public class GvgPresetMapper {

    public GvgPresetResponse toResponse(GvgPreset preset) {
        return new GvgPresetResponse(
                preset.getId(),
                preset.getGuild().getId(),
                preset.getMap().getId(),
                preset.getPresetCode(),
                preset.getName(),
                preset.getDescription(),
                preset.getCreatedAt(),
                preset.getUpdatedAt()
        );
    }
}