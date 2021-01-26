Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF24C3034D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbhAZF2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbhAZCcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628365; x=1643164365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jPqwgZGI5bxeK7MgzXekEr0jNSk2h5t9A2pyqG7eu38=;
  b=ecQU2q2fFIQ5CAxq45cLrnj4JKArP9I5AZQL3TSWxzIRANVHwSXAj5Zq
   wjZGBXIUNxA6cIQ+kJVGYKjSPiI6doNC4DAHRRtpeFeACzwZYMausCNSW
   CT1zSph2IyH8m3ynbCYDkusDuoSQ0YyYMIuSvIAqukilPM0AltJZgQ5d4
   h5xeJlGWkC1vS7a6dklhiNgHl1OfSyErEZhjV9IEMvBDHgmi0a097wacU
   IK44oUupoOnzeY9YQsGznbQ/uEZGvrWtiP6rHJ2jH8X/JvCiQlU1g2/e2
   1hkBAbyZQpNp+hhJICii1VwwpwNDyrU16uiGXDcjclRNbsicN8JLL7/z7
   g==;
IronPort-SDR: Cy1pWrmoAs5YrkkDBEeolXFR+Z+pLk3hV3PDrhuKYNTRerDX3zS6w7gMTBmQdiu8wXku2R5u3X
 84kG45ngX3PjcPyvlvLlz6rGD84BdjQLyB5Zqe9Sh2Ovz29qi1zeOJYRL8j1P+iz8TZjMYxHBl
 EE8Q6563mweS0drgcwOXsHNpXpfd0WzjfVKUFeTQ/DsrQicJ67pvy0ryruFftl9XRu/gmRg+Yw
 952AaU+k1zTRsj03V4xkyblnAUERQYqfhkSRrS8es7DZ8zNq9tsddrUNLp+Ckvcezz8xq+n/ZG
 Qig=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483534"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:23 +0800
IronPort-SDR: 0itxSmKkx0PzAtWjAB9lgcEn0BchwaxhM4PUHA0U3JHB8H3PMMOAUQdq2GZHc9Ap08pi+x9ULa
 +5/gYvqfXkSvY9dFL94ldY/rYy4AR3obkLW+QDiLhqPU/YGtpkggu9JNP51Ms9jmUbYMusJl/2
 UkTlQmyIFBQJez5qQBGpoAE2v5CXoq3O9mKKu3jSbDg61jcnWtJAfHGomEO/svFN6wkxeJRww3
 wP+gteZhRUUBMIH+XVnhuex1LNKLcHNGyH0xckJrVhGjhnhbXe8v9EgrTtu+ba3FIsvMRC9KNw
 TUzI2jsW+Tas2F4+5iS81BIX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:49 -0800
IronPort-SDR: KnlLHVBrAQzSo3O5xfUCJtcBBuCb9wXnX5MMOXubHOJIgq+9Yg8X5EraQ9sJ17ys3zLg44BcvV
 dHJJrVOrSzNtCtcQUF6cjeKLg8hM01VhPy3BTwVJeCbDNq8D1rVa33AryBfby706uR/nOGPf/8
 /0GHGke2yVlb+SH+AwyJOS+9Pa16DueHD/G/Dzg31sVFbxhdk7/+tAwo5vWELD+n2AeUoD/6OS
 tccvczEwF9r02LVq9PtrvwP3XObX8mEmFWF4zKGCaOC0j1CiLdELLzivFXx2TweL9hfRulm4oq
 q90=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 14/42] btrfs: do sequential extent allocation in ZONED mode
Date:   Tue, 26 Jan 2021 11:24:52 +0900
Message-Id: <b31174c335bcfbb478ed0c9d246632e5f32a1730.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index dcc2a466c353..f38817a82901 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -725,6 +725,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
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
index 193dda1b83bb..6d6feac90005 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3454,6 +3454,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3706,6 +3707,65 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
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
@@ -3713,6 +3773,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3727,6 +3789,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3755,6 +3820,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3770,6 +3838,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* Give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -3938,6 +4009,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -4001,6 +4075,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_is_zoned(fs_info))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4143,20 +4220,23 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
index 22a7a95088be..19c00118917a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2919,6 +2919,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -3050,6 +3052,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3826,6 +3830,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	int ret;
 	u64 rem = 0;
 
+	ASSERT(!btrfs_is_zoned(block_group->fs_info));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-- 
2.27.0

