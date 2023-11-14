Return-Path: <linux-fsdevel+bounces-2833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D07EB3CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D0281196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1B41774;
	Tue, 14 Nov 2023 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhFo/s6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65241A82
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:41 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27FD59
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fb1d757f7so3696388f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976018; x=1700580818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQtkuR/iZsmuEMlTPtAT3Yz8z3F19r7J47t6Nq7MaQQ=;
        b=fhFo/s6gtzLbo7MQcvBc0+1lOheTvLML1yDd1IoSgDe51XYOIBepmL8vCyv2TrVJrn
         X01mAnbdk7ZxTWHzYklmhsTZgGDykCZ41uumd5A38k7w+5b+X+NYrCbpAUgfgCXcW+ST
         Jxz8nCAGJuIqsoVWJqY3YpcMxWyrjkW3u3cRaM8UyRQgi8GBSGwX+33H8iit4PBfxd8n
         XztrTfUqlwYmyoAWAqfD3cqFWQcGn/EK011uE5vS71gY/7xiAlzhvNh4zQIljToy4bmr
         8aZe9wKqyovzf5JFab/O061xHJZR8NentH1Bn8HHvkkoNPxHAOzHijakckNpTBvzU85s
         W9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976018; x=1700580818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQtkuR/iZsmuEMlTPtAT3Yz8z3F19r7J47t6Nq7MaQQ=;
        b=tzFdkR2vsUvQ3QIyb37ItpqhOSxNbAs69URKSZpYMjjgq5rLB3/JgxV6ZwTvq1xqfw
         puHbq5rhG6cuaFpP6EEhw2QSJP6EFMC77u1bp7v/GqrD+JU7Cs4rK/VACXdu83Ov/kgi
         ihoTLwmLtNsjJaZuDcApl4nVo5fPNpnHlZSpThycyykO3Cvg6T4yTseYEZECmhFpkhR4
         KlfS7YVFnvj75aAQ+XJnMaqDL73dGtdcqY106eNWVAcdPL6deX2sDzewjdfCc9rrz+O/
         35RmRDhDcdRiuxBPNaSDXg5rSnibl0ZVYeu3+dxruyzILTMfAfeq7WKs2zvXOylIYy8/
         b/RQ==
X-Gm-Message-State: AOJu0YxJowFQ50JqS1xAt+cOaJgy5Ic3pJQO4UvHZ9Cc3dPey3DPfE1c
	zSpSaU6ZZQqBiKc9p+M2+yw=
X-Google-Smtp-Source: AGHT+IFGUL+WrSFozzRnYkIC7hFMdaXLbCAB3LXUoQ9utcLSLe/hYlFgpSxhkFhe9T6hUSlOagKYpw==
X-Received: by 2002:adf:f2cb:0:b0:32f:e1a2:525d with SMTP id d11-20020adff2cb000000b0032fe1a2525dmr7194225wrp.57.1699976018558;
        Tue, 14 Nov 2023 07:33:38 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 09/15] fs: move file_start_write() into vfs_iter_write()
Date: Tue, 14 Nov 2023 17:33:15 +0200
Message-Id: <20231114153321.1716028-10-amir73il@gmail.com>
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

All the callers of vfs_iter_write() call file_start_write() just before
calling vfs_iter_write() except for target_core_file's fd_do_rw().

Move file_start_write() from the callers into vfs_iter_write().
fd_do_rw() calls vfs_iter_write() with a non-regular file, so
file_start_write() is a no-op.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 drivers/block/loop.c |  2 --
 fs/coda/file.c       |  4 +---
 fs/nfsd/vfs.c        |  2 --
 fs/overlayfs/file.c  |  2 --
 fs/read_write.c      | 13 ++++++++++---
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..8a8cd4fc9238 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -245,9 +245,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 
 	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
 
-	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
-	file_end_write(file);
 
 	if (likely(bw ==  bvec->bv_len))
 		return 0;
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 16acc58311ea..7c84555c8923 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -79,14 +79,12 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto finish_write;
 
-	file_start_write(host_file);
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(host_file, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
 	inode_unlock(coda_inode);
-	file_end_write(host_file);
 
 finish_write:
 	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5d704461e3b4..35c9546b3396 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1186,9 +1186,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-	file_start_write(file);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
-	file_end_write(file);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 131621daeb13..690b173f34fc 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -436,9 +436,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(ifl);
 
-		file_start_write(real.file);
 		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos, rwf);
-		file_end_write(real.file);
 		/* Update size */
 		ovl_file_modified(file);
 	} else {
diff --git a/fs/read_write.c b/fs/read_write.c
index 590ab228fa98..8cdc6e6a9639 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -846,7 +846,7 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 EXPORT_SYMBOL(vfs_iter_read);
 
 static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
-		loff_t *pos, rwf_t flags)
+			     loff_t *pos, rwf_t flags)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
@@ -901,11 +901,18 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 EXPORT_SYMBOL(vfs_iocb_iter_write);
 
 ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
-		rwf_t flags)
+		       rwf_t flags)
 {
+	int ret;
+
 	if (!file->f_op->write_iter)
 		return -EINVAL;
-	return do_iter_write(file, iter, ppos, flags);
+
+	file_start_write(file);
+	ret = do_iter_write(file, iter, ppos, flags);
+	file_end_write(file);
+
+	return ret;
 }
 EXPORT_SYMBOL(vfs_iter_write);
 
-- 
2.34.1


