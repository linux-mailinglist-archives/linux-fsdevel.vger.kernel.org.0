Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA20540CC29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhIOSAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44377 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231277AbhIOSAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 729F75C0191;
        Wed, 15 Sep 2021 13:59:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Sep 2021 13:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=42DPWXnF7K60U
        mIMLOWUndtU0p5zix7a7KTLEFXJ1AY=; b=EKqHhHX1nmg7/9GTShWWIwjKT4ZL6
        FI1rCnFaExOUWQHyHwh69ezexzZaWV5V20+pG0GYfOKTKs90Mim9kgffMP7qnLXo
        PPMhpHDddV4ySWacAsd0eci1PFOCu2L/xCxb5/Ttm13jtvgWG353b1sO/M8oKTfC
        TCHNLAOgAjLmltNy89u0oygllLpkzPkaB7wZ9GO/ag9W2+kiFoMQunFN1vFUN8P3
        bRuBe5DANRSssIWOpSi0GgmyhFxvts/23uHNEvYZ/6LruQDM9IdjPVmX7CggJdtd
        Fq87taajhSo0xTK9tsul7s9SCB5NhiuhUAKN3yLlAEVHwAnEmqR+3hg+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=42DPWXnF7K60UmIMLOWUndtU0p5zix7a7KTLEFXJ1AY=; b=KaguOzfl
        pVFfATs8WYQOBawKzKTbw80an8AYqbnAM29cIzJ7sui7vCQ9go7z/YMpjCRsIi+C
        IB8id9LcfX9lDJN4NaYF6NrUyojipryHQ2v7WZk7PdQph2UZx1h636qi3fVatceW
        qViaGXPQX/m3f3FlotcFenmYeGtX7mpwyHLC/8WDBSJJSqLdYu95n+20jJA6grDE
        UdYcInfYlOmZBZIGygdIoXMyGQgrWVUEJVpJCwC9s74g/tLzSH2Sn86UlATnQafz
        xgBqi7PWJqLgBE++ilDBdYs772XiM6MqQ/AbFgyzu69olcf4gprTgQZJ45K819MJ
        mKu8Pz4vbLwe+Q==
X-ME-Sender: <xms:dDRCYdpe20cXZYKqC9uPLGTsw7wBWH01M2n5jLuIWWQHieDGxdJV2w>
    <xme:dDRCYfpajXQcxtBJ49v2jQKgJfaNTTnmoOwnyUPw7vMsaYUzC1t9HqxMAUSkX7ZF_
    GfzUNiMPIvaJ6yNqRU>
X-ME-Received: <xmr:dDRCYaOwxEFMER1j4Bh21CjfVLAC7RTJHTGvFOYfaqg9qs4hePtFEX5gzXSYRYhM4AhvEwWWSboNDYfF3IV20E_60chA9g8zOSlvwsSKyXLOOFD_ILM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:dDRCYY4TmSydsZhr4jY7JP2g-yYsgWdJZ4_aB15hP9z3PXhG6ryFlw>
    <xmx:dDRCYc6r6uuN0Yx07NkCNUMIDzEXYRrRYrswh0EH-h_rOp3z1w0w-w>
    <xmx:dDRCYQjXFNBC9QoNuY8Wr4EYXXomPWbPWtYLeNACX34vVHCai5de4Q>
    <xmx:dDRCYakVDrYdOjgI-ZPX8oZpFl1TdhxwWFupNkvErmTPfSOnmXaFCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:14 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/12] proc/stat: Use unsigned long for "softirq" sum
Date:   Thu, 16 Sep 2021 02:58:47 +0900
Message-Id: <20210915175848.162260-12-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to "intr" sum value, "softirq" sum is computed by adding up
unsigned long counters for each CPU returned by kstat_softirqs_cpu().
To preserve monotonicity, use the same integer type so that the sum
wraps around consistently. And just like before, this value does not
need to be explicitly casted into unsigned long long for display.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 fs/proc/stat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 3741d671ab0a..4c6122453946 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -111,8 +111,8 @@ static int show_stat(struct seq_file *p, void *v)
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
 	unsigned long sum = 0;
-	u64 sum_softirq = 0;
-	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
+	unsigned long sum_softirq = 0;
+	unsigned long per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
 	user = nice = system = idle = iowait =
@@ -208,7 +208,7 @@ static int show_stat(struct seq_file *p, void *v)
 		nr_running(),
 		nr_iowait());
 
-	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
+	seq_put_decimal_ull(p, "softirq ", sum_softirq);
 
 	for (i = 0; i < NR_SOFTIRQS; i++)
 		seq_put_decimal_ull(p, " ", per_softirq_sums[i]);
-- 
2.25.1

