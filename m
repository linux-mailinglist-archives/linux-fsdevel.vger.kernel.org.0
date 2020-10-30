Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE32A06F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgJ3NxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgJ3NxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065986; x=1635601986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daDaDyauWWbGjS+uDafaEorxHQhBe9r6S2WaFj20xaU=;
  b=Ilmwn9OlHkgqm/j8nTH7FMhsd4b7vExnZafK9v2g6qKIBu3nWhYMapOA
   YgJBXmMsrdTKurkkIsXJH7HAujjKOkHKEjyUqY8ReEOxnUQIMBphHF+oD
   iCAUNEgV5re85kXHFOyU0QdWLKbkALqnjOq5BRMJLtJudBH2Z4pTHr1V9
   A/4m8rBhIWGfeaoV2e88yqArdLT0pUlTHAcWu5aNn0j6vZiQU6rYZ6gTU
   zCPHV7f6ECIqrZL2AUHahaQfYnkjsyZoWAMfH9+VsTm0hhvUOnuO51h0B
   KhL8RtEQwT/ZZMN4LpZi55xymFWHHcz5czW/PNVrXQQmF+snJLZkr58GM
   w==;
IronPort-SDR: GxwarNjt29HJH0mm18IUVRVRi79h2tr4qcg4kmEpv6xwyGBv89JJJX39YaSvRmbxctnstNdpSp
 bt1xFT1LYIrTFLDpupzypCZMSM9CkLJy2wJRJalNDP8hHp+eYejs12ZDPTS3x4bNYiMhiaUFP4
 T1p4Mk6vcqp8eb/IKnjxWqIjrtOHBX9E9UKHdTEbCU5noSJhfX4U3fjufDvGEsfzwCkrYhdDuZ
 GHb5nTID06YnexyqxiBfrQMZQK+oBjnM0K6Ro27HdMneYP+duVe/qyeug1lBupwlBzMAuuDvAy
 7Lc=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806631"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:55 +0800
IronPort-SDR: w3TzW9UQbW+gRL3McXGn6d4xZmG/qzKJvWeC5mnWERjtC2X+nWDSzbUuTF48ig0bWTWpgehRc3
 qG64B4y3Q+TEPLZuPD2uzsFzU1zNjvVAzMzGXyAdJS/2Qa7q0q2SMCMJP3JDnuVq5IefhlXxmV
 qtay1HMjMmkP2Vyb14JfzqNOouvJtglWyUo5SZ9kkxCquQAhWpeuRR4EkG5MRmgqPjhuTmSCXY
 MDuIK+YR20zXWwy0RzSFsaMcNPXnVlgvJGMDmF7lgPKIEEiDgvwm1kojyUHqGYBqFueio6datt
 uxuc+vKANcMgi+xBY7JqN1TQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:09 -0700
IronPort-SDR: ECpfeLskO+nEWoM4WSaQlxQkAmPgW7KjW4rj8wpw51gIuTrDrS+74d59A4SRm6xF6gyXoIi8SM
 4sPyqibTeXpWPc1wrrGx+ClbQjWi01Yn2iVZ3/YS7gY9UHcG9PUxF7tM+dUF5GPbs5Hdtb7MVL
 9p2HNTWVIfj9O0vE5L3XL8edRd1sahNtjjJbMvkAzZg2llgO02OAXKtUyAs5/4k5dtYFfgo2ty
 Afh0jvOj3QFNO6fpZQ3Mp7/KQGZLFZ7zrmG+9tTJp/S5rKeBmtLbb9zobXHp7de4/V21sDIn5G
 1VA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 28/41] btrfs: serialize meta IOs on ZONED mode
Date:   Fri, 30 Oct 2020 22:51:35 +0900
Message-Id: <61771fe28bda89abcdb55b2a00be05eb82d2216e.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot use zone append for writing metadata, because the B-tree nodes
have references to each other using the logical address. Without knowing
the address in advance, we cannot construct the tree in the first place.
So we need to serialize write IOs for metadata.

