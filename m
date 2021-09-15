Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94A140CC1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhIOSAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44231 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhIOSAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AC6DA5C0113;
        Wed, 15 Sep 2021 13:58:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 15 Sep 2021 13:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Vi4AemPzNUewX
        Z2yAGjziJvBNY9NKWVEUT2EaX3WCcQ=; b=CfIfMmiuIUA9ZoAg/E+ZKsu2wf2+T
        u34idDDPkfxisThOVWSo5jxZPa1kF1LgnPSn42pM0p93URubpepXJp7EjjVkf+WV
        QRDzK30AIjLtE+/BFxwhIQuv9KsTZLredtCqRRd3rjVhL464a/rBigAL/1e0pjBd
        tSpOwnA/HBEWK92ynNwYEECrQ4cMcPbPSx8YCg5mXqn4Fx1LCWxexkmIPAMcXE8c
        gpO8uIMzffTB7nD6elHBzRuQuL3b2B3LYbhO7glSUDkT7SvpGZcO6Vijo1OEILM/
        C7LijBdCn2WfoivflAopfTWNxLC7V/y3udkNcWVa8RV1+yfjH2fwsHjGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Vi4AemPzNUewXZ2yAGjziJvBNY9NKWVEUT2EaX3WCcQ=; b=sfiTasWJ
        gTZhFtvYPa6Y/1AwTZ/KD67F8DAi39HKhVGoaSH8j9Yw0Mh/80O0/VEbfJymFIl1
        cB45s41ktDDNKfq/jDuT16SqpaELTj/Ev2Qb4jNS5TFs7kb54b6IXc89LqXk/CUy
        LlhyCh3CkmkTOhuUBJqTBpObbjCp6KDCcX/CaQdp+Su0h8/fdt9GnsDBAqh+p40m
        nmQR5wg33Y2vELlKqPIjCaUmV7S7oG5sGYbTCNKs0b+Z5mEoQzhA6K2NpaKrUMgC
        8kT4mhSiEJeowGBjR88mEwdnSmhhlQE5M9Tk0wN2L8WuSQpLW7NWbc5SlSCijj4v
        OLRYAFJ9Bsd5gA==
X-ME-Sender: <xms:XzRCYRSMMyZpyjT0IH8uoDL8PeMC2sNIRc_IE6Pgc0n6Xbc78a_KmQ>
    <xme:XzRCYay4MlZvRDhjedTDa-9mn4fWVv5eElEi4uQxIGwOuGtp3oHxgcDweqikEJZwb
    JIs6QcxumiNnxYbm24>
X-ME-Received: <xmr:XzRCYW2Bc6PmifSFKBeCiPoHQx_9mUKMolVmE9_MaUPxSV3gWO45yuMCY8Wa1k4hxPitgKKdxw-ful7aVpCvTx1IcLiy1rP9CoRDQnH8HflyuZxsTdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:XzRCYZB11XkA03DImNGP2jt0hok9Rqk2AegxwE3WexG6nQ2_LHDDfw>
    <xmx:XzRCYagyhiSuh4bfmcAIxx9Azk6ke6jPaFraHp9uCVoECHsuG7HJrA>
    <xmx:XzRCYdodbQJVcWzru7egZWOtf-lRMIoL7KFD0llkFNaSfTZNKBLtgQ>
    <xmx:XzRCYbukxbFCIX_kDee7t81rjnV9mDMbUvpzi7bLZWB65nk-hLwomw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:58:53 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/12] genirq: Use READ_ONCE for IRQ counter reads
Date:   Thu, 16 Sep 2021 02:58:37 +0900
Message-Id: <20210915175848.162260-2-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IRQ counters are updated by each CPU independently, access to them
does not need to synchronized and it's okay to race: as long as the
counter is not seen going backwards (hopefully, cache coherency
takes care of that) and the stores and loads are not torn.

The last part is currently sorta-kinda expected to happen because
all the counters use "unsigned int" which is expected to fit into
machine word and not be torn.

Make this expectation explicit by wrapping the reads in READ_ONCE.
Note that writes are typically perfomed via this_cpu_inc() and its
fellows which do not do matching WRITE_ONCE().

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 include/linux/kernel_stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7eb9e3..90f2e2faf999 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -61,7 +61,7 @@ static inline void kstat_incr_softirqs_this_cpu(unsigned int irq)
 
 static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
 {
-       return kstat_cpu(cpu).softirqs[irq];
+	return READ_ONCE(kstat_cpu(cpu).softirqs[irq]);
 }
 
 /*
@@ -74,7 +74,7 @@ extern unsigned int kstat_irqs_usr(unsigned int irq);
  */
 static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 {
-	return kstat_cpu(cpu).irqs_sum;
+	return READ_ONCE(kstat_cpu(cpu).irqs_sum);
 }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-- 
2.25.1

