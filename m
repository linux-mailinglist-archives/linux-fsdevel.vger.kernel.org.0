Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123AE2AD50F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgKJL3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgKJL3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007749; x=1636543749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q9ylZB25gulV6gMz51E7B2lJ+KQTj0EvRMZM7uw2+XA=;
  b=DJUoW7NTCLgwwYQQJZ0uMhkp48sbXX7Qyo6skY8vgGmFT7muiy0TuNAK
   wnREmb5xmSGCMTaFajQqICWPvABMWIDobdzRi1uTJhOcPiZ5fzaFsXZM0
   JHU0dPU6doJk7MRglVWHWWpIvFLCuw5cG2owhy1S9vy/iRl8IQngY3ugs
   kUtfdhly2Umw5RxGr0KBWf+UuQTmai1e3o2tjej7EG/c3tqsJ7v71Li/B
   I3Tk6L5fiERnTuFj9mxabnVYxHOQ33ZbP0wTWwa8NAsW9aTtBbtU1L4JA
   Qv4CMQbJQqDW7mlSJ9+DTgwZIUKjYSnlYtR1KGxdFMFFDdit1OHwZkQj7
   w==;
IronPort-SDR: X6BwGX3SThFp81m2t2GELdRN8S/7PSU3iQqJjWCdW5fDd6nKhRGYGDzzbGtQQvyWxMMqN3u1yZ
 UgRHm6ogQsWTiod6xMt/02pGoualOEdPeEwTRFN2Z3sCOBFS12b/uJAXs7gC8E2XEzrSbBs/FB
 g2uK4p5qauXJJApaRwbAQbtzJEUKxj5iU0jW/yylSH4bDm8BHL9ehNFCWduFkyx0n0xMoxe+EX
 s1qLJ5Mw3SDJQPd0DCEWr4Go4n0rv3YNJwftBzIpdroif3Q6PuJA3LISgIs8Tsms2jY+PjYjK1
 kqg=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376619"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:50 +0800
IronPort-SDR: TbKorjJvnRP0SqAkfp8IEE2Twh9EV5kzSjOZj9xvwePY8nOGKnmaIVkkjazXx4QKiJ2uzY4ZQi
 /yZGkgnAhyFL+a/3GSFDGCRdBt0vnMKlEWGgo+rRGzggv/xmwopMPw47pHw7dCX/CeByH4vVQp
 B9TFvKGLb+kHLTrwAMmmeAhkNMvpc0Ubqkj1zdqYMHTguNPc4hrtuMOgxCr1Ini0mrb2jedYI4
 /f68QO/wOwBqzYmhxxbcbGBKkB8doE6/cw4PwW4P0xItNDSKMo81l9wQWnM9BrjV6H39KEH5vF
 EEebwxe/29GPVKsQWOfbhwYz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:52 -0800
IronPort-SDR: hscIgVNhjgVLI5diDk/TpOpLtQNhvlJeTSI4jBLRdqzV+7dm4w+Lzy53jzhkuzz/ckuoI5Nf6z
 BPmHrpfnWRUwcb3G4doiY5dV716AwOVtDtIYAJin1cndnd6j3MEyjUgrhilBPMCxVUV2gc/CqN
 aWqw9n1zsnv++UqSA5RIVwEeXnlREPCn06rpIexdFhv/l94VacsH1EaLY4StS6Tfmg8JQC/WTk
 eDQIsF2FJMik30DWpovtwnBoccCo2EIveYw+oC/wdQns23MVkJgPL5Wv0h6deB1FO2dUVfJ91L
 EDI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 28/41] btrfs: serialize meta IOs on ZONED mode
Date:   Tue, 10 Nov 2020 20:26:31 +0900
Message-Id: <4a7c166980699b0316fc10a8a496ddc68d9297be.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c   | 27 ++++++++++++++++++++++-
 fs/btrfs/zoned.c       | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 32 +++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9a4009eaaecb..44f68e12f863 100644
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
index c70d3fcc62c2..8138e932b7cc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -956,6 +956,7 @@ struct btrfs_fs_info {
 
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8acf1ed75889..66f90ebfc01f 100644
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
index 7f94fef3647b..d26c827f39c6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -3995,6 +3996,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb, *prev_eb = NULL;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.extent_locked = 0,
@@ -4029,6 +4031,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4071,12 +4074,30 @@ int btree_write_cache_pages(struct address_space *mapping,
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
@@ -4109,10 +4130,12 @@ int btree_write_cache_pages(struct address_space *mapping,
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
@@ -4147,6 +4170,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f38bd0200788..d345c07f5fdf 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -995,6 +995,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1128,3 +1131,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
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
index 2872a0cbc847..41d786a97e40 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -48,6 +48,11 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans);
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
@@ -140,6 +145,19 @@ static inline void btrfs_record_physical_zoned(struct inode *inode,
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

