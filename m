Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8593B101E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFVWfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFVWfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:35:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58346C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 15:33:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h3so747352ilc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wnmRkYKboAH8zJCZrdHT+Gn/DKgpUQ6lVnKyPQDk2e0=;
        b=AR49a0Vnv4dm3JSBho21CVzLTpAw6AKYpkMLlF0NkD583G7YZ5+wtgml5dypSZYMud
         2hfVQyG1d5bTuI2+7TuzCftNECNvg3nMDkkcS0jnB8f2TmWBOjU2CGLh4fNOy9Ya+Pg/
         2GtHu1wBydy6jnwS6C8nQCjyYL+cINkYFKqTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wnmRkYKboAH8zJCZrdHT+Gn/DKgpUQ6lVnKyPQDk2e0=;
        b=GG2EHyFusqRwE6lfNl2gQ7o/gmSp4QVRxwamLnP2qCPanJmZrAov0MXf5tJzVaQF84
         Mo1f5P8hvYUfDZ5NlfdgvW5u36DU3UxBi3sBktSpBoqt/XIChmyWscACbFf2hwCk67Aj
         jxcflN5qUq6ExduLeZVQWPld2rLYRxTBVjL5OCEo9WErEjiJzuI3KzX0s91qSKEfyfbh
         E5OoSDuHDrr1oTL9ZVnEscxrCu1K/9EV3orY2r9PDXieaVab7zNJYVF6ybgsyxqhd60c
         fazxPXYcihK3+KYV6EtuWnF0WxAkcJj/dL8TBlPxoGspoGc8x1kS4BqjFqJDaqoi2hwA
         Ps4Q==
X-Gm-Message-State: AOAM530w/3GSDUCmH/z5Hm95Sv01rPUEsXBL6mPv+g8LpYkkQQCwncJI
        LGxOWqRo7oJFXW+8gV4sZLZJ/g==
X-Google-Smtp-Source: ABdhPJxN9TU0oJIL6ix/vNDlgeb3nGygOZZkb/SbcRaq0bOTovZyipADlOgJDT4QhLMrlnkFt38wbw==
X-Received: by 2002:a92:1310:: with SMTP id 16mr672327ilt.60.1624401203750;
        Tue, 22 Jun 2021 15:33:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j12sm8587753ilk.26.2021.06.22.15.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 15:33:23 -0700 (PDT)
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        David Hildenbrand <david@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <b32c8672-06ee-bf68-7963-10aeabc0596c@redhat.com>
 <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
 <20210610182318.jrxe3avfhkqq7xqn@nitro.local>
 <YMJcdbRaQYAgI9ER@pendragon.ideasonboard.com>
 <20210610152633.7e4a7304@oasis.local.home>
 <37e8d1a5-7c32-8e77-bb05-f851c87a1004@linuxfoundation.org>
 <YMyjryXiAfKgS6BY@pendragon.ideasonboard.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae51f636-8fb5-20b7-bbc5-37e22edb9a02@linuxfoundation.org>
Date:   Tue, 22 Jun 2021 16:33:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMyjryXiAfKgS6BY@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/21 7:46 AM, Laurent Pinchart wrote:
> Hi Shuah,
> 
> On Thu, Jun 10, 2021 at 01:55:23PM -0600, Shuah Khan wrote:
>> On 6/10/21 1:26 PM, Steven Rostedt wrote:
>>> On Thu, 10 Jun 2021 21:39:49 +0300 Laurent Pinchart wrote:
>>>
>>>> There will always be more informal discussions between on-site
>>>> participants. After all, this is one of the benefits of conferences, by
>>>> being all together we can easily organize ad-hoc discussions. This is
>>>> traditionally done by finding a not too noisy corner in the conference
>>>> center, would it be useful to have more break-out rooms with A/V
>>>> equipment than usual ?
>>>
>>> I've been giving this quite some thought too, and I've come to the
>>> understanding (and sure I can be wrong, but I don't think that I am),
>>> is that when doing a hybrid event, the remote people will always be
>>> "second class citizens" with respect to the communication that is going
>>> on. Saying that we can make it the same is not going to happen unless
>>> you start restricting what people can do that are present, and that
>>> will just destroy the conference IMO.
>>>
>>> That said, I think we should add more to make the communication better
>>> for those that are not present. Maybe an idea is to have break outs
>>> followed by the presentation and evening events that include remote
>>> attendees to discuss with those that are there about what they might
>>> have missed. Have incentives at these break outs (free stacks and
>>> beer?) to encourage the live attendees to attend and have a discussion
>>> with the remote attendees.
>>>
>>> The presentations would have remote access, where remote attendees can
>>> at the very least write in some chat their questions or comments. If
>>> video and connectivity is good enough, perhaps have a screen where they
>>> can show up and talk, but that may have logistical limitations.
>>>
>>
>> You are absolutely right that the remote people will have a hard time
>> participating and keeping up with in-person participants. I have a
>> couple of ideas on how we might be able to improve remote experience
>> without restricting in-person experience.
>>
>> - Have one or two moderators per session to watch chat and Q&A to enable
>>     remote participants to chime in and participate.
>> - Moderators can make sure remote participation doesn't go unnoticed and
>>     enable taking turns for remote vs. people participating in person.
>>
>> It will be change in the way we interact in all in-person sessions for
>> sure, however it might enhance the experience for remote attendees.
> 
> A moderator to watch online chat and relay questions is I believe very
> good for presentations, it's hard for a presenter to keep an eye on a
> screen while having to manage the interaction with the audience in the
> room (there's the usual joke of the difference between an introvert and
> an extrovert open-source developer is that the extrovert looks at *your*
> shoes when talking to you, but in many presentations the speaker
> nowadays does a fairly good job as watching the audience, at least from
> time to time :-)).
> 
> For workshop or brainstorming types of sessions, the highest barrier to
> participation for remote attendees is local attendees not speaking in
> microphones. That's the number one rule that moderators would need to
> enforce, I think all the rest depends on it. This may require a larger
> number of microphones in the room than usual.
> 

Absolutely. Moderator has to make sure the following things happen for
this to be effective:

- Watch chat and Q&A, Raise hand from remote participants
- Enforce some kind of taking turns to allow fairness in
   participation
- Have the speaker repeat questions asked in the room (we do that now
   in some talks - both remote and in-person - chat and Q&A needs
   reading out for recording)
- Explore live Transcription features available in the virtual conf.
   platform. You still need humans watching the transcription.
- Have a running session notes combined with transcription.

Any of these options aren't sustainable when large number of people
are participating remotely or in-person. In general a small number of
people participate either in person or remote in any case, based on
my observation in remote and in-person settings.

Maybe we can experiment with one or two workshops this time around
and see how it works out. If we can figure an effective way, it would
be beneficial for people that can't travel for one reason or the
other.

thanks,
-- Shuah





