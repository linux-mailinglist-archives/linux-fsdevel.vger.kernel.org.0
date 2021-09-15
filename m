Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B838340CC30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhIOSBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:01:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43025 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhIOSAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6029F5C018B;
        Wed, 15 Sep 2021 13:59:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 Sep 2021 13:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=rXPmRtPvanx8u
        dPUE35J5/l0NVtQqP+ln76q+IjUGqE=; b=UwHKYkN+9B9MSAf7DwdgYEuk9EANX
        uwhGzexoN5hLCgqWa4AdvXUsTzlbTPcOY4f1fc6+18a8Eq4YVugCuFrQW6oyzogF
        IMQ3KzDqBY1rf2brBqs+YgKK2h4aDfeCjsO+8SKM4A3kwouRHmVKCr6P/zoIF2t6
        ErB0ZfhZR1shp9ygnw1NT/RDqHQkuWRlwUF4A50QQM8oRKEh4QuOQ5p5KuODlkd1
        DzWq4rSWJjxCOL20jit9IGWxvWpFqs3lg8UngiDQo06TIrWoBbX207g15/bfHGgN
        Go9YLtPAErJ1XTpfREeD4TqvVZIioblNmdPIzhI0sgLe9ej6mEtws7RiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rXPmRtPvanx8udPUE35J5/l0NVtQqP+ln76q+IjUGqE=; b=mX4MQhXI
        UsdMVDilOKbjUBpLWwkUNV9pn0MxbHnMjC8qLIDbYCkB6OrX1rHgz6dElaHAK38B
        6AmGoxA4Wok1nZGvEgV582GK9rDty6C/5+R27/vBdi+1573Qz83cE2VTP2J7gMQl
        nodKBhRj3N7VQtO960aaox3++FdSpAlpwu22Eph5AaxQY6W6wLtoJ76lRmUCQkET
        2c7PgPZJM7Mr/RKeUG1O/GSvExa/hhGxFZqeS+/XegGle20XerB2e60O9VfDYWPj
        n0BS5CTDPJuZ2rqZP5QYs+R591L9VM6//MF+Ih444w2Q6LEpyQ5KiKDShH/i0hXa
        ezco2Mx4yysNuw==
X-ME-Sender: <xms:cTRCYdCs3srsUBoiO3PjczZ95VOWE8VzCXWHAvAcUkbsc0AcF7Z_-A>
    <xme:cTRCYbiQyGeNHVtTUfN0VlCm6OqNSSRMjkKK_pA6gGOt6dgvVzIFV2mbdaH2am6PN
    i5Dkx2kulkUk8eGebg>
X-ME-Received: <xmr:cTRCYYlGa1Or_IrC9xZe4bOjjwcsnvbsMT9qa90FdhialY8J1Bm3KGEuq8FaMO6_4z_BA803aibS8AtkK1qtng0-9tsbxWdCoZqQkq6JDh_A0jfpxpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:cTRCYXyKO_8xCuHfemj6bLA2rf4BZyvMHML8QBqxlyVG8BnqEp9Zww>
    <xmx:cTRCYSQjWZlrYLVtUB_pbgknS_typJpWp_acRxteVYSAMlp_REOjyg>
    <xmx:cTRCYabqnH72XLnpLRSmAvqTbq3R9xwTUHnJK2REv8i_59r87xx6xw>
    <xmx:cjRCYQe_nbFLRIX4qp3JirIwnXnXJY3hbnORc8Bn0pFTQJ6MzAXg9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:12 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/12] proc/stat: Use unsigned long for "intr" sum
Date:   Thu, 16 Sep 2021 02:58:46 +0900
Message-Id: <20210915175848.162260-11-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all values that are collected into "sum" are unsigned long,
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
index d9d89d7a959c..3741d671ab0a 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -110,7 +110,7 @@ static int show_stat(struct seq_file *p, void *v)
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
-	u64 sum = 0;
+	unsigned long sum = 0;
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

