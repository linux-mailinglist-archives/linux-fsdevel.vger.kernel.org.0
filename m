Return-Path: <linux-fsdevel+bounces-896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A887D2992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C611C20939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 05:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC94C9D;
	Mon, 23 Oct 2023 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WxpQhsSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E7A40
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:10:51 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93960DF
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:10:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ac87af634aso1476830a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698037847; x=1698642647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqEGZi5nSfEoo0Jf1Lc/9y+PU60tCr9cp+0wXyKg1dY=;
        b=WxpQhsSgjgpx/wog202AYfXNgcUdaSKauuDbQod+1UQyjd46QuqHb0OvGScxtyP0UB
         je6+UZAXBjkFzlSYzUCCgGpoOroAZHMDlTXUAFPIi89dbs53KrdgkxwFct0DOfcDSzYr
         +3PGslm2nZARABs07tffy0rKsum8WWzSfjJzjrWYrZ6fr08x7QaHuc4Mk1o3fXSqSkRP
         vrvg28a8vTOk76Fserr/i1WHfFXv1s5Uls6IND+CN5XKDWH88ZwcP4ltejAG6snqAImn
         1oALZOCd0LpKDLdFSH/O6GmJvJYcDNrtZeiCAm75ur1XC+yQIvPgFnEb6iEkp69jcMDn
         qDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698037847; x=1698642647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqEGZi5nSfEoo0Jf1Lc/9y+PU60tCr9cp+0wXyKg1dY=;
        b=RXJiaYIH+oKNIWt7E4GpphWDy6nOEcl1vomUXAwwZtiar8n0v6y3euf+dhMelXQYez
         r1cDY4B2Rti/2c1KxLv1RGUzUrSRrV2IMNwX7TJb6pPT6SiHkmRaZEGVQv9+G+Pf4N3B
         buTipJ/BKlieldJiUlPmvqLdq5K6YcGPDlbovmkFiHqEuWAvfcPjJT8XgSV2grFKjRVa
         3+jS0RacmYlCmfE5O9XAYoGFcyaLJ6w1FQJ/U8DDQOkW8jRUaAI1MdKR6dPUHgS+pg+a
         K3Rn+U27VF9jenc/RMhEOpZWg7QthprF7zCT8Es7ityPe3EhCfjjsDkUJ6hgF5nPax/S
         jNzw==
X-Gm-Message-State: AOJu0YxIbeNwgLAvNdr8Xe6D19aKwnswwOoDpYPZTfc7hScBpBZOpi0V
	xkRxIEbPRPPAZOihGzYbS+LolA==
X-Google-Smtp-Source: AGHT+IF4mdl/p7MwmT9rggEW5i0Pnb3I8vJIkySlMMIdR9Uuv2bBWBl35XUkOmugLgCh+EFAsIMURA==
X-Received: by 2002:a05:6a21:35c4:b0:152:6b63:f1e7 with SMTP id ba4-20020a056a2135c400b001526b63f1e7mr6319229pzc.1.1698037846933;
        Sun, 22 Oct 2023 22:10:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001aaf2e8b1eesm5178263plw.248.2023.10.22.22.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 22:10:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qunD9-002jxt-0P;
	Mon, 23 Oct 2023 16:10:43 +1100
Date: Mon, 23 Oct 2023 16:10:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <ZTYAUyiTYsX43O9F@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>

On Fri, Oct 20, 2023 at 07:49:18PM +0200, Mateusz Guzik wrote:
> On 10/20/23, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, Oct 19, 2023 at 05:59:58PM +0200, Mateusz Guzik wrote:
> >> > To be clear there is no urgency as far as I'm concerned, but I did run
> >> > into something which is primarily bottlenecked by inode hash lock and
> >> > looks like the above should sort it out.
> >> >
> >> > Looks like the patch was simply forgotten.
> >> >
> >> > tl;dr can this land in -next please
> >>
> >> In case you can't be arsed, here is something funny which may convince
> >> you to expedite. ;)
> >>
> >> I did some benching by running 20 processes in parallel, each doing stat
> >> on a tree of 1 million files (one tree per proc, 1000 dirs x 1000 files,
> >> so 20 mln inodes in total).  Box had 24 cores and 24G RAM.
> >>
> >> Best times:
> >> Linux:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
> >> FreeBSD:        3.49s user 345.12s system 1983% cpu 17.573 total
> >> OpenBSD:        5.01s user 6463.66s system 2000% cpu 5:23.42 total
> >> DragonflyBSD:   11.73s user 1316.76s system 1023% cpu 2:09.78 total
> >> OmniosCE:       9.17s user 516.53s system 1550% cpu 33.905 total
> >>
> >> NetBSD failed to complete the run, OOM-killing workers:
> >> http://mail-index.netbsd.org/tech-kern/2023/10/19/msg029242.html
> >> OpenBSD is shafted by a big kernel lock, so no surprise it takes a long
> >> time.
> >>
> >> So what I find funny is that Linux needed more time than OmniosCE (an
> >> Illumos variant, fork of Solaris).
> >>
> >> It also needed more time than FreeBSD, which is not necessarily funny
> >> but not that great either.
> >>
> >> All systems were mostly busy contending on locks and in particular Linux
> >> was almost exclusively busy waiting on inode hash lock.
> >
> > Did you bother to test the patch, or are you just complaining
> > that nobody has already done the work for you?
> 
> Why are you giving me attitude?

Look in the mirror, mate.

Starting off with a derogatory statement like:

"In case you can't be arsed, ..."

is a really good way to start a fight.

