Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21B731C5A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 03:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBPCmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 21:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBPCmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 21:42:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9BEC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 18:41:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cv23so4805293pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 18:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2wfceIw/1agtFY1A1DOX2hqcAxOR5x5DYgiw6GM0xs=;
        b=LDmgpPpMgK1fq8jD65UBp5YmPRvv8iRvXj6SK5H/x/yscBqlEMMp/G9EPRcT5F7c4Y
         NPEV8hkBQJsATJo4PaD/vvF+hGzFg+d8+9U2ZswW2/094Nt5RLQ4ULqnCdhFVZ+HQOMF
         ceAtXxqC7lC5q/uKs0XRisNDV5QXGjVqjF8SOdnxMYKpX7kRGGIJtrICRPqp93N1wW7H
         aVNLA7BYi+J9f2B7QLzbvWK+K1vb/HJpNCIjWZfAAEVrxY2eNbUvTbXS1bPOQ6yJ0iqU
         ZE2FB/ME3vXbhSZyGg5leTTH098JTZeZxf6p6S7hP5b6ot+wl+8MwGwcl6whg6qb6G8L
         hWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2wfceIw/1agtFY1A1DOX2hqcAxOR5x5DYgiw6GM0xs=;
        b=VeGOUrEhOM/QfO+97Y4ruKoJXABDPBiF/iBQ6K/STW6Kzsum5PNC59wWpasLnEHtLP
         BU2NEMV4DHtuvX0K+oXRDrjq5agVThmAsZWGqylgMu75QEmgDVKgAZeAFf7D2HUJSGcZ
         PRzQpOyfqCoW5IAUqsGaJ8jqaSvi88g3ne67+rQ/jndnFMEYJZVjjUtIT4XS6Hn2Rl3X
         GXiPjYjpaRIXXysr3VhbehMFk6aM7L8Afc+Kb7CpjTIGe9OSBfuYufXc2nAWpyMdMs6V
         5SBOaN1331l6LaQ/lyE4aLzjePGWSn0mZ8TQ7XRKzLLMOQGIA9r3roM/+DkrMnzJeQoj
         o+HQ==
X-Gm-Message-State: AOAM531zRIwrvplWbyUUAEXrS1UYnE6Uil9pugchutbymSSbohvR0J24
        0RgYw30SKhhQgNHnDKW8FErpLm1bgedSDw==
X-Google-Smtp-Source: ABdhPJzkA1SSJaAdOT4iDtgIrhiZ21sZYmUv5PsCnzFmlVlyuTRoe5zTJy1pspAIeCVxXXbi6pKDWw==
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id e20-20020a170902ed94b02900de8844a650mr17872975plj.56.1613443302548;
        Mon, 15 Feb 2021 18:41:42 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s23sm19002030pgj.29.2021.02.15.18.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 18:41:42 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
 <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
 <m11rdhurvp.fsf@fess.ebiederm.org>
 <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
 <e3335211-83f2-5305-9601-663cc2a73427@kernel.dk>
 <m1r1lht0lo.fsf@fess.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b642d3-6a38-af68-b99d-44efcf0b13a5@kernel.dk>
Date:   Mon, 15 Feb 2021 19:41:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m1r1lht0lo.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/21 3:41 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 2/15/21 11:24 AM, Jens Axboe wrote:
>>> On 2/15/21 11:07 AM, Eric W. Biederman wrote:
>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>>
>>>>> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>>> Similarly it looks like opening of "/dev/tty" fails to
>>>>>>> return the tty of the caller but instead fails because
>>>>>>> io-wq threads don't have a tty.
>>>>>>
>>>>>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>>>>>> thread if not explicitly inherited, and I'm working on similarly
>>>>>> proactively catching these cases that could potentially be problematic.
>>>>>
>>>>> Well, the /dev/tty case still needs fixing somehow.
>>>>>
>>>>> Opening /dev/tty actually depends on current->signal, and if it is
>>>>> NULL it will fall back on the first VT console instead (I think).
>>>>>
>>>>> I wonder if it should do the same thing /proc/self does..
>>>>
>>>> Would there be any downside of making the io-wq kernel threads be per
>>>> process instead of per user?
>>>>
>>>> I can see a lower probability of a thread already existing.  Are there
>>>> other downsides I am missing?
>>>>
>>>> The upside would be that all of the issues of have we copied enough
>>>> should go away, as the io-wq thread would then behave like another user
>>>> space thread.  To handle posix setresuid() and friends it looks like
>>>> current_cred would need to be copied but I can't think of anything else.
>>>
>>> I really like that idea. Do we currently have a way of creating a thread
>>> internally, akin to what would happen if the same task did pthread_create?
>>> That'd ensure that we have everything we need, without actively needing to
>>> map the request types, or find future issues of "we also need this bit".
>>> It'd work fine for the 'need new worker' case too, if one goes to sleep.
>>> We'd just 'fork' off that child.
>>>
>>> Would require some restructuring of io-wq, but at the end of it, it'd
>>> be a simpler solution.
>>
>> I was intrigued enough that I tried to wire this up. If we can pull this
>> off, then it would take a great weight off my shoulders as there would
>> be no more worries on identity.
>>
>> Here's a branch that's got a set of patches that actually work, though
>> it's a bit of a hack in spots. Notes:
>>
>> - Forked worker initially crashed, since it's an actual user thread and
>>   bombed on deref of kernel structures. Expectedly. That's what the
>>   horrible kernel_clone_args->io_wq hack is working around for now.
>>   Obviously not the final solution, but helped move things along so
>>   I could actually test this.
>>
>> - Shared io-wq helpers need indexing for task, right now this isn't
>>   done. But that's not hard to do.
>>
>> - Idle thread reaping isn't done yet, so they persist until the
>>   context goes away.
>>
>> - task_work fallback needs a bit of love. Currently we fallback to
>>   the io-wq manager thread for handling that, but a) manager is gone,
>>   and b) the new workers are now threads and go away as well when
>>   the original task goes away. None of the three fallback sites need
>>   task context, so likely solution here is just punt it to system_wq.
>>   Not the hot path, obviously, we're exiting.
>>
>> - Personality registration is broken, it's just Good Enough to compile.
>>
>> Probably a few more items that escape me right now. As long as you
>> don't hit the fallback cases, it appears to work fine for me. And
>> the diffstat is pretty good to:
>>
>>  fs/io-wq.c                 | 418 +++++++++++--------------------------
>>  fs/io-wq.h                 |  10 +-
>>  fs/io_uring.c              | 314 +++-------------------------
>>  fs/proc/self.c             |   7 -
>>  fs/proc/thread_self.c      |   7 -
>>  include/linux/io_uring.h   |  19 --
>>  include/linux/sched.h      |   3 +
>>  include/linux/sched/task.h |   1 +
>>  kernel/fork.c              |   2 +
>>  9 files changed, 161 insertions(+), 620 deletions(-)
>>
>> as it gets rid of _all_ the 'grab this or that piece' that we're
>> tracking.
>>
>> WIP series here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-worker
> 
> I took a quick look through the code and in general it seems reasonable.

Great, thanks for checking.

> Can the io_uring_task_cancel in begin_new_exec go away as well?
> Today it happens after de_thread and so presumably all of the io_uring
> threads are already gone.

I don't think so, async offload is only the slower path of async. We
can have poll based waiting, and various others. If we want to guarantee
that no requests escape across exec, then we'll need to retain that.

-- 
Jens Axboe

