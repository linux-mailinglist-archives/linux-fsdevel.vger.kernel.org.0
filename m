Return-Path: <linux-fsdevel+bounces-61950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8FB80788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90949587F17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35A33592B;
	Wed, 17 Sep 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AXqMWWLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228C22576E;
	Wed, 17 Sep 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122269; cv=none; b=QNCAp32MKxElWCX4JYxkyuRIYZ/EwP7tl/7BgjG57dqc+LcNH7CbuRsuwts2F5GVaCEpfgVRnUL+AnEX2F/u3Jv9kjt5mUnUPOU+J/0M+P5rUy0YnrJQtBDq3GbBcGGMaRRVUD3BLkbMpH1rupy/FmoWcJY8ZtvrBe94w+ogfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122269; c=relaxed/simple;
	bh=dr4qqB+gUQjpx9BPl5XmLoEZyK9T8SJYsWEaVlVRIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG/bScRPit3e/nWanfgM7MjaEgHYmCarHJlhNAQ49QzgYGjBRWl2I/N3See1FTPu68zoWrjyN1lo66sh7INVBgJenhUXsbADu/tQ7QmmN0AxCwk35+aryEOU3dM5hh6jRWVcLNfXx2Lme2eO6R0nzPvjz0F9gDw2MgMAJ6DGK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AXqMWWLO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d2rOtavN8Yu5wp1NcVsRpxDZLel/3IAuBK2KE2s78bs=; b=AXqMWWLOmPyRphOsbmVfXMxScx
	BvFgiufLKJWsHtvi3uUbeWEc2oY0SA/fHNKXxM650FCV4woIljD4ramthXo4iNMBYhqK3UpJ8urAI
	oNYWczNXp8U4ZI2MPeCdij3j7WPW5tN8oYv5wUaPNzUZYuG3/fYejTM4KsEMC/uuEhOzAum5lSUev
	y6iVlG6nM9qom0+6IU8Skhg3J5m/d0bWYCArtFXZMmkqhVWA/O+xCZzKQQZ+KT81ZxGJ9KpLwqQ+l
	ry/4hO5Nnr8PyWYjPO8CTax/TsxCv6qEdYqI4F2UHngp6KcQASfyK7LOAiiaLMzdejC+XOAwgT1jY
	Mylix9gQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uytug-000000004qV-2pGK;
	Wed, 17 Sep 2025 16:17:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uytud-000000000ID-028Q;
	Wed, 17 Sep 2025 16:17:39 +0100
Date: Wed, 17 Sep 2025 16:17:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
Message-ID: <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
 <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
 <87y0qd89q9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0qd89q9.ffs@tglx>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 03:55:10PM +0200, Thomas Gleixner wrote:
> On Wed, Sep 17 2025 at 10:41, Russell King wrote:
> > On Wed, Sep 17, 2025 at 07:48:00AM +0200, Thomas Gleixner wrote:
> >
> > Putting together a simple test case, where the only change is making
> > __gu_val an unsigned long long:
> >
> > t.c: In function ‘get_ptr’:
> > t.c:40:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >    40 |         (x) = (__typeof__(*(ptr)))__gu_val;                             \
> >       |               ^
> > t.c:21:9: note: in expansion of macro ‘__get_user_err’
> >    21 |         __get_user_err((x), (ptr), __gu_err, TUSER());                  \
> >       |         ^~~~~~~~~~~~~~
> > t.c:102:16: note: in expansion of macro ‘__get_user’
> >   102 |         return __get_user(p, ptr);
> >       |                ^~~~~~~~~~
> >
> > In order for the code you are modifying to be reachable, you need to
> > build with CONFIG_CPU_SPECTRE disabled. This is produced by:
> >
> > int get_ptr(void **ptr)
> > {
> >         void *p;
> >
> >         return __get_user(p, ptr);
> > }
> 
> Duh, yes. I hate get_user() and I did not notice, because the
> allmodconfig build breaks early due to frame size checks, so I was too
> lazy to find that config knob and built only a couple of things and an
> artificial test case for u64.
> 
> But it actually can be solved solvable by switching the casting to:
> 
>     (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;
> 
> Not pretty, but after upping the frame size limit it builds an
> allmodconfig kernel.

For me, this produces:

get-user-test.c:41:16: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   41 |         (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;                \
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

with arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0

Maybe you're using a different compiler that doesn't issue that warning?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

