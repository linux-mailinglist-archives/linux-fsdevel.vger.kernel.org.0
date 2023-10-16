Return-Path: <linux-fsdevel+bounces-428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E77CAE80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5DA281409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F830CF3;
	Mon, 16 Oct 2023 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaZnlf6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696B2377B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:21 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38452B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so50942165e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472557; x=1698077357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhhVBmzTLRq6j76u18cxKgkovQkLdILFSPp057mQvzY=;
        b=GaZnlf6oF5rOClf2iy7LXLc1XSnx2s5dihA1AHrav3mQo/y8xbpXgzwxE+wc6JcRpf
         YlWXM6NGUJWwnL7rj7UiCrghlla4os6dzTjQeiroLlcL+vhVMIYeln+2aINhJOVtBrB3
         o9E14k5AcCIP49Qg6ulyY4R1xbvuCvbUK+NOCifC0+WZsUZU6+ukfMcYOoOM6lWDRKQW
         xzY3ls+vqgG9mgb6khudNihhm3w7OPPj1lzMm2+NIvo8Wf55eaKGOQ5VXwblkXm8olFj
         rdcqnyWazu+jRJq6eedQocE23jgHrC60ePTotFMciJsJmcgwMR5rG4OLCi40Pgk7mSmr
         2ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472557; x=1698077357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhhVBmzTLRq6j76u18cxKgkovQkLdILFSPp057mQvzY=;
        b=ZAqJDcHmDg9zar/k7XnrjLFXEYFSmP96kon4tQDQ/pJpSsVMIc71rQXURy0sHodFIb
         Tbme/RBWhwPNS8Ecd3l8J0+VzWU/B80qwkEMnrZR+78plJl1jMbN7UcJ03t4ovNYjNcq
         4GmA9lFFYhw3VjvTRbAzpT7ltkhMhfDEe5ouGGg/PWOtYQPwRVeGPbTEBS8+5/2V/KFH
         /jEghEDqcPu1RizBRvY3aBFH/au8lWHgMa7D7YI4vVNhpPFhZLFV2mRwpDHOLCs335n0
         phpTZ2g5V+L9vfahXdBM7fylrvogn2ZTQMqvsomAu1VF07WywkBIO1X3muSja+S7LirL
         ZXUA==
X-Gm-Message-State: AOJu0YyCyS8JlQ2mmCdjaHgmHHfmQvPTaTpFvg/lo24vQGXZwTKqN1TY
	H1W6/62vRuLu3/BpPNCTVYAsQl27VMk=
X-Google-Smtp-Source: AGHT+IEiEWJ5QsuyKuZbDRlzMjICyvP9wYZU3zvHC11bVUmz9YiC9FOr50ivo3c2+6ur2hgFE4008g==
X-Received: by 2002:a05:6000:1e91:b0:32d:8185:9526 with SMTP id dd17-20020a0560001e9100b0032d81859526mr12403382wrb.55.1697472557555;
        Mon, 16 Oct 2023 09:09:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 06/12] fuse: introduce FUSE_PASSTHROUGH capability
Date: Mon, 16 Oct 2023 19:08:56 +0300
Message-Id: <20231016160902.2316986-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

FUSE_PASSTHROUGH capability to passthrough FUSE operations to backing
files will be made available with kernel config CONFIG_FUSE_PASSTHROUGH.

When requesting FUSE_PASSTHROUGH, userspace needs to specify the
max_stack_depth that is allowed for FUSE on top of backing files.

Introduce a refcounted fuse_backing object that will be used to
associate an open backing file with a fuse inode.

This association will be used when replying to OPEN with the flag
FOPEN_PASSTHROUGH to setup passthrough of read/write operations on the
open fuse file to the associated backing file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/Kconfig           | 11 +++++++++++
 fs/fuse/Makefile          |  1 +
 fs/fuse/fuse_i.h          | 19 +++++++++++++++++++
 fs/fuse/inode.c           | 20 ++++++++++++++++++++
 fs/fuse/passthrough.c     | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 12 ++++++++++--
 6 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 038ed0b9aaa5..8674dbfbe59d 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -52,3 +52,14 @@ config FUSE_DAX
 
 	  If you want to allow mounting a Virtio Filesystem with the "dax"
 	  option, answer Y.
