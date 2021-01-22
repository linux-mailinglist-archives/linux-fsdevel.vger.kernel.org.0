Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEACE2FFCBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbhAVG3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:29:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbhAVG1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296842; x=1642832842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bhI4GsdYtyiwv2jI0vmusT05p0v6H3hNyj5go0qKkg=;
  b=WmAe8wOGE/2py9ehSqFlCdLn+0fOan82IzKkDV5ohYoauCIVLxivrXsT
   AP+We41tLOTzS3jKWZQhPfr7tbx9NeUcQ7OunVmhCrgi197bBA8qkp4es
   CD0yFXrzdDdOTsoMnbkR+0aAj42etf0gx+ya93MeV6Vp9EdscTFjDVNUW
   rZFzPhP2RyPaP1mPkeRhsU1XQxTMJjEW9kcwM1AP4DFVnaK8UhK1mBP4L
   SeYOBtkprkQ+vBwn+S8TNykvSVeeyn4DIe9y5s3Ix3wDnJu/sYwWeOgyH
   OiTubeyO+cd4MfO4tVI1H1USKcf0Ylw3/rJ2jrcTNwbn7GMfAbu8ZTc6v
   w==;
IronPort-SDR: CFCaQJZuVUydGjzl4gT4AcxSKz6gJRRU9ZE4OrW1yxFIe9Ae8HXjh9UfWeRKf/zA9xX8oij4Ui
 C3NBCBqTC25BLwdoATKH84xjiTBcw6vCjkdUm1jE4Y4YVpuBbnuM/YBV1GNgQU8MklUv4YznQX
 qos3z7/t9aAWXZWgj8Xkcg2fT2XkYx24QvxF/Z4nnfZDpjMT9mTr8u5hnjHboFQuVwtMvwXbwT
 Ek5dYa54ZqYSE79fXsdRF0uc/p3ypCbyvPNUQuYdZP3aKblLMTP1tB3sKXkXTzohyTP3M3Y26W
 +D8=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392047"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:10 +0800
IronPort-SDR: HH8YBtHFr++rrZfz/rQ6CIuLEnuD8LwDFKPQrsatAbXeN8DvrxbOCEj7vc942fPIc64un10x2d
 /pKAhZHnbT5IqN8QKd75xl6Y2f8Vsj0UYNzoqZso8NiMkCQaAeU36sfqwxo8nYidRFir05fSgk
 7AqGtSSZyVvm9S93hZtUwbnfx7wBKSasRTO2r0zug2ndizGlVHCZ+U9n59rUES1aKp8pdN2lHo
 GfB+XZXQsSPiLzIVfn2NDSI7p9GF0E2onEituFr8A323RMomdz11zeuXrxOf+3t6fWGM7AJ46b
 0vmCYM68WK4MxdX0cRZmfbpj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:42 -0800
IronPort-SDR: KdI+XdayyETU9xW6I4j+UJTjPIeoI4QqAhLMP6ZUkHm6m02ym97Hq0N48TvgvpMDWfmvi/DE2W
 TaYZbWmKyubmOhkjjGMzt219yi5hQaV8zEyXxtB41ouI+TclCdPJDLeF7MTZxWosdmKkNO43Fb
 PGyc1H6TxeuHldpaznBe8NcZYhcIaLKBNelcFKNfb1krJqJlFBBELM+/4B7kYwN6fi9Z1VAapk
 NKtaFn8xbiVKx+e1wqBEyKC/1TiH6AnuD5z5YLzk6X40lUMgpaVQCNY4UbbGaPOmcBL4EgTSIy
 S9M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 30/42] btrfs: serialize meta IOs on ZONED mode
Date:   Fri, 22 Jan 2021 15:21:30 +0900
Message-Id: <af5f966753bb0cb2170d17c198ec2696a0180253.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 1b6f66575471..4e9c55171ddb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -972,6 +972,7 @@ struct btrfs_fs_info {
 
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ba0ca953f7e5..a41bdf9312d6 100644
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
index e0d212fd5678..ed976f6e620c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4074,6 +4075,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -4106,13 +4108,31 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
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
@@ -4158,6 +4178,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4198,7 +4219,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	}
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4233,6 +4254,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index aa158735a1e6..b66f57119068 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1161,6 +1161,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1325,3 +1328,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
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

