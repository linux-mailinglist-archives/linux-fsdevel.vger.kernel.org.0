Return-Path: <linux-fsdevel+bounces-10848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A7384EAF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9874C289A47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A424F605;
	Thu,  8 Feb 2024 21:55:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB94F5F1;
	Thu,  8 Feb 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429348; cv=none; b=kvbYqV5Zs8ir0CC5JwDAShwgSzMjpJHbE2t+1Y9SAJ+sUfkdN9eM+ohxxDcEyYNTU4kPwEDvTOAORakQlWVdH9+liwkzsfp9ZD+BTzNUQMbD42pP/7Bm11DaHnaRMguX3OZcuUgvYq/30jIPSQQw7JugZU2PmgjmAiZFBsyfyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429348; c=relaxed/simple;
	bh=J+c0BcmQhQDSvW0867pgNWBBImYdT8ll+zGLNGru5Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3/iMmW8xASAddtZ/qqc98Mbd/bXuQvmnmKckrNiY0U1y9/v5g340BuZ5gkdfqWXFrFODZ86K+GjeR6nIveHmElmN746KNu0uUyzqivWUbLgOyhLk3h+4ym6QSlQohD8IQkap26FqsTjWv2+Nm+LTBTSBe4xUJCVgd+XNYT0og8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d958e0d73dso2887295ad.1;
        Thu, 08 Feb 2024 13:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429345; x=1708034145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ9PD8mdvinv/WwVMMAsHYkNKSpwgA1F6ZEMvLuB0jo=;
        b=sYT97kXQ8Pl6XDjF7zou+NnQJJd1bL3ZXt+RwU37B7DUVEhKXe2RVgQFB5wFW9bHCj
         /+rNjf7cbBvMSkaXUqjRSusFIbfgaHw4dUZdLjLnGcZMHQHyOyI+ccyZ9Z/96FW7W//Q
         hxBOppLd50qJXYlduDTg6GzSdR3jn9CS8YJUxqFu5gRtHwY7drXU1qKeLjTT1eci7S0o
         LjYICUv+iMwD9Sx8fynTxQtb3eX8J/nV4O5zBufCON1ozFtouMuRJnVhDTsl+t21vqdT
         4IqDjssN0XiIn/t694eLvzbwCkw7k34rB39o4/9jtlTVHRIORxUuBMFMicrmAtkw183h
         0qiw==
X-Gm-Message-State: AOJu0YxiRpCrXDDE6hSxF1Rn10TVRGm04rt45nkU8ReOe+zSeOIhyDF1
	Hoz48kd4XbLltiP273z9c0x2ZzTNLX8qhNT/b7nAWNUhDyFZQZl9
X-Google-Smtp-Source: AGHT+IGkcUmTh8dlF+BQEToQ3doxGETlSiKh9Cmb7FOVH3jMTTOuOQSMqHjAUynZt3cC5ggVjGifSQ==
X-Received: by 2002:a17:902:ed11:b0:1d9:ef4f:376b with SMTP id b17-20020a170902ed1100b001d9ef4f376bmr1133992pld.8.1707429345058;
        Thu, 08 Feb 2024 13:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnvNUiENF5LnUnD3WWRkoHAL14E68njjYmgLjXlBK4OBiVM2LFopj3iwfqwIrUQPZEXfIZiM2RgLvA2ef69MfPHdx+1bmGHf9Ok2pUIJyd27hqX5icUI3ES6jawm1JquVHF9sARFAy0AnolQrI8W+q6mC/GDd18C8XV0t7aAdxa9IzG+FrnzOQCAb07EtllkqgKa1SS+52xeCX0QHV11DRF+kz6O6Li//Mat048UKtqOzS7KyJm9D8sRsCiypL+lrd8BCPiM4kuzH8y+AYdmg3u6Q=
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9d77:6767:98c9:caf2])
        by smtp.gmail.com with ESMTPSA id ko13-20020a17090307cd00b001d88d791eccsm233980plb.160.2024.02.08.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:55:44 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Date: Thu,  8 Feb 2024 13:55:18 -0800
Message-ID: <20240208215518.1361570-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
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

