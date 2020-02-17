Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D216170F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBQQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i7UxIu53WMIak3oTmUUFsQPJD3tNfGxlNe4h+y+HDOI=; b=JuW3Ou0xvHI1KqN1eM2sIVyRuH
        ldpdVcjqiTOd6Z6m7sTK7V9I6nbZkf39QT+TTgVozDpItPkSV/vKCM6WYGqt+N7EgM5Up6Hbim5MR
        l96aTafQcysW8OBDeDmfZBED4zxjIE9Oy7sVaZ5f4e3o1e4DUt0q7Qqfgm5GQ7pyVdt6ciT1GWkT+
        tCv9DdrxcRnfxEbroLmU6DAF42qG6+CLuZE56TGqvpLOsCMTDw9nUVuVLGNZmoWI4aGqq6LOKJPpn
        xI/lgjVPLtc2TaohyLkEkfdtfOvSHaVGgF0FtM+UbyFeYXGxmTq06MBDELLigZnwznjZcAtUyeh/V
        auZazpFw==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0b-0006uW-Tf; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZm-U8; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/44] docs: filesystems: convert debugfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:57 +0100
Message-Id: <42db8f9db17a5d8b619130815ae63d1615951d50.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Use copyright symbol;
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Use footnoote markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{debugfs.txt => debugfs.rst}  | 54 ++++++++++---------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 31 insertions(+), 24 deletions(-)
 rename Documentation/filesystems/{debugfs.txt => debugfs.rst} (91%)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.rst
similarity index 91%
rename from Documentation/filesystems/debugfs.txt
rename to Documentation/filesystems/debugfs.rst
index 55336a47a110..80f332b8eb68 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.rst
@@ -1,4 +1,11 @@
-Copyright 2009 Jonathan Corbet <corbet@lwn.net>
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=======
+DebugFS
+=======
+
+Copyright |copy| 2009 Jonathan Corbet <corbet@lwn.net>
 
 Debugfs exists as a simple way for kernel developers to make information
 available to user space.  Unlike /proc, which is only meant for information
@@ -6,11 +13,11 @@ about a process, or sysfs, which has strict one-value-per-file rules,
 debugfs has no rules at all.  Developers can put any information they want
 there.  The debugfs filesystem is also intended to not serve as a stable
 ABI to user space; in theory, there are no stability constraints placed on
-files exported there.  The real world is not always so simple, though [1];
+files exported there.  The real world is not always so simple, though [1]_;
 even debugfs interfaces are best designed with the idea that they will need
 to be maintained forever.
 
-Debugfs is typically mounted with a command like:
+Debugfs is typically mounted with a command like::
 
     mount -t debugfs none /sys/kernel/debug
 
@@ -23,7 +30,7 @@ Note that the debugfs API is exported GPL-only to modules.
 
 Code using debugfs should include <linux/debugfs.h>.  Then, the first order
 of business will be to create at least one directory to hold a set of
-debugfs files:
+debugfs files::
 
     struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 
@@ -36,7 +43,7 @@ something went wrong.  If ERR_PTR(-ENODEV) is returned, that is an
 indication that the kernel has been built without debugfs support and none
 of the functions described below will work.
 
-The most general way to create a file within a debugfs directory is with:
+The most general way to create a file within a debugfs directory is with::
 
     struct dentry *debugfs_create_file(const char *name, umode_t mode,
 				       struct dentry *parent, void *data,
@@ -53,7 +60,7 @@ ERR_PTR(-ERROR) on error, or ERR_PTR(-ENODEV) if debugfs support is
 missing.
 
 Create a file with an initial size, the following function can be used
-instead:
+instead::
 
     struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
 				struct dentry *parent, void *data,
@@ -66,7 +73,7 @@ as the function debugfs_create_file.
 In a number of cases, the creation of a set of file operations is not
 actually necessary; the debugfs code provides a number of helper functions
 for simple situations.  Files containing a single integer value can be
-created with any of:
+created with any of::
 
     void debugfs_create_u8(const char *name, umode_t mode,
 			   struct dentry *parent, u8 *value);
@@ -80,7 +87,7 @@ created with any of:
 These files support both reading and writing the given value; if a specific
 file should not be written to, simply set the mode bits accordingly.  The
 values in these files are in decimal; if hexadecimal is more appropriate,
-the following functions can be used instead:
+the following functions can be used instead::
 
     void debugfs_create_x8(const char *name, umode_t mode,
 			   struct dentry *parent, u8 *value);
@@ -94,7 +101,7 @@ the following functions can be used instead:
 These functions are useful as long as the developer knows the size of the
 value to be exported.  Some types can have different widths on different
 architectures, though, complicating the situation somewhat.  There are
-functions meant to help out in such special cases:
+functions meant to help out in such special cases::
 
     void debugfs_create_size_t(const char *name, umode_t mode,
 			       struct dentry *parent, size_t *value);
@@ -103,7 +110,7 @@ As might be expected, this function will create a debugfs file to represent
 a variable of type size_t.
 
 Similarly, there are helpers for variables of type unsigned long, in decimal
-and hexadecimal:
+and hexadecimal::
 
     struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 					struct dentry *parent,
@@ -111,7 +118,7 @@ and hexadecimal:
     void debugfs_create_xul(const char *name, umode_t mode,
 			    struct dentry *parent, unsigned long *value);
 
-Boolean values can be placed in debugfs with:
+Boolean values can be placed in debugfs with::
 
     struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				       struct dentry *parent, bool *value);
