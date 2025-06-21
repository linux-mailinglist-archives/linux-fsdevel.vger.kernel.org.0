Return-Path: <linux-fsdevel+bounces-52385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C1AE2D0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D61174E34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1002701D0;
	Sat, 21 Jun 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V831u3Ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51E30E842
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jun 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750549630; cv=none; b=omTkiO4wIc0XHny/rgDvZ5j+pMEq4kMRjpGGuJrVGLPVJWvU+UP4HtzZpFD36+1bSXLSW6NxNTBEhfhiyXf0K3/Pi8afJ/TQIKSMXixUsMhbIVshvbYy50UXKJR1wzS40TkV/UxPWu2y6Qs0qTr7WvN+kY0HkEZkIVS1DJkgWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750549630; c=relaxed/simple;
	bh=IExmb1Yylsbaz8gT8G51Tsy6qJeebKN6F6b9RQetJ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGpML8nJRkTzfKitFFeeIiRuxJZpE5a9qzSWSme/bD/INhLebcW2x7d0JJ1BKa6zdGceg3drYQxBhF8Wa5fFiBakD4N0nvVj1m0CYXzsTimjDx30agMkEO5yHVvTkyARYylJMD5Wp+qiEPDeFA3A/7GWhvUGDmFcShayAODRsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V831u3Ou; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Jun 2025 19:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750549616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtEpdf2Sm20BULRUQ7J60IT8r6LCJl5yBzpfSEMUwj0=;
	b=V831u3OuB9W2mlaZPWmPuRYt+PPWXan8ARjLQ2zWJvy18y9KEU0i4IfqGxCUvWfMzq+3n3
	esXjXCZXB3AmxrONYhthYNCFOKvksxTRWeszZZG2yshCAPJ1806jnsI64WJX9abygKJkVG
	SF72mTeFgFMT9wkqhX9lsWZBH1xrIDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?B?SsOpcsO0bWU=?= Poulin <jeromepoulin@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Martin Steigerwald <martin@lichtvoll.de>, Jani Partanen <jiipee@sotapeli.fi>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <yzvtarg7cpwyo3mxwv5obyjhxi2arlxq2lqizgxhe4u55wsvk4@qjt6kkmnmpao>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de>
 <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
 <20250620124346.GB3571269@mit.edu>
 <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
 <ztqfbkxiuuvsp7r66kqxlnedca3h5ckm5wscopzo2e4z33rrjg@lyundluol5qq>
 <CALJXSJrWjsAgN8HDUAhr5WYB97_YS57PuAhwpRctpNFU6=4AKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALJXSJrWjsAgN8HDUAhr5WYB97_YS57PuAhwpRctpNFU6=4AKQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Thanks for the report.

I'd like to add, bcachefs is the _lot_ of people investing a ton of time
QAing this thing. There are a lot of users like Jérôme that I've worked
with for extended periods tracking down all sorts of crazy stuff, and I
thank them for their patience and all their help.

It's been a true community effort.

On Sat, Jun 21, 2025 at 05:07:51PM -0400, Jérôme Poulin wrote:
> The filesystem is very resilient at being rebooted anywhere, anytime.
> It went through many random resets during any of..  fsck repairs, fsck
> rebuilding the btree from scratch, upgrades, in the middle of snapshot
> operations, while replaying journal.  It just always recovers at
> places I wouldn't expect to be able to hit the power switch. Worst
> case, it mounted read-only and needed fsck but could always be mounted
> read-only.

That's the dream :)

I don't think the filesystem should ever fail in a way that leads to
data loss, and I think this is a more than achievable goal.

> Where things get a bit more touchy is when combining all those
> features together;  operations tend to be a bit "racy" between each
> other and tend to lock up when there's multiple features running/being
> used in parallel.  I think this is where we get to the "move fast
> break things" part of the filesystem.  The foundation is solid, read,
> write, inode creations/suppression, bucket management, all basic posix
> operations, checksums, scrub, device addition. Many of the
> bcachefs-specific operations are stable, being able to set compression
> and replication level and data target per folder is awesome stuff and
> works well.

It's not "move fast and break things", we haven't had a problem with
regressions that I've seen.

It's just a project with massive scope, and it takes awhile to find all
the corner cases and make sure there's no pathalogical behaviour in any
scenario.

> From my experience, what is less polished are; snapshots and snapshot
> operations, reflink, nocow, multiprocess heavy workloads, those seem
> to be where the "experimental" part of the filesystem goes into the
> spotlight.

This mostly fits with what I've been seeing; exception being that I
haven't seen any major issues with reflink in ages (you mentioned a
reflink corruption earlier, are you sure that was reflink?).

