Return-Path: <linux-fsdevel+bounces-2504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0657E6A74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902271C209DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41E1DA3A;
	Thu,  9 Nov 2023 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh9+RiTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB328F2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 12:21:06 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CF2702;
	Thu,  9 Nov 2023 04:21:05 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5849fc56c62so430384eaf.3;
        Thu, 09 Nov 2023 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699532465; x=1700137265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf06u8ZRup48FiodSvGNoaJfH2Amt2aPrTV0aUl6vho=;
        b=bh9+RiTbrzxgHshpCGlnT/nMw3MWTOAeiew0g/iCh381q+PV7R6USTyEBvK+RED17U
         4qHNCL2eKZ3z8mZ+1yXF3p2ENJHVq1ciMfECrJvXeicCNtQgm/BrH72cyCX/DMMwHsfz
         51QfPCcTXwOL1HyNTZnOCtVOpo47x8Kn794t/5MMpx52Nfm1XKRoy1dUp45FtPpdSC8t
         A6xSDmjlyy1UAmQWEXgbXHFBqrNLu3OZP+1x2DBl/DzIiWcmMATLtt1D2A74gYDKZ8vU
         L7WyDksCm7oM8W9fuXNVRoEeAMJadleOgaz+syOjzMv3boVO1JlRQ3sH7TwbH62b7K1F
         tB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532465; x=1700137265;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cf06u8ZRup48FiodSvGNoaJfH2Amt2aPrTV0aUl6vho=;
        b=A4hYRF8XMFIxUtYZZ8sG2yAkecPm/ccbOtTiGMdfXsdqWGN5tzKukeEAh3lLVH05Ip
         c1y7cUFyFVZrL6hTLXD5ktCiofTM+OadDr30klm1BCdjn0v5n3+L+CE/tDJUDHtCE5xC
         orNHPYBRdpg6RG+zVrZxH93BGuLMwfzmzMdZweEwLJPuh/+tWnoOgVvdGEd+vMNRQmj8
         Lg7ZrqKJNyXttK6mVqnEC3UOQGT/LC4T8dvhHxn3tUZ5G3ATeOVl82vuKL7aP2AZqDrS
         uuXRw8PEu4CvMCIh+qy5jKkmiPbr8KCT6AsIK59H2ychkSxLU7VJjAQCibSKSUD0H4+T
         oU+A==
X-Gm-Message-State: AOJu0YwDRxfAiZi4mBoV7VyObQpqly5j9gXv+o0a7FR1kES3Lzy32z7m
	ZsPGJBzStNCcx25EwIThUzywe+diV7LLpkj8DBw=
X-Google-Smtp-Source: AGHT+IHSCIfAvxAsoOhCmuC/wS5IjQ8yNasMvbesR4csTwSDuItjtE1BiSf3ph5q+6Ne9SxAA+PV13TTUBc5f1h52dg=
X-Received: by 2002:a4a:d35a:0:b0:581:ec87:edc0 with SMTP id
 d26-20020a4ad35a000000b00581ec87edc0mr4683338oos.9.1699532464870; Thu, 09 Nov
 2023 04:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6696:0:b0:4f0:1250:dd51 with HTTP; Thu, 9 Nov 2023
 04:21:04 -0800 (PST)
In-Reply-To: <87msvnwzim.fsf@email.froward.int.ebiederm.org>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook> <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org> <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
 <202311081129.9E1EC8D34@keescook> <CAGudoHEqv=JmMyV8vYSvhubxXaW-cK3n5WRR=nR7eDZjBOQTcw@mail.gmail.com>
 <87msvnwzim.fsf@email.froward.int.ebiederm.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 9 Nov 2023 13:21:04 +0100
Message-ID: <CAGudoHHb8Fh5UxgMa-hw3Kj=wjMqpdZq2J6869fBgsKXcZOeHA@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
To: "Eric W. Biederman" <ebiederm@xmission.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/9/23, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Mateusz Guzik <mjguzik@gmail.com> writes:
>> sched_exec causes migration only for only few % of execs in the bench,
>> but when it does happen there is tons of overhead elsewhere.
>>
>> I expect real programs which get past execve will be prone to
>> migrating anyway, regardless of what sched_exec is doing.
>>
>> That is to say, while sched_exec buggering off here would be nice, I
>> think for real-world wins the thing to investigate is the overhead
>> which comes from migration to begin with.
>
> I have a vague memory that the idea is that there is a point during exec
> when it should be much less expensive than normal to allow migration
> between cpus because all of the old state has gone away.
>
> Assuming that is the rationale, if we are getting lock contention
> then either there is a global lock in there, or there is the potential
> to pick a less expensive location within exec.
>

Given the commit below I think the term "migration cost" is overloaded here.

By migration cost in my previous mail I meant the immediate cost
(stop_one_cpu and so on), but also the aftermath -- for example tlb
flushes on another CPU when tearing down your now-defunct mm after you
switched.

For testing purposes I verified commenting out sched_exec and not
using taskset still gives me about 9.5k ops/s.

I 100% agree should the task be moved between NUMA domains, it makes
sense to do it when it has the smallest footprint. I don't know what
the original patch did, the current code just picks a CPU and migrates
to it, regardless of NUMA considerations. I will note that the goal
would still be achieved by comparing domains and doing nothing if they
match.

I think this would be nice to fix, but it is definitely not a big
deal. I guess the question is to Peter Zijlstra if this sounds
reasonable.

> Just to confirm my memory I dug a little deeper and I found the original
> commit that added sched_exec (in tglx's git tree of the bit keeper
> history).
>
> commit f01419fd6d4e5b32fef19d206bc3550cc04567a9
> Author: Martin J. Bligh <mbligh@aracnet.com>
> Date:   Wed Jan 15 19:46:10 2003 -0800
>
>     [PATCH] (2/3) Initial load balancing
>
>     Patch from Michael Hohnbaum
>
>     This adds a hook, sched_balance_exec(), to the exec code, to make it
>     place the exec'ed task on the least loaded queue. We have less state
>     to move at exec time than fork time, so this is the cheapest point
>     to cross-node migrate. Experience in Dynix/PTX and testing on Linux
>     has confirmed that this is the cheapest time to move tasks between
> nodes.
>
>     It also macro-wraps changes to nr_running, to allow us to keep track of
>     per-node nr_running as well. Again, no impact on non-NUMA machines.
>
>
> Eric
>
>


-- 
Mateusz Guzik <mjguzik gmail.com>