Several ideas in this patch come from the following patch: Christoph
Hellwig, "[PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
cancel_kiocb file operation", May 2018
(https://lore.kernel.org/all/20180515194833.6906-9-hch@lst.de/).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/gadget/function/f_fs.c |  19 +----
 drivers/usb/gadget/legacy/inode.c  |  12 +--
 fs/aio.c                           | 129 +++++++++++++++++++----------
 include/linux/aio.h                |   7 --
 include/linux/fs.h                 |   1 +
 5 files changed, 90 insertions(+), 78 deletions(-)

Changes compared to v1:
 - Fixed a race between request completion and addition to the list of
   active requests.
 - Changed the return type of .cancel_kiocb() from int into void.
 - Simplified the .cancel_kiocb() implementations.
 - Introduced the ki_opcode member in struct aio_kiocb.
 - aio_cancel_and_del() checks .ki_opcode before accessing union members.
 - Left out the include/include/mm changes.

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..4837e3071263 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -31,7 +31,6 @@
 #include <linux/usb/composite.h>
 #include <linux/usb/functionfs.h>
 
-#include <linux/aio.h>
 #include <linux/kthread.h>
 #include <linux/poll.h>
 #include <linux/eventfd.h>
@@ -1157,23 +1156,16 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static int ffs_aio_cancel(struct kiocb *kiocb)
+static void ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
 	unsigned long flags;
-	int value;
 
 	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
-
 	if (io_data && io_data->ep && io_data->req)
-		value = usb_ep_dequeue(io_data->ep, io_data->req);
-	else
-		value = -EINVAL;
-
+		usb_ep_dequeue(io_data->ep, io_data->req);
 	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
-
-	return value;
 }
 
 static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
@@ -1198,9 +1190,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1242,9 +1231,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1356,6 +1342,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
+	.cancel_kiocb = ffs_epfile_cancel_kiocb,
 };
 
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 03179b1880fd..c2cf7fca6937 100644
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
@@ -446,23 +445,18 @@ struct kiocb_priv {
 	unsigned		actual;
 };
 
-static int ep_aio_cancel(struct kiocb *iocb)
+static void ep_cancel_kiocb(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
 	struct ep_data		*epdata;
-	int			value;
 
 	local_irq_disable();
 	epdata = priv->epdata;
 	// spin_lock(&epdata->dev->lock);
 	if (likely(epdata && epdata->ep && priv->req))
-		value = usb_ep_dequeue (epdata->ep, priv->req);
-	else
-		value = -EINVAL;
+		usb_ep_dequeue(epdata->ep, priv->req);
 	// spin_unlock(&epdata->dev->lock);
 	local_irq_enable();
-
-	return value;
 }
 
 static void ep_user_copy_worker(struct work_struct *work)
@@ -537,7 +531,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
 	iocb->private = priv;
 	priv->iocb = iocb;
 
-	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
 	get_ep(epdata);
 	priv->epdata = epdata;
 	priv->actual = 0;
@@ -709,6 +702,7 @@ static const struct file_operations ep_io_operations = {
 	.unlocked_ioctl = ep_ioctl,
 	.read_iter =	ep_read_iter,
 	.write_iter =	ep_write_iter,
+	.cancel_kiocb = ep_cancel_kiocb,
 };
 
 /* ENDPOINT INITIALIZATION
diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..9dc0be703aa6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -203,7 +203,6 @@ struct aio_kiocb {
 	};
 
 	struct kioctx		*ki_ctx;
-	kiocb_cancel_fn		*ki_cancel;
 
 	struct io_event		ki_res;
 
@@ -211,6 +210,8 @@ struct aio_kiocb {
 						 * for cancellation */
 	refcount_t		ki_refcnt;
 
+	u16			ki_opcode;	/* IOCB_CMD_* */
+
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -587,22 +588,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
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
@@ -634,6 +619,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	queue_rcu_work(system_wq, &ctx->free_rwork);
 }
 
+static void aio_cancel_and_del(struct aio_kiocb *req);
+
 /*
  * When this function runs, the kioctx has been removed from the "hash table"
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
@@ -649,8 +636,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+		aio_cancel_and_del(req);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1552,6 +1538,24 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
 	return __import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter, compat);
 }
 
+static void aio_add_rw_to_active_reqs(struct kiocb *req)
+{
+	struct aio_kiocb *aio = container_of(req, struct aio_kiocb, rw);
+	struct kioctx *ctx = aio->ki_ctx;
+	unsigned long flags;
+
+	/*
+	 * If the .cancel_kiocb() callback has been set, add the request
+	 * to the list of active requests.
+	 */
+	if (!req->ki_filp->f_op->cancel_kiocb)
+		return;
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	list_add_tail(&aio->ki_list, &ctx->active_reqs);
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+}
+
 static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 {
 	switch (ret) {
@@ -1593,8 +1597,10 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret)
+	if (!ret) {
+		aio_add_rw_to_active_reqs(req);
 		aio_rw_done(req, call_read_iter(file, req, &iter));
+	}
 	kfree(iovec);
 	return ret;
 }
