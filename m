Return-Path: <linux-fsdevel+bounces-70967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88183CACD0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6391F308DAF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A52D739D;
	Mon,  8 Dec 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yq1FcK78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEE2144C7;
	Mon,  8 Dec 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188460; cv=none; b=sx746ZWRuG1XSunwjKcgSof4m5tmrmGiZq4d9OT7UUaRHMKwzYh1Q4kdcTBkXr3YBbqfeYj1ZiKtvitU9RCYDrvPjm7Ys7j72oVV+3Spy9+ce2UeVIeqMhMoq0D2lWI6B7z14Fetes0cLIQGd95InwUYnIbRGwPqbg7+VbKU08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188460; c=relaxed/simple;
	bh=zzoPaZTOchC0rfeZyXPZrjhQIa0OL/Xj8WihiQjr7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hePMSTADUreT9v3nhNEksOUzw3kbVtBPT4tZbyCqAJlJMG2NmD7Q206Lplo9LFwfYw1hpN9/Pa5ju2kP4W20ER2GTU0MdxhYuSO9cdvgAf73GZ3QNOKypQdgwXsIylntPGVFGtbaPt4FokmlCKa8kkRapBJS2xpz2SVv/KQEdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yq1FcK78; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T2q3qIpB2rZdmxgNfQrdMX7fXgjlUn1FNnbk0gfok3I=; b=Yq1FcK78y3w6nkgHfG8T/MDxrk
	IxPuchTO5iIOBoYJahU8xB/t/TBjpRAjm/4AFYdSRl6UIeQ11DcKzstMyYC6itiWWr6tdIPLP5Y7H
	oqkVhHPMfM+F4oWLKsC9B0VaLXpMAwRhWiAV1s4LEV2C3JSjEkHE7Kgc003Hh1bBk4X6AkWRoEpVW
	oT+77Xz6SycoycRX1c0LeynFqnbm7G1n5TtAHY42t4W9I1dP7Iese3Pe5JIL2yvuHdlvtUE0NKd53
	Oe9oqVQJa7G5XePlJlodhUKIs/7elRd9CSi08xcHHqeO66+yWWWAe3BmmTNtZmFjbpOl1VDVCQCzB
	svgD+L+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSY9S-000000007bR-0fW9;
	Mon, 08 Dec 2025 10:07:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSY9N-000000004vY-2kGQ;
	Mon, 08 Dec 2025 10:07:25 +0000
Date: Mon, 8 Dec 2025 10:07:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org, brauner@kernel.org,
	catalin.marinas@arm.com, hch@lst.de, jack@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pangliyuan1@huawei.com, torvalds@linux-foundation.org,
	wangkefeng.wang@huawei.com, will@kernel.org,
	wozizhi@huaweicloud.com, yangerkun@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aTajXdAVYh9qJI6B@shell.armlinux.org.uk>
References: <aTLLLuup7TeAqFVL@shell.armlinux.org.uk>
 <20251208023206.44238-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208023206.44238-1-xieyuanbin1@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 10:32:06AM +0800, Xie Yuanbin wrote:
> On Fri, 5 Dec 2025 12:08:14 +0000, Russell King wrote:
> > Right, let's split these issues into separate patches. Please test this
> > patch, which should address only the hash_name() fault issue, and
> > provides the basis for fixing the branch predictor issue.
> 
> I conducted a simple test, and it seems that both the hash_name()
> might sleep issue and the branch predictor issue have been fixed.

This isn't entirely fixed. A data abort for an alignment fault (thus
calling do_alignment()) will enable interrupts, and then may call
do_bad_area(). We can't short-circuit this path like we can with
do_page_fault() as alignment faults from userspace can be valid for
the vectors page - not that we should see them, but that doesn't mean
that there isn't something in userspace that does.

> BTW, even with this patch, test cases may still fail. There is another
> bug in hash_name() will also be triggered by the testcase, which will be
> fixed in this patch:
> Link: https://lore.kernel.org/20251127025848.363992-1-pangliyuan1@huawei.com

That patch got missed - I'm notoriously bad at catching every email.
There's just way too much email coming in.

> Test case is from:
> Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com
> 
> Test in commit 6987d58a9cbc5bd57c98 ("Add linux-next specific files for
> 20251205") from linux-next branch.
> 
> I still have a question about this patch: Is 
> ```patch
> +		if (interrupts_enabled(regs))
> +			local_irq_enable();
> ```
> necessary? Although this implementation is closer to the original code,
> which can reduce side effects, do_bad_area(), do_sect_fault(),
> and do_translation_fault() all call __do_kernel_fault() with interrupts
> disabled.

It's to keep the behaviour closer to the original as possible, on the
principle of avoiding unnecessary behavioural changes to the code. As
noted above, do_bad_area() can be called with interrupts enabled.

Whether RT folk would be happy removing that is a different question,
given that they want as much of the kernel to be preemptable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

