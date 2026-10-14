package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;

import java.time.LocalDateTime;

public record GvgMapResponse(
        Long id,
        Integer seasonNumber,
        GvgMapType mapType,
        String name,
        Integer width,
        Integer height,
        Boolean active,
        LocalDateTime createdAt
) {
}