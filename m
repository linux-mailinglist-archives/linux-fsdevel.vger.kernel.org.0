Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEC40CC31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhIOSBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:01:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45421 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231397AbhIOSA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 07B7B5C01A9;
        Wed, 15 Sep 2021 13:59:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 Sep 2021 13:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=j/pVif0xC3YoC
        SLChBtt/dSwBkWOK8HluzLcTq6fSjw=; b=opE9LIMwmE2DJtNV0rVjJFyebCARl
        oXsQzCmlwOP1oB1vHN4rIfRvstgDPejKpP28GXGb7PsDPgyzW1L4LIjqkPP4GoN1
        erpvzi6W/JOA3lOw5kD9XU6G24g+9wn2aXKUvxzhCPou38v72O2PpItBaGMv28Uy
        P9u/oJdL6fnaCWhYq8JMXe90X+Xx5jU2vj6jo9/tnrUVrZkBMxLVktAcgWyUKD7B
        jtSwTX/Cawu5X+e/8s1o128sX9XvJwxvGsDUmAHJl6VtKP2AT4ttzQriCzdUgw1h
        a0IQZQ5VqwzzskYQKOh63lvTCOtvxN6OK4Ens66u9oO/45H+RFa2IAFVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=j/pVif0xC3YoCSLChBtt/dSwBkWOK8HluzLcTq6fSjw=; b=chK5pLPz
        NSnYXc61RO3grCXVzHuHpZO+wWXRWAB61w36XDJmpt7XFwepuKjOBeLKSpPqjjOk
        I/C1Q+dN1bcJnV8rxkq8LUXBgfcyfre665YMDfFRSGbNIst47gDYY93MpwbjU3um
        Yh7b0nr5DZO3keBOkdOxWdEAWZkWRv8S3aVAO3kkNxQoQtAFgXsMlKaBmlukDbqO
        0CAUCS9YSjSU57NIf/N/Z6bau+tPKASozjFsMsWTy2cR8XeVXrntfm1L9KcLFosv
        /7CZ4/4rxpiSM3I9MzfLTpnwBaqOUsdE0KHHXCqfSBF9HqaLVVnHlcJMiFqIzlJh
        fBYOAqYnJzK5YQ==
X-ME-Sender: <xms:bTRCYbvs72tY6IzJHjchkJ_d-JW4R5_yx_YbqQr3UXEakGIE7r2N0g>
    <xme:bTRCYcfpMTJYcMMtnXJpziqy7wnjsM30iMmweCknSQmmSAib6Yo8yOL3Y07rWBk5s
    rQXU2FmxQIZzm-o6XE>
X-ME-Received: <xmr:bTRCYeyrHUQPG8eMY_H7YTYTaB2BSP7kSgbDoRYsujWc_dDiowYgZJr7l1_YfF6L1_b8ny6XSYY-NdWqzbyVV9DJd-zzgLWvQ6cw2fzM7wDCKLiBR-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:bTRCYaOnixOajJqrBfViMJ4ONfPzjbSoAFltnmq-JxlEo7ZhHQ1w5w>
    <xmx:bTRCYb-Wmute8T0ImqP6Gqb6OIE_ui3DO0yFxTfUESZBIY0IqG5VqQ>
    <xmx:bTRCYaVlPE_3-_HFZzG8Nbqx9l6IZyASkGiaAGJaQxexSM5j_BaZvA>
    <xmx:bjRCYeb6a8uotHBl7svnxvS_VD9-sTtv3J9_DA8R7_HKr81Dy_SDwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:08 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/12] x86/irq: Use unsigned long for IRQ counters more
Date:   Thu, 16 Sep 2021 02:58:44 +0900
Message-Id: <20210915175848.162260-9-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two stand aside since they are atomic_t and all, but these
counters are also reported by procfs and included into the total
interrupt count. Make them unsigned long as well.

Strictly speaking, only irq_err_count is reported in the totals,
but I felt bad for its friend to miss out on becoming wiiiiider.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/include/asm/hw_irq.h  | 4 ++--
 arch/x86/kernel/apic/apic.c    | 2 +-
 arch/x86/kernel/apic/io_apic.c | 4 ++--
 arch/x86/kernel/i8259.c        | 2 +-
 arch/x86/kernel/irq.c          | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..684310f723ac 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -111,8 +111,8 @@ static inline void unlock_vector_lock(void) {}
 #endif	/* CONFIG_X86_LOCAL_APIC */
 
 /* Statistics */
-extern atomic_t irq_err_count;
-extern atomic_t irq_mis_count;
+extern atomic_long_t irq_err_count;
+extern atomic_long_t irq_mis_count;
 
 extern void elcr_set_level_irq(unsigned int irq);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d262811ce14b..d0add3f1841b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2220,7 +2220,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 		apic_write(APIC_ESR, 0);
 	v = apic_read(APIC_ESR);
 	ack_APIC_irq();
-	atomic_inc(&irq_err_count);
+	atomic_long_inc(&irq_err_count);
 
 	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
 		    smp_processor_id(), v);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 39224e035e47..038737f5fb88 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1693,7 +1693,7 @@ static unsigned int startup_ioapic_irq(struct irq_data *data)
 	return was_pending;
 }
 
-atomic_t irq_mis_count;
+atomic_long_t irq_mis_count;
 
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 static bool io_apic_level_ack_pending(struct mp_chip_data *data)
@@ -1835,7 +1835,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 	 * at the cpu.
 	 */
 	if (!(v & (1 << (i & 0x1f)))) {
-		atomic_inc(&irq_mis_count);
+		atomic_long_inc(&irq_mis_count);
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 282b4ee1339f..7ef2facea165 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -211,7 +211,7 @@ static void mask_and_ack_8259A(struct irq_data *data)
 			       "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
-		atomic_inc(&irq_err_count);
+		atomic_long_inc(&irq_err_count);
 		/*
 		 * Theoretically we do not have to handle this IRQ,
 		 * but in Linux this does not cause problems and is
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9e47c2dd7ef9..6e7c6b4cebc1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -29,7 +29,7 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-atomic_t irq_err_count;
+atomic_long_t irq_err_count;
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -160,9 +160,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
 #endif
-	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
+	seq_printf(p, "%*s: %10lu\n", prec, "ERR", atomic_long_read(&irq_err_count));
 #if defined(CONFIG_X86_IO_APIC)
-	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
+	seq_printf(p, "%*s: %10lu\n", prec, "MIS", atomic_long_read(&irq_mis_count));
 #endif
 #ifdef CONFIG_HAVE_KVM
 	seq_printf(p, "%*s: ", prec, "PIN");
@@ -221,7 +221,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 
 u64 arch_irq_stat(void)
 {
-	u64 sum = atomic_read(&irq_err_count);
+	u64 sum = atomic_long_read(&irq_err_count);
 	return sum;
 }
 
-- 
2.25.1

