Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850A14C5AEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiB0MJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 07:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiB0MIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:08:51 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5807289BC;
        Sun, 27 Feb 2022 04:08:00 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AVOpC5az9a73ieinsGEZ6t+dcxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGwj0GBUzGZLUD+FPa2LNzD3ft8iaoW2o09SuMWGmIRkHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeWdeSPg753Ip6HBWz62qxl0N2k6NJMZ9s55G2Z?=
 =?us-ascii?q?L8uYSKSxLZReG78q2y7KTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+Agnj5bi0drVe9prQ+6GuVyxZ?=
 =?us-ascii?q?+uJDrLtbUf9miQcROgl3eomPA4nS/DhwEXPSdwDyItHmsm8fIhyrwXI9UH7q9n?=
 =?us-ascii?q?tZugVuO1ikdExEbS1a/iee2h1T4WN9FLUEQvC00osAa8E2tU8m4XBCipnOAlgA?=
 =?us-ascii?q?TVsAWEOAg7gyJjK3O7G6xAmkCUy4EeNI9nNE5SCZs1VKTmd7tQzt1v9Wopdi1n?=
 =?us-ascii?q?luPhWrqf3FLcilZPmlZJTbpKuLL+Okb5i8jhP4+eEJtsuDIJA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHK/0DaHi4qOcNDRZpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122037693"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Feb 2022 20:07:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5487E4D169F2;
        Sun, 27 Feb 2022 20:07:53 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:55 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 27 Feb 2022 20:07:52 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
Date:   Sun, 27 Feb 2022 20:07:46 +0800
Message-ID: <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5487E4D169F2.A383A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce xfs_notify_failure.c to handle failure related works, such as
implement ->notify_failure(), register/unregister dax holder in xfs, and
so on.

If the rmap feature of XFS enabled, we can query it to find files and
metadata which are associated with the corrupt data.  For now all we do
is kill processes with that file mapped into their address spaces, but
future patches could actually do something about corrupt metadata.

After that, the memory failure needs to notify the processes who are
using those files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/Makefile             |   1 +
 fs/xfs/xfs_buf.c            |  12 ++
 fs/xfs/xfs_fsops.c          |   3 +
 fs/xfs/xfs_mount.h          |   1 +
 fs/xfs/xfs_notify_failure.c | 235 ++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.h |  10 ++
 fs/xfs/xfs_super.c          |   6 +
 7 files changed, 268 insertions(+)
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 04611a1068b4..389970b3e13b 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -84,6 +84,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_message.o \
 				   xfs_mount.o \
 				   xfs_mru_cache.o \
+				   xfs_notify_failure.o \
 				   xfs_pwork.o \
 				   xfs_reflink.o \
 				   xfs_stats.o \
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index b45e0d50a405..5f4984a5e108 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -19,6 +19,7 @@
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_ag.h"
+#include "xfs_notify_failure.h"
 
 static struct kmem_cache *xfs_buf_cache;
 
