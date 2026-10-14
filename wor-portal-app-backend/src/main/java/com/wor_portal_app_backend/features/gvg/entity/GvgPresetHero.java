package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;

@Entity
@Table(
        name = "gvg_preset_heroes",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_gvg_preset_hero",
                columnNames = {"preset_id", "hero_id"}
        )
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgPresetHero {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "preset_id", nullable = false)
    private GvgPreset preset;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hero_id", nullable = false)
    private Hero hero;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tile_id")
    private GvgMapTile tile;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "attack_direction", nullable = false)
    private AttackDirection attackDirection;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}