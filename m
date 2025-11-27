Return-Path: <linux-fsdevel+bounces-69983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8896C8D115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47D9934DE3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C1314A85;
	Thu, 27 Nov 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLInNBs8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dk5SuCbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8E136358;
	Thu, 27 Nov 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228065; cv=none; b=NI+koxhq2OIxQZ4TQ2WpRL5X1XeVGTiQlb6lcfdCPCd/hd7vlSLFWwMCUDIRLmpS3qum7Ro0ugnwHd3I/kNOAznK0xgLjtA2HVbJLlvWzRQcWHVBNz6rAS2NVkmuK8zO7JS3WfYNnqJA5cPirZaDnqcV+LbBnsvICf5i0wsFey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228065; c=relaxed/simple;
	bh=EjN2pyme8bcJ6nPanSFCQ/XBTZBa8sJ070ZhisLyqvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiwcS0CbVdg2OoGoS3baGJH3DcYFy1ij9Ep0r2tg2HIqoWBO3oOzPJVGk/gpycxLcZxMgyiCLlR3pGXh7GYN5l8Dd7ONlp0VT/E3E/2SoL+fSB+a47NM0+qxrC8U31S9UZq9Pgd0HF8EFE2QhHnyvX3suhUxYBmeoRE1Zpi0K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLInNBs8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dk5SuCbO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 08:20:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764228059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ad8ik7IFSyx7voLIMN7w0BRCBgrkaim2ypdKamKnu4=;
	b=fLInNBs8TXqUHGtP3Sh1sI6ytVwTqfBLr12hBnrz+MA8vrF5DTVkSUXNqFbzywP456lNeB
	ez73iUWVfEsf7FI0j6ikXXxHMfwNimMtiy7rW8tC5ZhcKUxZU29BYos4u2BXpsCC5Ald34
	Vs0GfoQublaZnEOiSv48K7uNCrPlu07CIS0rI3lgaEBNIk8gpzEjvWrfezSP+0BW7PTEpx
	J8wjLrzxdRXyxoQKeZi0kBumr+eR2LmUSOrGj8xPUOqnMccqZfx0+qYvS5U941NFYPFFZS
	PrZb9p0STUdw3Zxv3qYbCkZlJXkHt0KmsNyzGv9MQX3zaLVbHr0vTtdeG4MNJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764228059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ad8ik7IFSyx7voLIMN7w0BRCBgrkaim2ypdKamKnu4=;
	b=dk5SuCbOQvbURXCZeKYw/C9ynGOXmOuzOVf9ofmc8gtUWPcmsiNWWOsyOjHAZ0L3i9i8YU
	ZNHJRX1mAseyi7CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: viro@zeniv.linux.org.uk, linux@armlinux.org.uk, will@kernel.org,
	david.laight@runbox.com, rmk+kernel@armlinux.org.uk,
	brauner@kernel.org, jack@suse.cz, nico@fluxnic.net,
	akpm@linux-foundation.org, hch@lst.de, jack@suse.com,
	wozizhi@huaweicloud.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, rppt@kernel.org,
	vbabka@suse.cz, pfalcato@suse.de, lorenzo.stoakes@oracle.com,
	kuninori.morimoto.gx@renesas.com, tony@atomide.com, arnd@arndb.de,
	punitagrawal@gmail.com, rjw@rjwysocki.net, marc.zyngier@arm.com,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251127072057.EbvhUyG4@linutronix.de>
References: <aSeNtFxD1WRjFaiR@shell.armlinux.org.uk>
 <20251127030316.8396-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127030316.8396-1-xieyuanbin1@huawei.com>

On 2025-11-27 11:03:16 [+0800], Xie Yuanbin wrote:
> On, Wed, 26 Nov 2025 19:26:40 +0000, Al Viro wrote:
> > For quick and dirty variant (on current tree), how about
> > adding
> > 	if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
> > 		goto no_context;
> >
> > right after
> >
> > 	if (!ttbr0_usermode_access_allowed(regs))
> > 		goto no_context;
> >
> > in do_page_fault() there?
> 
> On, Wed, 26 Nov 2025 23:31:00 +0000, Russell King (Oracle) wrote:
> > Now, for 32-bit ARM, I think I am coming to the conclusion that Al's
> > suggestion is probably the easiest solution. However, whether it has
> > side effects, I couldn't say - the 32-bit ARM fault code has been
> > modified by quite a few people in ways I don't yet understand, so I
> > can't be certain at the moment whether it would cause problems.
> 
> I think I've already submitted a very similar patch, to fix another bug:
> On Thu, 16 Oct 2025 20:16:21 +0800, Xie Yuanbin wrote:
> > +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> > +	if (unlikely(addr > TASK_SIZE) && user_mode(regs)) {
> > +		fault = 0;
> > +		code = SEGV_MAPERR;
> > +		goto bad_area;
> > +	}
> > +#endif
> Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com
> 
> However, the patch seems to have received no response for a very long
> time.

This all should be covered by the series here
	https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy@linutronix.de/

or do I miss something.

Sebastian

