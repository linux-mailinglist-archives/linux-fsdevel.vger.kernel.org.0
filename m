Return-Path: <linux-fsdevel+bounces-61895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE600B7CC71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F861C056DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F232D5B9;
	Wed, 17 Sep 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F6jd6Ef0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829A2F9D94;
	Wed, 17 Sep 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102091; cv=none; b=Ed4AIAnCcCfQlE/DeDzKKyvEwUtHXZsy1sQyy99pMxgu8x8x0zEclBEWW3Abwnh+eYdpxAY9we8RWKCyC/pFWvi+CurRQN4foEoR4RqJPhwkqcfGq5gjzImcDNa7bl5GidqgKQ/tzc3lmZZzT6mhAKfH2G3skU4sSraTGFqonWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102091; c=relaxed/simple;
	bh=YCI6wulcSyZgO+5t0TGsFWVCvN+/35+a/EhqwuiBoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1SMDjpoyGiLG9QBBdhrsr80LCFFm0/3tBIid6roYfu7DtNqiUh4VFgSfo4m/Ueg0C1FbQaYFxwi6zTcRpuntRU7t7b857X/i/yNY/T2P+KMLNXvdQ6aaiCmwLB//UnTdRtAtM3eGT99ETfXxh28fzo9gyMd3kWT9xSReBVd8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F6jd6Ef0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8m8ART9uGtatKNIYvyyLoFqaRtCnziJZo3bw/694yoE=; b=F6jd6Ef0slDx6KZTkSsFuYbYZP
	nFB5c/p9TCBpYhYgtXht07g+ywDnTKEtxX6GHWKLqwBeOC0sZgFO48KFbAxF9iTFD+BPBQLMT6whX
	iYKssWI5YmQzbMnwomOFNakbcfEaQkV43eUTRUMamh3fiN+Au8cdANEnP1wvOFDPnWT7SUUfomSY+
	4bYD3uIcHoAil2wwfMcQG53So7hfRnTh5uSeyee+fuWoo9U7HYLp7Yvp0lFjrAFSnFTH900aJbx8Y
	7mKOcIL4fV8CUm/U8ExbCUkptV+BpppC43jM+MaeqfnS+8HQZe6z87MCG53vjr2fwUHMUIEJY/sSS
	wsOZXCuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyofB-000000003A2-2cyn;
	Wed, 17 Sep 2025 10:41:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyof7-0000000005z-1COi;
	Wed, 17 Sep 2025 10:41:17 +0100
Date: Wed, 17 Sep 2025 10:41:17 +0100
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
Message-ID: <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
 <875xdhaaun.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xdhaaun.ffs@tglx>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 07:48:00AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 16 2025 at 22:26, Russell King wrote:
> > On Tue, Sep 16, 2025 at 06:33:09PM +0200, Thomas Gleixner wrote:
> >> When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
> >> for no real good reason. This prevents using get_user(u64) in generic code.
> >
> > I'm sure you will eventually discover the reason when you start getting
> > all the kernel build bot warnings that will result from a cast from a
> > u64 to a pointer.
> 
> I really don't know which cast you are talking about.

I'll grant you that the problem is not obvious. It comes about because
of all the different types that get_user() is subject to - it's not
just integers, it's also pointers.

The next bit to realise is that casting between integers that are not
the same size as a pointer causes warnings. For example, casting
between a 64-bit integer type and pointer type causes the compiler to
emit a warning. It doesn't matter if the code path ends up being
optimised away, the warning is still issued.

Putting together a simple test case, where the only change is making
__gu_val an unsigned long long:

t.c: In function ‘get_ptr’:
t.c:40:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   40 |         (x) = (__typeof__(*(ptr)))__gu_val;                             \
      |               ^
t.c:21:9: note: in expansion of macro ‘__get_user_err’
   21 |         __get_user_err((x), (ptr), __gu_err, TUSER());                  \
      |         ^~~~~~~~~~~~~~
t.c:102:16: note: in expansion of macro ‘__get_user’
  102 |         return __get_user(p, ptr);
      |                ^~~~~~~~~~

In order for the code you are modifying to be reachable, you need to
build with CONFIG_CPU_SPECTRE disabled. This is produced by:

int get_ptr(void **ptr)
{
        void *p;

        return __get_user(p, ptr);
}

Now, one idea may be to declare __gu_val as:

	__typeof__(x) __gu_val;

but then we run into:

t.c: In function ‘get_ptr’:
t.c:37:29: error: assignment to ‘void *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
   37 |         default: (__gu_val) = __get_user_bad();                         \
      |                             ^
t.c:21:9: note: in expansion of macro ‘__get_user_err’
   21 |         __get_user_err((x), (ptr), __gu_err, TUSER());                  \
      |         ^~~~~~~~~~~~~~
t.c:102:16: note: in expansion of macro ‘__get_user’
  102 |         return __get_user(p, ptr);
      |                ^~~~~~~~~~

You may think this is easy to solve, just change the last cast to:

	(x) = (__typeof__(*(ptr)))(__typeof__(x))__gu_val;

but that doesn't work either (because in the test case __typeof__(x) is
still a pointer type. You can't cast this down to a 32-bit quantity
because that will knock off the upper 32 bits for the case you're trying
to add.

You may think, why not  move this cast into each switch statement...
there will still be warnings because the cast is still reachable at the
point the compiler evaluates the code for warnings, even though the
optimiser gets rid of it later.

Feel free to try to solve this, but I can assure you that you certainly
are not the first. Several people have already tried.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

