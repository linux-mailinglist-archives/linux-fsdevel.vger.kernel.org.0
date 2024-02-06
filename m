Return-Path: <linux-fsdevel+bounces-10537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873284C10A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F061F237E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674C1CD27;
	Tue,  6 Feb 2024 23:47:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68E1CD13
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263248; cv=none; b=Kn+eEAzhTvl5yz/6RFQ1UQuwqnrL7Zoe4MAXYMo/T66Hw6DRkoeDDe0+rsVnpB3GJbUd8GcdS7gr8KH/vH1DURMxGCv712jnnz6wlxa9OwwatQvkZDAonqNKCVXrKcFsOKW1cSuXxCHNi7Z8K4UHn8DlbmV5risxcYKVlm1EJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263248; c=relaxed/simple;
	bh=EZd79GOUg/F5PbwnY9tFL74Is55UPwvLZOxLjSu18uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vs4GMGXmIIFCWouOw5dPWFzEv4lMbls/cuZiCPisQpKmx9dO1WbSaU+OJZeCAA8Ofsd6gVzP7d/pSbnfa95w2J/HowXE6Zv3kacOxjT2Tggb1bYlNwHqAROvbrUuw8QoO5RO0TBpZZvEV14FJeGUpYEwYtmwZ8YbBmJYHBvobrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93f2c3701so503085ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 15:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707263243; x=1707868043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWasxGtyfY7ChFvrSTUIv0FvBzGbF1PbfMNNX0w6pBs=;
        b=EuYcZyX5XemceO1r9fLfheFNB5STvusgbKkZKV2sBRM4k+1sMrxatp+ihZXPs89lHJ
         CaWjfEXgZgkx+nIdmByiBbuiA0MMOYKIJNqpwBE5BOjwSPhiDuGB7fMAoi+BhHnDEggV
         P2DG5z6J326EJSSVKQ0yE9lMpnVMA9TjAyeiWGazfpFcQiokOzM37xX9IZA+0S5fXLRS
         PBrO5Pk19XWGpRmiYSI2pHkAcRWXZbBvaUZAQLroifLV+HevhD8qfA3ZUmRHRO/IL6q+
         xMlXnsqwyJQA+zQr8uQ4DxZ2pdM2yaqN3rYw4ncDxNPWG4ZuP9xObekKqeax018rvSrb
         NXFg==
X-Gm-Message-State: AOJu0YwiwEumgXoEQMq55dA742PQJPIuq1bvLKljfUHgyXp+TZwLLHHG
	7CMYk9aX3tHYmKHwq7CEOFvJrf+5UemO0qyl7XM1XHJXeleIUFdI+nDOTvxQ
X-Google-Smtp-Source: AGHT+IEh6YGTIJL24OezPtzRYCrIBUA+hMP7sj+RRGUKF5Rbu2xzqQ6LuiOkRdaB0UeCHvMAaJs/kQ==
X-Received: by 2002:a17:903:40c5:b0:1d9:8b58:c9f1 with SMTP id t5-20020a17090340c500b001d98b58c9f1mr3792178pld.6.1707263243365;
        Tue, 06 Feb 2024 15:47:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1fRwC+6yh1hnxcvt5dq/3/kq54HUOLAwQAplNHO+F3kroLlp5HyhbLL/+9oJZTBFTX2s7uwkLrT00+oullA0hgVBkdd9oj9DHVZHkmPINK1I67lt04U4dddz9q4ujs9+G5ohKsmNPjkSsEpUbSRqPap70wp5qLjLN9hyqEdq0iWLcT53Al0j3wmFOXXLE1SP87QTOdheT0Saewxs0JazATQT3Od05B1wHKhf4h4zr9gha/keBPIm1ePY=
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:8633:8b18:c51e:4bae])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001d7915fc630sm81559plc.307.2024.02.06.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:47:22 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fs, USB gadget: Rework kiocb cancellation
Date: Tue,  6 Feb 2024 15:47:18 -0800
Message-ID: <20240206234718.1437772-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling kiocb_set_cancel_fn() without knowing whether the caller
submitted a struct kiocb or a struct aio_kiocb is unsafe. Fix this by
introducing the cancel_kiocb() method in struct file_operations. The
following call trace illustrates that without this patch an
out-of-bounds write happens if I/O is submitted by io_uring (from a
phone with an ARM CPU and kernel 6.1):

WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
Call trace:
 kiocb_set_cancel_fn+0x9c/0xa8
 ffs_epfile_read_iter+0x144/0x1d0
 io_read+0x19c/0x498
 io_issue_sqe+0x118/0x27c
 io_submit_sqes+0x25c/0x5fc
 __arm64_sys_io_uring_enter+0x104/0xab0
 invoke_syscall+0x58/0x11c
 el0_svc_common+0xb4/0xf4
 do_el0_svc+0x2c/0xb0
 el0_svc+0x2c/0xa4
 el0t_64_sync_handler+0x68/0xb4
 el0t_64_sync+0x1a4/0x1a8

The following patch has been used as the basis of this patch: Christoph
Hellwig, "[PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
cancel_kiocb file operation", May 2018
(https://lore.kernel.org/all/20180515194833.6906-9-hch@lst.de/).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/gadget/function/f_fs.c | 10 +---
 drivers/usb/gadget/legacy/inode.c  |  5 +-
 fs/aio.c                           | 93 +++++++++++++++++-------------
 include/linux/aio.h                |  7 ---
 include/linux/fs.h                 |  1 +
 include/linux/mm.h                 |  5 ++
 include/linux/mm_inline.h          |  5 ++
 7 files changed, 68 insertions(+), 58 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..adc00689fe3b 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -31,7 +31,6 @@
 #include <linux/usb/composite.h>
 #include <linux/usb/functionfs.h>
 
-#include <linux/aio.h>
 #include <linux/kthread.h>
 #include <linux/poll.h>
 #include <linux/eventfd.h>
@@ -1157,7 +1156,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static int ffs_aio_cancel(struct kiocb *kiocb)
+static int ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
@@ -1198,9 +1197,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1242,9 +1238,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1356,6 +1349,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
+	.cancel_kiocb = ffs_epfile_cancel_kiocb,
 };
 
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 03179b1880fd..a4c03cfb3baa 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/kthread.h>
-#include <linux/aio.h>
 #include <linux/uio.h>
 #include <linux/refcount.h>
 #include <linux/delay.h>
@@ -446,7 +445,7 @@ struct kiocb_priv {
 	unsigned		actual;
 };
 
-static int ep_aio_cancel(struct kiocb *iocb)
+static int ep_cancel_kiocb(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
 	struct ep_data		*epdata;
@@ -537,7 +536,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
 	iocb->private = priv;
 	priv->iocb = iocb;
 
-	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
 	get_ep(epdata);
 	priv->epdata = epdata;
 	priv->actual = 0;
@@ -709,6 +707,7 @@ static const struct file_operations ep_io_operations = {
 	.unlocked_ioctl = ep_ioctl,
 	.read_iter =	ep_read_iter,
 	.write_iter =	ep_write_iter,
+	.cancel_kiocb = ep_cancel_kiocb,
 };
 
 /* ENDPOINT INITIALIZATION
diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..0b13d6be773d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -203,7 +203,6 @@ struct aio_kiocb {
 	};
 
 	struct kioctx		*ki_ctx;
-	kiocb_cancel_fn		*ki_cancel;
 
 	struct io_event		ki_res;
 
@@ -587,22 +586,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
-{
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
-		return;
-
-	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
-	req->ki_cancel = cancel;
-	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-}
-EXPORT_SYMBOL(kiocb_set_cancel_fn);
-
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
@@ -634,6 +617,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	queue_rcu_work(system_wq, &ctx->free_rwork);
 }
 
+static void aio_cancel_and_del(struct aio_kiocb *req);
+
 /*
  * When this function runs, the kioctx has been removed from the "hash table"
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
@@ -649,8 +634,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+		aio_cancel_and_del(req);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1556,6 +1540,20 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 {
 	switch (ret) {
 	case -EIOCBQUEUED:
+		/*
+		 * If the .cancel_kiocb() callback has been set, add the request
+		 * to the list of active requests.
+		 */
+		if (req->ki_filp->f_op->cancel_kiocb) {
+			struct aio_kiocb *iocb =
+				container_of(req, struct aio_kiocb, rw);
+			struct kioctx *ctx = iocb->ki_ctx;
+			unsigned long flags;
+
+			spin_lock_irqsave(&ctx->ctx_lock, flags);
+			list_add_tail(&iocb->ki_list, &ctx->active_reqs);
+			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+		}
 		break;
 	case -ERESTARTSYS:
 	case -ERESTARTNOINTR:
@@ -1715,6 +1713,41 @@ static void poll_iocb_unlock_wq(struct poll_iocb *req)
 	rcu_read_unlock();
 }
 
