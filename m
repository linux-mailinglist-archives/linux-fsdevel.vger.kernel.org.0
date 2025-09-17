Return-Path: <linux-fsdevel+bounces-61976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E7FB812F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023B7626331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB82FDC4C;
	Wed, 17 Sep 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wr9Pzivg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B261C84C0;
	Wed, 17 Sep 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130467; cv=none; b=Wt+U8OrsC4bTxdNMHUjuuiRMAUMWPkTrwBJFMqJ6VlSOkyy/dOJdXnFAbWoxZU9fRLDwShgsQTL/2OxWAaY2aHhEtD//ijySSGf0aCWShzYTGlIDpNxsIRJKrVgdnQ2kio1lgpQkcNCfp76RksXJJA64gi+fEYRlYLY8Wcn9l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130467; c=relaxed/simple;
	bh=bgcVqmixOn47G6EpqaXlR06xxVFF4RoZW9BetbI6TZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjuZOCUZMSbKA6+0Kbw1LdoKEClTRLuRt1Q3ykhrcGCTnygzv+ioO63uR8PzIaRVP5wpTLtW3CYlcf1FWRexEXCxMqhwR3ck3cYfDdJSeMLlIhJC/iJ+IdeLQBm0s+XDev6mzaI2yuHJE92mcdoBZpgia29eNW7dwZLeFyewcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wr9Pzivg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=re9XiQwZHyoGrJmwBRzeNqQiLmgFq6r4H1Yj73RZIV8=; b=wr9Pzivg4eMg+afHKT1BIf6dDL
	Q4WjVxrBc0RMofwJb53n409SGCq035N3e91aPMXt47MwNYA9yEhewMvTDAR69hT5H45W1sktyPL4D
	nJqQM5Ze4peqVjOJYjvdLJhMaWb3Hk1GCpwyB9MeUYULC+lsqJag91Fo2goJ8S/nDlWnRFIRs2VwB
	OESogtTWXLz49g6qJ/ax/byne2afQNrq/7hNHyIxgElulMsYptKIy5JYhpyG62HfRP/fPgeKFMoGF
	B5lry83DH8O6pkJ0/3cNDFq0lNh25J6Zb7iZkW/R5ofgIx9J0tmY0STZe4bZNS5Rlna7AUq2QWlkf
	imnUJ98Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44040)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyw2u-000000005Pd-0r9U;
	Wed, 17 Sep 2025 18:34:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyw2p-000000000Nu-3wy6;
	Wed, 17 Sep 2025 18:34:15 +0100
Date: Wed, 17 Sep 2025 18:34:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
Message-ID: <aMrxF3AnFox0LH8V@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
 <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
 <87y0qd89q9.ffs@tglx>
 <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>
 <20250917171424.GB1457869@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917171424.GB1457869@ax162>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 10:14:24AM -0700, Nathan Chancellor wrote:
> On Wed, Sep 17, 2025 at 04:17:38PM +0100, Russell King (Oracle) wrote:
> > For me, this produces:
> > 
> > get-user-test.c:41:16: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >    41 |         (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;                \
> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > with arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
> > 
> > Maybe you're using a different compiler that doesn't issue that warning?
> 
> Maybe because the kernel uses -fno-strict-aliasing, which presumably
> turns off -Wstrict-aliasing?

Thanks, I'd forgotten to pick the -f flags for building the out of tree
test. Yes, that does work, but I wonder whether the powerpc 32-bit
approach with __long_type() that Christophe mentioned would be better.
That also appears to avoid all issues, and doesn't need the use of
the nasty __force, address-of and deref trick.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

