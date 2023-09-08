Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69A798498
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbjIHJLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjIHJLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:11:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6930F1997
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 02:11:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso19339135e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1694164268; x=1694769068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uucPgAlGBQZ8LNzLV0XU3oBxm9XKuhvV3ldf5KCnJas=;
        b=KFTrR103szWJEVVrwrOh3S5yIePmAzay2NB6PFt/uuy3m7O/JxRVNNdzZkzciTproH
         3v8xwblhNzTDV1uo0m4/p5wR9GMFix1uGRNY0tjAI8FXgLRMX7FbeSJSwo5TdUwofpft
         nvztFi9NemEqR16ZeE+wtHJdHE7ceZXDNxXcYtsL5OoFaddDJfbqBc0tSBCe9NW/71mY
         nVd4VORQIrH72GdWhuu1G4EG11p34BgmGDav8jPY2m2NMFcUOwU3BR+H5bPJNSITQstl
         j+b373W00j2OxP/ygsSj8XuTaes00BZsqS3aoyq9ZlZtVIdwpFqOAOkfv5rQqXwMo2DA
         qbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694164268; x=1694769068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uucPgAlGBQZ8LNzLV0XU3oBxm9XKuhvV3ldf5KCnJas=;
        b=AV1lX4Lxu30m3hbvzgcnAxo2GRQWhFUoEDUR99LwitvpIAh2JB5t9iFCQ73vvFA1tX
         bbM69QTrNFLoZb/EzZk6i2SHBgsstiISVzObldfEhC4807FIbz0hw8gyGm0I4dNc9oAc
         y06A1tlwbB+IyF5vwPpckSZqmDRnwd7wi7hElEzLOPe+hiEij+3v857UYcr2puO0tERe
         QEtT+JorESCofiZ70mH3/aDhY3XrjL5oVAW1tay4JWd7+NuHAwAuJ8cvWTNhlflDeB0m
         ff3gZl4dmT+K7ZVtRAwTUX6nF7nLOAlFcsft6V1LylRvMLXeTjC+n/7uP+vDye0yNTYO
         y6cw==
X-Gm-Message-State: AOJu0YyQ0hT6MNLbWrvHdq8c631pzMj+D3zaiS+CSlyLq+oCiCedh8ZF
        qoZWjss0xojFJyq5jncqdbU/Xw==
X-Google-Smtp-Source: AGHT+IHXFm0k3Ng9rEIihR13gx7EBn8TISG7UZBX/S9GUomLYkv0qz2Sp94jomnPytBSKb0AniVSKQ==
X-Received: by 2002:a7b:c01a:0:b0:3fb:d1db:545b with SMTP id c26-20020a7bc01a000000b003fbd1db545bmr1557599wmb.20.1694164267671;
        Fri, 08 Sep 2023 02:11:07 -0700 (PDT)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d6791000000b0031c5ce91ad6sm1535225wru.97.2023.09.08.02.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:11:07 -0700 (PDT)
