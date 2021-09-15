Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91C40CC2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhIOSAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46851 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhIOSA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 01C035C0195;
        Wed, 15 Sep 2021 13:59:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 Sep 2021 13:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=9knqoN2a0SJIB
        wSAS5DQkKkV5ouK+9JQaaJs3/U0e/Y=; b=jPyitBQSRpzcLfDKpfPyZcUppYU1W
        aCQ5dei3FLIXys+akqanclPfmkIK59lICx56BrrEpZhMza2FkCSnrBY25ZA5CF6Q
        oO92o7VfwG5QsQO0FrzHfWOrraLwnhN6RiNKTB//duPh23Gzl3vREpzccrD/R3uH
        7BK7z2r1YEFHk5WdqEjDSYt5/S2A2tb7Hy19IY4sLbv7hn3wQ5H72J8ZUzXx7RI+
        V6OLhr054KKhgjd7U+gzZ1J9AGc4g1dl51LjPo9yVmQamPMX5ozcTkx1NBgzpkZZ
        6vCvXkBe/tLLhNlTBuHu/UXqvdVBQy+yMAbM3UoH59YvfGjW8N7FNMchA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9knqoN2a0SJIBwSAS5DQkKkV5ouK+9JQaaJs3/U0e/Y=; b=DcBWycYo
        +E6Qoe9wH/wY4nOqrT8NiZARd3bHn6eJjRJJD3gtyJKuKpUBp2IyE/br3l37av/u
        Ae3afH5sg9SaJxihSDLxm6gi6oUwXS8N1ph/0cyBG6rUyDFsvNuncHere1pm4GhW
        KRSpPQJHPxTvlZsUpFKAT6mfHk5/S2bkrsJk/SD5I01035COUSnThMRCQehYEf3c
        ERBSDwU4n+2I7iMclT2Zv1FlErpLuc1iexlVRJcZ3L3YmMlF35HtU0w3NsrcN2Vm
        T4MdpaMJr7SI4WLD5AgR1yp/SY/7+PsVd27L1FI3Pi7us/fdv8Zhu9i64CryNbM0
        CltncQdNnlltGg==
X-ME-Sender: <xms:azRCYe7edMxCRrIW7_F2YGzFto8mtDHET0m9N8il24XfeijoWOQuxw>
    <xme:azRCYX7baj1bz2jU0OU7gryusG1hAWRuyJM-00BVCHvT5PtgYScnA4l7tWwrDTNns
    xrVmYIW5H4Rk96ZvIU>
X-ME-Received: <xmr:azRCYdcAO7s6w8tugNh5Y4S3KSFBm7ewtXxl0tNiNxs4sEXpM6rsVAzJEqEX7JenO2lJF6C7dQSFW409OyCm_4OdTWtiIlH2274e1gl-H0E4OXv_NZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:azRCYbLx9zerW7ZiJI8IK5JY2Ct8WfB1Qb9Ec8ABsY3rBgDOUxaPsQ>
    <xmx:azRCYSKZEwAplJDLqjzWaSMMNNm0R_Kv7YCzTJ2d-t5Xwi24uF7TlQ>
    <xmx:azRCYcxbK8ynRJWhwzYdKwB_t5ONnd4PioW8J8F7HzdsPuqUm3GKlw>
    <xmx:azRCYe3uvh3Ya3Obsl95ZOCtSxdQ-ujOYU_qHZ5dVBnqqffgA7PyNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:06 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/12] x86/irq: Use unsigned long for IRQ counters
Date:   Thu, 16 Sep 2021 02:58:43 +0900
Message-Id: <20210915175848.162260-8-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to PowerPC in the previous patches, bump the counters from
irq_cpustat_t to a wider type for better wrap around handling on x86_64.
Not all of them, just the ones reported via procfs.

Also grab mce_exception_count and mce_poll_count which are reported
along with counters from irq_cpustat_t.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/include/asm/hardirq.h | 22 +++++++++++-----------
 arch/x86/include/asm/mce.h     |  4 ++--
 arch/x86/kernel/cpu/mce/core.c |  4 ++--
 arch/x86/kernel/irq.c          | 26 +++++++++++++-------------
 4 files changed, 28 insertions(+), 28 deletions(-)

So, about the "not all of them" part. What about all other counters that
are present in irq_cpustat_t, printed out by arch_show_interrupts() for
/proc/interrupts, but are not included in arch_irq_stat_cpu() and don't
show up in total counter of /proc/stat?

These ones:

    kvm_posted_intr_ipis
    kvm_posted_intr_wakeup_ipis
    kvm_posted_intr_nested_ipis
    irq_tlb_count
    irq_deferred_error_count
    irq_hv_callback_count
    irq_hv_reenlightenment_count
    hyperv_stimer0_count