+
+config FUSE_PASSTHROUGH
+	bool "FUSE passthrough operations support"
+	default y
+	depends on FUSE_FS
+	select FS_STACK
+	help
+	  This allows bypassing FUSE server by mapping specific FUSE operations
+	  to be performed directly on a backing file.
+
+	  If you want to allow passthrough operations, answer Y.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35c058d..504acfb71402 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6e6e721f421b..5be51358542e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,15 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** Container for data related to mapping to backing file */
+struct fuse_backing {
+	struct file *file;
+
+	/** refcount */
+	refcount_t count;
+	struct rcu_head rcu;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -803,6 +812,12 @@ struct fuse_conn {
 	/* Is statx not implemented by fs? */
 	unsigned int no_statx:1;
 
+	/** Passthrough support for read/write IO */
+	unsigned int passthrough:1;
+
+	/** Maximum stack depth for passthrough backing files */
+	int max_stack_depth;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -1340,4 +1355,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* passthrough.c */
+struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
+void fuse_backing_put(struct fuse_backing *fb);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..7e01eb5a04dc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1234,6 +1234,24 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->create_supp_group = 1;
 			if (flags & FUSE_DIRECT_IO_RELAX)
 				fc->direct_io_relax = 1;
+			/*
+			 * max_stack_depth is the max stack depth of FUSE fs,
+			 * so it has to be at least 1 to support passthrough
+			 * to backing files.
+			 *
+			 * with max_stack_depth > 1, the backing files can be
+			 * on a stacked fs (e.g. overlayfs) themselves and with
+			 * max_stack_depth == 1, FUSE fs can be stacked as the
+			 * underlying fs of a stacked fs (e.g. overlayfs).
+			 */
+			if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
+			    (flags & FUSE_PASSTHROUGH) &&
+			    arg->max_stack_depth > 0 &&
+			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
+				fc->passthrough = 1;
+				fc->max_stack_depth = arg->max_stack_depth;
+				fm->sb->s_stack_depth = arg->max_stack_depth;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1289,6 +1307,8 @@ void fuse_send_init(struct fuse_mount *fm)
 #endif
 	if (fm->fc->auto_submounts)
 		flags |= FUSE_SUBMOUNTS;
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		flags |= FUSE_PASSTHROUGH;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..e8639c0a9ac6
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE passthrough to backing file.
+ *
+ * Copyright (c) 2023 CTERA Networks.
+ */
+
+#include "fuse_i.h"
+
+#include <linux/file.h>
+
+struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
+{
+	if (fb && refcount_inc_not_zero(&fb->count))
+		return fb;
+	return NULL;
+}
+
+static void fuse_backing_free(struct fuse_backing *fb)
+{
+	if (fb->file)
+		fput(fb->file);
+	kfree_rcu(fb, rcu);
+}
+
+void fuse_backing_put(struct fuse_backing *fb)
+{
+	if (fb && refcount_dec_and_test(&fb->count))
+		fuse_backing_free(fb);
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index db92a7202b34..acb42a76f7ff 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -211,6 +211,10 @@
  *  7.39
  *  - add FUSE_DIRECT_IO_RELAX
  *  - add FUSE_STATX and related structures
+ *
+ *  7.40
+ *  - add max_stack_depth to fuse_init_out, add FUSE_PASSTHROUGH flag
+ *  - add FOPEN_PASSTHROUGH
  */
 
 #ifndef _LINUX_FUSE_H
@@ -246,7 +250,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 39
+#define FUSE_KERNEL_MINOR_VERSION 40
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -353,6 +357,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_PASSTHROUGH: passthrough read/write operations for this open file
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -361,6 +366,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_PASSTHROUGH	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -450,6 +456,7 @@ struct fuse_file_lock {
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
+#define FUSE_PASSTHROUGH	(1ULL << 37)
 
 /**
  * CUSE INIT request/reply flags
@@ -875,7 +882,8 @@ struct fuse_init_out {
 	uint16_t	max_pages;
 	uint16_t	map_alignment;
 	uint32_t	flags2;
-	uint32_t	unused[7];
+	uint32_t	max_stack_depth;
+	uint32_t	unused[6];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.34.1


