Return-Path: <linux-fsdevel+bounces-5430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA43880BB95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53430280E5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72466154AE;
	Sun, 10 Dec 2023 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH/WOAx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF050F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so36695965e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217948; x=1702822748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haxK5+aFSnAntu/DKYrPb2jEJLFoRjVDDqnC9jaA4R4=;
        b=OH/WOAx41EqZJbAS7s6dtevedTg9q9A0P7AqBqmf9HHMDvxwT5zOg2issSySSvw3Ok
         SuUz2UOsi8XC5udFgMi7XKFF1i901Ecg3Zs9MKCLqO3xGKgHPctIYWI7FwQwWSVKLoYb
         NJPVrp1ThWKQhS6uE643A7rcAJlE7EisO/Tmv3x+5aosrWXmrys/BvRIqwbfWhyRC2cj
         8ybGazciUTFXu4a44urdu/Cc5F06ZUdo10zgcyU70V3yAoAHjfqkEqskuuJNe1zltPpO
         r9AAjQ/bGND69D8Zbtzbqumogpg0WmvwAi9D70YPGxPw9FpTPAsoXNcIXzt82+2SPLiH
         qvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217948; x=1702822748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haxK5+aFSnAntu/DKYrPb2jEJLFoRjVDDqnC9jaA4R4=;
        b=AlUU6ehXbEkyFwNUU4UQ7VupIhafbqv/Gz8SI6uPXBe2+K+OKfKlm6FXWIfYi7s+ON
         vCvDBD/e/XIY1u+XB29efaMYESFRLL7wGVDHW+BYVhSfbjSdaH9NW53APt1GRSS2rUWa
         Gj0PpR90v1a+EkPr1G0iv9DqRaIPpMQ8FC6lAiyJrnNd78Ldt66jNmykBL4FWWtXWabd
         lHxNtb5zXLU1hVOdBta8NU3JCi3m5jQjA04A63omkJpbMk2qIquEonpSuvjCyo88hsko
         Pmay0/0p3WX8/W+kalqHWGQS9DLRHrjlJHPnmUhVFOEYloPv0B5hGmSnchCmuW4UIneo
         +2bA==
X-Gm-Message-State: AOJu0Ywy8i25KCfzC5cxnfBkBPOEYz3gZwiVGW0h0f6bN4iUPNLLeK3h
	YsTLRxdSaeuJGJ3O2jwNvfc=
X-Google-Smtp-Source: AGHT+IGb9G3TLjj4ijDMshuMlU1aNzlPuQ/xozivHcmfIfEx9OevA2sPa10DpKY6dBIDcB5DjiIbvw==
X-Received: by 2002:a05:600c:474c:b0:40c:4575:2050 with SMTP id w12-20020a05600c474c00b0040c45752050mr395538wmo.96.1702217947787;
        Sun, 10 Dec 2023 06:19:07 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:07 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/5] splice: return type ssize_t from all helpers
