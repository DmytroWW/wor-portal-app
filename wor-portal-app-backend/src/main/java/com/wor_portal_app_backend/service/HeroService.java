package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.HeroResponseDto;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.mapper.HeroMapper;
import com.wor_portal_app_backend.repository.HeroRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HeroService {

    private final HeroRepository heroRepository;
    private final HeroMapper heroMapper;

    @Transactional
    public List<HeroResponseDto> getAllHeroes() {
        return heroRepository.findAll().stream()
                .map(heroMapper::toDto)
                .toList();
    }

    @Transactional
    public HeroResponseDto getHeroById(Long id) {
        return heroRepository.findById(id)
                .map(heroMapper::toDto)
                .orElseThrow(() -> new ResourceNotFoundException("Hero not found with id: " + id));
    }

    @Transactional
    public List<HeroResponseDto> findByClassName(String className) {
        return heroRepository.findAll().stream()
                .filter(hero -> hero.getClassName().equalsIgnoreCase(className))
                .map(heroMapper::toDto)
                .toList();
    }
}