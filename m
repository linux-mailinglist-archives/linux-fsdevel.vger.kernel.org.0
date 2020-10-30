Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA69C2A0708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJ3Nxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgJ3NxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604066000; x=1635602000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x5Y0WD3RTEFz7Z3HQrUml34e1hfnT65ellZSD2oJEGs=;
  b=IWsJFumCxRHbw16D/h0eWh1MztcYCsQgLDskRuhRLGfPVabnJUsxVVNf
   dkPF+s8+7DA1Z/YA0S+CA5JYiL97vzgPO17S4krppnBY2jtjvnPl9tI+Q
   UCr4QTi5KbyBcLXuLeTjSR//O8AEE2G+DVoHctlS/2A0oGdOiyj++Es71
   rSI4Dm8a95naMTVtkijUiregD1zXvV6pGnwEay26+fBj1pb2/57eiCYK7
   S4d2tBM9yLB2DQ6ci9rtH8vbkq/KvL007ACbSa7ZsqnI6DV/9ytp9krAt
   91wp3tcFzzh4sQfrj85JL1W/RB3/TKzxtBhWvclB0Fr698r6KccbNf89l
   w==;
IronPort-SDR: /7PVcxkFlHA+Iw/HgBa+4D3fQUaJkMtKDkqVkwo+j0rjpAM3cuA5YLBUryiph3XlW1+hLf2ss8
 t9tiWsaDB7VNFLbjV6x4hC0nh0GfYJurFg/5+Da/U/1Ab+UW+Ou6d4AsE6BvrN8W6jZAsIZgvM
 lXfvbZuIjSe4uqb0W9M0YB5q5TB52kL6YS718e2eo/UvCIPf2aNWZmWwJKm71981EO1u1xxs0X
 zWxctY+kHLuiDBg0vbUDeqwGWyh0uKdKCOr2jC4Gq4+aXVUIuTmSSbYixhFZFj0QtP/0/HB8hN
 iEw=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806645"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:07 +0800
IronPort-SDR: nyvS+lq1r6+Y5IKtaf4mdMtILnIDPI/6NxTcpeAcYBaknvzfypnAFgdZm7glmwGdhpDQF0j58P
 RtWst/M54Bg77VeBfdXLor9hSuBcF0VJn+ep1xkLNuEEN1+xHACgjnkPhgKqHLA33RDp4Zhx8V
 WhW+o0vsAgSbTnDatHDDhxkrMzQO/hfFuttwCBcTiVpXbI05ygs+J4u1hEM3LPovWc2iIANNaw
 zc9FUQRd0FRGzaQ+vlgVkvYTKiz0NhVe2tMMRVra+jtKWHqUjNsnMqeSdhX0mH16QD7EXynHAq
 UO1MGZsdzOZoOosIK52bNdbC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:22 -0700
IronPort-SDR: 2Yhve9yEjRdiT4lA6lemjvBmddKKgqpOyeQatwe+6gxS1qfdu3z1Jpqtp0quMvfwHKYlBhIWQ7
 tPIKVq3TZI18afnlPK6OPtJQDPllnAutXrqGKrQySIimuJKLkj3e/mDNhamDR0n95cPH8Ai1jK
 XZSITFsd89gWibek9RQj3J84c8hv2XFb0DYXCivEIUkmG2a7DV+CUefB6/4BQnScIj5s53XpUp
 ZaTJOtaKmLYhFFQS11BXHCAMP7RazW2ke0h1xW3uVOGcErTcmPJUmoj/nXd0un24kID1mlzarp
 mLM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 38/41] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Fri, 30 Oct 2020 22:51:45 +0900
Message-Id: <6640d3c034c9c347958860743501aff59da7a5a0.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
index 21e40046dce1..ac4fb954db28 100644
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
index 736f679f1310..026d34c8f2ee 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -956,6 +956,8 @@ struct btrfs_fs_info {
 	/* max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1bb95d5aaed2..c570fe576fb3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3619,6 +3619,9 @@ struct find_free_extent_ctl {
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
+	/* Allocation is called for tree-log */
+	bool for_treelog;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -3856,23 +3859,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
@@ -3880,6 +3914,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3894,6 +3931,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4143,7 +4183,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
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
@@ -4187,6 +4232,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
 
@@ -4200,6 +4246,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4274,8 +4321,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
@@ -4463,6 +4517,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4486,8 +4541,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
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

