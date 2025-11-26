Return-Path: <linux-fsdevel+bounces-69935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACCAC8C5D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE73C351019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A212E62B7;
	Wed, 26 Nov 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OMQTGPEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80C4207A;
	Wed, 26 Nov 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199881; cv=none; b=VdNILyVwXTw1o4aVrTvPUGV+hLwkEb4GqgX/8zi80TTgh2zoIkvvMs9Gdd67cMSkov+TguIu7N9sp73rQUBTrqw5sT3W+2VZUTsQYXHlaLqZ3Y2lg/4wZZynZ1X30OBMMBNmZZlebamkbbK78BklZw4dm1As3NSv1/69/TEo2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199881; c=relaxed/simple;
	bh=K30DygW3iI4KrZzMRvlO2n4J3AsX3lIL6DQycQWlGzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCswe+1O+KqnkQoqdu3zgMsBwt7QS6vnUTdnwq3VPo8pqbkUdmT9rMXCtFb4xJzp7xXKdr6fYYmfafohM9JxePbbhpa9Q9hXLIQr2Q76v6d/B4VKeGoMePYE3xzQ0rGiXMQW8RJLnS40ORlnTTmC+Uo4nIKAKFqwcSvQmbQrN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OMQTGPEv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ICd8G5D0Nxy6iHBtTIxjwZs9PaKgLQ/+fqX/nFiMHTk=; b=OMQTGPEv+0m2vczeCsiycqa7Ei
	Wuo0I3V8eJv5d0zYs5flQN4ysmgsl3TmQvaNIjAK5mAX+icsKntbdAQLW7GcLaWXNhd3Cs7yk3Zz0
	LVB+3AsbzWJ/versa1R4lmzwjvA2MQsPskSNcbiAyvLXQoEW2yueeaVi7E1gnca2sAi9NasppJXra
	45y58mWzoBjoFcYosAc1YeAPNKd+F0JIELmxQavxHiBvwlH1USlL6c8XfFXYFkFIud8OHr+DyswYd
	dPVYh1U0qeE6tFGZ7kYTuGifiPS99/Z05fE3k+aNQiCNiYTvsW2+IUZHFHM3U1IgOoCo6j4ec6asQ
	9HlCJLWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59528)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOOyW-000000004bn-3yEF;
	Wed, 26 Nov 2025 23:31:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOOyS-00000000274-2rWk;
	Wed, 26 Nov 2025 23:31:00 +0000
Date: Wed, 26 Nov 2025 23:31:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <aSeNtFxD1WRjFaiR@shell.armlinux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
 <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
 <20251126192640.GD3538@ZenIV>
 <aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
 <20251126200221.GE3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126200221.GE3538@ZenIV>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 08:02:21PM +0000, Al Viro wrote:
> On Wed, Nov 26, 2025 at 07:51:54PM +0000, Russell King (Oracle) wrote:
> 
> > I don't understand how that helps. Wasn't the report that the filename
> > crosses a page boundary in userspace, but the following page is
> > inaccessible which causes a fault to be taken (as it always would do).
> > Thus, wouldn't "addr" be a userspace address (that the kernel is
> > accessing) and thus be below TASK_SIZE ?
> > 
> > I'm also confused - if we can't take a fault and handle it while
> > reading the filename from userspace, how are pages that have been
> > swapped out or evicted from the page cache read back in from storage
> > which invariably results in sleeping - which we can't do here because
> > of the RCU context (not that I've ever understood RCU, which is why
> > I've always referred those bugs to Paul.)
> 
> No, the filename is already copied in kernel space *and* it's long enough
> to end right next to the end of page.  There's NUL before the end of page,
> at that, with '/' a couple of bytes prior.  We attempt to save on memory
> accesses, doing word-by-word fetches, starting from the beginning of
> component.  We *will* detect NUL and ignore all subsequent bytes; the
> problem is that the last 3 bytes of page might be '/', 'x' and '\0'.
> We call load_unaligned_zeropad() on page + PAGE_SIZE - 2.  And get
> a fetch that spans the end of page.
> 
> We don't care what's in the next page, if there is one mapped there
> to start with.  If there's nothing mapped, we want zeroes read from
> it, but all we really care about is having the bytes within *our*
> page read correctly - and no oops happening, obviously.
> 
> That fault is an extremely cold case on a fairly hot path.  We don't
> want to mess with disabling pagefaults, etc. - not for the sake
> of that.

I think, looking at the x86 handling, 32-bit ARM has missed a heck of
a lot of changes to the fault handling code, going all the way back to
pre-git history.

I seem to remember that I had updated it to match i386's implementation
at one point in the distant past, which is essentially what we have
today with a few tweaks. As code ages, it gets more difficult to
justify wholesale rewrites to bring it back up.

Relevant to this, looking at i386, that at some point added:

+       /*
+        * We fault-in kernel-space virtual memory on-demand. The
+        * 'reference' page table is init_mm.pgd.
+        *
+        * NOTE! We MUST NOT take any locks for this case. We may
+        * be in an interrupt or a critical region, and should
+        * only copy the information from the master page table,
+        * nothing more.
+        *
+        * This verifies that the fault happens in kernel space
+        * (error_code & 4) == 0, and that the fault was not a
+        * protection error (error_code & 1) == 0.
+        */
+       if (unlikely(address >= TASK_SIZE)) {
+               if (!(error_code & 5))
+                       goto vmalloc_fault;
+               /*
+                * Don't take the mm semaphore here. If we fixup a prefetch
+                * fault we could otherwise deadlock.
+                */
+               goto bad_area_nosemaphore;
+       }

which is after notify_die() and the test to see whether we need a
local_irq_enable(). This means we go straight to the fixing up etc
for these addresses.

In today's kernel, this has morphed into:

        /* Was the fault on kernel-controlled part of the address space? */
        if (unlikely(fault_in_kernel_space(address))) {
                do_kern_addr_fault(regs, error_code, address);
        } else {
                do_user_addr_fault(regs, error_code, address);

meaning any page fault for a kernel space address is handled entirely
separately from the normal page fault handling, and it looks like
this is entirely sensible.

Interestingly, however, I notice that x86 appears to no longer call
notify_die(DIE_PAGE_FAULT) in its page fault handling path, and I
wonder whether that's a regression on x86.

Now, for 32-bit ARM, I think I am coming to the conclusion that Al's
suggestion is probably the easiest solution. However, whether it has
side effects, I couldn't say - the 32-bit ARM fault code has been
modified by quite a few people in ways I don't yet understand, so I
can't be certain at the moment whether it would cause problems.

I think the only thing to do is to try the solution and see what
breaks. I'm not in a position to be able to do that as, having not
had reason to touch 32-bit ARM for years, I don't have a hackable
platform nearby. Maybe Xie Yuanbin can test it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

