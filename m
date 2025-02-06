Return-Path: <linux-fsdevel+bounces-41047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36674A2A4FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FE918882D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CB226198;
	Thu,  6 Feb 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCuWKuOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E62040B5;
	Thu,  6 Feb 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835217; cv=none; b=lVZORi7ldytmNKH9MCiK/kLBB1szYYy5ylvo6+UuNdg1AL3uTVXAkcKi1omG/sQrCbUStjyvGIYXWU7eb+t/tXOeXMWX1RRF0OWQpKgpI4RI1qQPVQIb6w5HBqaNoj5qLrHzxi+/FeMTAy9RN78OrzoknsJt5+o35YJcy9S32xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835217; c=relaxed/simple;
	bh=6XzfY0Ym/94MvpFos5qn6qlgB95sB5hZ4t8U3Dq3/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwrex8tEE3qjuGzjHJ5Uo7Nm4sisbouFp97R8zqyERogv3x7iopz6SjioooizYgTgv6Eo5A0K23gMOFy+qGOKy7MxQ3a8oIjUtERSuBZAGOPujRz51/4FkpF+52k3LKRsEPFL3WlwyrQ05O3a1fUnGstVFZrzmvJ7/bc/dQhpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCuWKuOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4AAC4CEDD;
	Thu,  6 Feb 2025 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835217;
	bh=6XzfY0Ym/94MvpFos5qn6qlgB95sB5hZ4t8U3Dq3/dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCuWKuOizKr6twH8SoBtjVugZLOV/N45HXJrh7g1xgtWUTalhOrMotf16LFitSq2m
	 /0JEB2lGOP0dWTz76O5xMhlb+XH3ywUOZcRfis4hBea0Nr7Qk3b6hru9q4bE4yahwK
	 HkmVlrsYaw5LU5HES02M3DNdT0vuhPm1oDHGtaA242Z9ad3/mCdwCqmHtG/PvBV3s8
	 Fn+vkrmBltHw0q2a8zm0EEMdQ0o0Flhd7iprLsNSgZ1Lb9jdkFiA+yB4tSmuGPipuf
	 ej7LmTOhY5kRl1F9K7g6N6o0Z6L1vo16OI84VNGAtClECOyweLRWAuTsuTxOBxjqWN
	 3/+CXWkH6CbTw==
Date: Thu, 6 Feb 2025 10:46:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] CONFIG_VFS_DEBUG at last
Message-ID: <20250206-seestern-amtsmissbrauch-f72509002083@brauner>
References: <20250205183839.395081-1-mjguzik@gmail.com>
 <CAGudoHFq2AbuvvKhhY7pOouE_jhJk5ZdkU_Dd1wYnyYHosndpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFq2AbuvvKhhY7pOouE_jhJk5ZdkU_Dd1wYnyYHosndpA@mail.gmail.com>

On Wed, Feb 05, 2025 at 07:57:07PM +0100, Mateusz Guzik wrote:
> On Wed, Feb 5, 2025 at 7:38 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > This adds a super basic version just to get the mechanism going and
> > adds sample usage.
> >
> > The macro set is incomplete (e.g., lack of locking macros) and
> > dump_inode routine fails to dump any state yet, to be implemented(tm).
> >
> > I think despite the primitive state this is complete enough to start
> > sprinkling warns as necessary.
> >
> > Mateusz Guzik (3):
> >   vfs: add initial support for CONFIG_VFS_DEBUG
> >   vfs: catch invalid modes in may_open
> >   vfs: use the new debug macros in inode_set_cached_link()
> >
> >  fs/namei.c               |  2 ++
> >  include/linux/fs.h       | 16 +++----------
> >  include/linux/vfsdebug.h | 50 ++++++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig.debug        |  9 ++++++++
> >  4 files changed, 64 insertions(+), 13 deletions(-)
> >  create mode 100644 include/linux/vfsdebug.h
> >
> > --
> > 2.43.0
> >
> 
> The produced warn is ugly as sin:\, for example for that bad size:
> [   51.433206] VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) ==
> sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
> *)8))), __builtin_strlen(link), __fortify_strlen(link)) != linklen)
> failed for inode ff32f7c350c8aec8
> 
> maybe there is a way to work it around, the code is literally lifted
> out of mmdebug.h so they presumably have the same problem
> 
> apart from that the assert in may_open is backwards, the code normally
> is not reached.
> 
> anyhow I expect to send a v2, but will wait for feedback before I do

I think it is overdue that we do something like this. Being able to be
more liberal with _meaningful_ asserts can help us in the long run.
So I'm supportive.

