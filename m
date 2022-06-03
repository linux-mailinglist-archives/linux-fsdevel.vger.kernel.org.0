Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A493253C472
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiFCFiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiFCFiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:38:03 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CD0539148;
        Thu,  2 Jun 2022 22:37:57 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AyjHkN6tvtxIC77XxE+YU5Vict+fnVKtfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yWQYXWiBOPyLYGDzc49wO4rn9EwP75OEz983T1dsqyFgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65DNnxOWKiCEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYu1tgMEiJc7rMasfp3h/wDCfBvEjKbjDSKXi5NlWx?=
 =?us-ascii?q?j48i8lCW/HEaKIxdjtraAXoYhtBIF4bBZsy2uCyiRHXfzRe7lDTuqsz52nayRd?=
 =?us-ascii?q?Z0b7xPd6TcduPLe1ZnFmfoG3u/GnjBBwectuFxlKt9nOqm/+KmCbTW5wbH77+8?=
 =?us-ascii?q?eRl6HWaxXQWIBkXU0ar5Pe+l0iyUs5eLEpS/TAhxYA06kCqS9zVWxyjvGXCuh8?=
 =?us-ascii?q?aRsoWH+AkgCmLw63F6kCZAXIFQSNKaN0OssI9Azct0zehndrvCHpksKC9TmiU/?=
 =?us-ascii?q?bOZ6zi1PEA9N2AFYSMbXA0t+MT4rcc/g3rnStdlDb7wgMb5FC/9xxiUoyUkwbY?=
 =?us-ascii?q?el8gG0+O851+vqzatoIXZCw04/APaWkq74Q5jIo2ofYql7R7c9/koBIKYSESR+?=
 =?us-ascii?q?WgKgOCA4+0US5KAjiqARKMKBr7Bz+iEKjr0k1NpHodn8zWr5m7leppfpix9THq?=
 =?us-ascii?q?FmO5slSTBOReV4F0OosQIeibCUEO+WKrpY+xC8EQqPY6NuijoU+dz?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALGg+1a1PUa5cDnoMW94PpgqjBFYkLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb3qynIpoV86faUskdpZJhOo7C90cW7LU80sKQFhLX5Xo3SOzUO2l?=
 =?us-ascii?q?HYT72KhLGKq1aLdhEWtNQtsZuIGJIeNDSfNzdHZL7BkWuF+sgbsaS62ZHtleHD?=
 =?us-ascii?q?1G1sUA0vT6lh6j1yAgGdHlYefng8ObMJUIqb+tFcpyetPVAebsGADHEDWOTZ4/?=
 =?us-ascii?q?LRkpaOW299OzcXrBmJkSiz6KP3VzyR3hIlWTtJxrs4tUjp+jaJnpmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686813"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:57 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 254EA4D17198;
        Fri,  3 Jun 2022 13:37:52 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:51 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:52 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 13/14] xfs: support CoW in fsdax mode
Date:   Fri, 3 Jun 2022 13:37:37 +0800
Message-ID: <20220603053738.1218681-14-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 254EA4D17198.A0CE1
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

In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
After that, new allocated extents needs to be remapped to the file.
So, add a CoW identification in ->iomap_begin(), and implement
->iomap_end() to do the remapping work.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 33 ++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iomap.c | 30 +++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |  1 +
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a60632ecc3f0..07ec4ada5163 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -25,6 +25,7 @@
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
 
+#include <linux/dax.h>
 #include <linux/falloc.h>
 #include <linux/backing-dev.h>
 #include <linux/mman.h>
@@ -669,7 +670,7 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -1254,6 +1255,31 @@ xfs_file_llseek(
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
 
+#ifdef CONFIG_FS_DAX
+int
+xfs_dax_fault(
+	struct vm_fault		*vmf,
+	enum page_entry_size	pe_size,
+	bool			write_fault,
+	pfn_t			*pfn)
+{
+	return dax_iomap_fault(vmf, pe_size, pfn, NULL,
+			(write_fault && !vmf->cow_page) ?
+				&xfs_dax_write_iomap_ops :
+				&xfs_read_iomap_ops);
+}
+#else
+int
+xfs_dax_fault(
+	struct vm_fault		*vmf,
+	enum page_entry_size	pe_size,
+	bool			write_fault,
+	pfn_t			*pfn)
+{
+	return 0;
+}
+#endif
+
 /*
  * Locking for serialisation of IO during page faults. This results in a lock
  * ordering of:
@@ -1285,10 +1311,7 @@ __xfs_filemap_fault(
 		pfn_t pfn;
 
 		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
-				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
-				 &xfs_read_iomap_ops);
+		ret = xfs_dax_fault(vmf, pe_size, write_fault, &pfn);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5a393259a3a3..4c07f5e718fb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -773,7 +773,8 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode,
+				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 		if (shared)
@@ -867,6 +868,33 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_dax_write_iomap_end(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			length,
+	ssize_t			written,
+	unsigned		flags,
+	struct iomap		*iomap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (!xfs_is_cow_inode(ip))
+		return 0;
+
+	if (!written) {
+		xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		return 0;
+	}
+
+	return xfs_reflink_end_cow(ip, pos, written);
+}
+
+const struct iomap_ops xfs_dax_write_iomap_ops = {
+	.iomap_begin	= xfs_direct_write_iomap_begin,
+	.iomap_end	= xfs_dax_write_iomap_end,
+};
+
 static int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index e88dc162c785..c782e8c0479c 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -51,5 +51,6 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.36.1



