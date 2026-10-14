package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgPreset;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GvgPresetRepository extends JpaRepository<GvgPreset, Long> {

    List<GvgPreset> findByGuild_IdOrderByCreatedAtDesc(Long guildId);

    Optional<GvgPreset> findByIdAndGuild_Id(
            Long id,
            Long guildId
    );

    boolean existsByGuild_IdAndPresetCode(
            Long guildId,
            String presetCode
    );
}