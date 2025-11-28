Return-Path: <linux-fsdevel+bounces-70176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E4C92CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 790554E2274
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867E32ED2D;
	Fri, 28 Nov 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exD/y7j9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4CSl6gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436E2D46B1;
	Fri, 28 Nov 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350568; cv=none; b=leipIxcqTTTBlAEIUqGqLjCbuKmA+vOh403+lkh+9g4Yrjm5gz2ksyv23EzhwkL1sCKyMjd4ddCCrqy/lNf7x6/ksmMjwES96cTt0QfmQT3bKYRaaGt+B6AK5cum21zKQJHCCA3FtHCyjFkLxx8CQn4LuSsXvZWSiryaHu/KoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350568; c=relaxed/simple;
	bh=HZcnp6RJdflNQaNkZhoP9wB0ZXvSknhNlVPsemL0eIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkLc4HYMUvt0pZABURuzNMDXe3K+HjF3XfSxoh55dups76cRTKLkimipUYUhcKklWDC89IOEwZnreIi91jNbUBkM28W+hx+wgs+Ba/UUhivaDgMAs8FUt9mstChKLQEqROb+HxVWOWO1ov2vx2NIABof3QuS6pdzruNYKb0jJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exD/y7j9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4CSl6gq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Nov 2025 18:22:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764350564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdQDOqyfil+DNkwzLkg7VF450RbTdgCc8NqtMW6uRW4=;
	b=exD/y7j999jCv6bS9IMXmr8sD3f5ooPKDx0FbXkjx8Zj/4jZp0LGdf83r48cRlz7csM4Ga
	774RSGWxq23m0i77jv/+q1WYKBFSNoHeK0SHXnAycfz20MDDwCsouqDKIt0UomOqQW2JEt
	Ifm/vEMXWcO7DbLtSF415CnpmUT2oDJIBZ9e17a+9JOTcn0g0uIN9m0bLfNklQ8Xln2Xu6
	LvEijg/kINBpfKtj9Zr2zSHXizNpjkYvM1MVykXCXlUGgNkpllZmDS64AXJTlju+wuK9M6
	r6QIBEfXSaR7tiPshZakf/KZ37DzfOetx999jxpGfk44srLtQmtiUsi98BQykQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764350564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdQDOqyfil+DNkwzLkg7VF450RbTdgCc8NqtMW6uRW4=;
	b=M4CSl6gqnCuJP+oILiEsB+RMaQsPNdVWA8BsfnJdgpZXuMRB31+BAQu7VwjE/LRYhROu4e
	95a+J06qa8kBsGCA==
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
Message-ID: <20251128172242.cCNBVf7H@linutronix.de>
References: <20251127145127.qUXs_UAE@linutronix.de>
 <20251128022756.9973-1-xieyuanbin1@huawei.com>
 <20251128120359.Xc09qn1W@linutronix.de>
 <aSnVXrnuY9QKjTKg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSnVXrnuY9QKjTKg@shell.armlinux.org.uk>

On 2025-11-28 17:01:18 [+0000], Russell King (Oracle) wrote:
> > I hope Russell will add them once he gets to it. They got reviewed, I
> > added them to the patch system.
> 
> I'm not sure which patches you're talking about, but discussion is
> still ongoing, so it would be greatly premature to merge anything.

This thread
	https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy@linutronix.de/

and the patches are 9459/1 to 9463/1 in your patch system. They address
other issues, not this one.

> https://lore.kernel.org/r/aSmUnZZATTn3JD7m@willie-the-truck
> 
> There are now many threads each with their own discussion, which
> makes it more difficult to work out which is the implementation that
> should be merged. Clearly, not everyone knows about the other
> discussion threads.

So Will suggested to let change the handler and handle this case. The
other patch is avoiding handling addr > TASK_SIZE.
Any preferences from your side?

Sebastian

