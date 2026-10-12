package com.wor_portal_app_backend.mapper;

import com.wor_portal_app_backend.dto.DemonSoldierResponse;
import com.wor_portal_app_backend.entity.DemonSoldier;
import org.springframework.stereotype.Component;

@Component
public class DemonSoldierMapper {

    public DemonSoldierResponse toDto(DemonSoldier soldier) {

        if (soldier == null) {
            return null;
        }

        return DemonSoldierResponse.builder()
                .id(soldier.getId())
                .name(soldier.getName())
                .rarity(soldier.getRarity())
                .faction(soldier.getFaction())
                .level(soldier.getLevel())
                .imageSlug(soldier.getImageSlug())
                .build();
    }
}