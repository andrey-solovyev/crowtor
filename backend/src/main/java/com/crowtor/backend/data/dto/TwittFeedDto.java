package com.crowtor.backend.data.dto;

import java.time.LocalDateTime;

public class TwittFeedDto {
    private Long id;
    private String textTwit;
    private boolean isPremium;
    private int amountLikes;
    private LocalDateTime created;
}
