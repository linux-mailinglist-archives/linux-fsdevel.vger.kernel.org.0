Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334D53C489
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiFCFiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiFCFiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:38:03 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84CA736E02;
        Thu,  2 Jun 2022 22:37:59 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A7GZ1wKpA0vCFoqopwef8e4enTq1eBmKKZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmJJXjiAa/3YMGPwf4x/OY3ioUhUscSDyd5mGgM//HtmQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbPkR2YIyKwqxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFoh8ImLcDsPI43umxp0jzYS/0hRPjrQ67Kzd5e0?=
 =?us-ascii?q?i05is1HEbDZfcVxQSVuaBDRSxxJNE0eBJ83kKGvnHaXWzFRrhSX47U252zSxQl?=
 =?us-ascii?q?q+LnrLNfRPNeNQK19kkSHoWTJ12f0GBcXMJqY0zXt2natgPLf2Cb+cIEMHba7s?=
 =?us-ascii?q?PlwjzW7z28LDTUSVF2msby3jVO4V9tDKksSvC00osAa8lKnT9z4dxm5u2Kf+Bo?=
 =?us-ascii?q?dXcdAVeE39mmlyqHUywKCGi4IQ1ZpbtUhpcZwRTsw11CUlNPoLTpiu/ueTnf13?=
 =?us-ascii?q?rWdqz70MigIBWgYbCQAQE0O5NyLiJs8iRbDUcdlOLWoldCzEjb1qxiQoy86i6o?=
 =?us-ascii?q?Ci+YQyr62u1zK6xqop57UXks7/QnaQG+hxh12aZTjZIGy71Xfq/FaI+6xSliHo?=
 =?us-ascii?q?WhBmMWE6u0KJY+CmTbLQ+gXGrytofGfP1X0hV9pAolk5zq202CscJoW4zxkIkp?=
 =?us-ascii?q?tdMEedlfBfk7JvitD6ZlSIj2ubKlqc8S2Ects0KuIKDhPfpg4dfIXOt4oKlDBp?=
 =?us-ascii?q?3ooOCatM6nWuBBEuckC1V2zLa5A1UonNJk=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Afx5yFalkNlPs+lSUOqotSO2EDFbpDfLI3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV8sjzsiWE7gr5OUtQ4OxoV5PhfZqxz/JICMwqTNKftWrdyQ?=
 =?us-ascii?q?yVxeNZnOjfKlTbckWUnINgPOVbAsxD4bbLbGSS4/yU3ODBKadD/DCYytHUuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcbKBJb6a0145WoSa6Y3QLYoCeDnkBZeLKoN?=
 =?us-ascii?q?rGj9bIehgDbiRXkjWmvHe57qLgCRiE0lM7WzNL+70r9m/IiEjYy8yYwomG9iM?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686814"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:57 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4D0954D17189;
        Fri,  3 Jun 2022 13:37:51 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:51 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:51 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/14] fsdax: Dedup file range to use a compare function
Date:   Fri, 3 Jun 2022 13:37:36 +0800
Message-ID: <20220603053738.1218681-13-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4D0954D17189.AF8B8
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

With dax we cannot deal with readpage() etc. So, we create a dax
comparison function which is similar with
vfs_dedupe_file_range_compare().
And introduce dax_remap_file_range_prep() for filesystem use.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c             | 82 ++++++++++++++++++++++++++++++++++++++++++++
 fs/remap_range.c     | 31 ++++++++++++++---
 fs/xfs/xfs_reflink.c |  8 +++--
 include/linux/dax.h  |  8 +++++
 include/linux/fs.h   | 12 ++++---
 5 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 24d8b4f99e98..cda43a819509 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1873,3 +1873,85 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
+		struct iomap_iter *it_dest, u64 len, bool *same)
+{
+	const struct iomap *smap = &it_src->iomap;
+	const struct iomap *dmap = &it_dest->iomap;
+	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
+	void *saddr, *daddr;
+	int id, ret;
+
+	len = min(len, min(smap->length, dmap->length));
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
+		.flags		= IOMAP_DAX,
+	};
+	struct iomap_iter dst_iter = {
+		.inode		= dst,
+		.pos		= dstoff,
+		.len		= len,
+		.flags		= IOMAP_DAX,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
+		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
+			dst_iter.processed = dax_range_compare_iter(&src_iter,
+						&dst_iter, len, same);
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
index e112b5424cdb..231de627c1b9 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -271,9 +272,11 @@ static int vfs_dedupe_file_range_compare(struct file *src, loff_t srcoff,
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
@@ -333,8 +336,18 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		ret = vfs_dedupe_file_range_compare(file_in, pos_in,
-				file_out, pos_out, *len, &is_same);
+		if (*len == 0)
+			return 0;
+
+		if (!IS_DAX(inode_in))
+			ret = vfs_dedupe_file_range_compare(file_in, pos_in,
+					file_out, pos_out, *len, &is_same);
+		else if (dax_read_ops)
+			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
+					inode_out, pos_out, *len, &is_same,
+					dax_read_ops);
+		else
+			return -EINVAL;
 		if (ret)
 			return ret;
 		if (!is_same)
@@ -352,6 +365,14 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
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
index e7a7c00d93be..cbaf36d21020 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1367,8 +1367,12 @@ xfs_reflink_remap_prep(
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
index 7116681b48c0..ba985333e26b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -246,6 +246,14 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
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
index 01403e637271..e742ec02501e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -74,6 +74,7 @@ struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
+struct iomap_ops;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2072,10 +2073,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
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
2.36.1



