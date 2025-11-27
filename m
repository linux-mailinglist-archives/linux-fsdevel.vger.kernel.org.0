Return-Path: <linux-fsdevel+bounces-70037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F6C8EDE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E13B660B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83728C5D9;
	Thu, 27 Nov 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pliw/Hg2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tk/qR6wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF08273816;
	Thu, 27 Nov 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254958; cv=none; b=RkR9P5yJwK/e5o4kTg12rsQ/FpAe0mWDjccyyssAuB6o/0Lhao4ETg1/pJWSPZt8S3utActZc30b5h6MvzjVyeVzDTZWq2x833AcayOeFBpH/Qdzjz0deMd8Jz8dEKP2BOlPBjGIRRrMSPtXjUhhOBGiKpb1lClDWpgHM/w5ahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254958; c=relaxed/simple;
	bh=FFjrNlZ3Qw64oHatIC7QkeWeQt2fwddh71PoWa/omkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh7KipHmz6mUMkebLcX6YC4cKALeatCnXlTFjjjVPMjjYwnqQFlNY5vzVvJfFgu0hSVcAl77TjFXMaGDDcrEQ2U6VtF7+kZD0gifcJ7Qgk8JiDM2RBqstX6hr3V1yGzxBOQRCE6AKgOONVZ02ZDLh+zqyRs3xzQeTEA37ceKGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pliw/Hg2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tk/qR6wX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 15:49:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764254955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7NGhO3m20hNBLQgRoRe5aCNIWN6lSYGzFhhL4/I6i0M=;
	b=Pliw/Hg2CT43fdJgplojXUFqZWA2AK9IGFihMdPAPz54Y8g0mjc85DdYd2Uo6AllcFjoiT
	9VFWW866CG15H8AZg/JOkeXYUoDhKfKcxkPBufmmf31b+Tni2xhvwJ6vE14mXJrqCOEcP0
	d+Jt8lZF5hv5n1mjHJ0kkReygCl30hEonK/PRRaU104CqK4tSZLtYY/ytzUKnDDAFYM56t
	nSDG11BcPSSmZC+LG4P3Ucp1u/pEVab4lb9MPVaD/bferdR2FOke+brgUytotq5Sev6xIe
	1uaZtYHsYuGKahn5mbDONskt7U1CBXWwRR4AMWm1Cw9C0rCqvWuWOYljP/axIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764254955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7NGhO3m20hNBLQgRoRe5aCNIWN6lSYGzFhhL4/I6i0M=;
	b=tk/qR6wXFEg1BUpfHcBHWK5zjR3/ybtkL+SBbbbMbUDbtuwWcXISYr74nD3EOKGwFa5B+2
	Kr1OcIdXS+VWX2CQ==
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
Subject: Re: [RFC PATCH v2 2/2] ARM/mm/fault: Enable interrupts before
 sending signal
Message-ID: <20251127144913.arc7keYZ@linutronix.de>
References: <20251127140109.191657-1-xieyuanbin1@huawei.com>
 <20251127140109.191657-2-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127140109.191657-2-xieyuanbin1@huawei.com>

On 2025-11-27 22:01:09 [+0800], Xie Yuanbin wrote:
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -184,10 +184,13 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
>  	struct task_struct *tsk = current;
>  
>  	if (addr > TASK_SIZE)
>  		harden_branch_predictor();
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_irq_enable();

This shouldn't be limited to CONFIG_PREEMPT_RT. There is nothing wrong
with enabling it unconditionally.

>  #ifdef CONFIG_DEBUG_USER
>  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
>  	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
>  		pr_err("8<--- cut here ---\n");
>  		pr_err("%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",

Sebastian

