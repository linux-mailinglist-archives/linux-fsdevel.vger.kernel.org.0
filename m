Return-Path: <linux-fsdevel+bounces-17170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0088A88FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E552814C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142B16FF4A;
	Wed, 17 Apr 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lep17+Kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D815FA7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371813; cv=none; b=mvNkNREwKDvQkFxogXsqoh33r0wlQqQQP+Nsgb8oBwBc8HAaeNT9FwUc9tTWG1g02ijANAu9o6NTNBV6kv6sI9WWBxNUtsvlIpk2evjjHDQkEf+ts4OFY+ZY7M272aPdDuXFy18OMaFF45/dtzQunZa8SRXyKryu/xhpCHcnaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371813; c=relaxed/simple;
	bh=MidJNy96A94Te4IZoNdgPV29Xs+5+pPh/tNpIy97X+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6GJItMRX1JNUC39T+DkLxhGSdtNVkdOOHCMJVsG2f5I40tV/Dxpujw2JTvWDe2LkHLtyZeNX/NrOYt0h7j+txrtMfJT1s/m2cfMVv0awkErHnDgyPrpSJvkQWgx1hU1FD3vIlLSqc02bPU3Mhnm83Uy3K98chsTdzSgRvHjLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lep17+Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF97FC072AA;
	Wed, 17 Apr 2024 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713371813;
	bh=MidJNy96A94Te4IZoNdgPV29Xs+5+pPh/tNpIy97X+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lep17+KdVCIFSAlj5kgw07avaZnA3ZtT1a1GedZcQt4fo/RjSsMNZvzxpXY1wEtrW
	 mXBt5ONNNri/OD47eUzIuFT8vb6fcZSFwVRGMFDYTs2zTEmTlaB5OZlwd3QUVQij2e
	 7SrUrkd7NlerqYTLSCU4jxce2DXOYQqXMipaGwJmpGZr1jlqbfy7CbYG6EwOoJVhXf
	 67ySvHJwhlWSDh0WLottz5uMBBW1NOaYm7CXxQB4LJ+PAvY30Ac5SQN+Tg5DbpbIGl
	 66fad93GPEf4G7V22FwQsz563QGDIoocLCXBRQwjk62Gjmvzvo9burq7f/KAD5klxG
	 JOozCwOBO9ygw==
Date: Wed, 17 Apr 2024 18:36:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Message-ID: <20240417-guthaben-dekret-b2d079ef0d21@brauner>
References: <20240416180414.GA2100066@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416180414.GA2100066@perftesting>

On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> Hello,
> 
> There have been a few common themes that have come up over the years that I feel
> like we should address.
> 
> 1. Adding new file systems.  This is a long and painful process, and I think it
>    should be more painful in order to encourage more FUSE use cases.  However, a
>    lot of the reason it's painful is because it's a "send to Linus and see what
>    happens" sort of process.  Obviously a lot of us get a say, but there's a
>    sort of arbitrary point where it becomes "well send a PR to Linus and see
>    what he thinks."  This is annoying for people who review stuff who may have
>    legitimate concerns, and it's annoying for new file systems who aren't sure
>    what feedback they're supposed to take seriously and what feedback is safe to
>    ignore.
> 
> 2. Removing file systems.  We've gotten some good guidance from Greg and others
>    on this, but this still becomes a thing where nobody feels particularly
>    empowered to send the first patch of actually removing a file system.  In
>    super obvious cases it's easier, but there's a lot of non-obvious cases where
>    we kind of sit here and talk about it without doing anything.
> 
> 3. API changes.  Sometimes we make API changes in the core code and then
>    provided helpers for the other file systems to use until they're converted,
>    and that long tail goes on forever.  We generally avoid doing work that
>    touches all the file systems because we have to coordinate with at least 4
>    major trees. I'm particularly guilty of this one, I didn't even notice when
>    the new mount API went in, and then I wasn't sufficiently motivated to work
>    on it until it intersected with some other work I was doing.  I was easily
>    halfway through the work when I found out that Christian had done all of the
>    work for us previously, which brings me to #4.
> 
> 4. We all have our own ways of doing things, but we're all really similar at the
>    same time.  In btrfs land we prefer small, bitesize patches.  This makes it
>    easier for review, easier for bisecting, etc.  This exists because we take in
>    3x the number of changes as any other file system, we have been bitten
>    several times by some 6'4" jackass with a swearing problem with a 6000 line
>    patch with an unhelpful changelog.  I've had developers get frustrated with
>    our way of running our tree because it's setup differently than others. At
>    the end of the day however a lot of our policies exist to make it as easy as
>    possible for everybody involved to understand what is going on, and to make
>    sure we don't repeat previous mistakes.  At the same time we all do a lot of
>    the same things, emphasize patch review and testing.
> 
> There are other related problems, but these are the big ones as I see them.
> 
> I would like to propose we organize ourselves more akin to the other large
> subsystems.  We are one of the few where everybody sends their own PR to Linus,
> so oftentimes the first time we're testing eachothers code is when we all rebase
> our respective trees onto -rc1.  I think we could benefit from getting more
> organized amongst ourselves, having a single tree we all flow into, and then
> have that tree flow into Linus.
> 
> I'm also not a fan of single maintainers in general, much less for this large of
> an undertaking.  I would also propose that we have a maintainership group where
> we rotate the responsibilities of the mechanics of running a tree like this.
> I'm nothing if not unreliable so I wouldn't be part of this group per se, but I
> don't think we should just make Christian do it.  This would be a big job, and
> it would need to be shared.

Context here is that some of us discussed this idea off-list a while
ago. Various aspects of this sounded appealing to me.

One of my crucial points is that the current fs/ maintainers are
responsible and will decide on the addition of any new maintainers. As
of v6.8 Jan Kara has been added as co-maintainer of fs/.

The number of trees merged into vfs/vfs.git has slowly increased.
There's already a few people that send pulls and there'll be another
tree addition during this cycle.

New subtrees are also now formalized in MAINTAINERS similar to other
hierarchical trees. New trees that are added and that get sent to fs/
are marked with FILESYSTEMS [subsystem] and we've gotten a few of those
last year actually.

I'm generally supportive of moving into this direction. But I have no
interest in this being decided over the heads of the current fs/
maintainers (or individual filesystem maintainers for that matter).

This should be voluntary. Individual fses or subsystems are welcome to
send pulls. If there's bigger fses that want to start doing this then a
conversations on expectations from both sides needs to happen. If we do
this then we start with one or two non-trivial fses and then go from
there. And it also needs to work for Linus obviously.

Rotating tree management for a cycle seems fine to me once we've reached
a point where it's really more than can be handled. Might actually mean
one can get some work on something bigger done. Writing pidfs on the
side while maintaining was certainly fun.

> I would also propose that along with this single tree and group maintainership
> we organize some guidelines about the above problems and all collectively agree
> on how we're going to address them.  Having clear guidelines for adding new file
> systems, clear guidelines for removing them.  Giving developers the ability to
> make big API changes outside of the individual file systems trees to make it
> easier to get things merged instead of having to base against 4 or 5 different
> trees.  Develop some guidelines about how we want patches to look, how we want
> testing to be done, etc. so people can move through our different communities
> and not have drastically different experiences.
> 
> This is a massive proposal, and not one that we're going to be able to nail down
> and implement quickly or easily.  But I think in the long term it'll make
> working in our community simpler, more predictable, and less frustrating for
> everybody.  Thanks,
> 
> Josef