@@ -1622,6 +1628,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
+		aio_add_rw_to_active_reqs(req);
 		if (S_ISREG(file_inode(file)->i_mode))
 			kiocb_start_write(req);
 		req->ki_flags |= IOCB_WRITE;
@@ -1715,6 +1722,54 @@ static void poll_iocb_unlock_wq(struct poll_iocb *req)
 	rcu_read_unlock();
 }
 
+/* Must be called only for IOCB_CMD_POLL requests. */
+static void aio_poll_cancel(struct aio_kiocb *aiocb)
+{
+	struct poll_iocb *req = &aiocb->poll;
+	struct kioctx *ctx = aiocb->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (!poll_iocb_lock_wq(req))
+		return;
+
+	WRITE_ONCE(req->cancelled, true);
+	if (!req->work_scheduled) {
+		schedule_work(&aiocb->poll.work);
+		req->work_scheduled = true;
+	}
+	poll_iocb_unlock_wq(req);
+}
+
+static void aio_cancel_and_del(struct aio_kiocb *req)
+{
+	void (*cancel_kiocb)(struct kiocb *) =
+		req->rw.ki_filp->f_op->cancel_kiocb;
+	struct kioctx *ctx = req->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	switch (req->ki_opcode) {
+	case IOCB_CMD_PREAD:
+	case IOCB_CMD_PWRITE:
+	case IOCB_CMD_PREADV:
+	case IOCB_CMD_PWRITEV:
+		if (cancel_kiocb)
+			cancel_kiocb(&req->rw);
+		break;
+	case IOCB_CMD_FSYNC:
+	case IOCB_CMD_FDSYNC:
+		break;
+	case IOCB_CMD_POLL:
+		aio_poll_cancel(req);
+		break;
+	default:
+		WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
+	}
+
+	list_del_init(&req->ki_list);
+}
+
 static void aio_poll_complete_work(struct work_struct *work)
 {
 	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
@@ -1727,11 +1782,11 @@ static void aio_poll_complete_work(struct work_struct *work)
 		mask = vfs_poll(req->file, &pt) & req->events;
 
 	/*
-	 * Note that ->ki_cancel callers also delete iocb from active_reqs after
-	 * calling ->ki_cancel.  We need the ctx_lock roundtrip here to
-	 * synchronize with them.  In the cancellation case the list_del_init
-	 * itself is not actually needed, but harmless so we keep it in to
-	 * avoid further branches in the fast path.
+	 * aio_cancel_and_del() deletes the iocb from the active_reqs list. We
+	 * need the ctx_lock here to synchronize with aio_cancel_and_del(). In
+	 * the cancellation case the list_del_init itself is not actually
+	 * needed, but harmless so we keep it in to avoid further branches in
+	 * the fast path.
 	 */
 	spin_lock_irq(&ctx->ctx_lock);
 	if (poll_iocb_lock_wq(req)) {
@@ -1760,24 +1815,6 @@ static void aio_poll_complete_work(struct work_struct *work)
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
@@ -1945,7 +1982,6 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 			 * active_reqs so that it can be cancelled if needed.
 			 */
 			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
-			aiocb->ki_cancel = aio_poll_cancel;
 		}
 		if (on_queue)
 			poll_iocb_unlock_wq(req);
@@ -1993,6 +2029,8 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	req->ki_res.res = 0;
 	req->ki_res.res2 = 0;
 
+	req->ki_opcode = iocb->aio_lio_opcode;
+
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
 		return aio_read(&req->rw, iocb, false, compat);
@@ -2189,8 +2227,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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
index ed5966a70495..7ec714878637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2021,6 +2021,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	void (*cancel_kiocb)(struct kiocb *);
 } __randomize_layout;
 
 /* Wrap a directory iterator that needs exclusive inode access */

