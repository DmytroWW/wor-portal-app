package com.wor_portal_app_backend.features.gvg.repository;


import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GvgPresetHeroRepository extends JpaRepository<GvgPresetHero, Long> {

    List<GvgPresetHero> findByPreset_Id(Long presetId);

    void deleteByPreset_Id(Long presetId);
}