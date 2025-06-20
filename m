Return-Path: <linux-fsdevel+bounces-52369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C2AE2681
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 01:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627C11BC6165
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549A23BD1A;
	Fri, 20 Jun 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2sfE72B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5042A9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462509; cv=none; b=uIOikcidY4h70zXAoCtz34vnjjdfGFycdakAdOtEifJT+NIspSPVQUNsin/+mO7NfsQoYoZhxcERCjtHjCEh5GMOauD51mkDXJ7Z0rg/tktyRwWrTIyEvSjSeJMlyH8BUnoqxV4qhzxR/X8xNHPYic3EHUzkW93CkdzttqNZODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462509; c=relaxed/simple;
	bh=ggKAh9KSeQLXZX5dOy0m9MvnoCxk0k7vlIpT/uNzad4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP1Jxi2y7XlHYrLiXr7FkqzdW2dAdqsiYAB7QaPtt2CEomOyL+1nt3k/9OIuVmiEWRB/0n1MZFuqJ+ZK15xbnlCm7cAbRTyQp/iMZOrglY50QRxyAgqjJy+wDfwABtKoVzRM+85fk8mPc6fP1f8r6exo0f0A3qLmZJ4kVNdMXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2sfE72B; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Jun 2025 19:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750462503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tWsslxXZGVlg403xFDlb7Ii0ML959zqGzVWwgzj70s=;
	b=r2sfE72B/Sxqb0ZNBuGVSks29lZrQhRdObDlt+h3v5grpc87o9nRSMntWn0gdU4roVVN96
	E2ofOlXCc9kO05PKfpPEtDyttNFLoo6BHYSKXNxkg6YakqY+SYphJ+yl9WcHh9VhlpU3Kw
	kp6+JNI625UPNgVsEy87LptY23nKDOc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Martin Steigerwald <martin@lichtvoll.de>, 
	Jani Partanen <jiipee@sotapeli.fi>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de>
 <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
 <20250620124346.GB3571269@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620124346.GB3571269@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 08:43:46AM -0400, Theodore Ts'o wrote:
> On Fri, Jun 20, 2025 at 04:14:24AM -0400, Kent Overstreet wrote:
> > 
> > There is a time and a place for rules, and there is a time and a place
> > for using your head and exercising some common sense and judgement.
> > 
> > I'm the one who's responsible for making sure that bcachefs users have a
> > working filesystem. That means reading and responding to every bug
> > report and keeping track of what's working and what's not in
> > fs/bcachefs/. Not you, and not Linus.
> 
> Kent, the risk as always of adding features after the merge window is
> that you might introduce regressions.  This is especially true if you
> are making changes to relatively sensitive portions of any file system
> --- such as journalling.

Ted, you know better than most how long I've been shipping storage code.

You also know just as well as I do that when to include a patch is very
much a judgement call, so I'm quite curious why you and Linus think
yourselves better able to make that judgement call than I.

> The rules around the merge window is something which the vast majority
> of the kernel developers have agreeded upon for well over a decade.
> And it is Linus's responsibility to *enforce* those rules.

And those rules are _always_ flexible when there's a reason for them to
be, and here we do have a very good reason for including that code -
making sure people don't lose filesystems.

> If, as you say, bcachefs is experimental, and no sane person should be
> trusting their data on it, then perhaps this shouldn't be urgent. 

I don't see how that follows.

Firstly, we're not defining what the "experimental" label, and since I
am the one who put that label on bcachefs, I'll define that now.

Primarily:

- Bugs are still outstanding, so users should not expect the same level
  of polish as other filesystems - but that does _not_ mean that it's
  not supported to the same degree as other filesystems. Bug reports are
  triaged, and anything that effects the filesystem as a whole will be
  fixed with great immediacy: "polish" issues or bugs that only affect a
  specific application, or a new feature, might have to wait.

- Stable backports are only happening for the most critical bugs, due to
  the volume of bugfixing. Users are expected to stick close to the
  latest release if they want a fix, and often run rc kernels if there's
  something specific they need. This has been working well, because the
  rate of _regressions_ has been quite low.

And that's basically it.

This isn't btrfs, which took off the experimental label, as I recall,
when the on disk format was frozen. bcachefs's on disk format hasn't
been making incompatible changes in years, and as of 6.15 the last of
the required on disk format upgrades is done.

I'll be taking off the experimental label when I believe bcachefs ready
for widespread deployment by the distributions, not before.

Again, that _does not mean_ that I'm not supporting it like any other
production filesystem is supported. I think user reports should have
made that clear by now.

The talk about "no sane person should trust their data to it" is
entirely baseless - I honestly don't know where you and Linus are
getting that from. It's certainly not based on user reports or anything
I've seen.

bcachefs has been used in production for years, by a small but growing
number of users, and at this point 100+tb filesystems in production are
commonplace. I have one user I work with closely who can rattle off a
long list of workloads he's got on bcachefs, and the only reason he
isn't moving more stuff off of btrfs is send/recv - it'll be a long time
before we have that.

> On the flip side, perhaps if you are claiming that people should be
> using it for critical data, then perhaps your care for user's data
> safety should be.... revisted.

This seems entirely backwards. Whatever I'm claiming is besides the
point: bcachefs has users, and I actively support them.

Now, onwards:

It's _entirely_ unclear why you and Linus are bringing up the
experimental label of bcachefs.

If bcachefs were seen as a widely deployed, non-experimental filesystem
(despite the fact that for all purposes it is), I have to think - I have
to hope - that you'd be taking a more pragmatic approach here.

But I think I and myself would assume that having an experimental label
would mean _looser_ rules, so that development can move more quickly.

So it's hard to fathom what's going on here.

