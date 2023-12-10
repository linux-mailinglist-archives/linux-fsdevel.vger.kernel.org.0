Return-Path: <linux-fsdevel+bounces-5431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C780BB94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1061C20986
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED81156E8;
	Sun, 10 Dec 2023 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiBNZwaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174CEFA
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so36696145e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217949; x=1702822749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP6Ltl5IEPsSe+0+rYYVlFiR1UDQU6qeHy4zkHapvgg=;
        b=YiBNZwajIrbhhMSF/0ctKvsPk938orARFlepdk4aHKKI6iopdRfD4H/eL/BinHl4Wx
         U8v0Cy7+UMaZ1FUkHVKrr8O0XQ5fTurIHuqV5kPLdCZIpxeoVjR05Cp84ty8xmgxUA3p
         zBWEklcOHTWvqxjEfcV2ibIFAn1fDVx6Tuh84FxTCMXgYkZn8H7egZJWAnBAtcrRLaDR
         TZdNGLFSZJOuqs5byORhTm/+ntKEJrPYG9XJf8yu0CAtGfReDra/EX2cFYNRoRdOOgyl
         42VZLM4R0zkSHYRlHwTcNal4d1KSbGOdBNppozgX20oZry9vvosVr8Zm7fhj1a8YxMA0
         kvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217949; x=1702822749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP6Ltl5IEPsSe+0+rYYVlFiR1UDQU6qeHy4zkHapvgg=;
        b=og35Xilyf1YscVKCl8qc2sh+l61l8Fv1kw+2ipV/mLqvvbWKq0jjdgb6T9wn6287l6
         hfeW0rykDc1bFSabDw7l+hVWVSythkKbyt2jcT81Pii29qyu+JfWuDxWOcvNhFGabeeJ
         PDRS2TTGCgpPJQaYy5Cyxklok76DJHzUG3zx/WPb9GC2TDgQsFc05TT34dCSkRAsRKUl
         e72xMXrWmVh7TJXbBxPXuezX7jltSE3EdKY+0GkQTzZP2Bo7bQB4FTVpWl7nJgnfchTh
         WWKOG5HDGHBMevHd0H6ghnYkOfmq3PBci0ydk7Ti8vx9Lvtl9SoBLZruuGD/oT0Ec2Ly
         KfYQ==
X-Gm-Message-State: AOJu0YwQzHfuZ5gYwGd98W0gE3dZqIhxgB4SctWEv1XZXKeWHISBR93b
	JL/k8UgRRhHOtfkSaEth+/I=
X-Google-Smtp-Source: AGHT+IGvtZHt8eGHpLV4bmkdaMXipfXjdZFVoYgReHKMgfJsVlRxRoR8Wow1jKVfEX9TGaoWNRJHrA==
X-Received: by 2002:a05:600c:3d91:b0:40b:5e1d:83a7 with SMTP id bi17-20020a05600c3d9100b0040b5e1d83a7mr1573840wmb.59.1702217949224;
        Sun, 10 Dec 2023 06:19:09 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:08 -0800 (PST)
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
Subject: [PATCH v2 2/5] fs: use splice_copy_file_range() inline helper
Date: Sun, 10 Dec 2023 16:18:58 +0200
Message-Id: <20231210141901.47092-3-amir73il@gmail.com>
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

generic_copy_file_range() is just a wrapper around splice_file_range(),
which caps the maximum copy length.

The only caller of splice_file_range(), namely __ceph_copy_file_range()
is already ready to cope with short copy.

Move the length capping into splice_file_range() and replace the exported
symbol generic_copy_file_range() with a simple inline helper.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-fsdevel/20231204083849.GC32438@lst.de/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c         |  4 ++--
 fs/fuse/file.c         |  5 +++--
 fs/nfs/nfs4file.c      |  5 +++--
 fs/read_write.c        | 34 ----------------------------------
 fs/smb/client/cifsfs.c |  5 +++--
 fs/splice.c            |  7 ++++---
 include/linux/fs.h     |  3 ---
 include/linux/splice.h |  7 +++++++
 8 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f11de6e1f1c1..d380d9dad0e0 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -3090,8 +3090,8 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				     len, flags);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
