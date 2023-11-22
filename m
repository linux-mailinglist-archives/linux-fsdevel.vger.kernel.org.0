Return-Path: <linux-fsdevel+bounces-3413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A17F462E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E47BB21168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E875644A;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIJiLrUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7636D62
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-409299277bbso30173905e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656056; x=1701260856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfYQppQSLMX/y7n8JpLStAWWk81BSauB7nth4ozE5Ig=;
        b=EIJiLrUd+A0D5/PCmkKDGnak8TNyPrHbAwQsyYyLhP5StUJKjWHQfrV6s+Q5m8+UFg
         o9qRrF6beXbVqA2/kcfe4hWFF3o5HldIw1xX1mRnaDStWijMXrXL0lDWs+GNrq76IyAg
         6w0VO4HPL79H8KMkpK2rtFCxiMyz7tZYaANQ89JLn00RtLgX8JsmBPBctlCrT2sAXeQY
         XPo7/NxumGD6wMjGKmTgCQQjZsxZs/rvuHKo64RuKTt67OVMyMf+KbzAOgqLROlnKdXw
         7OS6oOFyD3ML88piNXUjsSnDaoU0UkAtxKXy4WBEabpx1FqgI1YV/OK5OENRYhgl6vay
         QewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656056; x=1701260856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfYQppQSLMX/y7n8JpLStAWWk81BSauB7nth4ozE5Ig=;
        b=umg+OdeLmQ/Ky3fzTPbeAHSpeJTqSrBwH47gPJXPloMfRvj4dHOG3Dkt5ic2l07Mqx
         sgaYPYjvoSbFJRDlRvadnC25Q3A3PBbAYTvSak44WhVSnpNtnPND8z/ZjFZ/Amez4Mxt
         dfS5dNwts9ozw1slNuNp8YmLu6S0zuQX0HQbmN7mI78wWfTvnHOsif6Yc55YPDJUmvsi
         Ab1bUEz0erd4xLEk5bUNuWOpJ3ZOAWa1zqeM0TwkWARypF+P4GmGKbv6KbpKy66bkf5y
         IObyNeKwzQrPHHa1w5nKvMUDlQxFo567AMmi1JKrahQu4Z407uo/1x4Q2cOPK53WtVlc
         LqHg==
X-Gm-Message-State: AOJu0YywbfV1y0lEHeCw7m5ffqsHn2BJ0Wud13Ws90rY+rHncmtiPtr4
	abJYn7FaiOLgrE4zSBp2Eg0EY+nHMK8=
X-Google-Smtp-Source: AGHT+IG1MWaKVveOYbTm87ufR9NY6GAaL0tfklyuGtxSw9nAXJyYYKYr3ivpW8WXDcJd/zV7O1MOhQ==
X-Received: by 2002:a05:600c:4706:b0:408:c6ec:1ac9 with SMTP id v6-20020a05600c470600b00408c6ec1ac9mr1646667wmo.28.1700656055827;
        Wed, 22 Nov 2023 04:27:35 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/16] fs: move permission hook out of do_iter_write()
Date: Wed, 22 Nov 2023 14:27:10 +0200
Message-Id: <20231122122715.2561213-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 78 +++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 87ca50f16a23..6c40468efe19 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -852,28 +852,10 @@ EXPORT_SYMBOL(vfs_iter_read);
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
-	else
-		ret = do_loop_readv_writev(file, iter, pos, WRITE, flags);
-	if (ret > 0)
-		fsnotify_modify(file);
-	return ret;
+		return do_iter_readv_writev(file, iter, pos, WRITE, flags);
+
+	return do_loop_readv_writev(file, iter, pos, WRITE, flags);
 }
 
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
@@ -907,13 +889,28 @@ EXPORT_SYMBOL(vfs_iocb_iter_write);
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
@@ -938,20 +935,39 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
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


