Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D5417566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbhIXNVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 09:21:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11373 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346009AbhIXNVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:21:08 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A6ZgjnaiTPqpuNoy33CxjH/1OX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUOzmQWXTiBbv2LZDD0L9xyO9+/9E0G78TXx9Y1GQpornw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi8xZVA/fvQHOOkWbS?=
 =?us-ascii?q?YYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm7Z3KkBGYKhMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd1LUZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3g0GUK+B7SX+fB9Pg89uk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+sjztCWE8Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="114917461"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Sep 2021 21:10:36 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5E28D4D0DC77;
        Fri, 24 Sep 2021 21:10:30 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Sep 2021 21:10:26 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Sep 2021 21:10:23 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v7 7/8] xfs: Implement ->notify_failure() for XFS
Date:   Fri, 24 Sep 2021 21:09:58 +0800
Message-ID: <20210924130959.2695749-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5E28D4D0DC77.A27F1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is used to handle errors which may cause data lost in
filesystem.  Such as memory failure in fsdax mode.

If the rmap feature of XFS enabled, we can query it to find files and
metadata which are associated with the corrupt data.  For now all we do
is kill processes with that file mapped into their address spaces, but
future patches could actually do something about corrupt metadata.

After that, the memory failure needs to notify the processes who are
using those files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c |  19 +++++
 fs/xfs/xfs_fsops.c  |   3 +
 fs/xfs/xfs_mount.h  |   1 +
 fs/xfs/xfs_super.c  | 188 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  18 +++++
 5 files changed, 229 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 7d4a11dcba90..22091e7fb0ef 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -135,6 +135,25 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 
