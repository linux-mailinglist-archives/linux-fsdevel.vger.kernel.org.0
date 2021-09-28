Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FB41A8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhI1GZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:25:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6259 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239046AbhI1GZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:37 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Asp8ECaCx63XSOxVW/z3iw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fUAi90DIng2cPyjRJWz2CP6zbMGShL9l1PYqz8h5T7ZCAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkExcwmj/3auK49SgmhfnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPAeqeGWcCLXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRg+Cg+an6LO9RPNliskqII/sJox3kn1py3fbS+knRZTCSqDRzd5ew?=
 =?us-ascii?q?Do0wMtJGJ72a8gGbjxgRBfNeRtCPhEQEp1WtOG2inj6dhVcqUmJvuwz4m7O3Ep?=
 =?us-ascii?q?93aaFGNreevSOXtkTkkvwjnjJ+GD1HQAcHMeC0jfD+XWp7sfVkiT/VJ0DEpWj6?=
 =?us-ascii?q?+VnxlGerkQXCRsLRR61uvW0lEO6c8xQJlZS+Sc0q6U2skuxQbHVWxy+vW7BvRM?=
 =?us-ascii?q?GXddUO/M15RvLyafO5QudQG8eQVZpbN0gqd9zVTIx/kGGksmvBjF1trCRD3WH+?=
 =?us-ascii?q?d+8szKoPgAHIGkDe2kATA0Y85/kuo51kxGnczrJOMZZlfWsQXepnW/M93N42t0?=
 =?us-ascii?q?uYQcw//3T1Tj6b/iE+/AlljII2zg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+ndMYa+/Vyx4i/19hdJuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="115096992"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Sep 2021 14:23:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B42E04D0DC7C;
        Tue, 28 Sep 2021 14:23:45 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:44 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Sep 2021 14:23:43 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v10 6/8] fsdax: Dedup file range to use a compare function
Date:   Tue, 28 Sep 2021 14:23:09 +0800
Message-ID: <20210928062311.4012070-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B42E04D0DC7C.A14E7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With dax we cannot deal with readpage() etc. So, we create a dax
comparison function which is similar with
vfs_dedupe_file_range_compare().
And introduce dax_remap_file_range_prep() for filesystem use.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c             | 79 ++++++++++++++++++++++++++++++++++++++++++++
 fs/remap_range.c     | 31 ++++++++++++++---
 fs/xfs/xfs_reflink.c |  8 +++--
 include/linux/dax.h  |  8 +++++
 include/linux/fs.h   | 12 ++++---
 5 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5379de8ad0c7..e45944251956 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1815,3 +1815,82 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
+		struct iomap_iter *it_dest, bool *same)
+{
+	const struct iomap *smap = &it_src->iomap;
+	const struct iomap *dmap = &it_dest->iomap;
+	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
+	loff_t len = min(smap->length, dmap->length);
+	void *saddr, *daddr;
+	int id, ret;
+
+	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
+		*same = true;
+		return len;
+	}
+
+	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
+		*same = false;
+		return 0;
+	}
+
+	id = dax_read_lock();
+	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
+				      &saddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
+				      &daddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	*same = !memcmp(saddr, daddr, len);
+	if (!*same)
+		len = 0;
+	dax_read_unlock(id);
+	return len;
+
+out_unlock:
+	dax_read_unlock(id);
+	return -EIO;
+}
+
+int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+		struct inode *dst, loff_t dstoff, loff_t len, bool *same,
+		const struct iomap_ops *ops)
+{
+	struct iomap_iter src_iter = {
+		.inode		= src,
+		.pos		= srcoff,
+		.len		= len,
+	};
+	struct iomap_iter dst_iter = {
+		.inode		= dst,
+		.pos		= dstoff,
+		.len		= len,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
+		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
+			dst_iter.processed = dax_range_compare_iter(&src_iter,
+						&dst_iter, same);
+		}
+		if (ret <= 0)
+			src_iter.processed = ret;
+	}
+	return ret;
+}
+
+int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+			      struct file *file_out, loff_t pos_out,
+			      loff_t *len, unsigned int remap_flags,
+			      const struct iomap_ops *ops)
+{
+	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
+					       pos_out, len, remap_flags, ops);
+}
+EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 6d4a9beaa097..1157169b9d79 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -277,9 +278,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
  * If there's an error, then the usual negative error code is returned.
  * Otherwise returns 0 with *len set to the request length.
  */
-int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  loff_t *len, unsigned int remap_flags)
+int
+__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				loff_t *len, unsigned int remap_flags,
+				const struct iomap_ops *dax_read_ops)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -339,8 +342,18 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
+		if (*len == 0)
+			return 0;
+
+		if (!IS_DAX(inode_in))
+			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
+					inode_out, pos_out, *len, &is_same);
+		else if (dax_read_ops)
+			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
+					inode_out, pos_out, *len, &is_same,
+					dax_read_ops);
+		else
+			return -EINVAL;
 		if (ret)
 			return ret;
 		if (!is_same)
@@ -358,6 +371,14 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 	return ret;
 }
+
+int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  loff_t *len, unsigned int remap_flags)
+{
+	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
+					       pos_out, len, remap_flags, NULL);
+}
 EXPORT_SYMBOL(generic_remap_file_range_prep);
 
 loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 76355f293488..7ecea0311e88 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1332,8 +1332,12 @@ xfs_reflink_remap_prep(
 	if (IS_DAX(inode_in) || IS_DAX(inode_out))
 		goto out_unlock;
 
-	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags);
+	if (!IS_DAX(inode_in))
+		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
+				pos_out, len, remap_flags);
+	else
+		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
+				pos_out, len, remap_flags, &xfs_read_iomap_ops);
 	if (ret || *len == 0)
 		goto out_unlock;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b6f5d0d30065..043b8008d8f4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -212,6 +212,14 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 s64 dax_iomap_zero(const struct iomap_iter *iter, loff_t pos, u64 length);
+int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+				  struct inode *dest, loff_t destoff,
+				  loff_t len, bool *is_same,
+				  const struct iomap_ops *ops);
+int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+			      struct file *file_out, loff_t pos_out,
+			      loff_t *len, unsigned int remap_flags,
+			      const struct iomap_ops *ops);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..670b53c722a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -71,6 +71,7 @@ struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
+struct iomap_ops;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2175,10 +2176,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
-extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-					 struct file *file_out, loff_t pos_out,
-					 loff_t *count,
-					 unsigned int remap_flags);
+int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    loff_t *len, unsigned int remap_flags,
+				    const struct iomap_ops *dax_read_ops);
+int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  loff_t *count, unsigned int remap_flags);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
-- 
2.33.0



