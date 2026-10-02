package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.UserHeroResponseDto;
import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.entity.UserHero;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.mapper.UserHeroMapper;
import com.wor_portal_app_backend.repository.HeroRepository;
import com.wor_portal_app_backend.repository.UserHeroRepository;
import com.wor_portal_app_backend.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserHeroService {

    private final UserHeroRepository userHeroRepository;
    private final UserRepository userRepository;
    private final HeroRepository heroRepository;
    private final UserHeroMapper userHeroMapper;

    @Transactional
    public List findByUserId(Long userId) {
        return userHeroRepository.findByUserId(userId).stream()
                .map(userHeroMapper::toDto)
                .toList();
    }

    @Transactional
    public UserHeroResponseDto toggleOrUpgradeHero(Long userId, Long heroId) {
        UserHero userHero = userHeroRepository.findByUserIdAndHeroId(userId, heroId).orElseGet(() -> {
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + userId));
            Hero hero = heroRepository.findById(heroId)
                    .orElseThrow(() -> new ResourceNotFoundException("Hero not found with id: " + heroId));

            return UserHero.builder().user(user).hero(hero).awakeningLevel(0).build();
        });

        if (userHero.getId() != null) {
            if (userHero.getAwakeningLevel() < 5) {
                userHero.setAwakeningLevel(userHero.getAwakeningLevel() + 1);
            } else {
                userHero.setAwakeningLevel(0);
            }
        }

        UserHero saved = userHeroRepository.save(userHero);
        return userHeroMapper.toDto(saved);
    }

    @Transactional
    public void removeUserHero(Long userId, Long heroId) {
        userHeroRepository.findByUserIdAndHeroId(userId, heroId).ifPresent(userHeroRepository::delete);
    }

    @Transactional
    public List getUserHeroes(Long userId) {
        return findByUserId(userId);
    }
}