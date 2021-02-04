Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E330F0A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhBDK0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhBDKZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434345; x=1643970345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdOdb3akZdghVnsgyOGjs7F8rdRCq2/2YmVHxcdWR0E=;
  b=TSqtGdTl4jA23mG544hYWzj7Dv7htwmPWa7ztX4uaYELJm1PhApaKAJ2
   jCbAyzCCVrtRGFk4ffeCaqoc10vffh1AOnmRv1CTLxXUe3Efb+HcHIwJ2
   sTtsh8X3zv5YoqIrwoQ/B3wXviMGMFnFZDLJx89avvCpRcHfD3jQae7JO
   QMtyi83Ktf/8cPPB+BpdGk4XraL2uzqsH+CaMX8ATX5/Kf1EreSEMKHyr
   amdMwXV5H5drc56FKeGTu1/GIOyBPPq+MbQRof7xIhtqsyD1F8I02hofd
   k2lomCpRAx1jQ1/dHL60SKjBhSZi/LfgdLmgOXwdmWjLCaakbby/xyuOA
   Q==;
IronPort-SDR: cMChE2ZBMW5d04lkNSQRYQq7ExYwEXsCzBbUG0QHWgZtNF0av6mVYsE5mz/Ewi5dByA4rR3uQu
 unMu7V2I9M9kMRvFJSmeBRmE3hVNApD6+nCGViYG41DkdwGb114REVdUKLXxQZ4LZT52/PmID/
 cvMEop8jT1RdE1s7q2qhOWrY8+2RnrySk6PE9wgQV6odulRq+/eY6Px/017SpoNYNmAFtdouD+
 F/KcYiq4QyG9bUd+UFT7EJMZXBU83HPXK49K3Q6gFLkUoRcOWh4j4uN5+TlbkUAT0kV/zwdtYi
 iuo=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:15 +0800
IronPort-SDR: 4YxgUQNEDs3xeYvLWWmskeLOc+MW0dLFIJ0R4CTiqL2AU3dtWDFGPWTnGy1JU3jDVqaGQn/KjS
 RvyOVZFOLb3Wc8kK+A4wfOs2xfjYGLscdMzEgBaYXTilDv2lBUZp9H3zs6B9YAoqrMkGOVVbvl
 3cwvZbrSU4QjfiI8nT6qHBgiMwUxIVk0WguC/Yat7Vp1csS5vSk4zB5HVoEWuM/zegeEkjfBVJ
 N70LDVkhRck6X+PAtZqN7CtnMTwU/mJD5hlg9XD4uY0CpYcgCVI8Br9X7KGatVXXZL2bB9Xv7h
 F8cmEERxhl/KkSlhsPjMUfu6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:18 -0800
IronPort-SDR: EavtwIDsZOvTAEAx+5Zq9Bn1Y0Sy09qVulIhXhYsURw2hOCA5qwu+iFQup+SzdUlp1aFT7YFm8
 qCru0Pcdyw/wiFubZigyuTeYn68abvJStd8sbL2G91fFY5id0FSB7Lywrm32wDO6tUpvgJqtW8
 3UE+POUVjNU/+Pre0M6yoQ9TMyHiLEUYol2RrXrjF9aM/nbGcZ41UtW6Q9utd6HKBSCjO6jE0l
 U+tUHJYRKEQhrYj/0W6PDvOvBnIY9A5Bsgfj1X/I43ZcllBBnjozwjR6AzatkTL196qP26/wNX
 Dxw=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 14/42] btrfs: zoned: implement sequential extent allocation
Date:   Thu,  4 Feb 2021 19:21:53 +0900
Message-Id: <2a2f979a38943162a54ddf017aa44371d17695ec.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a sequential extent allocator for zoned filesystems. This
allocator only needs to check if there is enough space in the block group
after the allocation pointer to satisfy the extent allocation request.
Therefore the allocator never manages bitmaps or clusters. Also, add
assertions to the corresponding functions.

