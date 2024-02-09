Return-Path: <linux-fsdevel+bounces-11011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C597A84FCE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4D28F721
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873D83CB9;
	Fri,  9 Feb 2024 19:31:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181757861;
	Fri,  9 Feb 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507061; cv=none; b=Bz8WmMTczAjxXZPOVk3AOhxp/etxhkRRqd/FPH9BMt4ow3rO4mBx6YUXLWhHn69ZcB/fHq46eitiQ+R2Jl3KJsmEZOYLiAT3vWaRferLmWSdGjnIbwxNm+lCcfj30yliRA3zl5NxD7XxHjlyhKxq600z7cjjvmKS6PBKM2yC2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507061; c=relaxed/simple;
	bh=WXRgWOknpTQHPieGhlgqrTz8Si/I9po/JG56mWDuIZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgA9NWQoSTu2qH5O6BQuO30A3gyEocH+9hXpGBZURxcsYvLA3qq7q13WiB6IA9Lao/l5a/4CJjPNgoCi0CaBLR0ZYra/Bo3Wak3SVA1a2ib9vDrV4WKv1lPxsjNkdfuFX711KCbppOFtWZnoB/h2hVMK+QltsdJwsBtzT01RwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1145506b3a.0;
        Fri, 09 Feb 2024 11:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507059; x=1708111859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncSl4GRsIOjORenB835GQXRTcvK/RjBEKaRERWdIdNU=;
        b=myGKUzHkOcNiTSsI/pCCGIH97fUD56tI8Cq3pSkzao58dIj1WiSd4oFsNSOrhWfp2w
         2nKX0T+Pyq8fLlCd4S6lElyzqR1MUjnzlV8GN8IZVIdns8HJJ+w5P6/5JkOCuLhDIYs2
         0TMwPASiYTdCCr13DANy43VbSYph6dpFX/YFnBqkcdrHwkiATAE3kXFCTaGfVFqS0IPY
         ySJc1tdE3zZh4jSIFTVhXaUvp79JrJ4GY7WYsvhSb50w+TSQx944CqMjqj2XREFuHEcl
         q9+T2/iZFIBHk38NsCbziH0X2/atg4UPy8dFrRjqhPXmi44rtxFLvJ0ySY0DTLGTAYBS
         Quhg==
X-Gm-Message-State: AOJu0YxHRUKlql/gyvf0YOplbiQmqToYa39GCAJ8YBjpzzzfTUhlYqr4
	q7IE46cYqQziqGT/82RamjPmw0CzvweVGYNRSm/g3qWhCZ4p1Hb7
