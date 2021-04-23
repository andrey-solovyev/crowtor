package com.crowtor.backend.service;

import com.crowtor.backend.data.repository.TwitRepository;
import org.springframework.beans.factory.annotation.Autowired;

public class TwitService {
    @Autowired
    private TwitRepository twitRepository;
}
