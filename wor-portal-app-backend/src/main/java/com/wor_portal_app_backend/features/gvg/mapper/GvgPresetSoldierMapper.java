package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgPresetSoldierResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetSoldier;
import org.springframework.stereotype.Component;

@Component
public class GvgPresetSoldierMapper {

    public GvgPresetSoldierResponse toResponse(
            GvgPresetSoldier presetSoldier
    ) {
        return new GvgPresetSoldierResponse(
                presetSoldier.getId(),
                presetSoldier.getSoldier().getId(),
                presetSoldier.getLevel()
        );
    }
}