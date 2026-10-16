package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.GvgTileType;

public record GvgMapTileBatchUpdateItemRequest(
        Integer x,
        Integer y,
        GvgTileType tileType
) {}