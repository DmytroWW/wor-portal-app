package com.wor_portal_app_backend.features.gvg.dto;

import java.util.List;

public record GvgPresetSearchRequest(
        Long mapId,
        List<GvgPresetHeroRequest> heroes
) {
}