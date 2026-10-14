package com.wor_portal_app_backend.features.gvg.dto;

import java.time.LocalDateTime;

public record GvgPresetResponse(
        Long id,
        Long guildId,
        Long mapId,
        String presetCode,
        String name,
        String description,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}