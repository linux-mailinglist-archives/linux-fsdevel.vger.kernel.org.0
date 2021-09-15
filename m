Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087D340CC26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhIOSAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35609 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhIOSAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DAD975C019A;
        Wed, 15 Sep 2021 13:59:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 15 Sep 2021 13:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=YQEHYcfXa0InC
        iKZOyZgJDVQhRISp2oHQfGAKjcBvrA=; b=LPcEHsYlAu4TQyIlgUy2g/SJsVdOA
        q4ew38Zc0znF7UeZ8lbtUnPxRXyA1txj3HLYW24N4Da8WwRSKfeCkB6hNOf3gluN
        HP3KC1LMjyAVksiMB4RwJ+TNzsxPHCHI8W5HRbJXb+2X30HH3gn2+SLATcYzj/92
        eKMpbfFk3au+XEtZNSsONbWIjG7LlV8CeWtVIaz6GhG251BZhXNAeVDI0ifzQEDk
        +gtDXgydnE1xum8qfTpsl+10Jdp3JmHcorMjKlp+GSBkQJHW7VPWlAYVBKtAJawm
        A7IHzOhCKIVG0URDsip+hzg9Um/m/BZ1Ca2/xDZh1Ahi2361Q6SOr/V/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=YQEHYcfXa0InCiKZOyZgJDVQhRISp2oHQfGAKjcBvrA=; b=uljrsX+D
        2L+fjXtFOxxq/NXGfTZCIodMbNw0ZecLfKEiAJg9NUeeLp7KcX0/gOKQ1YUL++j/
        V0AnOQUnfy6aDEDBno3JJ6ueg4le0g/EkqT6YiyvJ0DuYvgX8xfSPrq3UIrd5NeD
        Cpu0nB2e4AGzStCISDfIrCuQVkn65P8qTd9sWRyov1OYGnu6IgmXCymqxy80AOmG
        rfLReZR6/vs7Iqs5+HrwFjeDoVta+1xaWBpJW/vDFmYO/FnjHYZw6GbzA49Q4A6f
        /vAV25hQZOCYZStyDRZVMQO3qC5bxn0Y4Zb9kudR/VTUy0PpXxnaechyLtqmu/cM
        fe+7tBnLEKTk0w==
X-ME-Sender: <xms:ZzRCYbyk4dwqEj5uv6BXX2S8W3L-Jf7FD4KN6RcSu74yTdloWWreFQ>
    <xme:ZzRCYTQoWvMDdcDFkNigyK0o9eUx04Oh6WObIe_U52n8Fh_9kQ-xlcKhr6DgHrEQ1
    c3CrProS8jwuwiaRfg>
X-ME-Received: <xmr:ZzRCYVUu0rxH4xGwu5cewiQY47Zsr6z_bwAjeOuN3NP2EBd4yT2PNVSYNj79maq7kOIS8qrxukebmKgL_Q3GyUN1ovbmB0cQmN8oyDh2ZtXlBuhqvbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:ZzRCYViEXexjZtNA6Sdg0Z8C7GUALFLENwFxj42_Rv_4bMjqsiFkcQ>
    <xmx:ZzRCYdAtHDbi3cOtH6LK_5Qws5sikIJrGrR_a_26K-lQHr8ECWGl-w>
    <xmx:ZzRCYeL9zncpe8HH2ejEQT0_jQJ4ZkJZYP0dJoKvzZEDyB0GGtHYvw>
    <xmx:ZzRCYcN9sPZlzjwwCV_c-toWGqPv6xSnxBvLhvv4X42_RKLONgS3Dw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:02 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/12] powerpc/irq: Use unsigned long for IRQ counter sum
Date:   Thu, 16 Sep 2021 02:58:41 +0900
Message-Id: <20210915175848.162260-6-me@ilammy.net>
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
(which is more important for 32-bit PowerPC at this point).

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/powerpc/include/asm/hardirq.h | 2 +-
 arch/powerpc/kernel/irq.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index efc5391f84fb..4d3a7d66c299 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -32,7 +32,7 @@ static inline void ack_bad_irq(unsigned int irq)
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 
-extern u64 arch_irq_stat_cpu(unsigned int cpu);
+extern unsigned long arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
 #endif /* _ASM_POWERPC_HARDIRQ_H */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9f39de114a0e..1a0a161ee38b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -645,9 +645,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 /*
  * /proc/stat helpers
  */
-u64 arch_irq_stat_cpu(unsigned int cpu)
+unsigned long arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = READ_ONCE(per_cpu(irq_stat, cpu).timer_irqs_event);
+	unsigned long sum = READ_ONCE(per_cpu(irq_stat, cpu).timer_irqs_event);
 
 	sum += READ_ONCE(per_cpu(irq_stat, cpu).broadcast_irqs_event);
 	sum += READ_ONCE(per_cpu(irq_stat, cpu).pmu_irqs);
-- 
2.25.1

