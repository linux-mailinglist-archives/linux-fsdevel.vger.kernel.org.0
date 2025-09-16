Return-Path: <linux-fsdevel+bounces-61830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1464EB5A3E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E2E3A301C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E72C3252;
	Tue, 16 Sep 2025 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UkeeZH1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAF2582;
	Tue, 16 Sep 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057990; cv=none; b=Sw+5faxxyDnT/SeD2kOec2bBeaoIa0WyJ1lzEPvl1rCKR5xS1yiANkcgxWxu2ZRwVz44McPTDAPaJmFINIXqe4499klY4UZxiRIvQtWttQkD309fD5kyzMATZEvlnPrS70lmfD0AJmqbM7f13+H0LHgm5EiWLPq3Bpa56uYThOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057990; c=relaxed/simple;
	bh=tJ7v2amow6Nukphc2vYgDVl0UiDxe0Mkxm8bSWitNJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtfpLhon9sSe8jzgZlMizRqqgnor5dCWdhb4g9H2GuBIp9bz2rmV97ogj/gVFA5AgDaI/ixcFSXv3GPpapA3o665nkUZ0vcYMi6Yh6xVHgOmSZsA7wblqiQAX9dCGkoCZre7KNZbr3CumLnHGRNfTwChThvBTJvt4A0oy7wlcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UkeeZH1R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yqn5JrCHJ75qJ1M5wbwAacTEtJNDzbRenZ2g7NMAdTo=; b=UkeeZH1R0r6GOrXjtjlcsSa5hN
	8r+6U0ofsRSJ9AucuPYHXQzMKdjNxKG9u5u/jZOQNCywIy2T87K61FOpMLFjEyJToJr/Jaem6m5In
	X+xd99jiFR30B7SgjvPUV8Lj45/FSfTyOYMHlwI/iY4+ForcdbX8RTgKbAPni7CACH6V4vjEU1gYz
	uxp8waAl7HY4H/qmwJvxJqV7VTDCsWK9perGAzIvkFxMvHodG4Si/66CAIG1miuCohS/V4QpLGT9c
	CZS+hD3K1K8XJTWG5M/uE4MOSxOjLHwJfuXu/kdu20tGcCADvj73urgjIILfNfFJX14PWxqgocxXA
	/sjxZhnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uydBv-000000006JJ-0Z5P;
	Tue, 16 Sep 2025 22:26:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uydBq-000000007za-2a30;
	Tue, 16 Sep 2025 22:26:18 +0100
Date: Tue, 16 Sep 2025 22:26:18 +0100
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
Message-ID: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.037251747@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916163252.037251747@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 06:33:09PM +0200, Thomas Gleixner wrote:
> When CONFIG_CPU_SPECTRE=n then get_user() is missing the 8 byte ASM variant
> for no real good reason. This prevents using get_user(u64) in generic code.

I'm sure you will eventually discover the reason when you start getting
all the kernel build bot warnings that will result from a cast from a
u64 to a pointer.

You're not the first to try implementing this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