Date: Sun, 10 Dec 2023 16:18:57 +0200
Message-Id: <20231210141901.47092-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210141901.47092-1-amir73il@gmail.com>
References: <20231210141901.47092-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not sure why some splice helpers return long, maybe historic reasons.
Change them all to return ssize_t to conform to the splice methods and
to the rest of the helpers.

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@brauner/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c |  2 +-
 fs/read_write.c        |  2 +-
 fs/splice.c            | 62 +++++++++++++++++++++---------------------
 include/linux/splice.h | 43 ++++++++++++++---------------
 io_uring/splice.c      |  4 +--
 5 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 294b330aba9f..741d38058337 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -285,7 +285,7 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 
 	while (len) {
 		size_t this_len = OVL_COPY_UP_CHUNK_SIZE;
-		long bytes;
+		ssize_t bytes;
 
 		if (len < this_len)
 			this_len = len;
diff --git a/fs/read_write.c b/fs/read_write.c
index 01a14570015b..7783b8522693 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1214,7 +1214,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 #endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
-		  	   size_t count, loff_t max)
+			   size_t count, loff_t max)
 {
 	struct fd in, out;
 	struct inode *in_inode, *out_inode;
diff --git a/fs/splice.c b/fs/splice.c
index 7cda013e5a1e..6c1f12872407 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -932,8 +932,8 @@ static int warn_unsupported(struct file *file, const char *op)
 /*
  * Attempt to initiate a splice from pipe to file.
  */
-static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
-			   loff_t *ppos, size_t len, unsigned int flags)
+static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
+			      loff_t *ppos, size_t len, unsigned int flags)
 {
 	if (unlikely(!out->f_op->splice_write))
 		return warn_unsupported(out, "write");
@@ -955,9 +955,9 @@ static void do_splice_eof(struct splice_desc *sd)
  * Callers already called rw_verify_area() on the entire range.
  * No need to call it for sub ranges.
  */
-static long do_splice_read(struct file *in, loff_t *ppos,
-			   struct pipe_inode_info *pipe, size_t len,
-			   unsigned int flags)
+static size_t do_splice_read(struct file *in, loff_t *ppos,
+			     struct pipe_inode_info *pipe, size_t len,
+			     unsigned int flags)
 {
 	unsigned int p_space;
 
@@ -999,11 +999,11 @@ static long do_splice_read(struct file *in, loff_t *ppos,
  * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
  * a hole and a negative error code otherwise.
  */
-long vfs_splice_read(struct file *in, loff_t *ppos,
-		     struct pipe_inode_info *pipe, size_t len,
-		     unsigned int flags)
+ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags)
 {
-	int ret;
+	ssize_t ret;
 
 	ret = rw_verify_area(READ, in, ppos, len);
 	if (unlikely(ret < 0))
@@ -1030,7 +1030,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 			       splice_direct_actor *actor)
 {
 	struct pipe_inode_info *pipe;
-	long ret, bytes;
+	size_t ret, bytes;
 	size_t len;
 	int i, flags, more;
 
@@ -1181,7 +1181,7 @@ static void direct_file_splice_eof(struct splice_desc *sd)
 		file->f_op->splice_eof(file);
 }
 
-static long do_splice_direct_actor(struct file *in, loff_t *ppos,
+static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 				   struct file *out, loff_t *opos,
 				   size_t len, unsigned int flags,
 				   splice_direct_actor *actor)
@@ -1226,8 +1226,8 @@ static long do_splice_direct_actor(struct file *in, loff_t *ppos,
  *
  * Callers already called rw_verify_area() on the entire range.
  */
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags)
+ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+			 loff_t *opos, size_t len, unsigned int flags)
 {
 	return do_splice_direct_actor(in, ppos, out, opos, len, flags,
 				      direct_splice_actor);
@@ -1249,8 +1249,8 @@ EXPORT_SYMBOL(do_splice_direct);
  *
  * Callers already called rw_verify_area() on the entire range.
  */
-long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
-		       loff_t *opos, size_t len)
+ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
+			  loff_t *opos, size_t len)
 {
 	lockdep_assert(file_write_started(out));
 
@@ -1280,12 +1280,12 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
 
-long splice_file_to_pipe(struct file *in,
-			 struct pipe_inode_info *opipe,
-			 loff_t *offset,
-			 size_t len, unsigned int flags)
+ssize_t splice_file_to_pipe(struct file *in,
+			    struct pipe_inode_info *opipe,
+			    loff_t *offset,
+			    size_t len, unsigned int flags)
 {
-	long ret;
+	ssize_t ret;
 
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
@@ -1300,13 +1300,13 @@ long splice_file_to_pipe(struct file *in,
 /*
  * Determine where to splice to/from.
  */
-long do_splice(struct file *in, loff_t *off_in, struct file *out,
-	       loff_t *off_out, size_t len, unsigned int flags)
+ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
+		  loff_t *off_out, size_t len, unsigned int flags)
 {
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset;
-	long ret;
+	ssize_t ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ) ||
 		     !(out->f_mode & FMODE_WRITE)))
@@ -1397,14 +1397,14 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 	return ret;
 }
 
