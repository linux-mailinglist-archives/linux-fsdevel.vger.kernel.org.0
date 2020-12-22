Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48E32E0518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgLVDyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLVDyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609293; x=1640145293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MQiHU4ncWfcd60/PGbKA0MAGmm9qh3uCGdWyTZD7aOs=;
  b=PpWNjr6wu15N7TRchM/VMp8OE5wJ/UiQE1a1r3hBa4Oe6aG4QawTfAWf
   VrE3x/qbXGGQPZi+ylN71WEC4cD9o65/fGX5kW3yvyO6XyG0E+ZMxFidL
   9YjAUr+IzaPk8LTDuJdr5iH315HFfB+RIT3KE1wO+4agWLQBqtt6x7SVi
   z78soIbU/jWGP7FDuLgnhSmLecbhqv5T9Cd6wdoZkfCwoVCBx8j5H8HDk
   2xGxj8ZJZgA1vmjYZLjwxS8jqibQQvPJh+hTGrbogllt2/xXIuiYnRP1v
   byydfIATUOi/PgIn2GhsBeZTpPs3imtHf3yFei1bG2vn/QzJQjv/AwHaa
   w==;
IronPort-SDR: Zcw4O34c3V+wMG2RNki7Fs4QbUNVgYjRC7eO74pXaGDYXXl1kww0rQyZo/yNo8XVF7asqsp+Q7
 SUtSh0y2MpQS3aB8I93Q14qq4TFfzpI5V22+6k0FWETPlIIX7S/gLLt/LfzgGknqbMNVPVJgAy
 4564hBU2yM7BtphPZPYlU5qNXiTRWNBmjrH1zGCc6k5OEJydtfJIOsgpLoR+FtxSvUPfq7GQBT
 GxtzJCPtqBNytz83oQ+3AEtVq+JsgK4tlrldp5N4nTRgmXpMcr/4VXwkMpwDl9FMjXg0q4pPEH
 4lM=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193834"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:09 +0800
IronPort-SDR: Q2P14uhfhI6TXelZ5IQWrkmRacrfA13jYjXoCEOLzoW3ZanvejznJcgQ83F47a/f+XR1BfsviZ
 +MHPepCnytuMQcPNzANM8uE8pGei5TVoqULxVcZQm9H+/kPohJ3nB4iLTZkzpX3ShyfNal+svl
 ODHBLnzjE2gxFfr9GxX8Y4BoHDvsnsO6UQOXqFCbEq6RyNI9smcpQw/mMnfi/uo6NLqK6oD/o1
 9+VS9DtQBN0GocRpdEi9gyVNml0gPvidMqbwBOnPgUrB5WuVMUBP7YPm+6da1hs0aKlqW24NcS
 q8GNFFBb4OOKoDEli7lH/7pe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:20 -0800
IronPort-SDR: jUOlX4/3STiudKZ4NA5jyWdWLKkTeRj0Yo+Se5CO/2SkIuB4t3OkUCCAIWGqI4G/m7cdG2gxlW
 Stv4nKLjfDGEgWmh478t6lab+eEpHYOtX0K7uFqfV0e74waUT+dFxar4i+Inzj5pqAeo28uZeC
 /ffsOlQjhHaPbk0amOuItKXfe6qFghBUwT65wUzj3jO7cM4dp9azPnfeSSZvuNiTEpAHDVuK6I
 lBvt6qhJ0yisuhMhxE1W2Xt0VMRtHbw0aQ2ujheq+noc5C29zdAnTax2kzuX1Oj+A1a8n8VQR+
 avk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 28/40] btrfs: serialize meta IOs on ZONED mode
Date:   Tue, 22 Dec 2020 12:49:21 +0900
Message-Id: <660d1b81f3f865dbd728ef6cd0b7efb669f36743.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent_io.c   | 25 ++++++++++++++++++++-
 fs/btrfs/zoned.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 32 +++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a1d96c4cfa3b..19a22bf930c6 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -192,6 +192,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 meta_write_pointer;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cc8b8bab241d..1085f8d9752b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -976,6 +976,7 @@ struct btrfs_fs_info {
 
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1cbcf53ba756..1f0523a796b4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2704,6 +2704,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->zoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0cffb6901e58..80e5352d8d2c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4072,6 +4073,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -4104,13 +4106,31 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
+		/*
+		 * If for_sync, this hole will be filled with
+		 * trasnsaction commit.
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+			ret = -EAGAIN;
+		else
+			ret = 0;
+		free_extent_buffer(eb);
+		return ret;
+	}
+
 	*eb_context = eb;
 
 	ret = lock_extent_buffer_for_io(eb, epd);
 	if (ret <= 0) {
+		btrfs_revert_meta_write_pointer(cache, eb);
+		if (cache)
+			btrfs_put_block_group(cache);
 		free_extent_buffer(eb);
 		return ret;
 	}
+	if (cache)
+		btrfs_put_block_group(cache);
 	ret = write_one_eb(eb, wbc, epd);
 	free_extent_buffer(eb);
 	if (ret < 0)
@@ -4156,6 +4176,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4196,7 +4217,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	}
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4231,6 +4252,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a4def29e7851..01f84b4c4224 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1126,6 +1126,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1285,3 +1288,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	kfree(logical);
 	bdput(bdev);
 }
+
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret)
+{
+	struct btrfs_block_group *cache;
+	bool ret = true;
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
+		if (cache->meta_write_pointer != eb->start) {
+			btrfs_put_block_group(cache);
+			cache = NULL;
+			ret = false;
+		} else {
+			cache->meta_write_pointer = eb->start + eb->len;
+		}
+
+		*cache_ret = cache;
+	}
+
+	return ret;
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
index cf420964305f..a42e120158ab 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -50,6 +50,11 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
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
@@ -151,6 +156,19 @@ static inline void btrfs_record_physical_zoned(struct inode *inode,
 static inline void btrfs_rewrite_logical_zoned(
 				struct btrfs_ordered_extent *ordered) { }
 
+static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+			       struct extent_buffer *eb,
+			       struct btrfs_block_group **cache_ret)
+{
+	return true;
+}
+
+static inline void btrfs_revert_meta_write_pointer(
+						struct btrfs_block_group *cache,
+						struct extent_buffer *eb)
+{
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -243,4 +261,18 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
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

