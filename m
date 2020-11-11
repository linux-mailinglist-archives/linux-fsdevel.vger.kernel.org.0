Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9042AE7B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 05:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKE62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 23:58:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7733 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKE6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071575; x=1636607575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqFHGmfrUYEfeGAKDiO6RWz5s6RQ0CjyJ/pBnGI/8fE=;
  b=Gk39tE1SpVYO3zwrKPvZ5hxQeYdAng56FmCwBO/DOD+RXEjnJ4xH3kbc
   csMh+NyTPCIdUxYn5KlxgwbCaaVrUmuPn8SPU8FUPqUgZFbXzVp9xgpzq
   uJ6A5MGrPGBYt+LUPqclFCSp8agsV/4x3K04pI97lCFxtbkj2bw9texN7
   nY63TVpK44+ap/H6nJ9PNAt090G0sevo+jTLcP0PUqfTS9xpWwiGjNbeJ
   xCNsjVUHkszpveDsaXwzv0Omwoc1aST/K0revLGLYqnPgxl6+ysPembmA
   WofZnGgkGkppUJTUreyYF7mLjfFUMuuEkJtyLFEKD8oqbzk66Un8gezTp
   A==;
IronPort-SDR: 6s6SbmYZL4iyG1yZuTZuIQsOdG52ESkIvkB2ElZ6HR2onLmsO3e6ByCuq3TjfG4foPXprHm2wn
 HC4uqMiCp+EagiE3cfMY3GD8Dn4PmPTkOdd/qeVN4ZkfHu5cLsYRDJPGS2O+whQf/EoFQwvkU5
 P/aW8slorBX/nroaw+xM9wUAj9hEUCvNQQGJEW48p3LXfgLIRf3FPPbdUykCG1tODSmNOg1Gwo
 tP5juMQx+m/bgMUMq+5MxN0n9Y/WyXiQB12UFUSWe1GaXRb4dA9RXYHYZs60azF/3eczWiUZu7
 42Q=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255915038"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:12:55 +0800
IronPort-SDR: a83Nc3Sd6+QQcEOAOVLSGLC1heC85o7THEa9sCcDq+Eu4TjVIa6Wi+4s+CcENyJ833adMeKgRb
 08I2r7FI31wvXRox66lCCdbL7APCDye0YZDsQV3W6UaVoCAAMSlJrMHB2My/xQ8P0CEoPfk5W/
 JInyt6cH3HGRLLg5Z/fWeZechvvCeYrWXjaTi6+l8fq4rmn9lPEwddss7wsj/pSV9NvAB2563i
 EDurMzWHz0OCsVJP8HJ7v5lU5eno3tS57VPqU+wfGhjTWjhji/ieiwK8fU9Kw0BVJRURjPLkJF
 09FTZnalTTZRExsnY16LtNO+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 20:43:09 -0800
IronPort-SDR: OkC3xAtQ/W5QNBZxOIHpEwUQWZnofUScCp4tu/lwOVgKMiTG44N0ZfjDWv3mKX1T6otCk9SsoY
 fBt+TOZL5Wm6PbZiHtO+G6KB/dGz1oFaWa7TC3/vWVTgc5LFO+9xxoM2ZzA8sH+CN31XvEJNZ+
 RvsrLgrtc/wpNmhcULCgK+mXyCyvpCJOv+Laboi8mUd/zFlpivL1OOQFApp6/roz0Tov/oMGyH
 syosu/SqCC/qF4mhwcWT84oM0aiYsar5qGGRjBla/6Zb3LVzU8+1cnJuBdfZ6rZN3rrkmXIiKd
 Lv8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 20:58:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10.1 38/41] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Wed, 11 Nov 2020 13:58:08 +0900
Message-Id: <3d5be9c64060efb3b976e0288befad965b599269.1605070255.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <551fecb79909221d640f9d6d08f5ccc8487717be.1605007037.git.naohiro.aota@wdc.com>
References: <551fecb79909221d640f9d6d08f5ccc8487717be.1605007037.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/3 patch to enable tree log on ZONED mode.

The tree-log feature does not work on ZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing from a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes that ZONED mode must avoid.

We can introduce a dedicated block group for tree-log blocks so that
tree-log blocks and other metadata blocks can be separated write streams.
As a result, each write stream can now be written to devices separately.
"fs_info->treelog_bg" tracks the dedicated block group and btrfs assign
"treelog_bg" on-demand on tree-log block allocation time.

This commit extends the zoned block allocator to use the block group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  7 ++++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent-tree.c | 79 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 4 deletions(-)

I forgot to merge a patch to add the lock description...

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 04bb0602f1cc..d222f54eb0c1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -939,6 +939,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&cluster->refill_lock);
 
+	if (btrfs_is_zoned(fs_info)) {
+		spin_lock(&fs_info->treelog_bg_lock);
+		if (fs_info->treelog_bg == block_group->start)
+			fs_info->treelog_bg = 0;
+		spin_unlock(&fs_info->treelog_bg_lock);
+	}
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8138e932b7cc..2fd7e58343ce 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -957,6 +957,8 @@ struct btrfs_fs_info {
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2ee21076b641..f50eea392b2f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3631,6 +3631,9 @@ struct find_free_extent_ctl {
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
+	/* Allocation is called for tree-log */
+	bool for_treelog;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -3859,6 +3862,22 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Tree-log Block Group Locking
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
  * Simple allocator for sequential only block group. It only allows
  * sequential allocation. No need to play with trees. This function
@@ -3868,23 +3887,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
 		ffe_ctl->max_extent_size = avail;
@@ -3892,6 +3942,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3906,6 +3959,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4155,7 +4211,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		/* nothing to do */
+		if (ffe_ctl->for_treelog) {
+			spin_lock(&fs_info->treelog_bg_lock);
+			if (fs_info->treelog_bg)
+				ffe_ctl->hint_byte = fs_info->treelog_bg;
+			spin_unlock(&fs_info->treelog_bg_lock);
+		}
 		return 0;
 	default:
 		BUG();
@@ -4199,6 +4260,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4212,6 +4274,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4286,8 +4349,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		struct btrfs_block_group *bg_ret;
 
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro))
+		if (unlikely(block_group->ro)) {
+			if (btrfs_is_zoned(fs_info) && for_treelog) {
+				spin_lock(&fs_info->treelog_bg_lock);
+				if (block_group->start == fs_info->treelog_bg)
+					fs_info->treelog_bg = 0;
+				spin_unlock(&fs_info->treelog_bg_lock);
+			}
 			continue;
+		}
 
 		btrfs_grab_block_group(block_group, delalloc);
 		ffe_ctl.search_start = block_group->start;
@@ -4475,6 +4545,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4498,8 +4569,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-				  "allocation failed flags %llu, wanted %llu",
-				  flags, num_bytes);
+			"allocation failed flags %llu, wanted %llu treelog %d",
+				  flags, num_bytes, for_treelog);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
-- 
2.27.0

