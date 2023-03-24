Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F46C87BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCXVwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 17:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXVwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:52:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669A1E9C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 14:52:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x15so2654624pjk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679694730; x=1682286730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbVtUmnKCTzykcbhJ/O8jygDhhkOOUy4wDLBYjGN00s=;
        b=Olgawl+wwtJod7z8SJ3X+dfhZElbJNehOzRbG1K+PbvWWSukEvtJmOF+874H/VT6fD
         ywrJxBOmKrV4JRwV5FKhhKAB1OstZLfD/tbGuueH3EnnOkrvI66HyOhTcAXYDC7Csf3x
         74gGD7YERis7pJQw2iJUl1JlNYOj/fZBebiedi6M9HZLClXBVWT7IQFqISzpR4D3+xyh
         fM5KKyo9GwBUdqZv/EotwBA7Ys6hfUzTb/BvjhVbPMSr0yI92PZXHmVb/a8XImQ4vxSV
         xKzUwVAk7mb5Enu/wL5635d8Ja0TAxb9f8uZJKVidQuj/8QcD0kelhO4U/VgY/JEFP5y
         7tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679694730; x=1682286730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbVtUmnKCTzykcbhJ/O8jygDhhkOOUy4wDLBYjGN00s=;
        b=bZ8a2W6GmqYaRmD9n+SAcToot+FnUoIBWgAa/JQsVKexzPy0qok88b8/0qtfS+B6vX
         X4TIKe3wUduNC/SSP/9RreoLaEU4DCbP7QQ/+ng78N5tRUUSmMIraRv/pLH0q28x3YzW
         64/ER9YoZBz6gEKaP0aUN4D4Mtxu3gmxeSEHPiNrbryHuJ1nFcKUQUhm0jP6v9PCTMkx
         EXGPZNJ+4p4JHuVPtOXkw/8H7vnV1YkLOlTRtvPI+mmp9jdQPO7EG/lF3artA1xXcFV4
         MZCy0bTH7gWjdv56aoAHcFAeMnLnM4e7r8wuo7TDn6Mmqk3Cj07IX6ts+cqfMSqQN80F
         3CXw==
X-Gm-Message-State: AO0yUKWhSIA56K2OSz7ty29P3wUZh2o6gi3UjIKOa5n9QOKGZdUNzAi4
        KUSCHOvLPtCbdPQA5nSIMvIMcw==
X-Google-Smtp-Source: AK7set9jtBg/SciPuVcdZFWZLDuDVQh3mbSEl+6WtkQ4j0PUKSyEKi8VHRpJ0ECN3NetPiy57cQnRw==
X-Received: by 2002:a05:6a20:6914:b0:cc:bf13:7b1c with SMTP id q20-20020a056a20691400b000ccbf137b1cmr3047635pzj.0.1679694730257;
        Fri, 24 Mar 2023 14:52:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t19-20020a62ea13000000b005a8de0f4c64sm14268726pfh.82.2023.03.24.14.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 14:52:09 -0700 (PDT)
Message-ID: <45c46ee9-8479-4114-6ce9-ae3082335cb8@kernel.dk>
Date:   Fri, 24 Mar 2023 15:52:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230324204443.45950-1-axboe@kernel.dk>
 <CAHk-=wgjPAUwbQ9bf764x6xL8Ht56CGX79OLTG-fCS6u8yLaCA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgjPAUwbQ9bf764x6xL8Ht56CGX79OLTG-fCS6u8yLaCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/24/23 3:14?PM, Linus Torvalds wrote:
> On Fri, Mar 24, 2023 at 1:44?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
>> spots, as the latter is cheaper to iterate and hence saves some cycles.
>> I recently experimented [1] with io_uring converting single segment READV
>> and WRITEV into non-vectored variants, as we can save some cycles through
>> that as well.
>>
>> But there's really no reason why we can't just do this further down,
>> enabling it for everyone. It's quite common to use vectored reads or
>> writes even with a single segment, unfortunately, even for cases where
>> there's no specific reason to do so. From a bit of non-scientific
>> testing on a vm on my laptop, I see about 60% of the import_iovec()
>> calls being for a single segment.
> 
> I obviously think this is the RightThing(tm) to do, but it's probably
> too late for 6.3 since there is the worry that somebody "knows" that
> it's a IOVEC somewhere.
> 
> Even if it sounds unlikely, and wrong.

Agree, wasn't really targeting 6.3 though after looking over it, I do
feel better about the whole thing.

I already ran the io_uring test and it showed a nice win, wrote a small
micro benchmark that just does 10M 4k reads from /dev/zero. First
observation from the below numbers is that copying just a single vec is
EXPENSIVE. But I already knew that from the io_uring testing, where
we're spending ~8% just on that alone. Secondly, readv(..., 1) saves
about 3% with the patches in this series.

read-zero takes on argument, which is to do vectored reads or not.

Stock kernel:

axboe@r7525 ~> time taskset -c 0 ./read-zero 0
________________________________________________________
Executed in  859.98 millis    fish           external
   usr time  210.10 millis  291.00 micros  209.81 millis
   sys time  649.42 millis    0.00 micros  649.42 millis

axboe@r7525 ~> time taskset -c 0 ./read-zero 0
________________________________________________________
Executed in  853.82 millis    fish           external
   usr time  228.45 millis  304.00 micros  228.15 millis
   sys time  624.92 millis    0.00 micros  624.92 millis

axboe@r7525 ~> time taskset -c 0 ./read-zero 1
________________________________________________________
Executed in    1.84 secs    fish           external
   usr time    0.21 secs  218.00 micros    0.21 secs
   sys time    1.63 secs  101.00 micros    1.63 secs

axboe@r7525 ~> time taskset -c 0 ./read-zero 1
________________________________________________________
Executed in    1.83 secs    fish           external
   usr time    0.18 secs  594.00 micros    0.18 secs
   sys time    1.64 secs    0.00 micros    1.64 secs

And with the patches:

axboe@r7525 ~> time taskset -c 0 ./read-zero 1
________________________________________________________
Executed in    1.78 secs    fish           external
   usr time    0.22 secs  141.00 micros    0.22 secs
   sys time    1.56 secs  141.00 micros    1.56 secs

axboe@r7525 ~> time taskset -c 0 ./read-zero 1
________________________________________________________
Executed in    1.78 secs    fish           external
   usr time    0.19 secs    0.00 micros    0.19 secs
   sys time    1.59 secs  509.00 micros    1.59 secs

read-zero 0 the same with patches, as expected.

> Adding Al, who tends to be the main iovec person.
> 
> Al, see
> 
>    https://lore.kernel.org/all/20230324204443.45950-1-axboe@kernel.dk/
> 
> for the series if you didn't already see it on fsdevel.

Yep sorry, forgot to add Al.

-- 
Jens Axboe

