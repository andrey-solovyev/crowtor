package com.crowtor.backend.data.mappers.Impl;

import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.mappers.BaseObjectMapper;
import com.crowtor.backend.data.models.Twitt;
import org.springframework.stereotype.Component;

@Component
public class TwittToTwittFeedDtoObjectMapper extends BaseObjectMapper<Twitt, TwittFeedDto> {

    @Override
    public TwittFeedDto convert(Twitt obj) {
        var twittDto = new TwittFeedDto();
        twittDto.setTextTwit(obj.getTextTwit());
        twittDto.setId(obj.getId());
        twittDto.setCreated(obj.getCreated());
        twittDto.setPremium(obj.isPremium());
        twittDto.setFirstName(obj.getAuthor().getFirstName());
        twittDto.setLastName(obj.getAuthor().getLastName());
        twittDto.setNickName(obj.getAuthor().getNickName());
        twittDto.setAmountLikes(obj.getPersonLikes().size());
        twittDto.setAmountDisLikes(obj.getPersonDisLikes().size());
        return twittDto;
    }

    @Override
    public Class<Twitt> getInClass() {
        return Twitt.class;
    }

    @Override
    public Class<TwittFeedDto> getOutClass() {
        return TwittFeedDto.class;
    }
}
