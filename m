Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B024074EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhIKDtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60155 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235322AbhIKDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 115D05C018D;
        Fri, 10 Sep 2021 23:48:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Sep 2021 23:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=hZFPPQMxtDZYs
        SaAZ1s1UJVWP1V7Xv6Kaz9Dp+/4f24=; b=dkgv1grr7eem+kHDQotDzlcN7xyIV
        wEVo9mXfGH0yokZuB/Gvhp3Wswg53X+shqyJiMTgrRfgl21cvLIamMTqqvcPmMLk
        KdqD1TXZ7RySsBqHCvXyHz71nIVEPjkAwjFhMuoCLLqjLMzIvE7DW8VqYnRO46cL
        dpoW3ZDoeV22X+pOvFEdB/w+24OZHuC1xlpKnaih6YAyEolB1GVDudvSm90U37PG
        O5FcxxQbsPQCNi1VCmwazg8b5sxCHrvsbPXbnG+j/gGnEsAZVyYtLBL7lWeHbOwf
        Mp5/MeFdhawuJefNlECyFsoD5zwwcnIAp86smtgPzua0Ah4H5AcWhEUaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hZFPPQMxtDZYsSaAZ1s1UJVWP1V7Xv6Kaz9Dp+/4f24=; b=cwTjDWO5
        0Gk1ynKlfJOqK/aSbQ3G14iUEz+LhGkyi5zGKdeM+ux6gqFpDmYbghS6ZEyIWTgg
        +IgJbuUWUtDnY4AzSW2is90YB8ZgzrNauPTWZCY2vRvTce34aUrKI0zagnr5oNW6
        MSF5F7CiLFs+xcatjYMAgYH+weW/AlLfWoJoxvq/wYtEO2wdKD1WO7e6jiDP1uyI
        1afBKGhRlD/fhLn/pLLBey19KZ4dcu5TOrqvZxQGdYEleNJZ4Bx8lDlpfxZXey3A
        /vqdnwpEpE1lhjv7PvKmJCF38wBCMOIIrYtnN6kjK76DHJ/XBbxDfld2J068SLXq
        Z00QzRPoVD3StA==
X-ME-Sender: <xms:Bic8YQdxJtIa_AnqtElq9PrGL-HA1Gud7Q5uC6vJpS4_njCRRvaBZA>
    <xme:Bic8YSOGVJCcMpq2DFxI9XpFnHH3qDQDYgCJB6Gu1S4BB6woi-db7ITM5r5DlS8HK
    8rNAqbUU0JCcs3yrEE>
X-ME-Received: <xmr:Bic8YRjnJF7VvDLSuOyTkel0tDh8pitcOTLAH5-MTSEB2mfrVb_ThmSCTwtP7nctTNt_GwxgyGhNIFRGSuq72Jk8rcI8RyZ5eVFF7cQ98HBffAMpmnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:Bic8YV9hWVxytIgUc4eBjWmME3ciBaFGT7SIiGbOKg5AYbmPbmH_tg>
    <xmx:Bic8YcuTYQHIKPTkeg9NarrolWQMHG2hZo2vTdu9NnctJHpewTwuVw>
    <xmx:Bic8YcHrXgshTCgvjPUAgGogH6OM7uo29s0Wc1DJjm_ZdbqI1Tqj8g>
    <xmx:Byc8YYKoNkMMrtQ7tx6XZijo9oLEFY8mvRjwX9f-1gliLW5yL08GKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:21 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] proc/stat: Use unsigned int for "softirq" sum
Date:   Sat, 11 Sep 2021 12:48:07 +0900
Message-Id: <20210911034808.24252-7-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to "intr" sum value, "softirq" sum is computed by adding up
unsigned int counters for each CPU returned by kstat_softirqs_cpu().
To preserve monotonicity, use the same integer type so that the sum
wraps around consistently. And just like before, this value does not
need to be explicitly casted into unsigned long long for display.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index d31b83b2a175..b7a7de3cd822 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -111,7 +111,7 @@ static int show_stat(struct seq_file *p, void *v)
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
 	unsigned int sum = 0;
-	u64 sum_softirq = 0;
+	unsigned int sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
@@ -208,7 +208,7 @@ static int show_stat(struct seq_file *p, void *v)
 		nr_running(),
 		nr_iowait());
 
-	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
+	seq_put_decimal_ull(p, "softirq ", sum_softirq);
 
 	for (i = 0; i < NR_SOFTIRQS; i++)
 		seq_put_decimal_ull(p, " ", per_softirq_sums[i]);
-- 
2.25.1

