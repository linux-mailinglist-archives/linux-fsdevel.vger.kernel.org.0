Return-Path: <linux-fsdevel+bounces-7879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBC82C2AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B218285DDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECDC6EB49;
	Fri, 12 Jan 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cIKtMsHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65F6EB42
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Jan 2024 10:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705072962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IhkJydrBr5oWl/1kDyDfEcJCZlKsWprnUGSBkWlGJMM=;
	b=cIKtMsHEj9meAF++JzAVaKfnGVL9GKJME8rOMFv7IIvngsEG77r3khtiiC5GzcP2e7YY9a
	u+vhaVEe18vEBZdpEOJ4/M337yCv51f9oPJv1a+F8jtOPBJsytfbTKv5ZjjqcoS9S7j2Bt
	PtORcLkdt7b8+G2PHpSW6ddthJ8HuGg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] bcachefs locking fix
Message-ID: <degsfnsjxknfeizu7mow5vqwel27zdtfxa3p5yxt2l7cd74ndo@5z6424jtcra6>
References: <20240112072954.GC1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112072954.GC1674809@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 12, 2024 at 07:29:54AM +0000, Al Viro wrote:
> Looks like Kent hadn't merged that into his branch for some reason;
> IIRC, he'd been OK with the fix and had no objections to that stuff
> sitting in -next, so...

I did, but then you said something about duplicate commit IDs? I thought
that meant they were going through your tree.

> Kent, if you *do* have objections, please make them now.
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bcachefs-fix
> 
> for you to fetch changes up to bbe6a7c899e7f265c5a6d01a178336a405e98ed6:
> 
>   bch2_ioctl_subvolume_destroy(): fix locking (2023-11-15 22:47:58 -0500)
> 
> ----------------------------------------------------------------
> fix buggered locking in bch2_ioctl_subvolume_destroy()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
 
> ----------------------------------------------------------------
> Al Viro (2):
>       new helper: user_path_locked_at()
>       bch2_ioctl_subvolume_destroy(): fix locking
> 
>  fs/bcachefs/fs-ioctl.c | 31 +++++++++++++++++--------------
>  fs/namei.c             | 16 +++++++++++++---
>  include/linux/namei.h  |  1 +
>  3 files changed, 31 insertions(+), 17 deletions(-)

