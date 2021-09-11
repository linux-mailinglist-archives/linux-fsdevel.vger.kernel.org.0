Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B324074E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhIKDt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42799 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhIKDt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 22DE15C0189;
        Fri, 10 Sep 2021 23:48:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Sep 2021 23:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=lMi0BKNLipyY8
        mupcENzcBdBYS0W64a2lg2FY9qyhcQ=; b=N0a3vDvJ9PFW9IlXnNoO+0canqRJx
        UfhyyPQEXCnktRNUSpY+bjkeoOgglxnkURtWxqhF+b9BHtIvCYlqY0ynCmMnsTvt
        vMr54Gjr19weDBIIEoz3Kq3Yapg9LVWbiOwcOGz2/CqPaHi43R0EpjzmNc4bJxb/
        8zqNGikOO21q4Zt/OlG9S8OyOPPPOxVUdBywvUNPFZUPBo8pSFybH/n5FIpgI8y8
        FVA1w5C/jRWhl7fXR2EU1QLEsTmCR4Adbp2XyyVhCzKhMvPJZ2T+LPJH9p32pTpO
        1Q6QH0Q0KRfKRCOr0eVGDv1GfKoEkkjQ/YHXdVZYYBAU9v4PnvSFJSSsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=lMi0BKNLipyY8mupcENzcBdBYS0W64a2lg2FY9qyhcQ=; b=v+4dSS8B
        xw6rXEFjQXxcVIUv6c1xx/e5t9kk2TeuwXZyCGKAJri63xSBVHe/RF3TtBuYJdwT
        u9eOAI5U2RaMtAjGGxF3dvQAQYWeEeVB9PnQNxRXxcIwUCtV/2a0mmh2vcMsSh7q
        8Y/mdzojystgglikPKY4rUvFO1d7YHO8HqEYrOkrR9pfWdeMRRRAuzRAe5img+Xh
        AsVIXKM+Bec8071sv1lpFPDaL3B1bMfl33KX4t9nwVd6an5oL0fCH70V39r//PpM
        AidYTjHPZkX/6ITeMRySPGRR6/jk4gbqlItzhLSvIe39ug0fSRc7yyfHlikXFWKA
        hn6+24peo9BrzA==
X-ME-Sender: <xms:_SY8Yea9JbIBIqWL1AkdHGXRMFMFbbaKo6GGHuL6maSt3IBISXU8nQ>
    <xme:_SY8YRabrI6HxQZS7TzPBY21ZAQ2scNwwlfYkbYDG01_epFB5_4NXDC2uhuAKc1e_
    Y6JdyPTbZ5RRlgZkfA>
X-ME-Received: <xmr:_SY8YY8kfNZmrp74FrdESElmCpzFUiCxn2DjutljIZQXPmLXTSlr3k6MnKPFRJD1gWpiIk8e8D3SjiGjRWdjBb8Hk6dHbJ9BVRl6gJ-AB3Be4YuFkn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:_iY8YQp3a9aOYIfPbrJdectLirKC4antV_cIu24CdUldkQP6W1R35w>
    <xmx:_iY8YZpvMH73GJrufCOdK8LnMTgEpzugUDRpdHEig30EguvShh2Cdg>
    <xmx:_iY8YeR8wi0jvw87XTGwdsgCyJr4LbvmFiCOu_w0jwfI3dHsCvfd1w>
    <xmx:_iY8YQUbQEAkVmPKTSaggtntoHPt6pXWEveycQ5da2k0CMTRB-yZgA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:12 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] genirq: Use unsigned int for irqs_sum
Date:   Sat, 11 Sep 2021 12:48:02 +0900
Message-Id: <20210911034808.24252-2-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's read as unsigned int via kstat_cpu_irqs_sum() for /proc/stat.
There is no point in having this counter wider than necessary.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 include/linux/kernel_stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7eb9e3..72818fb39ae8 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -36,7 +36,7 @@ struct kernel_cpustat {
 };
 
 struct kernel_stat {
-	unsigned long irqs_sum;
+	unsigned int irqs_sum;
 	unsigned int softirqs[NR_SOFTIRQS];
 };
 
-- 
2.25.1

