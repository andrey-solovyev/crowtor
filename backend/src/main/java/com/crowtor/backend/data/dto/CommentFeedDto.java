package com.crowtor.backend.data.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentFeedDto {
    private long id;
    private String textComment;
    private String nickname;
}