+/* assumes we are called with irqs disabled */
+static int aio_poll_cancel(struct aio_kiocb *aiocb)
+{
+	struct poll_iocb *req = &aiocb->poll;
+	struct kioctx *ctx = aiocb->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (!poll_iocb_lock_wq(req)) {
+		/* Not a polled request or already cancelled. */
+		return 0;
+	}
+
+	WRITE_ONCE(req->cancelled, true);
+	if (!req->work_scheduled) {
+		schedule_work(&aiocb->poll.work);
+		req->work_scheduled = true;
+	}
+	poll_iocb_unlock_wq(req);
+
+	return 0;
+}
+
+static void aio_cancel_and_del(struct aio_kiocb *req)
+{
+	struct kioctx *ctx = req->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (req->rw.ki_filp->f_op->cancel_kiocb)
+		req->rw.ki_filp->f_op->cancel_kiocb(&req->rw);
+	aio_poll_cancel(req);
+	list_del_init(&req->ki_list);
+}
+
 static void aio_poll_complete_work(struct work_struct *work)
 {
 	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
@@ -1760,24 +1793,6 @@ static void aio_poll_complete_work(struct work_struct *work)
 	iocb_put(iocb);
 }
 
-/* assumes we are called with irqs disabled */
-static int aio_poll_cancel(struct kiocb *iocb)
-{
-	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
-	struct poll_iocb *req = &aiocb->poll;
-
-	if (poll_iocb_lock_wq(req)) {
-		WRITE_ONCE(req->cancelled, true);
-		if (!req->work_scheduled) {
-			schedule_work(&aiocb->poll.work);
-			req->work_scheduled = true;
-		}
-		poll_iocb_unlock_wq(req);
-	} /* else, the request was force-cancelled by POLLFREE already */
-
-	return 0;
-}
-
 static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		void *key)
 {
@@ -1945,7 +1960,6 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 			 * active_reqs so that it can be cancelled if needed.
 			 */
 			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
-			aiocb->ki_cancel = aio_poll_cancel;
 		}
 		if (on_queue)
 			poll_iocb_unlock_wq(req);
@@ -2189,8 +2203,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	/* TODO: use a hash or array, this sucks. */
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
 		if (kiocb->ki_res.obj == obj) {
-			ret = kiocb->ki_cancel(&kiocb->rw);
-			list_del_init(&kiocb->ki_list);
+			aio_cancel_and_del(kiocb);
 			break;
 		}
 	}
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 86892a4fe7c8..2aa6d0be3171 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -4,20 +4,13 @@
 
 #include <linux/aio_abi.h>
 
-struct kioctx;
-struct kiocb;
 struct mm_struct;
 
-typedef int (kiocb_cancel_fn)(struct kiocb *);
-
 /* prototypes */
 #ifdef CONFIG_AIO
 extern void exit_aio(struct mm_struct *mm);
-void kiocb_set_cancel_fn(struct kiocb *req, kiocb_cancel_fn *cancel);
 #else
 static inline void exit_aio(struct mm_struct *mm) { }
-static inline void kiocb_set_cancel_fn(struct kiocb *req,
-				       kiocb_cancel_fn *cancel) { }
 #endif /* CONFIG_AIO */
 
 #endif /* __LINUX__AIO_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..36cd982c167d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2021,6 +2021,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*cancel_kiocb)(struct kiocb *);
 } __randomize_layout;
 
 /* Wrap a directory iterator that needs exclusive inode access */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..7c05464c0ad0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1092,6 +1092,11 @@ static inline unsigned int folio_order(struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+/*
+ * Include <linux/fs.h> to work around a circular dependency between
+ * <linux/fs.h> and <linux/huge_mm.h>.
+ */
+#include <linux/fs.h>
 #include <linux/huge_mm.h>
 
 /*
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..4eb96f08ec4f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -3,6 +3,11 @@
 #define LINUX_MM_INLINE_H
 
 #include <linux/atomic.h>
+/*
+ * Include <linux/fs.h> to work around a circular dependency between
+ * <linux/fs.h> and <linux/huge_mm.h>.
+ */
+#include <linux/fs.h>
 #include <linux/huge_mm.h>
 #include <linux/mm_types.h>
 #include <linux/swap.h>

