Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836F6D9AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDFOkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbjDFOkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:40:01 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BDEB77F;
        Thu,  6 Apr 2023 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1680791876;
        bh=XA9RStXar6lejJB+opLt3Pq4asfGnjDahXdp3RA6yEY=;
        h=From:To:Cc:Subject:Date;
        b=NrSxPOfwlHz07xTtL5HEIvdPFJzkULQ7W5pRylEqSJNf84cxJlAlpeFeKNc8dxd+6
         5BW9dRL4odhZThzoh2J+WGqZewB9ozE60w9cSIe/lsNw9LCQhD7RHOL4rLK0TZlmaB
         DZu3wgaECasNs8+s1MrWHJd8k6yusEc6Fcvd4fj0=
Received: from localhost.localdomain ([106.92.97.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 97437848; Thu, 06 Apr 2023 22:37:52 +0800
X-QQ-mid: xmsmtpt1680791872tg9f5s5up
Message-ID: <tencent_F38839D00FE579A60A97BA24E86AF223DD05@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaiJEzhjgU8ytkJfB1HDRKtg7Fd+8CHLY7ORzeoC4dQeH9goKvkt
         /cKF2i7N9bzUI7rUfqXCbfKW22lUK809zNhFw/83CEaNgo1eSWdTxLYOKWdPBq2IVN2/U7cT+OcK
         GvYaNPCVamBKxQEVZqWyCIC8reZS4hvy7VxONmlsSGCiVsjateSnQXjXwZq5uRt4bPdkrJSopbtE
         LtRFgVvwvHDUEca5125SjMz1Q93GMzpNWkHXK9/EjZdlmq9ypmtl8ZM0XXeFCBJpEZQyElj+VxUP
         K+trdsPMN5jsTRTwYeoiq7aMIy4W6HGV1rfRbtlsgNjSELmz0/K5x03BPPZxmviBLVAVV+MhfSgJ
         TXWAQaEFwuslAMnMGuP08id5LvZZ64iTcvK3z7hDGxBAhUTX052+if6uZgNlnx3PpN09hbs6ytCo
         Hs8+GqL20zqFU8Mmt46mkjMe4U3iHdWGGdgqU8TOGXO1agkJJibVfiGYin1iU7JJI/KuCqa10sox
         swjfRlGxe4NwsiKJ84DODJGqEnIxq0vUlT/mnoxNfQhEqp2pICR210/y1LXoY2FecLBAkaj4VNSD
         LdDMqeaNQXPm4snDMYxgJCiu0fJc5lLEN2fj7H/9pUZpGYVgSzIqixGAU50Xv1LNkt4nYx1M028a
         UQR8iAxmpDBnOFb53J1tHOQwiCA0xAnoGZKt6o8lbpysMWWsr1H0auNgVMz/tzJP9MsWGparlelU
         fUYYeFySIcAWmICBvSU1DTjXz0OlLFcHWhSYNIoaYUIzfAjvzPwB/t9qA+HI+Zo45iYAX38InsX2
         wCMx/m18CkvFzVHonuGF4sUlOTQM+ATE3jrxZeiEBjkyhNmMNXCBz2w0LuLrCSpp4uMgKz2mdzB/
         BjMrYML1LJUtNrQLtNKcJIswoEzMj7UOBe/ATMLX+wXWKrw3rskyY0+5CnFwbFQ2UwMNMyuyghmn
         R2P6s2wFMW7z+elZpbtIiUXugQ5WRJaU4KmlRaZHd4/M0NATZ9B8IDbIGO6uO5ZCUSe1n9mEsXp8
         NzJoiAMQvpkxsFcJba2+pd242zq7bQLej9/m0E2Q==
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Thu,  6 Apr 2023 07:42:08 +0800
X-OQ-MSGID: <20230405234208.235509-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.2 required=5.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
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

