Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8196E2AD506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgKJL2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:41 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgKJL2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007717; x=1636543717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXoi4hz8+t4wLk78uy0VB7V1Ylvk6b47Nu308FFNIQc=;
  b=kwz+a8/PqEmwfAc8L2q0pgpKq5AliHDfn9Jmd5LEpfjXxZ7i7AKHH1+r
   TibSU82WmM0/HPOvJWliVh4U/CTnbw+t0g4d05sJfc+KhdjUtallkRGC0
   Cay3b6EZW9C/wxg7CrUVw0pc2XIy3Pj5f2k3phFt68w1or9MzSAnmUsda
   D3IOEZelHbu9uTIY5RY81iSlUypj2MH2c3MqEHS7u/2tQoimDaQeK7tYB
   PitBoHIZ4kU96UinQCO8d95MnyXCldIdf3J1fIdBO/6jqjLTRuF797C9+
   aeGpNDRpzKCoUOD3QbuNSqzLuDzFvL5B4Wd+LfLpUzMmk9ouOk4RcRPVv
   w==;
IronPort-SDR: WS1PpPoGE9uNLVmXuqForY5xI9EJhWu1aLNt2NFOJ0g053ZlqzhC+kRsZRB+sdz199DSA3dv2+
 KTi+wFtv5ik0ZjjUiIpidPKySm56HBYrPU4Y2qL2wDraXbY88ZD3oxjMrwEeQm2KpRpMZ+lRE4
 75kbhew8n1+HbeHXBn9+80Oln20kNTtGQfWSRIEq3Cc+iEo5EzhaCA4gnyD7iXHXDx5pSXyJNi
 Df8lPonzOd5DKzE8QOFtdMeuGhkVwfkSJuBZfhEsxjUSzh5o8Ft5owkOkgE4tksdHJ9CbN9H5K
 uQ0=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376518"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:32 +0800
IronPort-SDR: gusCJyL3DeqMYkaY7dK8WKX3f2+Uqj8Xz2rdya6K9Pokb4kee+yp1/0Yo6Saj3reELn0WRvezt
 11n0nXdAuA4iAjCNnq4/3Q+BzjZno4Mj7So2OB0xeOSsVcqXMvRyPQR6s7cj4lP6CWcGRsrhdM
 cKyw8QObsYNZD7emf1VOg89YZTnIWnjKQzkKJs9LKuHgnzmTn3UwAq1s2MtNOdCPS5Xxmtr8pk
 FA7u7ebfFHwrIQAeD2ywzvZQUzhUt9j40B48D4eTnfmS6+MHcresh9g75Tz19nyE9MBhxhm9TC
 Ywgi0UTAmjuWfqIDIOFqML7w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:34 -0800
IronPort-SDR: +fKs21Wo4u6P+cqOYxU3R8t1RF/NHpALLUvAxiWIOjTPKrVEldC6mK325gEbY3fAn6MLmgikj9
 PfrcXXztLeYzVarmDcpVo/qX4qslW1yJ5lnAqscZFUAgo0xfwBmjETBwgW3w8kF39SrVIrktyx
 Q/69OQyxno7+80QGn4cqUbWgAIqOL9ofTd3Gn8aD+MxLQqABZe6g4i8t/Tq7QjO+oJWeGV6ohw
 so7QLS733KtZV5GrfP0lxWMI7tcipLXeSDDcmwO4ukJWtmGTA7pKrvZNEu0181eHiXEZPLKuLR
 MAE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 17/41] btrfs: do sequential extent allocation in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:20 +0900
Message-Id: <604e8da010ec0d5529ee5f8a468681d3f1f0282a.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit implements a sequential extent allocator for the ZONED mode.
This allocator just needs to check if there is enough space in the block
group. Therefor the allocator never manages bitmaps or clusters. Also add
ASSERTs to the corresponding functions.

Actually, with zone append writing, it is unnecessary to track the
allocation offset. It only needs to check space availability. But, by
tracking the offset and returning the offset as an allocated region, we can
skip modification of ordered extents and checksum information when there is
no IO reordering.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  4 ++
 fs/btrfs/extent-tree.c      | 85 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  6 +++
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 723b7c183cd9..232885261c37 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -683,6 +683,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	/* Allocator for ZONED btrfs does not use the cache at all */
+	if (btrfs_is_zoned(fs_info))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 09439782b9a8..ab0ce3ba2b89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3563,6 +3563,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3815,6 +3816,58 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserves the bytes as in btrfs_add_reserved_bytes.
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
+		ffe_ctl->max_extent_size = avail;
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
@@ -3822,6 +3875,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3836,6 +3891,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3864,6 +3922,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3879,6 +3940,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -4047,6 +4111,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -4110,6 +4177,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_is_zoned(fs_info))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4252,20 +4322,23 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		/* move on to the next group */
 		if (ffe_ctl.search_start + num_bytes >
 		    block_group->start + block_group->length) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    num_bytes);
 			goto loop;
 		}
 
 		if (ffe_ctl.found_offset < ffe_ctl.search_start)
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-				ffe_ctl.search_start - ffe_ctl.found_offset);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    ffe_ctl.search_start - ffe_ctl.found_offset);
 
 		ret = btrfs_add_reserved_bytes(block_group, ram_bytes,
 				num_bytes, delalloc);
 		if (ret == -EAGAIN) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    num_bytes);
 			goto loop;
 		}
 		btrfs_inc_block_group_reservations(block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f6434794cb0b..2161d0ad5cf0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2903,6 +2903,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -3034,6 +3036,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3810,6 +3814,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	int ret;
 	u64 rem = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-- 
2.27.0

