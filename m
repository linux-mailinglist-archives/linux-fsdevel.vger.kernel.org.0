Return-Path: <linux-fsdevel+bounces-70137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D475EC91EE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7A6F34A8A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36472327BED;
	Fri, 28 Nov 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjvODXBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwJZJJp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD3327200;
	Fri, 28 Nov 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331445; cv=none; b=fZ0IW+eKOhSIT//wS6O09oVmTQ5TMQWDh9dt0vmS6aSJZdI0hYfFoYSzwBuuxVuFPa4sfaTXw7rOs2tzj5OWVVY7jJCZFPlKq24yHAiKBKI16fYNgjC9WOt+a7To4Ypzpsw00xZB8Rr9nwvkTuH4sUU5sBVBdkiuYSH4SEGbO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331445; c=relaxed/simple;
	bh=WOfz0d4SvQwVXihXoMNPnT50+9yr0cDYZpjE2roJFxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdqHkbfCPZw/8fgYWzt/Cj2sOqKsqMXOjS994f3FvqbWa8TacBUfb4/2DUUe9FOj57k9U7+dJB+4mTWSVc38qdYIMgpF8YiGKwTwqkShjoEapoEvSr6JOBv8IuOLMCi2Loa1xhVBbduVa08c+QrAvOZh55+C4GjLTSzc/Pj26qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjvODXBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwJZJJp2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Nov 2025 13:03:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764331441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbDjONWolVRWulV3h7Xuju+0Pp5SGwJDbywLzt8xkyA=;
	b=rjvODXBfX/sGkP/SCBKWlg8gpJJxx2QtqmFIp+teBWBjiWqBL8VYrIZsj3aPHQUc6HIpf5
	+gJaijo1gEFelmDWDnOZWkoGyV1Xwk/V8deJSxh/TMhCEvj/MSbeCFh139+ess3+XZBA50
	2N7JPfLDkTVvg5GQNjOcGeY9KhJfhk/PPS2am97rxe1W/A6Uqjp51FL0YmE5eW0zsK+8z2
	jpK+InifjZCWat5n/Udg94w52lpUupY+dExqkuTK68yS0PABYP76Po+H+ZnD3hUZXH7kzv
	6ZRpS6PpL27XyGr7IsFGdkGqOUvzAfc4BZgwyrtKlH/cvlbGZJQ336rUeCu2zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764331441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbDjONWolVRWulV3h7Xuju+0Pp5SGwJDbywLzt8xkyA=;
	b=pwJZJJp2Pqx0lf2Ld6/O21R9gOY7TB3qWP8v0eYtWWqzIGVABTIINg+o1P9ZC0sFnIaQ3K
	YStQHA1g20ACsBBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
	david.laight@runbox.com, hch@lst.de, jack@suse.com,
	kuninori.morimoto.gx@renesas.com, liaohua4@huawei.com,
	lilinjie8@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com, marc.zyngier@arm.com, nico@fluxnic.net,
	pangliyuan1@huawei.com, pfalcato@suse.de, punitagrawal@gmail.com,
	rjw@rjwysocki.net, rmk+kernel@armlinux.org.uk, rppt@kernel.org,
	tony@atomide.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	wangkefeng.wang@huawei.com, will@kernel.org,
	wozizhi@huaweicloud.com
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when
 handling with page faults of kernel address
Message-ID: <20251128120359.Xc09qn1W@linutronix.de>
References: <20251127145127.qUXs_UAE@linutronix.de>
 <20251128022756.9973-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251128022756.9973-1-xieyuanbin1@huawei.com>

On 2025-11-28 10:27:56 [+0800], Xie Yuanbin wrote:
> According to the discussion, it might be better to handle the kernel
> address fault directly, just like what x86 does, instead of finding VMA.

the kernel fault shouldn't have a VMA

> Link: https://elixir.bootlin.com/linux/v6.18-rc7/source/arch/x86/mm/fault.c#L1473
> ```c
> 	if (unlikely(fault_in_kernel_space(address)))
> 		do_kern_addr_fault(regs, error_code, address);
> 	else
> 		do_user_addr_fault(regs, error_code, address);
> ```
> 
> It seems your patches hasn't been merged into the linux-next branch yet.

I hope Russell will add them once he gets to it. They got reviewed, I
added them to the patch system.

> This patch is based on linux-next, so it doesn't include your
> modifications. This patch might conflict with your patch:
> Link: https://lore.kernel.org/20251110145555.2555055-2-bigeasy@linutronix.de
> so I'd like to discuss it with you.

what about this:

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ad58c1e22a5f9..b6b3cd893c808 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -282,10 +282,10 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an interrupt or have no user context, we must not take
+	 * the fault. Kernel addresses are handled in do_translation_fault().
 	 */
-	if (faulthandler_disabled() || !mm)
+	if (faulthandler_disabled() || !mm || addr >= TASK_SIZE)
 		goto no_context;
 
 	if (user_mode(regs))

We shouldn't be getting here. Above TASK_SIZE there are just fix
mappings which don't fault and the VMALLOC array which should be handled
by do_translation_fault(). So this should be only the exception table.

This should also not clash with the previous patches. Would that work
for everyone?

> Thanks!
> 
> Xie Yuanbin

Sebastian

