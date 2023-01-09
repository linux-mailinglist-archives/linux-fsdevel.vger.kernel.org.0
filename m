Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E634661BB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 02:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjAIBAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 20:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjAIBAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:00:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5374F10FFA;
        Sun,  8 Jan 2023 17:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8HpT9M7E2Z08ieaoWeScUI0TdFZeKpmwj7XNUA2SnSg=; b=uiQPEwh4/P+YcNBrUMbwcgumHg
        Xpo3nJb/WfCKAaAYXjv1EAtgukmFWG5b/7F74UfOwuCA5Yie/4h9B5NiunXb4AivwPN2JexlKpXPe
        mCKpLC5CoI8bDR2QD+jKAt/RLlvDzHOoNf/0wc20JYdGQ7vYNk2z7odtV0UtBbXh2PACWHIO5t4IH
        oPgIIZtFRQ+I6XJ01NZfZIOUvP4S4bT9lsGECA0Fv671VLV4SSTRAyrK4eXaXfC5uMZ6nKZppI7iC
        WZj4tAu/C5Ji7zIcy18CWkGrUf12ETrvSE/B6qlxn+JFwNg6kBjgGLErlf1Tyhf4kUsCHBz2Hq7NL
        Zv6LBpcw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEgWo-00GZjc-Gz; Mon, 09 Jan 2023 01:00:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ntfs: fix multiple kernel-doc warnings
Date:   Sun,  8 Jan 2023 17:00:41 -0800
Message-Id: <20230109010041.21442-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix many W=1 kernel-doc warnings in fs/ntfs/:

fs/ntfs/aops.c:30: warning: Incorrect use of kernel-doc format:  * ntfs_end_buffer_async_read - async io completion for reading attributes
fs/ntfs/aops.c:46: warning: expecting prototype for aops.c(). Prototype was for ntfs_end_buffer_async_read() instead
fs/ntfs/aops.c:1655: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_normal_aops = '
fs/ntfs/aops.c:1670: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_compressed_aops = '
fs/ntfs/aops.c:1685: warning: cannot understand function prototype: 'const struct address_space_operations ntfs_mst_aops = '
fs/ntfs/compress.c:22: warning: Incorrect use of kernel-doc format:  * ntfs_compression_constants - enum of constants used in the compression code
fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
fs/ntfs/compress.c:47: warning: cannot understand function prototype: 'u8 *ntfs_compression_buffer; '
fs/ntfs/compress.c:52: warning: expecting prototype for ntfs_cb_lock(). Prototype was for DEFINE_SPINLOCK() instead
fs/ntfs/dir.c:21: warning: Incorrect use of kernel-doc format:  * The little endian Unicode string $I30 as a global constant.
fs/ntfs/dir.c:23: warning: cannot understand function prototype: 'ntfschar I30[5] = '
fs/ntfs/inode.c:31: warning: Incorrect use of kernel-doc format:  * ntfs_test_inode - compare two (possibly fake) inodes for equality
fs/ntfs/inode.c:47: warning: expecting prototype for inode.c(). Prototype was for ntfs_test_inode() instead
fs/ntfs/inode.c:2956: warning: expecting prototype for ntfs_write_inode(). Prototype was for __ntfs_write_inode() instead
fs/ntfs/mft.c:24: warning: expecting prototype for mft.c - NTFS kernel mft record operations. Part of the Linux(). Prototype was for MAX_BHS() instead
fs/ntfs/namei.c:263: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Inode operations for directories.
fs/ntfs/namei.c:368: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Export operations allowing NFS exporting of mounted NTFS partitions.
fs/ntfs/runlist.c:16: warning: Incorrect use of kernel-doc format:  * ntfs_rl_mm - runlist memmove
fs/ntfs/runlist.c:22: warning: expecting prototype for runlist.c - NTFS runlist handling code.  Part of the Linux(). Prototype was for ntfs_rl_mm() instead
fs/ntfs/super.c:61: warning: missing initial short description on line:
 * simple_getbool -
fs/ntfs/super.c:2661: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The complete super operations.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/ntfs/aops.c     |   10 +++++-----
 fs/ntfs/aops.h     |    2 +-
 fs/ntfs/compress.c |    6 +++---
 fs/ntfs/dir.c      |    4 ++--
 fs/ntfs/inode.c    |    6 +++---
 fs/ntfs/mft.c      |    2 +-
 fs/ntfs/namei.c    |    4 ++--
 fs/ntfs/runlist.c  |    2 +-
 fs/ntfs/super.c    |   12 ++++++++++--
 9 files changed, 28 insertions(+), 20 deletions(-)

