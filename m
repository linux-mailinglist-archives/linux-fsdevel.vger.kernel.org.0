Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643F94074EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhIKDtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34785 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235319AbhIKDtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 57CBB5C0187;
        Fri, 10 Sep 2021 23:48:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Sep 2021 23:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cigNkoH13qaWh
        wQ8t7Mm2Oj9VW7DSWQdJYMBXGB8leE=; b=QGNIsVTNHlretRUnvBEfGehe800eO
        j2Dre7EBBnkDJI4QIqCC9e9sjjytrDQJyuNB8NUdfEDppjPRFu2visCHWUL/m3XW
        bgBoFzsiX4PiVw9oFB7lJWqJ/EADCHEGQfRd3XAZgVrurCyGbTkjLQaBfH4lOMJN
        IfFBolfp+nBH1eqos6A14i1qjvnULWEc456vagTXPARJX4g4368buVdhOGd6WgO+
        xmzOO37jNyCTcwd1WBI7GkUe95qcqr9c/9eoNpQMWPbWxhbEantaNzzBA3HZlxuJ
        bJApwY3DVEcY3/BeCOTrQskJKeemC+G7M4OltvGlGbTIikrYoKz+qq33Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cigNkoH13qaWhwQ8t7Mm2Oj9VW7DSWQdJYMBXGB8leE=; b=EnAmDpBx
        d6YuMMEz1FyHXJu91uGifX8aXMZwswwZ2/pO6U1M9zXrElS8yrQ7mGNPnvPPfMWT
        eAmQlz3F1cOhFjYF8kCaw5BCQYBikiArR0ufEASkbtEozJaUSK5m9Dr82BDcnj2v
        4LPUTqM1xGL/XzDVVwcFrN01pVcA9RBnmJQy6KnPKGRqn6y8Bf/cJd5NTZQ9QWmn
        uB6VFEXXhF3RjI5fyy+xJxhm2xI7rHPvCyGJgeNIcuUZBj+WR2zhW/3aleY/lXtn
        eFgDDdWf/6UWlOTGt1/cfgxI/Xg5WKcfd/YiRg2b7oDe4ZOY5hWjHHYX9Gy+4iqM
        2xMTSOB11RMreQ==
X-ME-Sender: <xms:BSc8Ye2NcqimQnusFBpJz6BPLeuF8W9rDOEjTQsCJcMb-SyQvE1mKQ>
    <xme:BSc8YRF4u0jiYpRbdTuq_C4leNaBm3JMyzahUgJGDd04B490EDPWJPcBQ_Bzm6juq
    C70L5HMUPtVIehRP5s>
X-ME-Received: <xmr:BSc8YW69vcr0B2b84wwJxX0mj1qcxzONMt0HEWmXuQVOx9wD6r6YwRUVrfdsun3rWOQ62z1RmMdHTVa8EHQ2EX56TTmTxCtPXIcOrxU_7cVR3Kt6YKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:BSc8Yf3nRRWn9AFgvApM1SepR9PP_Lt8x7SJkVYRPn092GPpz5nKTg>
    <xmx:BSc8YRHZsFwLaEmwMOwDD1iK1OLk3pVSI3-dNJQlA80wTDUt76Qo6w>
    <xmx:BSc8YY9O5LSPpbTn9zFKD0iYvtdmJ-IVy2ihekQaCK4dpY9GF5iujQ>
    <xmx:BSc8YRBXjC_8YuECOSuq8yIDVLH2taMfaO2RRDPlr7X7x9ZEXB1PpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:19 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] proc/stat: Use unsigned int for "intr" sum
Date:   Sat, 11 Sep 2021 12:48:06 +0900
Message-Id: <20210911034808.24252-6-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all values that are collected into "sum" are unsigned int,
make the sum itself unsigned int so that it overflows consistently
with individual components and thus retains the monotonicity.

Since seq_put_decimal_ull() is a function, we don't have to explicitly
cast sum into unsigned long long. Integer promotion will take care of
that (and the compiler will issue warnings if the types don't agree).

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..d31b83b2a175 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -110,7 +110,7 @@ static int show_stat(struct seq_file *p, void *v)
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
-	u64 sum = 0;
+	unsigned int sum = 0;
 	u64 sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
@@ -192,7 +192,7 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
 		seq_putc(p, '\n');
 	}
-	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
+	seq_put_decimal_ull(p, "intr ", sum);
 
 	show_all_irqs(p);
 
-- 
2.25.1

