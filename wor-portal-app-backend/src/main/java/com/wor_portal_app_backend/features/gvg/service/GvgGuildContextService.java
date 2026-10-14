package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgGuildContextService {

    private final UserRepository userRepository;

    public Guild getCurrentGuild() {
        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            throw new ResourceNotFoundException("Authenticated user not found");
        }

        String username = authentication.getName();

        User user = userRepository.findByUsername(username)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "User not found: " + username
                        )
                );

        Guild guild = user.getGuild();

        if (guild == null) {
            throw new ResourceNotFoundException(
                    "Current user is not a member of any guild"
            );
        }

        return guild;
    }

    public Long getCurrentGuildId() {
        return getCurrentGuild().getId();
    }
}