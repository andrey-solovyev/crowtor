package com.crowtor.backend.data.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TwittFeedDto {
    private Long id;
    private String textTwit;
    private boolean isPremium;
    private int amountLikes;
    private int amountDisLikes;
    private LocalDateTime created;
    private String nickName;
    private String firstName;
    private String lastName;
    private boolean isLike;
    private boolean isDislike;
    private List<TagDto> tags;

    public TwittFeedDto(Long id, String textTwit, boolean isPremium, int amountLikes, int amountDisLikes, LocalDateTime created, String nickName, String firstName, String lastName) {
        this.id = id;
        this.textTwit = textTwit;
        this.isPremium = isPremium;
        this.amountLikes = amountLikes;
        this.amountDisLikes = amountDisLikes;
        this.created = created;
        this.nickName = nickName;
        this.firstName = firstName;
        this.lastName = lastName;
    }
}
