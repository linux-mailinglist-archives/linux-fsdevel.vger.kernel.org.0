Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0B40CC33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIOSBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:01:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33927 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhIOSAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E1D425C019E;
        Wed, 15 Sep 2021 13:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Sep 2021 13:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=kGSC8LRHOi/rO
        /mTgc4QHdxzMBSlJDij9UWkECnfcxI=; b=FnLEnB21bTZVxIiTYV+qDjDZtvyDV
        t9l8ks59adl7xQcRFGbuwk2XWDqauZC9kkWpzBGCmCckMzmRjx7BAPX1KG95ko9t
        hO2HPqTWozv1Ts0AL6omoOLQ5pwRFPFJKqJFaDT9jhnjFvHhh3K4nK/TsWyJOqOW
        18UPA61zxnffcLQZ+nvtmuVqaSV94pQnTqW0NCsXv+1sz2JKmws+w35zJWWvUcMv
        5h/I3ukquDfA4fr3D1hZjGQwTyIbYXXflvnHTSpQdz56SVjhWlHpeaVsgJDQS3xZ
        dY5IFXO75HfnUhoErtx9c3midLkBLlitc2OvLZ7pb/4uL2hF36sQbygHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kGSC8LRHOi/rO/mTgc4QHdxzMBSlJDij9UWkECnfcxI=; b=ZoqlXhKf
        LMzZwb2IQghLOe9AMw/vMFh8oYvGy2Y42ANFD1LE09HSE4fpzu+Hu8ZHwhfAiGNl
        RSYJ37t093ud7uXYslm0edcsdfM9R5jIFMkUPRRvkzeNrqy7o/iDKES2zCCVFMRX
        gH4TjlXkqf/ln/VcGWoUq2NDpY90UyvZ+eipjvtzry3ODWKzLae3GJTt/bw4e9tW
        9bpuQsvflB4MxgF+3SiHAaxwAndOcs/iSzG2KbTDV7tthZxJ7nq+cCX9XZOwewGB
        /Z9gQLp/y7NRo9Ofw7rzuGxfbTNSjxdms89nzfWcUtylVr+WOUfqVd9vE84ObQtP
        9TXAFTnLQa2tFA==
X-ME-Sender: <xms:aTRCYf0Hf_dGMDlPPRSrCzDMcAmL495tRAsVGADTs4pMZ0qWR-4QQw>
    <xme:aTRCYeHQdY0_NFKTM7ytet7xF8Q0XwilzalLa2vmEIqtzbd6s-JW0SSivc46pqSsQ
    4VkTZ252UPKU90H064>
X-ME-Received: <xmr:aTRCYf5toLlTZZ64cqBBvbwYYloOO9ZzTgx7DZrrnq-05lXch5CHAKAM2LOIhBdUzMgadaHcmuMFb8qJnDdpvDHjCKgHN8Sd4NfixH3s6pfluEfqir4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:aTRCYU11LBuUHww9GvtX7EYFiIkWPFCl1EIxBOhFlnJaQPBjk7txRQ>
    <xmx:aTRCYSHkkKiXWBxHk-MC1lFjc_v6fNrnqQmWlq6qpuojJ4gT9iT6Qg>
    <xmx:aTRCYV9k-V8g9_s9y8pdpQUdsK41OzlYhPwmFd5dDIdaPIxMdefHag>
    <xmx:aTRCYeBW4KxOdMYitQH-4TGKdilAErzQ61lyCBIvpjy6JFq7qlJyZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:04 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/12] x86/irq: Use READ_ONCE for IRQ counter reads
Date:   Thu, 16 Sep 2021 02:58:42 +0900
Message-Id: <20210915175848.162260-7-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like with generic IRQ counters, wrap accesses to counters from
irq_cpustat_t into READ_ONCE to ensure these loads don't get torn.

mce_exception_count and mce_poll_count are also updated by each CPU
independently and we don't want these loads to tear as well.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/kernel/irq.c | 69 ++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e28f6a5d14f1..4ff04ce22eb6 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -62,77 +62,77 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->__nmi_count));
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_timer_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_timer_irqs));
 	seq_puts(p, "  Local timer interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_spurious_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_spurious_count));
 	seq_puts(p, "  Spurious interrupts\n");
 	seq_printf(p, "%*s: ", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_perf_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_perf_irqs));
 	seq_puts(p, "  Performance monitoring interrupts\n");
 	seq_printf(p, "%*s: ", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_irq_work_irqs);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_irq_work_irqs));
 	seq_puts(p, "  IRQ work interrupts\n");
 	seq_printf(p, "%*s: ", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->icr_read_retry_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->icr_read_retry_count));
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
 		seq_printf(p, "%*s: ", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->x86_platform_ipis);
