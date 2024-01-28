Return-Path: <linux-fsdevel+bounces-9256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6983FA05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120771C21BF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A93C08E;
	Sun, 28 Jan 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W1o5H2JH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95D3C068;
	Sun, 28 Jan 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476550; cv=none; b=N0Q5i+7H9NiaKNqig/O1mFxlk/1RRbjs22fchC+z1GTwDvgk9MkXF70Y7lG7sD8CatCArfWeGsSLqMc1Q0YVGFrau5XKCgsF+AMqZ1Smp43FO9Rm9qJSPNuk6mnCb8L+kXG4LM6l1xQk/Wv+n9Anuoqh+vKe0IQU5CnBHnT2/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476550; c=relaxed/simple;
	bh=EXuSa4gGiCY0uqNYZiHpX9KNfSk9OgXnN3fhz5hen2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFi6wkjdWyzm5t/qBayZ0PvyiZTHJezE3PtA6Fpte6R9fYvktktlYNU4gnA71c2Y/ul5nX3RQ3st05hBGgTJq+hkI7zf4EPWi1OqXdLsGgbPzfP5gYYxeyXLOlYXtQmx0zwWs5Ybd3VisHm2ThVcVshQGDrurU6XvT1PfsHc2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W1o5H2JH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/1z7epYXd7WwGTtA8Xhkd9FS4LrkVYNY9code3O2GwU=; b=W1o5H2JH+iy1jqASif+VOSnz75
	8z9WRqC3L/hUjGmjMa8Yjw20OEzZT9zURQJVfg5znB4hKkjgP0QISAHQTpRJm6IpIo5pkuzRqTC+P
	TpljrBS3GvwF63JiqbgOIXUpuTs4GJuNdohF5u5DJNO0QNdYLXjcqja1mDyFVEfMYATtBhvYeKLaW
	gSecsnjcCisJmeERHx752xOdXkBBd+gGDa/vEWjxDyy1OoVUctuyqumQWllrqFBRJf7dNb7h/Q38q
	+9GO1wM7iSXxDJ+7fV77cqVwZObd4K6qJtzOpZ6OdagXdZPjhEP8sxCJG7bf2w80ZXt3K4sQbOFBr
	vFBrqa6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUCVE-00HXA6-2A;
	Sun, 28 Jan 2024 21:15:44 +0000
Date: Sun, 28 Jan 2024 21:15:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
Message-ID: <20240128211544.GD2087318@ZenIV>
References: <202401280650.Us2Lrkgl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401280650.Us2Lrkgl-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 28, 2024 at 06:59:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha
> head:   267674e3b4fd1ff6cedf9b22cd304daa75297966
> commit: 1fb71c4d2bcacd6510fbe411016475ccc15b1a03 [5/8] alpha: missing includes
> config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240128/202401280650.Us2Lrkgl-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280650.Us2Lrkgl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401280650.Us2Lrkgl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/alpha/kernel/io.c:655:1: error: redefinition of 'scr_memcpyw'
>      655 | scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
>          | ^~~~~~~~~~~
>    In file included from arch/alpha/kernel/io.c:10:
>    include/linux/vt_buffer.h:42:20: note: previous definition of 'scr_memcpyw' with type 'void(u16 *, const u16 *, unsigned int)' {aka 'void(short unsigned int *, const short unsigned int *, unsigned int)'}
>       42 | static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
>          |                    ^~~~~~~~~~~

_Very_ interesting.  First of all, there are 3 users of scr_memcpyw() -
vt.c, vgacon.c and fbcon.c.  All of them are getting that thing via
vt_buffer.h.  There we have
* include of asm/vga.h, conditional upon VGA_CONSOLE | MDA_CONSOLE
* fallback definitions of scr_...() stuff, conditional upon the
corresponding VT_BUF_HAVE_... not being defined.

The thing is, VT_BUF_HAVE_... are defined in asm/vga.h, so if you don't
have VGA_CONSOLE or MDA_CONSOLE you are going to get the default ones.
In case of scr_memcpyw() it's going to end up with memcpy(); on alpha
that does *not* match the native scr_memcpyw() instance.

Since we have vga.h in mandatory-y, with asm-generic fallback being
reasonable enough...  Should that include of asm/vga.h be conditional
in the first place?

I'm really unfamiliar with that thing - the last time I'd looked at
anything related to virtual console had been back in '99 or so...

