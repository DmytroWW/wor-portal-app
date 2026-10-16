package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgPresetSoldier;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GvgPresetSoldierRepository
        extends JpaRepository<GvgPresetSoldier, Long> {

    List<GvgPresetSoldier> findByPreset_Id(Long presetId);

    Optional<GvgPresetSoldier> findByPreset_IdAndSoldier_Id(
            Long presetId,
            Long soldierId
    );

    boolean existsByPreset_IdAndSoldier_Id(
            Long presetId,
            Long soldierId
    );

    void deleteByPreset_Id(Long presetId);
}