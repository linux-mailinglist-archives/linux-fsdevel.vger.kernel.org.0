Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811C1664C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfGLDAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 23:00:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55534 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfGLDAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562900421; x=1594436421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B1w6UltCHLH+fhv2UsRfqVGCShMLffqkWZTuwHv6cvQ=;
  b=gQDNSyxnCHCmA88QwmJ7IveXJaMWZ9/BfoVRapyTxcTOi3hu00uPwnRV
   WhE+hsoaEVq/OHuPPOPNGJfkDW88Bamy8BewZ2D6606HOYPu2rh0haRfC
   y1uGcGKluA14d+3o4FGyF3unoK49eZMOpjh35nXPDSRLhpoonarusvY1K
   hrF3i/kKRJ2NFMt3vtLvXxDwClkTqaTwHsxNQvWChkIyK7LYjkW4AxpW2
   bP/dMfnXr3rd2SZgk+A7iz4HQlTg/92hjWHXHFFSVH8NeO6/khFor2ZRW
   Rpa6ee9/s1ce3IAzSSpZ1Jzm1j1ZJlnB/rbOz3cM2LXe1vPWfGkpH+Zfd
   g==;
IronPort-SDR: eLfWaxmXqy12Slgz4pc7HXs8+aUsTLp4Z0oIRLG4gjIo5HQSORp0zjYYgRSkbjQNIX4235ozcr
 YOkaOBSlkzk2OA9kiE/MT0GgFZifhw3x2cYUOapAWJ3MTuk5Y4TSUwnJnHGecuydf8itXs+riS
 +xSk7jhnn322CXrVf8cvKnaScLNa7Sx1G2XrUQKuJcP401XOQu9cmGC+oAjr43LHhoQ51aKR//
 p/NInGM3JpfXWDzCpKQFBdq721noDqDZQGD+mhwg87A1tyKWU2V+6R3ZfWzSRaxI0uxfyeHhMS
 cP8=
X-IronPort-AV: E=Sophos;i="5.63,480,1557158400"; 
   d="scan'208";a="112846261"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 11:00:20 +0800
IronPort-SDR: REP+G9zXpQ62lHSydtDT7nhfdudqlNGE/crllAEJF0BPawpOnl/Dnh2Ss9SXww7ESuRBHSLmLg
 TuZq6+Rwq+cSmnilqylofur61F8T3/CwgjD6/QKIBCoRvt/dKGHIc1uJEG4lpfFcjDdyfYr7+w
 mlKo5rh/9cyH50tK5is9HiQi0CQ3nf1qflMqJSzq4lCov+IQesPp0J6iPWlA6AIrodztHSv3KN
 z9VEzwECx1Ww1fWWCjsMC+8E0rA7yV1Ue44h56NJcr6ska0YzEKDieuk7zJ8VkWcvqiKpNPEyV
 tFfwV15Qb7PNB8TETGj1W9s0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 19:58:56 -0700
IronPort-SDR: 5wGwJCK5ukhou97OTRbdjDAYt8ep5LzJyNJPHrE2Inn++/fpmCyuXA0l8VCtJuDFGGh8EBB6Pd
 to5KH44snHIGc+aaBn/p0y3du3YqsHD4F3duSSz3ka/wdEEIJrBRfr40ZGw6VrKuSTmhBnHEai
 guQEE2AulGfBIYEnmdTFlZzsH9fUvT/2aYg+lxHVdE4NfEyxvGXeemWKVNKI2OYjfQ7VH7OsLk
 ru5ctG6YZwONyxbItAAI0U9EyYhdAP4koODYEMLeVENgvJ4CK91edlvAYUPbx6YznZzRaIMpcc
 FyU=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2019 20:00:18 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC] fs: New zonefs file system
Date:   Fri, 12 Jul 2019 12:00:17 +0900
Message-Id: <20190712030017.14321-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zonefs is a very simple file system exposing each zone of a zoned
block device as a file. This is intended to simplify implementation of
application zoned block device raw access support by allowing switching
to the well known POSIX file API rather than relying on direct block
device file ioctls and read/write. Zonefs, for instance, greatly
simplifies the implementation of LSM (log-structured merge) tree
structures (such as used in RocksDB and LevelDB) on zoned block devices
by allowing SSTables to be stored in a zone file similarly to a regular
file system architecture, hence reducing the amount of change needed in
the application.

Due to its simplicity, zonefs is in fact closer to a raw block device
access interface than to a full feature POSIX file system. This RFC
implementation uses Christoph's work on generic iomap writepage
implementation and is based on Christoph's gfs2 tree available at
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gfs2-iomap

Zonefs on-disk metadata is reduced to a super block to store a magic
number, a uuid and optional features flags and values. On mount, zonefs
uses blkdev_report_zones() to obtain the device zone configuration and
populates the mount point with a static file tree solely based on this
information. E.g. file sizes come from zone write pointer offset managed
by the device itself.

The zone files created on mount have the following characteristics.
1) Files representing zones of the same type are grouped together
   under a common directory:
  * For conventional zones, the directory "cnv" is used.
  * For sequential write zones, the directory "seq" is used.
  These two directories are the only directories that exist in zonefs.
  Users cannot create other directories and cannot rename nor delete
  the "cnv" and "seq" directories.
