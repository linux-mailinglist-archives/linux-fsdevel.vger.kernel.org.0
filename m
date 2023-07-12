Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8E750EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGLQnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjGLQm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:42:58 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46411B;
        Wed, 12 Jul 2023 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689180157;
        bh=XS7uVyxvyErmeOipAo/I8ZO89hZtODJtc8bPKLUEKT0=;
        h=From:To:Cc:Subject:Date;
        b=Lq+UVddJnobpDppQFwRdLVwvauHhnIaV0sMxZhOUUb5mDGWxCC/gkLglm9xVNvrXY
         HLpP2+J2E1KYTwNKlpz9ZrGKl6/2HVrusve5TWuHduH3vWYID1ecUYD+zF/dgM9ZDY
         QJ44rrKHFNdOC9sNoEDyI4V+iEu7Vn6DFVSN5TN8=
Received: from localhost.localdomain ([240e:331:c33:db00:13e0:d3eb:116f:835c])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id AA205AB9; Thu, 13 Jul 2023 00:42:34 +0800
X-QQ-mid: xmsmtpt1689180154t1hg5njof
Message-ID: <tencent_DC522F05F54C72A6EF3193F9313CD756350A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtb5BMoGPAGiwT8G+APxd1DKqErseAuhEgDN1s0J6hBaOnI/p6Bs
         y1LTaF2FpF+tPi3E2YETAUZV2+mu75MN35ZYXm1QXO/s9k+N1n97BBBHqNhWxlAF5XdnCq+ybeTe
         U7hbjDAyQeNBQuSChO50BcRfo8qz5OTInIZBRPWAGfnQGr82BUJguY51UY/o+t8FysnTWzVIJW22
         r50PfKyHbj60zQK+u8o1SbprWF9bDo5KTdwwEQ3DNnQ14NFYdr2hE4uRqpfiCr2qWmgvMifouS8k
         onYlfHimhCv5w4obqqLR/KtO4ADBW7akGfM4Duj/pqftOFKJrxhuPWTjrrVQDiN6vd73xWjO+SVY
         jGhgGp9Jkmbk4HxdPQX1E6kItIRAweTbIUBW+NLlC4cmo7cK+gr0v9yukciLQhvvF2d+3MZcdhoV
         VFMGoyglrk9fouQl7YaFIQkiHyTrTbvPGaA2M15QAYpae+D9rk/N3rofVz/vItUcmupsiqFYozkY
         wDVXRWJ66jD42Aezros8/joWN4ctdXZjjahur5ki8wl2+4tzhFnr4TDgqblOTCcAH2p7DYzqihqj
         z8huDVRJoZyaj0pIKLdDeL/fbTXwwEDtKXN1vPHcEGF4GIabxmZojVIOb8uw9F6+u64oiuaue+xY
         1ks0eui3zG34ERKxRDWPhyNV+lZKLMPPjyntyH/0sMM43ufsUGpdstkR1ZoSeGpX0RYZ8jBXCq7b
         cFhoYR9r0x2crbK9VOQWEddStRAA7HIDsZghLUb3t8a4GJktcJSiu3PSDlCZkF73L1VYH5FABt4c
         5+MUgged1NKs736jze8w4qQn7rI3Zsp8vMkHUAd8WUTlCIxYg+CXl2tKnknzyIwoUQskpomIziz9
         UDN67vSl1iCQQ+40sxCgXGPI1J7UgcWRrMl3nhsBK07IW7gqw6awiDTKHbpcP8aoQ5oNnqtP0xJI
         XMYgkhB76PhkImDLqZwv4KEf6FHdRbCDtLwT5KWCjIcxiGG9wOYazPOYR/sfZApqONyS8QesXhDX
         eronhbVA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: avoid unnecessary wakeups in eventfd_write()
Date:   Thu, 13 Jul 2023 00:42:32 +0800
X-OQ-MSGID: <20230712164232.121991-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

In eventfd_write(), when ucnt is 0 and ctx->count is also 0,
current->in_eventfd will be set to 1, which may affect eventfd_signal(),
and unnecessary wakeups will also be performed.

Fix this issue by ensuring that ctx->count is not zero.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 33a918f9566c..254b18ff0e00 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -281,10 +281,12 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
-		current->in_eventfd = 1;
-		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-		current->in_eventfd = 0;
+		if (ctx->count) {
+			current->in_eventfd = 1;
+			if (waitqueue_active(&ctx->wqh))
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			current->in_eventfd = 0;
+		}
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 
-- 
2.25.1

