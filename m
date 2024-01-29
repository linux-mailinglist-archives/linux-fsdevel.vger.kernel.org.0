Return-Path: <linux-fsdevel+bounces-9297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604A83FD56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 06:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6096D282A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7E3C6BA;
	Mon, 29 Jan 2024 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vmeirx5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CE44C76;
	Mon, 29 Jan 2024 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504610; cv=none; b=Nbb382+yaLR1p64+UZ7qz9LI/yKGEMZVdILIL58QR+XUhTFEod+OsD6KexXPX8HapRY9k1O4o24GE0cpd0WMgxTdiEbXz4ASKgSWpDYsBsexFTQPPOdZWrUMCMXjWmNZRx7GvMwgmTt6vpEaqHW9zY9xMOo8lF5Y7N5yhyTtuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504610; c=relaxed/simple;
	bh=bWo1LQtclt3DjACJak7KRjechmo9LRKN+dTIFaj9S+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwgHSAiDsk51QJy7I7adAXBB0zHUQq3Qh7ZqhEf8cq/32eiY0nq4vozO/dBSrHwTVHseN2wItFzBhroeIOUFp/Hnas8Ez2QftF6KYp4Ab1hZZoM7/41g8z+JtG2SoxU0dxqmiBHvbS0DXYlEy+d7bv6nRis6kObEsJv1Xclu8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vmeirx5L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QoqsiGmkzCZBurOQpTAzJeU0KMKVWVIax2I0KtXPowM=; b=vmeirx5Lp2/bwMkIhA5RtiTkoE
	y/LIKSaUczI/t5R9SaNhwf0qbKF3Xwtr7IoiOtkpFIGwGrt4zXxoLPa7/5m+ymG9KqEWJsTRzUr0z
	xfATWd2kpS5xg3FtVbnuz0Xw4zQWMK6Ph47AHUsZyvqOJ7uLVCnSKBBHii4zUBkG/+wpydDnpTyiH
	9qDSbNRd+G4WivJrPXFhSTUpNv5iYdo/HzRXoU7BCUukEH9LWNFJm1kVbifn1qSac9pTMWVu6kOoh
	ct+xk2zZ/OsYOfB8s9Z7iBfaJTrLbtwqDuRgonN1Lcz4LqSo2aIsCTIrdzO7DfVhssrFEEQVPKJ7U
	GCMnd71w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUJnn-000Axd-2u;
	Mon, 29 Jan 2024 05:03:24 +0000
Date: Mon, 29 Jan 2024 05:03:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
Message-ID: <20240129050323.GJ2087318@ZenIV>
References: <202401280650.Us2Lrkgl-lkp@intel.com>
 <20240128211544.GD2087318@ZenIV>
 <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
 <20240128220904.GF2087318@ZenIV>
 <CAHk-=wih5PvaVpdgjLrAof6cX0SP9kM-z-pWczDk8EaHscDGzg@mail.gmail.com>
 <20240129021309.GG2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129021309.GG2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 29, 2024 at 02:13:09AM +0000, Al Viro wrote:
> On Sun, Jan 28, 2024 at 02:39:35PM -0800, Linus Torvalds wrote:
> > On Sun, 28 Jan 2024 at 14:09, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Do we ever use that thing on iomem in non-VGA setups?
> > 
> > On iomem? No. But I think several of the routines just work on either
> > VGA screen memory directly (c->vc_origin = vga_vram_base), or normal
> > RAM (vc_allocate)
> > 
> > But who knows.. I *used* to know all this code, but happily no longer.
> 
> 
> I hadn't finished going through the callers, but AFAICS in !VGA && !MDA
> case alpha should be just fine with the fallbacks, so we could just
> put the instance in io.c under the same ifdef that pulls asm/vga.h into
> linux/vt_buffer.h

BTW, fun observation:

#ifndef VT_BUF_HAVE_MEMCPYW
static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
{
#ifdef VT_BUF_HAVE_RW
	count /= 2;
	while (count--)
		scr_writew(scr_readw(s++), d++);
#else
	memcpy(d, s, count);
#endif
}
#endif

is... interesting.  VT_BUF_HAVE_MEMCPYW is defined in asm/vga.h on alpha,
mips, powerpc and sparc.  VT_BUF_HAVE_RW is defined precisely in the
same cases.  In other words, fallback is *always* memcpy().  Now, note
that
arch/mips/include/asm/vga.h:50:#define scr_memcpyw(d, s, c) memcpy(d, s, c)
arch/powerpc/include/asm/vga.h:45:#define scr_memcpyw   memcpy
and on sparc we have
static inline void scr_memcpyw(u16 *d, u16 *s, unsigned int n)
{
        BUG_ON((long) d >= 0);

        memcpy(d, s, n);
}

IOW, we might as well kill VT_BUF_HAVE_MEMCPYW on everything except
alpha and turn the bit in vt_buffer.h into
#ifndef VT_BUF_HAVE_MEMCPYW
#define scr_memcpyw memcpyw
#endif

Furthermore, scr_memmovew() situation is not far from that - we
have
* architectures other than alpha/mips/powerpc/sparc - all end
up with memmove(), since neither VT_BUF_HAVE_MEMMOVEW nor
VT_BUF_HAVE_RW is defined
* mips/powerpc/sparc - memmove(), since it's explicitly defined
that way.
* alpha - that weird shit.

Incidentally, why do we play with asm/vga.h on sparc?  Had there ever
been sparc boxen with VGA card in them that would be in text mode?