We cannot add a mutex around allocation and submission because metadata
blocks are allocated in an earlier stage to build up B-trees.

Add a zoned_meta_io_lock and hold it during metadata IO submission in
btree_write_cache_pages() to serialize IOs. Furthermore, this add a
per-block group metadata IO submission pointer "meta_write_pointer" to
ensure sequential writing, which can be caused when writing back blocks in
an unfinished transaction.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent_io.c   | 27 ++++++++++++++++++++++-
 fs/btrfs/zoned.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 31 ++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 401e9bcefaec..b2a8a3beceac 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -190,6 +190,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 meta_write_pointer;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 383c83a1f5b5..736f679f1310 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -955,6 +955,7 @@ struct btrfs_fs_info {
 	};
 	/* max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 778716e223ff..f02b121d8213 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2652,6 +2652,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->zoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f49febafc69..3cce444d5dbb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4001,6 +4002,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb, *prev_eb = NULL;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.extent_locked = 0,
@@ -4035,6 +4037,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4077,12 +4080,30 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret)
 				continue;
 
+			if (!btrfs_check_meta_write_pointer(fs_info, eb,
+							    &cache)) {
+				/*
+				 * If for_sync, this hole will be filled with
+				 * trasnsaction commit.
+				 */
+				if (wbc->sync_mode == WB_SYNC_ALL &&
+				    !wbc->for_sync)
+					ret = -EAGAIN;
+				else
+					ret = 0;
+				done = 1;
+				free_extent_buffer(eb);
+				break;
+			}
+
 			prev_eb = eb;
 			ret = lock_extent_buffer_for_io(eb, &epd);
 			if (!ret) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				free_extent_buffer(eb);
 				continue;
 			} else if (ret < 0) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				done = 1;
 				free_extent_buffer(eb);
 				break;
@@ -4115,10 +4136,12 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
+	if (cache)
+		btrfs_put_block_group(cache);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4153,6 +4176,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 50393d560c9a..15bc7d451348 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -989,6 +989,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1120,3 +1123,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	kfree(logical);
 	bdput(bdev);
 }
+
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret)
+{
+	struct btrfs_block_group *cache;
+
+	if (!btrfs_is_zoned(fs_info))
+		return true;
+
+	cache = *cache_ret;
+
+	if (cache && (eb->start < cache->start ||
+		      cache->start + cache->length <= eb->start)) {
+		btrfs_put_block_group(cache);
+		cache = NULL;
+		*cache_ret = NULL;
+	}
+
+	if (!cache)
+		cache = btrfs_lookup_block_group(fs_info, eb->start);
+
+	if (cache) {
+		*cache_ret = cache;
+
+		if (cache->meta_write_pointer != eb->start) {
+			btrfs_put_block_group(cache);
+			cache = NULL;
+			*cache_ret = NULL;
+			return false;
+		}
+
+		cache->meta_write_pointer = eb->start + eb->len;
+	}
+
+	return true;
+}
+
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb)
+{
+	if (!btrfs_is_zoned(eb->fs_info) || !cache)
+		return;
+
+	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
+	cache->meta_write_pointer = eb->start;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d3ed4d7dae2b..262b248a9085 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -47,6 +47,11 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
 				 struct bio *bio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret);
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -122,6 +127,18 @@ static inline void btrfs_record_physical_zoned(struct inode *inode,
 }
 static inline void
 btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered) { }
+static inline bool
+btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+			       struct extent_buffer *eb,
+			       struct btrfs_block_group **cache_ret)
+{
+	return true;
+}
+static inline void
+btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				struct extent_buffer *eb)
+{
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -224,4 +241,18 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 	return true;
 }
 
+static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	mutex_lock(&fs_info->zoned_meta_io_lock);
+}
+
+static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	mutex_unlock(&fs_info->zoned_meta_io_lock);
+}
+
 #endif
-- 
2.27.0