-static long __do_splice(struct file *in, loff_t __user *off_in,
-			struct file *out, loff_t __user *off_out,
-			size_t len, unsigned int flags)
+static ssize_t __do_splice(struct file *in, loff_t __user *off_in,
+			   struct file *out, loff_t __user *off_out,
+			   size_t len, unsigned int flags)
 {
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset, *__off_in = NULL, *__off_out = NULL;
-	long ret;
+	ssize_t ret;
 
 	ipipe = get_pipe_info(in, true);
 	opipe = get_pipe_info(out, true);
@@ -1634,7 +1634,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 		size_t, len, unsigned int, flags)
 {
 	struct fd in, out;
-	long error;
+	ssize_t error;
 
 	if (unlikely(!len))
 		return 0;
@@ -1648,7 +1648,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 		out = fdget(fd_out);
 		if (out.file) {
 			error = __do_splice(in.file, off_in, out.file, off_out,
-						len, flags);
+					    len, flags);
 			fdput(out);
 		}
 		fdput(in);
@@ -1962,7 +1962,7 @@ static int link_pipe(struct pipe_inode_info *ipipe,
  * The 'flags' used are the SPLICE_F_* variants, currently the only
  * applicable one is SPLICE_F_NONBLOCK.
  */
-long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
+ssize_t do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
 {
 	struct pipe_inode_info *ipipe = get_pipe_info(in, true);
 	struct pipe_inode_info *opipe = get_pipe_info(out, true);
@@ -2003,7 +2003,7 @@ long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
 SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
 {
 	struct fd in, out;
-	int error;
+	ssize_t error;
 
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 49532d5dda52..068a8e8ffd73 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -68,31 +68,30 @@ typedef int (splice_actor)(struct pipe_inode_info *, struct pipe_buffer *,
 typedef int (splice_direct_actor)(struct pipe_inode_info *,
 				  struct splice_desc *);
 
-extern ssize_t splice_from_pipe(struct pipe_inode_info *, struct file *,
-				loff_t *, size_t, unsigned int,
-				splice_actor *);
-extern ssize_t __splice_from_pipe(struct pipe_inode_info *,
-				  struct splice_desc *, splice_actor *);
-extern ssize_t splice_to_pipe(struct pipe_inode_info *,
-			      struct splice_pipe_desc *);
-extern ssize_t add_to_pipe(struct pipe_inode_info *,
-			      struct pipe_buffer *);
-long vfs_splice_read(struct file *in, loff_t *ppos,
-		     struct pipe_inode_info *pipe, size_t len,
-		     unsigned int flags);
+ssize_t splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
+			 loff_t *ppos, size_t len, unsigned int flags,
+			 splice_actor *actor);
+ssize_t __splice_from_pipe(struct pipe_inode_info *pipe,
+			   struct splice_desc *sd, splice_actor *actor);
+ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
+			      struct splice_pipe_desc *spd);
+ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf);
+ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags);
 ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd,
 			       splice_direct_actor *actor);
-long do_splice(struct file *in, loff_t *off_in, struct file *out,
-	       loff_t *off_out, size_t len, unsigned int flags);
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags);
-long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
-		       loff_t *opos, size_t len);
+ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
+		  loff_t *off_out, size_t len, unsigned int flags);
+ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+			 loff_t *opos, size_t len, unsigned int flags);
+ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
+			  loff_t *opos, size_t len);
 
-extern long do_tee(struct file *in, struct file *out, size_t len,
-		   unsigned int flags);
-extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-				loff_t *ppos, size_t len, unsigned int flags);
+ssize_t do_tee(struct file *in, struct file *out, size_t len,
+	       unsigned int flags);
+ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
+			 loff_t *ppos, size_t len, unsigned int flags);
 
 /*
  * for dynamic pipe sizing
diff --git a/io_uring/splice.c b/io_uring/splice.c
index 7c4469e9540e..3b659cd23e9d 100644
--- a/io_uring/splice.c
+++ b/io_uring/splice.c
@@ -51,7 +51,7 @@ int io_tee(struct io_kiocb *req, unsigned int issue_flags)
 	struct file *out = sp->file_out;
 	unsigned int flags = sp->flags & ~SPLICE_F_FD_IN_FIXED;
 	struct file *in;
-	long ret = 0;
+	ssize_t ret = 0;
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
@@ -92,7 +92,7 @@ int io_splice(struct io_kiocb *req, unsigned int issue_flags)
 	unsigned int flags = sp->flags & ~SPLICE_F_FD_IN_FIXED;
 	loff_t *poff_in, *poff_out;
 	struct file *in;
-	long ret = 0;
+	ssize_t ret = 0;
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-- 
2.34.1


