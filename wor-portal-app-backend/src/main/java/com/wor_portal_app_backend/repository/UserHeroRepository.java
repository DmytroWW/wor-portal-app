package com.wor_portal_app_backend.repository;

import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.entity.UserHero;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserHeroRepository extends JpaRepository <UserHero, Long> {

    List<UserHero> findByUserId(Long userId);

    Optional<UserHero> findByUserIdAndHeroId(
            Long userId, Long heroId
    );
}