2) The name of zone files is by default the number of the file within
   the zone type directory, in order of increasing zone start sector.
3) The size of conventional zone files is fixed to the device zone size.
   Conventional zone files cannot be truncated.
4) The size of sequential zone files represent the file zone write
   pointer position relative to the zone start sector. Truncating these
   files is allowed only down to 0, in wich case, the zone is reset to
   rewind the file zone write pointer position to the start of the zone.
5) All read and write operations to files are not allowed beyond the
   file zone size. Any access exceeding the zone size is failed with
   the -EFBIG error.
6) Creating, deleting, renaming or modifying any attribute of files
   and directories is not allowed. The only exception being the file
   size of sequential zone files which can be modified by write
   operations or truncation to 0.

Several optional features of zonefs can be enabled at format time.
* Conventional zone aggregation: contiguous conventional zones can be
  agregated into a single larger file instead of multiple per-zone
  files.
* File naming: the default file number file name can be switched to
  using the base-10 value of the file zone start sector.
* File ownership: The owner UID and GID of zone files is by default 0
  (root) but can be changed to any valid UID/GID.
* File access permissions: the default 640 access permissions can be
  changed.

The mkzonefs tool is used to format zonefs. This tool will be available
on Github at:

https://github.com/westerndigitalcorporation/zonefs-tools

Example: the following formats a host-managed SMR HDD with the
conventional zone aggregation feature enabled.

mkzonefs -o aggr_cnv /dev/sdX
mount -t zonefs /dev/sdX /mnt
ls -l /mnt/
total 0
dr-xr-xr-x 2 root root 0 Apr 11 13:00 cnv
dr-xr-xr-x 2 root root 0 Apr 11 13:00 seq

ls -l /mnt/cnv
total 137363456
-rw-rw---- 1 root root 140660178944 Apr 11 13:00 0

ls -Fal -v /mnt/seq
total 14511243264
dr-xr-xr-x 2 root root 15942528 Jul 10 11:53 ./
drwxr-xr-x 4 root root     1152 Jul 10 11:53 ../
-rw-r----- 1 root root        0 Jul 10 11:53 0
-rw-r----- 1 root root 33554432 Jul 10 13:43 1
-rw-r----- 1 root root        0 Jul 10 11:53 2
-rw-r----- 1 root root        0 Jul 10 11:53 3
...

The aggregated conventional zone file can be used as a regular file.
Operations such as the following work.

mkfs.ext4 /mnt/cnv/0
mount -o loop /mnt/cnv/0 /data

Contains contributions from Johannes Thumshirn <jthumshirn@suse.de>
and Christoph Hellwig <hch@lst.de>.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/Kconfig                 |    2 +
 fs/Makefile                |    1 +
 fs/zonefs/Kconfig          |    9 +
 fs/zonefs/Makefile         |    4 +
 fs/zonefs/super.c          | 1004 ++++++++++++++++++++++++++++++++++++
 fs/zonefs/zonefs.h         |  190 +++++++
 include/uapi/linux/magic.h |    1 +
 7 files changed, 1211 insertions(+)
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..e48cc0e0efbb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -41,6 +41,7 @@ source "fs/ocfs2/Kconfig"
 source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
+source "fs/zonefs/Kconfig"
 
 config FS_DAX
 	bool "Direct Access (DAX) support"
