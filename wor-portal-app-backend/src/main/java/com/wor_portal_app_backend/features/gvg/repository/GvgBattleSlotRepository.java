package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgBattleSlot;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import jakarta.persistence.LockModeType;

import java.util.List;
import java.util.Optional;

public interface GvgBattleSlotRepository extends JpaRepository<GvgBattleSlot, Long> {
    List<GvgBattleSlot> findByRound_IdAndMapTypeOrderBySlotNumberAscLaneNumberAsc(
            Long roundId,
            GvgMapType mapType
    );

    Optional<GvgBattleSlot> findByIdAndRound_Guild_Id(Long slotId, Long guildId);

    Optional<GvgBattleSlot> findByRound_IdAndMapTypeAndSlotNumberAndLaneNumber(
            Long roundId,
            GvgMapType mapType,
            Integer slotNumber,
            Integer laneNumber
    );

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select s from GvgBattleSlot s where s.id = :slotId and s.round.guild.id = :guildId")
    Optional<GvgBattleSlot> findByIdAndRound_Guild_IdForUpdate(
            @Param("slotId") Long slotId,
            @Param("guildId") Long guildId
    );
}
