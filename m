Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1747E2AD526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgKJL3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12030 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbgKJL3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007781; x=1636543781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BLX9S8ivqjtwXHkCZxXvEU5pBlznLZ1k/tZ8n9x+nek=;
  b=CsuONGdwSuID80P7oMVgTPayjpu+6EwQep2uwr3wF6ZH+g3F5IJH5UBe
   re//5w4W1AnAoS8CywgTH2SZtuH8vSvtrofCeL7+YlhkHgh8Spc/6w+D1
   WZIV4UpiRes1SBG2Ic4YuEIu+A5MbNBYjmVkE4bxioorwZJfQzaUjZ8+K
   aLVC5nsZSOqlzJzu1J4YxYJDlBVrQPgEjlbJd4U+APLibjkfSBpdfJRGT
   hlM6pqMMDOyzitLcF7/7/euSEqOWnttCj7EAUGzd1uur+wwQZkJuonQZP
   OEtvbw6Pl4CcXnN1kfAHTo+CkJAA8BR6iH5U425RySw8ISaENCxSEDFSN
   A==;
IronPort-SDR: KR1xDRf0nS0ZCT9R6laF2Um2pkHFjts1Skxe4F92TmWzeGGr/fEs/w9IKsoknd/E6R7+zV3qmf
 bx2RVDpsQRfZYV0oyIYWRvjduoockWvwhwzB+2UOnpkGKCDqGDhVcGyYjRsxb47qKc8tBm76l+
 hYXZgJKOHR/3VfjBSBDjreth+RS4r2BhTnpX51Auo7V26nzvJO0PxjRZAMkdLHkDRcGzQ8zccM
 lzaByDFrHLa6U8RKiNZ9uMSz/350bmPUI8OMr4/bdosP/MZj4bIpLf+cFgPD+2aB2DxoKzzisM
 8us=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:07 +0800
IronPort-SDR: dgTax0kZpDGR/BmgFd9NHYJK98q94OZ/tK2CLR3HLBEif67QP+OnMDP+CBuJnV7bbwABjKbMM7
 DrQRTANMum+4wbt0F6Fr8/kj1PWwO6VKcp8M8zD2J9YENV1irIGw8/089ekMLD6aCqHrAwT5OO
 uGabLoAKp6q5Lx5cWQmvyHkCRvF7iw2TFY3qKQ9N/lx+Mc+Gt2jMsyrG0lyEH2MOK4sHPAZCYT
 zuoahmygtHbyXzi0l8r+v0vmEHtzShTJKppKya+MDbtOrLoqVoSleOiKjxjAn7OAnRrWzc3Et2
 dbYbdLObGXlZuIlELF9OsiQA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:08 -0800
IronPort-SDR: n8dr7va6Imbzj5evk/gyAip7XszNMSabmulilNkS8ZILXXj6VJOHXFn3GxCD40GH7xUYIBqjmU
 fA3N/keqAyFxJhRVljp06QOsnRyRNh17myoiOh4tlyMkGa0aINu8/V9sOFlf5absXMvYnu4jqk
 MAqufe8jjUEoIVxJgqBCCceUztk647CX3ERkO14V4ujIqLKfxR6do3djR7LeHz785nxGIxa6Oe
 GTKj8UaXrRnhQLbXoYJSJb8xDxbe57OYronzL/PjY3I4VwtrIwY+udm3AZgUEwvX0BPNt3Hv1H
 x3Q=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 38/41] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Tue, 10 Nov 2020 20:26:41 +0900
Message-Id: <551fecb79909221d640f9d6d08f5ccc8487717be.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.c |  7 +++++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent-tree.c | 63 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 4 deletions(-)

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
index 2ee21076b641..69d913ffc425 100644
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
 
@@ -3868,23 +3871,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
@@ -3892,6 +3926,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3906,6 +3943,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4155,7 +4195,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
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
@@ -4199,6 +4244,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4212,6 +4258,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4286,8 +4333,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
@@ -4475,6 +4529,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4498,8 +4553,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
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