+			seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->x86_platform_ipis));
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
 	seq_printf(p, "%*s: ", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_resched_count));
 	seq_puts(p, "  Rescheduling interrupts\n");
 	seq_printf(p, "%*s: ", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_call_count));
 	seq_puts(p, "  Function call interrupts\n");
 	seq_printf(p, "%*s: ", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_tlb_count));
 	seq_puts(p, "  TLB shootdowns\n");
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
 	seq_printf(p, "%*s: ", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_thermal_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_thermal_count));
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
 	seq_printf(p, "%*s: ", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_threshold_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_threshold_count));
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
 	seq_printf(p, "%*s: ", prec, "DFR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_deferred_error_count);
+		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_deferred_error_count));
 	seq_puts(p, "  Deferred Error APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE
 	seq_printf(p, "%*s: ", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_exception_count, j));
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(mce_exception_count, j)));
 	seq_puts(p, "  Machine check exceptions\n");
 	seq_printf(p, "%*s: ", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
+		seq_printf(p, "%10u ", READ_ONCE(per_cpu(mce_poll_count, j)));
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
@@ -140,7 +140,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s: ", prec, "HYP");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_callback_count);
+				READ_ONCE(irq_stats(j)->irq_hv_callback_count));
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
@@ -149,14 +149,14 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s: ", prec, "HRE");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_reenlightenment_count);
+				READ_ONCE(irq_stats(j)->irq_hv_reenlightenment_count));
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
 	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
 		seq_printf(p, "%*s: ", prec, "HVS");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
-				   irq_stats(j)->hyperv_stimer0_count);
+				READ_ONCE(irq_stats(j)->hyperv_stimer0_count));
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
 #endif
@@ -167,19 +167,20 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #ifdef CONFIG_HAVE_KVM
 	seq_printf(p, "%*s: ", prec, "PIN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kvm_posted_intr_ipis);
+		seq_printf(p, "%10u ",
+			READ_ONCE(irq_stats(j)->kvm_posted_intr_ipis));
 	seq_puts(p, "  Posted-interrupt notification event\n");
 
 	seq_printf(p, "%*s: ", prec, "NPI");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_nested_ipis);
+			READ_ONCE(irq_stats(j)->kvm_posted_intr_nested_ipis));
 	seq_puts(p, "  Nested posted-interrupt event\n");
 
 	seq_printf(p, "%*s: ", prec, "PIW");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
+			READ_ONCE(irq_stats(j)->kvm_posted_intr_wakeup_ipis));
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
 	return 0;
@@ -190,30 +191,30 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 u64 arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = irq_stats(cpu)->__nmi_count;
+	u64 sum = READ_ONCE(irq_stats(cpu)->__nmi_count);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	sum += irq_stats(cpu)->apic_timer_irqs;
-	sum += irq_stats(cpu)->irq_spurious_count;
-	sum += irq_stats(cpu)->apic_perf_irqs;
-	sum += irq_stats(cpu)->apic_irq_work_irqs;
-	sum += irq_stats(cpu)->icr_read_retry_count;
+	sum += READ_ONCE(irq_stats(cpu)->apic_timer_irqs);
+	sum += READ_ONCE(irq_stats(cpu)->irq_spurious_count);
+	sum += READ_ONCE(irq_stats(cpu)->apic_perf_irqs);
+	sum += READ_ONCE(irq_stats(cpu)->apic_irq_work_irqs);
+	sum += READ_ONCE(irq_stats(cpu)->icr_read_retry_count);
 	if (x86_platform_ipi_callback)
-		sum += irq_stats(cpu)->x86_platform_ipis;
+		sum += READ_ONCE(irq_stats(cpu)->x86_platform_ipis);
 #endif
 #ifdef CONFIG_SMP
-	sum += irq_stats(cpu)->irq_resched_count;
-	sum += irq_stats(cpu)->irq_call_count;
+	sum += READ_ONCE(irq_stats(cpu)->irq_resched_count);
+	sum += READ_ONCE(irq_stats(cpu)->irq_call_count);
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	sum += irq_stats(cpu)->irq_thermal_count;
+	sum += READ_ONCE(irq_stats(cpu)->irq_thermal_count);
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	sum += irq_stats(cpu)->irq_threshold_count;
+	sum += READ_ONCE(irq_stats(cpu)->irq_threshold_count);
 #endif
 #ifdef CONFIG_X86_MCE
-	sum += per_cpu(mce_exception_count, cpu);
-	sum += per_cpu(mce_poll_count, cpu);
+	sum += READ_ONCE(per_cpu(mce_exception_count, cpu));
+	sum += READ_ONCE(per_cpu(mce_poll_count, cpu));
 #endif
 	return sum;
 }
-- 
2.25.1

