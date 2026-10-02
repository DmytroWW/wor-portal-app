package com.wor_portal_app_backend.repository;

import com.wor_portal_app_backend.entity.Guild;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GuildRepository extends JpaRepository<Guild, Long> {
    Optional<Guild> findByInviteCode(String inviteCode);
    boolean existsByInviteCode(String inviteCode);
}