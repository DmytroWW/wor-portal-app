package com.wor_portal_app_backend.features.gvg.dto;

import java.util.List;

public record GvgMapTileBatchUpdateRequest(
        List<GvgMapTileBatchUpdateItemRequest> tiles
) {}