X-Google-Smtp-Source: AGHT+IHOw0k4TTHBpPaj6e8Ar5UGnJNf4BRp5Gf+qWoJDoQplxoaz+YMvk1x2wADT/4UnAsFpA2cHw==
X-Received: by 2002:aa7:8597:0:b0:6da:c7ce:ef53 with SMTP id w23-20020aa78597000000b006dac7ceef53mr246645pfn.3.1707507058365;
        Fri, 09 Feb 2024 11:30:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7eqeOF5n2ARJzoaMiAON+umgWJDE3Lppvwddf7rXB3W/oCiXcLDZrnd7gxsZyfkzFOPLb8v8JzBvEBTypM2s5MzP9jA5hPsJPgNLIZdY0PiPhR9kuuzCSswsjMSO/kZRnQT7Y7LNUAcq6UtdtYGWzWZ1YZ3NNTT0Ma87xDVFfFh7Nz1NoRTfSI1e6/iYXJxxdiWI6t7ZXqFudibe9G2WDxXWGjOtoFBE0HM6/oNcqUS6RYyDJY4BgpZNKGBwim7tqEvIuRFbMMq+N/MX3ls7LlmU=
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9d77:6767:98c9:caf2])
        by smtp.gmail.com with ESMTPSA id e25-20020a62aa19000000b006dbd3aec001sm923895pff.146.2024.02.09.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:30:57 -0800 (PST)
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
Subject: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Date: Fri,  9 Feb 2024 11:30:26 -0800
Message-ID: <20240209193026.2289430-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally io_cancel() only supported cancelling USB reads and writes.
If I/O was cancelled successfully, information about the cancelled I/O
operation was copied to the data structure the io_cancel() 'result'
argument points at. Commit 63b05203af57 ("[PATCH] AIO: retry
infrastructure fixes and enhancements") changed the io_cancel() behavior
from reporting status information via the 'result' argument into
reporting status information on the completion ring. Commit 41003a7bcfed
("aio: remove retry-based AIO") accidentally changed the behavior into
not reporting a completion event on the completion ring for cancelled
requests. This is a bug because successful cancellation leads to an iocb
leak in user space. Since this bug was introduced more than ten years
ago and since nobody has complained since then, remove support for I/O
cancellation. Keep support for cancellation of IOCB_CMD_POLL requests.

Calling kiocb_set_cancel_fn() without knowing whether the caller
submitted a struct kiocb or a struct aio_kiocb is unsafe. The
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

Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 63b05203af57 ("[PATCH] AIO: retry infrastructure fixes and enhancements")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/gadget/function/f_fs.c | 25 -------------------
 drivers/usb/gadget/legacy/inode.c  | 20 ---------------
 fs/aio.c                           | 39 +++++-------------------------
 include/linux/aio.h                |  9 -------
 4 files changed, 6 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..59789292f4f7 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1157,25 +1157,6 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static int ffs_aio_cancel(struct kiocb *kiocb)
-{
-	struct ffs_io_data *io_data = kiocb->private;
-	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
-	unsigned long flags;
-	int value;
-
-	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
-
-	if (io_data && io_data->ep && io_data->req)
-		value = usb_ep_dequeue(io_data->ep, io_data->req);
-	else
-		value = -EINVAL;
-
-	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
-
-	return value;
-}
-
 static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 {
 	struct ffs_io_data io_data, *p = &io_data;
@@ -1198,9 +1179,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1242,9 +1220,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 03179b1880fd..99b7366d77af 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -446,25 +446,6 @@ struct kiocb_priv {
 	unsigned		actual;
 };
 
-static int ep_aio_cancel(struct kiocb *iocb)
-{
-	struct kiocb_priv	*priv = iocb->private;
-	struct ep_data		*epdata;
-	int			value;
-
-	local_irq_disable();
-	epdata = priv->epdata;
-	// spin_lock(&epdata->dev->lock);
-	if (likely(epdata && epdata->ep && priv->req))
-		value = usb_ep_dequeue (epdata->ep, priv->req);
-	else
-		value = -EINVAL;
-	// spin_unlock(&epdata->dev->lock);
-	local_irq_enable();
-
-	return value;
-}
-
 static void ep_user_copy_worker(struct work_struct *work)
 {
 	struct kiocb_priv *priv = container_of(work, struct kiocb_priv, work);
@@ -537,7 +518,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
 	iocb->private = priv;
 	priv->iocb = iocb;
 
-	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
 	get_ep(epdata);
 	priv->epdata = epdata;
 	priv->actual = 0;
diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..c20946d5fcf3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -203,7 +203,7 @@ struct aio_kiocb {
 	};
 
 	struct kioctx		*ki_ctx;
-	kiocb_cancel_fn		*ki_cancel;
+	int			(*ki_cancel)(struct kiocb *);
 
 	struct io_event		ki_res;
 
@@ -587,22 +587,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
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
@@ -2158,13 +2142,11 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 #endif
 
 /* sys_io_cancel:
- *	Attempts to cancel an iocb previously passed to io_submit.  If
- *	the operation is successfully cancelled, the resulting event is
- *	copied into the memory pointed to by result without being placed
- *	into the completion queue and 0 is returned.  May fail with
- *	-EFAULT if any of the data structures pointed to are invalid.
- *	May fail with -EINVAL if aio_context specified by ctx_id is
- *	invalid.  May fail with -EAGAIN if the iocb specified was not
+ *	Attempts to cancel an IOCB_CMD_POLL iocb previously passed to
+ *	io_submit(). If the operation is successfully cancelled 0 is returned.
+ *	May fail with -EFAULT if any of the data structures pointed to are
+ *	invalid.  May fail with -EINVAL if aio_context specified by ctx_id is
+ *	invalid.  May fail with -EINPROGRESS if the iocb specified was not
  *	cancelled.  Will fail with -ENOSYS if not implemented.
  */
 SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
@@ -2196,15 +2178,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-	if (!ret) {
-		/*
-		 * The result argument is no longer used - the io_event is
-		 * always delivered via the ring buffer. -EINPROGRESS indicates
-		 * cancellation is progress:
-		 */
-		ret = -EINPROGRESS;
-	}
-
 	percpu_ref_put(&ctx->users);
 
 	return ret;
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 86892a4fe7c8..9aabca4a0eed 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -2,22 +2,13 @@
 #ifndef __LINUX__AIO_H
 #define __LINUX__AIO_H
 
-#include <linux/aio_abi.h>
-
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

