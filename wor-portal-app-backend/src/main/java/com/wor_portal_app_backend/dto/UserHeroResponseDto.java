package com.wor_portal_app_backend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserHeroResponseDto {
    private Long id;
    private Long userId;
    private HeroResponseDto hero;
    private int awakeningLevel;
}