+		ret = splice_copy_file_range(src_file, src_off, dst_file,
+					     dst_off, len);
 	return ret;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..148a71b8b4d0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
+#include <linux/splice.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -3195,8 +3196,8 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 				     len, flags);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
+		ret = splice_copy_file_range(src_file, src_off, dst_file,
+					     dst_off, len);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 02788c3c85e5..e238abc78a13 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -10,6 +10,7 @@
 #include <linux/mount.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_ssc.h>
+#include <linux/splice.h>
 #include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
@@ -195,8 +196,8 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
 				     flags);
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(file_in, pos_in, file_out,
-					      pos_out, count, flags);
+		ret = splice_copy_file_range(file_in, pos_in, file_out,
+					     pos_out, count);
 	return ret;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 7783b8522693..e3abf603eaaf 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1396,40 +1396,6 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
-/**
- * generic_copy_file_range - copy data between two files
- * @file_in:	file structure to read from
- * @pos_in:	file offset to read from
- * @file_out:	file structure to write data to
- * @pos_out:	file offset to write data to
- * @len:	amount of data to copy
- * @flags:	copy flags
- *
- * This is a generic filesystem helper to copy data from one file to another.
- * It has no constraints on the source or destination file owners - the files
- * can belong to different superblocks and different filesystem types. Short
- * copies are allowed.
- *
- * This should be called from the @file_out filesystem, as per the
- * ->copy_file_range() method.
- *
- * Returns the number of bytes copied or a negative error indicating the
- * failure.
- */
-
-ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				struct file *file_out, loff_t pos_out,
-				size_t len, unsigned int flags)
-{
-	/* May only be called from within ->copy_file_range() methods */
-	if (WARN_ON_ONCE(flags))
-		return -EINVAL;
-
-	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
-				 min_t(size_t, len, MAX_RW_COUNT));
-}
-EXPORT_SYMBOL(generic_copy_file_range);
-
 /*
  * Performs necessary checks before doing a file copy
  *
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea3a7a668b45..ee461bf0ef63 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/namei.h>
 #include <linux/random.h>
+#include <linux/splice.h>
 #include <linux/uuid.h>
 #include <linux/xattr.h>
 #include <uapi/linux/magic.h>
@@ -1362,8 +1363,8 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 	free_xid(xid);
 
 	if (rc == -EOPNOTSUPP || rc == -EXDEV)
-		rc = generic_copy_file_range(src_file, off, dst_file,
-					     destoff, len, flags);
+		rc = splice_copy_file_range(src_file, off, dst_file,
+					    destoff, len);
 	return rc;
 }
 
diff --git a/fs/splice.c b/fs/splice.c
index 6c1f12872407..5f534bedc25a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1243,7 +1243,7 @@ EXPORT_SYMBOL(do_splice_direct);
  * @len:	number of bytes to splice
  *
  * Description:
- *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *    For use by ->copy_file_range() methods.
  *    Like do_splice_direct(), but vfs_copy_file_range() already holds
  *    start_file_write() on @out file.
  *
@@ -1254,8 +1254,9 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 {
 	lockdep_assert(file_write_started(out));
 
-	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
-				      splice_file_range_actor);
+	return do_splice_direct_actor(in, ppos, out, opos,
+				      min_t(size_t, len, MAX_RW_COUNT),
+				      0, splice_file_range_actor);
 }
 EXPORT_SYMBOL(splice_file_range);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04422a0eccdd..900d0cd55b50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2090,9 +2090,6 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
-extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				       struct file *file_out, loff_t pos_out,
-				       size_t len, unsigned int flags);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 068a8e8ffd73..9dec4861d09f 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -88,6 +88,13 @@ ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 			  loff_t *opos, size_t len);
 
+static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
+					  struct file *out, loff_t pos_out,
+					  size_t len)
+{
+	return splice_file_range(in, &pos_in, out, &pos_out, len);
+}
+
 ssize_t do_tee(struct file *in, struct file *out, size_t len,
 	       unsigned int flags);
 ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-- 
2.34.1


