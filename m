Return-Path: <linux-fsdevel+bounces-70974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1CCADA1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E4D3058E61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5242DAFB5;
	Mon,  8 Dec 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mS/JIlOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFB2C159C;
	Mon,  8 Dec 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208665; cv=none; b=U+AVMi0b+pZPwTYEqLfE0MSWlXUdT9mebjpPVM+u5t+LXzxOjqA0RxVl7z0XBylQAMoV28Yv9Y9uB/A4LNac+O56W2FraHp8idj3cMW1It3tmt5SAjzn9eCHjWIZN/Yvd0+3WDSe2Yqkc5QyNf5Yh7Qhbotp6nUzmiC7UhR1ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208665; c=relaxed/simple;
	bh=5QT5/WRESdYkF7GVVE1BUTuJ0w70eV+hD2ZRT3bgbJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV0UFilmTV58SYs91nnJoiMgVVbFlGMWFbnMUJ31juVUQXoYfti6MiBiC7NedioUB7MB7O4uIATwM4K7SptBDlcxNnAN3Lp6AdhE1pGB5XcCriD6yRl+WooY0sDHynOSy5elE95ZF0pyErjnC8rMkVaOhOdGl0ac5qywCnEmT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mS/JIlOM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pslbipuyb311NpGDh7aABN2Ik4Dzwcn+Di9Zp7T7MRM=; b=mS/JIlOMRVTCrqARcmN1g+l1Ii
	wA+sPPH2au2vG9zqcNd5pB7ibNnRoOMQWQkqTMRYcWHEb/xUdQKKphUAl7gYU6K3/PXNYggILrKri
	or0Y1vEey+b4oOLJ2aEQDTMRMLfVfW7RPsU7WOUUflxo2AqiUfA/+xd530Ahi9e84dRQcVYFxXGJl
	D9esXo4AczKMywv4Y8YyosK9Vx6+OvNlj/MOOzpqrJlw7CcDm7yI945DKBQvlNMb6SjuCej6Iru5I
	WTpOwU86ufXTwC7Y5cC5Fjvtma5c4aitPp1NMpxEO3jNTpVX6p2ms9PgDO2NnWEbQ7tHz3WsAfffJ
	VPacYP6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSdP6-000000007uN-491j;
	Mon, 08 Dec 2025 15:44:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSdP2-00000000591-3DmX;
	Mon, 08 Dec 2025 15:43:56 +0000
Date: Mon, 8 Dec 2025 15:43:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, catalin.marinas@arm.com,
	hch@lst.de, jack@suse.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pangliyuan1@huawei.com,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	wangkefeng.wang@huawei.com, will@kernel.org,
	wozizhi@huaweicloud.com, yangerkun@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aTbyPNINxjzU3Lua@shell.armlinux.org.uk>
References: <aTajXdAVYh9qJI6B@shell.armlinux.org.uk>
 <20251208131842.76909-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208131842.76909-1-xieyuanbin1@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 09:18:42PM +0800, Xie Yuanbin wrote:
> On Mon, 8 Dec 2025 10:07:25 +0000, Russell King wrote:
> > This isn't entirely fixed. A data abort for an alignment fault (thus
> > calling do_alignment()) will enable interrupts, and then may call
> > do_bad_area(). We can't short-circuit this path like we can with
> > do_page_fault() as alignment faults from userspace can be valid for
> > the vectors page - not that we should see them, but that doesn't mean
> > that there isn't something in userspace that does.
> 
> I had indeed been lacking in consideration regarding do_alignment()
> before, so thank you for reply. But, may I ask that, is there a scenario
> where user-mode access to kernel addresses causes an alignment fault
> (do_alignment())?

If you mean, won't permission errors be detected first, then no.
Alignment is one of the first things that is checked if alignment
faults are enabled.

So yes, if userspace attempts an unaigned load of a kernel address,
and the CPU does not support / have enabled unaigned load support,
then we will get a data abort with the FSR indicating an alignment
fault. So do_alignment() wil be entered.

Whether branch predictor handling needs to happen in this path is
a separate question, but as it's highly likely we'll take an
exception anyway and userspace is doing Bad Stuff, I feel it's
better to be over-cautious.

> In your last email, you described it as follows:
> On Fri, 5 Dec 2025 12:08:14 +0000, Russell King wrote:
> > Also tested usermode access to kernel space
> > which fails with SEGV:
> > - read from 0xc0000000 (section permission fault, do_sect_fault)
> > - read from 0xffff2000 (page translation fault, do_page_fault)
> > - read from 0xffff0000 (vectors page - read possible as expected)
> > - write to 0xffff0000 (page permission fault, do_page_fault)
> 
> There seems to be no do_alignment()?

Yes, I didn't test this case, because I was only concentrating on
the effects of the proposed patch which did not include moving the
branch predictor handling.

> In other words, is there a way to construct a user-mode testcase which
> accesses a kernel address and triggers do_alignment()?

Testing these mitigations is very difficult as there's no public
test cases for ARM.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

