Return-Path: <linux-fsdevel+bounces-5642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FDA80E803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC37B1C21715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA15914A;
	Tue, 12 Dec 2023 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKwHbryX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15BE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50e04354de0so1421678e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374286; x=1702979086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8Zpe6O6e50b4Mbg0l0YHYguBcBP+cYVm1GrQQWkmDA=;
        b=UKwHbryX8bo/T048LvZtHzpEyfldLAZPiv0XyuvnD2IaVmlQ8CsHR7klhrg/kH+Cwb
         Wmn4DAyXb+c9ojPAolB+nOWgeBxK65jyAR3DU7U188HZ2rwsqdgxemSeK3weSpRB1KoI
         lSTxDiopPLmT2poON491figMEulTSydXfP2GxucQHG62WqnCbaH/u3ZCg4kLhGNfgHJE
         qTfkdselCK+ePpqpRphjc2Ao2x3HEfngeHETZWtyyQrGH/gNjFn8RFUfwCkEmzgutc4G
         Z8ay/gI2TP/QEBwiTzB3ujskE+btaNESi6GdRZ/FSg9iuSmjTthtaE3nGd5NglRLkcxn
         BKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374286; x=1702979086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8Zpe6O6e50b4Mbg0l0YHYguBcBP+cYVm1GrQQWkmDA=;
        b=rpZisA+fWPc8bCbi6PNIFEPTizNJBHKYo3BjH/XU3pTTKeYo9U3MXLXUzcCj3xNx21
         jacpPNBcoFljF3umwiVQgYd3Hk2Hi9DIL7wAuxa4OztQY6Fw1mcA/Syx6/jBPJODpX/U
         f048EQJEVcacdwckLXK/xfLODzc4SAp0mteRqctqa8sqg434uzoTZ7GU7+bpMUB0om5F
         PmtWhU3kn1Y9i8fXU6a7yBeRKCi9qvfvTcAv1sXsLO8ofpbm5Sqi420TMykusXJOln2q
         j/nEabNvev0/vUgVMjeDLhBH/qb34P+hFt9mC7/IZZxxS/ptMLohRZr1989YnS9c7MkE
         D4yw==
X-Gm-Message-State: AOJu0YxAN24W8o+vwJxJsec9PGxspMAhR6xyQ14pk57eEaxS5+6tvyWC
	V/CRKggv4XynA+5W42udZBVQwt53HpU=
X-Google-Smtp-Source: AGHT+IHSFFH82NNAi8UfscUDFXDzH1lYKop2Wl0+T8wZZhF75g3mv58nIkU6K0m3OUn/vCAx7X8zqw==
X-Received: by 2002:a05:6512:3f2a:b0:50e:acd:123 with SMTP id y42-20020a0565123f2a00b0050e0acd0123mr203482lfa.46.1702374286338;
        Tue, 12 Dec 2023 01:44:46 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:45 -0800 (PST)
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
Subject: [PATCH v3 1/5] splice: return type ssize_t from all helpers
Date: Tue, 12 Dec 2023 11:44:36 +0200
Message-Id: <20231212094440.250945-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
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
 fs/internal.h          |   8 ++--
 fs/overlayfs/copy_up.c |   2 +-
 fs/read_write.c        |   2 +-
 fs/splice.c            | 103 +++++++++++++++++++++--------------------
 include/linux/splice.h |  43 +++++++++--------
 io_uring/splice.c      |   4 +-
 6 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index de67b02226e5..bd9dedfcb675 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -241,10 +241,10 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 /*
  * fs/splice.c:
  */
