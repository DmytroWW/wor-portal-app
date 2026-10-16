package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface GvgPresetHeroRepository
        extends JpaRepository<GvgPresetHero, Long> {

    @EntityGraph(attributePaths = {"hero", "tile"})
    List<GvgPresetHero> findByPreset_Id(Long presetId);

    @EntityGraph(attributePaths = {"preset", "hero", "tile"})
    List<GvgPresetHero> findByPreset_IdIn(
            Collection<Long> presetIds
    );

    Optional<GvgPresetHero> findByPreset_IdAndHero_Id(
            Long presetId,
            Long heroId
    );

    boolean existsByPreset_IdAndHero_Id(
            Long presetId,
            Long heroId
    );

    boolean existsByPreset_IdAndTile_Id(
            Long presetId,
            Long tileId
    );

    void deleteByPreset_Id(Long presetId);
}