+void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	dax_set_holder(dax_dev, holder, ops);
+}
+EXPORT_SYMBOL_GPL(fs_dax_register_holder);
+
+void fs_dax_unregister_holder(struct dax_device *dax_dev)
+{
+	dax_set_holder(dax_dev, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(fs_dax_unregister_holder);
+
+void *fs_dax_get_holder(struct dax_device *dax_dev)
+{
+	return dax_get_holder(dax_dev);
+}
+EXPORT_SYMBOL_GPL(fs_dax_get_holder);
+
 bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors)
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 33e26690a8c4..4c2d3d4ca5a5 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -542,6 +542,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of in-memory data";
+	} else if (flags & SHUTDOWN_CORRUPT_META) {
+		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
+		why = "Corruption of on-disk metadata";
 	} else {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Metadata I/O Error";
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e091f3b3fa15..d0f6da23e3df 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -434,6 +434,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
 
 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4e0cd1c1c8c..46fdf44b5ec2 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -37,11 +37,19 @@
 #include "xfs_reflink.h"
 #include "xfs_pwork.h"
 #include "xfs_ag.h"
+#include "xfs_alloc.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_bit.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/mm.h>
+#include <linux/dax.h>
 
+static const struct dax_holder_operations xfs_dax_holder_operations;
 static const struct super_operations xfs_super_operations;
 
 static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
@@ -377,6 +385,8 @@ xfs_close_devices(
 
 		xfs_free_buftarg(mp->m_logdev_targp);
 		xfs_blkdev_put(logdev);
+		if (dax_logdev)
+			fs_dax_unregister_holder(dax_logdev);
 		fs_put_dax(dax_logdev);
 	}
 	if (mp->m_rtdev_targp) {
@@ -385,9 +395,13 @@ xfs_close_devices(
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
 		xfs_blkdev_put(rtdev);
+		if (dax_rtdev)
+			fs_dax_unregister_holder(dax_rtdev);
 		fs_put_dax(dax_rtdev);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
+	if (dax_ddev)
+		fs_dax_unregister_holder(dax_ddev);
 	fs_put_dax(dax_ddev);
 }
 
@@ -411,6 +425,9 @@ xfs_open_devices(
 	struct block_device	*logdev = NULL, *rtdev = NULL;
 	int			error;
 
+	if (dax_ddev)
+		fs_dax_register_holder(dax_ddev, mp,
+				&xfs_dax_holder_operations);
 	/*
 	 * Open real time and log devices - order is important.
 	 */
@@ -419,6 +436,9 @@ xfs_open_devices(
 		if (error)
 			goto out;
 		dax_logdev = fs_dax_get_by_bdev(logdev);
+		if (dax_logdev != dax_ddev && dax_logdev)
+			fs_dax_register_holder(dax_logdev, mp,
+					&xfs_dax_holder_operations);
 	}
 
 	if (mp->m_rtname) {
@@ -433,6 +453,9 @@ xfs_open_devices(
 			goto out_close_rtdev;
 		}
 		dax_rtdev = fs_dax_get_by_bdev(rtdev);
+		if (dax_rtdev)
+			fs_dax_register_holder(dax_rtdev, mp,
+					&xfs_dax_holder_operations);
 	}
 
 	/*
@@ -1110,6 +1133,171 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+struct notify_failure_info {
+	xfs_agblock_t startblock;
+	xfs_filblks_t blockcount;
+	int flags;
+};
+
+static loff_t
+xfs_notify_failure_start(
+	struct xfs_mount			*mp,
+	const struct xfs_rmap_irec		*rec,
+	const struct notify_failure_info	*notify)
+{
+	loff_t start = rec->rm_offset;
+
+	if (notify->startblock > rec->rm_startblock)
+		start += XFS_FSB_TO_B(mp,
+				notify->startblock - rec->rm_startblock);
+	return start;
+}
+
+static size_t
+xfs_notify_failure_size(
+	struct xfs_mount			*mp,
+	const struct xfs_rmap_irec		*rec,
+	const struct notify_failure_info	*notify)
+{
+	xfs_agblock_t rec_start = rec->rm_startblock;
+	xfs_agblock_t rec_end = rec->rm_startblock + rec->rm_blockcount;
+	xfs_agblock_t notify_start = notify->startblock;
+	xfs_agblock_t notify_end = notify->startblock + notify->blockcount;
+	xfs_agblock_t cross_start = max(rec_start, notify_start);
+	xfs_agblock_t cross_end = min(rec_end, notify_end);
+
+	return XFS_FSB_TO_B(mp, cross_end - cross_start);
+}
+
+static int
+xfs_dax_notify_failure_fn(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+	struct xfs_inode		*ip;
+	struct address_space		*mapping;
+	struct notify_failure_info	*notify = data;
+	int				error = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		// TODO check and try to fix metadata
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	/* Get files that incore, filter out others that are not in use. */
+	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
+			 0, &ip);
+	if (error)
+		return error;
+
+	mapping = VFS_I(ip)->i_mapping;
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		loff_t offset = xfs_notify_failure_start(mp, rec, notify);
+		size_t size = xfs_notify_failure_size(mp, rec, notify);
+
+		error = mf_dax_kill_procs(mapping, offset >> PAGE_SHIFT, size,
+					  notify->flags);
+	}
+	// TODO try to fix data
+	xfs_irele(ip);
+
+	return error;
+}
+
+static loff_t
+xfs_dax_bdev_offset(
+	struct xfs_mount *mp,
+	struct dax_device *dax_dev,
+	loff_t disk_offset)
+{
+	struct block_device *bdev;
+
+	if (mp->m_ddev_targp->bt_daxdev == dax_dev)
+		bdev = mp->m_ddev_targp->bt_bdev;
+	else if (mp->m_logdev_targp->bt_daxdev == dax_dev)
+		bdev = mp->m_logdev_targp->bt_bdev;
+	else
+		bdev = mp->m_rtdev_targp->bt_bdev;
+
+	return disk_offset - (get_start_sect(bdev) << SECTOR_SHIFT);
+}
+
+static int
+xfs_dax_notify_failure(
+	struct dax_device	*dax_dev,
+	loff_t			offset,
+	size_t			len,
+	int			flags)
+{
+	struct xfs_mount	*mp = fs_dax_get_holder(dax_dev);
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_buf		*agf_bp = NULL;
+	struct xfs_rmap_irec	rmap_low, rmap_high;
+	loff_t			bdev_offset = xfs_dax_bdev_offset(mp, dax_dev,
+								  offset);
+	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, bdev_offset);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	int			error = 0;
+	struct notify_failure_info notify = {
+		.startblock	= XFS_FSB_TO_AGBNO(mp, fsbno),
+		.blockcount	= XFS_B_TO_FSB(mp, len),
+		.flags		= flags,
+	};
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
+		xfs_warn(mp,
+			 "notify_failure() not supported on realtime device!");
+		return -EOPNOTSUPP;
+	}
+
+	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
+	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
+		return -EFSCORRUPTED;
+	}
+
+	if (!xfs_has_rmapbt(mp)) {
+		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+	if (error)
+		goto out_cancel_tp;
+
+	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
+
+	/* Construct a range for rmap query */
+	memset(&rmap_low, 0, sizeof(rmap_low));
+	memset(&rmap_high, 0xFF, sizeof(rmap_high));
+	rmap_low.rm_startblock = rmap_high.rm_startblock = notify.startblock;
+	rmap_low.rm_blockcount = rmap_high.rm_blockcount = notify.blockcount;
+
+	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
+				     xfs_dax_notify_failure_fn, &notify);
+
+	xfs_btree_del_cursor(cur, error);
+	xfs_trans_brelse(tp, agf_bp);
+
+out_cancel_tp:
+	xfs_trans_cancel(tp);
+	return error;
+}
+
+static const struct dax_holder_operations xfs_dax_holder_operations = {
+	.notify_failure		= xfs_dax_notify_failure,
+};
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3d90becbd160..0f1fa7a4a616 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -149,6 +149,10 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 }
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
+void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void fs_dax_unregister_holder(struct dax_device *dax_dev);
+void *fs_dax_get_holder(struct dax_device *dax_dev);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
@@ -179,6 +183,20 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	return NULL;
 }
 
+static inline void fs_dax_register_holder(struct dax_device *dax_dev,
+		void *holder, const struct dax_holder_operations *ops)
+{
+}
+
+static inline void fs_dax_unregister_holder(struct dax_device *dax_dev)
+{
+}
+
+static inline void *fs_dax_get_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
+
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.33.0