@@ -120,7 +127,7 @@ A read on the resulting file will yield either Y (for non-zero values) or
 N, followed by a newline.  If written to, it will accept either upper- or
 lower-case values, or 1 or 0.  Any other input will be silently ignored.
 
-Also, atomic_t values can be placed in debugfs with:
+Also, atomic_t values can be placed in debugfs with::
 
     void debugfs_create_atomic_t(const char *name, umode_t mode,
 				 struct dentry *parent, atomic_t *value)
@@ -129,7 +136,7 @@ A read of this file will get atomic_t values, and a write of this file
 will set atomic_t values.
 
 Another option is exporting a block of arbitrary binary data, with
-this structure and function:
+this structure and function::
 
     struct debugfs_blob_wrapper {
 	void *data;
@@ -151,7 +158,7 @@ If you want to dump a block of registers (something that happens quite
 often during development, even if little such code reaches mainline.
 Debugfs offers two functions: one to make a registers-only file, and
 another to insert a register block in the middle of another sequential
-file.
+file::
 
     struct debugfs_reg32 {
 	char *name;
@@ -175,7 +182,7 @@ The "base" argument may be 0, but you may want to build the reg32 array
 using __stringify, and a number of register names (macros) are actually
 byte offsets over a base for the register block.
 
-If you want to dump an u32 array in debugfs, you can create file with:
+If you want to dump an u32 array in debugfs, you can create file with::
 
     void debugfs_create_u32_array(const char *name, umode_t mode,
 			struct dentry *parent,
@@ -185,7 +192,7 @@ The "array" argument provides data, and the "elements" argument is
 the number of elements in the array. Note: Once array is created its
 size can not be changed.
 
-There is a helper function to create device related seq_file:
+There is a helper function to create device related seq_file::
 
    struct dentry *debugfs_create_devm_seqfile(struct device *dev,
 				const char *name,
@@ -197,14 +204,14 @@ The "dev" argument is the device related to this debugfs file, and
 the "read_fn" is a function pointer which to be called to print the
 seq_file content.
 
-There are a couple of other directory-oriented helper functions:
+There are a couple of other directory-oriented helper functions::
 
-    struct dentry *debugfs_rename(struct dentry *old_dir, 
+    struct dentry *debugfs_rename(struct dentry *old_dir,
     				  struct dentry *old_dentry,
-		                  struct dentry *new_dir, 
+		                  struct dentry *new_dir,
 				  const char *new_name);
 
-    struct dentry *debugfs_create_symlink(const char *name, 
+    struct dentry *debugfs_create_symlink(const char *name,
                                           struct dentry *parent,
 				      	  const char *target);
 
@@ -219,7 +226,7 @@ module is unloaded without explicitly removing debugfs entries, the result
 will be a lot of stale pointers and no end of highly antisocial behavior.
 So all debugfs users - at least those which can be built as modules - must
 be prepared to remove all files and directories they create there.  A file
-can be removed with:
+can be removed with::
 
     void debugfs_remove(struct dentry *dentry);
 
@@ -229,7 +236,7 @@ be removed.
 Once upon a time, debugfs users were required to remember the dentry
 pointer for every debugfs file they created so that all files could be
 cleaned up.  We live in more civilized times now, though, and debugfs users
-can call:
+can call::
 
     void debugfs_remove_recursive(struct dentry *dentry);
 
@@ -237,5 +244,4 @@ If this function is passed a pointer for the dentry corresponding to the
 top-level directory, the entire hierarchy below that directory will be
 removed.
 
-Notes:
-	[1] http://lwn.net/Articles/309298/
+.. [1] http://lwn.net/Articles/309298/
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 8fe848ea04af..ab3b656bbe60 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -57,6 +57,7 @@ Documentation for filesystem implementations.
    btrfs
    ceph
    cramfs
+   debugfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

