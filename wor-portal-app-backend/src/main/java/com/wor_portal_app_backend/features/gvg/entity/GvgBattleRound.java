package com.wor_portal_app_backend.features.gvg.entity;

import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.features.gvg.enums.GvgBattleRoundStatus;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(
    name = "gvg_battle_rounds",
    uniqueConstraints = @UniqueConstraint(
        name = "uk_gvg_battle_round_guild_number",
        columnNames = {"guild_id", "round_number"}
    )
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GvgBattleRound {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guild_id", nullable = false)
    private Guild guild;

    @Column(name = "round_number", nullable = false)
    private Integer roundNumber;

    @Column(name = "opponent_name", nullable = false, length = 150)
    private String opponentName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 16)
    @Builder.Default
    private GvgBattleRoundStatus status = GvgBattleRoundStatus.ACTIVE;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "locked_at")
    private LocalDateTime lockedAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (status == null) status = GvgBattleRoundStatus.ACTIVE;
    }
}
