Return-Path: <linux-fsdevel+bounces-70038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE4C8EECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEC53BA717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370C2F8BC9;
	Thu, 27 Nov 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbwvzb36";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p9WbnQvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1025BEE8;
	Thu, 27 Nov 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255092; cv=none; b=ZYWZ0QCsiCyMv2rirwl0oXk23rFfEa5c4EGTjap0AJ5Nqiv4eC6mpoe2gFjQ9kLpxNXB8orqnbKrYphSU1F5PZM67OKvI0vPGPEc7t/Ii99QHGinTc+aq4/SXRrBDexXKlfB9qJFBuMXQW/I9nxIVBZuOk2SkE+waXhqG/mNJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255092; c=relaxed/simple;
	bh=VWijIJeIy+jhcJC+hdGZzWiEMKdAifCc+dca5ibw3TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaPcjBl3wJBLIJNaferrGdFYWzGB6WCe77xCtV8eYH7KJeJbrrDJk2H4cJXbbJj+Mvr1hV0A+Jki7uUegW+rcnuEp0xkAiju/pS3n0oUNRKvkRQAnzZc93xAprSHiYJDnHAZRr8Uz2Ux28F5FtckGHzsF2Kdigc/AjlybqyTFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbwvzb36; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p9WbnQvb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 15:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764255089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZiGM0rgOh8rCPA4Chxa2korgREX/RFMjcGVwmNVipY=;
	b=hbwvzb365mil7ujSwC8oJpF8CtccBGMjUFmYcTY7jCpfPuJm1qBs5AaPCZPMADrLTWU3TA
	vn13NSp93U+rAvnpb7CJ0J+MVeIUYV+xdakfOm1+LMSRjb7xUMuysNXNhTsWsNcMQiPtCy
	mgyDlVsWbMeHTe0PUshZ5WZZiozDAxx4FSniJOK3nA7unx7A7VajLGUwsB5JV00+dV+U67
	UiuDXqGtIZWaUf7Govw33nazqzbo1QKrSKB2ROJ7mNru2DaY0svMNx441cxH6kdtMmp89s
	7AROEeoJjjKgBMjjOE8d7wS5gvIildHIZSqs4jTxKPt9HJQaFfYb+OOYc2OWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764255089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZiGM0rgOh8rCPA4Chxa2korgREX/RFMjcGVwmNVipY=;
	b=p9WbnQvb7y0LNdkXZr9Yzo0gHnHa6g+Z2WXDmZUBwgqVuoqJOXmUV0kOAeAdzwMXc7ytE7
	mse1wFdfR5DBq6Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: viro@zeniv.linux.org.uk, will@kernel.org, nico@fluxnic.net,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk,
	david.laight@runbox.com, rppt@kernel.org, vbabka@suse.cz,
	pfalcato@suse.de, brauner@kernel.org, lorenzo.stoakes@oracle.com,
	kuninori.morimoto.gx@renesas.com, tony@atomide.com, arnd@arndb.de,
	akpm@linux-foundation.org, punitagrawal@gmail.com, hch@lst.de,
	jack@suse.com, rjw@rjwysocki.net, marc.zyngier@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	wozizhi@huaweicloud.com, liaohua4@huawei.com, lilinjie8@huawei.com,
	pangliyuan1@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when
 handling with page faults of kernel address
Message-ID: <20251127145127.qUXs_UAE@linutronix.de>
References: <20251127140109.191657-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127140109.191657-1-xieyuanbin1@huawei.com>

On 2025-11-27 22:01:08 [+0800], Xie Yuanbin wrote:
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -270,10 +270,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	vm_flags_t vm_flags = VM_ACCESS_FLAGS;
>  
>  	if (kprobe_page_fault(regs, fsr))
>  		return 0;
>  
> +	if (unlikely(addr >= TASK_SIZE)) {
> +		fault = 0;
> +		code = SEGV_MAPERR;
> +		goto bad_area;
> +	}
>  
>  	/* Enable interrupts if they were enabled in the parent context. */
>  	if (interrupts_enabled(regs))
>  		local_irq_enable();

What is with the patch I sent wrong?

Sebastian

