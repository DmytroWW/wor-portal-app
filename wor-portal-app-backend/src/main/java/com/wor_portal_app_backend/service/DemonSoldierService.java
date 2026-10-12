package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.DemonSoldierResponse;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.mapper.DemonSoldierMapper;
import com.wor_portal_app_backend.repository.DemonSoldierRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DemonSoldierService {

    private final DemonSoldierRepository demonSoldierRepository;
    private final DemonSoldierMapper demonSoldierMapper;

    @Transactional(readOnly = true)
    public List<DemonSoldierResponse> getAllDemonSoldiers() {

        return demonSoldierRepository.findAll()
                .stream()
                .map(demonSoldierMapper::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public DemonSoldierResponse getDemonSoldierById(Long id) {

        return demonSoldierRepository.findById(id)
                .map(demonSoldierMapper::toDto)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Demon Soldier not found with id: " + id
                        )
                );
    }
}