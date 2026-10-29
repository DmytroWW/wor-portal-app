package com.wor_portal_app_backend.controller;

import com.wor_portal_app_backend.dto.ChangeGuildRoleRequest;
import com.wor_portal_app_backend.dto.CreateGuildRequest;
import com.wor_portal_app_backend.dto.GuildMemberResponse;
import com.wor_portal_app_backend.dto.GuildResponse;
import com.wor_portal_app_backend.service.GuildService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
        return ResponseEntity.ok(guildService.createGuild(request, authentication.getName()));
    }

    @PostMapping("/join")
    public ResponseEntity<GuildResponse> joinGuild(
            @RequestParam String inviteCode,
            Authentication authentication
    ) {
        return ResponseEntity.ok(guildService.joinGuild(inviteCode, authentication.getName()));
    }

    @GetMapping("/members")
    public ResponseEntity<List<GuildMemberResponse>> getMembers(Authentication authentication) {
        return ResponseEntity.ok(guildService.getMembers(authentication.getName()));
    }

    @PatchMapping("/members/{memberId}/role")
    public ResponseEntity<Void> changeMemberRole(
            @PathVariable Long memberId,
            @RequestBody ChangeGuildRoleRequest request,
            Authentication authentication
    ) {
        guildService.changeMemberRole(memberId, request, authentication.getName());
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/members/{memberId}")
    public ResponseEntity<Void> kickMember(
            @PathVariable Long memberId,
            Authentication authentication
    ) {
        guildService.kickMember(memberId, authentication.getName());
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/members/{memberId}/leader")
    public ResponseEntity<Void> transferLeadership(
            @PathVariable Long memberId,
            Authentication authentication
    ) {
        guildService.transferLeadership(memberId, authentication.getName());
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/invite-code")
    public ResponseEntity<GuildResponse> rotateInviteCode(Authentication authentication) {
        return ResponseEntity.ok(guildService.rotateInviteCode(authentication.getName()));
    }
}
