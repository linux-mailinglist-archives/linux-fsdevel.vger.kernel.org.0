Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6C51EE41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiEHOks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiEHOkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 10:40:43 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25488101E8;
        Sun,  8 May 2022 07:36:38 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A67OTtqrXk3vGNlpS4cq9wbADwQZeBmLAZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmZKDT2DbqyPYzSgKdwjbNi28RkDvJPWmoNkG1dlqSAyQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbPlxKbLCa0qxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFoh8ImLcDsPI43umxp0jzYS/0hRPjrQ67Kzd5e0?=
 =?us-ascii?q?i05is1HEbDZfcVxQSVuaBDRSxxJNE0eBJ83kKGvnHaXWzFRrhSX47U252zSxQl?=
 =?us-ascii?q?q+LnrLNfRPNeNQK19kkSHoWTJ12f0GBcXMJqY0zXt2natgPLf2Cb+cIEMHba7s?=
 =?us-ascii?q?PlwjzW7wHIfCRgTfV+6uuWizEq/Xc9PbUAZ5EIGq6E15UXtTt7nXhKlq36Flhg?=
 =?us-ascii?q?RUJxbFOhSwAOEzKeS6AaELm8eRzVFZZots8pebSYl0VuFgMLvLSdyq7DTRX/13?=
 =?us-ascii?q?rOVqy6ifCYOIWIcaCssUwQI+Z/grZs1gxaJScxseIaxj9voCXTzziqMoSwWmbo?=
 =?us-ascii?q?el4gI2r+98FSBhCijzrDNTwgo9kDHUHmN8Ax0fsimapau5Fyd6uxPRK6HT0OGl?=
 =?us-ascii?q?GoJncmAquQPC4yd0iuXT6MQH9mUC1ytWNHHqQc3WcB/qHL2oDj+Fb28KQpWfC9?=
 =?us-ascii?q?BWvvosxe1CKMLhT5s2Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AUL8onK5TuglLwacnBQPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124075750"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 May 2022 22:36:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id F31414D17197;
        Sun,  8 May 2022 22:36:32 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 8 May 2022 22:36:36 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 8 May 2022 22:36:31 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>
Subject: [PATCH v11 06/07] xfs: support CoW in fsdax mode
Date:   Sun, 8 May 2022 22:36:19 +0800
Message-ID: <20220508143620.1775214-14-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F31414D17197.AEC13
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
 fs/xfs/xfs_file.c  |  7 ++-----
 fs/xfs/xfs_iomap.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |  3 +++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index af954a5b71f8..5a4508b23b51 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -669,7 +669,7 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -1285,10 +1285,7 @@ __xfs_filemap_fault(
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
index 5a393259a3a3..e35842215d22 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,7 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "linux/dax.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -773,7 +774,8 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode,
+				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 		if (shared)
@@ -867,6 +869,33 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
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
@@ -1358,3 +1387,18 @@ xfs_truncate_page(
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
+
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
+#endif
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index e88dc162c785..89dfa3bb099f 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -25,6 +25,8 @@ int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
 int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
+int xfs_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
+		bool write_fault, pfn_t *pfn);
 
 static inline xfs_filblks_t
 xfs_aligned_fsb_count(
@@ -51,5 +53,6 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.35.1



