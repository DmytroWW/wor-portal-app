package com.wor_portal_app_backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "user_heroes", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"user_id", "hero_id"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserHero {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Зв'язок із користувачем, якому належить ростер
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Зв'язок із героєм із загального довідника
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hero_id", nullable = false)
    private Hero hero;

    // Рівень пробудження (від 0 до 5)
    @Column(name = "awakening_level", nullable = false)
    private int awakeningLevel = 0;
}