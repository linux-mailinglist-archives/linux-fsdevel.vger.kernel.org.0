Return-Path: <linux-fsdevel+bounces-20355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE338D1F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25791F22218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D5170847;
	Tue, 28 May 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ah1FIbUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084231667C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908236; cv=none; b=L1uDpSFQGKcOZCHGUTlQ7pzC29cO2z1yqYokFVUFSyilj8ji8Hl+Yu8SKtODiZMMbc8E14G/Bjeo+HeUPjr9LMzW9deWOUz4ypyc4eRVwvlcHcrFd8ktLPZ+sTyF9GJWn+e4j2tAax6h1/5mhF+uRbOAZLW9CgKOeRK3Hha99v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908236; c=relaxed/simple;
	bh=5e4Eyu+ivSDaJd/Tf2Gk0Qf4nn/JhPXTY010TVmM2Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBjvFXhSPnlAGTikIvGG8pP/wkbs50reNYBv6CZoWYXgEQwo9SXsC4byGMgey/FFUSxE94iLNZSTvO+0swO04NSCj4UWmMbGgjxtjzP+nR21s7x6rLlL26MCB9xppJrC+hIbKqUDBFE2yotdBBB5PuP62oXMYtGHEapOrVTQWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ah1FIbUq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geert@linux-m68k.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716908226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaedXKwptRwArU5/TiEjza53c6kyC/sm8MBUE2Z0ktc=;
	b=Ah1FIbUqRPiFab0/AihhX29Q0Vhr5jr7LNqAS7NQVlf4wwalwazM/1Q1+jhTd1GQJJbmaF
	1+hX8Utnpl64/yOgrA9DSsbekzgJ98ic3pDWDkDHdX4X1ou9TWxhROQURQEQN+DePeGxOd
	wXib4WonQvUPDRQO2dh1DLVT//CVY/s=
X-Envelope-To: keescook@chromium.org
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 28 May 2024 10:57:03 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <uetvuew5tmhjeipqlemyuocqtx2yn2t5gkuew4vmxh4tbny7kx@4g2qkhfpwbmg>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
 <202405191921.C218169@keescook>
 <CAMuHMdUUTy7G6fUa7+P+ZionsiYag-ni_K4smcp6j=gFb9RJJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUUTy7G6fUa7+P+ZionsiYag-ni_K4smcp6j=gFb9RJJg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 09:18:24AM +0200, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Mon, May 20, 2024 at 4:39 AM Kees Cook <keescook@chromium.org> wrote:
> > On Sun, May 19, 2024 at 12:14:34PM -0400, Kent Overstreet wrote:
> > > [...]
> > > bcachefs changes for 6.10-rc1
> > > [...]
> > >       bcachefs: bch2_btree_path_to_text()
> >
> > Hi Kent,
> >
> > I've asked after this before[1], but there continues to be a lot of
> > bcachefs development going on that is only visible when it appears in
> > -next or during the merge window. I cannot find the above commit on
> > any mailing list on lore.kernel.org[2]. The rules for -next are clear:
> > patches _must_ appear on a list _somewhere_ before they land in -next
> > (much less Linus's tree). The point is to get additional reviews, and
> > to serve as a focal point for any discussions that pop up over a given
> > change. Please adjust the bcachefs development workflow to address this.
> 
> This morning, the kisskb build service informed me about several build
> failures on m68k (e.g. [1]).
> 
> In fact, the kernel test robot had already detected them on multiple 32-bit
> platforms 4 days ago:
>   - Subject: [bcachefs:bcachefs-testing 21/23] fs/bcachefs/btree_io.c:542:7:
>     warning: format specifies type 'size_t' (aka 'unsigned int') but the
>     argument has type 'unsigned long'[2]
>   - Subject: [bcachefs:bcachefs-testing 21/23] fs/bcachefs/btree_io.c:541:33:
>     warning: format '%zu' expects argument of type 'size_t', but argument
>     3 has type 'long unsigned int'[3]
> 
> These are caused by commit 1d34085cde461893 ("bcachefs:
> Plumb bkey into __btree_err()"), which is nowhere to be found on
> any public mailing list archived by lore.
> 
> +               prt_printf(out, " bset byte offset %zu",
> +                          (unsigned long)(void *)k -
> +                          ((unsigned long)(void *)i & ~511UL));
> 
> Please stop committing private unreviewed patches to linux-next,
> as I have asked before [4].
> Thank you!

You seem to be complaining about test infrastructur eissues - you don't
seriously expect code review to be catching 32 bit build isues, do you?

0day takes awhile to run, so I don't always see these right away. I'll
add some 32 bit builds to my own test infrastructure.

