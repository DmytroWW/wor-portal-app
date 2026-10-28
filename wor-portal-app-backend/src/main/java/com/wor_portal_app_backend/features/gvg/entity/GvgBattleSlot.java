package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
        name = "gvg_battle_slots",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_gvg_battle_slot_position",
                columnNames = {"round_id", "map_type", "slot_number", "lane_number"}
        ),
        indexes = {
                @Index(name = "idx_gvg_battle_slots_round_type", columnList = "round_id,map_type")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgBattleSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "round_id", nullable = false)
    private GvgBattleRound round;

    @Enumerated(EnumType.STRING)
    @Column(name = "map_type", nullable = false, length = 12)
    private GvgMapType mapType;

    /** Position 1..25 for towers and 1..5 for forts. */
    @Column(name = "slot_number", nullable = false)
    private Integer slotNumber;

    /** Two def slots per position: 1 or 2. */
    @Column(name = "lane_number", nullable = false)
    private Integer laneNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "defense_preset_id")
    private GvgPreset defensePreset;

    /** Enemy defense formations are stored independently from our guild's attack presets. */
    @OneToMany(mappedBy = "slot", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<GvgBattleDefenseHero> defenseHeroes = new ArrayList<>();

    @Column(name = "opponent_nickname", length = 100)
    private String opponentNickname;

    @Column(name = "battle_power")
    private Long battlePower;

    @Column(name = "mirror_note", columnDefinition = "TEXT")
    private String mirrorNote;

    @Column(nullable = false)
    @Builder.Default
    private boolean breached = false;

    @Column(name = "breached_by_1", length = 100)
    private String breachedBy1;

    @Column(name = "breached_by_2", length = 100)
    private String breachedBy2;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        if (updatedAt == null) updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
