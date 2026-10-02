package com.wor_portal_app_backend.controller;

import com.wor_portal_app_backend.dto.CreateGuildRequest;
import com.wor_portal_app_backend.dto.GuildResponse;
import com.wor_portal_app_backend.service.GuildService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/guilds")
@RequiredArgsConstructor
public class GuildController {

    private final GuildService guildService;

    @PostMapping("/create")
    public ResponseEntity<GuildResponse> createGuild(
            @RequestBody CreateGuildRequest request,
            Authentication authentication
    ) {
        GuildResponse response = guildService.createGuild(request, authentication.getName());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/join")
    public ResponseEntity<GuildResponse> joinGuild(
            @RequestParam String inviteCode,
            Authentication authentication
    ) {
        GuildResponse response = guildService.joinGuild(inviteCode, authentication.getName());
        return ResponseEntity.ok(response);
    }


}