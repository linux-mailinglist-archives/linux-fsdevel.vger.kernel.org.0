Return-Path: <linux-fsdevel+bounces-4407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10747FF24B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93551C20400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528114A9BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNQchjJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13ABD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9c5d30b32so12798421fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353791; x=1701958591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdgGlN3ggNzzMY4TjtYxpQIn+IVihY8sLN8TQod+ErE=;
        b=PNQchjJWQIjw/B6zu1YxRL5jH48d2NLHPrB0OUP9hNjKa+sDSe9Hko/JWNUk0ZW27E
         +dhdnwHSMR08lQAB809vWV8LzTgG+fimRjNeFSG9XKU5M4nWej67nXi5ZBTOpxxCESta
         pEFe3tmN8AW5YBGrnCUHr4ejT+Hq2TkPa5IUk36h7SQoqyvOljgUuEijtSa+J8NPPPNc
         wAuKjrYiCo1eDQNyY8XF0Yq9CvEQvIu9s1mFEvTfxpDuX6lcmShZz6okLKtLpvvYfuO+
         sunhT3eyS1ZcwslqtnUbbfLhqClt8CBs9II0nO/1H4pRyMaChW7Tj2ZpHchMK5RuZN0j
         a9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353791; x=1701958591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdgGlN3ggNzzMY4TjtYxpQIn+IVihY8sLN8TQod+ErE=;
        b=hCMOOynXq/X9yH/+mmcHBUauQdpmwOghLItXDI0gR6YcZYtAM4gIxM13xR3UlDg3u5
         Br4eJf/cYabYmdFHegYXttH0UpIAonQPO1SuppuYi+TdxPFsAIs9o/9hsHKoSdndMAoZ
         YFylZj9JEByq37poWqspAXhw5EKgf39RqRXxf01dosQbCh4R2d5BsgmK7zTw9gMfuu7e
         h3x7uahwXiDqzNRBPos/u7bDSV1fbSuoy1edP+cy+BU7A3az0ifMgXT/LiTGPz5yeDaS
         A2LpEtbUc57vBieP7+qHqNEvpgeitQHfTu67lMt62oqBZEhkCYKUXdzKgn2v75nrVp5I
         A7Pw==
X-Gm-Message-State: AOJu0YzL0RXTytkX1XK//hv83EUl3rDWC0YxYFoIlWNiOtNQPlI5umnH
	pkA3G7Ii4U9reGLn7s5rBOs=
X-Google-Smtp-Source: AGHT+IE4ZXIbAp3bAOeBJCM7dTadi8FP7r9SzU3lvBXnUT4PWLHa+27BvVaemCl9MQbe+YfbyZzfIA==
X-Received: by 2002:a2e:9896:0:b0:2c9:c3d6:103d with SMTP id b22-20020a2e9896000000b002c9c3d6103dmr2632924ljj.15.1701353790572;
        Thu, 30 Nov 2023 06:16:30 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm2170966wmq.14.2023.11.30.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:16:30 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] fs: fork splice_file_range() from do_splice_direct()
Date: Thu, 30 Nov 2023 16:16:22 +0200
Message-Id: <20231130141624.3338942-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130141624.3338942-1-amir73il@gmail.com>
References: <20231130141624.3338942-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of calling do_splice_direct() without file_start_write()
held, create a new helper splice_file_range(), to be called from context
of ->copy_file_range() methods instead of do_splice_direct().

Currently, the only difference is that splice_file_range() does not take
flags argument and that it asserts that file_start_write() is held, but
we factor out a common helper do_splice_direct_actor() that will be used
later.

Use the new helper from __ceph_copy_file_range(), that was incorrectly
passing to do_splice_direct() the copy flags argument as splice flags.
The value of copy flags in ceph is always 0, so it is a smenatic bug fix.

Move the declaration of both helpers to linux/splice.h.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c         |  9 +++---
 fs/read_write.c        |  6 ++--
 fs/splice.c            | 71 ++++++++++++++++++++++++++++++------------
 include/linux/fs.h     |  2 --
 include/linux/splice.h | 13 +++++---
 5 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3b5aae29e944..f11de6e1f1c1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -12,6 +12,7 @@
 #include <linux/falloc.h>
 #include <linux/iversion.h>
 #include <linux/ktime.h>
+#include <linux/splice.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		 * {read,write}_iter, which will get caps again.
 		 */
 		put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
