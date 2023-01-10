Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011A664142
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJNIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbjAJNIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:41 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC959D2B
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356118; x=1704892118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5rJXkwHdK6eaNLyLDSx7WVJof7cMRcI/32v/A+zaMY=;
  b=riTj1E4x64CBOI4RaSat0EScC0FcNAUMkfZt93VanOx9mUIn08qQ7p3U
   g/v1fRuXNBw8SC44aWk/ovgvVld3BJF5EHXEtIoTzrufELYXwZb5fvqjA
   54IGCrrSfpI0+ZiUq7PhM218XksWPDU/9HsJLOw7UZIjqlJtgFOLACq91
   BotWEqnQHN+3wE1X0wwI13a3AkEDLch7jffRlqQW91lkmExxBghc4E3vG
   hwhRrlvwFz5Qnf50KCEgVLLh1ycKiy1WJYF2LqBZirNSdDDD23guT76yq
   FL0pFxf8jrGi/kJGfyiey6jDh/qdAfJhaZDGGvUQ9FTA9iXB5lWIVmhrd
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740562"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:38 +0800
IronPort-SDR: 3KppjhOiOYfNqv+GXxYv+Lm89rgGxPwQFv5D3bAfxtuaDj6j6JwwarcBmURa3M35P9BT6JNuBp
 IZVwkRQRyCWfqYOym4sG2mYVmLQdI4279//6KiuHCIMYIOtPUtvkReltR49SZdIwwqvOyxvR4D
 fyPt/LQhz2lurQZi2rKabSPDMNbrebwqJN2Q+IjMGNLH4kizOyOSzxGhex20UMOsE2hrwHuLhs
 PKuG66dIfv0DrlFIdz23HIgn1/zsj15YY90+m2axMAXMMtA4IAgRGwbKHGm1AB9FV1/uR0UHEP
 JTk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:43 -0800
IronPort-SDR: 2bMSrCxnkXlZyx6pzm1ELurQFIxSkdXbxQ9wbr7UvdjEPc2gEV169LYjsFI9RLOs4dCV4gqvxR
 DxNjnKMj516XAzf6bfNHxWm1zTbxqPCpPmewtqh37koE9wq+sXz0tns8KDsOnW/C2nVpFwkVDf
 8AlURteZ1fMkUH+wHBxPnd0GEqOw468QnYf6d2pmBivTy6lLefhmVsAow3g+a6q6vHHlahFO+y
 M0PHrvxiIPQWkJxWywOHlWXJjSYigUXPEH9GpZcmWeUsH9QV30YVrJvvv+tGlDmhN1/D4+L5JD
 Ps0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjK59BKz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356114; x=1675948115; bh=f5rJXkwHdK6eaNLyLD
        Sx7WVJof7cMRcI/32v/A+zaMY=; b=FTdx60xaA6fMGTzAbQ76BjeZ795kcnmlYX
        MljsPauFXT7ajCK8PMD4a2oUQLAwdRo0+CkoLITrwlVHff34uNjdtGb0ZyAYO4N3
        U5SXNY7h5xHfAnn39wwnAnPPvg6f5taMchG8aH7SuBKcHd9NoZpb8USANGGJN6S/
        5R2AZjDDk2lQ/bcky66eBxcP31+T2nYNy1Rlf1eHf0NeNSeoaiFDvLhnOyHMxVLY
        /gw7CJVpaTCTRCXESmY/1pkUORziRNIIgCkd1Aukb6P1Q+g17ia0uwCCC73CzRmn
        iwmRzBMocGBw/Jm4HQjQIilf60nujaus8IwF34W+xVKLBUApUkEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KjUdAE34nOGp for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:34 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjF6M0mz1RvLy;
        Tue, 10 Jan 2023 05:08:33 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 2/7] zonefs: Reorganize code
Date:   Tue, 10 Jan 2023 22:08:25 +0900
Message-Id: <20230110130830.246019-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move all code related to zone file operations from super.c to the new
file.c file. Inode and zone management code remains in super.c.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/Makefile |   2 +-
 fs/zonefs/file.c   | 874 ++++++++++++++++++++++++++++++++++++++++
 fs/zonefs/super.c  | 973 +++------------------------------------------
 fs/zonefs/zonefs.h |  22 +
 4 files changed, 955 insertions(+), 916 deletions(-)
 create mode 100644 fs/zonefs/file.c

diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
index 9fe54f5319f2..645f7229de4a 100644
--- a/fs/zonefs/Makefile
+++ b/fs/zonefs/Makefile
@@ -3,4 +3,4 @@ ccflags-y				+=3D -I$(src)
=20
 obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o
