Return-Path: <linux-fsdevel+bounces-70279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E1C94F12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F33450E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD427703A;
	Sun, 30 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/O9ZzYi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RrraBCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B2272E6E;
	Sun, 30 Nov 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501614; cv=none; b=cn4W8l9JGkIrxxs2zNmQv0zZZvxBvSgwNel4nqRInZVYigpoSVUdTKDLnm7HpgHsof9BezA/qT9X4RGEMgV4quLJRlssoJdl3/cgd/ybI/wr9kq15XW9XitHkjAriEz5M+ve3yPo91XwSmgcHp/yRfUpeAAoB1yHoTwQfIDp/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501614; c=relaxed/simple;
	bh=5GukvJtRxSI4nNFN8ne4cRSKijLmtlAAoxwznQa8t3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ+byOb6vidfq09hKWHGbD8HCjlMDs9xc0M81DEZKmn+vZVy2aJeB4DR8xXGaVEmUqMyvVveGX1QoWE7Q7QGrGyX7q5bfxkBng+Vzy2GmYb6WU8EKwg+18geUj5AVafNQF6wqno2Jqwnu/7xIxeEHFzQvzUYCOcn1ZO+Jl0Og8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/O9ZzYi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RrraBCZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 30 Nov 2025 12:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764501610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPSeu511L0k6gL1IYpux6jfrEM3Z2mSgCdofcykt0M=;
	b=H/O9ZzYiHw/2G2WBqoGZ3K3FPLNuLrAWvk4v/z+wfncXBs075k6aX+F8Iqp8Vgp+LcjyHC
	z1G/MHOyvAh7TA4mK+eXChXlqCIy+EZvNiofVHBTXaCED1jIhLqVlWUxXvtoHpu1Ah9S2e
	F9JX+agQqQ/wqp8/A44N9X3E6LhxoLVaz+GSa+Dj2DBQ++P2UMEGoJSFjvRTB6wNi21E8W
	3esGxnfRtGW9Xy9r7VrNCc6RRigIODj87/eRuf/oAicuV8uZFco5gHUlYiB3CiXIVKxoYP
	MZ7+6xcVMAYjC7Z8e8XAfZYx6UOUYsx3qf+zjw3RwTW8FcJLWYP9IkNoABFSNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764501610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPSeu511L0k6gL1IYpux6jfrEM3Z2mSgCdofcykt0M=;
	b=8RrraBCZU5plsGR6xmde28IoY0RzxSIbtXdVMZm7XVpNQnachUBhpN47q/W3YXgJIb0ERh
	gNxYivhVx7Dx+TBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <20251130112008.DZYHlSPm@linutronix.de>
References: <20251127145127.qUXs_UAE@linutronix.de>
 <20251128022756.9973-1-xieyuanbin1@huawei.com>
 <20251128120359.Xc09qn1W@linutronix.de>
 <aSnVXrnuY9QKjTKg@shell.armlinux.org.uk>
 <20251128172242.cCNBVf7H@linutronix.de>
 <aSndJ1EYUnMGsUYX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSndJ1EYUnMGsUYX@shell.armlinux.org.uk>

On 2025-11-28 17:34:31 [+0000], Russell King (Oracle) wrote:
> On Fri, Nov 28, 2025 at 06:22:42PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-28 17:01:18 [+0000], Russell King (Oracle) wrote:
> > > > I hope Russell will add them once he gets to it. They got reviewed, I
> > > > added them to the patch system.
> > > 
> > > I'm not sure which patches you're talking about, but discussion is
> > > still ongoing, so it would be greatly premature to merge anything.
> > 
> > This thread
> > 	https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy@linutronix.de/
> > 
> > and the patches are 9459/1 to 9463/1 in your patch system. They address
> > other issues, not this one.
> 
> Oh, the branch predictor issue. Yea, I'm not keen on changing that
> because I'm not sure if it's correct (the knowledge for this has
> long since evaporated.) There have been multiple attempts at fixing
> this in the past, and I've previously pointed out problems with
> them when I _did_ have the knowledge. Have you looked back in the
> archives to see whether any of that feedback I've given in the past
> is relevant?

I dug up the emails from 2021, 2019 and you complained that I open the
interrupts too early. Now I moved the invocation of hardening the branch
predictor to happen before the interrupts are enabled. Based on that it
should not raise to any complains.

> > So Will suggested to let change the handler and handle this case. The
> > other patch is avoiding handling addr > TASK_SIZE.
> > Any preferences from your side?
> 
> ... and now we have a new proposal from Linus. I'm not intending to
> do anything on this new problem until the discussion calms down and
> we stop getting new solutions.

Okay. If we could please sort out the first part then it might be easier
to move on here once the dust settled.

Sebastian

