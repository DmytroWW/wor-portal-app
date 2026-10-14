package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GvgMapTileRepository extends JpaRepository<GvgMapTile, Long> {

    List<GvgMapTile> findByMap_IdOrderByYAscXAsc(Long mapId);

    Optional<GvgMapTile> findByMap_IdAndXAndY(
            Long mapId,
            Integer x,
            Integer y
    );
}