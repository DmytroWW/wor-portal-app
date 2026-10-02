package com.wor_portal_app_backend.repository;

import com.wor_portal_app_backend.entity.Hero;
import org.springframework.data.jpa.repository.JpaRepository;


public interface HeroRepository extends JpaRepository <Hero, Long> {
    boolean existsByName(String name);

}
