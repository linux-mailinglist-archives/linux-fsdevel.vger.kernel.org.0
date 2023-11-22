Return-Path: <linux-fsdevel+bounces-3407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713087F4627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF232811A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45E4C62D;
	Wed, 22 Nov 2023 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2v8iMJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A42410DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b2a8c7ca9so13394345e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656045; x=1701260845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB3NeAUUbZWofeZDWYvKhsUgyFUdR3Pi/WqAHuFQ11E=;
        b=C2v8iMJf4YuU4ZQwsDU6eWrO4Fe2RkTHUIGITKDkU3sfv9snKl8pXOkhIzLdEz2u3J
         lhiGGZoRBAS2YagTF+bXIW36rrT7rMVzE1/y4o+OO8lq5dYKTwAs3Ek1lQn3KEjHHr/P
         cM9BZtodE9YQQbGP6DxigcGtNPxgxztPmgzdA7A8Mi8ipcaplpsSLK13QLOy/1yLPVAu
         H2A43na9p9q9DwI1s7daEYSpcQjrRM33SBXXb6SZi6rPIGtB105Pxyzovd8SnLLRs+uT
         7jSglekq5jwiWqTfs2s9xOb7kW9ZYwbKtaldvY2OCC7EjntEOHJ0KVK4yxuuK6xHdwWC
         5X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656045; x=1701260845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB3NeAUUbZWofeZDWYvKhsUgyFUdR3Pi/WqAHuFQ11E=;
        b=w4mnPS6sdF0K/0fOsgG9Rf9CtspdSesPkxl77GL0phWCw/Hdf+3YRj30l+lLV5ile5
         oMWMMzJQQM0IgMUZPjyPHAUipeg2zJ6NgjaUWpUxyUdplqs5CM2iyP9dCUGzR3gaax/h
         qIABcUvy73KATUhUUMd3UBC3frHBjupsyJLuiY9VZCXoiuvPXLqPOMZpahYBL0v72dKc
         Liv1yXe48MBw6MG537Is5qqrJ7Z4lrxLI5K6hcOpjIQjz5UtNmLb7l1IEpdHtMA3jz1E
         3k1ctiXkvr7PincUSHzrL3VOsSnQ4NaaOYOwoa0EW/Q1ouwuiLD++aPopC86VJY+hs2j
         Q5LA==
X-Gm-Message-State: AOJu0YzX17cV6RaKdn3Q3OdiQbTEmUrgmmrbz94gmPuIyCEp4jxkm46N
	beEgpsKvW6D/Fez2lPjItrQms2f9EO4=
X-Google-Smtp-Source: AGHT+IEUXLJqAdztdpPBL0XL+pn65oucQZiEqUjFtK7DRUd1l2ayC2CHkf/wkWLh3ygf5SXYN9cK0w==
X-Received: by 2002:a05:600c:308a:b0:408:56ea:f061 with SMTP id g10-20020a05600c308a00b0040856eaf061mr189491wmn.24.1700656044836;
        Wed, 22 Nov 2023 04:27:24 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:24 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 03/16] splice: move permission hook out of splice_direct_to_actor()
Date: Wed, 22 Nov 2023 14:27:02 +0200
Message-Id: <20231122122715.2561213-4-amir73il@gmail.com>
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

vfs_splice_read() has a permission hook inside rw_verify_area() and
it is called from do_splice_direct() -> splice_direct_to_actor().

The callers of do_splice_direct() (e.g. vfs_copy_file_range()) already
call rw_verify_area() for the entire range, but the other caller of
splice_direct_to_actor() (nfsd) does not.

Add the rw_verify_area() checks in nfsd_splice_read() and use a
variant of vfs_splice_read() without rw_verify_area() check in
splice_direct_to_actor() to avoid the redundant rw_verify_area() checks.

This is needed for fanotify "pre content" events.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/vfs.c |  5 ++++-
 fs/splice.c   | 58 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..5d704461e3b4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1046,7 +1046,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 
 	trace_nfsd_read_splice(rqstp, fhp, offset, *count);
-	host_err = splice_direct_to_actor(file, &sd, nfsd_direct_splice_actor);
+	host_err = rw_verify_area(READ, file, &offset, *count);
+	if (!host_err)
+		host_err = splice_direct_to_actor(file, &sd,
+						  nfsd_direct_splice_actor);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
diff --git a/fs/splice.c b/fs/splice.c
index 6e917db6f49a..6fc2c27e9520 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -944,27 +944,15 @@ static void do_splice_eof(struct splice_desc *sd)
 		sd->splice_eof(sd);
 }
 
-/**
- * vfs_splice_read - Read data from a file and splice it into a pipe
- * @in:		File to splice from
- * @ppos:	Input file offset
- * @pipe:	Pipe to splice to
- * @len:	Number of bytes to splice
- * @flags:	Splice modifier flags (SPLICE_F_*)
- *
- * Splice the requested amount of data from the input file to the pipe.  This
- * is synchronous as the caller must hold the pipe lock across the entire
- * operation.
- *
- * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
- * a hole and a negative error code otherwise.
+/*
+ * Callers already called rw_verify_area() on the entire range.
+ * No need to call it for sub ranges.
  */
-long vfs_splice_read(struct file *in, loff_t *ppos,
-		     struct pipe_inode_info *pipe, size_t len,
-		     unsigned int flags)
+static long do_splice_read(struct file *in, loff_t *ppos,
+			   struct pipe_inode_info *pipe, size_t len,
+			   unsigned int flags)
 {
 	unsigned int p_space;
-	int ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
@@ -975,10 +963,6 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 	p_space = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);
 	len = min_t(size_t, len, p_space << PAGE_SHIFT);
 
-	ret = rw_verify_area(READ, in, ppos, len);
-	if (unlikely(ret < 0))
-		return ret;
-
 	if (unlikely(len > MAX_RW_COUNT))
 		len = MAX_RW_COUNT;
 
@@ -992,6 +976,34 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 		return copy_splice_read(in, ppos, pipe, len, flags);
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
+
+/**
+ * vfs_splice_read - Read data from a file and splice it into a pipe
+ * @in:		File to splice from
+ * @ppos:	Input file offset
+ * @pipe:	Pipe to splice to
+ * @len:	Number of bytes to splice
+ * @flags:	Splice modifier flags (SPLICE_F_*)
+ *
+ * Splice the requested amount of data from the input file to the pipe.  This
+ * is synchronous as the caller must hold the pipe lock across the entire
+ * operation.
+ *
+ * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
+ * a hole and a negative error code otherwise.
+ */
+long vfs_splice_read(struct file *in, loff_t *ppos,
+		     struct pipe_inode_info *pipe, size_t len,
+		     unsigned int flags)
+{
+	int ret;
+
+	ret = rw_verify_area(READ, in, ppos, len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return do_splice_read(in, ppos, pipe, len, flags);
+}
 EXPORT_SYMBOL_GPL(vfs_splice_read);
 
 /**
@@ -1066,7 +1078,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
-		ret = vfs_splice_read(in, &pos, pipe, len, flags);
+		ret = do_splice_read(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
 			goto read_failure;
 
-- 
2.34.1


