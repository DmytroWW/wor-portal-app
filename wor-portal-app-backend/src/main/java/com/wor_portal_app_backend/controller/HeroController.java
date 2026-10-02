package com.wor_portal_app_backend.controller;


import com.wor_portal_app_backend.service.HeroService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/heroes")
@RequiredArgsConstructor
public class HeroController {

    private final HeroService heroService;

    @GetMapping
    public List getAllHeroes() {
        return heroService.getAllHeroes();
    }

    @GetMapping("/class/{className}")
    public List getHeroesByClass(@PathVariable String className) {
        return heroService.findByClassName(className);
    }



}
