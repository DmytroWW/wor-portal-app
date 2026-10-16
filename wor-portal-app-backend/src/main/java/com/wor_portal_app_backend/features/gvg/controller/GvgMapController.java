package com.wor_portal_app_backend.features.gvg.controller;

import com.wor_portal_app_backend.features.gvg.dto.GvgMapResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileResponse;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import com.wor_portal_app_backend.features.gvg.service.GvgMapService;
import com.wor_portal_app_backend.features.gvg.service.GvgMapTileService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/gvg/maps")
@RequiredArgsConstructor
public class GvgMapController {

    private final GvgMapService mapService;
    private final GvgMapTileService mapTileService;

    /**
     * GET /gvg/maps
     * Отримати всі GvG-карти.
     */
    @GetMapping
    public List<GvgMapResponse> getAllMaps() {
        return mapService.getAllMaps();
    }

    /**
     * GET /gvg/maps/active?type=FORT
     * GET /gvg/maps/active?type=TOWER
     * Отримати активну карту вибраного типу.
     */
    @GetMapping("/active")
    public GvgMapResponse getActiveMap(
            @RequestParam GvgMapType type
    ) {
        return mapService.getActiveMap(type);
    }

    /**
     * GET /gvg/maps/{mapId}
     * Отримати одну карту за ID.
     */
    @GetMapping("/{mapId}")
    public GvgMapResponse getMapById(
            @PathVariable Long mapId
    ) {
        return mapService.getById(mapId);
    }

    /**
     * GET /gvg/maps/{mapId}/tiles
     * Отримати всі клітинки карти.
     */
    @GetMapping("/{mapId}/tiles")
    public List<GvgMapTileResponse> getMapTiles(
            @PathVariable Long mapId
    ) {
        return mapTileService.getTiles(mapId);
    }
}