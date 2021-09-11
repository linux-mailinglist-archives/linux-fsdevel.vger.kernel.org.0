Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF634074E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhIKDtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45163 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235295AbhIKDta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CFF735C0198;
        Fri, 10 Sep 2021 23:48:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 Sep 2021 23:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=qU+ZIBwcVV+1Z
        RKMVnuvE+6vrYCsfMzo1A5ZRTYTTsk=; b=BG8AXXGuZxJ4Pp4TOAydPGjswfTAB
        K6cmhVG5XVM+klNVzCnRG9CO4wKZNer8y7FIM13lFyWVIzFz3FUyJb51fyuBBdLd
        4cB9yalgupyxL0sM7Xpicoqj+CGnnwSTabPwGwrpYImB7UcdQa341XWP1vDp/tXu
        UnTaoG079XxQnQ4jE64QlXrguHG6dNalj8qd11CqKSITsYmBDLQof/8FF/PH0oA/
        ZJt2n+Q8JByDjTNEHekSWKGjxRVMXJCPU+NgaFb8fhAubHTD+ORymcSmirxXyVWR
        KD/Hfgb0xEEgxBD/38I/1lAYp2KXkyndQz2MWhVkbTnP+1NJz1FuxFgvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=qU+ZIBwcVV+1ZRKMVnuvE+6vrYCsfMzo1A5ZRTYTTsk=; b=T1Tp3tq2
        6YK1epcUDtgnWw1qmMcN+jWfD2br8bPlg/4uWoYXMV8/QXuBG6LIkPa6gq09M2pm
        Y+MDyB0kv4fvSBPWS1weY7w4rSsO32yn7IMMxry0GX5jkykGRGhmKGLGtGXev9K/
        k4aRfVlnJXdISGtJVyErYVzioaTIUXyXM5QvJB77oVTb7NbL++YwA7fmXzPlPuAM
        j9MO3v3wQMd1MEWhITAN6P3XVA87JbNKpfo+GvfJ3f5Nf2p6BaoOsDuxGiq/wF39
        G7HlSmLYvHD0zaMV/18htPyXFtfzIOuX3GIYqEzbFDLqRNOdnIv8pn+iGCt91n7l
        oPbtpSuJ/RVDwA==
X-ME-Sender: <xms:ASc8YSTl0VN59JhMPizn09b5sPLyrmi7V5rfT9M5q5nbf20s0UQR6A>
    <xme:ASc8YXwEYwGq6zp-7DSN9hAZ72x71TAeZVZlEDDAQjl5Sm0g1DKtAF1JatzK4ToBs
    ZxPWNVnmeiNVMRpsUQ>
X-ME-Received: <xmr:ASc8Yf2o4C6N_Ura38NxUJ9u3gFWArqxmqaXV3faE_NnI_u_Pk-GVfVT1hzW1qium0E4U_pt6FG9NMsb17OnFOlNDMvXGk2-dJ5ubM9BrGwEVIJcuPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:ASc8YeCtmkG4hWe4fm8wIKrZaVKz6gik4hyLtt7_GfHuTGJgh-YDQA>
    <xmx:ASc8YbgM161NuBP4EXHAtD5uIKW5WWhYZroPFx9QbbQH52KX4cwz_A>
    <xmx:ASc8YapWhATE72_m72wRQ6fH5s7CPBMd9Qpv6gpnMtf1HQfUmvZOeA>
    <xmx:ASc8YYsnHcneAbuirMBnWi_MyUmV7-cNbgY52nrvTr_tp6xq0iz0JQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:16 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] x86/irq: arch_irq_stat_cpu() returns unsigned int
Date:   Sat, 11 Sep 2021 12:48:04 +0900
Message-Id: <20210911034808.24252-4-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like with PowerPC's version, on x86 the interrupt counters that are
added here are all unsigned int too (see irq_cpustat_t for x86)
as well as mce_exception_count and mce_poll_count.

Summing up unsigned int values into u64 does not "handle" overflows,
but if any of the individual counters overflows then the computed
sum is inaccurate.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 275e7fd20310..461536b45391 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -54,7 +54,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 extern void ack_bad_irq(unsigned int irq);
 
-extern u64 arch_irq_stat_cpu(unsigned int cpu);
+extern unsigned int arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
 extern u64 arch_irq_stat(void);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e28f6a5d14f1..cefe1bc9f42c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -188,9 +188,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 /*
  * /proc/stat helpers
  */
-u64 arch_irq_stat_cpu(unsigned int cpu)
+unsigned int arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = irq_stats(cpu)->__nmi_count;
+	unsigned int sum = irq_stats(cpu)->__nmi_count;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	sum += irq_stats(cpu)->apic_timer_irqs;
-- 
2.25.1

