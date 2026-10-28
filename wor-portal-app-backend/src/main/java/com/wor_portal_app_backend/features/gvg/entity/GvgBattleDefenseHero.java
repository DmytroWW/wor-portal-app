package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(
        name = "gvg_battle_defense_heroes",
        uniqueConstraints = {
                @UniqueConstraint(name = "uk_gvg_battle_defense_hero", columnNames = {"slot_id", "hero_id"}),
                @UniqueConstraint(name = "uk_gvg_battle_defense_tile", columnNames = {"slot_id", "tile_id"})
        },
        indexes = @Index(name = "idx_gvg_battle_defense_slot", columnList = "slot_id")
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgBattleDefenseHero {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "slot_id", nullable = false)
    private GvgBattleSlot slot;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hero_id", nullable = false)
    private Hero hero;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tile_id", nullable = false)
    private GvgMapTile tile;

    @Enumerated(EnumType.STRING)
    @Column(name = "attack_direction", nullable = false, length = 12)
    private AttackDirection attackDirection;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
    }
}
