package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.UserProfileResponse;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.mapper.UserMapper;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper; // Інжектимо наш новий мапер

    @Transactional(readOnly = true)
    public UserProfileResponse getCurrentUserProfile(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        // Вся логіка збору DTO тепер схована у мапері
        return userMapper.toProfileResponse(user);
    }
}