I don't think anyone working on this stuff couldn't be bothered to
get their lazy arses off their couches to get it merged. Though you
may not have intended it that way, that's exactly what "can't be
arsed" means. 

I have not asked for this code to be merged because I'm not ready to
ask for it to be merged. I'm trying to be careful and cautious about
changing core kernel code that every linux installation out there
uses because I care about this code being robust and stable. That's
the exact opposite of "can't be arsed"....

Further, you have asked for code that is not ready to be merged to
be merged without reviewing it or even testing it to see if it
solved your reported problem. This is pretty basic stuff - it you
want it merged, then *you also need to put effort into getting it
merged* regardless of who wrote the code. TANSTAAFL.

But you've done neither - you've just made demands and thrown
hypocritical shade implying busy people working on complex code are
lazy arses.

Perhaps you should consider your words more carefully in future?

> > Because if you tested the patch, you'd have realised that by itself
> > it does nothing to improve performance of the concurrent find+stat
> > workload. The lock contention simply moves to the sb_inode_list_lock
> > instead.
> >
> 
> Is that something you benched? While it may be there is no change,
> going from one bottleneck to another does not automatically mean there
> are no gains in performance.

Of course I have. I wouldn't have said anything if this wasn't a
subject I have specific knowledge and expertise in. As I've already
said, I've been running this specific "will it scale" find+stat
micro-benchmark for well over a decade. For example:

https://lore.kernel.org/linux-xfs/20130603074452.GZ29466@dastard/

That's dated June 2013, and the workload is:

"8-way 50 million zero-length file create, 8-way
find+stat of all the files, 8-unlink of all the files:"

Yeah, this workload only scaled to a bit over 4 CPUs a decade ago,
hence I only tested to 8-way....

> For example, this thing on FreeBSD used to take over one minute (just
> like on Linux right now), vast majority of which was spent on
> multicore issues. I massaged it down to ~18 seconds, despite it still
> being mostly bottlenecked on locks.
> 
> So I benched the hashbl change and it provides a marked improvement:
> stock:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
> patched:  6.34s user 453.87s system 1312% cpu 35.052 total
> 
> But indeed as expected it is still bottlenecked on locks.

That's better than I expected, but then again I haven't looked at
this code in detail since around 5.17 and lots has changed since
then.  What filesystem was this? What kernel?  What locks is it
bottlenecked on now?  Did you test the vfs-scale branch I pointed
you at, or just the hash-bl patches?

> > IOWs, those sb_inode_list_lock changes haven't been included for the
> > same reason as the hash-bl patches: outside micro-benchmarks, these
> > locks just don't show up in profiles on production machines.
> > Hence there's no urgency to "fix" these lock contention
> > problems despite the ease with which micro-benchmarks can reproduce
> > it...
> 
> The above is not a made-up microbenchmark though.

I didn't say anything about it being "made up".

There's typically a huge difference in behaviour between the
microbenchmark which immediately discards retrieved data and has no
memory footprint to speak of versus an application that comparing
the retrieved data with an in-memory index of inodes held
in a memory constrained environment to determine if anything has
changed and then doing different work if they have changed.

IOWs, while microbenchmarks can easily produce contention, it's much
less obvious that applications doing substantial userspace work
between similar data retrieval operations will experience similar kernel
level contention problems.

What is lacking here is real world evidence showing this is a
production level problem that needs to be solved immediately....

> I got someone running FreeBSD whose workload mostly consists of
> stating tens of millions of files in parallel and which was suffering
> a lot from perf standpoint -- flamegraphs show that contending on
> locks due to memory reclamation induced by stat calls is almost
> everything that was going on at the time.

.... and "one person's workload on FreeBSD" is not significant
evidence there's a Linux kernel problem that needs to be solved
immediately.

> Said workload probably should not do that to begin with (instead
> have a db with everything it normally stats for?), but here we
> are.

As you state, the right fix for the application is to avoid scanning
tens of millions of inodes repeatedly.  We have functionality in
linux like fanotify to watch and report changes to individual files
in a huge filesystem, so even if this was running on Linux the
push-back would be to use fanotify and avoid repeatedly poll the
entire filesystem to find individual file changes.

> That is to say, while I would not be in position to test Linux in the
> above workload, the problem (high inode turnover in memory) is very
> much real.

Yup, XFS currently bottlenecks at about 800,000 inodes/s being
streamed through memory my old 32p test machine - it's largely the
sb->s_inode_list_lock that is the limitation. The vfs-scale branch
I've pointed to brings that up to about 1.5 million inodes/s before
the next set of limits are hit - the system is CPU bound due to the
aggregate memory demand of ~10GB/s being allocated and freed by the
mm subsystem (not lock contention). Hence further improvements are
all about improving per-lookup operation CPU and memory efficiency..

> All that said, if a real deployment which runs into the problem is
> needed to justify the change, then I can't help (wrong system).

Well, that's kind of the point, though - if users and customers are
not reporting that they have production workloads where 800,000
inodes/s throughput through the inode cache is the performance
limiting factor, then why risk destabilising core code by changing
it?

Yes, we can go faster (as the vfs-scale branch shows), but if
applications aren't limited by the existing code, why risk breaking
every linux installation out there by pushing something that isn't
100% baked?  Nobody wins if the new code is faster for a few but has
bugs that many people hit, so if there's no urgency to change the
code I won't hurry to push the change. I've carried this code for
years, a few months here or there isn't going to change anything
material....

If you think that's wrong or want it faster than I might address it,
then by all means you can take the vfs-scale branch and do the
validation work needed to get it pushed it upstream sooner.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

