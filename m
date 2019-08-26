Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083C39C9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfHZG6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 02:58:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30789 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfHZG6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566802680; x=1598338680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dU3m0beh7ML168cs9b6M7yo2FA4eGoSZwgfXK8y1aUk=;
  b=ALVpA86ZciXS6RG1xW9+wd0jGU1nBH9v3dZIc6qe8lx1ve2W+LHYOfSn
   Y9pZGCy05jKxnzrcwuOD/LPY5BOPtdjBdwOOIQSaCVwtsTVMPMcpMZfOI
   AoptMQMf4tRMTjeKvxu3r4BArThC0WJLhBDKoKQhib2/VvhK6lKEveOgH
   tXONmwVKng0G/+Zh/kkHiQsLnlJD512R9vz8szB8n8CNHv/oQZ57N314b
   kWSYGSqAzSa2FaAuCfFcogYxZ6DmOWmp9kgEAT1ddd5QMrJHIenboYxSV
   KYUuJAMDAWxwocEdaA6usrvw8tcVlvZGxxPtxPdxJeWB79guwxC+ZuYsr
   Q==;
IronPort-SDR: USrDX9blU0IRMo70+dCh251X7BCXhExdke5oqRGSXMrsKqWWy3eRH3sgrmBAhxoTtKPMKHfami
 wqGjtyExbYicNz/h+C56BwCpWT/5qUkFH/gnfQoAmbPvDDvVwKbrnUCwwE/HFR/dmp/GUyUIiX
 pC2JZKNxGkGxcZpFllfv2nP4AgcmGqst5qFN56qnQEYVZkkej9poovOM3sFWB9Kx2H/GP4eJPh
 6trLN+TpuJKIwKRGFfo/fNTX679Cmua4omvgJO/xINXLw0ZjyiX4fMJ6JPvXFE+BPDcjFrpt2w
 vtg=
X-IronPort-AV: E=Sophos;i="5.64,431,1559491200"; 
   d="scan'208";a="118244076"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2019 14:57:53 +0800
IronPort-SDR: HE2tsgOsZJ3SxPwpQtJ2w1S0Ys8FcvOaxoRmOYIn6JjAxI9xwWeM2oqTQVTPIXlOPUj6LDT9FM
 mtFlSDdfezXm+YbICRzWVDXCAN8cAZM2eZW7582xJY2X8KhAzT6/y7cYf8OE0xvjuxcaKY3xI+
 qMZHDXXBvMpbqLFCfpvguo1ZU3RA5k0nF20nbXaqrURWyZAV1SvXSJoLYxySzj27qqHX9CW3to
 98IP6EFtljR21xLOmA9deouo4m7nK0JwD0npUKlTgcpud2Ft5iNdielm9HRfjkcjmQ71YOXnZw
 g4xywyv5fV23wxpSwlcNrLJa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 23:55:06 -0700
IronPort-SDR: HmFJADn8dRHr3IgfeXHHZYP4KfhUXvuttIGFKvXuFbNfFWXAH32Z5+qVLpfK4swyHs2w1fwuGu
 w6dMQGOuLfqvYhsjLtz3GOk3xdQmLTH5MqvMGi6KuKO/1CdB3+UyHWzr9sdH64f5/nL8J/zAwO
 BD4pc9q7IBbuhCPxL169/q3tZ4rW4pHlQ7JBLeXMhGcEe3T0twqAEOHXmAwT3hVn3Mwobp1Bc1
 lHQDeGbj9DNghsnpiizTlvOkNmp2pfZPc8l2uLmU1Yv5/dLBkJffQewN7o/RsWQmQaBfXoAjEd
 tDU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Aug 2019 23:57:51 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH V4] fs: New zonefs file system
Date:   Mon, 26 Aug 2019 15:57:50 +0900
Message-Id: <20190826065750.11674-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zonefs is a very simple file system exposing each zone of a zoned
block device as a file. zonefs is in fact closer to a raw block device
access interface than to a full feature POSIX file system.