=20
-zonefs-y	:=3D super.o sysfs.o
+zonefs-y	:=3D super.o file.o sysfs.o
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
new file mode 100644
index 000000000000..ece0f3959b6d
--- /dev/null
+++ b/fs/zonefs/file.c
@@ -0,0 +1,874 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple file system for zoned block devices exposing zones as files.
+ *
+ * Copyright (C) 2022 Western Digital Corporation or its affiliates.
+ */
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/iomap.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/statfs.h>
+#include <linux/writeback.h>
+#include <linux/quotaops.h>
+#include <linux/seq_file.h>
+#include <linux/parser.h>
+#include <linux/uio.h>
+#include <linux/mman.h>
+#include <linux/sched/mm.h>
+#include <linux/task_io_accounting_ops.h>
+
+#include "zonefs.h"
+
+#include "trace.h"
+
+static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned int flags,
+				   struct iomap *iomap, struct iomap *srcmap)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	loff_t isize;
+
+	/*
+	 * All blocks are always mapped below EOF. If reading past EOF,
+	 * act as if there is a hole up to the file maximum size.
+	 */
+	mutex_lock(&zi->i_truncate_mutex);
+	iomap->bdev =3D inode->i_sb->s_bdev;
+	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
+	isize =3D i_size_read(inode);
+	if (iomap->offset >=3D isize) {
+		iomap->type =3D IOMAP_HOLE;
+		iomap->addr =3D IOMAP_NULL_ADDR;
+		iomap->length =3D length;
+	} else {
+		iomap->type =3D IOMAP_MAPPED;
+		iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+		iomap->length =3D isize - iomap->offset;
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	trace_zonefs_iomap_begin(inode, iomap);
+
+	return 0;
+}
+
+static const struct iomap_ops zonefs_read_iomap_ops =3D {
+	.iomap_begin	=3D zonefs_read_iomap_begin,
+};
+
+static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
+				    loff_t length, unsigned int flags,
+				    struct iomap *iomap, struct iomap *srcmap)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	loff_t isize;
+
+	/* All write I/Os should always be within the file maximum size */
+	if (WARN_ON_ONCE(offset + length > zi->i_max_size))
+		return -EIO;
+
+	/*
+	 * Sequential zones can only accept direct writes. This is already
+	 * checked when writes are issued, so warn if we see a page writeback
+	 * operation.
+	 */
+	if (WARN_ON_ONCE(zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+			 !(flags & IOMAP_DIRECT)))
+		return -EIO;
+
+	/*
+	 * For conventional zones, all blocks are always mapped. For sequential
+	 * zones, all blocks after always mapped below the inode size (zone
+	 * write pointer) and unwriten beyond.
+	 */
+	mutex_lock(&zi->i_truncate_mutex);
+	iomap->bdev =3D inode->i_sb->s_bdev;
+	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
+	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+	isize =3D i_size_read(inode);
+	if (iomap->offset >=3D isize) {
+		iomap->type =3D IOMAP_UNWRITTEN;
+		iomap->length =3D zi->i_max_size - iomap->offset;
+	} else {
+		iomap->type =3D IOMAP_MAPPED;
+		iomap->length =3D isize - iomap->offset;
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	trace_zonefs_iomap_begin(inode, iomap);
+
+	return 0;
+}
+
+static const struct iomap_ops zonefs_write_iomap_ops =3D {
+	.iomap_begin	=3D zonefs_write_iomap_begin,
+};
+
+static int zonefs_read_folio(struct file *unused, struct folio *folio)
+{
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+}
+
+static void zonefs_readahead(struct readahead_control *rac)
+{
+	iomap_readahead(rac, &zonefs_read_iomap_ops);
+}
+
+/*
+ * Map blocks for page writeback. This is used only on conventional zone=
 files,
+ * which implies that the page range can only be within the fixed inode =
size.
+ */
+static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
+				   struct inode *inode, loff_t offset)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
+		return -EIO;
+	if (WARN_ON_ONCE(offset >=3D i_size_read(inode)))
+		return -EIO;
+
+	/* If the mapping is already OK, nothing needs to be done */
+	if (offset >=3D wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
+					IOMAP_WRITE, &wpc->iomap, NULL);
+}
+
+static const struct iomap_writeback_ops zonefs_writeback_ops =3D {
+	.map_blocks		=3D zonefs_write_map_blocks,
+};
+
+static int zonefs_writepages(struct address_space *mapping,
+			     struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc =3D { };
+
+	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+}
+
+static int zonefs_swap_activate(struct swap_info_struct *sis,
+				struct file *swap_file, sector_t *span)
+{
+	struct inode *inode =3D file_inode(swap_file);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
+		zonefs_err(inode->i_sb,
+			   "swap file: not a conventional zone file\n");
+		return -EINVAL;
+	}
+
+	return iomap_swapfile_activate(sis, swap_file, span,
+				       &zonefs_read_iomap_ops);
+}
+
+const struct address_space_operations zonefs_file_aops =3D {
+	.read_folio		=3D zonefs_read_folio,
+	.readahead		=3D zonefs_readahead,
+	.writepages		=3D zonefs_writepages,
+	.dirty_folio		=3D filemap_dirty_folio,
+	.release_folio		=3D iomap_release_folio,
+	.invalidate_folio	=3D iomap_invalidate_folio,
+	.migrate_folio		=3D filemap_migrate_folio,
+	.is_partially_uptodate	=3D iomap_is_partially_uptodate,
+	.error_remove_page	=3D generic_error_remove_page,
+	.direct_IO		=3D noop_direct_IO,
+	.swap_activate		=3D zonefs_swap_activate,
+};
+
+int zonefs_file_truncate(struct inode *inode, loff_t isize)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	loff_t old_isize;
+	enum req_op op;
+	int ret =3D 0;
+
+	/*
+	 * Only sequential zone files can be truncated and truncation is allowe=
d
+	 * only down to a 0 size, which is equivalent to a zone reset, and to
+	 * the maximum file size, which is equivalent to a zone finish.
+	 */
+	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+		return -EPERM;
+
+	if (!isize)
+		op =3D REQ_OP_ZONE_RESET;
+	else if (isize =3D=3D zi->i_max_size)
+		op =3D REQ_OP_ZONE_FINISH;
+	else
+		return -EPERM;
+
+	inode_dio_wait(inode);
+
+	/* Serialize against page faults */
+	filemap_invalidate_lock(inode->i_mapping);
+
+	/* Serialize against zonefs_iomap_begin() */
+	mutex_lock(&zi->i_truncate_mutex);
+
+	old_isize =3D i_size_read(inode);
+	if (isize =3D=3D old_isize)
+		goto unlock;
+
+	ret =3D zonefs_zone_mgmt(inode, op);
+	if (ret)
+		goto unlock;
+
+	/*
+	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,
+	 * take care of open zones.
+	 */
+	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
+		/*
+		 * Truncating a zone to EMPTY or FULL is the equivalent of
+		 * closing the zone. For a truncation to 0, we need to
+		 * re-open the zone to ensure new writes can be processed.
+		 * For a truncation to the maximum file size, the zone is
+		 * closed and writes cannot be accepted anymore, so clear
+		 * the open flag.
+		 */
+		if (!isize)
+			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+		else
+			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+	}
+
+	zonefs_update_stats(inode, isize);
+	truncate_setsize(inode, isize);
+	zi->i_wpoffset =3D isize;
+	zonefs_account_active(inode);
+
+unlock:
+	mutex_unlock(&zi->i_truncate_mutex);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return ret;
+}
+
+static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end=
,
+			     int datasync)
+{
+	struct inode *inode =3D file_inode(file);
+	int ret =3D 0;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	/*
+	 * Since only direct writes are allowed in sequential files, page cache
+	 * flush is needed only for conventional zone files.
+	 */
+	if (ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
+		ret =3D file_write_and_wait_range(file, start, end);
+	if (!ret)
+		ret =3D blkdev_issue_flush(inode->i_sb->s_bdev);
+
+	if (ret)
+		zonefs_io_error(inode, true);
+
+	return ret;
+}
+
+static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode =3D file_inode(vmf->vma->vm_file);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	vm_fault_t ret;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * Sanity check: only conventional zone files can have shared
+	 * writeable mappings.
+	 */
+	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
+		return VM_FAULT_NOPAGE;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	/* Serialize against truncates */
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	ret =3D iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct zonefs_file_vm_ops =3D {
+	.fault		=3D filemap_fault,
+	.map_pages	=3D filemap_map_pages,
+	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,
+};
+
+static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vm=
a)
+{
+	/*
+	 * Conventional zones accept random writes, so their files can support
+	 * shared writable mappings. For sequential zone files, only read
+	 * mappings are possible since there are no guarantees for write
+	 * ordering between msync() and page cache writeback.
+	 */
+	if (ZONEFS_I(file_inode(file))->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
+
+	file_accessed(file);
+	vma->vm_ops =3D &zonefs_file_vm_ops;
+
+	return 0;
+}
+
+static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int w=
hence)
+{
+	loff_t isize =3D i_size_read(file_inode(file));
+
+	/*
+	 * Seeks are limited to below the zone size for conventional zones
+	 * and below the zone write pointer for sequential zones. In both
+	 * cases, this limit is the inode size.
+	 */
+	return generic_file_llseek_size(file, offset, whence, isize, isize);
+}
+
+static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size=
,
+					int error, unsigned int flags)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (error) {
+		zonefs_io_error(inode, true);
+		return error;
+	}
+
+	if (size && zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
+		/*
+		 * Note that we may be seeing completions out of order,
+		 * but that is not a problem since a write completed
+		 * successfully necessarily means that all preceding writes
+		 * were also successful. So we can safely increase the inode
+		 * size to the write end location.
+		 */
+		mutex_lock(&zi->i_truncate_mutex);
+		if (i_size_read(inode) < iocb->ki_pos + size) {
+			zonefs_update_stats(inode, iocb->ki_pos + size);
+			zonefs_i_size_write(inode, iocb->ki_pos + size);
+		}
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+	return 0;
+}
+
+static const struct iomap_dio_ops zonefs_write_dio_ops =3D {
+	.end_io			=3D zonefs_file_write_dio_end_io,
+};
+
+static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct block_device *bdev =3D inode->i_sb->s_bdev;
+	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
+	struct bio *bio;
+	ssize_t size;
+	int nr_pages;
+	ssize_t ret;
+
+	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
+	iov_iter_truncate(from, max);
+
+	nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
+	if (!nr_pages)
+		return 0;
+
+	bio =3D bio_alloc(bdev, nr_pages,
+			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
+	bio->bi_iter.bi_sector =3D zi->i_zsector;
+	bio->bi_ioprio =3D iocb->ki_ioprio;
+	if (iocb_is_dsync(iocb))
+		bio->bi_opf |=3D REQ_FUA;
+
+	ret =3D bio_iov_iter_get_pages(bio, from);
+	if (unlikely(ret))
+		goto out_release;
+
+	size =3D bio->bi_iter.bi_size;
+	task_io_account_write(size);
+
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, iocb);
+
+	ret =3D submit_bio_wait(bio);
+
+	/*
+	 * If the file zone was written underneath the file system, the zone
+	 * write pointer may not be where we expect it to be, but the zone
+	 * append write can still succeed. So check manually that we wrote wher=
e
+	 * we intended to, that is, at zi->i_wpoffset.
+	 */
+	if (!ret) {
+		sector_t wpsector =3D
+			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
+
+		if (bio->bi_iter.bi_sector !=3D wpsector) {
+			zonefs_warn(inode->i_sb,
+				"Corrupted write pointer %llu for zone at %llu\n",
+				wpsector, zi->i_zsector);
+			ret =3D -EIO;
+		}
+	}
+
+	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
+	trace_zonefs_file_dio_append(inode, size, ret);
+
+out_release:
+	bio_release_pages(bio, false);
+	bio_put(bio);
+
+	if (ret >=3D 0) {
+		iocb->ki_pos +=3D size;
+		return size;
+	}
+
+	return ret;
+}
+
+/*
+ * Do not exceed the LFS limits nor the file zone size. If pos is under =
the
+ * limit it becomes a short access. If it exceeds the limit, return -EFB=
IG.
+ */
+static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
+					loff_t count)
+{
+	struct inode *inode =3D file_inode(file);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	loff_t limit =3D rlimit(RLIMIT_FSIZE);
+	loff_t max_size =3D zi->i_max_size;
+
+	if (limit !=3D RLIM_INFINITY) {
+		if (pos >=3D limit) {
+			send_sig(SIGXFSZ, current, 0);
+			return -EFBIG;
+		}
+		count =3D min(count, limit - pos);
+	}
+
+	if (!(file->f_flags & O_LARGEFILE))
+		max_size =3D min_t(loff_t, MAX_NON_LFS, max_size);
+
+	if (unlikely(pos >=3D max_size))
+		return -EFBIG;
+
+	return min(count, max_size - pos);
+}
+
+static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *=
from)
+{
+	struct file *file =3D iocb->ki_filp;
+	struct inode *inode =3D file_inode(file);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	loff_t count;
+
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
+	if (iocb->ki_flags & IOCB_APPEND) {
+		if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+			return -EINVAL;
+		mutex_lock(&zi->i_truncate_mutex);
+		iocb->ki_pos =3D zi->i_wpoffset;
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+	count =3D zonefs_write_check_limits(file, iocb->ki_pos,
+					  iov_iter_count(from));
+	if (count < 0)
+		return count;
+
+	iov_iter_truncate(from, count);
+	return iov_iter_count(from);
+}
+
+/*
+ * Handle direct writes. For sequential zone files, this is the only pos=
sible
+ * write path. For these files, check that the user is issuing writes
+ * sequentially from the end of the file. This code assumes that the blo=
ck layer
+ * delivers write requests to the device in sequential order. This is al=
ways the
+ * case if a block IO scheduler implementing the ELEVATOR_F_ZBD_SEQ_WRIT=
E
+ * elevator feature is being used (e.g. mq-deadline). The block layer al=
ways
+ * automatically select such an elevator for zoned block devices during =
the
+ * device initialization.
+ */
+static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter=
 *from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	bool sync =3D is_sync_kiocb(iocb);
+	bool append =3D false;
+	ssize_t ret, count;
+
+	/*
+	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
+	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
+	 * on the inode lock but the second goes through but is now unaligned).
+	 */
+	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !sync &&
+	    (iocb->ki_flags & IOCB_NOWAIT))
+		return -EOPNOTSUPP;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	count =3D zonefs_write_checks(iocb, from);
+	if (count <=3D 0) {
+		ret =3D count;
+		goto inode_unlock;
+	}
+
+	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
+		ret =3D -EINVAL;
+		goto inode_unlock;
+	}
+
+	/* Enforce sequential writes (append only) in sequential zones */
+	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ) {
+		mutex_lock(&zi->i_truncate_mutex);
+		if (iocb->ki_pos !=3D zi->i_wpoffset) {
+			mutex_unlock(&zi->i_truncate_mutex);
+			ret =3D -EINVAL;
+			goto inode_unlock;
+		}
+		mutex_unlock(&zi->i_truncate_mutex);
+		append =3D sync;
+	}
+
+	if (append)
+		ret =3D zonefs_file_dio_append(iocb, from);
+	else
+		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
+				   &zonefs_write_dio_ops, 0, NULL, 0);
+	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
+		if (ret > 0)
+			count =3D ret;
+
+		/*
+		 * Update the zone write pointer offset assuming the write
+		 * operation succeeded. If it did not, the error recovery path
+		 * will correct it. Also do active seq file accounting.
+		 */
+		mutex_lock(&zi->i_truncate_mutex);
+		zi->i_wpoffset +=3D count;
+		zonefs_account_active(inode);
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+inode_unlock:
+	inode_unlock(inode);
+
+	return ret;
+}
+
+static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
+					  struct iov_iter *from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	ssize_t ret;
+
+	/*
+	 * Direct IO writes are mandatory for sequential zone files so that the
+	 * write IO issuing order is preserved.
+	 */
+	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV)
+		return -EIO;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	ret =3D zonefs_write_checks(iocb, from);
+	if (ret <=3D 0)
+		goto inode_unlock;
+
+	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
+	if (ret > 0)
+		iocb->ki_pos +=3D ret;
+	else if (ret =3D=3D -EIO)
+		zonefs_io_error(inode, true);
+
+inode_unlock:
+	inode_unlock(inode);
+	if (ret > 0)
+		ret =3D generic_write_sync(iocb, ret);
+
+	return ret;
+}
+
+static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_ite=
r *from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	if (sb_rdonly(inode->i_sb))
+		return -EROFS;
+
+	/* Write operations beyond the zone size are not allowed */
+	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)
+		return -EFBIG;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ssize_t ret =3D zonefs_file_dio_write(iocb, from);
+
+		if (ret !=3D -ENOTBLK)
+			return ret;
+	}
+
+	return zonefs_file_buffered_write(iocb, from);
+}
+
+static int zonefs_file_read_dio_end_io(struct kiocb *iocb, ssize_t size,
+				       int error, unsigned int flags)
+{
+	if (error) {
+		zonefs_io_error(file_inode(iocb->ki_filp), false);
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct iomap_dio_ops zonefs_read_dio_ops =3D {
+	.end_io			=3D zonefs_file_read_dio_end_io,
+};
+
+static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter=
 *to)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	loff_t isize;
+	ssize_t ret;
+
+	/* Offline zones cannot be read */
+	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
+		return -EPERM;
+
+	if (iocb->ki_pos >=3D zi->i_max_size)
+		return 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	/* Limit read operations to written data */
+	mutex_lock(&zi->i_truncate_mutex);
+	isize =3D i_size_read(inode);
+	if (iocb->ki_pos >=3D isize) {
+		mutex_unlock(&zi->i_truncate_mutex);
+		ret =3D 0;
+		goto inode_unlock;
+	}
+	iov_iter_truncate(to, isize - iocb->ki_pos);
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		size_t count =3D iov_iter_count(to);
+
+		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
+			ret =3D -EINVAL;
+			goto inode_unlock;
+		}
+		file_accessed(iocb->ki_filp);
+		ret =3D iomap_dio_rw(iocb, to, &zonefs_read_iomap_ops,
+				   &zonefs_read_dio_ops, 0, NULL, 0);
+	} else {
+		ret =3D generic_file_read_iter(iocb, to);
+		if (ret =3D=3D -EIO)
+			zonefs_io_error(inode, false);
+	}
+
+inode_unlock:
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+/*
+ * Write open accounting is done only for sequential files.
+ */
+static inline bool zonefs_seq_file_need_wro(struct inode *inode,
+					    struct file *file)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+		return false;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return false;
+
+	return true;
+}
+
+static int zonefs_seq_file_write_open(struct inode *inode)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	int ret =3D 0;
+
+	mutex_lock(&zi->i_truncate_mutex);
+
+	if (!zi->i_wr_refcnt) {
+		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
+		unsigned int wro =3D atomic_inc_return(&sbi->s_wro_seq_files);
+
+		if (sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
+
+			if (sbi->s_max_wro_seq_files
+			    && wro > sbi->s_max_wro_seq_files) {
+				atomic_dec(&sbi->s_wro_seq_files);
+				ret =3D -EBUSY;
+				goto unlock;
+			}
+
+			if (i_size_read(inode) < zi->i_max_size) {
+				ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+				if (ret) {
+					atomic_dec(&sbi->s_wro_seq_files);
+					goto unlock;
+				}
+				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
+				zonefs_account_active(inode);
+			}
+		}
+	}
+
+	zi->i_wr_refcnt++;
+
+unlock:
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	return ret;
+}
+
+static int zonefs_file_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret =3D generic_file_open(inode, file);
+	if (ret)
+		return ret;
+
+	if (zonefs_seq_file_need_wro(inode, file))
+		return zonefs_seq_file_write_open(inode);
+
+	return 0;
+}
+
+static void zonefs_seq_file_write_close(struct inode *inode)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	int ret =3D 0;
+
+	mutex_lock(&zi->i_truncate_mutex);
+
+	zi->i_wr_refcnt--;
+	if (zi->i_wr_refcnt)
+		goto unlock;
+
+	/*
+	 * The file zone may not be open anymore (e.g. the file was truncated t=
o
+	 * its maximum size or it was fully written). For this case, we only
+	 * need to decrement the write open count.
+	 */
+	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
+		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
+		if (ret) {
+			__zonefs_io_error(inode, false);
+			/*
+			 * Leaving zones explicitly open may lead to a state
+			 * where most zones cannot be written (zone resources
+			 * exhausted). So take preventive action by remounting
+			 * read-only.
+			 */
+			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
+			    !(sb->s_flags & SB_RDONLY)) {
+				zonefs_warn(sb,
+					"closing zone at %llu failed %d\n",
+					zi->i_zsector, ret);
+				zonefs_warn(sb,
+					"remounting filesystem read-only\n");
+				sb->s_flags |=3D SB_RDONLY;
+			}
+			goto unlock;
+		}
+
+		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+		zonefs_account_active(inode);
+	}
+
+	atomic_dec(&sbi->s_wro_seq_files);
+
+unlock:
+	mutex_unlock(&zi->i_truncate_mutex);
+}
+
+static int zonefs_file_release(struct inode *inode, struct file *file)
+{
+	/*
+	 * If we explicitly open a zone we must close it again as well, but the
+	 * zone management operation can fail (either due to an IO error or as
+	 * the zone has gone offline or read-only). Make sure we don't fail the
+	 * close(2) for user-space.
+	 */
+	if (zonefs_seq_file_need_wro(inode, file))
+		zonefs_seq_file_write_close(inode);
+
+	return 0;
+}
+
+const struct file_operations zonefs_file_operations =3D {
+	.open		=3D zonefs_file_open,
+	.release	=3D zonefs_file_release,
+	.fsync		=3D zonefs_file_fsync,
+	.mmap		=3D zonefs_file_mmap,
+	.llseek		=3D zonefs_file_llseek,
+	.read_iter	=3D zonefs_file_read_iter,
+	.write_iter	=3D zonefs_file_write_iter,
+	.splice_read	=3D generic_file_splice_read,
+	.splice_write	=3D iter_file_splice_write,
+	.iopoll		=3D iocb_bio_iopoll,
+};
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index a9c5c3f720ad..e808276b8801 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -30,7 +30,7 @@
 /*
  * Manage the active zone count. Called with zi->i_truncate_mutex held.
  */