-long splice_file_to_pipe(struct file *in,
-			 struct pipe_inode_info *opipe,
-			 loff_t *offset,
-			 size_t len, unsigned int flags);
+ssize_t splice_file_to_pipe(struct file *in,
+			    struct pipe_inode_info *opipe,
+			    loff_t *offset,
+			    size_t len, unsigned int flags);
 
 /*
  * fs/xattr.c:
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
index 7cda013e5a1e..13030ce192d9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -201,7 +201,7 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	unsigned int tail = pipe->tail;
 	unsigned int head = pipe->head;
 	unsigned int mask = pipe->ring_size - 1;
-	int ret = 0, page_nr = 0;
+	ssize_t ret = 0, page_nr = 0;
 
 	if (!spd_pages)
 		return 0;
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
+static ssize_t do_splice_read(struct file *in, loff_t *ppos,
+			      struct pipe_inode_info *pipe, size_t len,
+			      unsigned int flags)
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
+	ssize_t ret, bytes;
 	size_t len;
 	int i, flags, more;
 
@@ -1181,10 +1181,10 @@ static void direct_file_splice_eof(struct splice_desc *sd)
 		file->f_op->splice_eof(file);
 }
 
-static long do_splice_direct_actor(struct file *in, loff_t *ppos,
-				   struct file *out, loff_t *opos,
-				   size_t len, unsigned int flags,
-				   splice_direct_actor *actor)
+static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
+				      struct file *out, loff_t *opos,
+				      size_t len, unsigned int flags,
+				      splice_direct_actor *actor)
 {
 	struct splice_desc sd = {
 		.len		= len,
@@ -1195,7 +1195,7 @@ static long do_splice_direct_actor(struct file *in, loff_t *ppos,
 		.splice_eof	= direct_file_splice_eof,
 		.opos		= opos,
 	};
-	long ret;
+	ssize_t ret;
 
 	if (unlikely(!(out->f_mode & FMODE_WRITE)))
 		return -EBADF;
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
@@ -1443,16 +1443,16 @@ static long __do_splice(struct file *in, loff_t __user *off_in,
 	return ret;
 }
 
-static int iter_to_pipe(struct iov_iter *from,
-			struct pipe_inode_info *pipe,
-			unsigned flags)
+static ssize_t iter_to_pipe(struct iov_iter *from,
+			    struct pipe_inode_info *pipe,
+			    unsigned int flags)
 {
 	struct pipe_buffer buf = {
 		.ops = &user_page_pipe_buf_ops,
 		.flags = flags
 	};
 	size_t total = 0;
-	int ret = 0;
+	ssize_t ret = 0;
 
 	while (iov_iter_count(from)) {
 		struct page *pages[16];
@@ -1501,8 +1501,8 @@ static int pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
  * For lack of a better implementation, implement vmsplice() to userspace
  * as a simple copy of the pipes pages to the user iov.
  */
-static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+static ssize_t vmsplice_to_user(struct file *file, struct iov_iter *iter,
+				unsigned int flags)
 {
 	struct pipe_inode_info *pipe = get_pipe_info(file, true);
 	struct splice_desc sd = {
@@ -1510,7 +1510,7 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 		.flags = flags,
 		.u.data = iter
 	};
-	long ret = 0;
+	ssize_t ret = 0;
 
 	if (!pipe)
 		return -EBADF;
@@ -1534,11 +1534,11 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
  * as splice-from-memory, where the regular splice is splice-from-file (or
  * to file). In both cases the output is a pipe, naturally.
  */
-static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+				unsigned int flags)
 {
 	struct pipe_inode_info *pipe;
-	long ret = 0;
+	ssize_t ret = 0;
 	unsigned buf_flag = 0;
 
 	if (flags & SPLICE_F_GIFT)
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
@@ -1871,15 +1871,15 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 /*
  * Link contents of ipipe to opipe.
  */
-static int link_pipe(struct pipe_inode_info *ipipe,
-		     struct pipe_inode_info *opipe,
-		     size_t len, unsigned int flags)
+static ssize_t link_pipe(struct pipe_inode_info *ipipe,
+			 struct pipe_inode_info *opipe,
+			 size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
 	unsigned int i_tail, o_tail;
 	unsigned int i_mask, o_mask;
-	int ret = 0;
+	ssize_t ret = 0;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1962,11 +1962,12 @@ static int link_pipe(struct pipe_inode_info *ipipe,
  * The 'flags' used are the SPLICE_F_* variants, currently the only
  * applicable one is SPLICE_F_NONBLOCK.
  */
-long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
+ssize_t do_tee(struct file *in, struct file *out, size_t len,
+	       unsigned int flags)
 {
 	struct pipe_inode_info *ipipe = get_pipe_info(in, true);
 	struct pipe_inode_info *opipe = get_pipe_info(out, true);
-	int ret = -EINVAL;
+	ssize_t ret = -EINVAL;
 
 	if (unlikely(!(in->f_mode & FMODE_READ) ||
 		     !(out->f_mode & FMODE_WRITE)))
@@ -2003,7 +2004,7 @@ long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
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