As zone append writing is used, it would be unnecessary to track the
allocation offset, as the allocator only needs to check available space.
But by tracking and returning the offset as an allocated region, we can
skip modification of ordered extents and checksum information when there
is no IO reordering.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  4 ++
 fs/btrfs/extent-tree.c      | 90 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  6 +++
 3 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e4444d4dd4b5..63093cfb807e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -725,6 +725,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
 
+	/* Allocator for zoned filesystems does not use the cache at all */
+	if (btrfs_is_zoned(fs_info))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5c61c3f136f7..85d99307673d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3429,6 +3429,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3681,6 +3682,65 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows sequential
+ * allocation. No need to play with trees. This function also reserves the
+ * bytes as in btrfs_add_reserved_bytes.
+ */
+static int do_allocation_zoned(struct btrfs_block_group *block_group,
+			       struct find_free_extent_ctl *ffe_ctl,
+			       struct btrfs_block_group **bg_ret)
+{
+	struct btrfs_space_info *space_info = block_group->space_info;
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 start = block_group->start;
+	u64 num_bytes = ffe_ctl->num_bytes;
+	u64 avail;
+	int ret = 0;
+
+	ASSERT(btrfs_is_zoned(block_group->fs_info));
+
+	spin_lock(&space_info->lock);
+	spin_lock(&block_group->lock);
+
+	if (block_group->ro) {
+		ret = 1;
+		goto out;
+	}
+
+	avail = block_group->length - block_group->alloc_offset;
+	if (avail < num_bytes) {
+		if (ffe_ctl->max_extent_size < avail) {
+			/*
+			 * With sequential allocator, free space is always
+			 * contiguous
+			 */
+			ffe_ctl->max_extent_size = avail;
+			ffe_ctl->total_free_space = avail;
+		}
+		ret = 1;
+		goto out;
+	}
+
+	ffe_ctl->found_offset = start + block_group->alloc_offset;
+	block_group->alloc_offset += num_bytes;
+	spin_lock(&ctl->tree_lock);
+	ctl->free_space -= num_bytes;
+	spin_unlock(&ctl->tree_lock);
+
+	/*
+	 * We do not check if found_offset is aligned to stripesize. The
+	 * address is anyway rewritten when using zone append writing.
+	 */
+
+	ffe_ctl->search_start = ffe_ctl->found_offset;
+
+out:
+	spin_unlock(&block_group->lock);
+	spin_unlock(&space_info->lock);
+	return ret;
+}
+
 static int do_allocation(struct btrfs_block_group *block_group,
 			 struct find_free_extent_ctl *ffe_ctl,
 			 struct btrfs_block_group **bg_ret)
@@ -3688,6 +3748,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3702,6 +3764,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3730,6 +3795,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3745,6 +3813,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -3913,6 +3984,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -3976,6 +4050,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_is_zoned(fs_info))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4118,20 +4195,21 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		/* move on to the next group */
 		if (ffe_ctl.search_start + num_bytes >
 		    block_group->start + block_group->length) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+					    ffe_ctl.found_offset, num_bytes);
 			goto loop;
 		}
 
 		if (ffe_ctl.found_offset < ffe_ctl.search_start)
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-				ffe_ctl.search_start - ffe_ctl.found_offset);
+			btrfs_add_free_space_unused(block_group,
+					ffe_ctl.found_offset,
+					ffe_ctl.search_start - ffe_ctl.found_offset);
 
 		ret = btrfs_add_reserved_bytes(block_group, ram_bytes,
 				num_bytes, delalloc);
 		if (ret == -EAGAIN) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+					ffe_ctl.found_offset, num_bytes);
 			goto loop;
 		}
 		btrfs_inc_block_group_reservations(block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b93ac31eca69..d2a43186cc7f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2928,6 +2928,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -3059,6 +3061,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3835,6 +3839,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	int ret;
 	u64 rem = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-- 
2.30.0

