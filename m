Return-Path: <linux-fsdevel+bounces-2335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B17E4DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2F8281446
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF6361;
	Wed,  8 Nov 2023 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwo8FdzT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE5182
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 00:03:34 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425310E4;
	Tue,  7 Nov 2023 16:03:34 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso4035424a34.0;
        Tue, 07 Nov 2023 16:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699401814; x=1700006614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5LBcj9Ai/IS8fLRfhiYfHqRvqJUefGN2W7PjES7Bxo=;
        b=hwo8FdzT4fVOd03VAgREecm9Kux3V4U6P1wcjfbjTjhumNpd4Cx6d8ZheUiFYnSUbd
         PgAMEuZrigCyvS+3Hgn26UDNS/pzbE6PPNzytqqBqemNQMCErcTPhZ/bLZB8bGIuqsfk
         yk2XqUc4cDkuw94/9t2+ordrNsPIkXZ0LECMAXX0hdSarKh+Vm08zh8xAGG9UwthTJ0Z
         IgVPoPzqQeDc60hzKRkIeLQgrcPcXMOPZfIJB0QuZRwVuRLmE/dLwNKtHTXYgWP10OC5
         kq4+mmJrefqhPE1ZzQ0yJ8z36KinOgmwM6A81fN7wmonDH8mA/kB590UGUZhEBlkxUJe
         7gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401814; x=1700006614;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5LBcj9Ai/IS8fLRfhiYfHqRvqJUefGN2W7PjES7Bxo=;
        b=IWpTHGj66Ic23F15hIuhcuLB1lStAq5DKkvFcImgoEe6h06cIMfRJL9auJDZDsB7dt
         lUXxtJsvoUYTtvk5n2prOEJw4VULG4xBWmdeRH8GoCm5vYGTg9TWsxAeIWk7QaQES3n6
         9zTplNHZKzh2LFnoBe7bWTr6+0UmdzXwHrCYg0+0ZdN/b1X6JEXXm7cNqZMYXhMLIHmV
         r8+C0hW40cTl5mhOJPFbuDzjHfoNlWRbJO0Hh9+S8R7+jwDJE8rJamxMIISoXuq5huez
         hK8VKAqV67/oWbET7+tOhef5HO5V4jDxiRcEq1jk6KobwjYQIwMjcJNTmNEudn+bXpS3
         /mVA==
X-Gm-Message-State: AOJu0YxhOGnamhrAAccQIqKrZwP48Gi709pYrhpMXJ07tm0A+tl9Wjjl
	qE8q7Y9mztAurIzOIGEe3PQEX8U2d2Gcn4Nq9mQAqyRW
X-Google-Smtp-Source: AGHT+IEqZhTaX29JcgF6ONXkh2J4MIBuyEqTF1/MoCB/3c+YA7OhLsdvXIckAeQ2wusUzs9RSqXWYxO0oNDet6dw0CE=
X-Received: by 2002:a05:6830:2b25:b0:6d3:1212:15ab with SMTP id
 l37-20020a0568302b2500b006d3121215abmr396732otv.20.1699401813768; Tue, 07 Nov
 2023 16:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:158f:0:b0:4f0:1250:dd51 with HTTP; Tue, 7 Nov 2023
 16:03:33 -0800 (PST)
In-Reply-To: <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook> <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 8 Nov 2023 01:03:33 +0100
Message-ID: <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Josh Triplett <josh@joshtriplett.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/8/23, Kees Cook <kees@kernel.org> wrote:
>
>
> On November 7, 2023 3:08:47 PM PST, Mateusz Guzik <mjguzik@gmail.com>
> wrote:
>>On 11/7/23, Kees Cook <keescook@chromium.org> wrote:
>>> On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
>>>> If the patch which dodges second lookup still somehow appears slower a
>>>> flamegraph or other profile would be nice. I can volunteer to take a
>>>> look at what's going on provided above measurements will be done and
>>>> show funkyness.
>>>
>>> When I looked at this last, it seemed like all the work done in
>>> do_filp_open() (my patch, which moved the lookup earlier) was heavier
>>> than the duplicate filename_lookup().
>>>
>>> What I didn't test was moving the sched_exec() before the mm creation,
>>> which Peter confirmed shouldn't be a problem, but I think that might be
>>> only a tiny benefit, if at all.
>>>
>>> If you can do some comparisons, that would be great; it always takes me
>>> a fair bit of time to get set up for flame graph generation, etc. :)
>>>
>>
>>So I spawned *one* process executing one statocally linked binary in a
>>loop, test case from http://apollo.backplane.com/DFlyMisc/doexec.c .
>>
>>The profile is definitely not what I expected:
>>   5.85%  [kernel]           [k] asm_exc_page_fault
>>   5.84%  [kernel]           [k] __pv_queued_spin_lock_slowpath
>>[snip]
>>
>>I'm going to have to recompile with lock profiling, meanwhile
>>according to bpftrace
>>(bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] =
>> count(); }')
>>top hits would be:
>>
>>@[
>>    __pv_queued_spin_lock_slowpath+1
>>    _raw_spin_lock+37
>>    __schedule+192
>>    schedule_idle+38
>>    do_idle+366
>>    cpu_startup_entry+38
>>    start_secondary+282
>>    secondary_startup_64_no_verify+381
>>]: 181
>>@[
>>    __pv_queued_spin_lock_slowpath+1
>>    _raw_spin_lock_irq+43
>>    wait_for_completion+141
>>    stop_one_cpu+127
>>    sched_exec+165
>
> There's the suspicious sched_exec() I was talking about! :)
>
> I think it needs to be moved, and perhaps _later_ instead of earlier?
> Hmm...
>

I'm getting around 3.4k execs/s. However, if I "taskset -c 3
./static-doexec 1" the number goes up to about 9.5k and lock
contention disappears from the profile. So off hand looks like the
task is walking around the box when it perhaps could be avoided -- it
is idle apart from running the test. Again this is going to require a
serious look instead of ad hoc pokes.

Side note I actually read your patch this time around instead of
skimming through it and assuming it did what I thought.

do_filp_open is of course very expensive and kmalloc + kfree are slow.
On top of it deallocating a file object even after a failed open was
very expensive due to delegation to task_work (recently fixed).

What I claim should be clear-cut faster is that lookup as in the
original patch and only messing with file allocation et al if it
succeeds.

-- 
Mateusz Guzik <mjguzik gmail.com>