-static void zonefs_account_active(struct inode *inode)
+void zonefs_account_active(struct inode *inode)
 {
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
@@ -68,7 +68,7 @@ static void zonefs_account_active(struct inode *inode)
 	}
 }
=20
-static inline int zonefs_zone_mgmt(struct inode *inode, enum req_op op)
+int zonefs_zone_mgmt(struct inode *inode, enum req_op op)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
 	int ret;
@@ -99,7 +99,7 @@ static inline int zonefs_zone_mgmt(struct inode *inode,=
 enum req_op op)
 	return 0;
 }
=20
-static inline void zonefs_i_size_write(struct inode *inode, loff_t isize=
)
+void zonefs_i_size_write(struct inode *inode, loff_t isize)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
=20
@@ -117,167 +117,7 @@ static inline void zonefs_i_size_write(struct inode=
 *inode, loff_t isize)
 	}
 }
=20
-static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
-				   loff_t length, unsigned int flags,
-				   struct iomap *iomap, struct iomap *srcmap)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct super_block *sb =3D inode->i_sb;
-	loff_t isize;
-
-	/*
-	 * All blocks are always mapped below EOF. If reading past EOF,
-	 * act as if there is a hole up to the file maximum size.
-	 */
-	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev =3D inode->i_sb->s_bdev;
-	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
-	isize =3D i_size_read(inode);
-	if (iomap->offset >=3D isize) {
-		iomap->type =3D IOMAP_HOLE;
-		iomap->addr =3D IOMAP_NULL_ADDR;
-		iomap->length =3D length;
-	} else {
-		iomap->type =3D IOMAP_MAPPED;
-		iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
-		iomap->length =3D isize - iomap->offset;
-	}
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	trace_zonefs_iomap_begin(inode, iomap);
-
-	return 0;
-}
-
-static const struct iomap_ops zonefs_read_iomap_ops =3D {
-	.iomap_begin	=3D zonefs_read_iomap_begin,
-};
-
-static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
-				    loff_t length, unsigned int flags,
-				    struct iomap *iomap, struct iomap *srcmap)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct super_block *sb =3D inode->i_sb;
-	loff_t isize;
-
-	/* All write I/Os should always be within the file maximum size */
-	if (WARN_ON_ONCE(offset + length > zi->i_max_size))
-		return -EIO;
-
-	/*
-	 * Sequential zones can only accept direct writes. This is already
-	 * checked when writes are issued, so warn if we see a page writeback
-	 * operation.
-	 */
-	if (WARN_ON_ONCE(zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
-			 !(flags & IOMAP_DIRECT)))
-		return -EIO;
-
-	/*
-	 * For conventional zones, all blocks are always mapped. For sequential
-	 * zones, all blocks after always mapped below the inode size (zone
-	 * write pointer) and unwriten beyond.
-	 */
-	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev =3D inode->i_sb->s_bdev;
-	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
-	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
-	isize =3D i_size_read(inode);
-	if (iomap->offset >=3D isize) {
-		iomap->type =3D IOMAP_UNWRITTEN;
-		iomap->length =3D zi->i_max_size - iomap->offset;
-	} else {
-		iomap->type =3D IOMAP_MAPPED;
-		iomap->length =3D isize - iomap->offset;
-	}
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	trace_zonefs_iomap_begin(inode, iomap);
-
-	return 0;
-}
-
-static const struct iomap_ops zonefs_write_iomap_ops =3D {
-	.iomap_begin	=3D zonefs_write_iomap_begin,
-};
-
-static int zonefs_read_folio(struct file *unused, struct folio *folio)
-{
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
-}
-
-static void zonefs_readahead(struct readahead_control *rac)
-{
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
-}
-
-/*
- * Map blocks for page writeback. This is used only on conventional zone=
 files,
- * which implies that the page range can only be within the fixed inode =
size.
- */
-static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
-				   struct inode *inode, loff_t offset)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
-		return -EIO;
-	if (WARN_ON_ONCE(offset >=3D i_size_read(inode)))
-		return -EIO;
-
-	/* If the mapping is already OK, nothing needs to be done */
-	if (offset >=3D wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
-		return 0;
-
-	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
-					IOMAP_WRITE, &wpc->iomap, NULL);
-}
-
-static const struct iomap_writeback_ops zonefs_writeback_ops =3D {
-	.map_blocks		=3D zonefs_write_map_blocks,
-};
-
-static int zonefs_writepages(struct address_space *mapping,
-			     struct writeback_control *wbc)
-{
-	struct iomap_writepage_ctx wpc =3D { };
-
-	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
-}
-
-static int zonefs_swap_activate(struct swap_info_struct *sis,
-				struct file *swap_file, sector_t *span)
-{
-	struct inode *inode =3D file_inode(swap_file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
-		zonefs_err(inode->i_sb,
-			   "swap file: not a conventional zone file\n");
-		return -EINVAL;
-	}
-
-	return iomap_swapfile_activate(sis, swap_file, span,
-				       &zonefs_read_iomap_ops);
-}
-
-static const struct address_space_operations zonefs_file_aops =3D {
-	.read_folio		=3D zonefs_read_folio,
-	.readahead		=3D zonefs_readahead,
-	.writepages		=3D zonefs_writepages,
-	.dirty_folio		=3D filemap_dirty_folio,
-	.release_folio		=3D iomap_release_folio,
-	.invalidate_folio	=3D iomap_invalidate_folio,
-	.migrate_folio		=3D filemap_migrate_folio,
-	.is_partially_uptodate	=3D iomap_is_partially_uptodate,
-	.error_remove_page	=3D generic_error_remove_page,
-	.direct_IO		=3D noop_direct_IO,
-	.swap_activate		=3D zonefs_swap_activate,
-};
-
-static void zonefs_update_stats(struct inode *inode, loff_t new_isize)
+void zonefs_update_stats(struct inode *inode, loff_t new_isize)
 {
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
@@ -487,7 +327,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
  * eventually correct the file size and zonefs inode write pointer offse=
t
  * (which can be out of sync with the drive due to partial write failure=
s).
  */
-static void __zonefs_io_error(struct inode *inode, bool write)
+void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
 	struct super_block *sb =3D inode->i_sb;
@@ -526,749 +366,6 @@ static void __zonefs_io_error(struct inode *inode, =
bool write)
 	memalloc_noio_restore(noio_flag);
 }
