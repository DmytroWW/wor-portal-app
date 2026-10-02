package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.AuthResponse;
import com.wor_portal_app_backend.dto.LoginRequest;
import com.wor_portal_app_backend.dto.RegisterRequest;
import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.exception.InvalidCredentialsException;
import com.wor_portal_app_backend.exception.UserAlreadyExistsException;
import com.wor_portal_app_backend.repository.GuildRepository;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private static final String INVALID_CREDENTIALS_MSG = "Invalid username or password";
    private static final String USERNAME_TAKEN_MSG = "Username already taken";

    private final UserRepository userRepository;
    private final GuildRepository guildRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserAlreadyExistsException(USERNAME_TAKEN_MSG);
        }

        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(User.Role.MEMBER);

        if (request.getInviteCode() != null && !request.getInviteCode().isBlank()) {
            Optional<Guild> guildOpt = guildRepository.findByInviteCode(request.getInviteCode());
            guildOpt.ifPresent(user::setGuild);
        }

        userRepository.save(user);

        String token = jwtService.generateToken(user.getUsername(), user.getRole().name());
        String guildName = user.getGuild() != null ? user.getGuild().getName() : null;

        return new AuthResponse(token, user.getUsername(), user.getRole().name(), guildName);
    }

    @Transactional(readOnly = true)
    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new InvalidCredentialsException(INVALID_CREDENTIALS_MSG));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new InvalidCredentialsException(INVALID_CREDENTIALS_MSG);
        }

        String token = jwtService.generateToken(user.getUsername(), user.getRole().name());
        String guildName = user.getGuild() != null ? user.getGuild().getName() : null;

        return new AuthResponse(token, user.getUsername(), user.getRole().name(), guildName);
    }
}