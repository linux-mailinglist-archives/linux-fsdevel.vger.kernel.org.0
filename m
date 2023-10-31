Return-Path: <linux-fsdevel+bounces-1649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BE7DCF82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F5D280F8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C21DDCC;
	Tue, 31 Oct 2023 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xbDJCQ4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DF1C3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:45:12 +0000 (UTC)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15EDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:45:10 -0700 (PDT)
Date: Tue, 31 Oct 2023 10:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698763507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gchYbq79mNDohG4/f4ys44HMok8d0bAKNHT8aFmBDo=;
	b=xbDJCQ4gjieKVwS/6bt9bB9kVPZjx6e3Xe6NROKOBlFHnnt5Rzb2shCM6FwMavZG5XZZKZ
	nu4/YDPeLzrplr7JtuL2JzvU3pzHv2v1ilL/DR+5FPHkjl4Ttewto76Mr7J64qt67fY7ST
	VRMRZoj98joV+h+EnPljL0qQS0/avj4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs for v6.7
Message-ID: <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan>
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
 <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 31, 2023 at 01:47:02PM +0100, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Mon, Oct 30, 2023 at 3:56 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> >
> >   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
> >
> > for you to fetch changes up to b827ac419721a106ae2fccaa40576b0594edad92:
> >
> >   exportfs: Change bcachefs fid_type enum to avoid conflicts (2023-10-26 16:41:00 -0400)
> >
> > ----------------------------------------------------------------
> > Initial bcachefs pull request for 6.7-rc1
> >
> > Here's the bcachefs filesystem pull request.
> >
> > One new patch since last week: the exportfs constants ended up
> > conflicting with other filesystems that are also getting added to the
> > global enum, so switched to new constants picked by Amir.
> >
> > I'll also be sending another pull request later on in the cycle bringing
> > things up to date my master branch that people are currently running;
> > that will be restricted to fs/bcachefs/, naturally.
> >
> > Testing - fstests as well as the bcachefs specific tests in ktest:
> >   https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream
> >
> > It's also been soaking in linux-next, which resulted in a whole bunch of
> > smatch complaints and fixes and a patch or two from Kees.
> >
> > The only new non fs/bcachefs/ patch is the objtool patch that adds
> > bcachefs functions to the list of noreturns. The patch that exports
> > osq_lock() has been dropped for now, per Ingo.
> 
> Thanks for your PR!
> 
> >  fs/bcachefs/mean_and_variance.c                 |  159 ++
> >  fs/bcachefs/mean_and_variance.h                 |  198 ++
> >  fs/bcachefs/mean_and_variance_test.c            |  240 ++
> 
> Looking into missing dependencies for MEAN_AND_VARIANCE_UNIT_TEST and
> failing mean_and_variance tests, this does not seem to match what was
> submitted for public review?
> 
> Lore only has:
> "[PATCH 31/32] lib: add mean and variance module."
> https://lore.kernel.org/all/20230509165657.1735798-32-kent.overstreet@linux.dev/

It was later moved back into fs/bcachefs/, yes. I want to consolidate
the time stats code in bcachefs and bcachefs, so I'll be sending a PR to
move it back out at some point.

Can you point me at what's failing?