=20
-static void zonefs_io_error(struct inode *inode, bool write)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	mutex_lock(&zi->i_truncate_mutex);
-	__zonefs_io_error(inode, write);
-	mutex_unlock(&zi->i_truncate_mutex);
-}
-
-static int zonefs_file_truncate(struct inode *inode, loff_t isize)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	loff_t old_isize;
-	enum req_op op;
-	int ret =3D 0;
-
-	/*
-	 * Only sequential zone files can be truncated and truncation is allowe=
d
-	 * only down to a 0 size, which is equivalent to a zone reset, and to
-	 * the maximum file size, which is equivalent to a zone finish.
-	 */
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
-		return -EPERM;
-
-	if (!isize)
-		op =3D REQ_OP_ZONE_RESET;
-	else if (isize =3D=3D zi->i_max_size)
-		op =3D REQ_OP_ZONE_FINISH;
-	else
-		return -EPERM;
-
-	inode_dio_wait(inode);
-
-	/* Serialize against page faults */
-	filemap_invalidate_lock(inode->i_mapping);
-
-	/* Serialize against zonefs_iomap_begin() */
-	mutex_lock(&zi->i_truncate_mutex);
-
-	old_isize =3D i_size_read(inode);
-	if (isize =3D=3D old_isize)
-		goto unlock;
-
-	ret =3D zonefs_zone_mgmt(inode, op);
-	if (ret)
-		goto unlock;
-
-	/*
-	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,
-	 * take care of open zones.
-	 */
-	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
-		/*
-		 * Truncating a zone to EMPTY or FULL is the equivalent of
-		 * closing the zone. For a truncation to 0, we need to
-		 * re-open the zone to ensure new writes can be processed.
-		 * For a truncation to the maximum file size, the zone is
-		 * closed and writes cannot be accepted anymore, so clear
-		 * the open flag.
-		 */
-		if (!isize)
-			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
-		else
-			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
-	}
-
-	zonefs_update_stats(inode, isize);
-	truncate_setsize(inode, isize);
-	zi->i_wpoffset =3D isize;
-	zonefs_account_active(inode);
-
-unlock:
-	mutex_unlock(&zi->i_truncate_mutex);
-	filemap_invalidate_unlock(inode->i_mapping);
-
-	return ret;
-}
-
-static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
-				struct dentry *dentry, struct iattr *iattr)
-{
-	struct inode *inode =3D d_inode(dentry);
-	int ret;
-
-	if (unlikely(IS_IMMUTABLE(inode)))
-		return -EPERM;
-
-	ret =3D setattr_prepare(&init_user_ns, dentry, iattr);
-	if (ret)
-		return ret;
-
-	/*
-	 * Since files and directories cannot be created nor deleted, do not
-	 * allow setting any write attributes on the sub-directories grouping
-	 * files by zone type.
-	 */
-	if ((iattr->ia_valid & ATTR_MODE) && S_ISDIR(inode->i_mode) &&
-	    (iattr->ia_mode & 0222))
-		return -EPERM;
-
-	if (((iattr->ia_valid & ATTR_UID) &&
-	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
-	    ((iattr->ia_valid & ATTR_GID) &&
-	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
-		ret =3D dquot_transfer(mnt_userns, inode, iattr);
-		if (ret)
-			return ret;
-	}
-
-	if (iattr->ia_valid & ATTR_SIZE) {
-		ret =3D zonefs_file_truncate(inode, iattr->ia_size);
-		if (ret)
-			return ret;
-	}
-
-	setattr_copy(&init_user_ns, inode, iattr);
-
-	return 0;
-}
-
-static const struct inode_operations zonefs_file_inode_operations =3D {
-	.setattr	=3D zonefs_inode_setattr,
-};
-
-static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end=
,
-			     int datasync)
-{
-	struct inode *inode =3D file_inode(file);
-	int ret =3D 0;
-
-	if (unlikely(IS_IMMUTABLE(inode)))
-		return -EPERM;
-
-	/*
-	 * Since only direct writes are allowed in sequential files, page cache
-	 * flush is needed only for conventional zone files.
-	 */
-	if (ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
-		ret =3D file_write_and_wait_range(file, start, end);
-	if (!ret)
-		ret =3D blkdev_issue_flush(inode->i_sb->s_bdev);
-
-	if (ret)
-		zonefs_io_error(inode, true);
-
-	return ret;
-}
-
-static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
-{
-	struct inode *inode =3D file_inode(vmf->vma->vm_file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	vm_fault_t ret;
-
-	if (unlikely(IS_IMMUTABLE(inode)))
-		return VM_FAULT_SIGBUS;
-
-	/*
-	 * Sanity check: only conventional zone files can have shared
-	 * writeable mappings.
-	 */
-	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
-		return VM_FAULT_NOPAGE;
-
-	sb_start_pagefault(inode->i_sb);
-	file_update_time(vmf->vma->vm_file);
-
-	/* Serialize against truncates */
-	filemap_invalidate_lock_shared(inode->i_mapping);
-	ret =3D iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
-	filemap_invalidate_unlock_shared(inode->i_mapping);
-
-	sb_end_pagefault(inode->i_sb);
-	return ret;
-}
-
-static const struct vm_operations_struct zonefs_file_vm_ops =3D {
-	.fault		=3D filemap_fault,
-	.map_pages	=3D filemap_map_pages,
-	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,
-};
-
-static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vm=
a)
-{
-	/*
-	 * Conventional zones accept random writes, so their files can support
-	 * shared writable mappings. For sequential zone files, only read
-	 * mappings are possible since there are no guarantees for write
-	 * ordering between msync() and page cache writeback.
-	 */
-	if (ZONEFS_I(file_inode(file))->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
-	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-		return -EINVAL;
-
-	file_accessed(file);
-	vma->vm_ops =3D &zonefs_file_vm_ops;
-
-	return 0;
-}
-
-static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int w=
hence)
-{
-	loff_t isize =3D i_size_read(file_inode(file));
-
-	/*
-	 * Seeks are limited to below the zone size for conventional zones
-	 * and below the zone write pointer for sequential zones. In both
-	 * cases, this limit is the inode size.
-	 */
-	return generic_file_llseek_size(file, offset, whence, isize, isize);
-}
-
-static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size=
,
-					int error, unsigned int flags)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	if (error) {
-		zonefs_io_error(inode, true);
-		return error;
-	}
-
-	if (size && zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
-		/*
-		 * Note that we may be seeing completions out of order,
-		 * but that is not a problem since a write completed
-		 * successfully necessarily means that all preceding writes
-		 * were also successful. So we can safely increase the inode
-		 * size to the write end location.
-		 */
-		mutex_lock(&zi->i_truncate_mutex);
-		if (i_size_read(inode) < iocb->ki_pos + size) {
-			zonefs_update_stats(inode, iocb->ki_pos + size);
-			zonefs_i_size_write(inode, iocb->ki_pos + size);
-		}
-		mutex_unlock(&zi->i_truncate_mutex);
-	}
-
-	return 0;
-}
-
-static const struct iomap_dio_ops zonefs_write_dio_ops =3D {
-	.end_io			=3D zonefs_file_write_dio_end_io,
-};
-
-static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct block_device *bdev =3D inode->i_sb->s_bdev;
-	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
-	struct bio *bio;
-	ssize_t size;
-	int nr_pages;
-	ssize_t ret;
-
-	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
-	iov_iter_truncate(from, max);
-
-	nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
-	if (!nr_pages)
-		return 0;
-
-	bio =3D bio_alloc(bdev, nr_pages,
-			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
-	bio->bi_iter.bi_sector =3D zi->i_zsector;
-	bio->bi_ioprio =3D iocb->ki_ioprio;
-	if (iocb_is_dsync(iocb))
-		bio->bi_opf |=3D REQ_FUA;
-
-	ret =3D bio_iov_iter_get_pages(bio, from);
-	if (unlikely(ret))
-		goto out_release;
-
-	size =3D bio->bi_iter.bi_size;
-	task_io_account_write(size);
-
-	if (iocb->ki_flags & IOCB_HIPRI)
-		bio_set_polled(bio, iocb);
-
-	ret =3D submit_bio_wait(bio);
-
-	/*
-	 * If the file zone was written underneath the file system, the zone
-	 * write pointer may not be where we expect it to be, but the zone
-	 * append write can still succeed. So check manually that we wrote wher=
e
-	 * we intended to, that is, at zi->i_wpoffset.
-	 */
-	if (!ret) {
-		sector_t wpsector =3D
-			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
-
-		if (bio->bi_iter.bi_sector !=3D wpsector) {
-			zonefs_warn(inode->i_sb,
-				"Corrupted write pointer %llu for zone at %llu\n",
-				wpsector, zi->i_zsector);
-			ret =3D -EIO;
-		}
-	}
-
-	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
-	trace_zonefs_file_dio_append(inode, size, ret);
-
-out_release:
-	bio_release_pages(bio, false);
-	bio_put(bio);
-
-	if (ret >=3D 0) {
-		iocb->ki_pos +=3D size;
-		return size;
-	}
-
-	return ret;
-}
-
-/*
- * Do not exceed the LFS limits nor the file zone size. If pos is under =
the
- * limit it becomes a short access. If it exceeds the limit, return -EFB=
IG.
- */
-static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
-					loff_t count)
-{
-	struct inode *inode =3D file_inode(file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	loff_t limit =3D rlimit(RLIMIT_FSIZE);
-	loff_t max_size =3D zi->i_max_size;
-
-	if (limit !=3D RLIM_INFINITY) {
-		if (pos >=3D limit) {
-			send_sig(SIGXFSZ, current, 0);
-			return -EFBIG;
-		}
-		count =3D min(count, limit - pos);
-	}
-
-	if (!(file->f_flags & O_LARGEFILE))
-		max_size =3D min_t(loff_t, MAX_NON_LFS, max_size);
-
-	if (unlikely(pos >=3D max_size))
-		return -EFBIG;
-
-	return min(count, max_size - pos);
-}
-
-static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *=
from)
-{
-	struct file *file =3D iocb->ki_filp;
-	struct inode *inode =3D file_inode(file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	loff_t count;
-
-	if (IS_SWAPFILE(inode))
-		return -ETXTBSY;
-
-	if (!iov_iter_count(from))
-		return 0;
-
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
-		return -EINVAL;
-
-	if (iocb->ki_flags & IOCB_APPEND) {
-		if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
-			return -EINVAL;
-		mutex_lock(&zi->i_truncate_mutex);
-		iocb->ki_pos =3D zi->i_wpoffset;
-		mutex_unlock(&zi->i_truncate_mutex);
-	}
-
-	count =3D zonefs_write_check_limits(file, iocb->ki_pos,
-					  iov_iter_count(from));
-	if (count < 0)
-		return count;
-
-	iov_iter_truncate(from, count);
-	return iov_iter_count(from);
-}
-
-/*
- * Handle direct writes. For sequential zone files, this is the only pos=
sible
- * write path. For these files, check that the user is issuing writes
- * sequentially from the end of the file. This code assumes that the blo=
ck layer
- * delivers write requests to the device in sequential order. This is al=
ways the
- * case if a block IO scheduler implementing the ELEVATOR_F_ZBD_SEQ_WRIT=
E
- * elevator feature is being used (e.g. mq-deadline). The block layer al=
ways
- * automatically select such an elevator for zoned block devices during =
the
- * device initialization.
- */
-static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter=
 *from)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct super_block *sb =3D inode->i_sb;
