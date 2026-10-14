package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.entity.DemonSoldier;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(
        name = "gvg_preset_soldiers",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_gvg_preset_soldier",
                columnNames = {"preset_id", "soldier_id"}
        )
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgPresetSoldier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "preset_id", nullable = false)
    private GvgPreset preset;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "soldier_id", nullable = false)
    private DemonSoldier soldier;

    @Column(nullable = false)
    private Integer level;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}