package com.wor_portal_app_backend.features.gvg.repository;

import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GvgMapRepository extends JpaRepository<GvgMap, Long> {

    Optional<GvgMap> findBySeasonNumberAndMapType(
            Integer seasonNumber,
            GvgMapType mapType
    );

    Optional<GvgMap> findByMapTypeAndActiveTrue(
            GvgMapType mapType
    );
}