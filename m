Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA43730F0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhBDKdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:33:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhBDKcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434719; x=1643970719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KLkL2AWrGTi+ws9K4W3t0t/UhjMtLj661XQYJKwob+s=;
  b=IWC2hH9AQclR75Qlnw5u1ZIrTlVbex+ytzrFYy2gQS0CyDD0+/8SENR/
   R9h3BksGZEa3n28SgXNWMdfjTdltNPQJ8d7MDOhQnqXYXQE3scgkmEC1A
   rVoFjEHq+H7fpK/Oo/LKYIIHY+07Nu+etSNxcyEZz3RD+aEMTudV5GRH6
   aBa14YvsfSyBmWshqc3L9KYmLxVSpJEY7Zq3bdoeO7fXZ/JTdtIs5l3YT
   e6++1DP2yqdWW9CfMx9pBUX8AHebooyx9rGA+YP5WWRhFS0OD0dLCjAM5
   MO2diJnGtJLAf5YiRCUjeLOLpmuIyyVSwyiv2ssTQq7ys9w1yrpRZmmrg
   A==;
IronPort-SDR: NsDyR1QyQNeYedLjM9/w4JVauuWWCWbVaR1OjzpuHhEV8Dcgf9tjJ1rBjymvjVvCodkNrdQB9e
 Guba8quDBtKLJ8PgBBru8yWX/wZQlBG/I4VxJZqfHz++/3WaG8+7NIQIeUwMIxneSgOkAVCR45
 cfWAIF/Bggpk+lTGw7FRuqs+jVb9Xje2N5pQ+HQbpiAXPCBlx9UxOX0Ra+4nvFroFkT+xIKxnx
 nuVNAc1sh/hbTsW1cVPRLmTTpJ7yAT7a4Mj2E1bY4mlVYWACa7CRC1Z5t+H+f58PJoLCGcuQsh
 gfI=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108072"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:49 +0800
IronPort-SDR: vfSDxjRoh/22FIssY2nKhVWi8h1TXWGpRm/t3L8pUFpLMngJLyW48ab4TuDnvT09jyZyZ3Fv2n
 22jmp2KsKFMjqO6RILRuGpipnzeuTBRQAaP5S1+a4yG203wJBzrW0Ao7CpcS6lsRCwSvDWyBxp
 4oofsCbt1doaTkgGCMRpMxPCgPv7Z0cjwZFJ3PnP7dNgQinNxCacvDrt5i+g/VvJTMPeni6TkN
 6eW7/gu1YUpyUfUJbduGz84tIsMbEJeCgI4k0V1xKn4E1dY8SnnXSRW4budVhoa1j8kPSnFBVZ
 53LoqFCG52j0/8yUYnFL/jG5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:53 -0800
IronPort-SDR: dbEnZ+0eEluMvQcxs04bCOodQC3HxVeoHwQ7vA34FKs0wiUtVUcifCp/gmOhYK1s53RdSt+iuL
 peXYadsYQyFuHwpwhvq2xsGZWGy99U9l9PCsoE8FXYduw/KnR8vsIHxgLuq104jB4W5b6QBCQj
 yxJ2tMMXw8QJRTZJ6f7wJvHIsX4LBBcRkPb+kRnAS9VgkpH6+EASesBhSg9IAZIgN0BfY3GJJL
 BMDfwq5CYl8ar2N5h6waeZl/gc29W8MKHGjAQxdjUT1gm1GokhDJyJePJ1dDV+5LoTylxrFTBg
 YeQ=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 39/42] btrfs: zoned: extend zoned allocator to use dedicated tree-log block group
Date:   Thu,  4 Feb 2021 19:22:18 +0900
Message-Id: <4a02c3ff283a1c2d71bfa3b0a7135b062af7385e.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/3 patch to enable tree log on zoned filesystems.

The tree-log feature does not work on a zoned filesystem as is. Blocks for
a tree-log tree are allocated mixed with other metadata blocks and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which has a different timing than a global transaction commit. As a
result, both writing tree-log blocks and writing other metadata blocks
become non-sequential writes that zoned filesystems must avoid.

Introduce a dedicated block group for tree-log blocks, so that tree-log
blocks and other metadata blocks can be separate write streams.  As a
result, each write stream can now be written to devices separately.
"fs_info->treelog_bg" tracks the dedicated block group and btrfs assigns
"treelog_bg" on-demand on tree-log block allocation time.

