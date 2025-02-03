Return-Path: <linux-fsdevel+bounces-40659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3AA26416
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4307E1884A60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD8209684;
	Mon,  3 Feb 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RspWVIQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0F7081E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612425; cv=none; b=U5OE4oWI7n/cj6QITFCE/CP70dUfnri+icYjmPizfr2EMu7y3Tlr/RieuwxjITL1TOrOtZjNYIn6ZzpMvdNSoKRR41fE2IHvVEdbtcvDe/OXoT+wpGWN4E6DPFNCgN94IMyIveA6LKfBG9IBezGuv3r0mVtWhRVP+N9P7giP3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612425; c=relaxed/simple;
	bh=jbqQHOSdR3Z/E8p0gviyYU2szm3iBUXIVmM7BT5qRDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpP69ISsn1eULGuMrb6MBqXy1Gg0slPE9f5MI4zc7/iDA2XSqAID/M31f5ymI6CQf6xhV2k+frk78mTO8pfmdeR/5bF8k8IBOG5gzasEhWjZm/xOjsFpCTNpAs+58mOMSASaFKMinkdxq5xe2rAEm84CpxBGOpVBQH7jFUi7ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RspWVIQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99499C4CED2;
	Mon,  3 Feb 2025 19:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612424;
	bh=jbqQHOSdR3Z/E8p0gviyYU2szm3iBUXIVmM7BT5qRDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RspWVIQf/hb7gijabGwCeepC+rtl0KexsgE1wUBvfn4HuygX4F8fC9Abu/7Pdy7Mj
	 LZwQDg9XNiFyZ2pWrldLbtRUBkPbRbr2nVRsRPr9/2G9dtI/99vZWv82400F05J+TL
	 GXt6sZe1NZBXzFVVwE8BLmNsyfZyaH8BgbZJOgywzS2xpHcVYDkzvEEBFIugs1ZIw2
	 ylWSuSAUXNGkmkLcUdW612kuhTUalMhYkB7YgcQbEx0FWcOPJp8HjVcV80wI6EVQJa
	 KKd2qC6vplVpHX9wb2x6+RiTk7fBYQgIO5n5ga12rAjbMvWV0KqDZoBPzG3xca+x2h
	 AOI8fjgmTyxiQ==
Date: Mon, 3 Feb 2025 11:53:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <20250203195343.GA134490@frogsfrogsfrogs>
References: <20250203185519.GA2888598@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203185519.GA2888598@zen.localdomain>

On Mon, Feb 03, 2025 at 10:55:19AM -0800, Boris Burkov wrote:
> At Meta, we currently primarily rely on fstests 'auto' runs for
> validating Btrfs as a general purpose filesystem for all of our root
> drives. While this has obviously proven to be a very useful test suite
> with rich collaboration across teams and filesystems, we have observed a
> recent trend in our production filesystem issues that makes us question
> if it is sufficient.
> 
> Over the last few years, we have had a number of issues (primarily in
> Btrfs, but at least one notable one in Xfs) that have been detected in
> production, then reproduced with an unreliable non-specific stressor
> that takes hours or even days to trigger the issue.
> Examples:
> - Btrfs relocation bugs
> https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
> https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
> - Btrfs extent map merging corruption
> https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io/
> - Btrfs dio data corruptions from bio splitting
> (mostly our internal errors trying to make minimal backports of
> https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
> and Christoph's related series)
> - Xfs large folios 
> https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-563942242522@meta.com/
> 
> In my view, the common threads between these are that:
> - we used fstests to validate these systems, in some cases even with
>   specific regression tests for highly related bugs, but still missed
>   the bugs until they hit us during our production release process. In
>   all cases, we had passing 'fstests -g auto' runs.
> - were able to reproduce the bugs with a predictable concoction of "run
>   a workload and some known nasty btrfs operations in parallel". The most
>   common form of this was running 'fsstress' and 'btrfs balance', but it
>   wasn't quite universal. Sometimes we needed reflink threads, or
>   drop_caches, or memory pressure, etc. to trigger a bug.
> - The relatively generic stressing reproducers took hours or days to
>   produce an issue then the investigating engineer could try to tweak and
>   tune it by trial and error to bring that time down for a particular bug.
> 
> This leads me to the conclusion that there is some room for improvement in
> stress testing filesystems (at least Btrfs).
> 
> I attempted to study the prior art on this and so far have found:
> - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
>   tests using fsstress and fsx in fstests/. Most of them are xfs and
>   btrfs tests following the aforementioned pattern of racing fsstress
>   with some scary operations. Most of them tend to run for 30s, though
>   some are longer (and of course subject to TIME_FACTOR configuration)
> - Similar duration error injection tests in fstests (e.g. generic/475)
> - The NFSv4 Test Project
>   https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf 
>   A choice quote regarding stress testing:
>   "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
>   was able to sustain the concurrent load of 10 processes during 24
>   hours, without any problem. Three months later, NFSv4 reached 72 hours
>   of stress under FSSTRESS, without any bugs. From this date, NFSv4
>   filesystem tree manipulation is considered to be stable."
> 
> 
> I would like to discuss:
> - Am I missing other strategies people are employing? Apologies if there
>   are obvious ones, but I tried to hunt around for a few days :)

