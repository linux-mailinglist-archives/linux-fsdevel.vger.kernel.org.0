Return-Path: <linux-fsdevel+bounces-423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBC77CAE7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E61C209DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3C30CF0;
	Mon, 16 Oct 2023 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZprY/Sav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12030CE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:13 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394FA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso1707169f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472550; x=1698077350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAyvQOyGcN/B0Rn4yR0F7IUyZRuhu1LBoDh3dxJXrDQ=;
        b=ZprY/SavqM+Snf4h+cDPGn7xoAVrLmaMzK8FmOcEYibh1QRSAlNYWeQq16xTmBRqRh
         J5DDf86lNmlda7HSkbNZBoksHcdCeo2R1t/Tx+VVlp91wLeZ8hHl8sakPs1ChSR9JTje
         Z5g+R+0ajgnpSHeS7Bn90KzhprnO7clav3qZen9L6IK4CQhM5N+42oOEBW1tvBhupmrz
         leLuElSb75yZRukFhu57N8M6XowBEq6/GgynFtB2zdi4pfMGAvPa72FEo4/3vMNsMFe/
         rUG2SBTXkjHPpu93yi6nbQOMko53OvVvqsrlubRVOiqRBjOlVeDuWVo+dUMREHrxMLIG
         WTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472550; x=1698077350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAyvQOyGcN/B0Rn4yR0F7IUyZRuhu1LBoDh3dxJXrDQ=;
        b=gD5lPkqcqnbY7BsHoAiIKM8qfCUjrpKWf3J3TS1/NPVZ3KFn5oTDRjVkJDfIMKxe+D
         +ysQrHcsjTKLTS+v4SFD+DnPG515mwdXs4nw3FBbjCQblPCVkc4eYFDVPj4RYIHj6FY7
         RpIu+2jjhxoRaU8kS1XRU7GKCRsGmrxdwRoSUHEqCIs+e+8xT9gDar0JUMxP5xjJ+NJi
         LL9kugNQRf7fvqoyk8HksJk99XqEDIdp46cstGWNlb133uHRLGA8WdH0Bjr70gFCcZdG
         /Wi9c8MfwrNWYOhXhZ+5Y1aGo0xC9WEFWoASyJ0HdkVPB+7ju/3XZquIj8xxop4HV5HY
         t1sA==
X-Gm-Message-State: AOJu0YyMwSOIFcV+e4neNLs5+lNew8/1tgoun5lmUaizy5fKLfkNWQ6q
	sEhshpQKokW1LEs1Zd0hNC0=
X-Google-Smtp-Source: AGHT+IGUUu0PSchqx3OOENENsz10ti9lng9+tssrrpkiSTUVzR5lsH0/Cko9wo9XFIYFntaCWbkwGA==
X-Received: by 2002:adf:f0c5:0:b0:32d:9f1a:9f60 with SMTP id x5-20020adff0c5000000b0032d9f1a9f60mr6820693wro.61.1697472549453;
        Mon, 16 Oct 2023 09:09:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 01/12] fs: prepare for stackable filesystems backing file helpers
Date: Mon, 16 Oct 2023 19:08:51 +0300
Message-Id: <20231016160902.2316986-2-amir73il@gmail.com>
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

In preparation for factoring out some backing file io helpers from
overlayfs, move backing_file_open() into a new file fs/backing-file.c
and header.

Add a MAINTAINERS entry for stackable filesystems and add a Kconfig
FS_STACK which stackable filesystems need to select.

For now, the backing_file struct, the backing_file alloc/free functions
and the backing_file_real_path() accessor remain internal to file_table.c.
We may change that in the future.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 MAINTAINERS                  |  9 +++++++
 fs/Kconfig                   |  4 +++
 fs/Makefile                  |  1 +
 fs/backing-file.c            | 48 ++++++++++++++++++++++++++++++++++++
 fs/open.c                    | 38 ----------------------------
 fs/overlayfs/Kconfig         |  1 +
 fs/overlayfs/file.c          |  1 +
 include/linux/backing-file.h | 17 +++++++++++++
 include/linux/fs.h           |  3 ---
 9 files changed, 81 insertions(+), 41 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 include/linux/backing-file.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..2e3e9a6c1604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8050,6 +8050,15 @@ F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
 F:	include/uapi/linux/openat2.h
 
