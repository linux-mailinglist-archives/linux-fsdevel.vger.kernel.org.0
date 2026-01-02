Return-Path: <linux-fsdevel+bounces-72319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B127FCEE789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F12E30213EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948030DD3B;
	Fri,  2 Jan 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eWZ6M1Lx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DE1F875A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355977; cv=none; b=msnUZGQCUL/frMMRNq5SIMUUeYyn4Eg/n/2DgSt6oTPZFGBDd9esvQEcXLQINx4kE9EQWXUIm7e+W3GksEb4V+cQDA1y428shmjmKEV3L2SEoA1k5ANAomWA9xJXmnmrrQjEzVfaCKpNt+L5oILxR4s4RKC7eKUCwhlfdMow9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355977; c=relaxed/simple;
	bh=FzE6U/oGdJ15c6QaqeojMCWKqLr3ZlCM8vAR3D+T+fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDRMQibFEGl7tmCLqODtur00etwUeV9WW7sNfh74+dOzIIvwUrn1+d9twBmaAVPFI0tZKoO3xY9urnj1vIwOxkq5fJZTOvYkKNUXY1thwfOKizTM0gf67xiFi3ADMvBYfMefLeKUO2/l5ryInkaenOpwM8a9QHvCGcJK2C28ckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eWZ6M1Lx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6sNsz3nStghYSzY+sXXm0yt/UqQQAPm0N+js139ygxI=; b=eWZ6M1LxOy7uZXqanWlIQGUAO+
	MOCPLQXa7avZ/2SNw8YuSx1jkWfO8OQ2ROHAeH7unCs2xIfsNw/4UUpt+9+QVaCduJDkuggJPHLqQ
	+327Ef6QUxiHHK2+tyxckPNJbeSqfqB6lFY8F/tWC93NKL95phJOb//iOLMJMQJmVuTwom+mEt04b
	5Jm12IMW8W3uamxmcV+Go/CNG2VMe2q6mX+OUHl+3P1DTg2N6vBeNSeV7P/d//HXpT0+RBtxTu/kl
	GvnzBlqGY0Vl6AzymRFKx//5iAs1ik1f8ldQMYgjme1eLHQ5KGd/U/ZHPOLaXzgvaQ1tX+Vf6IOu9
	+Nmf+7Aw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41622)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbe1F-000000005x6-2g7a;
	Fri, 02 Jan 2026 12:12:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbe1A-00000000523-3D6T;
	Fri, 02 Jan 2026 12:12:32 +0000
Date: Fri, 2 Jan 2026 12:12:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthew Wilcox <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 3/4] ARM: remove support for highmem on VIVT
Message-ID: <aVe2MH0TUsobPaKL@shell.armlinux.org.uk>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-4-arnd@kernel.org>
 <20251219171412.GG254720@nvidia.com>
 <513078d3-976a-4e6d-b311-dcfcfea99238@app.fastmail.com>
 <aUtPRFdbpSQ20eOx@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUtPRFdbpSQ20eOx@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 23, 2025 at 10:26:12PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 19, 2025 at 09:34:33PM +0100, Arnd Bergmann wrote:
> > On Fri, Dec 19, 2025, at 18:14, Jason Gunthorpe wrote:
> > > On Fri, Dec 19, 2025 at 05:15:58PM +0100, Arnd Bergmann wrote:
> > >>  arch/arm/Kconfig                    |  1 +
> > >>  arch/arm/configs/gemini_defconfig   |  1 -
> > >>  arch/arm/configs/multi_v5_defconfig |  1 -
> > >>  arch/arm/configs/mvebu_v5_defconfig |  1 -
> > >>  arch/arm/include/asm/highmem.h      | 56 ++---------------------------
> > >>  arch/arm/mm/cache-feroceon-l2.c     | 31 ++--------------
> > >>  arch/arm/mm/cache-xsc3l2.c          | 47 +++---------------------
> > >>  arch/arm/mm/dma-mapping.c           | 12 ++-----
> > >>  arch/arm/mm/flush.c                 | 19 +++-------
> > >>  9 files changed, 16 insertions(+), 153 deletions(-)
> > >
> > > This looks great, but do you think there should be a boot time crash
> > > if a VIVT and HIGHMEM are enabled, just incase?
> > 
> > Do you mean in the common code or just for Arm?
> > 
> > We could use the Arm specific cache_is_vivt() macro, but it feels like
> > the 'dpends on !CPU_CACHE_VIVT' Kconfig check I added is both
> > safer and simpler.
> 
> Okay, so maybe I'm asking if !CPU_CACHE_VIVT then the kernel fails to
> boot on vivt systems, maybe it already does?

The cache modes (CPU_CACHE_xxx) are (were) selected by the processor
config entries. Not having the correct processor support built in to
the kernel will cause a boot failure.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

