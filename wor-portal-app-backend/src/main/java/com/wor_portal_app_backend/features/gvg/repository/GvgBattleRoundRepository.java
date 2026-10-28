package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgBattleRound;
import com.wor_portal_app_backend.features.gvg.enums.GvgBattleRoundStatus;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface GvgBattleRoundRepository extends JpaRepository<GvgBattleRound, Long> {
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select r from GvgBattleRound r where r.guild.id = :guildId and r.status = :status")
    Optional<GvgBattleRound> findByGuildAndStatusForUpdate(
            @Param("guildId") Long guildId,
            @Param("status") GvgBattleRoundStatus status
    );

    Optional<GvgBattleRound> findByIdAndGuild_Id(Long id, Long guildId);
    Optional<GvgBattleRound> findFirstByGuild_IdAndStatusOrderByRoundNumberDesc(Long guildId, GvgBattleRoundStatus status);
    Optional<GvgBattleRound> findFirstByGuild_IdOrderByRoundNumberDesc(Long guildId);
    List<GvgBattleRound> findByGuild_IdOrderByRoundNumberDesc(Long guildId);
}