Message-ID: <689a856d-4c4a-4d65-b4f2-a5b11e61d75b@froggi.es>
Date:   Fri, 8 Sep 2023 10:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <20230907234001.oe4uypp6anb5vqem@moria.home.lan>
Content-Language: en-US
From:   Joshua Ashton <joshua@froggi.es>
In-Reply-To: <20230907234001.oe4uypp6anb5vqem@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/23 00:40, Kent Overstreet wrote:
> On Wed, Sep 06, 2023 at 12:36:18PM -0700, Linus Torvalds wrote:
>> So I'm starting to look at this because I have most other pull
>> requests done, and while I realize there's no universal support for it
>> I suspect any further changes are better done in-tree. The out-of-tree
>> thing has been done.
>>
>> However, while I'll continue to look at it in this form, I just
>> realized that it's completely unacceptable for one very obvious
>> reason:
>>
>> On Sat, 2 Sept 2023 at 20:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>>
>>>    https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream
>>
>> No way am I pulling that without a signed tag and a pgp key with a
>> chain of trust. You've been around for long enough that having such a
>> key shouldn't be a problem for you, so make it happen.
>>
>> There are a few other issues that I have with this, and Christoph did
>> mention a big one: it's not been in linux-next. I don't know why I
>> thought it had been, it's just such an obvious thing for any new "I
>> want this merged upstream" tree.
>>
>> So these kinds of "I'll just ignore _all_ basic rules" kinds of issues
>> do annoy me.
>>
>> I need to know that you understand that if you actually want this
>> upstream, you need to work with upstream.
>>
>> That very much means *NOT* continuing this "I'll just do it my way".
>> You need to show that you can work with others, that you can work
>> within the framework of upstream, and that not every single thread you
>> get into becomes an argument.
>>
>> This, btw, is not negotiable.  If you feel uncomfortable with that
>> basic notion, you had better just continue doing development outside
>> the main kernel tree for another decade.
>>
>> The fact that I only now notice that you never submitted this to
>> linux-next is obviously on me. My bad.
>>
>> But at the same time it worries me that it might be a sign of you just
>> thinking that your way is special.
>>
>>                  Linus
> 
> Honestly, though, this process is getting entirely kafkaesque.
> 
> I've been spending the past month or two working laying the groundwork
> for putting together a team to work on this, because god knows we need
> fresh blood in filesystem land - but that's on hold. Getting blindsided
> by another three month delay hurts, but that's not even the main thing.
> 
> The biggest thing has just been the non stop hostility and accusations -
> everything from "fracturing the community" too "ignoring all the rules"
> and my favorite, "is this the hill Kent wants to die on?" - when I'm
> just trying to get work done.
> 
> I don't generally think of myself as being particularly difficult to
> work with, I get along fine with most of the filesystem developers I
> interact with - regularly sharing ideas back and forth with the XFS
> people - but these review discussions have been entirely dominated by
> the most divisive people in our community, and I'm being told it's
> entirely on me to work with the guy whos one constant in the past 15
> years has been to try and block everything I submit?
> 
> I'm just trying to get work done here. I'm not trying to ignore the
> rules. I'm trying to work with people who are willing to have reasonable
> discussions.
> 
> -------------------
> 
> When I was a teenager, I wanted nothing more than to be a Linux kernel
> programmer. I thought it utterly amazing that this huge group of people
> from around the world were working together over the internet, and that
> anyone could take part if they had the chops.
> 
> That was my escape from a shitty family situation and the assholes in my
> life.
> 
> But my life is different now; I have new and better people in my life,
> and I have to be thinking about them, and if merging bcachefs means I
> have to spend a lot more time in interactions like this then it's going
> to make me a shitty person to be around; and I don't want to do that to
> myself and I definitely don't want to do that to the people I care
> about.
> 
> I'm going to go offline for awhile and think about what I want to do
> next.

I've been holding off replying here for a while because I really hoped 
that this situation would just work itself out. (I apologise for adding 
more noise in advance)

I agree that it really sucks that sometimes you don't get replies to 
things sometimes or the review from the people you need it from all the 
time, or didn't tell you something you needed to know.

But, I think it's really important though to realize that you are 
talking to other people on the ML and not review machines (unless that 
person is Dave Airlie on Zink ;P) and very often, other work can come up 
that would block them being able to spend time reviewing or guiding you 
on this process.

Everyone on here is another person who has their own huuuge slog of work 
that is super important for security, stability, shipping a 
product/feature, keeping their job, etc.

Eg. I proposed several revisions on the casefolding support for 
bcachefs, but right now I am busy doing some other AMDGPU and 
Gamescope/Proton + color work so I haven't had a chance to follow up 
more on that since the last discussion.

You might think that because X takes a while to respond/review or a 
didn't mention that you actually needed to do Y or missed your meeting; 
it's because they don't care, but it's probably way more likely that 
they are just busy and going through their own personal hell.

One of the harsh things about open source is rationalizing that nobody 
owes you a review or any of their time. If people are willing to review 
your features and changes in any capacity, then they also have an 
interest in your project.

If you can understand that, then you are going to have a much better 
time proposing things upstream.

I also really want to see bcachefs in mainline, and I know you can do 
it. :-)

Cheers
- Joshie 🐸✨