-	bool sync =3D is_sync_kiocb(iocb);
-	bool append =3D false;
-	ssize_t ret, count;
-
-	/*
-	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
-	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
-	 * on the inode lock but the second goes through but is now unaligned).
-	 */
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !sync &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
-		return -EOPNOTSUPP;
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock(inode);
-	}
-
-	count =3D zonefs_write_checks(iocb, from);
-	if (count <=3D 0) {
-		ret =3D count;
-		goto inode_unlock;
-	}
-
-	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
-		ret =3D -EINVAL;
-		goto inode_unlock;
-	}
-
-	/* Enforce sequential writes (append only) in sequential zones */
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ) {
-		mutex_lock(&zi->i_truncate_mutex);
-		if (iocb->ki_pos !=3D zi->i_wpoffset) {
-			mutex_unlock(&zi->i_truncate_mutex);
-			ret =3D -EINVAL;
-			goto inode_unlock;
-		}
-		mutex_unlock(&zi->i_truncate_mutex);
-		append =3D sync;
-	}
-
-	if (append)
-		ret =3D zonefs_file_dio_append(iocb, from);
-	else
-		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
-				   &zonefs_write_dio_ops, 0, NULL, 0);
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
-	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
-		if (ret > 0)
-			count =3D ret;
-
-		/*
-		 * Update the zone write pointer offset assuming the write
-		 * operation succeeded. If it did not, the error recovery path
-		 * will correct it. Also do active seq file accounting.
-		 */
-		mutex_lock(&zi->i_truncate_mutex);
-		zi->i_wpoffset +=3D count;
-		zonefs_account_active(inode);
-		mutex_unlock(&zi->i_truncate_mutex);
-	}
-
-inode_unlock:
-	inode_unlock(inode);
-
-	return ret;
-}
-
-static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
-					  struct iov_iter *from)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	ssize_t ret;
-
-	/*
-	 * Direct IO writes are mandatory for sequential zone files so that the
-	 * write IO issuing order is preserved.
-	 */
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV)
-		return -EIO;
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock(inode);
-	}
-
-	ret =3D zonefs_write_checks(iocb, from);
-	if (ret <=3D 0)
-		goto inode_unlock;
-
-	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
-	if (ret > 0)
-		iocb->ki_pos +=3D ret;
-	else if (ret =3D=3D -EIO)
-		zonefs_io_error(inode, true);
-
-inode_unlock:
-	inode_unlock(inode);
-	if (ret > 0)
-		ret =3D generic_write_sync(iocb, ret);
-
-	return ret;
-}
-
-static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_ite=
r *from)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-
-	if (unlikely(IS_IMMUTABLE(inode)))
-		return -EPERM;
-
-	if (sb_rdonly(inode->i_sb))
-		return -EROFS;
-
-	/* Write operations beyond the zone size are not allowed */
-	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)
-		return -EFBIG;
-
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		ssize_t ret =3D zonefs_file_dio_write(iocb, from);
-		if (ret !=3D -ENOTBLK)
-			return ret;
-	}
-
-	return zonefs_file_buffered_write(iocb, from);
-}
-
-static int zonefs_file_read_dio_end_io(struct kiocb *iocb, ssize_t size,
-				       int error, unsigned int flags)
-{
-	if (error) {
-		zonefs_io_error(file_inode(iocb->ki_filp), false);
-		return error;
-	}
-
-	return 0;
-}
-
-static const struct iomap_dio_ops zonefs_read_dio_ops =3D {
-	.end_io			=3D zonefs_file_read_dio_end_io,
-};
-
-static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter=
 *to)
