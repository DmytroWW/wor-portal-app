
package com.wor_portal_app_backend.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "heroes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Hero {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String name;

    @Column(name = "image_slug", nullable = false)
    private String imageSlug;

    @Column(name = "class_name", nullable = false)
    private String className;

    @Column(name = "class_icon_slug")
    private String classIconSlug;

    @Column(name = "rarity")
    private String rarity;

    // Список фракцій героя
    @ElementCollection
    @CollectionTable(
            name = "hero_faction_list",
            joinColumns = @JoinColumn(name = "hero_id")
    )
    @Column(name = "faction_name")
    private List<String> factions;

    // Фракція, для якої герой є лордом
    @Column(name = "lord_faction")
    private String lordFaction;

    // Теги для фільтрації
    @ElementCollection
    @CollectionTable(
            name = "hero_tags",
            joinColumns = @JoinColumn(name = "hero_id")
    )
    @Column(name = "tag")
    private List<String> tags;
}