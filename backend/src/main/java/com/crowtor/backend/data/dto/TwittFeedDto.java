package com.crowtor.backend.data.dto;

import com.crowtor.backend.data.models.Comment;
import com.crowtor.backend.data.models.Tag;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

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
    private Set<Tag> tags;
    private Set<CommentFeedDto> commentSet;

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

    public TwittFeedDto(Long id, String textTwit, boolean isPremium, int amountLikes, int amountDisLikes, LocalDateTime created, String nickName, String firstName, String lastName, boolean isLike, boolean isDislike) {
        this.id = id;
        this.textTwit = textTwit;
        this.isPremium = isPremium;
        this.amountLikes = amountLikes;
        this.amountDisLikes = amountDisLikes;
        this.created = created;
        this.nickName = nickName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.isLike = isLike;
        this.isDislike = isDislike;
    }

}
