package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgPresetSoldier;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GvgPresetSoldierRepository extends JpaRepository<GvgPresetSoldier, Long> {

    List<GvgPresetSoldier> findByPreset_Id(Long presetId);

    void deleteByPreset_Id(Long presetId);
}