-		ret = do_splice_direct(src_file, &src_off, dst_file,
-				       &dst_off, src_objlen, flags);
+		ret = splice_file_range(src_file, &src_off, dst_file, &dst_off,
+					src_objlen);
 		/* Abort on short copies or on error */
 		if (ret < (long)src_objlen) {
 			doutc(cl, "Failed partial copy (%zd)\n", ret);
@@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 */
 	if (len && (len < src_ci->i_layout.object_size)) {
 		doutc(cl, "Final partial copy of %zu bytes\n", len);
-		bytes = do_splice_direct(src_file, &src_off, dst_file,
-					 &dst_off, len, flags);
+		bytes = splice_file_range(src_file, &src_off, dst_file,
+					  &dst_off, len);
 		if (bytes > 0)
 			ret += bytes;
 		else
diff --git a/fs/read_write.c b/fs/read_write.c
index f791555fa246..642c7ce1ced1 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
-	lockdep_assert(file_write_started(file_out));
-
-	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
+				 min_t(size_t, len, MAX_RW_COUNT));
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
diff --git a/fs/splice.c b/fs/splice.c
index 3fce5f6072dd..9007b2c8baa8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1170,25 +1170,10 @@ static void direct_file_splice_eof(struct splice_desc *sd)
 		file->f_op->splice_eof(file);
 }
 
-/**
- * do_splice_direct - splices data directly between two files
- * @in:		file to splice from
- * @ppos:	input file offset
- * @out:	file to splice to
- * @opos:	output file offset
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    For use by do_sendfile(). splice can easily emulate sendfile, but
- *    doing it in the application would incur an extra system call
- *    (splice in + splice out, as compared to just sendfile()). So this helper
- *    can splice directly through a process-private pipe.
- *
- * Callers already called rw_verify_area() on the entire range.
- */
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags)
+static long do_splice_direct_actor(struct file *in, loff_t *ppos,
+				   struct file *out, loff_t *opos,
+				   size_t len, unsigned int flags,
+				   splice_direct_actor *actor)
 {
 	struct splice_desc sd = {
 		.len		= len,
@@ -1207,14 +1192,60 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
-	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
+	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
 	return ret;
 }
+/**
+ * do_splice_direct - splices data directly between two files
+ * @in:		file to splice from
+ * @ppos:	input file offset
+ * @out:	file to splice to
+ * @opos:	output file offset
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    For use by do_sendfile(). splice can easily emulate sendfile, but
+ *    doing it in the application would incur an extra system call
+ *    (splice in + splice out, as compared to just sendfile()). So this helper
+ *    can splice directly through a process-private pipe.
+ *
+ * Callers already called rw_verify_area() on the entire range.
+ */
+long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+		      loff_t *opos, size_t len, unsigned int flags)
+{
+	return do_splice_direct_actor(in, ppos, out, opos, len, flags,
+				      direct_splice_actor);
+}
 EXPORT_SYMBOL(do_splice_direct);
 
+/**
+ * splice_file_range - splices data between two files for copy_file_range()
+ * @in:		file to splice from
+ * @ppos:	input file offset
+ * @out:	file to splice to
+ * @opos:	output file offset
+ * @len:	number of bytes to splice
+ *
+ * Description:
+ *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *
+ * Callers already called rw_verify_area() on the entire range.
+ */
+long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
+		       loff_t *opos, size_t len)
+{
+	lockdep_assert(file_write_started(out));
+
+	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
+				      direct_splice_actor);
+}
+EXPORT_SYMBOL(splice_file_range);
+
 static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 {
 	for (;;) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ae0e2fb7bcea..04422a0eccdd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3052,8 +3052,6 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 size_t len, unsigned int flags);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
-extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		loff_t *opos, size_t len, unsigned int flags);
 
 
 extern void
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 6c461573434d..49532d5dda52 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -80,11 +80,14 @@ extern ssize_t add_to_pipe(struct pipe_inode_info *,
 long vfs_splice_read(struct file *in, loff_t *ppos,
 		     struct pipe_inode_info *pipe, size_t len,
 		     unsigned int flags);
-extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
-				      splice_direct_actor *);
-extern long do_splice(struct file *in, loff_t *off_in,
-		      struct file *out, loff_t *off_out,
-		      size_t len, unsigned int flags);
+ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd,
+			       splice_direct_actor *actor);
+long do_splice(struct file *in, loff_t *off_in, struct file *out,
+	       loff_t *off_out, size_t len, unsigned int flags);
+long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+		      loff_t *opos, size_t len, unsigned int flags);
+long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
+		       loff_t *opos, size_t len);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
-- 
2.34.1


