Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFA2E052B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgLVD4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:56:03 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgLVD4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609362; x=1640145362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sn6k/589k8wbYimhdvHuGqYc4KdzkBuwFOVyca0Jq0k=;
  b=pBbuKguJ7jJS1R0fM5qv1UfTJbIRxkAMO/IyEMG30iFzBl7iIfzSTyQT
   Tn/ARKrHApuOHqaDooPzihN8eGlQlh4LsQVVA2LfoTeIfKwsekT9AbNRp
   bBi5vd8AQL4ou+j81+Q6m1JJbjRqoqx2eyixJC/ZKBxZ4AiYnSxBh36m6
   IWYymXnfwmtQka3ovnngpa99T2u2dqDyemfShAh0yZBZmZYARSO52d4C1
   EgJFuz0mXsp9xLKMJO/V8th/kY3hqzwseegnZszwGoWynePf3saP/eXbI
   vO9PeCzBEv0KeZxrskiNhQVGVDaYfD5D4t9IrUVNK6wmsTnmapqdlJo2m
   g==;
IronPort-SDR: o2aL7FNaKM+kw9McdFNujp5oHj0PNcrzukLR/ZKRkHDG+zlyFTfOzAMZl+kZspHy2gRi3demM0
 pelAdpszguawaiB4EBmtgkC8Dy463omTkdkOJPxK/O/rg2k2rGdIHZeab9z3tyfi5Zfikdnclm
 V+TBpHf6aEkjbOj99HXVVCZa8iYVDTnqgRt18h7fpHC2t3zfuyXg0hLKDlpjxadcrAxeAkI3oe
 3uTZzfj7k/EF0fjEX1J499M91X5ta2VPgAKY/xctNM8L50FARfuqyKN/JOnvByRf60Gc/V/5Jc
 wHc=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193878"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:25 +0800
IronPort-SDR: o+2W/T+5a+/3SkiwBEEVTiFgmUmWyUlI0ZAbm37FDSeB3BOuoN2gnHeGYCxipLqGnVpFye3yvm
 ja9UhbXQCV7kkSnoLiO742O7gEguv3F7O3Tg5eLYcTQD1k82FcS709r5nq+7t3KuKLAOoOMZxl
 hGGhqXfQDvA9g190RYWYr2k+XTqAQF8FLC3pKQcoSz3bl6aUTE4jOm8icraNaarLkcZYjuV7uI
 XSNOZmC+czQM5pO3eoBIxyFAMfXmlEygqDRBV31NACANrMrZgC9pALfF8WF8JvXGFp4ELGLllB
 X20eooe5gV0zes2CGsetWxe8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:36 -0800
IronPort-SDR: GVevf0A2VyHo2D3vPQDj9Ptc8f+byFEJ3mpLAMdeGfTRXdV+DEWIhmklDdaCCgeEXbQgxzvQfq
 JdYtm6idc6r2BbUG/cJaum5Zv2M1/wd58fFVKLYpT5OcQHy2yRJ8nVqqatoB8zkICJZdc1OK2B
 prrZ5HMQX/+LR5kVRjyaQtosxGn64TyOvs3XwspjBA1bDgg/wmU7QnJBW7epwYE1+MziYoXKXV
 BXK9nwSRUIutkOJ8rgT2jDmmBOC7YRfyneCVvwUbb3WSveaveHkN4UxrIP3z5Fa3IkO+VN1Z+b
 G9g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 38/40] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Tue, 22 Dec 2020 12:49:31 +0900
Message-Id: <920bc20e9b4b1bed3802c3dca6f9fa3c72850804.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent-tree.c | 79 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b477617021f..ffe8cf5818fd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -902,6 +902,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
index 1085f8d9752b..b4485ea90805 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -977,6 +977,8 @@ struct btrfs_fs_info {
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc0ddd097c6e..12c23cb410fd 100644
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
index 23d77e3196ca..e11ad53c6734 100644
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
 		ffe_ctl->max_extent_size = avail;
@@ -3851,6 +3901,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3865,6 +3918,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4114,7 +4170,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
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
@@ -4158,6 +4219,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4171,6 +4233,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4245,8 +4308,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
@@ -4434,6 +4504,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4457,8 +4528,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
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

