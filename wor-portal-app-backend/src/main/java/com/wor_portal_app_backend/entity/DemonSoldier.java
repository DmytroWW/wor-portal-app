package com.wor_portal_app_backend.entity;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "demon_soldiers",
        uniqueConstraints = {
                @UniqueConstraint(name = "uk_demon_soldier_name", columnNames = "name"),
                @UniqueConstraint(name = "uk_demon_soldier_image_slug", columnNames = "image_slug")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DemonSoldier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String name;

    @Column(nullable = false, length = 20)
    private String rarity;

    @Column(nullable = false, length = 50)
    private String faction;

    @Column(nullable = false)
    @Builder.Default
    private int level = 1;

    @Column(name = "image_slug", nullable = false, unique = true, length = 100)
    private String imageSlug;

}
