package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;
import com.wor_portal_app_backend.features.gvg.enums.GvgTileType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;

@Entity
@Table(
        name = "gvg_map_tiles",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_gvg_map_tile_position",
                columnNames = {"map_id", "x", "y"}
        )
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgMapTile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "map_id", nullable = false)
    private GvgMap map;

    @Column(nullable = false)
    private Integer x;

    @Column(nullable = false)
    private Integer y;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "tile_type", nullable = false)
    private GvgTileType tileType;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "attack_direction")
    private AttackDirection attackDirection;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}