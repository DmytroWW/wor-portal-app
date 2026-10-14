package com.wor_portal_app_backend.features.gvg.mapper;

import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileResponse;
import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import org.springframework.stereotype.Component;

@Component
public class GvgMapTileMapper {

    public GvgMapTileResponse toResponse(GvgMapTile tile) {
        return new GvgMapTileResponse(
                tile.getId(),
                tile.getMap().getId(),
                tile.getX(),
                tile.getY(),
                tile.getTileType(),
                tile.getAttackDirection()
        );
    }
}