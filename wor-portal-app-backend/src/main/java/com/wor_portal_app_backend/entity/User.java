package com.wor_portal_app_backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false)
    private String password;

    /**
     * Legacy column kept temporarily to make the transition safe for any code
     * that still reads users.role. New authorization must use platformRole and
     * new guild logic must use guildRole.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private Role role;

    @Enumerated(EnumType.STRING)
    @Column(name = "platform_role", nullable = false)
    @Builder.Default
    private PlatformRole platformRole = PlatformRole.USER;

    @Enumerated(EnumType.STRING)
    @Column(name = "guild_role")
    private GuildRole guildRole;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guild_id")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Guild guild;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (platformRole == null) {
            platformRole = PlatformRole.USER;
        }
        if (role == null) {
            role = platformRole == PlatformRole.ADMIN ? Role.ADMIN : Role.MEMBER;
        }
        if (guild == null) {
            guildRole = null;
        } else if (guildRole == null) {
            guildRole = GuildRole.MEMBER;
        }
    }

    /** Legacy enum mapped to the old `role` column. */
    public enum Role {
        ADMIN, LEADER, OFFICER, MEMBER, USER
    }

    /** Global application role; independent of guild rank. */
    public enum PlatformRole {
        USER, ADMIN
    }

    /** Rank inside the user's current guild; null means no guild. */
    public enum GuildRole {
        LEADER, OFFICER, MEMBER
    }
}
