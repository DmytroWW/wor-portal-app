package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import org.springframework.stereotype.Component;

@Component
public class GvgPresetHeroMapper {

    public GvgPresetHeroResponse toResponse(GvgPresetHero presetHero) {
        return new GvgPresetHeroResponse(
                presetHero.getId(),
                presetHero.getHero().getId(),
                presetHero.getTile() != null
                        ? presetHero.getTile().getId()
                        : null,
                presetHero.getAttackDirection()
        );
    }
}