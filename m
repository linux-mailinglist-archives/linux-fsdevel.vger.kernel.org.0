Return-Path: <linux-fsdevel+bounces-9264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124983FA46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211C11F224C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3283C481;
	Sun, 28 Jan 2024 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WKVV4JzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741363C46E;
	Sun, 28 Jan 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479750; cv=none; b=HPOI/mE7pPes4ehJ2SF609+7nGkjLi7q3UmNyoZwNU4utKoj4OlUKGtul6lwo6esTP/KwLcu5aMNm1QxCMI0U9zfJSiXePFnltti5NikeXQTbKiE8gz6gIuAYnG1DX0ErBMe15hC9QjZUWsE9jWE2cDm6RESJvRvrh1jeALbSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479750; c=relaxed/simple;
	bh=Svj/uhQONH0YYoalS5BYgSyJ5wJIVTOZ3/QMOCcx2c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXiL8B0EZfl8takHRel2QpDGW4tYnbIz/LqwzdPRZPKHr/rK/n2elyQTBaEXedGzAA3nHXtR4IclYf46Rbiw0cTyXjgKfAL14AST+IXwAsSDF0vTbdBY6kxjbXeHSQ4E3gxqYxsvrLoRal85OUh+5AfqA6puTatTQJ0GVEi2WAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WKVV4JzG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JvGaNpyrRzuacPHK+3LyFnGQ5PrV8OggoB/YP2zjJfs=; b=WKVV4JzGVnI7xh8qZV2d4f7Qsb
	bINwjPFJy7pOqnaC/VzO+9Ct+HlzskD7L9V20kifRSETP+/1Gi5ZyixOPWwB0yYsavS0FvG2CRqcC
	3dK6z3brtu8XsBIx5WX2lW3IPc7pVcnsZ0XWv7RlsVnOrHBjt++UJUA2kFeI/Saz3i0MSQECZVO3S
	kw/IZdDbcNxeYAi8IaPQncFKV1xlMxYYzzff/xH5UsdbfF9TGsybM0DxRY6SMQLwaonttkGHdFqlc
	61SQ/lYfZAVf6LWF4zkJbKxmeV+P9hMbUhZbSXPzAoqOnSBIwaZzPdaEBxV0E8gq6ZLMBoxVwEG2T
	6Swf2u6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUDKr-00HYsi-01;
	Sun, 28 Jan 2024 22:09:05 +0000
Date: Sun, 28 Jan 2024 22:09:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
Message-ID: <20240128220904.GF2087318@ZenIV>
References: <202401280650.Us2Lrkgl-lkp@intel.com>
 <20240128211544.GD2087318@ZenIV>
 <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 28, 2024 at 01:55:31PM -0800, Linus Torvalds wrote:
> On Sun, 28 Jan 2024 at 13:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > The thing is, VT_BUF_HAVE_... are defined in asm/vga.h, so if you don't
> > have VGA_CONSOLE or MDA_CONSOLE you are going to get the default ones.
> > In case of scr_memcpyw() it's going to end up with memcpy(); on alpha
> > that does *not* match the native scr_memcpyw() instance.
> >
> > Since we have vga.h in mandatory-y, with asm-generic fallback being
> > reasonable enough...  Should that include of asm/vga.h be conditional
> > in the first place?
> 
> It should be conditional, because that's the only case you want to
> actually have that special scr_memsetw() etc.
> 
> I think the problem is that you added the vtbuf include to <asm/io.h>,
> which gets included from VGA_H early, before vga.h has even had time
> to tell people that it overrides those helper functions.

Nope.  It's arch/alpha/kernel/io.c growing an include of linux/vt_buffer.h
and blowing up on allnoconfig.  The reason for that include was the
"missing prototype" on scr_memcpyw() definition in there...

> I assume that moving the
> 
>     #define VT_BUF_HAVE_RW
>     #define VT_BUF_HAVE_MEMSETW
>     #define VT_BUF_HAVE_MEMCPYW
> 
> to above the
> 
>     #include <asm/io.h>
> 
> fixes the build?

No such thing...  I can add an explicit extern in io.c, but that's
really obnoxious ;-/

> That said, a good alternative might be to just stop using 'inline' for
> the default scr_memsetw() and scr_memcpyw() functions, make them real
> functions, and mark them __weak.
> 
> Then architectures can override them much more easily, and inlining
> them seems a bit pointless.
> 
> But I doubt it's even worth cleaning things up in this area.

Do we ever use that thing on iomem in non-VGA setups?

