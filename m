Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17A6ED6BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjDXVWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDXVWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:22:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F936184
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:22:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6b17d6387so9896105ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682371326; x=1684963326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaNbkmhUQMoQImfoHxAMMvKYtfNulMFhxkCpZAaaktY=;
        b=gekBem1SqlFQgf/oS1H6X7CxcZ9L/x4NIAaeWUTWCg3fTJj6YEvrDDssdYkC4yt76T
         8VO2kEp/JcC1+fekZGTrutKAuzBAiCsuTOhUqO5/2pllF9y2qqcS6V3m5NJ8k1pKQkFB
         tchHzyLv1TTID7/BsCim4BbEDp6UHNRhz7oT80grOOf/k3bR7Ycj1qQYUNT6H9qCexrd
         3tdJj61sriHesIp+q+L25PMrTYGSvbCk5dbuoux+y0EpmrCQCkQDr7qgD7Uk7cTvFc9N
         lck/NeGUxTsf5YhwJ2CLntCnjOxeR+6aVHFrKqDv50DtlRAFdAzC+IdVyl7Q18vYWibZ
         5oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682371326; x=1684963326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaNbkmhUQMoQImfoHxAMMvKYtfNulMFhxkCpZAaaktY=;
        b=D58yeJjoOZxbR8ghHlV1mA+zVedGa5JYqUeUv82bfVHkZKQLP5nSxLXPcN92Ia0c4m
         1xS6hDb/n/U0rusjCM5P6mgWak0uv8YQpDpi6ctI9snoPkgNRRslwYqPBBOUU3WZSmzh
         2Vq+1Tk9LFhYxwWHqCW8jzSvGG80kG0bkNQr4Sz8EM3Xp+paXLXcx59o9gkLTphsJOue
         1v3Pb3CYvd/HnG6RhrH7jT0R6rPBr5/fAjLb/a8jv66bn7KaN3CaPIBvqbyjmkSN0Eur
         kdI8l/iNM+FpUzq6whaZL/WL2bGObVLmBVOUlj7jCtgKnC7Wd4HeTCuXxChRobDn6q0/
         Qv6w==
X-Gm-Message-State: AAQBX9dcD2jVQohXsP2Af9yLBXivD0ZTx55jbmt+tBO1nuSY+K9Qykfm
        729uszG8rY7g881SWxJw48zNpQ==
X-Google-Smtp-Source: AKy350YvRrIsirwUd7BecmdhAKouFQplvthKDpSS+N+d/jSTLRDgrGymw5AtMYAVQDjuFMVZOM4k8A==
X-Received: by 2002:a17:90a:1d3:b0:245:eb4c:3df8 with SMTP id 19-20020a17090a01d300b00245eb4c3df8mr13573475pjd.2.1682371326408;
        Mon, 24 Apr 2023 14:22:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ad10600b00244938da9b9sm486446pju.31.2023.04.24.14.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:22:06 -0700 (PDT)
Message-ID: <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
Date:   Mon, 24 Apr 2023 15:22:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 3:05?PM, Linus Torvalds wrote:
> On Fri, Apr 21, 2023 at 7:02?AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> This contains Jens' work to support FMODE_NOWAIT and thus IOCB_NOWAIT
>> for pipes ensuring that all places can deal with non-blocking requests.
>>
>> To this end, pass down the information that this is a nonblocking
>> request so that pipe locking, allocation, and buffer checking correctly
>> deal with those.
> 
> Ok, I pulled this, but then I unpulled it again.
> 
> Doing conditional locking for O_NONBLOCK and friends is not ok. Yes,
> it's been done, and I may even have let some slip through, but it's
> just WRONG.
> 
> There is absolutely no situation where a "ok, so the lock on this data
> structure was taken, we'll go to some async model" is worth it.
> 
> Every single time I've seen this, it's been some developer who thinks
> that O_NONBLOCk is somehow some absolute "this cannot schedule" thing.
> And every single time it's been broken and horrid crap that just made
> everything more complicated and slowed things down.
> 
> If some lock wait is a real problem, then the lock needs to be just
> fixed. Not "ok, let's make a non-blocking version and fall back if
> it's held".
> 
> Note that FMODE_NOWAIT does not mean (and *CANNOT* mean) that you'd
> somehow be able to do the IO in some atomic context anyway. Many of
> our kernel locks don't even support that (eg mutexes).
> 
> So thinking that FMODE_NOWAIT is that kind of absolute is the wrong
> kind of thinking entirely.
> 
> FMODE_NOWAIT should mean that no *IO* gets done. And yes, that might
> mean that allocations fail too. But not this kind of "let's turn
> locking into 'trylock' stuff".
> 
> The whoe flag is misnamed. It should have been FMODE_NOIO, the same
> way we have IOCB_NOIO.
> 
> If you want FMODE_ATOMIC, then that is something entirely and
> completely different, and is probably crazy.
> 
> We have done it in one area (RCU pathname lookup), and it was worth it
> there, and it was a *huge* undertaking. It was worth it, but it was
> worth it because it was a serious thing with some serious design and a
> critical area.
> 
> Not this kind of "conditional trylock" garbage which just means that
> people will require 'poll()' to now add the lock to the waitqueue, or
> make all callers go into some "let's use a different thread instead"
> logic.

I'm fully agreeing with you on the semantics for
FMODE_NOWAIT/IOCB_NOWAIT, and also agree that they are misnamed and
really should be _NOIO. There is no conceptual misunderstanding there,
nor do I care about atomic semantics. Obviously the above is for
io_uring to be able to improve the performance on pipes, because right
now everything is punted to io-wq and that severly hampers performance
with how pipes are generally used. io_uring doesn't care about atomic
context, but it very much cares about NOT sleeping for IO during issue
as that has adverse performance implications.

If we don't ever wait for IO with the pipe lock held, then we can skip
the conditional locking. But with splice, that's not at all the case! We
most certainly wait for IO there with the pipe lock held.

And yes I totally agree that conditional locking is not pretty, but for
some cases it really is a necessary evil. People have complained about
io_uring pipe performance, and I ran some testing myself. Being able to
sanely read/write from/to pipes without punting to io-wq is an easy 10x
improvement for that use case. How can I enable FMODE_NOWAIT on pipes if
we have splice holding the pipe lock over IO? It's not feasible.

So please reconsider, doing IO to/from pipes efficiently is actually
kind of useful for io_uring...

-- 
Jens Axboe