At the moment I start six VMs per "configuration", which each run one of:

generic/521	(directio)
generic/522	(bufferedio)
generic/476	(fsstress)
generic/388	(fsstress + log recovery)
xfs/285		(online fsck)
xfs/286		(online metadata rebuild)

with SOAK_DURATION=6.5d so that they wrap up right around the time that
each rc release drops.  I also set FSSTRESS_AVOID="-m 16" so that we
don't end up with gigantic quota files.

There are two "configurations" per kernel tree.  The dot product of them
are:

djwong-dev:
-m metadir=1,autofsck=1,uquota,gquota,pquota,
-m metadir=1,autofsck=1,uquota,gquota,pquota, -d rtinherit=1,

tot mainline:
-m autofsck=1, -d rtinherit=1,
-m autofsck=1,

for-next:
-m metadir=1,autofsck=1,uquota,gquota,pquota,
-m metadir=1,autofsck=1,uquota,gquota,pquota, -d rtinherit=1,

Actually, I just realized that with 6.14 I need to update the tot
mainline configuration to have metadir=1.

> - What is the universe of interesting stressors (e.g., reflink, scrub,
>   online repair, balance, etc.)

Prodding djwong and everyone else into loading up fsx/fsstress with
all their weird new file io calls. ;)

> - What is the universe of interesting validation conditions (e.g.,
>   kernel panic, read only fs, fsck failure, data integrity error, etc.)
> - Is there any interest in automating longer running fsstress runs? Are
>   people already doing this with varying TIME_FACTOR configurations in
>   fstests?

I don't run with SOAK_DURATION > 14 days because I generally haven't
found larger values to be useful in finding bugs.  However, these weekly
long soak tests runs have been going since 2016.

FWIW that actually started because we had a lot of customer complaints
in that era about log recovery failures in xfs, and only later did I
spread it beyond generic/388 to the six profiles above.

> - There is relatively less testing with fsx than fsstress in fstests.
>   I believe this creates gaps for data corruption bugs rather than
>   "feature logic" issues that the fsstress feature set tends to hit.

Probably.  I wonder how much we're really flexing io_uring?

--D

> - Can we standardize on some modular "stressors" and stress durations
>   to run to validate file systems?
> 
> In the short term, I have been working on these ideas in a separate
> barebones stress testing framework which I am happy to share, but isn't
> particularly interesting in and of itself. It is basically just a
> skeleton for concurrently running some concurrent "stressors" and then
> validating the fs with some generic "validators". I plan to run it
> internally just to see if I can get some useful results on our next few
> major kernel releases.
> 
> And of course, I would love to discuss anything else of interest to
> people who like stress testing filesystems!
> 
> Thanks,
> Boris
> 

