Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB064074E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhIKDtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33153 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233549AbhIKDt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 22ABE5C00B1;
        Fri, 10 Sep 2021 23:48:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 Sep 2021 23:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=saIJQDFIkap8K
        f5WlETLRZ3iX43zsd8TcVVo9ME/MBw=; b=kRaJptlraeVFr/GR0fy50S2lJqaGa
        ovyy6dSPPsicn5x8nZuKhh868tseeqVOyKynjtqUh/dS2IdxuctRm/RfQILbI9nA
        pzxdX0b5SSRIbfrmQZB1b5jv9MHAi+Smm0G5Ai4Vwk1ZTpdS01OZr2hX5sKX6qwf
        a764AjXJGbmuoqNP3HhNzkGhl7aoivzEk3jpas/gl+cM0kvXxMDZ9TRLGRYMW3ON
        edW1e7r8s6W5DtWMK4w11ZfsPsRq5LN4f458vrnO2vuaEYvRwDF9oLl0DHg1NR66
        4k2MRphpBATObdCT3Mzs8xOSFcFDksl5KrfDwD5npooFk7UWtFEzj7kJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=saIJQDFIkap8Kf5WlETLRZ3iX43zsd8TcVVo9ME/MBw=; b=TSwvYq7g
        2de91ps2k5vfhlxH0GaC9+CQrUrqJwmdBVcGbybSvo6ydPJvMSFsybjFkKWHJfZt
        ElDQCllJO3/7ZTxJhig566xY6A3WhdFH2/2X464wfd6GiulqYZcNeeqos49ycgHG
        EZ+2JpGkwFbjZc5DkxUtjYJb3d8LINnpf0Gek5f7heg2G9D6d6Cg7JDaP5FFIpLE
        Hnv/GDXbSBlU5d1+5c+8Fv8uUCPIQsYI6rJCx5TqIyiuLsf+h+MPLUfhzNjz+8ML
        QN5Wrqk68QcsJsiGpQsqKF3eQUJFUOePCe2Ql89p7FgrsTXrtQotflKZ5gPzsUp3
        mtmGZoEMnOhBZg==
X-ME-Sender: <xms:_yY8YSeKbT9hylo60zCg22yhYnA7c4oALDZX1S9Rpg7aloMqEYNe0w>
    <xme:_yY8YcP4rOEfNkJcaKdlW5EUPyyPNHoC73WoBdpm406IxVuHMai0up0g9VSgX9X-v
    yNs6RhINcf8XRpC5_c>
X-ME-Received: <xmr:_yY8YTh1SeOxrSaLs5C8P0y8NkaQDLYbZR6fT709scVvWvK-M4hUUdfo-FKrcWz8v3124V5oZB3DgOUduvVqQS7vgBCj3oTuRcWDiabPbzIIWQRZDWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:_yY8Yf-kGqpIhLwvadlDNBtaao7oi9fVAVS0oJ8xBuDd43tmvqQ0ug>
    <xmx:_yY8Yese7dbikJkWsQ1CKLHqlGbrtlL7ZXkHOhTHWVLo2IrOAvunYg>
    <xmx:_yY8YWHoR1hVi4YGx9CNbqSI5_7szKZdOHLLNNDw0-YOZvQcrjcDRQ>
    <xmx:ACc8YSKZRsXys1Nm6Z1qdwD0Be_mrfeiF5ah2oKr16tcp8a9FeK5ZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:14 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/irq: arch_irq_stat_cpu() returns unsigned int
Date:   Sat, 11 Sep 2021 12:48:03 +0900
Message-Id: <20210911034808.24252-3-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interrupt counters this function sums up are all unsigned int
(see irq_cpustat_t). If the sum overflows, so be it: you should
monitor the counter and take note when it wraps around.

Summing up unsigned int values into u64 does not "handle" overflows,
but if any of the individual counters overflows then the computed
sum is inaccurate.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/powerpc/include/asm/hardirq.h | 2 +-
 arch/powerpc/kernel/irq.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f133b5930ae1..5248adcb50b4 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -32,7 +32,7 @@ static inline void ack_bad_irq(unsigned int irq)
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 
-extern u64 arch_irq_stat_cpu(unsigned int cpu);
+extern unsigned int arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
 #endif /* _ASM_POWERPC_HARDIRQ_H */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 551b653228c4..a100c967892e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -645,9 +645,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 /*
  * /proc/stat helpers
  */
-u64 arch_irq_stat_cpu(unsigned int cpu)
+unsigned int arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
+	unsigned int sum = per_cpu(irq_stat, cpu).timer_irqs_event;
 
 	sum += per_cpu(irq_stat, cpu).broadcast_irqs_event;
 	sum += per_cpu(irq_stat, cpu).pmu_irqs;
-- 
2.25.1

