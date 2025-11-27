Return-Path: <linux-fsdevel+bounces-69999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EDC8DDE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FB93AD6C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDB32D0FD;
	Thu, 27 Nov 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B2/lGneY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A932BF25;
	Thu, 27 Nov 2025 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241097; cv=none; b=XB5etIzQajgk/YCykqNsyjW9Ob1gaEjthnn6fzABCW5XG+RYc5miTvmwDObj6c0AAziDIPrRS3JanEMw6zcJdFgzKb4zR+MT6vFYEOXboMmd4azBxYyC8WpwjUOQKwSxTG+DqSJ0ZM1tcOdfzPpveZ2dLOhpzhAq8qdEond0Tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241097; c=relaxed/simple;
	bh=DQolthg95sNpZS3gr3iSLlpUx7AiAQFUg88w6N8wHsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufcT5pEos6ktE59DreeSUCnC/GYBAYOd9T207IANKljhu5sNQsH3wnT5iw4g4xJiymS34lik49VBkXZfNTNEYVITw0UKwxdBjpZWWR/yJCPcLIDTyCbDnflgUZqGGL+OK+uhyh/K1a+Gou3IvOWRHulcfLNrCYfkf7SH4w/f61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B2/lGneY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rwaD6e3iO7FBswKwqbiTF+sng1XMVLA9gDzbmcM5PHM=; b=B2/lGneYs6pnScUNtyjG5fu88K
	S9+aReYiXYJTutEJBS5f97T5J5MZrDROL1VEzgpFlfs8j3y+bS501SkJES8IWxiycOAy0t95qRaeH
	amDDj2epiA9f/aFZLEGgNb8spmyhmFUp4APCVQH6+aCByPg72BD60fXcz+KYCsAktSKAGpGFzlpZZ
	Tja95pCyi8u48LDgytl9k+kcHYcY6uAKQyy40CoI8OC1418+VtkN1t2gybnHazlGHODW/+QZnzKzK
	5UsiiICDEJoHLQ0bHx7brGk6gacCnnB3nNT9ocSQ7FGKsyyMY6yAIQpRv9c7ObQarzVFarrC6m5+p
	g/9m4ITg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOZhM-0000000059B-0iXv;
	Thu, 27 Nov 2025 10:58:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOZhH-000000002cD-2eoj;
	Thu, 27 Nov 2025 10:57:59 +0000
Date: Thu, 27 Nov 2025 10:57:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jack@suse.com, brauner@kernel.org,
	hch@lst.de, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 01:12:38PM -0800, Linus Torvalds wrote:
> On Wed, 26 Nov 2025 at 02:27, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
> >
> > 在 2025/11/26 17:05, Zizhi Wo 写道:
> > > We're running into the following issue on an ARM32 platform with the linux
> > > 5.10 kernel:
> > >
> > > During the execution of hash_name()->load_unaligned_zeropad(), a potential
> > > memory access beyond the PAGE boundary may occur.
> 
> That is correct.
> 
> However:
> 
> > >                This triggers a page fault,
> > > which leads to a call to do_page_fault()->mmap_read_trylock().
> 
> That should *not* happen.  For kernel addresses, mmap_read_trylock()
> should never trigger, much less the full mmap_read_lock().
> 
> See for example the x86 fault handling in  handle_page_fault():
> 
>         if (unlikely(fault_in_kernel_space(address))) {
>                 do_kern_addr_fault(regs, error_code, address);
> 
> and the kernel address case never triggers the mmap lock, because
> while faults on kernel addresses can happen for various reasons, they
> are never memory mappings.
> 
> I'm seeing similar logic in the arm tree, although the check is
> different. do_translation_fault() checks for TASK_SIZE.
> 
>         if (addr < TASK_SIZE)
>                 return do_page_fault(addr, fsr, regs);
> 
> but it appears that there are paths to do_page_fault() that do not
> have this check, ie that do_DataAbort() function does
> 
>         if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>                 return;
> 
> 
> and It's not immediately obvious, but that can call do_page_fault()
> too though the fsr_info[] and ifsr_info[] arrays in
> arch/arm/mm/fsr-2level.c.
> 
> The arm64 case looks like it might have similar issues, but while I'm
> more familiar with arm than I _used_ to be, I do not know the
> low-level exception handling code at all, so I'm just adding Russell,
> Catalin and Will to the participants.
> 
> Catalin, Will - the arm64 case uses
> 
>         if (is_ttbr0_addr(addr))
>                 return do_page_fault(far, esr, regs);
> 
> instead, but like the 32-bit code that is only triggered for
> do_translation_fault().  That may all be ok, because the other cases
> seem to be "there is a TLB entry, but we lack privileges", so maybe
> will never trigger for a kernel access to a kernel area because they
> either do not exist, or we have permissions?
> 
> Anyway, possibly a few of those 'do_page_fault' entries should be
> 'do_translation_fault'? It certainly seems that way at least on 32-bit
> arm.
> 
> Over to more competent people. Russell?

Ha!

As said elsewhere, it looks like 32-bit ARM has been missing updates to
the fault handler since pre-git history - this was modelled in the dim
and distant i386 handling, and it just hasn't kept up.

I'm debating whether an entire rewrite would be appropriate, but I'm in
no position to do that at the moment for several reasons:

1. I've now very little knowledge of the Linux MM, there's been many
   changes over the last decade that I'm not aware of, and my knowledge
   of modern things like RCU, kfence, etc is practically zero.

2. I don't have a 32-bit ARM platform to hand to test on.

3. I've not touched these parts of 32-bit ARM for a very long time, so
   my knowledge there has severely bitrotted - E.g. I need to review the
   FSR codes and what they mean, because that knowledge has now
   evaporated as I've not had to use it for getting on for two decades.

4. The arm32 code has been modified by others in ways I don't yet
   understand.

I'm wondering whether Al's solution would be a reasonable stop-gap, but
I can't say whether it would have any side effects, so I've asked for it
to be tested so we get some idea whether it's a possible solution.

Basically, I'm afraid it's going to be a steep learning curve, and thus
won't be a quick exercise - expect it to take a month or more as there
is Christmas, and then I likely have medical stuff at the beginning of
next year.

The reason I'm suggesting a rewrite to something closer to x86 is that
we then have a familiar code pattern that's much more likely to be
correct going forward for the Linux MM requirements, which should also
make it easier for MM folk to understand.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

