Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387DA52299E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 04:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiEKCZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiEKCZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 22:25:24 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CC7B1FD870;
        Tue, 10 May 2022 19:25:22 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AWvaHDKjfMAqDRRwuS/2JfpYUX161jBEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUPm2QfCzuGMquLZGKkLdEjbIrgpkoH68ODx99iGwdl/nw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl7ZXPlRGZLhMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTTuhqg8UqK8nmFIMCs25tzHfSCvNOaZDIQ43L49FC1?=
 =?us-ascii?q?Ts9j8wIGuzRD+IGaD5rfTzBZRNVM1saAZ54m/2n7lHzejseqhSKpK4z4mHW1yR?=
 =?us-ascii?q?w1qTgNJzefdnibclXgUGeqUrF8n7/DxVcM8aQoRKB83SxlqrKmAv4RosZF/u/7?=
 =?us-ascii?q?PECqFuNym0WDTUSVECnur+9i0ijS5RTJlJ80iolrYA271DtQtSVdxuxp2+N+B4?=
 =?us-ascii?q?bQdtfDuY66SmLx6GS6AGcbkAGRzhMLtcmqecxXzUh0lLPlNTsbRR1v7qRRW2M8?=
 =?us-ascii?q?J+PsCi/fyQYRUcGZCkZXU4L+NXuvow3pgzAQ8wlE6OviNDxXzbqzFiiqCk4mqV?=
 =?us-ascii?q?WjsMR0ai/1U7IjijqpZXTSAMxoALNUQqN6gJ/eZ7gd4KzwUbU4OwGL4uDSFSF+?=
 =?us-ascii?q?n8elKC28uEUCrmfmSqMXqMJHbe097CCKjKanF0HInWL31xB4Fb6JcYJvm44fxw?=
 =?us-ascii?q?vb645lfbSSBe7kWtsCFV7ZhNGtZNKXr8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2gRIpqywAbaW80CDHsAHKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124142475"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2022 10:25:21 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1CE594D1718C;
        Wed, 11 May 2022 10:25:20 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:25:18 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:25:19 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 11 May 2022 10:25:17 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11.1 06/07] xfs: support CoW in fsdax mode
Date:   Wed, 11 May 2022 10:25:17 +0800
Message-ID: <20220511022517.2087361-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508143620.1775214-14-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-14-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1CE594D1718C.A0FAA
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 33 ++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iomap.c | 30 +++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |  1 +
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index af954a5b71f8..fe9f92586acf 100644
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
2.35.1



