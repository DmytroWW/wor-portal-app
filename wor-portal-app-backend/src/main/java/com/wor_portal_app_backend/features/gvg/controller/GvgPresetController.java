package com.wor_portal_app_backend.features.gvg.controller;

import com.wor_portal_app_backend.features.gvg.dto.*;
import com.wor_portal_app_backend.features.gvg.service.GvgPresetSearchService;
import com.wor_portal_app_backend.features.gvg.service.GvgPresetService;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/gvg/presets")
@RequiredArgsConstructor
public class GvgPresetController {

    private final GvgPresetService presetService;
    private final GvgPresetSearchService presetSearchService;

    /*
     * =========================
     * PRESETS
     * =========================
     */

    @GetMapping
    public List<GvgPresetResponse> getMyGuildPresets() {
        return presetService.getMyGuildPresets();
    }

    @GetMapping("/{presetId}/details")
    public GvgPresetDetailsResponse getPresetDetails(
            @PathVariable Long presetId
    ) {
        return presetService.getPresetDetails(presetId);
    }

    @GetMapping("/{presetId}")
    public GvgPresetResponse getPreset(
            @PathVariable Long presetId
    ) {
        return presetService.getPreset(presetId);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public GvgPresetResponse createPreset(
            @RequestBody GvgPresetCreateRequest request
    ) {
        return presetService.createPreset(request);
    }

    @PutMapping("/{presetId}")
    public GvgPresetResponse updatePreset(
            @PathVariable Long presetId,
            @RequestBody GvgPresetUpdateRequest request
    ) {
        return presetService.updatePreset(
                presetId,
                request
        );
    }

    @DeleteMapping("/{presetId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletePreset(
            @PathVariable Long presetId
    ) {
        presetService.deletePreset(presetId);
    }

    @PostMapping("/search")
    public List<GvgPresetResponse> searchExactPresets(
            @RequestBody GvgPresetSearchRequest request
    ) {
        return presetSearchService.searchExactPresets(request);
    }

    /*
     * =========================
     * HEROES
     * =========================
     */

    @GetMapping("/{presetId}/heroes")
    public List<GvgPresetHeroResponse> getPresetHeroes(
            @PathVariable Long presetId
    ) {
        return presetService.getPresetHeroes(presetId);
    }

    @PostMapping("/{presetId}/heroes")
    @ResponseStatus(HttpStatus.CREATED)
    public GvgPresetHeroResponse addHero(
            @PathVariable Long presetId,
            @RequestBody GvgPresetHeroRequest request
    ) {
        return presetService.addHero(
                presetId,
                request
        );
    }

    @PutMapping("/{presetId}/heroes/{heroId}")
    public GvgPresetHeroResponse updateHero(
            @PathVariable Long presetId,
            @PathVariable Long heroId,
            @RequestBody GvgPresetHeroRequest request
    ) {
        return presetService.updateHero(
                presetId,
                heroId,
                request
        );
    }

    @DeleteMapping("/{presetId}/heroes/{heroId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeHero(
            @PathVariable Long presetId,
            @PathVariable Long heroId
    ) {
        presetService.removeHero(
                presetId,
                heroId
        );
    }

    /*
     * =========================
     * SOLDIERS
     * =========================
     */

    @GetMapping("/{presetId}/soldiers")
    public List<GvgPresetSoldierResponse> getPresetSoldiers(
            @PathVariable Long presetId
    ) {
        return presetService.getPresetSoldiers(presetId);
    }

    @PostMapping("/{presetId}/soldiers")
    @ResponseStatus(HttpStatus.CREATED)
    public GvgPresetSoldierResponse addSoldier(
            @PathVariable Long presetId,
            @RequestBody GvgPresetSoldierRequest request
    ) {
        return presetService.addSoldier(
                presetId,
                request
        );
    }

    @PutMapping("/{presetId}/soldiers/{soldierId}")
    public GvgPresetSoldierResponse updateSoldier(
            @PathVariable Long presetId,
            @PathVariable Long soldierId,
            @RequestBody GvgPresetSoldierRequest request
    ) {
        return presetService.updateSoldier(
                presetId,
                soldierId,
                request
        );
    }

    @DeleteMapping("/{presetId}/soldiers/{soldierId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeSoldier(
            @PathVariable Long presetId,
            @PathVariable Long soldierId
    ) {
        presetService.removeSoldier(
                presetId,
                soldierId
        );
    }
}