And rebalance (background data movement) has taken awhile to make
polished, and we're still not done - I think as of 6.16 we've got all
the outright bugs I know of fixed, but there's still behaviour that's
less than ideal (charitably) - if you ask it to move more data to a
target than fits, it'll spin (no longer wasting IO, though). That one
needs some real work to fix properly - another auxiliary index of
"pending" extents, extents that rebalance would like to move but can't
until something changes.

Re: multiprocess workloads, those livelock-ish behaviour have been the
most problematic to track down - but we made some recent progress on
understanding where they're coming from, and the new btree iterator
tracepoints should help.

The new error_throw tracepoint is also already proving useful for
tracking down wonky behaviour (just not the one you're talking about).

> I've been running rotating snapshots on many machines, it
> works well until it doesn't and I need to reboot or fsck. Reflink
> before 6.14 seemed a bit hacky and can result in errors. Nocow tends
> to lock up but isn't really useful with bcachefs anyway. Maybe
> casefolding which might not be fully tested yet. Those are the true
> experimental features and aren't really labelled as such.

Casefolding still has a strange rename bug. Some of the recent self
healing work was partly to make it easier to track down - we now will
notice that something went wrong and pop a fsck error on the first 'ls'
of an improperly renamed dirent.

> We can always say "yes, this is fixed in master, this is fixed in
> 6.XX-rc4" but it is still experimental and tends to be what causes the
> most pain right now.  I think this needs to be communicated more
> clearly. If the filesystem goes off experimental, I think a subset of
> features should be gated by filesystem options to reduce the need for
> big and urgent rc patches.

Yeah, this is coming up more as the userbase grows.

For the moment doing more backports is infeasible due to sheer volume,
but I expect this to be changing soon - 6.17 is when I expect to start
doing more backports.

> The problem is...  when the experimental label is removed, it needs to
> be very clear that users aren't expected to be running the latest rc
> and master branch.  All the features marked as stable should have
> settled enough that there won't be 6 users requiring a developer to
> mount their filesystem read-write or recover files from a catastrophic
> race condition.

Correct. Stable backports will start happening _before_ the experimental
is lifted

> This is where communication needs to be clear, bcachefs website,
> tools, options; should all clearly label features that might require
> someone to ask a developer's help or to run the latest release
> candidate or a debug version of the kernel.

Everything just needs to be solid before the experimental label is
lifted. I don't want users to have to check a website to know what's
safe to use.

From the trends I've been seeing - bug report frequency, severity, and
where in the code we're located - I think we should be in good shape to
lift the experimental label in a year.

Of the ~2 years that bcachefs has been in, a good chunk of that has been
scalabilitiy and feature work, as we hit wider deployment and started
finding out more about what was needed in actual usage.

That's largely done, we don't need any more major development before
lifting experimental (there are some smaller things, like subvolume
walking APIs, but nothing like the disk accounting rewrite or all the
backpointers scalability work). That's why rate of patches has been
going up, now we're down to just fixing user bugs.

> Bcachefs has very nice unit and integration testing with ktest, but it
> isn't enough to represent real-world usage yet and that's why I think
> some features should still be marked just as experimental as erasure
> coding.  Bcachefs filesystem where I do not use reflink, snapshot or
> anything wild, only multiple devices with foreground/promote_target,
> replication, compression, never experience weird issues or lockups for
> many kernel versions now.  Mind you, I'm not using bcachefs on any
> rootfs yet, only specific use-case and patterns that can be
> documented.

Better automated testing would _always_ be nice :)

But realistically there's always going to be only so much we can do with
automated testing, there's always going to be things that only show up
in the wild when users start coming up with crazy usage scenarios and
doing all sorts of wild and wonderful things to break it. There's no
substitute for real world battle testing, and lots of it.

So the big thing on my mind right now isn't improving the automated
testing (besides, the server bill is already $1.5k/month and I run those
machines hard) - it's improving all the debugging tools to make sure we
can quickly and easy debug anything that might happen in the wild.

Later on, I hope we do add more automated testing - especially fault
inejection. _Lots_ of fault injection.

> One more thing that I think is missing, many patches submitted, even
> if it doesn't show up, should have a Reported-By and Tested-By tag to
> help show how many people in the community are working and helping
> make Bcachefs great, it would also make people on the ML aware that
> patches aren't just thrown in there; it usually has been a reported
> bug from a community member which had to test the resulting patch.

Yeah, for sure. You guys have been keeping be busy lately, so when I'm
debugging sunup to sundown for multiple people (a lot of days,
literalyl!) things do get lost :) But I will do more of that.

