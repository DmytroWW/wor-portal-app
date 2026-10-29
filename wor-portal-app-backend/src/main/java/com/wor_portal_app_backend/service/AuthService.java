package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.AuthResponse;
import com.wor_portal_app_backend.dto.LoginRequest;
import com.wor_portal_app_backend.dto.RegisterRequest;
import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.exception.InvalidCredentialsException;
import com.wor_portal_app_backend.exception.UserAlreadyExistsException;
import com.wor_portal_app_backend.mapper.UserMapper;
import com.wor_portal_app_backend.repository.GuildRepository;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.Locale;

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
        if (request == null || request.getUsername() == null || request.getPassword() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Вкажи ім'я користувача та пароль.");
        }

        String username = request.getUsername().trim();
        String password = request.getPassword();

        if (username.length() < 3 || username.length() > 50) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Ім'я користувача має містити від 3 до 50 символів.");
        }
        if (password.length() < 8) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Пароль має містити щонайменше 8 символів.");
        }
        if (userRepository.existsByUsername(username)) {
            throw new UserAlreadyExistsException(USERNAME_TAKEN_MSG);
        }

        Guild invitedGuild = null;
        String inviteCode = request.getInviteCode() == null ? "" : request.getInviteCode().trim();
        if (!inviteCode.isEmpty()) {
            invitedGuild = guildRepository.findByInviteCodeIgnoreCase(inviteCode)
                    .orElseThrow(() -> new ResponseStatusException(
                            HttpStatus.BAD_REQUEST,
                            "Інвайт-код не знайдено. Перевір код або залиш поле порожнім для реєстрації без гільдії."
                    ));
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setPlatformRole(User.PlatformRole.USER);
        user.setRole(User.Role.MEMBER); // legacy compatibility column
        user.setGuild(invitedGuild);
        user.setGuildRole(invitedGuild == null ? null : User.GuildRole.MEMBER);

        User savedUser = userRepository.save(user);
        String token = jwtService.generateToken(savedUser.getUsername(), savedUser.getPlatformRole().name());
        return toAuthResponse(savedUser, token);
    }

    @Transactional(readOnly = true)
    public AuthResponse login(LoginRequest request) {
        if (request == null || request.getUsername() == null || request.getPassword() == null) {
            throw new InvalidCredentialsException(INVALID_CREDENTIALS_MSG);
        }

        String username = request.getUsername().trim();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new InvalidCredentialsException(INVALID_CREDENTIALS_MSG));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new InvalidCredentialsException(INVALID_CREDENTIALS_MSG);
        }

        User.PlatformRole platformRole = UserMapper.resolvePlatformRole(user);
        String token = jwtService.generateToken(user.getUsername(), platformRole.name());
        return toAuthResponse(user, token);
    }

    private AuthResponse toAuthResponse(User user, String token) {
        User.PlatformRole platformRole = UserMapper.resolvePlatformRole(user);
        boolean hasGuild = user.getGuild() != null;

        return new AuthResponse(
                token,
                user.getUsername(),
                platformRole.name(),
                hasGuild ? user.getGuild().getName() : null,
                hasGuild ? user.getGuild().getId() : null,
                hasGuild && user.getGuildRole() != null ? user.getGuildRole().name() : null,
                hasGuild ? user.getGuild().getInviteCode() : null
        );
    }
}
