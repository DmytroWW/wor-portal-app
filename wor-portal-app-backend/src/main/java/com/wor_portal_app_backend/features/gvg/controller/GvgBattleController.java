package com.wor_portal_app_backend.features.gvg.controller;

import com.wor_portal_app_backend.features.gvg.dto.*;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import com.wor_portal_app_backend.features.gvg.service.GvgBattleService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/gvg/battle")
@RequiredArgsConstructor
public class GvgBattleController {
    private final GvgBattleService battleService;

    @GetMapping("/active")
    public ResponseEntity<GvgBattleRoundResponse> getActiveRound(
            @RequestParam(defaultValue = "TOWER") GvgMapType mapType
    ) {
        GvgBattleRoundResponse round = battleService.getActiveRound(mapType);
        if (round == null) return ResponseEntity.<GvgBattleRoundResponse>noContent().build();
        return ResponseEntity.ok(round);
    }

    @GetMapping("/rounds/history")
    public List<GvgBattleRoundSummaryResponse> getHistory() {
        return battleService.getHistory();
    }

    @GetMapping("/rounds/{roundId}")
    public GvgBattleRoundResponse getRound(
            @PathVariable Long roundId,
            @RequestParam(defaultValue = "TOWER") GvgMapType mapType
    ) {
        return battleService.getRound(roundId, mapType);
    }

    /** Creates round 1 if no active round exists; otherwise locks the current round and creates the next. */
    @PostMapping("/rounds/next")
    public GvgBattleRoundResponse createNextRound(
            @RequestBody GvgBattleRoundCreateRequest request,
            @RequestParam(defaultValue = "TOWER") GvgMapType mapType
    ) {
        return battleService.createNextRound(request, mapType);
    }

    @PatchMapping("/rounds/{roundId}/opponent")
    public GvgBattleRoundResponse renameOpponent(
            @PathVariable Long roundId,
            @RequestBody GvgBattleOpponentUpdateRequest request,
            @RequestParam(defaultValue = "TOWER") GvgMapType mapType
    ) {
        return battleService.renameOpponent(roundId, request, mapType);
    }

    @PutMapping("/slots/{slotId}")
    public GvgBattleSlotResponse updateSlot(
            @PathVariable Long slotId,
            @RequestBody GvgBattleSlotUpdateRequest request
    ) {
        return battleService.updateSlot(slotId, request);
    }

    @PutMapping("/slots/{slotId}/defense")
    public GvgBattleSlotResponse updateDefense(
            @PathVariable Long slotId,
            @RequestBody GvgBattleDefenseUpdateRequest request
    ) {
        return battleService.updateDefense(slotId, request);
    }

    @PatchMapping("/slots/{slotId}/breach")
    public GvgBattleSlotResponse updateBreach(
            @PathVariable Long slotId,
            @RequestBody GvgBattleBreachRequest request
    ) {
        return battleService.updateBreach(slotId, request);
    }
}
