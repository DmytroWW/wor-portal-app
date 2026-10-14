package com.wor_portal_app_backend.features.gvg.dto;

public record GvgPresetUpdateRequest(
        String presetCode,
        String name,
        String description
) {
}