package com.wor_portal_app_backend.mapper;

import com.wor_portal_app_backend.dto.HeroResponseDto;
import com.wor_portal_app_backend.entity.Hero;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class HeroMapper {

    public HeroResponseDto toDto(Hero hero) {
        if (hero == null) return null;

        return HeroResponseDto.builder()
                .id(hero.getId())
                .name(hero.getName())
                .imageSlug(hero.getImageSlug())
                .className(hero.getClassName())
                .classIconSlug(hero.getClassIconSlug())
                .rarity(hero.getRarity())
                .factions(hero.getFactions() != null ? List.copyOf(hero.getFactions()) : null)
                .lordFaction(hero.getLordFaction())
                .tags(hero.getTags() != null ? List.copyOf(hero.getTags()) : null)
                .build();
    }
}