-{
-	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct super_block *sb =3D inode->i_sb;
-	loff_t isize;
-	ssize_t ret;
-
-	/* Offline zones cannot be read */
-	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
-		return -EPERM;
-
-	if (iocb->ki_pos >=3D zi->i_max_size)
-		return 0;
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock_shared(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock_shared(inode);
-	}
-
-	/* Limit read operations to written data */
-	mutex_lock(&zi->i_truncate_mutex);
-	isize =3D i_size_read(inode);
-	if (iocb->ki_pos >=3D isize) {
-		mutex_unlock(&zi->i_truncate_mutex);
-		ret =3D 0;
-		goto inode_unlock;
-	}
-	iov_iter_truncate(to, isize - iocb->ki_pos);
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		size_t count =3D iov_iter_count(to);
-
-		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
-			ret =3D -EINVAL;
-			goto inode_unlock;
-		}
-		file_accessed(iocb->ki_filp);
-		ret =3D iomap_dio_rw(iocb, to, &zonefs_read_iomap_ops,
-				   &zonefs_read_dio_ops, 0, NULL, 0);
-	} else {
-		ret =3D generic_file_read_iter(iocb, to);
-		if (ret =3D=3D -EIO)
-			zonefs_io_error(inode, false);
-	}
-
-inode_unlock:
-	inode_unlock_shared(inode);
-
-	return ret;
-}
-
-/*
- * Write open accounting is done only for sequential files.
- */
-static inline bool zonefs_seq_file_need_wro(struct inode *inode,
-					    struct file *file)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
-		return false;
-
-	if (!(file->f_mode & FMODE_WRITE))
-		return false;
-
-	return true;
-}
-
-static int zonefs_seq_file_write_open(struct inode *inode)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	int ret =3D 0;
-
-	mutex_lock(&zi->i_truncate_mutex);
-
-	if (!zi->i_wr_refcnt) {
-		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
-		unsigned int wro =3D atomic_inc_return(&sbi->s_wro_seq_files);
-
-		if (sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
-
-			if (sbi->s_max_wro_seq_files
-			    && wro > sbi->s_max_wro_seq_files) {
-				atomic_dec(&sbi->s_wro_seq_files);
-				ret =3D -EBUSY;
-				goto unlock;
-			}
-
-			if (i_size_read(inode) < zi->i_max_size) {
-				ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
-				if (ret) {
-					atomic_dec(&sbi->s_wro_seq_files);
-					goto unlock;
-				}
-				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
-				zonefs_account_active(inode);
-			}
-		}
-	}
-
-	zi->i_wr_refcnt++;
-
-unlock:
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	return ret;
-}
-
-static int zonefs_file_open(struct inode *inode, struct file *file)
-{
-	int ret;
-
-	ret =3D generic_file_open(inode, file);
-	if (ret)
-		return ret;
-
-	if (zonefs_seq_file_need_wro(inode, file))
-		return zonefs_seq_file_write_open(inode);
-
-	return 0;
-}
-
-static void zonefs_seq_file_write_close(struct inode *inode)
-{
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	struct super_block *sb =3D inode->i_sb;
-	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
-	int ret =3D 0;
-
-	mutex_lock(&zi->i_truncate_mutex);
-
-	zi->i_wr_refcnt--;
-	if (zi->i_wr_refcnt)
-		goto unlock;
-
-	/*
-	 * The file zone may not be open anymore (e.g. the file was truncated t=
o
-	 * its maximum size or it was fully written). For this case, we only
-	 * need to decrement the write open count.
-	 */
-	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
-		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
-		if (ret) {
-			__zonefs_io_error(inode, false);
-			/*
-			 * Leaving zones explicitly open may lead to a state
-			 * where most zones cannot be written (zone resources
-			 * exhausted). So take preventive action by remounting
-			 * read-only.
-			 */
-			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
-			    !(sb->s_flags & SB_RDONLY)) {
-				zonefs_warn(sb,
-					"closing zone at %llu failed %d\n",
-					zi->i_zsector, ret);
-				zonefs_warn(sb,
-					"remounting filesystem read-only\n");
-				sb->s_flags |=3D SB_RDONLY;
-			}
-			goto unlock;
-		}
-
-		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
-		zonefs_account_active(inode);
-	}
-
-	atomic_dec(&sbi->s_wro_seq_files);
-
-unlock:
-	mutex_unlock(&zi->i_truncate_mutex);
-}
-
-static int zonefs_file_release(struct inode *inode, struct file *file)
-{
-	/*
-	 * If we explicitly open a zone we must close it again as well, but the
-	 * zone management operation can fail (either due to an IO error or as
-	 * the zone has gone offline or read-only). Make sure we don't fail the
-	 * close(2) for user-space.
-	 */
-	if (zonefs_seq_file_need_wro(inode, file))
-		zonefs_seq_file_write_close(inode);
-
-	return 0;
-}
-
-static const struct file_operations zonefs_file_operations =3D {
-	.open		=3D zonefs_file_open,
-	.release	=3D zonefs_file_release,
-	.fsync		=3D zonefs_file_fsync,
-	.mmap		=3D zonefs_file_mmap,
-	.llseek		=3D zonefs_file_llseek,
-	.read_iter	=3D zonefs_file_read_iter,
-	.write_iter	=3D zonefs_file_write_iter,
-	.splice_read	=3D generic_file_splice_read,
-	.splice_write	=3D iter_file_splice_write,
-	.iopoll		=3D iocb_bio_iopoll,
-};
-
 static struct kmem_cache *zonefs_inode_cachep;
