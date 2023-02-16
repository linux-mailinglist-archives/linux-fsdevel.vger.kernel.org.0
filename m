Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A178769958C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 14:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBPNTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 08:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBPNTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:19:17 -0500
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830855A9;
        Thu, 16 Feb 2023 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1676553553;
        bh=KhLIQn1nRpMe0qe3qC/c0JThjzwovc1ATByKz1BoxQs=;
        h=From:To:Cc:Subject:Date;
        b=mJtgZRg+iUz++zdyfs3WtBioVhZe2cZn3UD6UH2+kYG3dbwr+wKFFjIIQOhH0xjEJ
         bhELfMjmOg2e+qd/DaopBABUEsAdtZvIwfKNgyTUp2waYx0s/GjXFsqWOCWKr2byej
         p+vNb0xxnT/7Qm7q9S5TcRFvZ0e8JhSliTlp7p/0=
Received: from localhost.localdomain ([222.182.118.161])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id 47107C78; Thu, 16 Feb 2023 21:17:49 +0800
X-QQ-mid: xmsmtpt1676553469tde6widka
Message-ID: <tencent_47F9893DA354D9509F06DD4C52A7EB30130A@qq.com>
X-QQ-XMAILINFO: MAehWEgsdgwGizySxY9t5M4K/wNKQ08/FL35yST6mq3FuiDqOOextsvC5qcr8E
         +gU4AxKxogDmEA2c5WkRU+E86X0RndGXqsWzWvTBhAKWXNQ5RI03w/C+kWvQGrIQRg83p9n7HBNG
         0QIx5sT7E1pIBC+zEDECjR39xMmgd0ysUO8TQc2wN2T9zi6r6p9udgOrD8X+r35IeuigGHAv229B
         unJ3DGvIN9PVnhjoMyYfYZA/BIeNZ2oXlaRKanw/vrhsgEghB+B7i+RaGu5CPYWC3B0sa3VjNkiv
         h77wXyQtXFNcW6ulNHaGQKSiZ/xcLrVI3gMwEB47Yzf19kdT7WAu18k6j7YuxPIqCMTMnBWgUWki
         8ILe2i3C1LAQmr5YPKL+CIRs57l4F2FyDV5alHbw+ZdEnU6wb93Y/YnNgI7YaFStnx7DYhPmAuzd
         rxd+LAt7XWx7ThTqJlgMIPBZEipWVzGX6usJoaj3Uf4Wct+oBMSmVsOfca92WqRa8N7xkv8Uu9uz
         I7bfWj6XshRQgsIjrKUORhmN4H3UEn+DHFz+kuDXfCOIJ8xqA1uF+pMopquQCg6YqcGzPKPnCDIY
         Er3czH+3ESXNDO+69NdSgj5ic18rPZKoahCjBJgFR0+a22ZgJTDUK20DMGi7HIXWfgjEjhbOnMwL
         FMl+JcUlqAzKibOMLj6wvusuMsGzLWksvjGfLDdZcNmQK9nk8yzf50IQoGCojzZRgG/9RKZyIxAg
         ScCVP3ni9+tIiQWpknAe1BTrTa3Sbx19Opq1oALZxxq2pyM9Z0RpJMxqEBwLygUqFXdCAkTOyHkv
         b7KEtgTyGGlAoYMNMw5F1nVRe6dRjJf+uu0YBLVlU3PQannK2ETdbLJdmnjQmDdJ/Sy64GGOCnZX
         4xwJrXZzTn0Q9lRV5QJ0tBNEWeXV66s8xIQVOoujzx+1sX1BQa7bj58yZMClx4STlSlQXl3OQ7hi
         AyklrpAmUrlMe79blEIret94Q4LUYxbeVm1cglo8k3ssw+LrcRMamFDDm2lLhYCtmkhah4ryiFJ3
         9kH8Fv3g==
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Thu, 16 Feb 2023 21:17:39 +0800
X-OQ-MSGID: <20230216131739.823787-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 249ca6c0b784..2b6a8a4d80a1 100644
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
@@ -288,23 +274,9 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
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
+		res = wait_event_interruptible_locked_irq(
+				ctx->wqh, ULLONG_MAX - ctx->count > ucnt) ?
+			-ERESTARTSYS : sizeof(ucnt);
 	}
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
-- 
2.37.2

