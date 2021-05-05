package com.crowtor.backend.data.dto;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class TwittFeedDto {
    private Long id;
    private String textTwit;
    private boolean isPremium;
    private int amountLikes;
    private int amountDisLikes;
    private LocalDateTime created;
    private String nickName;

    public TwittFeedDto(Long id, String textTwit, boolean isPremium, int amountLikes, int amountDisLikes, LocalDateTime created, String nickName) {
        this.id = id;
        this.textTwit = textTwit;
        this.isPremium = isPremium;
        this.amountLikes = amountLikes;
        this.amountDisLikes = amountDisLikes;
        this.created = created;
        this.nickName = nickName;
    }
}
