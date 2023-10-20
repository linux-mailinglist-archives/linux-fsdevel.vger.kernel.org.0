Return-Path: <linux-fsdevel+bounces-847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FD7D1521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F071C20D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40F2033B;
	Fri, 20 Oct 2023 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3jkDQgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768C1DA22
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 17:49:23 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FAA3;
	Fri, 20 Oct 2023 10:49:20 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457cc01b805so451352137.0;
        Fri, 20 Oct 2023 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824159; x=1698428959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tCrUKrBe4ohlQTB10c53pGU4/58DcFanqEbH8HpfhOw=;
        b=k3jkDQgyOOEGBLncynGx1oKHmRKfTL4IH/3SEE7/IRLCteJhKqo2xAu8NyM/8bPZ3g
         L1i7MQvGBisWUe4antxtLa/TxuupknQxsOxJsXsHqSOuVKq6pjKZt5GmssTbiIy8riWH
         m+mMpoLF8X4C4YKC+XRPEhb+HJpqag3gAFO0JBasZtQklz9g1ogh3hc2MC4+dHJDP3SZ
         Q49gk0wu064j40aG4ow+qiIRahiYEYrRBVNVLy1z9UiHak2z1YBQ45OEhjUZdxZ50tup
         FAYVmHAbShFqrmHV0ZHyju/viLB3wVkfHvmJviIo8TAPE0RyqVCefWY5OpHA6Yyaz+Y1
         WuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824159; x=1698428959;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCrUKrBe4ohlQTB10c53pGU4/58DcFanqEbH8HpfhOw=;
        b=LyRA2qkUkpi9WNrXhfxhqZT2YQ0tKj/633EFvN1eMpWwrWmu4OtQl3cRbE+KDZeaCq
         loWElDgHszvFN24HlJn4DbnotGLthVUmgk70LJxUnD8GtYZTnIpJIO4A/JGJcbdyIBFv
         RCAvEyuy0Mgun6i0fAC/B0alOHQiXN9e8npr8rYEuLNrn1gWwhKgnH0vu5VKvxwHZkvL
         nw+3nRJwS2vRSxa24rkfOUGHk2bOmUYOctOVii0cxMG+0sfAY6N6GF1OHtkg1UsDe77r
         AB8CPRZAtl4w80W8DbpHXSEUk3rYuTePcxAFiqgWnRJ3f0YJwnDm0vl91/Ef3Awi6FrP
         Okzg==
X-Gm-Message-State: AOJu0YyCWLpe31K15ndd1DEAZ+SWnUZ9S+9qzihhfjVdXn/kSFEsIsS5
	3/Z8akraBwRLQw7FZTKWG2lxSDURkHzXc9UL94E=
X-Google-Smtp-Source: AGHT+IG+YDJbUucLWpHMjGyz7FRf13DQj6hv3iEc+6Dur5YraL4KHTm4SjlD+Wrbjjp7foJIXDIbYD6FYpflaH7FUx8=
X-Received: by 2002:a67:cb9b:0:b0:44e:8ae0:3df with SMTP id
 h27-20020a67cb9b000000b0044e8ae003dfmr2333417vsl.3.1697824159203; Fri, 20 Oct
 2023 10:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:3153:0:b0:783:def9:1a3a with HTTP; Fri, 20 Oct 2023
 10:49:18 -0700 (PDT)
In-Reply-To: <ZTJmnsAxGDnks2aj@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev> <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f> <20231019155958.7ek7oyljs6y44ah7@f> <ZTJmnsAxGDnks2aj@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 20 Oct 2023 19:49:18 +0200
Message-ID: <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Dave Chinner <dchinner@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On 10/20/23, Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Oct 19, 2023 at 05:59:58PM +0200, Mateusz Guzik wrote:
>> On Thu, Oct 19, 2023 at 05:30:40PM +0200, Mateusz Guzik wrote:
>> > On Tue, May 23, 2023 at 11:28:38AM +0200, Christian Brauner wrote:
>> > > On Tue, 09 May 2023 12:56:47 -0400, Kent Overstreet wrote:
>> > > > Because scalability of the global inode_hash_lock really, really
>> > > > sucks.
>> > > >
>> > > > 32-way concurrent create on a couple of different filesystems
>> > > > before:
>> > > >
>> > > > -   52.13%     0.04%  [kernel]            [k] ext4_create
>> > > >    - 52.09% ext4_create
>> > > >       - 41.03% __ext4_new_inode
>> > > >          - 29.92% insert_inode_locked
>> > > >             - 25.35% _raw_spin_lock
>> > > >                - do_raw_spin_lock
>> > > >                   - 24.97% __pv_queued_spin_lock_slowpath
>> > > >
>> > > > [...]
>> > >
>> > > This is interesting completely independent of bcachefs so we should
>> > > give
>> > > it some testing.
>> > >
>> > > I updated a few places that had outdated comments.
>> > >
>> > > ---
>> > >
>> > > Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git
>> > > tree.
>> > > Patches in the vfs.unstable.inode-hash branch should appear in
>> > > linux-next soon.
>> > >
>> > > Please report any outstanding bugs that were missed during review in
>> > > a
>> > > new review to the original patch series allowing us to drop it.
>> > >
>> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
>> > > patch has now been applied. If possible patch trailers will be
>> > > updated.
>> > >
>> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>> > > branch: vfs.unstable.inode-hash
>> > >
>> > > [22/32] vfs: inode cache conversion to hash-bl
>> > >         https://git.kernel.org/vfs/vfs/c/e3e92d47e6b1
>> >
>> > What, if anything, is blocking this? It is over 5 months now, I don't
>> > see it in master nor -next.
>
> Not having a test machine that can validate my current vfs-scale
> patchset for 4 of the 5 months makes it hard to measure and
> demonstrate the efficacy of the changes on a current kernel....
>

