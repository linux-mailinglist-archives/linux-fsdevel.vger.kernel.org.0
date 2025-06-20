Return-Path: <linux-fsdevel+bounces-52276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA518AE108D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E76A1096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3352E403;
	Fri, 20 Jun 2025 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WfQjaHEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9630E831
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750381774; cv=none; b=HhA7aScqV33CrA+Mkc3T8ht8VguBv6cXEGv5FxMxIQtIIUMuofy2QPPXCtMvEpFcCASdbgGnHIaZHlc10NieM/yvTONPSXkCPYxb1YSBSbbeRHeULgETvTFS2vQtzVkDld/PtyUdmFOBWpegxOSgJAARua0/lvJoXmDFfVslTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750381774; c=relaxed/simple;
	bh=T9/dbE1XcmP5MYTC2zfBvSun+GxsjXPmh5iICV/KTHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2vJCW+a5dDBn6vwJorijrnYBrvMOY54EdMz61cT3a7eYN8s3FDo+nS2AZqU7bIp4niBswOzmG7ANz4/PM+SFnVxOrptCo72HGstgRF1a4ZULen3DKYeC41Hq1LBFSw0Nb0nn5l4HbZqUlp9/Rdnj/dMZCeSD06ZX705/qMt7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WfQjaHEK; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Jun 2025 21:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750381760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT0iTunCunFXn9vRXltLaWe5/WhqrdVMi7w3nPYDva8=;
	b=WfQjaHEK+CHC1XjZVFMkgJzTSqtJ0/SLnf41jLFFtDF56GSkPeqPD6kH7vehLTMhPoBcF7
	BN1XRRs/T3fAd002iJJ0Hy2TUwWYloZVGs9iFJxGouJ1aR90YHfz71sBVQg2NoKQca4np9
	E7s9cQGXN1I7+1sctEbcCOt2LCdwJEM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <lyvczhllyn5ove3ibecnacu323yv4sm5snpiwrddw7tyjxo55z@6xea7oo5yqkn>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <CAHk-=wi2ae794_MyuW1XJAR64RDkDLUsRHvSemuWAkO6T45=YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2ae794_MyuW1XJAR64RDkDLUsRHvSemuWAkO6T45=YA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 19, 2025 at 05:51:17PM -0700, Linus Torvalds wrote:
> On Thu, 19 Jun 2025 at 16:06, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > - New option: journal_rewind
> >
> >   This lets the entire filesystem be reset to an earlier point in time.
> >
> >   Note that this is only a disaster recovery tool, and right now there
> >   are major caveats to using it (discards should be disabled, in
> >   particular), but it successfully restored the filesystem of one of the
> >   users who was bit by the subvolume deletion bug and didn't have
> >   backups. I'll likely be making some changes to the discard path in the
> >   future to make this a reliable recovery tool.
> 
> You seem to have forgotten what the point of the merge window was again.

The goal is to get users _code that works_, is it not?

> We don't start adding new features just because you found other bugs.
> 
> I remain steadfastly convinced that anybody who uses bcachefs is
> expecting it to be experimental. They had better.

Honestly, most of the people using bcachefs from what I've seen just
want something that works.

There are a _lot_ of people who've been burned by btrfs. I've even been
seeing more and more people in recent discussions talking about
unrecoverable filesystems with XFS (!).

That last one has been a surprise to me (and I don't think it's anything
to do with the quality of the code), but it honestly should serve as a
wakeup call as to how much is falling through the cracks and how badly
we've been failing.

There are still a lot of people who don't want to move off ext4... and I
can't really blame them.

If you go looking, you won't find those stories about bcachefs - except
from me, when I'm telling people what to watch out for.

And that's because of a lot of hard work, and because I'm dead set on
not repeating past mistakes; I actively hunt down bug reports and I
frequently tell people - "I don't care if you think it's a hardware
issue or pebcak, it's the filesystem's job to not lose data; get me the
info I need and I'll get it sorted and get it working again".

That's the goal here, delivering something that users can trust and rely
on.

I'm not seeing that _you_ get that.