The goal of zonefs is to simplify implementation of zoned block device
raw access by applications by allowing switching to the well known POSIX
file API rather than relying on direct block device file ioctls and
read/write. Zonefs, for instance, greatly simplifies the implementation
of LSM (log-structured merge) tree structures (such as used in RocksDB
and LevelDB) on zoned block devices by allowing SSTables to be stored in
a zone file similarly to a regular file system architecture, hence
reducing the amount of change needed in the application.

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

The mkzonefs tool is used to format zonefs. This tool is available
on Github at: git@github.com:damien-lemoal/zonefs-tools.git.
zonefs-tools includes a simple test suite which can be run against any
zoned block device, including null_blk block device created with zoned
mode.

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
Changes from v3:
* Enhanced super block features and reserved field handling as suggested
  by Darrick.
* Expose offline zones as non-accessible files to avoid zone to file
  name mapping changes.

Changes from v2:
* Addressed comments from Darrick: Typo, added checksum to super block,
  enhance cheks of the super block fields validity (used reserved bytes
  and unknown features bits)
* Rebased on XFS tree iomap-for-next branch

Changes from v1:
* Rebased on latest iomap branch iomap-5.4-merge of XFS tree at
  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
* Addressed all comments from Dave Chinner and others

 MAINTAINERS                |   10 +
 fs/Kconfig                 |    1 +
 fs/Makefile                |    1 +
 fs/zonefs/Kconfig          |    9 +
 fs/zonefs/Makefile         |    4 +
 fs/zonefs/super.c          | 1093 ++++++++++++++++++++++++++++++++++++
 fs/zonefs/zonefs.h         |  185 ++++++
 include/uapi/linux/magic.h |    1 +
 8 files changed, 1304 insertions(+)
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f0..a1b2c9836073 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17793,6 +17793,16 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
+ZONEFS FILESYSTEM
+M:	Damien Le Moal <damien.lemoal@wdc.com>
+M:	Naohiro Aota <naohiro.aota@wdc.com>
+R:	Johannes Thumshirn <jth@kernel.org>
+L:	linux-fsdevel@vger.kernel.org
+T:	git git@github.com:damien-lemoal/zonefs.git
+S:	Maintained
+F:	Documentation/filesystems/zonefs.txt
+F:	fs/zonefs/
+
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>
 L:	linux-mm@kvack.org
diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..dcaf3e07680f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -40,6 +40,7 @@ source "fs/ocfs2/Kconfig"
 source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
+source "fs/zonefs/Kconfig"
 
 config FS_DAX
 	bool "Direct Access (DAX) support"
