package com.wor_portal_app_backend.features.gvg.controller;

import com.wor_portal_app_backend.features.gvg.dto.GvgMapCreateRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileUpdateRequest;
import com.wor_portal_app_backend.features.gvg.service.GvgAdminMapService;
import com.wor_portal_app_backend.features.gvg.dto.GvgMapTileBatchUpdateRequest;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/gvg/admin/maps")
@RequiredArgsConstructor
public class GvgAdminMapController {

    private final GvgAdminMapService adminMapService;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public GvgMapResponse createMap(
            @RequestBody GvgMapCreateRequest request
    ) {
        return adminMapService.createMap(request);
    }

    @PutMapping("/{mapId}/tiles/{tileId}")
    public GvgMapTileResponse updateTile(
            @PathVariable Long mapId,
            @PathVariable Long tileId,
            @RequestBody GvgMapTileUpdateRequest request
    ) {
        return adminMapService.updateTile(
                mapId,
                tileId,
                request
        );
    }

    @PutMapping("/{mapId}/activate")
    public GvgMapResponse activateMap(
            @PathVariable Long mapId
    ) {
        return adminMapService.activateMap(mapId);
    }

    @PutMapping("/{mapId}/tiles")
    public List<GvgMapTileResponse> updateTiles(
            @PathVariable Long mapId,
            @RequestBody GvgMapTileBatchUpdateRequest request
    ) {
        return adminMapService.updateTiles(mapId, request);
    }


}