This commit extends the zoned block allocator to use the block group.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  2 ++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent-tree.c | 75 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       | 14 ++++++++
 5 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f5e9f560ce6d..5064be59dac5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -901,6 +901,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&cluster->refill_lock);
 
+	btrfs_clear_treelog_bg(block_group);
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1bb4f767966a..6f4b493625ef 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -976,6 +976,8 @@ struct btrfs_fs_info {
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d2fa92526b3b..84c6650d5ef7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2787,6 +2787,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->super_lock);
 	spin_lock_init(&fs_info->buffer_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
+	spin_lock_init(&fs_info->treelog_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e2b2abc42295..f8e8c17e5624 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3497,6 +3497,9 @@ struct find_free_extent_ctl {
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
+	/* Allocation is called for tree-log */
+	bool for_treelog;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -3725,6 +3728,22 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Tree-log block group locking
+ * ============================
+ *
+ * fs_info::treelog_bg_lock protects the fs_info::treelog_bg which
+ * indicates the starting address of a block group, which is reserved only
+ * for tree-log metadata.
+ *
+ * Lock nesting
+ * ============
+ *
+ * space_info::lock
+ *   block_group::lock
+ *     fs_info::treelog_bg_lock
+ */
+
 /*
  * Simple allocator for sequential only block group. It only allows sequential
  * allocation. No need to play with trees. This function also reserves the
@@ -3734,23 +3753,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct find_free_extent_ctl *ffe_ctl,
 			       struct btrfs_block_group **bg_ret)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
 	u64 avail;
+	u64 bytenr = block_group->start;
+	u64 log_bytenr;
 	int ret = 0;
+	bool skip;
 
 	ASSERT(btrfs_is_zoned(block_group->fs_info));
 
+	/*
+	 * Do not allow non-tree-log blocks in the dedicated tree-log block
+	 * group, and vice versa.
+	 */
+	spin_lock(&fs_info->treelog_bg_lock);
+	log_bytenr = fs_info->treelog_bg;
+	skip = log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
+			      (!ffe_ctl->for_treelog && bytenr == log_bytenr));
+	spin_unlock(&fs_info->treelog_bg_lock);
+	if (skip)
+		return 1;
+
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
+	spin_lock(&fs_info->treelog_bg_lock);
+
+	ASSERT(!ffe_ctl->for_treelog ||
+	       block_group->start == fs_info->treelog_bg ||
+	       fs_info->treelog_bg == 0);
 
 	if (block_group->ro) {
 		ret = 1;
 		goto out;
 	}
 
+	/*
+	 * Do not allow currently using block group to be tree-log dedicated
+	 * block group.
+	 */
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
+	    (block_group->used || block_group->reserved)) {
+		ret = 1;
+		goto out;
+	}
+
 	avail = block_group->length - block_group->alloc_offset;
 	if (avail < num_bytes) {
 		if (ffe_ctl->max_extent_size < avail) {
@@ -3765,6 +3815,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3779,6 +3832,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4028,7 +4084,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		/* Nothing to do */
+		if (ffe_ctl->for_treelog) {
+			spin_lock(&fs_info->treelog_bg_lock);
+			if (fs_info->treelog_bg)
+				ffe_ctl->hint_byte = fs_info->treelog_bg;
+			spin_unlock(&fs_info->treelog_bg_lock);
+		}
 		return 0;
 	default:
 		BUG();
@@ -4072,6 +4133,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4085,6 +4147,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4159,8 +4222,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		struct btrfs_block_group *bg_ret;
 
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro))
+		if (unlikely(block_group->ro)) {
+			if (for_treelog)
+				btrfs_clear_treelog_bg(block_group);
 			continue;
+		}
 
 		btrfs_grab_block_group(block_group, delalloc);
 		ffe_ctl.search_start = block_group->start;
@@ -4346,6 +4412,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4369,8 +4436,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-				  "allocation failed flags %llu, wanted %llu",
-				  flags, num_bytes);
+			"allocation failed flags %llu, wanted %llu tree-log %d",
+				  flags, num_bytes, for_treelog);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 932ad9bc0de6..61e969652fe1 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include "volumes.h"
 #include "disk-io.h"
+#include "block-group.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -290,4 +291,17 @@ static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
 	mutex_unlock(&fs_info->zoned_meta_io_lock);
 }
 
+static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	spin_lock(&fs_info->treelog_bg_lock);
+	if (fs_info->treelog_bg == bg->start)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
+}
+
 #endif
-- 
2.30.0

