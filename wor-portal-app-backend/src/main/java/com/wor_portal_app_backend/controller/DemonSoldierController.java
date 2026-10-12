package com.wor_portal_app_backend.controller;

import com.wor_portal_app_backend.dto.DemonSoldierResponse;
import com.wor_portal_app_backend.service.DemonSoldierService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/demon-soldiers")
@RequiredArgsConstructor
public class DemonSoldierController {
    private final DemonSoldierService demonSoldierService;

    @GetMapping
    public ResponseEntity<List<DemonSoldierResponse>> getAll() {

        return ResponseEntity.ok(
                demonSoldierService.getAllDemonSoldiers()
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<DemonSoldierResponse> getById(
            @PathVariable Long id
    ) {

        return ResponseEntity.ok(
                demonSoldierService.getDemonSoldierById(id)
        );
    }
}
