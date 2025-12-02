Return-Path: <linux-fsdevel+bounces-70452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8B3C9B821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03D9A347630
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB29312821;
	Tue,  2 Dec 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A0MDWDd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53832FD7CA;
	Tue,  2 Dec 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679438; cv=none; b=PIIE/6govFxIIIxZ0O2sn5GGrzJqAKKJGg0bzK8JxhS9N8CX/6dVtnf6EfE7xvVh2zbGYJM/dqsNeXGK1dvu6xDV2YT59ERpITnj9fpcddr3H4TOCciF+hKoEyEG4ALmtD/73Epr3/+mO4UQb0GQT5WRW7+NwCkaARyv2yp266k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679438; c=relaxed/simple;
	bh=7LHwSEOq0SURK/evWsXYOPpcBHjkJj90ktOJw+yLLKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI2U1ub/z+CDv0c/J+edMvc8e4fGewY0vmBnGVzaQKqbflT3FAnpl4/EjsalcJN/vMWDFB1CGSO5FtTwCz+t3QPlfJ92QOAGeg75WVVv8GGMKXkkNzbNXtagA4x9huhStHI7KTw6XX37CastYbGnMy0sX0S1Ekckw1nh8cZMI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A0MDWDd+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pz/V+JN/TaTGWZf//BDpclVF4cfp93h5KOPZd7Eqkp0=; b=A0MDWDd+gqUx3aOH3D6ksP9xwZ
	0REuMbfigE3bF6yA8RA08z27Bl6rVUAQsoiTH//L777avZYe2w+QUnKfhu5n377I5P7YW/6Pz6ZoU
	rd9NmrSMObrxcStlE1mr+X0cbbZW2TsAsetc63JhxzKLEoywsWcf8CWB9EYnkG8S8J3yK8P5MSKlm
	jAfrjf/T0qB4X0Jfyu9ifSydqLyDVmuiiIb3gDtsVPNnAAGMMXOeGcW9s2j2/uE7QK+H9PQ6cILUy
	TpKxptt1g9WU7kv7H9wc/fE8na7giqk54+0S1Q3rnxPUu53G8r1PHMFfhIxp8LD7EjiT6p7/EXv4D
	6LH+Gdcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39162)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQPjF-000000001hN-1Z9W;
	Tue, 02 Dec 2025 12:43:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQPjA-000000007Sl-2MI3;
	Tue, 02 Dec 2025 12:43:32 +0000
Date: Tue, 2 Dec 2025 12:43:32 +0000
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
Message-ID: <aS7e9CbQXS27sGcd@shell.armlinux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
 <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 09:06:50AM -0800, Linus Torvalds wrote:
> I don't think it's necessarily all that big of a deal. Yeah, this is
> old code, and yeah, it could probably be cleaned up a bit, but at the
> same time, "old and crusty" also means "fairly well tested". This
> whole fault on a kernel address is a fairly unusual case, and as
> mentioned, I *think* the above fix is sufficient.

We have another issue in the code - which has the branch predictor
hardening for spectre issues, which can be called with interrupts
enabled, causing a kernel warning - obviously not good.

There's another issue which PREEMPT_RT has picked up on - which is
that delivering signals via __do_user_fault() with interrupts disabled
causes spinlocks (which can sleep on PREEMPT_RT) to warn.

What I'm thinking is to address both of these by handling kernel space
page faults (which will be permission or PTE-not-present) separately
(not even build tested):

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..972bce697c6c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -175,7 +175,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 
 /*
  * Something tried to access memory that isn't in our memory map..
- * User mode accesses just cause a SIGSEGV
+ * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
+ * here, which is safe as the fault being handled is from userspace.
  */
 static void
 __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
@@ -183,8 +184,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 {
 	struct task_struct *tsk = current;
 
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
+	local_irq_enable();
 
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
@@ -259,6 +259,38 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 }
 #endif
 
+static int __kprobes
+do_kernel_address_page_fault(unsigned long addr, unsigned int fsr,
+			     struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/*
+		 * Fault from user mode for a kernel space address. User mode
+		 * should not be faulting in kernel space, which includes the
+		 * vector/khelper page. Handle the Spectre issues while
+		 * interrupts are still disabled, then send a SIGSEGV. Note
+		 * that __do_user_fault() will enable interrupts.
+		 */
+		harden_branch_predictor();
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+	} else {
+		/*
+		 * Fault from kernel mode. Enable interrupts if they were
+		 * enabled in the parent context. Section (upper page table)
+		 * translation faults are handled via do_translation_fault(),
+		 * so we will only get here for a non-present kernel space
+		 * PTE or kernel space permission fault. Both of these should
+		 * not happen.
+		 */
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
+		__do_kernel_fault(mm, addr, fsr, regs);
+	}
+
+	return 0;
+}
+
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
@@ -272,6 +304,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
+	if (addr >= TASK_SIZE)
+		return do_kernel_address_page_fault(addr, fsr, regs);
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))

... and I think there was a bug in the branch predictor handling -
addr == TASK_SIZE should have been included.

Does this look sensible?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

