Return-Path: <linux-fsdevel+bounces-2836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0C7EB3CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502EE1F2524B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736241AA9;
	Tue, 14 Nov 2023 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvTym/38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118A41A91
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:45 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6846D75
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408425c7c10so46870315e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976021; x=1700580821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko4DuETTQDsrHP5n6WDIpw77gVvQpoHQ8fh/EOMz2cA=;
        b=KvTym/389bAvPqgRHR3Q/PqdYTpXbXzLk2KD2K87uEQ6dsDicVvTY2RKIVoRdjOHyl
         FBUh0eHVlNLe9ZhVCDIpE3Q7WZOD4yYQNM8oXTS7lKpd2YbPk/hoUAh6qBO3uSQK3CZp
         kI30/IPs7M8vIwV4g9JrJZdOwRQDNvD+9r6Q2q4kPkyN/qHz6HBTcNYs4LPcM7ISAe0d
         q6gFjiNWeyRYj5CLjkujUy0/zvLJlojYx5nnyHZiq9SiCH3abBo3sal49LrRO7qYmbBg
         UP32AEKF7u2DgI7YgKxzkejJ59DYpkiqKu+QMrmvXwbbvPse0x1DXnVpSzoxkGRrxxz7
         fbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976021; x=1700580821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko4DuETTQDsrHP5n6WDIpw77gVvQpoHQ8fh/EOMz2cA=;
        b=bSfnJWzEmBrDDRwVgtHAte5LtBu94DFEwTUVz8UONbqN6IzlT/cItqaiqvCqKUFsOT
         zEZtEf1hNt8kOp6ga6XGYCail4M+oondsbA0vrw885kwBoNNP68iz9g2Z8A71KjejJ0i
         CCnaOo+mGKm9mPmkxjPHPVggdWkyRtunVEiKHw8Warx5R9MxfV7r92aUn4AW0W1nCJ1b
         VCeRc4x4fV6g0kD0goIz9HM78zZ4UgsfcbgHlJkIUmPGKnJePGnkuByqSK4PGGR2sI9p
         HPuXV4m4oefNKNtK83LpGJqv2Bz6dT6T5MPoZ4EbrXzXhvQEXkm/TybhhaVyNjkNNJkM
         bfaA==
X-Gm-Message-State: AOJu0YwXGG7L/xhILvGVjsISYKhSXy+zFQr02bxcniCKZvmcp+/s0oRJ
	4KodRiQtYosALpDJ76xPYv0=
X-Google-Smtp-Source: AGHT+IG8e858an1p0zBtLDSBBtxERD8lSioFjylEYLmtwwZ1ddUc38F59kbr7rfDO4avaq62QC4dhA==
X-Received: by 2002:a05:600c:1c92:b0:407:7ea1:e9a4 with SMTP id k18-20020a05600c1c9200b004077ea1e9a4mr7612351wms.5.1699976021088;
        Tue, 14 Nov 2023 07:33:41 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:40 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/15] fs: move permission hook out of do_iter_read()
Date: Tue, 14 Nov 2023 17:33:17 +0200
Message-Id: <20231114153321.1716028-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114153321.1716028-1-amir73il@gmail.com>
References: <20231114153321.1716028-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently moved fsnotify hook, rw_verify_area() and other checks from
do_iter_write() out to its two callers.

for consistency, do the same thing for do_iter_read() - move the
rw_verify_area() checks and fsnotify hook to the callers vfs_iter_read()
and vfs_readv().

This aligns those vfs helpers with the pattern used in vfs_read() and
vfs_iocb_iter_read() and the vfs write helpers, where all the checks are
in the vfs helpers and the do_* or call_* helpers do the work.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 70 +++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4891346d42e..5b18e13c2620 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -781,11 +781,22 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 }
 
 static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
-		loff_t *pos, rwf_t flags)
+			    loff_t *pos, rwf_t flags)
+{
+	if (file->f_op->read_iter)
+		return do_iter_readv_writev(file, iter, pos, READ, flags);
+	else
+		return do_loop_readv_writev(file, iter, pos, READ, flags);
+}
+
+ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
+			   struct iov_iter *iter)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
 
+	if (!file->f_op->read_iter)
+		return -EINVAL;
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_READ))
@@ -794,22 +805,20 @@ static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
-	ret = rw_verify_area(READ, file, pos, tot_len);
+	ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
 	if (ret < 0)
 		return ret;
 
-	if (file->f_op->read_iter)
-		ret = do_iter_readv_writev(file, iter, pos, READ, flags);
-	else
-		ret = do_loop_readv_writev(file, iter, pos, READ, flags);
+	ret = call_read_iter(file, iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
 	return ret;
 }
+EXPORT_SYMBOL(vfs_iocb_iter_read);
 
-ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
-			   struct iov_iter *iter)
+ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
+		      rwf_t flags)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
@@ -824,25 +833,16 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
-	ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
+	ret = rw_verify_area(READ, file, ppos, tot_len);
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = do_iter_read(file, iter, ppos, flags);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
 	return ret;
 }
-EXPORT_SYMBOL(vfs_iocb_iter_read);
-
-ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
-		rwf_t flags)
-{
-	if (!file->f_op->read_iter)
-		return -EINVAL;
-	return do_iter_read(file, iter, ppos, flags);
-}
 EXPORT_SYMBOL(vfs_iter_read);
 
 static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
@@ -914,19 +914,37 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 EXPORT_SYMBOL(vfs_iter_write);
 
 static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
-		  unsigned long vlen, loff_t *pos, rwf_t flags)
+			 unsigned long vlen, loff_t *pos, rwf_t flags)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	ssize_t ret;
+	size_t tot_len;
+	ssize_t ret = 0;
 
-	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret >= 0) {
-		ret = do_iter_read(file, &iter, pos, flags);
-		kfree(iov);
-	}
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_READ))
+		return -EINVAL;
+
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov,
+			   &iter);
+	if (ret < 0)
+		return ret;
 
+	tot_len = iov_iter_count(&iter);
+	if (!tot_len)
+		goto out;
+
+	ret = rw_verify_area(READ, file, pos, tot_len);
+	if (ret < 0)
+		goto out;
+
+	ret = do_iter_read(file, &iter, pos, flags);
+out:
+	if (ret >= 0)
+		fsnotify_access(file);
+	kfree(iov);
 	return ret;
 }
 
-- 
2.34.1


