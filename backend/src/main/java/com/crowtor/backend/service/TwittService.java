package com.crowtor.backend.service;

import com.crowtor.backend.data.repository.TwittRepository;
import org.springframework.beans.factory.annotation.Autowired;

public class TwittService {
    @Autowired
    private TwittRepository twittRepository;
}
