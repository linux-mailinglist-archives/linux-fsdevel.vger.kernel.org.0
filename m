Return-Path: <linux-fsdevel+bounces-2827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5D7EB3BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20688281268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6F41777;
	Tue, 14 Nov 2023 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSNQMhWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874454176E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:32 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090CE11F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so3450806f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976009; x=1700580809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPwJl4K8BEEQFhYjexDs/LBFmYBnhVlIJcHUn2gLmag=;
        b=cSNQMhWMu6EwbwfVjVLy6W5pRr6w+Tvw3cdEMBkdpf1E20COs9SboWkHaY7nFR1MO/
         IMZl0HVKtikqLrn/23nWRLdrsdf/lI00o4OsdR66/v6DJ5RhzrCJ6gF5SkbEGEsLc3VK
         Xl8liDxO1DwhvWhy13oF/5su+IAPkOz8zZc0NGtPntzJXRrenqi3F536M6SDntNnrNLO
         jkxv7hJih+Q2zq5le24ElGoS7N5K2AqqG/ZBf33s/azYIMYqUWw0A994t+VJpXYv77Kw
         Q583q6fVwsbSTLwi4yURGWv+Oha9VUEUoLbmF5k8CBPJPXMyjGtGtD3s3Lzg+Xc+zTeh
         EjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976009; x=1700580809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPwJl4K8BEEQFhYjexDs/LBFmYBnhVlIJcHUn2gLmag=;
        b=qKOttJztLl6aeI5/gFXNmbTb4mQ5/eLZKbZroaKE3Qbv1tV5U55sifGZt2L9mZXxWx
         RUCxfzD2DfFtIO1Zt6NBAcS5iM9e9zk7MBSb/GxFfBoLfOioNryBLf2F3xfWq8MKPiQ6
         IGZYPaI5fhFdHl4ywn2ryFtFnicg+CfKzwf8NTM0JRDKYor2C11znbovaVWCkw6R4PE+
         yPauVTA0sP8rmz+eNIFF2Z6xrv8jTZ9agJTpz4uIsYLSWtE98eG19VWAj8HLMHZwU75V
         kMYL5zMOl5CTzQAO7/5a/xM3j0wczFM9NrIPs+SibpdOMaGqnE3fA0X4qDF6SSAxgaf5
         o1KQ==
X-Gm-Message-State: AOJu0Yz0+Y61Ru+gEd+p8LsH6QcanpQUQAsemgD9BSWTgLoAX2ednn+Z
	4B2Zr6xr04bh3v72uToxaic=
X-Google-Smtp-Source: AGHT+IFWa2Z9xXq5/mDA+Hl20USIsH9WQSNsWiXo0tRpJ9Fjb5qhVmEjUbgu+hqlAw8OT7C+2ffJwA==
X-Received: by 2002:a05:6000:402c:b0:32f:7628:df3b with SMTP id cp44-20020a056000402c00b0032f7628df3bmr7771552wrb.6.1699976009421;
        Tue, 14 Nov 2023 07:33:29 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:29 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 03/15] splice: move permission hook out of splice_direct_to_actor()
Date: Tue, 14 Nov 2023 17:33:09 +0200
Message-Id: <20231114153321.1716028-4-amir73il@gmail.com>
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

vfs_splice_read() has a permission hook inside rw_verify_area() and
it is called from do_splice_direct() -> splice_direct_to_actor().

The callers of do_splice_direct() (e.g. vfs_copy_file_range()) already
call rw_verify_area() for the entire range, but the other caller of
splice_direct_to_actor() (nfsd) does not.

Add the rw_verify_area() checks in nfsd_splice_read() and use a
variant of vfs_splice_read() without rw_verify_area() check in
splice_direct_to_actor() to avoid the redundant rw_verify_area() checks.

This is needed for fanotify "pre content" events.

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