diff -- a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * aops.c - NTFS kernel address space operations and page cache handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
@@ -1646,7 +1646,7 @@ hole:
 	return block;
 }
 
-/**
+/*
  * ntfs_normal_aops - address space operations for normal inodes and attributes
  *
  * Note these are not used for compressed or mst protected inodes and
@@ -1664,7 +1664,7 @@ const struct address_space_operations nt
 	.error_remove_page = generic_error_remove_page,
 };
 
-/**
+/*
  * ntfs_compressed_aops - address space operations for compressed inodes
  */
 const struct address_space_operations ntfs_compressed_aops = {
@@ -1678,9 +1678,9 @@ const struct address_space_operations nt
 	.error_remove_page = generic_error_remove_page,
 };
 
-/**
+/*
  * ntfs_mst_aops - general address space operations for mst protecteed inodes
- *		   and attributes
+ *			  and attributes
  */
 const struct address_space_operations ntfs_mst_aops = {
 	.read_folio	= ntfs_read_folio,	/* Fill page with data. */
diff -- a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * compress.c - NTFS kernel compressed attributes handling.
  *		Part of the Linux-NTFS project.
  *
@@ -41,12 +41,12 @@ typedef enum {
 	NTFS_MAX_CB_SIZE	= 64 * 1024,
 } ntfs_compression_constants;
 
-/**
+/*
  * ntfs_compression_buffer - one buffer for the decompression engine
  */
 static u8 *ntfs_compression_buffer;
 
-/**
+/*
  * ntfs_cb_lock - spinlock which protects ntfs_compression_buffer
  */
 static DEFINE_SPINLOCK(ntfs_cb_lock);
diff -- a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
@@ -17,7 +17,7 @@
 #include "debug.h"
 #include "ntfs.h"
 
-/**
+/*
  * The little endian Unicode string $I30 as a global constant.
  */
 ntfschar I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
diff -- a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * inode.c - NTFS kernel inode handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
@@ -2935,7 +2935,7 @@ out:
 }
 
 /**
- * ntfs_write_inode - write out a dirty inode
+ * __ntfs_write_inode - write out a dirty inode
  * @vi:		inode to write out
  * @sync:	if true, write out synchronously
  *
@@ -3033,7 +3033,7 @@ int __ntfs_write_inode(struct inode *vi,
 	 * might not need to be written out.
 	 * NOTE: It is not a problem when the inode for $MFT itself is being
 	 * written out as mark_ntfs_record_dirty() will only set I_DIRTY_PAGES
-	 * on the $MFT inode and hence ntfs_write_inode() will not be
+	 * on the $MFT inode and hence __ntfs_write_inode() will not be
 	 * re-invoked because of it which in turn is ok since the dirtied mft
 	 * record will be cleaned and written out to disk below, i.e. before
 	 * this function returns.
diff -- a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
diff -- a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -259,7 +259,7 @@ err_out:
    }
 }
 
-/**
+/*
  * Inode operations for directories.
  */
 const struct inode_operations ntfs_dir_inode_ops = {
@@ -364,7 +364,7 @@ static struct dentry *ntfs_fh_to_parent(
 				    ntfs_nfs_get_inode);
 }
 
-/**
+/*
  * Export operations allowing NFS exporting of mounted NTFS partitions.
  *
  * We use the default ->encode_fh() for now.  Note that they
diff -- a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
diff -- a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -58,9 +58,17 @@ const option_t on_errors_arr[] = {
 };
 
 /**
- * simple_getbool -
+ * simple_getbool - convert input string to a boolean value
+ * @s: input string to convert
+ * @setval: where to store the output boolean value
  *
  * Copied from old ntfs driver (which copied from vfat driver).
+ *
+ * "1", "yes", "true", or an empty string are converted to %true.
+ * "0", "no", and "false" are converted to %false.
+ *
+ * Return: %1 if the string is converted or was empty and *setval contains it;
+ *	   %0 if the string was not valid.
  */
 static int simple_getbool(char *s, bool *setval)
 {
@@ -2657,7 +2665,7 @@ static int ntfs_write_inode(struct inode
 }
 #endif
 
-/**
+/*
  * The complete super operations.
  */
 static const struct super_operations ntfs_sops = {
diff -- a/fs/ntfs/aops.h b/fs/ntfs/aops.h
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * aops.h - Defines for NTFS kernel address space operations and page cache
  *	    handling.  Part of the Linux-NTFS project.
  *
