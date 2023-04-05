Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB36D86C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjDETWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDETWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:22:12 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF2619B;
        Wed,  5 Apr 2023 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1680722526;
        bh=bxOssrZ9p9edKrGOiBzAQqPL3Zbov8F9eu6w8/r57AY=;
        h=From:To:Cc:Subject:Date;
        b=h83ld2ciRGFg9XAgqEoFGe8kahjEeACGalZ/CsGFBDZuFiqIqHfBvKday4N7B/S1L
         ekypLw9t6sdxIF+zC6niQdnhF9s9sQdZsWezfa4e1Gx6oMUXgkHDDJaQgeBWuIvwkd
         4c8ogu7/IzzMVaJFhFNuTeoTQgPWDMDKR7WSBoLg=
Received: from wen-VirtualBox.lan ([106.92.97.36])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 5808F8A9; Thu, 06 Apr 2023 03:22:00 +0800
X-QQ-mid: xmsmtpt1680722520tvhd1dmos
Message-ID: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
X-QQ-XMAILINFO: MRw/zKT/0BpPOmBcxVwbT4iLv0RSfXAa7tRZuGbItYjMP9KJbNXJQY5dn8EsQt
         iu0FXvaWDBoaAcra6QNRb3xk0UE75zAziNTY90gkuUOEfpmhRSRu2A/sxRdznXgE6AfFGtYfeiZh
         dn/E+1u9TuLo0y+8CtMZ9vhoy/aecXGy1vKRJg3t8Fv1plWPaKMGn/lfPL+wZ5ZTEr/wv928k9IS
         z0dEVqVQ6ztthcBEUhQAVQ3ywD6VIRJNOlhU8xX75l0alv8sSlmFzrdND94QxwTfxPFzHZsquheJ
         ANFQgOmwUIu5fOpnAGjn1pq0/l5TUsGkuskS9pemxOTz3D51Kfd973Q1R4MWYsQ2D6EhUAksoqjr
         QjnvRRiGA6zuZFL8jExCLDiqRySkbZOHIUEiSpDiVC28IduPBljyVgyfjRZLHG4rWMABxyNm2bfk
         eRaXoo3t+U3J4xVrseT2jXVlp0Bmrj5sKEB4RcpaPHnYyJlwO67Eyfoy5SRdSacuV1B9f8o6mJc0
         JpuV1WOs6VTL/8Dr00keXy1mvwR3fwQAIE3axisJcAqQizQ8wbZ3w7tZzrVUXwk7i/bBj2PtVBqo
         u9RYa/SSJZT8PvlZsds1AiIi8r4J5a52F/0BBb/oSlwLgmaiRYryKNDL0ub7pRpWmj66Xo6mRuhS
         g47YiFBpFKdo3N5Z423y9ufqQm9OdyqUl8yBfg2/I02YiXmpPCEjdJFpmOsEf0Z2GOycG+/BdK0x
         WeN17gj4M9B4xXnDDt4Ou+VJAXWIMOUIY7m2QZL91Cbq43SthOvYN4dbTomOL0W0ga/7eraGKPch
         M7fkeAQboG50+PCeEwGTasIFUwX319+WtkX4sCZCkqAIr91MI/ccy6hQEHJ9c9QngbwbakL09vcQ
         YSX3XFc5sA8aWMJTBkJ5H9STKw53BunIfLllhyhCPGaeyfL/zwm9hrLA9SPOb3jJToaTcEOcy2Hi
         7B/CDNt4bsNBusZRkdLKTBoyn7TddAUsIyOu1ctmoNta6jmx8iwrx2ldmtigkQsEw+w+IOC333Uf
         qhgWeWBekwdmXolNFg
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Thu,  6 Apr 2023 03:20:02 +0800
X-OQ-MSGID: <20230405192002.48836-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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

