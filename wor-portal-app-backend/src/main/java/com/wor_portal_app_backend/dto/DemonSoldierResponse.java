package com.wor_portal_app_backend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DemonSoldierResponse {

    private Long id;
    private String name;
    private String rarity;
    private String faction;
    private int level;
    private String imageSlug;
}