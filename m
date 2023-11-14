Return-Path: <linux-fsdevel+bounces-2834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705B37EB3CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB119B20D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397641A98;
	Tue, 14 Nov 2023 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL4YL7Ac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F14175D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:43 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61954125
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a46ea95f0so36555235e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976020; x=1700580820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTeM1dBsqSMrj7dJ0Y7ppqb+rwjsKONfTRk0U9DB+v8=;
        b=NL4YL7AcU+VBBJu9bMXIW8WSq1wqh3XX+uqaD5ppTr8d28EIQBXdVqlshkRYP2XHUu
         f5F6lXzmep58z6yl51jw8BWb04B1RcDlGLTQdR3smX/t4USMlEMEQRKUClb6LAhvRmKu
         ipMK3aCrMvXZBd33BauhBSjAvfvlYYWSSwhfCcgWOobvI1z6Uww0b7ZaQbn0lNYN+aOu
         ujgC/DHAzjw66O7WaLHFv5TqX0gXmoZRk96XO9Mb+xLDV+gepd2wL/ARzUIb6+ixyg+s
         XMnXtYpgWmJTzGT2NtBl64B+QJJmhvVTlDcrV4PTVYuRt/Pxg9ORtBOqdTKz3DK6Zyp9
         2rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976020; x=1700580820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTeM1dBsqSMrj7dJ0Y7ppqb+rwjsKONfTRk0U9DB+v8=;
        b=SVGikC/1nmLbPJcOOKi8Dv1LXB/UJ71iXWl1HiND83yyhqHY1tKPVigxsHKm/J51aw
         OgZ9UXilTUqKlusfNUPMxcSGQxYH+vJaWyjhWjLtcSSKd9kIhnWEMkNAeMPByPpZUJR9
         +PM+Wfdc3j7MiPI3JUtVszpp0zbgxxxdCdzPxYdWV28/nO0h54GDrPiHjIN3lJCQNmdF
         /FgdpuzG+Tpcc7hV93viHGxlEm10jmQjkFTX62YdhWnr4ILBF/8fFo5BWFOZsgpgx/tA
         qc2TmqdQj02E+fD9zo0eEx73JZvE953CPsX3+FWay2gcpzvydCcJG4P8LXbGyiWiLQgp
         5TuA==
X-Gm-Message-State: AOJu0YwC/oW0qmu0H/rz5xyrh18/OmXpeBq+nu1ivoihu5zJezrTdQ0T
	CYxUtuQgMy1igqD14WlK7+M=
X-Google-Smtp-Source: AGHT+IEB4v8Sk3yNzGeSiHRAaNSSw6T9iJ+ae45cLxOsudwuVpg1D+qf6QOLdsv7sZNoGcfx2BbJLA==
X-Received: by 2002:a5d:584d:0:b0:32d:ba1e:5cee with SMTP id i13-20020a5d584d000000b0032dba1e5ceemr9362104wrf.45.1699976019803;
        Tue, 14 Nov 2023 07:33:39 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:39 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/15] fs: move permission hook out of do_iter_write()
Date: Tue, 14 Nov 2023 17:33:16 +0200
Message-Id: <20231114153321.1716028-11-amir73il@gmail.com>
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

In many of the vfs helpers, the rw_verity_area() checks are called before
taking sb_start_write(), making them "start-write-safe".
do_iter_write() is an exception to this rule.

do_iter_write() has two callers - vfs_iter_write() and vfs_writev().
Move rw_verify_area() and other checks from do_iter_write() out to
its callers to make them "start-write-safe".

Move also the fsnotify_modify() hook to align with similar pattern
used in vfs_write() and other vfs helpers.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 76 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8cdc6e6a9639..d4891346d42e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -848,28 +848,10 @@ EXPORT_SYMBOL(vfs_iter_read);
 static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
 			     loff_t *pos, rwf_t flags)
 {
-	size_t tot_len;
-	ssize_t ret = 0;
-
-	if (!(file->f_mode & FMODE_WRITE))
-		return -EBADF;
-	if (!(file->f_mode & FMODE_CAN_WRITE))
-		return -EINVAL;
-
-	tot_len = iov_iter_count(iter);
-	if (!tot_len)
-		return 0;
-	ret = rw_verify_area(WRITE, file, pos, tot_len);
-	if (ret < 0)
-		return ret;
-
 	if (file->f_op->write_iter)
-		ret = do_iter_readv_writev(file, iter, pos, WRITE, flags);
+		return do_iter_readv_writev(file, iter, pos, WRITE, flags);
 	else
-		ret = do_loop_readv_writev(file, iter, pos, WRITE, flags);
-	if (ret > 0)
-		fsnotify_modify(file);
-	return ret;
+		return do_loop_readv_writev(file, iter, pos, WRITE, flags);
 }
 
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
@@ -903,13 +885,28 @@ EXPORT_SYMBOL(vfs_iocb_iter_write);
 ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		       rwf_t flags)
 {
-	int ret;
+	size_t tot_len;
+	ssize_t ret;
 
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_WRITE))
+		return -EINVAL;
 	if (!file->f_op->write_iter)
 		return -EINVAL;
 
+	tot_len = iov_iter_count(iter);
+	if (!tot_len)
+		return 0;
+
+	ret = rw_verify_area(WRITE, file, ppos, tot_len);
+	if (ret < 0)
+		return ret;
+
 	file_start_write(file);
 	ret = do_iter_write(file, iter, ppos, flags);
+	if (ret > 0)
+		fsnotify_modify(file);
 	file_end_write(file);
 
 	return ret;
@@ -934,20 +931,39 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 }
 
 static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
-		   unsigned long vlen, loff_t *pos, rwf_t flags)
+			  unsigned long vlen, loff_t *pos, rwf_t flags)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	ssize_t ret;
+	size_t tot_len;
+	ssize_t ret = 0;
 
-	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret >= 0) {
-		file_start_write(file);
-		ret = do_iter_write(file, &iter, pos, flags);
-		file_end_write(file);
-		kfree(iov);
-	}
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_WRITE))
+		return -EINVAL;
+
+	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov,
+			   &iter);
+	if (ret < 0)
+		return ret;
+
+	tot_len = iov_iter_count(&iter);
+	if (!tot_len)
+		goto out;
+
+	ret = rw_verify_area(WRITE, file, pos, tot_len);
+	if (ret < 0)
+		goto out;
+
+	file_start_write(file);
+	ret = do_iter_write(file, &iter, pos, flags);
+	if (ret > 0)
+		fsnotify_modify(file);
+	file_end_write(file);
+out:
+	kfree(iov);
 	return ret;
 }
 
-- 
2.34.1


