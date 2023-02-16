Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDD699C52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 19:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBPSaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 13:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBPS36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:29:58 -0500
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86405869B
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1676572193;
        bh=tpo05uIrSacwP/ayWfelC/1KDGLF6+foH8Gxsp184zo=;
        h=From:To:Cc:Subject:Date;
        b=dyA3ibHwSEzn5NBCTMWK00Imn6uOnKJ4yVOW6NXKaVhzrzZGRmH5P8WOxcV3X7RVK
         HfGewZs/p9tt788bDNf+w3vw/lpDSHGeVL/z9V+KvI4gV1WqshpsrOUnrpHEphkLlP
         FJTC/9yoHB2aylBxiXKec9mvee/vwEJvqIoIiyp4=
Received: from localhost.localdomain ([222.182.118.161])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 77320C47; Fri, 17 Feb 2023 02:29:51 +0800
X-QQ-mid: xmsmtpt1676572191tl5gbs3vj
Message-ID: <tencent_98334C552AB55C90FCE4523A327393DFF606@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujfPX9AmgkfAeXzMg3Yo7i2LquEBhKD6goXaR/+obi86JtI8z1I4
         Pk2Vxz8aeh5DMv8wGeVanr2/nGOoeG5aHIYKEctEVk5mqhCmtf3DRSukpitOjOhQHgshvIY5DLSJ
         2KMld2hK1YTj6XrhHzO7cqvla0oqEMe05Q0K0EgK/qLDpWjobIFFb7NNlOeNh+3cMbK5KKE58szR
         ugW7y9epm89HsiZsgsKBkKDd1swO9ba4j3Qzo/54oku1nLzuwT1i4bL63iq7gL6rTi2KNFwqZWtx
         44sXgReUxj82AOip2og4vhEFWIvJp+jQe2z5mkGKDcF3J6bpDiMsQs/Xdq41Gd2tnhPXIeMeENLt
         vpWLaM8TYS6unIN+FVi9dDFuM/uhyxQNrpWr6Ti16o181hJFrj26tbK1vwIqUv7viCxIyXIM92y8
         agrHXx3SoHdYsW2H2SmrNjhq8S5R7DC1I70tVzpC6GNaZ7BoRR5wJHEMMP76ombUwb8yquhAWCuD
         em5fpbP8UWEFElJTa1XRGDKPYTBlweX6euqguaCcW0P4pGC7jVtiF5VQ1ELYl4Ft3A9s16Mnvxzq
         RvatuOIWsBpdt82PfiDMALMmEtS/xCmSjHSDV7mWhTlqbziqARAJosnnJl/AwIxuICq9KPTGwRsj
         YiXQgf+efiLGMIEhMXB1BzMuenT4rN3aSEY2xFMCLsZ4Sjj6eEb2ubXWHDgbtxvJjN+dejtR2qh0
         wg4BFtQKcBnGrheVyjNL8rt32orvJStymbhHjQrZq8rIWiAC84GYIQ4A0mJ45u3C+eRAYKg3seSE
         FADsy4on+/J/lY0WLp0nAME3n8RgVwL+0vxces+WpbLcnrdFjqGkd+PMuJPbgCrpbDPbXA87/6av
         AGId27hwHGKBlsk9w8jAeCvedu/uNwp1a8VeVdDbzt0aKYoOHegLMnTO0MP/J02sFKmYaKyQ4d0l
         bfZ6SLfqqQWH2VrIftu9lIEez1baVtIWs/pxCMOH0lsU21HL7fX26ujEX7Yi3X
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Fri, 17 Feb 2023 02:29:48 +0800
X-OQ-MSGID: <20230216182948.1401036-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
("wait_event_interruptible_locked() interface"), but older code such as
eventfd_{write,read} still uses the open code implementation.
Inspired by commit 8120a8aadb20
("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
patch replaces the open code implementation with a single macro call.

No functional change intended.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Fu Wei <wefu@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 249ca6c0b784..95850a13ce8d 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -228,7 +228,6 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
 	__u64 ucnt = 0;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (iov_iter_count(to) < sizeof(ucnt))
 		return -EINVAL;
@@ -239,23 +238,11 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 			spin_unlock_irq(&ctx->wqh.lock);
 			return -EAGAIN;
 		}
-		__add_wait_queue(&ctx->wqh, &wait);
-		for (;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (ctx->count)
-				break;
-			if (signal_pending(current)) {
-				__remove_wait_queue(&ctx->wqh, &wait);
-				__set_current_state(TASK_RUNNING);
-				spin_unlock_irq(&ctx->wqh.lock);
-				return -ERESTARTSYS;
-			}
+
+		if (wait_event_interruptible_locked_irq(ctx->wqh, ctx->count)) {
 			spin_unlock_irq(&ctx->wqh.lock);
-			schedule();
-			spin_lock_irq(&ctx->wqh.lock);
+			return -ERESTARTSYS;
 		}
-		__remove_wait_queue(&ctx->wqh, &wait);
-		__set_current_state(TASK_RUNNING);
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
 	current->in_eventfd = 1;
@@ -275,7 +262,6 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	struct eventfd_ctx *ctx = file->private_data;
 	ssize_t res;
 	__u64 ucnt;
-	DECLARE_WAITQUEUE(wait, current);
 
 	if (count < sizeof(ucnt))
 		return -EINVAL;
@@ -288,23 +274,10 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
 	else if (!(file->f_flags & O_NONBLOCK)) {
-		__add_wait_queue(&ctx->wqh, &wait);
-		for (res = 0;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (ULLONG_MAX - ctx->count > ucnt) {
-				res = sizeof(ucnt);
-				break;
-			}
-			if (signal_pending(current)) {
-				res = -ERESTARTSYS;
-				break;
-			}
-			spin_unlock_irq(&ctx->wqh.lock);
-			schedule();
-			spin_lock_irq(&ctx->wqh.lock);
-		}
-		__remove_wait_queue(&ctx->wqh, &wait);
-		__set_current_state(TASK_RUNNING);
+		res = wait_event_interruptible_locked_irq(ctx->wqh,
+				ULLONG_MAX - ctx->count > ucnt);
+		if (!res)
+			res = sizeof(ucnt);
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
-- 
2.37.2

