Return-Path: <linux-fsdevel+bounces-70169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E84C92BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDD34D913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A217029B8FE;
	Fri, 28 Nov 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Du0ZlL/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76642B9B9;
	Fri, 28 Nov 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349356; cv=none; b=vAp9BA9Mz73tcV4Lv9EZ6bL6Hu7FtzOQ+PosHdwIyNMTHPZRbR3hMMl1YTX64l1nNJvBSzNd2pITgFRvubBS5fHOBEBDDxICUwrF79uW+3wLmg+xasKmuYGlYDDTWGTZOGqiMFE9FGpUcFHMzqbylTarI9vagm3dy51BEsYIMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349356; c=relaxed/simple;
	bh=VgjJZdmkHhMWi0QFjzr0qROISGTYjYKxFBEbzNZxRAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bagprzFIG4bkuYvqhKzdO7IZiJGL1JSHbmiK4ED6xRUuvWL/ymF5DCmtm/E6qhbLzYcLPvMf0UiWhLklQ29bMernGUslx5ZhtVSDlr7RO+vQV4Ee/Hrh1/7NBg+fO1OADM7T2i5cWehnKTMh3lTgS7iDZWJS5VGTGfAGVia7uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Du0ZlL/y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XVRJvm/lygEstYwV/cxa35RATnYQMUHVa5blksxqM90=; b=Du0ZlL/yTuJ7tgAK2/eya2Msv0
	m1hqJ1fknLG5/2gAaZraPTBi4xu5lbdIohbe+V2jihr4tRyNEtbSORjNW/LjDwo9S5Nas1NhX0U+X
	vO1ED5Q3H05FJRXQJm28JEFlS6JVro50OVs0uhPUT8l7bea10AB3nG06YNtCYyGUuTmfhMa75P4Oh
	/dhkFNrWOrM0yYp2pq9f5ZW2TG5aKT5L0OnEgk/qi8Al+krHe1/xBvr+aQSYMZAya472w82YALFwu
	5Q2rA7atA436DTMf/r7uTyS/8+zDwF2MuzRB9woLnX+Wm6oeApu9ixX4s8wLJ7MiB7MKf8PvS9g9L
	mYnjWg5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vP1qZ-0000000071m-1bEl;
	Fri, 28 Nov 2025 17:01:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vP1qR-000000003mj-01ZK;
	Fri, 28 Nov 2025 17:01:19 +0000
Date: Fri, 28 Nov 2025 17:01:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, akpm@linux-foundation.org,
	arnd@arndb.de, brauner@kernel.org, david.laight@runbox.com,
	hch@lst.de, jack@suse.com, kuninori.morimoto.gx@renesas.com,
	liaohua4@huawei.com, lilinjie8@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, marc.zyngier@arm.com, nico@fluxnic.net,
	pangliyuan1@huawei.com, pfalcato@suse.de, punitagrawal@gmail.com,
	rjw@rjwysocki.net, rppt@kernel.org, tony@atomide.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, wangkefeng.wang@huawei.com,
	will@kernel.org, wozizhi@huaweicloud.com
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when
 handling with page faults of kernel address
Message-ID: <aSnVXrnuY9QKjTKg@shell.armlinux.org.uk>
References: <20251127145127.qUXs_UAE@linutronix.de>
 <20251128022756.9973-1-xieyuanbin1@huawei.com>
 <20251128120359.Xc09qn1W@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128120359.Xc09qn1W@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 01:03:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-28 10:27:56 [+0800], Xie Yuanbin wrote:
> > According to the discussion, it might be better to handle the kernel
> > address fault directly, just like what x86 does, instead of finding VMA.
> 
> the kernel fault shouldn't have a VMA
> 
> > Link: https://elixir.bootlin.com/linux/v6.18-rc7/source/arch/x86/mm/fault.c#L1473
> > ```c
> > 	if (unlikely(fault_in_kernel_space(address)))
> > 		do_kern_addr_fault(regs, error_code, address);
> > 	else
> > 		do_user_addr_fault(regs, error_code, address);
> > ```
> > 
> > It seems your patches hasn't been merged into the linux-next branch yet.
> 
> I hope Russell will add them once he gets to it. They got reviewed, I
> added them to the patch system.

I'm not sure which patches you're talking about, but discussion is
still ongoing, so it would be greatly premature to merge anything.

https://lore.kernel.org/r/aSmUnZZATTn3JD7m@willie-the-truck

There are now many threads each with their own discussion, which
makes it more difficult to work out which is the implementation that
should be merged. Clearly, not everyone knows about the other
discussion threads.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

