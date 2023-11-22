Return-Path: <linux-fsdevel+bounces-3415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C337F462F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC52B212C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80056468;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnp8Uiiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B7D70
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b27726369so14075305e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656054; x=1701260854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ayra2lBpzB2l6/vIVCHvT5UirKLd3Mhm4ZIGyoDxSzk=;
        b=Vnp8UiiwNn7DOFO530G3KBmdLVz9oMiAVt00BCRWSQMhpByLDPtu8452KtczosDIqE
         0/xAV8wuhmgUFHA4yAG64ioYSEArl+sza7a5nlZEl6uP8qoV4Toxj/FZxIX/GSHC0bWP
         yaGAAS6ausQh2V77U78AY0FWqoBoInMVVtNmtjKsSpaYfzG19ee0WLtkqGCUgPmhd82Y
         Ab2IVgEHwmUoNJj0SNM45W5c0Be7KZhnfOOMGrwG/dKtnxBke6qaftIMXIFCZIK8HZtb
         n2L+LX+ImdKsRNN82L5mGG5akychrGOYH5QaDvKTRohaGyZKoT0fbsM3eQ40jyDc4TUR
         tgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656054; x=1701260854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ayra2lBpzB2l6/vIVCHvT5UirKLd3Mhm4ZIGyoDxSzk=;
        b=ikZQQNEAQoVHSxlHAF8q9uSSPHnnTlxFHUBXzyIBxhmXCmQvVy0ui5r62ZUjfG2Dj3
         pffIfnmH6zA8fzf8yKInQ0SziDJiSdgdc9uhoZ8c0Hco2XKUYsoz2TmrpAPyV5pHjhAK
         vBp5+vPma2WnLM1L9QegTATO+PX0L8xHdntF4Grsw+dtQL/xxIgHmXaNNHTTzVaApK2g
         uixUCk2X2jY8MvYI/9vJVPID9CZVHk5fuRWdF8e/AiXKmzK5T5K2voPc7PrWNuH60CBf
         ORnqbk7VRkkOpc5mEL3PM7PnGohrKi7jhJ9jFqhJrwgAfMeJlJ+IhtuRQwvOk9c98J1q
         7DJQ==
X-Gm-Message-State: AOJu0Yy+RcGOhNY6jvWCHdjccgF2Kwm4cm7Tasl6l+xXo734avfdjXiu
	U300D81v9g8WqYokuOuNuBE=
X-Google-Smtp-Source: AGHT+IG0PKSxMb0pgM6G9SZ9vRJM5+GgaT3+/HYIPmG09SkNj2rjYesZnTcSD1Knq0rziydbp9ae9w==
X-Received: by 2002:a05:600c:314e:b0:407:462a:7e9f with SMTP id h14-20020a05600c314e00b00407462a7e9fmr2012624wmo.27.1700656054541;
        Wed, 22 Nov 2023 04:27:34 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:34 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/16] fs: move file_start_write() into vfs_iter_write()
Date: Wed, 22 Nov 2023 14:27:09 +0200
Message-Id: <20231122122715.2561213-11-amir73il@gmail.com>
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

All the callers of vfs_iter_write() call file_start_write() just before
calling vfs_iter_write() except for target_core_file's fd_do_rw().

Move file_start_write() from the callers into vfs_iter_write().
fd_do_rw() calls vfs_iter_write() with a non-regular file, so
file_start_write() is a no-op.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 drivers/block/loop.c |  2 --
 fs/coda/file.c       |  2 --
 fs/nfsd/vfs.c        |  2 --
 fs/overlayfs/file.c  |  2 --
 fs/read_write.c      | 13 ++++++++++---
 5 files changed, 10 insertions(+), 11 deletions(-)

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
index e62315c37386..148856a582a9 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -80,12 +80,10 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto finish_write;
 
 	inode_lock(coda_inode);
-	file_start_write(host_file);
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
-	file_end_write(host_file);
 	inode_unlock(coda_inode);
 
 finish_write:
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
index 313f7eaaa9a7..87ca50f16a23 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -850,7 +850,7 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 EXPORT_SYMBOL(vfs_iter_read);
 
 static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
-		loff_t *pos, rwf_t flags)
+			     loff_t *pos, rwf_t flags)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
@@ -905,11 +905,18 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
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


