Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9C40CC2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhIOSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45503 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231492AbhIOSAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 131C95C018F;
        Wed, 15 Sep 2021 13:59:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 15 Sep 2021 13:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=qbX19vLDtLzyl
        PjsWnbZRywh9VvojMAsJEf62kXFjsE=; b=UfJRfPo96nlTJyqScE2E7ctPACp6I
        jVyCp3hRKNYPZnXwdOVhQUnsw5Auf0KSx4CJWt+E4oxYJzpPauC2h4X81c1VmNCM
        dLpOrQOMnPnLlCB1uTyc+jxdeaEyGpZTCCIxJmcvVzeqg7A7dIcbDUzLC2kRdUT3
        6Txg6aTM9jxF8Ydp3NdZ06zo8UfL7yNsSkTnFwiAQoDADHQygkrozrxZQh3i+3Cs
        JHW+iezejX5WxN2veXF03OeRDps4XrIcwTiElns+MrJeesDdlJrOuR3J1PZvN7P1
        OF0XfSqy17o50fiGLpcImLOarunJK22ttwIzxn9b0dX1XWhxEzTOXhWvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=qbX19vLDtLzylPjsWnbZRywh9VvojMAsJEf62kXFjsE=; b=sm9EzDdJ
        k1hNDmTj+d1jjItSNt1FL5lfdu330KcwJ1MiD5qWvLghrjQhc004j+WzGn6OwdIE
        OOymcLzk5DFOeuqtzwGPrk2chKLeoNF1y/OXpRqk+xFmxnVQbB+PQYvlBPr+Wpjc
        mAHx475EjCgABmFReRzOjkUL5m0cEiXongJALoPBNvQZSQUc3e/maKSzH5Z37/k0
        7EO33eW9WBJva8fh+oX3q68+l3CVGSxjp2E98OTOBDU51MwXocmqNsRJuJOyFm/k
        KK5T4z1pDPtBOAGdoblU5EtKl/KYF3HzE6rDN9LKk+TxLGPa1FrekLeNKPwrxQ/x
        3S5Syxe92q5F9Q==
X-ME-Sender: <xms:bzRCYSYMqfATO9dgRZ_D-TFpabHp_yr_soYu2twdzW7KgZehCTKZNw>
    <xme:bzRCYVZs4sfakk4rEJc7fPbjpMPcDo3eZmtLY063CUw03wTi297KDIAegz6QirW2_
    ojiL6lRK4xv-Qv_EP8>
X-ME-Received: <xmr:bzRCYc-8ZfMqy5TzQ6bGEqJ1CIWOLjW-k3hgf_xeE5bwydDGOl4d5PLGtl4WikmiBF7GzbxPqTjf9-iQrRqEvHEPdcZxZJY0kK10t3fFxecfYGXcCWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:bzRCYUrKqt-X1O_H0qtqeDiR6bvW10uYAqmvaWwL-Cq6pNdkfMS4rw>
    <xmx:bzRCYdph8pGvIQs9EfVS-jt-oIJA7ZxhwdNEbIZYbaMcMhLoOCiGzQ>
    <xmx:bzRCYSQi_KmegKV8CkTADZlHmHPMbsO53249-fru72ipLt_edde_cw>
    <xmx:cDRCYUUokbNz4csSS_Tlai3OSuLw7TgiNwq_S-BipvTH6UOkYffv9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:10 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/12] x86/irq: Use unsigned long for IRQ counter sum
Date:   Thu, 16 Sep 2021 02:58:45 +0900
Message-Id: <20210915175848.162260-10-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all individual counters consistently use unsigned long, use the
same type for their sum. This ensures correct handling of wrap-around
(which is more important for i386 at this point).

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/include/asm/hardirq.h | 4 ++--
 arch/x86/kernel/irq.c          | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 2dc9c076f611..c05b42c4d8cb 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -54,10 +54,10 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 extern void ack_bad_irq(unsigned int irq);
 
-extern u64 arch_irq_stat_cpu(unsigned int cpu);
+extern unsigned long arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
-extern u64 arch_irq_stat(void);
+extern unsigned long arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 6e7c6b4cebc1..2d889e26ae68 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -189,9 +189,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 /*
  * /proc/stat helpers
  */
-u64 arch_irq_stat_cpu(unsigned int cpu)
+unsigned long arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = READ_ONCE(irq_stats(cpu)->__nmi_count);
+	unsigned long sum = READ_ONCE(irq_stats(cpu)->__nmi_count);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	sum += READ_ONCE(irq_stats(cpu)->apic_timer_irqs);
@@ -219,10 +219,9 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
-u64 arch_irq_stat(void)
+unsigned long arch_irq_stat(void)
 {
-	u64 sum = atomic_long_read(&irq_err_count);
-	return sum;
+	return atomic_long_read(&irq_err_count);
 }
 
 static __always_inline void handle_irq(struct irq_desc *desc,
-- 
2.25.1

