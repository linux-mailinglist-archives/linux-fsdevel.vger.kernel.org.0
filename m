Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9F2FFCDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhAVGcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:32:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbhAVGZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296718; x=1642832718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OR6frRfWIKwaS7K/QrW0FTPqOwmGS+MbQeBJLIaGm30=;
  b=Co7GmqnLqEmlM3A4buEo3QPfMUFxy8c/BzRmpqTTS/+M5EnOO+snzVrS
   CTZndMoDRnZQaatx20Yv/XJ+zt1JTKreTiS/wRwXpocScGKNujlgHMFy2
   xaZz9l+iKjdnybWAFgGyEA18nQlkOpCpTro9XwVqZDiS96qhlcsTieGvZ
   z6Ik1nLSdqCJ5oFLfc92n0UB9Wi6rC5EK8qfkaUgIRIz2vlGL7N9WjJjW
   jZgqd5oZoW1AFxXmAHYA7qE3N2WKNLgYLIgEr7DXIxe7eAkTm5vfMpknC
   Czd1jAclphFjTbYPhg6yI9uJ92Vd5r0z3jHK2z4Vy6ELda2pWidgZdHQr
   w==;
IronPort-SDR: vkXWzOXy7sskOSV0JB/+Pz2oniN28kyGMAkFAamPUn/0QMKHiBAxzIBOGzMbebCyl+eJ+O+tEX
 Zdzs8QZMqdbmPig5IrIkpE/O9TExx9fHW7LaX7hx0wQy9Jxq+npNxTaovZ1kngqq43H6mrOgN8
 fqcuWG9knSCbO8OkhXIq1nd5T90v2/nugU6xOsx0RuewM+DqGT1yyy39XmisspHhiNue3TbklL
 YGRNzdVCW90vfoWvppiD3AfemnbAnvkSybaq0VjuoiQ8LKDf6bHIs9kDLQaJf2JDl/Jrs5M7Pk
 dso=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391985"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:44 +0800
IronPort-SDR: 4sSBHPyt4/+mv2PPIpquRxttxXKVuAajyj9K/0mviW74CZECJNVx14HbCT/lmEb7WMaFFrw6kq
 reCJnwYK0x2a0WTTgAz7oQT8yxwJips37gNplFoX6Ig0QXW6yC7p+znbOfFH8kFVw4JnWNbiq4
 AfRYgo/odjRHo97vIok/aIdbFouzfT6ZZA8ouOBHHJILPAWzIG94Em/EJI6cbpQ0r1vdtZcPnA
 0QOH8b90yNw0WZ4PUIXGMzRhIqY0a4T67IksyukrXvaj8FDjziX4+akvR+5GE0XQMGk7ArXG40
 IL5QIIt6Sev9TlttnkvpRYta
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:15 -0800
IronPort-SDR: qWaocSNRQmcVrFJob3lfrWWpDSzD1QMCZLKx71Fsp66WOJVwmNS8Iu4z6NXAdqPCyVCBLL4m1t
 M3fc56MfV7T91Qpu3Sa2yCvFtbUL/4lyiGE36+R9YB3jGcBa95SZNcgJEKhIFs/JgWpjGcjg+B
 VnmFj0oRoZnae/K52MmL7sJIQZMfC5pz844nFtlrlguDoEXLsFvb4ADfq1mvu6O46urMmy0sUN
 t81tlSww0JtzDlXlFQQLD6XZbdCoIyT82sLTIoQSFA+EL/bglDnPGtrJWPBjm3qIspmB/fmKJh
 pMM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 14/42] btrfs: do sequential extent allocation in ZONED mode
Date:   Fri, 22 Jan 2021 15:21:14 +0900
Message-Id: <d43cfad85ccdba9e564ba168345dd84fffcf0a03.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent-tree.c      | 92 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  6 +++
 3 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 487511e3f000..d4c336e470dc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -717,6 +717,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
 
+	/* Allocator for ZONED btrfs does not use the cache at all */
+	if (btrfs_is_zoned(fs_info))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 071a521927e6..00eb42c7f09c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3522,6 +3522,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3774,6 +3775,65 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
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
+		if (ffe_ctl->max_extent_size < avail) {
+			/*
+			 * With sequential allocator, free space is always
+			 * contiguous.
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
@@ -3781,6 +3841,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3795,6 +3857,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3823,6 +3888,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3838,6 +3906,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -4006,6 +4077,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -4069,6 +4143,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_is_zoned(fs_info))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4211,20 +4288,23 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
index 8975a3a1ba49..990b0887ea45 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2916,6 +2916,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -3047,6 +3049,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3823,6 +3827,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	int ret;
 	u64 rem = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-- 
2.27.0

