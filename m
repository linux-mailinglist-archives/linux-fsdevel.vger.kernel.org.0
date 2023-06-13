Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3772E8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjFMRBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFMRBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:01:40 -0400
X-Greylist: delayed 165714 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 10:01:37 PDT
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908C19B1;
        Tue, 13 Jun 2023 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686675689;
        bh=WN3EO5L6L2LgUO17F1OB+6gZgNsH9LQG50fu8rjPAmw=;
        h=From:To:Cc:Subject:Date;
        b=RwlL8Hu6NjuOw1HA4xLw38JZdkmtp+YE8KyXfqlJ24Xz9GZaX7J+jXi9AufCW9JVy
         urgOp+7SzZSKoYIsPG9uW8nO3MGmTVO5Ej7w3ah2xfjIIqwz6ZE8QGuEpEEQ2onbTA
         RarFGWq1AUQ5sFLmL+huwBwjRAs+Ez+aUcRI8tHU=
Received: from localhost.localdomain ([240e:331:cc9:d200:8f2b:c42a:801a:dea9])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 598000A; Wed, 14 Jun 2023 01:01:25 +0800
X-QQ-mid: xmsmtpt1686675685t1vd58xeh
Message-ID: <tencent_05B9CFEFE6B9BC2A9B3A27886A122A7D9205@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieV1wQ4/ZgJkO9il4+0Zm6ZsbNCsziZg9eB7MUoKKULEsQBHpDd+
         t+PKUP2D4a7XlPE5vo/BuMz1LQxsSEdRAnKmwxn76FeqfXg/lWGta9ZymMsPsECQt+djyLRpy5AV
         cWt2U0xbrW/UiOX9/3Pj1xuYUs9gmfE6kPaiW3z1t1RbNY3SxpFhzflurJLW3zfZdymvU1FIEW5z
         PPn3m5RO+UixWvqB209KEAZR84ExgtxkdhpRGLpd2pR1coLWA+dWoPEBHTSwMh/dqXvwBzjGR/Zt
         gd5uL1k1o2ys/hV/A5tR4+Avrxzd/kbBsDwhJm1j6Wf5rty4M7HIEZpmAMvEDTQJuE2c7eeN9SZY
         UL+SoWT/idY6KDhn3oQh7RI4eG+ytsCWft+hdDIiapt9jrPlVHnHoP18pPo2n/Ml4i1XjMJzg60Y
         zxkibs/YEOJrfdrFbV2VcFSZJtK0/K4C3wAAlB0PAnhqXgWFHxntaZyelL3E2CBx5GluJMsj+NpS
         jqIyAGyBmvVnA5yK+CAJdsaHNUb7HODfgQQxyW9i4/MRHI0HLCTKKjk+mKNLfdw9inlQASzs8keD
         b+fDp33S8Yj/CCSpTS6/LswVC4C5TiWOJykxmfJuNgpX4EMNbGuIBDy5dKPWdpMq0HPktiHkB4Oy
         oUN/4HCgnEEuGV2UmLCbLQVZsafmA4tN+CNGU2OIVvDHsavwYzFRPZrQN0PBZhsWv2xWBC/PS/O8
         ppwjHnhikLs22lK4lFr+lHYp2xixe2U3fAXrpUscHipoUfq024+8wWXDe43J6WqBTUX2myt4A0a/
         jB9mbKfELz9aMTvuL/4EyJCVf3jPuH0fMBWfT1YRYc+CM77vQ9QbTcD2Tuv4502ahClHMhZUb12+
         YsEPLIwIMQoXtITOg7WJfUbuo7C0UJ2EKCLPVS+iWxE2M3Mh0VQcjG2TvEEtgLFGruIAiixVMrqJ
         AAxJ0yOUnsRTW5DZUWUxVONBicIKo2sTvefZVelUgOeljF0t0dPotLO/HxcflcvWTidgb4nlO2Vc
         4s0xPT1fq520hcCkGryrxnH0OTijAwstOgB4INIV/iOzwC6S9F
X-QQ-XMAILREADINFO: MFSZYyQdPxvloIttF8cZzD8=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] eventfd: show the EFD_SEMAPHORE flag in fdinfo
Date:   Wed, 14 Jun 2023 01:01:22 +0800
X-OQ-MSGID: <20230613170122.6867-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

The EFD_SEMAPHORE flag should be displayed in fdinfo,
as different value could affect the behavior of eventfd.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 6c06a527747f..8aa36cd37351 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -33,10 +33,10 @@ struct eventfd_ctx {
 	/*
 	 * Every time that a write(2) is performed on an eventfd, the
 	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
+	 * wakeup is performed on "wqh". If EFD_SEMAPHORE flag was not
+	 * specified, a read(2) will return the "count" value to userspace,
+	 * and will reset "count" to zero. The kernel side eventfd_signal()
+	 * also, adds to the "count" counter and issue a wakeup.
 	 */
 	__u64 count;
 	unsigned int flags;
@@ -301,6 +301,8 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 		   (unsigned long long)ctx->count);
 	spin_unlock_irq(&ctx->wqh.lock);
 	seq_printf(m, "eventfd-id: %d\n", ctx->id);
+	seq_printf(m, "eventfd-semaphore: %d\n",
+		   !!(ctx->flags & EFD_SEMAPHORE));
 }
 #endif
 
-- 
2.25.1