diff --git a/fs/Makefile b/fs/Makefile
index d60089fd689b..7d3c90e1ad79 100644
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
index 000000000000..8659878c6aec
--- /dev/null
+++ b/fs/zonefs/super.c
@@ -0,0 +1,1093 @@
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
+#include <linux/crc32.h>
+
+#include "zonefs.h"
+
+static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			      unsigned int flags, struct iomap *iomap)
+{
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	loff_t max_isize = zonefs_file_max_size(inode);
+	loff_t isize;
+
+	/*
+	 * For sequential zones, enforce direct IO writes. This is already
+	 * checked when writes are issued, so warn about this here if we
+	 * get buffered write to a sequential file inode.
+	 */
+	if (WARN_ON_ONCE(zonefs_file_is_seq(inode) && (flags & IOMAP_WRITE) &&
+			 !(flags & IOMAP_DIRECT)))
+		return -EIO;
+
+	/* An IO cannot exceed the zone size */
+	if (offset >= max_isize)
+		return -EFBIG;
+
+	/* All blocks are always mapped */
+	mutex_lock(&zi->i_truncate_mutex);
+	isize = i_size_read(inode);
+	if (offset >= isize) {
+		length = min(length, max_isize - offset);
+		iomap->type = IOMAP_UNWRITTEN;
+	} else {
+		length = min(length, isize - offset);
+		iomap->type = IOMAP_MAPPED;
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	iomap->offset = offset & (~sbi->s_blocksize_mask);
+	iomap->length = ((offset + length + sbi->s_blocksize_mask) &
+			 (~sbi->s_blocksize_mask)) - iomap->offset;
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->addr = (zonefs_file_start_sector(inode) << SECTOR_SHIFT)
+		      + iomap->offset;
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
+	return zonefs_iomap_begin(inode, offset, zonefs_file_max_size(inode),
+				  0, &wpc->iomap);
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
+static int zonefs_seq_file_truncate(struct inode *inode)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	int ret;
+
+	inode_dio_wait(inode);
+
+	/* Serialize against page faults */
+	down_write(&zi->i_mmap_sem);
+
+	/* Serialize against zonefs_iomap_begin() */
+	mutex_lock(&zi->i_truncate_mutex);
+
+	ret = blkdev_reset_zones(inode->i_sb->s_bdev,
+				 zonefs_file_start_sector(inode),
+				 zonefs_file_max_size(inode) >> SECTOR_SHIFT,
+				 GFP_NOFS);
+	if (ret) {
+		zonefs_err(inode->i_sb,
+			   "Reset zone at %llu failed %d",
+			   zonefs_file_start_sector(inode),
+			   ret);
+	} else {
+		truncate_setsize(inode, 0);
+		zi->i_wpoffset = 0;
+	}
+
+	mutex_unlock(&zi->i_truncate_mutex);
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
+		ret = zonefs_seq_file_truncate(inode);
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
+static int zonefs_conv_file_write_and_wait(struct file *file, loff_t start,
+					   loff_t end)
+{
+	int ret;
+
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
+
+	return file_check_and_advance_wb_err(file);
+}
+
+static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
+			     int datasync)
+{
+	struct inode *inode = file_inode(file);
+	int ret = 0;
+
+	/*
+	 * Since only direct writes are allowed in sequential files, page cache
+	 * flush is needed only for conventional zone files.
+	 */
+	if (zonefs_file_is_conv(inode))
+		ret = zonefs_conv_file_write_and_wait(file, start, end);
+
+	if (ret == 0)
+		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+
+	return ret;
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
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	loff_t max_pos;
+	size_t count;
+	ssize_t ret;
+
+	if (iocb->ki_pos >= zonefs_file_max_size(inode))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	mutex_lock(&zi->i_truncate_mutex);
+
+	/*
+	 * Limit read operations to written data.
+	 */
+	max_pos = i_size_read(inode);
+	if (iocb->ki_pos >= max_pos) {
+		mutex_unlock(&zi->i_truncate_mutex);
+		ret = 0;
+		goto out;
+	}
+
+	iov_iter_truncate(to, max_pos - iocb->ki_pos);
+
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	count = iov_iter_count(to);
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		/*
+		 * Direct IO reads must be aligned to device physical sector
+		 * size.
+		 */
+		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
+			ret = -EINVAL;
+		} else {
+			file_accessed(iocb->ki_filp);
+			ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL);
+		}
+	} else {
+		ret = generic_file_read_iter(iocb, to);
+	}
+
+out:
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+/*
+ * When a write error occurs in a sequential zone, the zone write pointer
+ * position must be refreshed to correct the file size and zonefs inode
+ * write pointer offset.
+ */
+static int zonefs_seq_file_write_failed(struct inode *inode, int error)
+{
+	struct super_block *sb = inode->i_sb;
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	sector_t sector = zi->i_zsector;
+	unsigned int nofs_flag;
+	struct blk_zone zone;
+	int n = 1, ret;
+	loff_t pos;
+
+	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);
+
+	/*
+	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution as
+	 * if GFP_NOFS was specified to no end up recusrsing into the FS on
+	 * memory allocation.
+	 */
+	nofs_flag = memalloc_nofs_save();
+	ret = blkdev_report_zones(sb->s_bdev, sector, &zone, &n);
+	memalloc_nofs_restore(nofs_flag);
+
+	if (ret || !n) {
+		if (!n)
+			ret = -EIO;
+		zonefs_err(sb, "Get zone %llu report failed %d\n",
+			   sector, ret);
+		return ret;
+	}
+
+	pos = (zone.wp - zone.start) << SECTOR_SHIFT;
+	zi->i_wpoffset = pos;
+	if (i_size_read(inode) != pos)
+		i_size_write(inode, pos);
+
+	return error;
+}
+
+static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size,
+				     unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	int ret = 0;
+
+	/*
+	 * Conventional zone file size is fixed to the zone size so there
+	 * is no need to do anything.
+	 */
+	if (zonefs_file_is_conv(inode))
+		return 0;
+
+	mutex_lock(&zi->i_truncate_mutex);
+
+	if (size < 0) {
+		ret = zonefs_seq_file_write_failed(inode, size);
+	} else {
+		/* Update seq file size */
+		if (i_size_read(inode) < iocb->ki_pos + size)
+			i_size_write(inode, iocb->ki_pos + size);
+	}
+
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	return ret;
+}
+
+static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	size_t count;
+	ssize_t ret;
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
+	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);
+	count = iov_iter_count(from);
+
+	/*
+	 * Direct writes must be aligned to the block size, that is, the device
+	 * physical sector size, to avoid errors when writing sequential zones
+	 * on 512e devices (512B logical sector, 4KB physical sectors).
+	 */
+	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Enforce sequential writes (append only) in sequential zones.
+	 */
+	mutex_lock(&zi->i_truncate_mutex);
+	if (zonefs_file_is_seq(inode) &&
+	    iocb->ki_pos != zi->i_wpoffset) {
+		zonefs_err(inode->i_sb,
+			   "Unaligned write at %llu + %zu (wp %llu)\n",
+			   iocb->ki_pos, count,
+			   zi->i_wpoffset);
+		mutex_unlock(&zi->i_truncate_mutex);
+		ret = -EINVAL;
+		goto out;
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+			   zonefs_file_dio_write_end);
+	if (zonefs_file_is_seq(inode) &&
+	    (ret > 0 || ret == -EIOCBQUEUED)) {
+		if (ret > 0)
+			count = ret;
+		mutex_lock(&zi->i_truncate_mutex);
+		zi->i_wpoffset += count;
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+out:
+	inode_unlock(inode);
+
+	return ret;
+}
+
+static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
+					  struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count;
+	ssize_t ret;
+
+	/*
+	 * Direct IO writes are mandatory for sequential zones so that the
+	 * write IO order is preserved.
+	 */
+	if (zonefs_file_is_seq(inode))
+		return -EIO;
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
+	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);
+	count = iov_iter_count(from);
+
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
+	if (ret > 0)
+		iocb->ki_pos += ret;
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+
+	return ret;
+}
+
+static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Check that the write operation does not go beyond the zone size.
+	 */
+	if (iocb->ki_pos >= zonefs_file_max_size(inode))
+		return -EFBIG;
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return zonefs_file_dio_write(iocb, from);
+
+	return zonefs_file_buffered_write(iocb, from);
+}
+
+static const struct file_operations zonefs_file_operations = {
+	.open		= generic_file_open,
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
+	mutex_init(&zi->i_truncate_mutex);
+	init_rwsem(&zi->i_mmap_sem);
+	inode_init_once(&zi->i_vnode);
+
+	return &zi->i_vnode;
+}
+
+static void zonefs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
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
+		/*
+		 * Zone file: for read-only zones, do not allow writes.
+		 * For offline zones, disable all accesses and set the file
+		 * size to 0.
+		 */
+		inode->i_mode = S_IFREG;
+		switch (zone->cond) {
+		case BLK_ZONE_COND_READONLY:
+			inode->i_mode |= sbi->s_perm & ~(0222); /* S_IWUGO */
+		case BLK_ZONE_COND_OFFLINE:
+			break;
+		default:
+			inode->i_mode |= sbi->s_perm;
+		}
+		inode->i_uid = sbi->s_uid;
+		inode->i_gid = sbi->s_gid;
+		zi->i_ztype = zonefs_zone_type(zone);
+		zi->i_zsector = zone->start;
+		zi->i_max_size = zone->len << SECTOR_SHIFT;
+
+		if (zone->cond == BLK_ZONE_COND_OFFLINE)
+			zi->i_wpoffset = 0;
+		else if (zonefs_file_is_conv(inode))
+			zi->i_wpoffset = zi->i_max_size;
+		else
+			zi->i_wpoffset =
+				(zone->wp - zone->start) << SECTOR_SHIFT;
+
+		inode->i_size = zi->i_wpoffset;
+		inode->i_blocks = zone->len;
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
+	u64 fsid;
+
+	buf->f_type = ZONEFS_MAGIC;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+	buf->f_namelen = ZONEFS_NAME_MAX;
+
+	buf->f_blocks = nr_sectors >> (sb->s_blocksize_bits - SECTOR_SHIFT);
+	buf->f_bfree = 0;
+	buf->f_bavail = 0;
+
+	buf->f_files = blkdev_nr_zones(sb->s_bdev);
+	for (t = 0 ; t < ZONEFS_ZTYPE_MAX; t++) {
+		if (sbi->s_nr_zones[t])
+			buf->f_files++;
+	}
+	buf->f_ffree = 0;
+
+	fsid = le64_to_cpup((void *)sbi->s_uuid.b) ^
+		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));
+	buf->f_fsid.val[0] = (u32)fsid;
+	buf->f_fsid.val[1] = (u32)(fsid >> 32);
+
+	return 0;
+}
+
+static const struct super_operations zonefs_sops = {
+	.alloc_inode	= zonefs_alloc_inode,
+	.free_inode	= zonefs_free_inode,
+	.statfs		= zonefs_statfs,
+};
+
+static char *zgroups_name[ZONEFS_ZTYPE_MAX] = {
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
+	end = zones + blkdev_nr_zones(sb->s_bdev);
+	for (zone = &zones[1]; zone < end; zone = next) {
+
+		next = zone + 1;
+		if (zonefs_zone_type(zone) != type)
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
+	zones = kvcalloc(blkdev_nr_zones(bdev),
+			 sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones)
+		return ERR_PTR(-ENOMEM);
+
+	/* Get zones information */
+	zone = zones;
+	while (nr_zones < blkdev_nr_zones(bdev) &&
+	       sector < nr_sectors) {
+
+		n = blkdev_nr_zones(bdev) - nr_zones;
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
+	    nr_zones != blkdev_nr_zones(bdev)) {
+		zonefs_err(sb, "Invalid zone report\n");
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
+	u32 crc, stored_crc;
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
+	super = page_address(page);
+
+	stored_crc = super->s_crc;
+	super->s_crc = 0;
+	crc = crc32_le(ZONEFS_MAGIC, (unsigned char *)super,
+		       sizeof(struct zonefs_super));
+	if (crc != stored_crc) {
+		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
+			   crc, stored_crc);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
+		goto out;
+
+	sbi->s_features = le64_to_cpu(super->s_features);
+	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
+		zonefs_err(sb, "Unknown features set 0x%llx\n",
+			   sbi->s_features);
+		goto out;
+	}
+
+
+	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {
+		sbi->s_uid = make_kuid(current_user_ns(),
+				       le32_to_cpu(super->s_uid));
+		if (!uid_valid(sbi->s_uid)) {
+			zonefs_err(sb, "Invalid UID feature\n");
+			goto out;
+		}
+	}
+	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {
+		sbi->s_gid = make_kgid(current_user_ns(),
+				       le32_to_cpu(super->s_gid));
+		if (!gid_valid(sbi->s_gid)) {
+			zonefs_err(sb, "Invalid GID feature\n");
+			goto out;
+		}
+	}
+
+	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))
+		sbi->s_perm = le32_to_cpu(super->s_perm);
+
+	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
+		zonefs_err(sb, "Reserved area is being used\n");
+		goto out;
+	}
+
+	uuid_copy(&sbi->s_uuid, &super->s_uuid);
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
+	sb->s_op = &zonefs_sops;
+	sb->s_time_gran	= 1;
+
+	/*
+	 * The block size is always equal to the device physical sector size to
+	 * ensure that writes on 512e disks (512B logical block and 4KB
+	 * physical block) are always aligned.
+	 */
+	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
+	sbi->s_blocksize_mask = sb->s_blocksize - 1;
+
+	sbi->s_uid = GLOBAL_ROOT_UID;
+	sbi->s_gid = GLOBAL_ROOT_GID;
+	sbi->s_perm = 0640; /* S_IRUSR | S_IWUSR | S_IRGRP */
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
+		sb->s_id, blkdev_nr_zones(sb->s_bdev));
+
+	/* Create root directory inode */
+	ret = -ENOMEM;
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = S_IFDIR | 0755;
+	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_size = sizeof(struct dentry) * 2;
+	set_nlink(inode, 2);
+
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
+	BUILD_BUG_ON(sizeof(struct zonefs_super) != ZONEFS_SUPER_SIZE);
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
index 000000000000..5338663711b4
--- /dev/null
+++ b/fs/zonefs/zonefs.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#include <linux/uuid.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+
+/*
+ * Maximum length of file names: this only needs to be large enough to fit
+ * the zone group directory names and a decimal value of the start sector of
+ * the zones for file names. 16 characters is plenty.
+ */
+#define ZONEFS_NAME_MAX		16
+
+/*
+ * Zone types: ZONEFS_ZTYPE_SEQ is used for all sequential zone types
+ * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and
+ * BLK_ZONE_TYPE_SEQWRITE_PREF.
+ */
+enum zonefs_ztype {
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
+/*
+ * Inode private data.
+ */
+struct zonefs_inode_info {
+	struct inode		i_vnode;
+	enum zonefs_ztype	i_ztype;
+	sector_t		i_zsector;
+	loff_t			i_wpoffset;
+	loff_t			i_max_size;
+	struct mutex		i_truncate_mutex;
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
+ * Start sector on disk of a file zone.
+ */
+static inline loff_t zonefs_file_start_sector(struct inode *inode)
+{
+	return ZONEFS_I(inode)->i_zsector;
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
+#define ZONEFS_SUPER_SIZE	4096
+struct zonefs_super {
+
+	/* Magic number */
+	__le32		s_magic;
+
+	/* Checksum */
+	__le32		s_crc;
+
+	/* Features */
+	__le64		s_features;
+
+	/* 128-bit uuid */
+	uuid_t		s_uuid;
+
+	/* UID/GID to use for files */
+	__le32		s_uid;
+	__le32		s_gid;
+
+	/* File permissions */
+	__le32		s_perm;
+
+	/* Padding to ZONEFS_SUPER_SIZE bytes */
+	__u8		s_reserved[4052];
+
+} __packed;
+
+/*
+ * Feature flags: used on disk in the s_features field of struct zonefs_super
+ * and in-memory in the s_feartures field of struct zonefs_sb_info.
+ */
+enum zonefs_features {
+	/*
+	 * Use a zone start sector value as file name.
+	 */
+	__ZONEFS_F_STARTSECT_NAME,
+	/*
+	 * Aggregate contiguous conventional zones into a single file.
+	 */
+	__ZONEFS_F_AGRCNV,
+	/*
+	 * Use super block specified UID for files instead of default.
+	 */
+	__ZONEFS_F_UID,
+	/*
+	 * Use super block specified GID for files instead of default.
+	 */
+	__ZONEFS_F_GID,
+	/*
+	 * Use super block specified file permissions instead of default 640.
+	 */
+	__ZONEFS_F_PERM,
+};
+
+#define ZONEFS_F_STARTSECT_NAME	(1ULL << __ZONEFS_F_STARTSECT_NAME)
+#define ZONEFS_F_AGRCNV		(1ULL << __ZONEFS_F_AGRCNV)
+#define ZONEFS_F_UID		(1ULL << __ZONEFS_F_UID)
+#define ZONEFS_F_GID		(1ULL << __ZONEFS_F_GID)
+#define ZONEFS_F_PERM		(1ULL << __ZONEFS_F_PERM)
+
+#define ZONEFS_F_DEFINED_FEATURES \
+	(ZONEFS_F_STARTSECT_NAME | ZONEFS_F_AGRCNV | \
+	 ZONEFS_F_UID | ZONEFS_F_GID | ZONEFS_F_PERM)
+
+/*
+ * In-memory Super block information.
+ */
+struct zonefs_sb_info {
+
+	unsigned long long	s_features;
+	kuid_t			s_uid;		/* File owner UID */
+	kgid_t			s_gid;		/* File owner GID */
+	umode_t			s_perm;		/* File permissions */
+	uuid_t			s_uuid;
+
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
+	return sbi->s_features & f;
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
index 1274c692e59c..3be20c774142 100644
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