=20
 static struct inode *zonefs_alloc_inode(struct super_block *sb)
@@ -1408,13 +505,47 @@ static int zonefs_remount(struct super_block *sb, =
int *flags, char *data)
 	return zonefs_parse_options(sb, data);
 }
=20
-static const struct super_operations zonefs_sops =3D {
-	.alloc_inode	=3D zonefs_alloc_inode,
-	.free_inode	=3D zonefs_free_inode,
-	.statfs		=3D zonefs_statfs,
-	.remount_fs	=3D zonefs_remount,
-	.show_options	=3D zonefs_show_options,
-};
+static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
+				struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode =3D d_inode(dentry);
+	int ret;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	ret =3D setattr_prepare(&init_user_ns, dentry, iattr);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since files and directories cannot be created nor deleted, do not
+	 * allow setting any write attributes on the sub-directories grouping
+	 * files by zone type.
+	 */
+	if ((iattr->ia_valid & ATTR_MODE) && S_ISDIR(inode->i_mode) &&
+	    (iattr->ia_mode & 0222))
+		return -EPERM;
+
+	if (((iattr->ia_valid & ATTR_UID) &&
+	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
+	    ((iattr->ia_valid & ATTR_GID) &&
+	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
+		ret =3D dquot_transfer(mnt_userns, inode, iattr);
+		if (ret)
+			return ret;
+	}
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		ret =3D zonefs_file_truncate(inode, iattr->ia_size);
+		if (ret)
+			return ret;
+	}
+
+	setattr_copy(&init_user_ns, inode, iattr);
+
+	return 0;
+}
=20
 static const struct inode_operations zonefs_dir_inode_operations =3D {
 	.lookup		=3D simple_lookup,
@@ -1434,6 +565,10 @@ static void zonefs_init_dir_inode(struct inode *par=
ent, struct inode *inode,
 	inc_nlink(parent);
 }
=20
+static const struct inode_operations zonefs_file_inode_operations =3D {
+	.setattr	=3D zonefs_inode_setattr,
+};
+
 static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *=
zone,
 				  enum zonefs_ztype type)
 {
@@ -1785,6 +920,14 @@ static int zonefs_read_super(struct super_block *sb=
)
 	return ret;
 }