I have a feeling they should be included into the total interrupt
counter sum (and be widened to unsigned long as well). Should they?

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 275e7fd20310..2dc9c076f611 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -9,30 +9,30 @@ typedef struct {
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
-	unsigned int __nmi_count;	/* arch dependent */
+	unsigned long __nmi_count;		/* arch dependent */
 #ifdef CONFIG_X86_LOCAL_APIC
-	unsigned int apic_timer_irqs;	/* arch dependent */
-	unsigned int irq_spurious_count;
-	unsigned int icr_read_retry_count;
+	unsigned long apic_timer_irqs;		/* arch dependent */
+	unsigned long irq_spurious_count;
+	unsigned long icr_read_retry_count;
 #endif
 #ifdef CONFIG_HAVE_KVM
 	unsigned int kvm_posted_intr_ipis;
 	unsigned int kvm_posted_intr_wakeup_ipis;
 	unsigned int kvm_posted_intr_nested_ipis;
 #endif
-	unsigned int x86_platform_ipis;	/* arch dependent */
-	unsigned int apic_perf_irqs;
-	unsigned int apic_irq_work_irqs;
+	unsigned long x86_platform_ipis;	/* arch dependent */
+	unsigned long apic_perf_irqs;
+	unsigned long apic_irq_work_irqs;
 #ifdef CONFIG_SMP
-	unsigned int irq_resched_count;
-	unsigned int irq_call_count;
+	unsigned long irq_resched_count;
+	unsigned long irq_call_count;
 #endif
 	unsigned int irq_tlb_count;
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	unsigned int irq_thermal_count;
+	unsigned long irq_thermal_count;
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	unsigned int irq_threshold_count;
+	unsigned long irq_threshold_count;
 #endif
 #ifdef CONFIG_X86_MCE_AMD
 	unsigned int irq_deferred_error_count;
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..65776c6a8478 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -255,8 +255,8 @@ bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
 int mce_usable_address(struct mce *m);
 
-DECLARE_PER_CPU(unsigned, mce_exception_count);
-DECLARE_PER_CPU(unsigned, mce_poll_count);
+DECLARE_PER_CPU(unsigned long, mce_exception_count);
+DECLARE_PER_CPU(unsigned long, mce_poll_count);
 
 typedef DECLARE_BITMAP(mce_banks_t, MAX_NR_BANKS);
 DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..38d418913a8f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -63,7 +63,7 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 
 #define SPINUNIT		100	/* 100ns */
 
-DEFINE_PER_CPU(unsigned, mce_exception_count);
+DEFINE_PER_CPU(unsigned long, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
@@ -718,7 +718,7 @@ static void mce_read_aux(struct mce *m, int i)
 	}
 }
 
-DEFINE_PER_CPU(unsigned, mce_poll_count);
+DEFINE_PER_CPU(unsigned long, mce_poll_count);
 
 /*
  * Poll for corrected events or events that happened before reset.
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 4ff04ce22eb6..9e47c2dd7ef9 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -62,45 +62,45 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->__nmi_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->__nmi_count));
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_timer_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->apic_timer_irqs));
 	seq_puts(p, "  Local timer interrupts\n");
 
 	seq_printf(p, "%*s: ", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_spurious_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->irq_spurious_count));
 	seq_puts(p, "  Spurious interrupts\n");
 	seq_printf(p, "%*s: ", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_perf_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->apic_perf_irqs));
 	seq_puts(p, "  Performance monitoring interrupts\n");
 	seq_printf(p, "%*s: ", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->apic_irq_work_irqs));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->apic_irq_work_irqs));
 	seq_puts(p, "  IRQ work interrupts\n");
 	seq_printf(p, "%*s: ", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->icr_read_retry_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->icr_read_retry_count));
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
 		seq_printf(p, "%*s: ", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->x86_platform_ipis));
+			seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->x86_platform_ipis));
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
 	seq_printf(p, "%*s: ", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_resched_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->irq_resched_count));
 	seq_puts(p, "  Rescheduling interrupts\n");
 	seq_printf(p, "%*s: ", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_call_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->irq_call_count));
 	seq_puts(p, "  Function call interrupts\n");
 	seq_printf(p, "%*s: ", prec, "TLB");
 	for_each_online_cpu(j)
@@ -110,13 +110,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #ifdef CONFIG_X86_THERMAL_VECTOR
 	seq_printf(p, "%*s: ", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_thermal_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->irq_thermal_count));
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
 	seq_printf(p, "%*s: ", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(irq_stats(j)->irq_threshold_count));
+		seq_printf(p, "%10lu ", READ_ONCE(irq_stats(j)->irq_threshold_count));
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
@@ -128,11 +128,11 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #ifdef CONFIG_X86_MCE
 	seq_printf(p, "%*s: ", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(mce_exception_count, j)));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(mce_exception_count, j)));
 	seq_puts(p, "  Machine check exceptions\n");
 	seq_printf(p, "%*s: ", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", READ_ONCE(per_cpu(mce_poll_count, j)));
+		seq_printf(p, "%10lu ", READ_ONCE(per_cpu(mce_poll_count, j)));
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
-- 
2.25.1
