Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58E430F0C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhBDKaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:30:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhBDK2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434493; x=1643970493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmpmGOWUn0PLgq7vxULG9L8m1uiHHUSeVWrdqeokLdI=;
  b=Gy333wwSsSv5CRcQCA1Qd9hpz2N3CJwPJP8kjiRr8xY4P7SBOaCoboRS
   puEMt9JMVje1yU9RtnAzss84lY0cyZrViToBauWqMkX7iLGFZOP37om80
   FVjDECFgFMikPJx7CL+gyV+m4dxpEjd+/VV9poA5b5R/mOIpEo3CE0zoO
   vlyNChQCfUCMyFA9jkXCEVE75m6ZL7kuAYqZ9kn9Dn2JA7p12F6yyzCac
   TJlzkQfN4pbUO+ER4TMvNbd2MpBVRM8DLjiNe2vJSYOOtmxbp7Z3O+Zjc
   r5KOB6Zk1X91XuCXIRlHLnuNTFt278EvRdR1lFv/e2UhubdYT0i/ZgcJ+
   Q==;
IronPort-SDR: gmpgdtVyZ+S4r32CyWut5fRuvr+u44G29aGp42WlFxy3Fn7v/BuE+xEZZOlN/S0ltQ7TPtnRvR
 oYKU0ye9tpW+l8YjqKoBfM6K+s5kl6SZvJ8deIWWQ5GzSTKAoKEymmoDtdayPG5NSdV9n6Hmy0
 oMYR7Mx8TLG4s9teCOZ68qBSATjtYNyKHerr79S3tdcilExaDM07V9Nm48eGvhZTFYkOgj5dTS
 eYiFlnElwu8uzmdpQAVE8au7czJmdMyxO29vxvGm/wR2NDi50a0nxa9u0ARH76fmPxY8UYOI//
 4GM=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108042"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:35 +0800
IronPort-SDR: 4RuM/3r4z8p9xRSFVAP/ks/3mT0xAkbVwN9FqAXX3QzvVmnjrmLsWaOBpa3c3yVZtNIK8FuoGi
 bJcAncIpJNu+1X0Zh3kbDlpD3WGIFffODbzO+jbe/acqq1nK8Y6Jc/iS69R5qYl+kv9QOy9Zta
 ATF/RB2VOkZyP058mCgy03iXV10sC9tedidwTMkgzUfkH0yROZFj0F1qnDHyqa6VVNLr/1N5j5
 tDIsC6Q069e6VGJE/SOho+76Oxwxtuq6UNT22j16Odf+AWwOEapdDwA1Ww/wntYVbO0AlTafDA
 j2Ki2EabQrOJdgDOiSnEC+N7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:39 -0800
IronPort-SDR: MZGb/pxx7q/1A7BjtF54DLBRU7c+FkEqWazHT8Wk+RXieotApSCfeON52K/4+ku4EaMzgWr4wY
 CWzwkFOxBQKWyHg0PESC9NwzXUjCAo11Z+igSmTJzCNM8b4F5e/K7/vJtrG23RTeB2BkBJRxDa
 rlxqQaeqEzTtIADN71WZeFDHYGiUM+Cibek6LK5SPLguRhGIUhSPyHJJwvhyu0I+2vIQ+lvQkW
 kOzrNM0y5A8Rkg+dfO5CO6+8014oD8ZeaefozXlaef17e/39VUy/BxJQ/79upyRUZISAfASz5x
 0EU=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 29/42] btrfs: zoned: serialize metadata IO
Date:   Thu,  4 Feb 2021 19:22:08 +0900
Message-Id: <50946e4e638b9efbc1be374bc60cb878d6ab227c.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot use zone append for writing metadata, because the B-tree nodes
have references to each other using logical address. Without knowing
the address in advance, we cannot construct the tree in the first place.
So we need to serialize write IOs for metadata.

We cannot add a mutex around allocation and submission because metadata
blocks are allocated in an earlier stage to build up B-trees.

Add a zoned_meta_io_lock and hold it during metadata IO submission in
btree_write_cache_pages() to serialize IOs.

Furthermore, this adds a per-block group metadata IO submission pointer
"meta_write_pointer" to ensure sequential writing, which can break when
attempting to write back blocks in an unfinished transaction. If the
writing out failed because of a hole and the write out is for data
integrity (WB_SYNC_ALL), it returns -EAGAIN.

A caller like fsync() code should handle this properly e.g. by falling
back to a full transaction commit.

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
index 31c7c5872b92..a07108d65c44 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -193,6 +193,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 meta_write_pointer;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 10da47ab093a..1bb4f767966a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -975,6 +975,7 @@ struct btrfs_fs_info {
 
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70621184a731..458bb27e0327 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2769,6 +2769,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->zoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4c186a5f9efa..ac210cf0956b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -26,6 +26,7 @@
 #include "disk-io.h"
 #include "subpage.h"
 #include "zoned.h"
+#include "block-group.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4162,6 +4163,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -4194,13 +4196,31 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
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
@@ -4246,6 +4266,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -4286,7 +4307,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	}
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
@@ -4321,6 +4342,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
+out:
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 050aea447332..2803a3e5d022 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1159,6 +1159,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1320,3 +1323,50 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
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
index 04f7b21652b6..0755a25d0f4c 100644
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
@@ -242,4 +260,18 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
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
2.30.0

