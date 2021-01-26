Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390C304918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbhAZF35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbhAZCk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628857; x=1643164857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSyjCVLFKxom+NnfZj3BrXysuI7QxXFL5HEdW7K34II=;
  b=M0h1FGy3wVUbpZiFhu+RynFpI2V7GV7vQpEA7Sa3dMy5dmOudc23vI4t
   NrDZwdKzK3nxfVdMYjhZjOVcg7k/54CNvsGM56Io0qSv9HHAJaQv/oDZ8
   2Af26gmH8qXaR3yVN8c0nEV45jh1aA0gNfIdfTLv4SI6Vxb9QQ3aQtoxb
   IpoOjqziwhfHZeu4c18y2Q5o21/a/NtG8ZxENHSeX0+CyKEY05TQbfVnB
   YeHU6UGk/g7oXqY5e8avt3z6CdPBxsiwqb7oToCU07IfnCUJ/+OeG+S1A
   L4rTNQlF2jPgNMWkLsA/Eu3gUxu2Pm5NI6LG2BJ31vl+skuFb4ftN4NbU
   w==;
IronPort-SDR: 2pjL8uRAruWxRyLA3j9j5A5NgmoVw5FQMq2wZ8mqonf3PqaFPR/nEL7tALQg3qV2eaSXJeZJoj
 sVYKkluKOKp6C3RWBl34xVVMehowdpk0LJSHiejgaQEuysTMI8IpOewAh1yXOVJv+UB8jcn00b
 F/6Ros01DdZmhKPGylv0td4PzxDI/5xq0+lPIYJOgJ3ClPrcQmiFLYdt/skHfTopP0yQrOQvTm
 vtTu53U/jCMSIMIi3AsVbla3+R/n51+fYJbY0kOjDzHHEDzLJG1ZgPROBse7Icf8TDK0eCejH8
 vmc=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483567"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:50 +0800
IronPort-SDR: QwxTAQD1m5Vd5BAZJMsCn+W0R2nLSoZlnRX/pPQdwy7+nVHv44TgC0680F7bwWZDGDpZRcvM8K
 +pO9f4AX1p2C78te5ExmssKPXI2exzuvDKGHxj3/WKSFyVab8FnL+lnVvEAj42qumEIBVnJbo8
 jishk79yNiXqzBvXDm2E+3twWlldC0pWOdOPXQQ5UkeWgO3Hc+0TdmJ78XmqLKklNNOhCZ3AVB
 8S6PtQZ9JTAd+mOkZe86zuWwUhzVodaUaf5Ai3iPA5tYA4I6lHPOIOi14XOrDeC7rw46Kbslr8
 ckbJJyVpqAGi0k63WuDvxvm7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:16 -0800
IronPort-SDR: 0x6ECqD9Fx1xe1dk3B54LEjk/iXKFnh20iKUfPDpKUmLTu2QLAZm8BGVrmGFsaP6+I99uAAh2A
 ns7IYvdGLqtlalPqiWf7qAjNIrda4Qdv1/Zj9SaEt1dfskWuAW8p24oFTTXl7IA9U4zFJ6WQOe
 ChpvvtiPQ5afMrhTmmaVWX6EW9udZkbbCFo4YbuPVAXDyg7a7PeQXK9DsSzJ4ElM8QF/MMu5Re
 6bhPi7smGFK2HD1soTpGGgFuJa6hYp2tPKCzdsnR4LHAl1hngQCTaI0Y/4e2iskdkyBeUjV8Wv
 Lwg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 30/42] btrfs: serialize meta IOs on ZONED mode
Date:   Tue, 26 Jan 2021 11:25:08 +0900
Message-Id: <50c5a35ef64d4b6d58a1c928acceb5e40b09f523.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index 6c4ff56eeb5e..37afe3f49045 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -975,6 +975,7 @@ struct btrfs_fs_info {
 
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
index 75df05193eb8..8de609d1897a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4075,6 +4076,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -4107,13 +4109,31 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
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
@@ -4159,6 +4179,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4199,7 +4220,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	}
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4234,6 +4255,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4f1801b71458..7cf7d74247c7 100644
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

