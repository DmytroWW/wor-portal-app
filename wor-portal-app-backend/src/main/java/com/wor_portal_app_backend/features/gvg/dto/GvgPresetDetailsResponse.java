package com.wor_portal_app_backend.features.gvg.dto;

import java.util.List;

public record GvgPresetDetailsResponse(
        GvgPresetResponse preset,
        GvgMapResponse map,
        List<GvgPresetHeroDetailsResponse> heroes,
        List<GvgPresetSoldierResponse> soldiers
) {
}