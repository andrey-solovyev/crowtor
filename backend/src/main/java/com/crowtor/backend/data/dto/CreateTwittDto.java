package com.crowtor.backend.data.dto;

import com.crowtor.backend.data.models.Tag;
import lombok.Data;

import java.util.Set;

@Data
public class CreateTwittDto {
    private String textTwit;
    private boolean isPremium;
    private Set<String> tagSet;
}