Ok, see below.

>> > To be clear there is no urgency as far as I'm concerned, but I did run
>> > into something which is primarily bottlenecked by inode hash lock and
>> > looks like the above should sort it out.
>> >
>> > Looks like the patch was simply forgotten.
>> >
>> > tl;dr can this land in -next please
>>
>> In case you can't be arsed, here is something funny which may convince
>> you to expedite. ;)
>>
>> I did some benching by running 20 processes in parallel, each doing stat
>> on a tree of 1 million files (one tree per proc, 1000 dirs x 1000 files,
>> so 20 mln inodes in total).  Box had 24 cores and 24G RAM.
>>
>> Best times:
>> Linux:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
>> FreeBSD:        3.49s user 345.12s system 1983% cpu 17.573 total
>> OpenBSD:        5.01s user 6463.66s system 2000% cpu 5:23.42 total
>> DragonflyBSD:   11.73s user 1316.76s system 1023% cpu 2:09.78 total
>> OmniosCE:       9.17s user 516.53s system 1550% cpu 33.905 total
>>
>> NetBSD failed to complete the run, OOM-killing workers:
>> http://mail-index.netbsd.org/tech-kern/2023/10/19/msg029242.html
>> OpenBSD is shafted by a big kernel lock, so no surprise it takes a long
>> time.
>>
>> So what I find funny is that Linux needed more time than OmniosCE (an
>> Illumos variant, fork of Solaris).
>>
>> It also needed more time than FreeBSD, which is not necessarily funny
>> but not that great either.
>>
>> All systems were mostly busy contending on locks and in particular Linux
>> was almost exclusively busy waiting on inode hash lock.
>
> Did you bother to test the patch, or are you just complaining
> that nobody has already done the work for you?
>

Why are you giving me attitude?

I ran a test, found the major bottleneck and it turned out there is a
patch which takes care of it, but its inclusion is stalled without
further communication. So I asked about it.

> Because if you tested the patch, you'd have realised that by itself
> it does nothing to improve performance of the concurrent find+stat
> workload. The lock contention simply moves to the sb_inode_list_lock
> instead.
>

Is that something you benched? While it may be there is no change,
going from one bottleneck to another does not automatically mean there
are no gains in performance.

For example, this thing on FreeBSD used to take over one minute (just
like on Linux right now), vast majority of which was spent on
multicore issues. I massaged it down to ~18 seconds, despite it still
being mostly bottlenecked on locks.

So I benched the hashbl change and it provides a marked improvement:
stock:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
patched:  6.34s user 453.87s system 1312% cpu 35.052 total

But indeed as expected it is still bottlenecked on locks.

> IOWs, those sb_inode_list_lock changes haven't been included for the
> same reason as the hash-bl patches: outside micro-benchmarks, these
> locks just don't show up in profiles on production machines.
> Hence there's no urgency to "fix" these lock contention
> problems despite the ease with which micro-benchmarks can reproduce
> it...
>

The above is not a made-up microbenchmark though.

I got someone running FreeBSD whose workload mostly consists of
stating tens of millions of files in parallel and which was suffering
a lot from perf standpoint -- flamegraphs show that contending on
locks due to memory reclamation induced by stat calls is almost
everything that was going on at the time. Said workload probably
should not do that to begin with (instead have a db with everything it
normally stats for?), but here we are.

That is to say, while I would not be in position to test Linux in the
above workload, the problem (high inode turnover in memory) is very
much real.

All that said, if a real deployment which runs into the problem is
needed to justify the change, then I can't help (wrong system).

-- 
Mateusz Guzik <mjguzik gmail.com>

