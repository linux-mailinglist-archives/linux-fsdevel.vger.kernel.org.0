Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5752FFCDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAVGc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:32:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51100 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbhAVGaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611297021; x=1642833021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ty3y61SAJAsARvaP7frpCCbEjnIreuR4z9tvb2Zs4vY=;
  b=L6vwW9HKtL5iEbI0kkji5HtnlyPL26oLM0brcKWpImG6GAQf3r/7u8pz
   oXI9d+HoocRJVf0SpYfcHs9WRVJnl5ImFUpmmTI8HsRGO9s6TiQUu185N
   EPjG15u4TLEfq65zKbjR9Am5peQnaQL255wJc0PP8reDD2bJXLavTBQE1
   jf/LFZ37N38xntsLUasxBMkvB1YGCxYnkSuaQQdtqmSCUdZ707qHQ9eWN
   QkzcMUIsASEn6CL5ubCakw0r0a/LItq3HAcum11+s43MKekujSGF9DyNB
   WXC60OuaodrWo8sA2GVOxV4n75KoeMQklULLh0Evxc2F5JWCvsOipl9m2
   A==;
IronPort-SDR: Ae3Qcncs7Z+tI8xebCYRvCtPThMC0f/wUcTMgXbP/phdSko1TS1IoZqgaxOMvNZAtHQbp1IcMs
 X3G8hhEc4JRw4mLyPmuCIsvMJK0E/Wh0TrNjF19OSQYtsqKPg37ZMZhS3INnbYoX4VgzP2gSfo
 ybNiNLKtn7lGsmmazH+Dvsiaxa8d9rKLsFwGVsuxPtQy3Ock6SJD4rnE1uR/YazsY0KsYoGDIy
 ekbLWbrGBfu8DEm7wkK1l5U/EmeOlcZUGswcIZS+wOmlH/cPSb6It32u8nt6uQ8OrNvD3M55u9
 lVk=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392098"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:27 +0800
IronPort-SDR: Xvu3r79PEYMiKXIcTPmZA90ogupFY8Le7aL7v5j53W3VCdxA/S+7+cXsbLOGXgzSKKSyHAjet8
 KH9T6XG4/tKHA5Kq9Ivgki934Cy0SpMUT+bcMc8CdcqxmF/kJqbDiU13gbB27wD0GfLBEyV0zB
 MZHrGm3sa1CTqDwkG3XTHL1bp1XLHRXQWV6p+HrA7tZv3aIoJVojHhEf+VTZ3A4OhOpHhEQasY
 /lbHLgnJIG3Upo7UTWZNDbmRquFWc6l/QFBeMp63qUpbUGzo9m5klCQXvG3tNFyrzi9Q33Feyb
 Q0rHkm7bPjOwElVR1BvvV6j0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:59 -0800
IronPort-SDR: xU5zYB/dqIp8e1EXULOw0Q2d8pKhN6MEnK6UmqWGn/J2VpEhJ1kInhhz2kzwWKYDkOdXA2ZPqK
 3h24z3KNTVGHt4xWt/z66h+NCHEJNO8gDAsEQ6hBAfAC76TdGgy4RO7xNd+Ev5bHfT15cwE53M
 WyMXklO7CsG4JMUpkhgkyt9XXInLqh6mhyEMafuCn5G+8Rx055yInb/mIYDw+Z3rKN3z8Szczn
 NWYVH323I+v3rxOUt7k9pc0osHYLp8bjZ6APm6k/NgueOcsXPydEg17msyi1EOGRs0eDcyXFfl
 8v4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 40/42] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Fri, 22 Jan 2021 15:21:40 +0900
Message-Id: <4449f11b454278c57ffd6592b634012675b1539b.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 56fab3d490b0..9f768c81d464 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -893,6 +893,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&cluster->refill_lock);
 
+	btrfs_clear_treelog_bg(block_group);
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e9c55171ddb..2deb34a8d65d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -973,6 +973,8 @@ struct btrfs_fs_info {
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2e2f09a46f45..c3b5cfe4d928 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2722,6 +2722,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->super_lock);
 	spin_lock_init(&fs_info->buffer_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
+	spin_lock_init(&fs_info->treelog_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1317f5d61024..fe8f1211f74c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3590,6 +3590,9 @@ struct find_free_extent_ctl {
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
+	/* Allocation is called for tree-log */
+	bool for_treelog;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -3818,6 +3821,22 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
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
@@ -3827,23 +3846,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
@@ -3858,6 +3908,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3872,6 +3925,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4121,7 +4177,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
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
@@ -4165,6 +4226,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4178,6 +4240,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4252,8 +4315,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
@@ -4441,6 +4507,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4464,8 +4531,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-				  "allocation failed flags %llu, wanted %llu",
-				  flags, num_bytes);
+			"allocation failed flags %llu, wanted %llu treelog %d",
+				  flags, num_bytes, for_treelog);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 8c203c0425e0..52789da61fa3 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include "volumes.h"
 #include "disk-io.h"
+#include "block-group.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -292,4 +293,17 @@ static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
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
2.27.0