+FILESYSTEMS [STACKABLE]
+M:	Miklos Szeredi <miklos@szeredi.hu>
+M:	Amir Goldstein <amir73il@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+L:	linux-unionfs@vger.kernel.org
+S:	Maintained
+F:	fs/backing-file.c
+F:	include/linux/backing-file.h
+
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
 L:	linux-hwmon@vger.kernel.org
diff --git a/fs/Kconfig b/fs/Kconfig
index aa7e03cc1941..2af673d7390e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -18,6 +18,10 @@ config VALIDATE_FS_PARSER
 config FS_IOMAP
 	bool
 
+# Stackable filesystems
+config FS_STACK
+	bool
+
 config BUFFER_HEAD
 	bool
 
diff --git a/fs/Makefile b/fs/Makefile
index f9541f40be4e..6fffddc4afde 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
 
+obj-$(CONFIG_FS_STACK)		+= backing-file.o
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
diff --git a/fs/backing-file.c b/fs/backing-file.c
new file mode 100644
index 000000000000..04b33036f709
--- /dev/null
+++ b/fs/backing-file.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common helpers for stackable filesystems and backing files.
+ *
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#include <linux/fs.h>
+#include <linux/backing-file.h>
+
+#include "internal.h"
+
+/**
+ * backing_file_open - open a backing file for kernel internal use
+ * @user_path:	path that the user reuqested to open
+ * @flags:	open flags
+ * @real_path:	path of the backing file
+ * @cred:	credentials for open
+ *
+ * Open a backing file for a stackable filesystem (e.g., overlayfs).
+ * @user_path may be on the stackable filesystem and @real_path on the
+ * underlying filesystem.  In this case, we want to be able to return the
+ * @user_path of the stackable filesystem. This is done by embedding the
+ * returned file into a container structure that also stores the stacked
+ * file's path, which can be retrieved using backing_file_user_path().
+ */
+struct file *backing_file_open(const struct path *user_path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = alloc_empty_backing_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	path_get(user_path);
+	*backing_file_user_path(f) = *user_path;
+	error = vfs_open(real_path, f);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
+	}
+
+	return f;
+}
+EXPORT_SYMBOL_GPL(backing_file_open);
diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..b90142c51797 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1180,44 +1180,6 @@ struct file *kernel_file_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
-/**
- * backing_file_open - open a backing file for kernel internal use
- * @user_path:	path that the user reuqested to open
- * @flags:	open flags
- * @real_path:	path of the backing file
- * @cred:	credentials for open
- *
- * Open a backing file for a stackable filesystem (e.g., overlayfs).
- * @user_path may be on the stackable filesystem and @real_path on the
- * underlying filesystem.  In this case, we want to be able to return the
- * @user_path of the stackable filesystem. This is done by embedding the
- * returned file into a container structure that also stores the stacked
- * file's path, which can be retrieved using backing_file_user_path().
- */
-struct file *backing_file_open(const struct path *user_path, int flags,
-			       const struct path *real_path,
-			       const struct cred *cred)
-{
-	struct file *f;
-	int error;
-
-	f = alloc_empty_backing_file(flags, cred);
-	if (IS_ERR(f))
-		return f;
-
-	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
-	f->f_path = *real_path;
-	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
-	if (error) {
-		fput(f);
-		f = ERR_PTR(error);
-	}
-
-	return f;
-}
-EXPORT_SYMBOL_GPL(backing_file_open);
-
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
 #define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
 
diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index fec5020c3495..2ac67e04a6fb 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config OVERLAY_FS
 	tristate "Overlay filesystem support"
+	select FS_STACK
 	select EXPORTFS
 	help
 	  An overlay filesystem combines two filesystems - an 'upper' filesystem
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index acdd79dd4bfa..19d4d4768fc7 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/backing-file.h>
 #include "overlayfs.h"
 
 #include "../internal.h"	/* for sb_init_dio_done_wq */
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
new file mode 100644
index 000000000000..55c9e804f780
--- /dev/null
+++ b/include/linux/backing-file.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common helpers for stackable filesystems and backing files.
+ *
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#ifndef _LINUX_BACKING_FILE_H
+#define _LINUX_BACKING_FILE_H
+
+#include <linux/file.h>
+
+struct file *backing_file_open(const struct path *user_path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred);
+
+#endif /* _LINUX_BACKING_FILE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 59b2d2ee2465..9b262516ca93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2456,9 +2456,6 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct file *backing_file_open(const struct path *user_path, int flags,
-			       const struct path *real_path,
-			       const struct cred *cred);
 struct path *backing_file_user_path(struct file *f);
 
 /*
-- 
2.34.1


