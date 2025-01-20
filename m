Return-Path: <linux-fsdevel+bounces-39732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF8A1732C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD61883D39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D841EF088;
	Mon, 20 Jan 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bio/Lvmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E81E0E0A;
	Mon, 20 Jan 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401928; cv=none; b=GP23wyBhiv++/idr/tkHz75QFPT8cGsvbENO/2K+lmAYzgdD+Zs6YffdqRjYgL1/3dVmjD2gkmaUyy7drwJTm9dTkGb87CJpUIdc75dY3s+Ui3sbI5B5b2P/lbA+BWpWd4yXCk44JsDenkWqBeXlQZS4Mr4klWScusHOZFhM+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401928; c=relaxed/simple;
	bh=y4Ic7EXtNlxF1083NdQ0vAaJqKRwlwj0PwgmloXSqWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBNrRuey2YAJPazRsefHMjkbIHXW91VORpgiK18OlldxPpnp2WEH2BFuVhHykz+XmqKjbCKoJRvrNFMGyCEIsMD60cVy+nf17uOwHm6vjx+4IQGJgnA15SVg7dIl1yLyu/PjCRNg7SkuTQ6oqdibbdDqJn8Ea3KwtrmtFqS144M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bio/Lvmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47854C4CEDD;
	Mon, 20 Jan 2025 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737401928;
	bh=y4Ic7EXtNlxF1083NdQ0vAaJqKRwlwj0PwgmloXSqWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bio/LvmoBMUp+Avy3tpTWrqz0E2FPZhe7fPXfQljhULCTTpLAjqfM1dDv7unfbIDs
	 W2ZhQjTOAO6YjqjZTTEpRlJ8dBLXld2oqHwTUNqw2fx4YJEl9BrkngXNcF+t1Y8D4X
	 jnVnMQoo25emEOP/Vh44TI1pWu/s7VqUhlahTKbaZgLDO8v94ycAlVMP2h9YapDDbe
	 BxNCKJZ55r2J4L1tzzWu6D9W4JGPlRu5gmcwhxUAybf+K304xmH8cyaUMb0GzkFf0m
	 TI9O45TIKGd3jLBeL2D4CgHsK15xykeBMH6XIj2BWk7G0y2xVZHmoOG/2pG7UBJlvI
	 cqYNx3Da8w4vA==
Date: Mon, 20 Jan 2025 20:38:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs dio
Message-ID: <20250120-narrte-spargel-6b0f052af8b6@brauner>
References: <20250118-vfs-dio-3ca805947186@brauner>
 <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>

On Mon, Jan 20, 2025 at 11:24:56AM -0800, Linus Torvalds wrote:
> On Sat, 18 Jan 2025 at 05:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Add a separate dio read align field to statx, as many out of place write
> > file systems can easily do reads aligned to the device sector size, but
> > require bigger alignment for writes.
> 
> I've pulled this, but it needs some fixing.
> 
> You added the 'dio_read_offset_align' field to 'struct kstat', and
> that structure is *critical*, because it's used even for the real
> 'stat()' calls that people actually use (as opposed to the statx side
> that is seldom a real issue).
> 
> And that field was added in a way that causes the struct to grow due
> to alignment issues.  For no good reason, because there were existing
> holes in there.
> 
> So please just fix it.

Right, sorry I should've noticed that during review.

> I despise the whole statx thing exactly because it has (approximately)
> five specialized users, while slowing down regular stat/fstat that is
> used widely absolutely *evertwhere*.
> 
> Of course, judging by past performance, I wouldn't be surprised if
> glibc has screwed the pooch, and decided to use 'statx()' to implement
> stat, together with extra pointless user space overhead to convert one
> into the other. Because that's the glibc way (ie the whole "turn
> fstat() into the much slower fstatat() call, just because").
> 
> So here's the deal: 'statx()' is *not* an "improved stat". It's an
> actively worse stat() for people who need very unusual and specialized
> information, and it makes everything else worse.

Yes, I'm well aware that you dislike statx(). :) It is heavily used
nowadays though because there's a few additional bits in there that
don't require calling into filesystems but are heavily used.

I want to reiterate that if I'd been involved in statx() I would've done
it as an extensible struct. So v1 of the struct would just be exactly
what stat() was.

This way neither copy-in nor copy-out would have done any unnecessary
work and perf would've been the same. Only when userspace actually
needed additional information it would have to pass in a larger struct
and pay the price for copy-in and copy-out.

I'll get you a new PR soon!

