Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5340CC22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhIOSAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37829 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231226AbhIOSAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C32665C0107;
        Wed, 15 Sep 2021 13:58:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 15 Sep 2021 13:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EF1oYjj7htZa6
        XszZLPpL5WxtqliOlfc5Q/ZUqAMH78=; b=AhL/Ij84sqnb1Jy4hDi1DmhojaCYk
        GQ8WJCjOKL4tHQd34KhQ+fF1FLk3HMXr1C7/7VSbJ1mK52tZ2zL9URKgAHnRt2MJ
        J5RPCMvBYCqKEDSrltgw2y09ffONlQnbgbEFpQ87tYq4zM0oGrlmnAeeSKN5s8Pf
        Xb8BM5POnyFPmnVah/9Dx94I9nfzCQDjvYALhOZJZlogjVu8WF9zhfqtqVA2oK7V
        lJyd2izsQUItnUsqFAm3shjkbgH+rhSRMHs2bb4WV7IJYDEKvWVJmO9owdFQPV2U
        aykMQVqlvquCmUx9BqjUJSG/HqEc69eHyIsJ0+2DLaLVQTtbtVSJ0u5Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EF1oYjj7htZa6XszZLPpL5WxtqliOlfc5Q/ZUqAMH78=; b=Rtp0y0QO
        6U2gdMzwdWOzsklGQvIP8rV/0HhMu4OMuOoPFelpi3EgJucR2V8ibdrw8wPpkF8r
        qmMSlcB1TnYdi5CyPYnPtdFm0K3mCVs4AAn+q9fPRds42SqGgPEi1xmIhE5KB8ih
        Jgnd8/sDrVbij1c+xqeGUtoaCueTsaNho9QSq8yp8ao/9zDR85D4v+r7NkZsGfkg
        C+fSe8jrbW9RoxuE1EcAVqu1fjE8zMOozb/qdkst6kSv+/7qs4cb+9CRePbkeO42
        2DlbBizBaKj2iB4aH4RvzOMGYqQ3pGeUWykE4MI3jOVuoPZVmyVIc0AvHrb5CQrV
        XHNpfznUM0I6Ug==
X-ME-Sender: <xms:YzRCYczgdDmPUppBr1g3EXzdO_LuQWuHBEshFbStw63YwWivXWJCbQ>
    <xme:YzRCYQQbweQpxCs9q-stW8TtMLrZCV0Xy9sQeWB4GmGwDUrZdEAKaKJdPbgypYXtF
    o4ihOPLkBIzIDqbuIs>
X-ME-Received: <xmr:YzRCYeVwjjuRT7H6tyj-mCKCnJaMDPCDIVpaLeVIynpk6q4xQ_qWKM1a94ZXFZ5k1OmRKm3_2oeUDh8zoDpRVplSuNipTXvoTPIkrAPVrjXtI66S58s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:YzRCYag7E0NNedX5fe3hBMCK3ogg37znNWC6bk0gdDNUUZp3XNo1Og>
    <xmx:YzRCYeAa7cGkinSqquhJakk5t7JocyzWK2tLGS37O6n9OZwdoPvDGQ>
    <xmx:YzRCYbJNgB9eG_sByfhyy9GwjO6IU8oNVf0uI63SKEmaHy6A991p4w>
    <xmx:YzRCYZP3LW7HuAc21UwsBpnAuzF2V6nmSDSRaPChI7yPEc9b_wnl5A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:58:57 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/12] powerpc/irq: Use READ_ONCE for IRQ counter reads
Date:   Thu, 16 Sep 2021 02:58:39 +0900
Message-Id: <20210915175848.162260-4-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like with generic IRQ counters in the previous commit,
wrap accesses to per-CPU counters from irq_cpustat_t in READ_ONCE.
Grab that one "hmi_irqs" oddball from struct paca_struct as well.
These memory loads should not be torn, let's make it explicit.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/powerpc/kernel/irq.c | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 551b653228c4..e5082d8be700 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -581,52 +581,52 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_event);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_event));
         seq_printf(p, "  Local timer interrupts for timer event device\n");
 
 	seq_printf(p, "%*s: ", prec, "BCT");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).broadcast_irqs_event);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).broadcast_irqs_event));
 	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
 
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_others);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_others));
         seq_printf(p, "  Local timer interrupts for others\n");
 
 	seq_printf(p, "%*s: ", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).spurious_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).spurious_irqs));
 	seq_printf(p, "  Spurious interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).pmu_irqs));
 	seq_printf(p, "  Performance monitoring interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).mce_exceptions));
 	seq_printf(p, "  Machine check exceptions\n");
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		seq_printf(p, "%*s: ", prec, "HMI");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", paca_ptrs[j]->hmi_irqs);
+			seq_printf(p, "%10u ", READ_ONCE(paca_ptrs[j]->hmi_irqs));
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 #endif
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).sreset_irqs));
 	seq_printf(p, "  System Reset interrupts\n");
 
 #ifdef CONFIG_PPC_WATCHDOG
 	seq_printf(p, "%*s: ", prec, "WDG");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).soft_nmi_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).soft_nmi_irqs));
 	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
 #endif
 
@@ -634,7 +634,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		seq_printf(p, "%*s: ", prec, "DBL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, j).doorbell_irqs);
+			seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).doorbell_irqs));
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
@@ -647,22 +647,22 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 u64 arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
+	u64 sum = READ_ONCE(per_cpu(irq_stat, cpu).timer_irqs_event);
 
-	sum += per_cpu(irq_stat, cpu).broadcast_irqs_event;
-	sum += per_cpu(irq_stat, cpu).pmu_irqs;
-	sum += per_cpu(irq_stat, cpu).mce_exceptions;
-	sum += per_cpu(irq_stat, cpu).spurious_irqs;
-	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).broadcast_irqs_event);
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).pmu_irqs);
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).mce_exceptions);
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).spurious_irqs);
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).timer_irqs_others);
 #ifdef CONFIG_PPC_BOOK3S_64
-	sum += paca_ptrs[cpu]->hmi_irqs;
+	sum += READ_ONCE(paca_ptrs[cpu]->hmi_irqs);
 #endif
-	sum += per_cpu(irq_stat, cpu).sreset_irqs;
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).sreset_irqs);
 #ifdef CONFIG_PPC_WATCHDOG
-	sum += per_cpu(irq_stat, cpu).soft_nmi_irqs;
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).soft_nmi_irqs);
 #endif
 #ifdef CONFIG_PPC_DOORBELL
-	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
+	sum += READ_ONCE(per_cpu(irq_stat, cpu).doorbell_irqs);
 #endif
 
 	return sum;
-- 
2.25.1