@@ -262,6 +263,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/ufs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..02fcd528991b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig
new file mode 100644
index 000000000000..6490547e9763
--- /dev/null
+++ b/fs/zonefs/Kconfig
@@ -0,0 +1,9 @@
+config ZONEFS_FS
+	tristate "zonefs filesystem support"
+	depends on BLOCK
+	depends on BLK_DEV_ZONED
+	help
+	  zonefs is a simple File System which exposes zones of a zoned block
+	  device as files.
+
+	  If unsure, say N.
diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
new file mode 100644
index 000000000000..75a380aa1ae1
--- /dev/null
+++ b/fs/zonefs/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ZONEFS_FS) += zonefs.o
+
+zonefs-y	:= super.o
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
new file mode 100644
index 000000000000..0bf56f378a77
--- /dev/null
+++ b/fs/zonefs/super.c
@@ -0,0 +1,1004 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple zone file system for zoned block devices.
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ */
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
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
+
+#include "zonefs.h"
+
+static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			      unsigned int flags, struct iomap *iomap)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	loff_t max_isize = zonefs_file_max_size(inode);
+	loff_t isize = i_size_read(inode);
+
+	/*
+	 * For sequential zones, enforce direct IO writes. This is already
+	 * checked when writes are issued, so warn about this here if we
+	 * get buffered write to a sequential file inode.
+	 */
+	if (WARN_ON_ONCE(zonefs_file_is_seq(inode) && (flags & IOMAP_WRITE) &&
+			 (!(flags & IOMAP_DIRECT))))
+		return -EIO;
+
+	/* An IO cannot exceed the zone size */
+	if (offset >= max_isize)
+		return -EFBIG;
+
+	/* All blocks are always mapped */
+	if (offset >= i_size_read(inode)) {
+		length = min(length, max_isize - offset);
+		iomap->type = IOMAP_UNWRITTEN;
+	} else {
+		length = min(length, isize - offset);
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = offset & (~sbi->s_blocksize_mask);
+	iomap->length = (offset + length + sbi->s_blocksize_mask) &
+			(~sbi->s_blocksize_mask);
+	iomap->addr = zonefs_file_addr(inode) + iomap->offset;
+	iomap->bdev = inode->i_sb->s_bdev;
+
+	return 0;
+}
+
+static const struct iomap_ops zonefs_iomap_ops = {
+	.iomap_begin	= zonefs_iomap_begin,
+};
+
+static int zonefs_readpage(struct file *unused, struct page *page)
+{
+	return iomap_readpage(page, &zonefs_iomap_ops);
+}
+
+static int zonefs_readpages(struct file *unused, struct address_space *mapping,
+			    struct list_head *pages, unsigned int nr_pages)
+{
+	return iomap_readpages(mapping, pages, nr_pages, &zonefs_iomap_ops);
+}
+
+static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
+			     struct inode *inode, loff_t offset)
+{
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
+	return zonefs_iomap_begin(inode, offset, INT_MAX, 0, &wpc->iomap);
+}
+
+static const struct iomap_writeback_ops zonefs_writeback_ops = {
+	.map_blocks		= zonefs_map_blocks,
+};
+
+static int zonefs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = { };
+
+	return iomap_writepage(page, wbc, &wpc, &zonefs_writeback_ops);
+}
+
+static int zonefs_writepages(struct address_space *mapping,
+			     struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = { };
+
+	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+}
+
+static const struct address_space_operations zonefs_file_aops = {
+	.readpage		= zonefs_readpage,
+	.readpages		= zonefs_readpages,
+	.writepage		= zonefs_writepage,
+	.writepages		= zonefs_writepages,
+	.set_page_dirty		= iomap_set_page_dirty,
+	.releasepage		= iomap_releasepage,
+	.invalidatepage		= iomap_invalidatepage,
+	.migratepage		= iomap_migrate_page,
+	.is_partially_uptodate  = iomap_is_partially_uptodate,
+	.error_remove_page	= generic_error_remove_page,
+	.direct_IO		= noop_direct_IO,
+};
+
+static int zonefs_truncate_seqfile(struct inode *inode)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	int ret;
+
+	/* Serialize against page faults */
+	down_write(&zi->i_mmap_sem);
+
+	ret = blkdev_reset_zones(inode->i_sb->s_bdev,
+				 zonefs_file_addr(inode) >> SECTOR_SHIFT,
+				 zonefs_file_max_size(inode) >> SECTOR_SHIFT,
+				 GFP_KERNEL);
+	if (ret) {
+		zonefs_err(inode->i_sb,
+			   "zonefs: Reset zone at %llu failed %d",
+			   zonefs_file_addr(inode) >> SECTOR_SHIFT,
+			   ret);
+	} else {
+		truncate_setsize(inode, 0);
+		zi->i_wpoffset = 0;
+	}
+
+	up_write(&zi->i_mmap_sem);
+
+	return ret;
+}
+
+static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	ret = setattr_prepare(dentry, iattr);
+	if (ret)
+		return ret;
+
+	if ((iattr->ia_valid & ATTR_UID &&
+	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
+	    (iattr->ia_valid & ATTR_GID &&
+	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
+		ret = dquot_transfer(inode, iattr);
+		if (ret)
+			return ret;
+	}
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		/* The size of conventional zone files cannot be changed */
+		if (zonefs_file_is_conv(inode))
+			return -EPERM;
+
+		/*
+		 * For sequential zone files, we can only allow truncating to
+		 * 0 size which is equivalent to a zone reset.
+		 */
+		if (iattr->ia_size != 0)
+			return -EPERM;
+
+		ret = zonefs_truncate_seqfile(inode);
+		if (ret)
+			return ret;
+	}
+
+	setattr_copy(inode, iattr);
+
+	return 0;
+}
+
+static const struct inode_operations zonefs_file_inode_operations = {
+	.setattr	= zonefs_inode_setattr,
+};
+
+/*
+ * Open a file.
+ */
+static int zonefs_file_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * Note: here we can do an explicit open of the file zone,
+	 * on the first open of the inode. The explicit close can be
+	 * done on the last release (close) call for the inode.
+	 */
+
+	return generic_file_open(inode, file);
+}
+
+static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
+			     int datasync)
+{
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	/*
+	 * Since only direct writes are allowed in sequential files, we only
+	 * need a device flush for these files.
+	 */
+	if (zonefs_file_is_seq(inode))
+		goto flush;
+
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret == 0)
+		ret = file_check_and_advance_wb_err(file);
+	if (ret)
+		return ret;
+
+flush:
+	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+}
+
+static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->vma->vm_file));
+	vm_fault_t ret;
+
+	down_read(&zi->i_mmap_sem);
+	ret = filemap_fault(vmf);
+	up_read(&zi->i_mmap_sem);
+
+	return ret;
+}
+
+static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	vm_fault_t ret;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vmf->vma->vm_file);
+
+	/* Serialize against truncates */
+	down_read(&zi->i_mmap_sem);
+	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
+	up_read(&zi->i_mmap_sem);
+
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct zonefs_file_vm_ops = {
+	.fault		= zonefs_filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= zonefs_filemap_page_mkwrite,
+};
+
+static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/*
+	 * Conventional zone files can be mmap-ed READ/WRITE.
+	 * For sequential zone files, only readonly mappings are possible.
+	 */
+	if (zonefs_file_is_seq(file_inode(file)) &&
+	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
+
+	file_accessed(file);
+	vma->vm_ops = &zonefs_file_vm_ops;
+
+	return 0;
+}
+
+static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	loff_t isize = i_size_read(file_inode(file));
+
+	/*
+	 * Seeks are limited to below the zone size for conventional zones
+	 * and below the zone write pointer for sequential zones. In both
+	 * cases, this limit is the inode size.
+	 */
+	return generic_file_llseek_size(file, offset, whence, isize, isize);
+}
+
+static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	loff_t max_pos = zonefs_file_max_size(inode);
+	size_t count;
+	ssize_t ret = 0;
+
+	/*
+	 * Check that the read operation does not go beyond the maximum
+	 * file size.
+	 */
+	if (iocb->ki_pos >= zonefs_file_max_size(inode))
+		return -EFBIG;
+
+	/*
+	 * For sequential zones, limit reads to written data.
+	 */
+	if (zonefs_file_is_seq(inode))
+		max_pos = i_size_read(inode);
+	if (iocb->ki_pos >= max_pos)
+		return 0;
+
+	iov_iter_truncate(to, max_pos - iocb->ki_pos);
+	count = iov_iter_count(to);
+	if (!count)
+		return 0;
+
+	/* Direct IO reads must be aligned to device physical sector size */
+	if ((iocb->ki_flags & IOCB_DIRECT) &&
+	    ((iocb->ki_pos | count) & sbi->s_blocksize_mask))
+		return -EINVAL;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL);
+	} else {
+		ret = generic_file_read_iter(iocb, to);
+	}
+
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+/*
+ * We got a write error: get the sequenial zone information from the device to
+ * figure out where the zone write pointer is and verify the inode size against
+ * it.
+ */
+static int zonefs_write_failed(struct inode *inode, int error)
+{
+	struct super_block *sb = inode->i_sb;
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	sector_t sector = zi->i_addr >> SECTOR_SHIFT;
+	unsigned int noio_flag;
+	struct blk_zone zone;
+	int n = 1, ret;
+
+	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);
+
+	noio_flag = memalloc_noio_save();
+	ret = blkdev_report_zones(sb->s_bdev, sector, &zone, &n);
+	memalloc_noio_restore(noio_flag);
+
+	if (!n)
+		ret = -EIO;
+	if (ret) {
+		zonefs_err(sb, "Get zone %llu report failed %d\n",
+			   sector, ret);
+		return ret;
+	}
+
+	zi->i_wpoffset = (zone.wp - zone.start) << SECTOR_SHIFT;
+	if (i_size_read(inode) != zi->i_wpoffset) {
+		i_size_write(inode, zi->i_wpoffset);
+		truncate_pagecache(inode, zi->i_wpoffset);
+	}
+
+	return error;
+}
+
+static int zonefs_update_size(struct inode *inode, loff_t new_pos)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+	zi->i_wpoffset = new_pos;
+	if (new_pos > i_size_read(inode))
+		i_size_write(inode, new_pos);
+	return 0;
+}
+
+static int zonefs_dio_seqwrite_end_io(struct kiocb *iocb, ssize_t size,
+				      unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	int ret;
+
+	inode_lock(inode);
+	if (size < 0)
+		ret = zonefs_write_failed(inode, size);
+	else
+		ret = zonefs_update_size(inode, iocb->ki_pos + size);
+	inode_unlock(inode);
+	return ret;
+}
+
+static ssize_t zonefs_file_dio_aio_write(struct kiocb *iocb,
+					 struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	size_t count;
+
+	/*
+	 * The size of conventional zone files is fixed to the zone size.
+	 * So only direct writes to sequential zones need adjusting the
+	 * inode size on IO completion.
+	 */
+	if (zonefs_file_is_conv(inode))
+		return iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);
+
+	/* Enforce append only sequential writes */
+	count = iov_iter_count(from);
+	if (iocb->ki_pos != zi->i_wpoffset) {
+		zonefs_err(inode->i_sb,
+			   "Unaligned write at %llu + %zu (wp %llu)\n",
+			   iocb->ki_pos, count, zi->i_wpoffset);
+		return -EINVAL;
+	}
+
+	if (is_sync_kiocb(iocb)) {
+		/*
+		 * Don't use the end_io callback for synchronous iocbs,
+		 * as we'd deadlock on i_rwsem.  Instead perform the same
+		 * actions manually here.
+		 */
+		count = iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);
+		if (count < 0)
+			return zonefs_write_failed(inode, count);
+		zonefs_update_size(inode, iocb->ki_pos);
+		return count;
+	}
+
+	return iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+			    zonefs_dio_seqwrite_end_io);
+}
+
+static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	size_t count;
+	ssize_t ret;
+
+	/*
+	 * Check that the read operation does not go beyond the file
+	 * zone boundary.
+	 */
+	if (iocb->ki_pos >= zonefs_file_max_size(inode))
+		return -EFBIG;
+	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);
+	count = iov_iter_count(from);
+
+	if (!count)
+		return 0;
+
+	/*
+	 * Direct IO writes are mandatory for sequential zones so that write IO
+	 * order is preserved. The direct writes also must be aligned to
+	 * device physical sector size.
+	 */
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask)
+			return -EINVAL;
+	} else {
+		if (zonefs_file_is_seq(inode))
+			return -EOPNOTSUPP;
+	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = zonefs_file_dio_aio_write(iocb, from);
+	else
+		ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0 && (!(iocb->ki_flags & IOCB_DIRECT))) {
+		iocb->ki_pos += ret;
+		ret = generic_write_sync(iocb, ret);
+	}
+
+	return ret;
+}
+
+static const struct file_operations zonefs_file_operations = {
+	.open		= zonefs_file_open,
+	.fsync		= zonefs_file_fsync,
+	.mmap		= zonefs_file_mmap,
+	.llseek		= zonefs_file_llseek,
+	.read_iter	= zonefs_file_read_iter,
+	.write_iter	= zonefs_file_write_iter,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.iopoll		= iomap_dio_iopoll,
+};
+
+
+static struct kmem_cache *zonefs_inode_cachep;
+
+static struct inode *zonefs_alloc_inode(struct super_block *sb)
+{
+	struct zonefs_inode_info *zi;
+
+	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
+	if (!zi)
+		return NULL;
+
+	init_rwsem(&zi->i_mmap_sem);
+	inode_init_once(&zi->i_vnode);
+
+	return &zi->i_vnode;
+}
+
+static void zonefs_destroy_cb(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
+}
+
+static void zonefs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, zonefs_destroy_cb);
+}
+
+static struct dentry *zonefs_create_inode(struct dentry *parent,
+					  const char *name,
+					  struct blk_zone *zone)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(parent->d_sb);
+	struct inode *dir = d_inode(parent);
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		return NULL;
+
+	inode = new_inode(parent->d_sb);
+	if (!inode)
+		goto out_dput;
+
+	inode->i_ino = get_next_ino();
+	if (zone) {
+		struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+		/* Zone file */
+		inode->i_mode = S_IFREG | sbi->s_perm;
+		if (zonefs_zone_readonly(zone))
+			inode->i_mode &= ~S_IWUGO;
+		inode->i_uid = sbi->s_uid;
+		inode->i_gid = sbi->s_gid;
+		zi->i_ztype = zonefs_zone_type(zone);
+		zi->i_addr = zone->start << SECTOR_SHIFT;
+		zi->i_max_size = zone->len << SECTOR_SHIFT;
+		inode->i_blocks = zone->len;
+		if (zonefs_file_is_conv(inode))
+			zi->i_wpoffset = zi->i_max_size;
+		else
+			zi->i_wpoffset =
+				(zone->wp - zone->start) << SECTOR_SHIFT;
+		inode->i_size = zi->i_wpoffset;
+		inode->i_fop = &zonefs_file_operations;
+		inode->i_op = &zonefs_file_inode_operations;
+		inode->i_mapping->a_ops = &zonefs_file_aops;
+		inode->i_mapping->a_ops = &zonefs_file_aops;
+	} else {
+		/* Zone group directory */
+		inode_init_owner(inode, dir, S_IFDIR | 0555);
+		inode->i_fop = &simple_dir_operations;
+		inode->i_op = &simple_dir_inode_operations;
+		set_nlink(inode, 2);
+		inc_nlink(dir);
+	}
+	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
+
+	d_add(dentry, inode);
+	d_inode(parent)->i_size += sizeof(struct dentry);
+
+	return dentry;
+
+out_dput:
+	dput(dentry);
+	return NULL;
+}
+
+/*
+ * File system stat.
+ */
+static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	sector_t nr_sectors = sb->s_bdev->bd_part->nr_sects;
+	enum zonefs_ztype t;
+
+	buf->f_type = ZONEFS_MAGIC;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+	buf->f_namelen = ZONEFS_NAME_MAX;
+
+	buf->f_blocks = nr_sectors >> (sb->s_blocksize_bits - SECTOR_SHIFT);
+	buf->f_bfree = 0;
+	buf->f_bavail = 0;
+
+	buf->f_files = sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] - 1;
+	for (t = ZONEFS_ZTYPE_ALL; t < ZONEFS_ZTYPE_MAX; t++) {
+		if (sbi->s_nr_zones[t])
+			buf->f_files++;
+	}
+	buf->f_ffree = 0;
+
+	/* buf->f_fsid = 0; uuid, see ext2 */
+	buf->f_namelen = ZONEFS_NAME_MAX;
+
+	return 0;
+}
+
+static const struct super_operations zonefs_sops = {
+	.alloc_inode	= zonefs_alloc_inode,
+	.destroy_inode	= zonefs_destroy_inode,
+	.statfs		= zonefs_statfs,
+};
+
+static char *zgroups_name[ZONEFS_ZTYPE_MAX] = {
+	NULL,
+	"cnv",
+	"seq"
+};
+
+/*
+ * Create a zone group and populate it with zone files.
+ */
+static int zonefs_create_zgroup(struct super_block *sb, struct blk_zone *zones,
+				enum zonefs_ztype type)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct blk_zone *zone, *next, *end;
+	char name[ZONEFS_NAME_MAX];
+	unsigned int nr_files = 0;
+	struct dentry *dir;
+
+	/* If the group is empty, nothing to do */
+	if (!sbi->s_nr_zones[type])
+		return 0;
+
+	dir = zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);
+	if (!dir)
+		return -ENOMEM;
+
+	/*
+	 * Note: The first zone contains the super block: skip it.
+	 */
+	end = zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];
+	for (zone = &zones[1]; zone < end; zone = next) {
+
+		next = zone + 1;
+		if (zonefs_zone_type(zone) != type)
+			continue;
+
+		/* Ignore offline zones */
+		if (zonefs_zone_offline(zone))
+			continue;
+
+		/*
+		 * For conventional zones, contiguous zones can be aggregated
+		 * together to form larger files.
+		 * Note that this overwrites the length of the first zone of
+		 * the set of contiguous zones aggregated together.
+		 * Only zones with the same condition can be agreggated so that
+		 * offline zones are excluded and readonly zones are aggregated
+		 * together into a read only file.
+		 */
+		if (type == ZONEFS_ZTYPE_CNV &&
+		    zonefs_has_feature(sbi, ZONEFS_F_AGRCNV)) {
+			for (; next < end; next++) {
+				if (zonefs_zone_type(next) != type ||
+				    next->cond != zone->cond)
+					break;
+				zone->len += next->len;
+			}
+		}
+
+		if (zonefs_has_feature(sbi, ZONEFS_F_STARTSECT_NAME))
+			/* Use zone start sector as file names */
+			snprintf(name, ZONEFS_NAME_MAX - 1, "%llu",
+				 zone->start);
+		else
+			/* Use file number as file names */
+			snprintf(name, ZONEFS_NAME_MAX - 1, "%u", nr_files);
+		nr_files++;
+
+		if (!zonefs_create_inode(dir, name, zone))
+			return -ENOMEM;
+	}
+
+	zonefs_info(sb, "Zone group %d (%s), %u zones -> %u file%s\n",
+		    type, zgroups_name[type], sbi->s_nr_zones[type],
+		    nr_files, nr_files > 1 ? "s" : "");
+
+	return 0;
+}
+
+static struct blk_zone *zonefs_get_zone_info(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	unsigned int i, n, nr_zones = 0;
+	struct blk_zone *zones, *zone;
+	sector_t sector = 0;
+	int ret;
+
+	sbi->s_blocksize_mask = sb->s_blocksize - 1;
+	sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] = blkdev_nr_zones(bdev);
+	zones = kvcalloc(sbi->s_nr_zones[ZONEFS_ZTYPE_ALL],
+			 sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones)
+		return ERR_PTR(-ENOMEM);
+
+	/* Get zones information */
+	zone = zones;
+	while (nr_zones < sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] &&
+	       sector < nr_sectors) {
+
+		n = sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] - nr_zones;
+		ret = blkdev_report_zones(bdev, sector, zone, &n);
+		if (ret) {
+			zonefs_err(sb, "Zone report failed %d\n", ret);
+			goto err;
+		}
+		if (!n) {
+			zonefs_err(sb, "No zones reported\n");
+			ret = -EIO;
+			goto err;
+		}
+
+		for (i = 0; i < n; i++) {
+			switch (zone->type) {
+			case BLK_ZONE_TYPE_CONVENTIONAL:
+				zone->wp = zone->start + zone->len;
+				if (zone > zones)
+					sbi->s_nr_zones[ZONEFS_ZTYPE_CNV]++;
+				break;
+			case BLK_ZONE_TYPE_SEQWRITE_REQ:
+			case BLK_ZONE_TYPE_SEQWRITE_PREF:
+				if (zone > zones)
+					sbi->s_nr_zones[ZONEFS_ZTYPE_SEQ]++;
+				break;
+			default:
+				zonefs_err(sb, "Unsupported zone type 0x%x\n",
+					   zone->type);
+				ret = -EIO;
+				goto err;
+			}
+			sector += zone->len;
+			zone++;
+		}
+
+		nr_zones += n;
+	}
+
+	if (sector < nr_sectors ||
+	    nr_zones < sbi->s_nr_zones[ZONEFS_ZTYPE_ALL]) {
+		zonefs_err(sb, "Incomplete zone report\n");
+		ret = -EIO;
+		goto err;
+	}
+
+	return zones;
+
+err:
+	kvfree(zones);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Read super block information from the device.
+ */
+static int zonefs_read_super(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct zonefs_super *super;
+	struct bio bio;
+	struct bio_vec bio_vec;
+	struct page *page;
+	int ret;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	bio_init(&bio, &bio_vec, 1);
+	bio.bi_iter.bi_sector = 0;
+	bio_set_dev(&bio, sb->s_bdev);
+	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
+	bio_add_page(&bio, page, PAGE_SIZE, 0);
+
+	ret = submit_bio_wait(&bio);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	super = page_address(page);
+	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
+		goto out;
+	if (le32_to_cpu(super->s_version) != ZONEFS_VERSION)
+		goto out;
+	sbi->s_features = le64_to_cpu(super->s_features);
+	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {
+		sbi->s_uid = make_kuid(current_user_ns(),
+				       le32_to_cpu(super->s_uid));
+		if (!uid_valid(sbi->s_uid))
+			goto out;
+	}
+	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {
+		sbi->s_gid = make_kgid(current_user_ns(),
+				       le32_to_cpu(super->s_gid));
+		if (!gid_valid(sbi->s_gid))
+			goto out;
+	}
+	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))
+		sbi->s_perm = le32_to_cpu(super->s_perm);
+
+	ret = 0;
+
+out:
+	__free_page(page);
+
+	return ret;
+}
+
+/*
+ * Check that the device is zoned. If it is, get the list of zones and create
+ * sub-directories and files according to the device zone configuration.
+ */
+static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct zonefs_sb_info *sbi;
+	struct blk_zone *zones;
+	struct inode *inode;
+	enum zonefs_ztype t;
+	int ret;
+
+	/* Check device type */
+	if (!bdev_is_zoned(sb->s_bdev)) {
+		zonefs_err(sb, "Not a zoned block device\n");
+		return -EINVAL;
+	}
+
+	/* Initialize super block information */
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+
+	sb->s_fs_info = sbi;
+	sb->s_magic = ZONEFS_MAGIC;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
+	sb->s_op = &zonefs_sops;
+	sb->s_time_gran	= 1;
+
+	/* Set defaults */
+	sbi->s_uid = GLOBAL_ROOT_UID;
+	sbi->s_gid = GLOBAL_ROOT_GID;
+	sbi->s_perm = S_IRUSR | S_IWUSR | S_IRGRP; /* 0640 */
+
+	ret = zonefs_read_super(sb);
+	if (ret)
+		return ret;
+
+	zones = zonefs_get_zone_info(sb);
+	if (IS_ERR(zones))
+		return PTR_ERR(zones);
+
+	pr_info("zonefs: Mounting %s, %u zones",
+		sb->s_id, sbi->s_nr_zones[ZONEFS_ZTYPE_ALL]);
+
+	/* Create root directory inode */
+	ret = -ENOMEM;
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+	inode->i_ino = get_next_ino();
+	inode->i_mode = S_IFDIR | 0755;
+	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_size = sizeof(struct dentry) * 2;
+	set_nlink(inode, 2);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		goto out;
+
+	/* Create and populate zone groups */
+	for (t = ZONEFS_ZTYPE_CNV; t < ZONEFS_ZTYPE_MAX; t++) {
+		ret = zonefs_create_zgroup(sb, zones, t);
+		if (ret)
+			break;
+	}
+
+out:
+	kvfree(zones);
+
+	return ret;
+}
+
+static struct dentry *zonefs_mount(struct file_system_type *fs_type,
+				 int flags, const char *dev_name, void *data)
+{
+	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
+}
+
+static void zonefs_kill_super(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+
+	kfree(sbi);
+	if (sb->s_root)
+		d_genocide(sb->s_root);
+	kill_block_super(sb);
+}
+
+/*
+ * File system definition and registration.
+ */
+static struct file_system_type zonefs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "zonefs",
+	.mount		= zonefs_mount,
+	.kill_sb	= zonefs_kill_super,
+	.fs_flags	= FS_REQUIRES_DEV,
+};
+
+static int __init zonefs_init_inodecache(void)
+{
+	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
+			sizeof(struct zonefs_inode_info), 0,
+			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+			NULL);
+	if (zonefs_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static void zonefs_destroy_inodecache(void)
+{
+	/*
+	 * Make sure all delayed rcu free inodes are flushed before we
+	 * destroy the inode cache.
+	 */
+	rcu_barrier();
+	kmem_cache_destroy(zonefs_inode_cachep);
+}
+
+static int __init zonefs_init(void)
+{
+	int ret;
+
+	ret = zonefs_init_inodecache();
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&zonefs_type);
+	if (ret) {
+		zonefs_destroy_inodecache();
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit zonefs_exit(void)
+{
+	zonefs_destroy_inodecache();
+	unregister_filesystem(&zonefs_type);
+}
+
+MODULE_AUTHOR("Damien Le Moal");
+MODULE_DESCRIPTION("Zone file system for zoned block devices");
+MODULE_LICENSE("GPL");
+module_init(zonefs_init);
+module_exit(zonefs_exit);
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
new file mode 100644
index 000000000000..91a9081c0d77
--- /dev/null
+++ b/fs/zonefs/zonefs.h
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple zone file system for zoned block devices.
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ */
+#ifndef __ZONEFS_H__
+#define __ZONEFS_H__
+
+#include <linux/fs.h>
+#include <linux/magic.h>
+
+/*
+ * Maximum length of file names: this only needs to be large enough to fit
+ * the zone group directory names and a decimal value of the start sector of
+ * the zones for file names. 16 characterse is plenty.
+ */
+#define ZONEFS_NAME_MAX		16
+
+/*
+ * Zone types: ZONEFS_ZTYPE_SEQWRITE is used for all sequential zone types
+ * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and
+ * BLK_ZONE_TYPE_SEQWRITE_PREF.
+ */
+enum zonefs_ztype {
+	ZONEFS_ZTYPE_ALL = 0,
+	ZONEFS_ZTYPE_CNV,
+	ZONEFS_ZTYPE_SEQ,
+	ZONEFS_ZTYPE_MAX,
+};
+
+static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return ZONEFS_ZTYPE_CNV;
+	return ZONEFS_ZTYPE_SEQ;
+}
+
+static inline bool zonefs_zone_offline(struct blk_zone *zone)
+{
+	return zone->cond == BLK_ZONE_COND_OFFLINE;
+}
+
+static inline bool zonefs_zone_readonly(struct blk_zone *zone)
+{
+	return zone->cond == BLK_ZONE_COND_READONLY;
+}
+
+/*
+ * Inode private data.
+ */
+struct zonefs_inode_info {
+	struct inode		i_vnode;
+	enum zonefs_ztype	i_ztype;
+	loff_t			i_addr;
+	loff_t			i_wpoffset;
+	loff_t			i_max_size;
+	struct rw_semaphore	i_mmap_sem;
+};
+
+static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
+{
+	return container_of(inode, struct zonefs_inode_info, i_vnode);
+}
+
+static inline bool zonefs_file_is_conv(struct inode *inode)
+{
+	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_CNV;
+}
+
+static inline bool zonefs_file_is_seq(struct inode *inode)
+{
+	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_SEQ;
+}
+
+/*
+ * Address (byte offset) on disk of a file zone.
+ */
+static inline loff_t zonefs_file_addr(struct inode *inode)
+{
+	return ZONEFS_I(inode)->i_addr;
+}
+
+/*
+ * Maximum possible size of a file (i.e. the zone size).
+ */
+static inline loff_t zonefs_file_max_size(struct inode *inode)
+{
+	return ZONEFS_I(inode)->i_max_size;
+}
+
+/*
+ * On-disk super block (block 0).
+ */
+struct zonefs_super {
+
+	/* Magic number */
+	__le32		s_magic;		/*    4 */
+
+	/* Metadata version number */
+	__le32		s_version;		/*    8 */
+
+	/* Features */
+	__le64		s_features;		/*   16 */
+
+	/* 128-bit uuid */
+	__u8		s_uuid[16];		/*   32 */
+
+	/* UID/GID to use for files */
+	__le32		s_uid;			/*   36 */
+	__le32		s_gid;			/*   40 */
+
+	/* File permissions */
+	__le32		s_perm;			/*   44 */
+
+	/* Padding to 4K */
+	__u8		s_reserved[4052];	/* 4096 */
+
+} __attribute__ ((packed));
+
+/*
+ * Metadata version.
+ */
+#define ZONEFS_VERSION	1
+
+/*
+ * Feature flags.
+ */
+enum zonefs_features {
+	/*
+	 * Use a zone start sector value as file name.
+	 */
+	ZONEFS_F_STARTSECT_NAME,
+	/*
+	 * Aggregate contiguous conventional zones into a single file.
+	 */
+	ZONEFS_F_AGRCNV,
+	/*
+	 * Use super block specified UID for files instead of default.
+	 */
+	ZONEFS_F_UID,
+	/*
+	 * Use super block specified GID for files instead of default.
+	 */
+	ZONEFS_F_GID,
+	/*
+	 * Use super block specified file permissions instead of default 640.
+	 */
+	ZONEFS_F_PERM,
+};
+
+/*
+ * In-memory Super block information.
+ */
+struct zonefs_sb_info {
+	/*
+	 * Mount options.
+	 */
+	unsigned long		s_mnt_opt;
+	unsigned long long	s_features;
+	kuid_t			s_uid;		/* File owner UID */
+	kgid_t			s_gid;		/* File owner GID */
+	umode_t			s_perm;		/* File permissions */
+
+	/*
+	 * Device information.
+	 */
+	loff_t			s_blocksize_mask;
+	unsigned int		s_nr_zones[ZONEFS_ZTYPE_MAX];
+};
+
+static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline bool zonefs_has_feature(struct zonefs_sb_info *sbi,
+				      enum zonefs_features f)
+{
+	return sbi->s_features & (1ULL << f);
+}
+
+#define zonefs_info(sb, format, args...)	\
+	pr_info("zonefs (%s): " format, sb->s_id, ## args)
+#define zonefs_err(sb, format, args...)	\
+	pr_err("zonefs (%s) ERROR: " format, sb->s_id, ## args)
+#define zonefs_warn(sb, format, args...)	\
+	pr_warn("zonefs (%s) WARN: " format, sb->s_id, ## args)
+
+#endif
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f8c00045d537..57b627429f41 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -86,6 +86,7 @@
 #define NSFS_MAGIC		0x6e736673
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
+#define ZONEFS_MAGIC		0x5a4f4653
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-- 
2.21.0