@@ -1892,6 +1893,8 @@ xfs_free_buftarg(
 	list_lru_destroy(&btp->bt_lru);
 
 	blkdev_issue_flush(btp->bt_bdev);
+	if (btp->bt_daxdev)
+		dax_unregister_holder(btp->bt_daxdev, btp->bt_mount);
 	fs_put_dax(btp->bt_daxdev);
 
 	kmem_free(btp);
@@ -1939,6 +1942,7 @@ xfs_alloc_buftarg(
 	struct block_device	*bdev)
 {
 	xfs_buftarg_t		*btp;
+	int			error;
 
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
 
@@ -1946,6 +1950,14 @@ xfs_alloc_buftarg(
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
 	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
+	if (btp->bt_daxdev) {
+		error = dax_register_holder(btp->bt_daxdev, mp,
+				&xfs_dax_holder_operations);
+		if (error) {
+			xfs_err(mp, "DAX device already in use?!");
+			goto error_free;
+		}
+	}
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 33e26690a8c4..d4d36c5bef11 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -542,6 +542,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of in-memory data";
+	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
+		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
+		why = "Corruption of on-disk metadata";
 	} else {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Metadata I/O Error";
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 00720a02e761..47ff4ac53c4c 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
 #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
 #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
+#define SHUTDOWN_CORRUPT_ONDISK	0x0010  /* corrupt metadata on device */
 
 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
new file mode 100644
index 000000000000..b057e9f7eb31
--- /dev/null
+++ b/fs/xfs/xfs_notify_failure.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
+ */
+
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_alloc.h"
+#include "xfs_bit.h"
+#include "xfs_btree.h"
+#include "xfs_inode.h"
+#include "xfs_icache.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtalloc.h"
+#include "xfs_trans.h"
+
+#include <linux/mm.h>
+#include <linux/dax.h>
+
+struct failure_info {
+	xfs_agblock_t		startblock;
+	xfs_extlen_t		blockcount;
+	int			mf_flags;
+};
+
+#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
+static pgoff_t
+xfs_failure_pgoff(
+	struct xfs_mount		*mp,
+	const struct xfs_rmap_irec	*rec,
+	const struct failure_info	*notify)
+{
+	uint64_t			pos = rec->rm_offset;
+
+	if (notify->startblock > rec->rm_startblock)
+		pos += XFS_FSB_TO_B(mp,
+				notify->startblock - rec->rm_startblock);
+	return pos >> PAGE_SHIFT;
+}
+
+static unsigned long
+xfs_failure_pgcnt(
+	struct xfs_mount		*mp,
+	const struct xfs_rmap_irec	*rec,
+	const struct failure_info	*notify)
+{
+	xfs_agblock_t			end_rec;
+	xfs_agblock_t			end_notify;
+	xfs_agblock_t			start_cross;
+	xfs_agblock_t			end_cross;
+
+	start_cross = max(rec->rm_startblock, notify->startblock);
+
+	end_rec = rec->rm_startblock + rec->rm_blockcount;
+	end_notify = notify->startblock + notify->blockcount;
+	end_cross = min(end_rec, end_notify);
+
+	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
+}
+
+static int
+xfs_dax_failure_fn(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+	struct xfs_inode		*ip;
+	struct failure_info		*notify = data;
+	int				error = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+		return -EFSCORRUPTED;
+	}
+
+	/* Get files that incore, filter out others that are not in use. */
+	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
+			 0, &ip);
+	/* Continue the rmap query if the inode isn't incore */
+	if (error == -ENODATA)
+		return 0;
+	if (error)
+		return error;
+
+	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
+				  xfs_failure_pgoff(mp, rec, notify),
+				  xfs_failure_pgcnt(mp, rec, notify),
+				  notify->mf_flags);
+	xfs_irele(ip);
+	return error;
+}
+#else
+static int
+xfs_dax_failure_fn(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+
+	/* No other option besides shutting down the fs. */
+	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+	return -EFSCORRUPTED;
+}
+#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
+
+static int
+xfs_dax_notify_ddev_failure(
+	struct xfs_mount	*mp,
+	xfs_daddr_t		daddr,
+	xfs_daddr_t		bblen,
+	int			mf_flags)
+{
+	struct xfs_trans	*tp = NULL;
+	struct xfs_btree_cur	*cur = NULL;
+	struct xfs_buf		*agf_bp = NULL;
+	int			error = 0;
+	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
+	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
+	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
+	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
+
+	error = xfs_trans_alloc_empty(mp, &tp);
+	if (error)
+		return error;
+
+	for (; agno <= end_agno; agno++) {
+		struct xfs_rmap_irec	ri_low = { };
+		struct xfs_rmap_irec	ri_high;
+		struct failure_info	notify;
+		struct xfs_agf		*agf;
+		xfs_agblock_t		agend;
+
+		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+		if (error)
+			break;
+
+		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
+
+		/*
+		 * Set the rmap range from ri_low to ri_high, which represents
+		 * a [start, end] where we looking for the files or metadata.
+		 * The part of range out of a AG will be ignored.  So, it's fine
+		 * to set ri_low to "startblock" in all loops.  When it reaches
+		 * the last AG, set the ri_high to "endblock" to make sure we
+		 * actually end at the end.
+		 */
+		memset(&ri_high, 0xFF, sizeof(ri_high));
+		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
+		if (agno == end_agno)
+			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
+
+		agf = agf_bp->b_addr;
+		agend = min(be32_to_cpu(agf->agf_length),
+				ri_high.rm_startblock);
+		notify.startblock = ri_low.rm_startblock;
+		notify.blockcount = agend - ri_low.rm_startblock;
+
+		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
+				xfs_dax_failure_fn, &notify);
+		xfs_btree_del_cursor(cur, error);
+		xfs_trans_brelse(tp, agf_bp);
+		if (error)
+			break;
+
+		fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
+	}
+
+	xfs_trans_cancel(tp);
+	return error;
+}
+
+static int
+xfs_dax_notify_failure(
+	struct dax_device	*dax_dev,
+	u64			offset,
+	u64			len,
+	int			mf_flags)
+{
+	struct xfs_mount	*mp = dax_holder(dax_dev);
+	u64			ddev_start;
+	u64			ddev_end;
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
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+		return -EFSCORRUPTED;
+	}
+
+	if (!xfs_has_rmapbt(mp)) {
+		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
+		return -EOPNOTSUPP;
+	}
+
+	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
+	ddev_end = ddev_start +
+		(mp->m_ddev_targp->bt_bdev->bd_nr_sectors << SECTOR_SHIFT) - 1;
+
+	/* Ignore the range out of filesystem area */
+	if ((offset + len) < ddev_start)
+		return -ENXIO;
+	if (offset > ddev_end)
+		return -ENXIO;
+
+	/* Calculate the real range when it touches the boundary */
+	if (offset > ddev_start)
+		offset -= ddev_start;
+	else {
+		len -= ddev_start - offset;
+		offset = 0;
+	}
+	if ((offset + len) > ddev_end)
+		len -= ddev_end - offset;
+
+	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
+			mf_flags);
+}
+
+const struct dax_holder_operations xfs_dax_holder_operations = {
+	.notify_failure		= xfs_dax_notify_failure,
+};
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
new file mode 100644
index 000000000000..76187b9620f9
--- /dev/null
+++ b/fs/xfs/xfs_notify_failure.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
+ */
+#ifndef __XFS_NOTIFY_FAILURE_H__
+#define __XFS_NOTIFY_FAILURE_H__
+
+extern const struct dax_holder_operations xfs_dax_holder_operations;
+
+#endif  /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e8f37bdc8354..b8de6ed2c888 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -353,6 +353,12 @@ xfs_setup_dax_always(
 		return -EINVAL;
 	}
 
+	if (xfs_has_reflink(mp) && !xfs_has_rmapbt(mp)) {
+		xfs_alert(mp,
+			"need rmapbt when both DAX and reflink enabled.");
+		return -EINVAL;
+	}
+
 	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 	return 0;
 
-- 
2.35.1