=20
+static const struct super_operations zonefs_sops =3D {
+	.alloc_inode	=3D zonefs_alloc_inode,
+	.free_inode	=3D zonefs_free_inode,
+	.statfs		=3D zonefs_statfs,
+	.remount_fs	=3D zonefs_remount,
+	.show_options	=3D zonefs_show_options,
+};
+
 /*
  * Check that the device is zoned. If it is, get the list of zones and c=
reate
  * sub-directories and files according to the device zone configuration =
and
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 1dbe78119ff1..839ebe9afb6c 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -209,6 +209,28 @@ static inline struct zonefs_sb_info *ZONEFS_SB(struc=
t super_block *sb)
 #define zonefs_warn(sb, format, args...)	\
 	pr_warn("zonefs (%s) WARNING: " format, sb->s_id, ## args)
=20
+/* In super.c */
+void zonefs_account_active(struct inode *inode);
+int zonefs_zone_mgmt(struct inode *inode, enum req_op op);
+void zonefs_i_size_write(struct inode *inode, loff_t isize);
+void zonefs_update_stats(struct inode *inode, loff_t new_isize);
+void __zonefs_io_error(struct inode *inode, bool write);
+
+static inline void zonefs_io_error(struct inode *inode, bool write)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	mutex_lock(&zi->i_truncate_mutex);
+	__zonefs_io_error(inode, write);
+	mutex_unlock(&zi->i_truncate_mutex);
+}
+
+/* In file.c */
+extern const struct address_space_operations zonefs_file_aops;
+extern const struct file_operations zonefs_file_operations;
+int zonefs_file_truncate(struct inode *inode, loff_t isize);
+
+/* In sysfs.c */
 int zonefs_sysfs_register(struct super_block *sb);
 void zonefs_sysfs_unregister(struct super_block *sb);
 int zonefs_sysfs_init(void);
--=20
2.39.0

