package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroDetailsResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import org.springframework.stereotype.Component;

@Component
public class GvgPresetHeroDetailsMapper {

    public GvgPresetHeroDetailsResponse toResponse(GvgPresetHero presetHero) {
        if (presetHero.getTile() == null) {
            return new GvgPresetHeroDetailsResponse(
                    presetHero.getId(),
                    presetHero.getHero().getId(),
                    null,
                    null,
                    null,
                    presetHero.getAttackDirection()
            );
        }

        return new GvgPresetHeroDetailsResponse(
                presetHero.getId(),
                presetHero.getHero().getId(),
                presetHero.getTile().getId(),
                presetHero.getTile().getX(),
                presetHero.getTile().getY(),
                presetHero.getAttackDirection()
        );
    }
}