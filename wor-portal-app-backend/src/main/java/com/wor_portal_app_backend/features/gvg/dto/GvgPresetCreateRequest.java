package com.wor_portal_app_backend.features.gvg.dto;

public record GvgPresetCreateRequest(
        Long mapId,
        String presetCode,
        String name,
        String description
) {
}