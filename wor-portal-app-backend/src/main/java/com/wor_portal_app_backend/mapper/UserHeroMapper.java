package com.wor_portal_app_backend.mapper;

import com.wor_portal_app_backend.dto.UserHeroResponseDto;
import com.wor_portal_app_backend.entity.UserHero;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserHeroMapper {

    private final HeroMapper heroMapper;

    public UserHeroResponseDto toDto(UserHero userHero) {
        if (userHero == null) return null;

        return UserHeroResponseDto.builder()
                .id(userHero.getId())
                .userId(userHero.getUser().getId())
                .hero(heroMapper.toDto(userHero.getHero()))
                .awakeningLevel(userHero.getAwakeningLevel())
                .build();
    }
}