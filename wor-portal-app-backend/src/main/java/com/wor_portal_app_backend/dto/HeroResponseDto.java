package com.wor_portal_app_backend.dto;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class HeroResponseDto {
    private Long id;
    private String name;
    private String imageSlug;
    private String className;
    private String classIconSlug;
    private String rarity;
    private List<String> factions;
    private String lordFaction;
    private List<String> tags;
}