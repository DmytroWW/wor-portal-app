package com.wor_portal_app_backend.repository;

import com.wor_portal_app_backend.entity.DemonSoldier;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DemonSoldierRepository extends JpaRepository<DemonSoldier, Long> {

    boolean existsByName(String name);
}