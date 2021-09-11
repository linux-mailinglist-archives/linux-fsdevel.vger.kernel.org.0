Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED124074E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhIKDtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55707 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235300AbhIKDtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 982005C0191;
        Fri, 10 Sep 2021 23:48:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 Sep 2021 23:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=UtuZPwZ+Fw93V
        aE+L4bJab8rAtlR8ivT2txo06W5xJs=; b=etBpuCx51QGe3lhLkATS6rCxxLJGB
        DpAAlArYC2TsrahY+HQFpX+fhLug8bHMHBzvxNDag6NKQM9N1FVEJrTNxiJTs+4j
        0dB8QHgmc9np+PWYYMkKpbNsEycFN8tpIhVNYGbof52mlwXlnWX9WpDZbWFyaoNa
        nD0aXZ0qth27kygpl5SCwo+Xymt1dz8hB0R/tYFCyCkUnJxGYkJwoPdJDZoS7Wsy
        rF4+qnYj1zitLHjl1JXu6igGYoEQjr72jOerpe1cOT0rEJkpvOM5bHPKL8Mdy35Z
        k1pN3RnN6+fwXDXz0YKuy9oy8+ZQh7yYBjcIISIZyyEWMIlKs+aCsyZdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UtuZPwZ+Fw93VaE+L4bJab8rAtlR8ivT2txo06W5xJs=; b=bYs0jBya
        BbM5O98vjQIlwIF7KVhVq06mBi7wRLxM/Ml35Vbp6OVTjokRjg7iX+t89VIVc6Z2
        KXP2xD9id1TFWMIX416gBwXcnOwlvSoakRWhoFnpYMZ0x0iQboLO47F2LgWu8slu
        NEILIckNs+vwtBlmhLfFlvEzuVCVPr4fUjiPgicy9nmyvKo/n2DrPSUk3WisyGqu
        /WWYk3uYdv8a97YBcFDu5r4UwDWnjdsPgx71yjnhfPGbg4y2WkRU0RvkD3bTPA15
        MOqTcH/Q25/zzban9FiwcLy3Aw8bksTFjo21bgfk3MNdmCuF5Y5ujJc+HlxQ95h7
        Cl1027vsZ1/71Q==
X-ME-Sender: <xms:Ayc8YcJV7_-FLE63b4LovCKdBcLmhmepHDfSczarV0Xx5P_48PycLg>
    <xme:Ayc8YcLrwZJmxuc0fCnEI6bbzGnVFUEGltc3_w_Yz1wxJByp5L4nX8qmeMYATy3SH
    byIfZ8ZaCaYy2n-60Y>
X-ME-Received: <xmr:Ayc8YcsFmkB-GN9VoDve_L_BmQKL_nxrvEPBcKS2082KZDAr6s-uALR917JYDCqpsqaXqT2BA2X3oetrRmg4xwZNUoVhDzcXfkTMYdHZDPso2Zocglk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:Ayc8YZZF0IjJ8v05f36IUu-eabHq8iaUb1wDcX9KlySR8emYkowOjQ>
    <xmx:Ayc8YTYpvtVz-MnernSZdBjOMzRwirf-UcilpJTcF25nLiFVdXeN0g>
    <xmx:Ayc8YVCsrC1FuuzibPP6P-emH0dYTwmRIDCc-xolH0crN3MFKZk1MQ>
    <xmx:Ayc8YfFLgJ_48LapwaLhUzEjTek-Q-JckmRjGgnBON6YmWrkJlPoJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:18 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] x86/irq: arch_irq_stat() returns unsigned int
Date:   Sat, 11 Sep 2021 12:48:05 +0900
Message-Id: <20210911034808.24252-5-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

irq_err_count is atomic_t, extending it to u64 does not make the value
wider, it's still unsigned int and will wrap around like unsigned int.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 arch/x86/include/asm/hardirq.h | 2 +-
 arch/x86/kernel/irq.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 461536b45391..3b0d79e72871 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -57,7 +57,7 @@ extern void ack_bad_irq(unsigned int irq);
 extern unsigned int arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
-extern u64 arch_irq_stat(void);
+extern unsigned int arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index cefe1bc9f42c..18691ed499d1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -218,9 +218,9 @@ unsigned int arch_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
-u64 arch_irq_stat(void)
+unsigned int arch_irq_stat(void)
 {
-	u64 sum = atomic_read(&irq_err_count);
+	unsigned int sum = atomic_read(&irq_err_count);
 	return sum;
 }
 
-- 
2.25.1

