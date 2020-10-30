Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6807E2A0723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgJ3NyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:54:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgJ3Nws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065967; x=1635601967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8Wmys5L2g9sde1FdwDgNezlXg2dd9T7GZAnlZsOUrc=;
  b=hLYyuOd076xgizIMWBcgVMPfyr51q236dcQRkfA2rhFttazZRq6wvXBi
   kn+G2s6RykXgcmxsnWkb6RTwP4CLQVsUf1go/CoMcNxs62HAfAl417MZL
   9/Pz/41EkmdAweagugB7mf2nUvT0FCdnBSOjcZ3XN54ZD4zbqQdm513PG
   fqvYKOmutyYlgOqYYCRoBxetzqchajyymLbJfsNkFgONj7yNYrv1kCh3J
   bunZC7HCk64t8UgGIbu9Zg9BkED/toP+Kx3kiWXY1WSj/cO8/UYwLKM0J
   wxvpKVUmHUYqqmP44CmnYWVMk9xhE1KeCqRtod/uaP79eKvMpFmMhaoBM
   Q==;
IronPort-SDR: jCRF45lN65/FkDdeosLXn8qG1tvKyMVtDBVmB1JLo6j+qS4cTV2eDUHfs5jnNlYncrlCLPPo2U
 sWbyVN9wuBQT2YQskeN2c/hlZpnabxyU3hjIKmMVimy8DOKZCHHddKxep6VuHxMIKghubO2esv
 u3pXasfi9hhBgN9TrnxvtQcMP3EAOL//XHUyX9j+PKeQuWKYkbBE63B0xjvSQ9LHLp/e0JQ6Bl
 MVt5jTIIAaqUPOD3KBHk+V51/MoAB1z9lHLw/+v0jt4NhwbjxNYUr3znelo7+RYlxDr4AYZaFD
 Og0=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806610"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:42 +0800
IronPort-SDR: uTpxl9LWrdTV0cI3dXTHkrsEedvmNZIKCMMPYjiY94iIycaC/OYYC03OAHfXtlloe9LNf7B15A
 Ua39j5J2CsJJjh+zSWiT7eACBTZff+wR7NCTb9foFvU2ac1OEp8olEvkFGAk7my/VBZHUasteO
 qOp8vIFJiZDaRbfPh+Dfej7RSO51qgI9klONcX4XAF+gwKcqplm6SQ4gGjI2HYsiN7qm6J8TbL
 Nzn7n2tIGX/bJQ1GNjHh/XwNbsb0o2MzliTBNW6PPhW3YUr2WDdPUceVIYYZ00GLnuvGTev4Rp
 7R+RQqZBX+h4/f7vaQHHsw6i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:57 -0700
IronPort-SDR: QzQd8PDiIvUgl0xfSNS84tgaWyqKMvYAliUAFqdMFiDkb3y7eRgQJDOCBeMa6IKusl6k632T6o
 wYtJmZKqGZ2KPv6fT9B1A6o7/cSVPyjqBhiaawvLdaCdGbX33NYh44tSxUL1+gfI0pLEoYtUao
 yni9MRe2KSLMIS85Rop7yF9MqoL7U+qQbf92obqQyUEoPhByN9FDCM6xAvGDi8VX9+8w4Nij4F
 M5yMdpR1PFINoUBT5H2w+S/R2LHEzI4griIIYyvgJI0LhOI/GyZ4MqN/Wuu7jMh1FmEMsF7sqa
 iOg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:42 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 17/41] btrfs: do sequential extent allocation in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:24 +0900
Message-Id: <0b0775b15f3fd97b04b3b3f1650701330e9392b5.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  4 ++
 fs/btrfs/extent-tree.c      | 85 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  6 +++
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c34bd2dbdf82..d67f9cabe5c1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -683,6 +683,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	/* Allocator for ZONED btrfs do not use the cache at all */
+	if (btrfs_is_zoned(fs_info))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fad53c702d8a..5e6b4d1712f2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3562,6 +3562,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3814,6 +3815,58 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserve the bytes as in btrfs_add_reserved_bytes.
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
@@ -3821,6 +3874,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3835,6 +3890,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3863,6 +3921,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3878,6 +3939,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -4046,6 +4110,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -4109,6 +4176,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_is_zoned(fs_info))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4251,20 +4321,23 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
index cfa466319166..7ad046d33c7e 100644
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

