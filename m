Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691D640CC24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhIOSAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50243 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhIOSAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CECD15C0191;
        Wed, 15 Sep 2021 13:59:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Sep 2021 13:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mhDh2bMN6vNYF
        HW709Q+YxRJXG1Exmn0B+3XD/1C9FA=; b=iPOvJc9n8gj1e8jVt49aFBICJdS7Y
        /bzxrf9/MNyMm8bOqk6LxvmajE3wWxCghpHD1mfZ21PsEIiKlfN7o8eJJ/w2c7Dq
        gHZEdypZrxS3fEmhwWqymzmf1yW4xhsrP6zfBVijVaEdHVLyeRnVxUNTU76kYews
        FFsmaoPjypKMtcIVgFNujMNJrgbGRMTdiZWPbSwqpsKPm0ClM9qHtf9XOcc5umb6
        XvVqA4EXL9sS3UHykTzl/oCibPUPGjR30Ia/2EGPmKjOdeQIIbfmnf86k7dRDYrK
        I7dNF6c0O4mU9xgZO4cM8VPhfrsKeruu81vHPMsgfK6ALJjbK2nlwL0Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mhDh2bMN6vNYFHW709Q+YxRJXG1Exmn0B+3XD/1C9FA=; b=ZxCn4GFd
        wdJgHLLOLzdI3SphEfI30G8lZmBYoBYkN5rNwBInclspvW5Er4h2KX9+P9nK5u8f
        1LWyzPRJhUTpyIyMeRIU4X0GSWiMvywQE8vBiKnYoJrKeBH/7oze+u/uQ4WR1HH2
        0rFRx26VI8ekPS2TwD29GkqmM2oY9P8OjlRSAiiqa7wLSu0laJIRKE2otedK4hqQ
        huUaHrCh2Eaf/Vj+3YbW8ZwK4xXeg8vNQV8KR7imfgK+x++r7KFtzrhMIISyCUEF
        O6X6TijvTfGz24HK4/b82m05Q1YwC6bgyxJGt17vU3K8aF62J1Ioe3ae8on4kOaS
        DIKd2yybL9zhnw==
X-ME-Sender: <xms:ZTRCYZZD35N4nI172IecB8O_J8LY7SlQLn9MPQyyDj3_H9HH1kAt3A>
    <xme:ZTRCYQanBjfhAedcyBa2rKaGXN7dMoxgryLO9mwRAhQYbwrmIh8uc28ws5rhV9TK-
    j6loX6mYapglQpBR50>
X-ME-Received: <xmr:ZTRCYb_ZzIy1DjSrbxU37kOb9oILKb5vjzZXBxVFcZ03EOUsfoVjJzCWKXjNnUTAwZq56Db8GJQgpe3AvIVZ-2rUT-GsGnHia52ivmbBzIcR1MxDAdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:ZTRCYXq80aHBP0NTlXM3HL2myzlSJDEX5wBVNvgCenjX_yWtsjKKfw>
    <xmx:ZTRCYUqgXh7tsZ4JBwnqEzADNaJHEJtSFVng05Qgm0WiieN8dCfhkg>
    <xmx:ZTRCYdRXa2PHytvXSV011nrMV2XxQr070g_Qw06nLk-aPS9XS0Xh4Q>
    <xmx:ZTRCYfVjr7_9q_cLDzTydVur7GqzTDD8rwPVJn6uEruXIXetumKJiw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:58:59 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/12] powerpc/irq: Use unsigned long for IRQ counters
Date:   Thu, 16 Sep 2021 02:58:40 +0900
Message-Id: <20210915175848.162260-5-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Widen individual counters from irq_cpustat_t to unsigned long. This
makes their overflow virtually impossible within reasonable time on
PowerPC64.

Switch "hmi_irqs" in paca to unsigned long as well since it's going
to be summed up with all those other counters and it must have the
same width for the addition to wrap around correctly.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/powerpc/include/asm/hardirq.h | 18 +++++++++---------
 arch/powerpc/include/asm/paca.h    |  2 +-
 arch/powerpc/kernel/irq.c          | 20 ++++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f133b5930ae1..efc5391f84fb 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -7,18 +7,18 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int timer_irqs_event;
-	unsigned int broadcast_irqs_event;
-	unsigned int timer_irqs_others;
-	unsigned int pmu_irqs;
-	unsigned int mce_exceptions;
-	unsigned int spurious_irqs;
-	unsigned int sreset_irqs;
+	unsigned long timer_irqs_event;
+	unsigned long broadcast_irqs_event;
+	unsigned long timer_irqs_others;
+	unsigned long pmu_irqs;
+	unsigned long mce_exceptions;
+	unsigned long spurious_irqs;
+	unsigned long sreset_irqs;
 #ifdef CONFIG_PPC_WATCHDOG
-	unsigned int soft_nmi_irqs;
+	unsigned long soft_nmi_irqs;
 #endif
 #ifdef CONFIG_PPC_DOORBELL
-	unsigned int doorbell_irqs;
+	unsigned long doorbell_irqs;
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dc05a862e72a..97d78fcf5529 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -230,7 +230,7 @@ struct paca_struct {
 	u16 in_mce;
 	u8 hmi_event_available;		/* HMI event is available */
 	u8 hmi_p9_special_emu;		/* HMI P9 special emulation */
-	u32 hmi_irqs;			/* HMI irq stat */
+	unsigned long hmi_irqs;		/* HMI irq stat */
 #endif
 	u8 ftrace_enabled;		/* Hard disable ftrace */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e5082d8be700..9f39de114a0e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -581,52 +581,52 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_event));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_event));
         seq_printf(p, "  Local timer interrupts for timer event device\n");
 
 	seq_printf(p, "%*s: ", prec, "BCT");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).broadcast_irqs_event));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).broadcast_irqs_event));
 	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
 
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_others));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).timer_irqs_others));
         seq_printf(p, "  Local timer interrupts for others\n");
 
 	seq_printf(p, "%*s: ", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).spurious_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).spurious_irqs));
 	seq_printf(p, "  Spurious interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).pmu_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).pmu_irqs));
 	seq_printf(p, "  Performance monitoring interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).mce_exceptions));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).mce_exceptions));
 	seq_printf(p, "  Machine check exceptions\n");
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		seq_printf(p, "%*s: ", prec, "HMI");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", READ_ONCE(paca_ptrs[j]->hmi_irqs));
+			seq_printf(p, "%10lu ", READ_ONCE(paca_ptrs[j]->hmi_irqs));
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 #endif
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).sreset_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).sreset_irqs));
 	seq_printf(p, "  System Reset interrupts\n");
 
 #ifdef CONFIG_PPC_WATCHDOG
 	seq_printf(p, "%*s: ", prec, "WDG");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).soft_nmi_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).soft_nmi_irqs));
 	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
 #endif
 
@@ -634,7 +634,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		seq_printf(p, "%*s: ", prec, "DBL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", READ_ONCE(per_cpu(irq_stat, j).doorbell_irqs));
+			seq_printf(p, "%10lu ", READ_ONCE(per_cpu(irq_stat, j).doorbell_irqs));
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
-- 
2.25.1

