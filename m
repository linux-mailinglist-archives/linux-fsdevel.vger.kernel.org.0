Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74811DCE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfLMELP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11907 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfLMELL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210272; x=1607746272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8QXk6brR3tcRJ1SASk/5og+UoqtTNWx3qVdS+e9vws=;
  b=K47jwJUOOu/CDHswN6394mv3kFqZxR/lRrW3oUkLV3TNSn3enb3NtveG
   Cl+Mpe7dWMTo9Kd/YUEOxakwG0CQ2Bw7EdY3IxHQqgqr7dYOrrVMPKUqM
   rWn+ltJvYxLzJsd7jjut18NMAVH21vdxuEfkqDIGaSLrcnY+axbIBbkZN
   fHzOGEzjnHWKcP9e7loe18HZf5qiyugbTywx7NUaoQPFUqVBJf0OqvVVw
   7CoeUTbojbUvsS2Jc5M0yNrKQ7hDNwL+ZFB4TWtDgykvwgaMdG1Jy3oTl
   fIVL61WIjqv43hoVAmjfzLKQxPvsPGTPp+iyKNY22wxdwSnLwkLH3tTI+
   Q==;
IronPort-SDR: IOEZ2P9+Lb79GaozaH1fP8VrS8bHFZo+akwGnlPMZeLtHJu7y1v6dew1eFkpwkd+371jLqaPVX
 yQ3FBpM8+U4pr61qzc4gWzw4rF21GsD9aQvzth+zp0B7kx6iYN7A9bZMfVQw7Zl48Hq+nFIPIa
 NtPTGX7Vj9m/f2hTQ0Wi+FWgraP8D89Zq1gomY/TrFU55yVtBP5ci22Befv/1Sep4thOTMMuOX
 S2azHgbvfr1xEqUk8/uNb6JcWqcAeg3WQyt+e4o+Nz/johmEb/vpTHJUH8r4Dyd9P/PnVk3ef5
 gz8=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860137"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:11 +0800
IronPort-SDR: vF+AhnCBORDj873Y4UprxlxrdUBnu0y84xF/QVuDzDR3Wsf/LTU0Spbfv++wyYwFJJWcmhl6ML
 ZLyZ/rbcnswyzbbaDipAUoPPx3X9yRtqZSXQ3WWGz25G5KjZYYI1JbSQFRBUFCZc9btp5Eh5xV
 4XQMESyEWQLKh+3lw/oes0bi9xqiVMdFgDJe+1ZINu3Hx7/eUosMq98pfLl8qBzYB9crJrCY40
 PMQ4bDMCbwTSg4AUDyeLRnDYJrK/zHW63YAQtcrBPJ0ws7ugp+5EfKUGijmQ/BQHCcAbBFG9a9
 /HP/4TRppl8rGJ0t/rD5g1ri
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:43 -0800
IronPort-SDR: ZTzz9VCglhU/Ls2DR6EHRwkmxXAZOv+yRIMDMk5QEH0NaSaUkV7v4bqrYeXA2Ya0/P9byxzvHE
 2aESUAmt9eaiO5e0wZD6tS5g0goyrwwvJUMcfm8OEigOMlwb0B8292+657qGB1rvB2nLBjmVQW
 WpSWHrNeI8N4j8sfVgdl/CYP6r7K+Vh3CHENjhLt3TWdpOmOD4RUvMDWjgzT0ckFkiFrJJcvYU
 AGwavSmMs078GbflzPlxhU/6eGTxGDJ1UINQg1UxOK4ytwwgleay/1wBGnTx1zl2eXxX5HztLj
 ef0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 15/28] btrfs: serialize data allocation and submit IOs
Date:   Fri, 13 Dec 2019 13:09:02 +0900
Message-Id: <20191213040915.3502922-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To preserve sequential write pattern on the drives, we must serialize
allocation and submit_bio. This commit add per-block group mutex
"zone_io_lock" and find_free_extent_zoned() hold the lock. The lock is kept
even after returning from find_free_extent(). It is released when submiting
IOs corresponding to the allocation is completed.

Implementing such behavior under __extent_writepage_io() is almost
impossible because once pages are unlocked we are not sure when submiting
IOs for an allocated region is finished or not. Instead, this commit add
run_delalloc_hmzoned() to write out non-compressed data IOs at once using
extent_write_locked_rage(). After the write, we can call
btrfs_hmzoned_data_io_unlock() to unlock the block group for new
allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  1 +
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  4 ++++
 fs/btrfs/hmzoned.h     | 36 +++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       | 45 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e78d34a4fb56..6f7d29171adf 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1642,6 +1642,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	btrfs_init_free_space_ctl(cache);
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
+	mutex_init(&cache->zone_io_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
 
 	return cache;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 347605654021..57c8d6f4b3d1 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -165,6 +165,7 @@ struct btrfs_block_group {
 	 * enabled.
 	 */
 	u64 alloc_offset;
+	struct mutex zone_io_lock;
 };
 
 #ifdef CONFIG_BTRFS_DEBUG
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e61f69eef4a8..d1f326b6c4d4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3699,6 +3699,7 @@ static int find_free_extent_zoned(struct btrfs_block_group *cache,
 
 	ASSERT(btrfs_fs_incompat(cache->fs_info, HMZONED));
 
+	btrfs_hmzoned_data_io_lock(cache);
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
 
@@ -3729,6 +3730,9 @@ static int find_free_extent_zoned(struct btrfs_block_group *cache,
 out:
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
+	/* if succeeds, unlock after submit_bio */
+	if (ret)
+		btrfs_hmzoned_data_io_unlock(cache);
 	return ret;
 }
 
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index ddec6aed7283..f6682ead575b 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include "volumes.h"
 #include "disk-io.h"
+#include "block-group.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -48,6 +49,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+void btrfs_hmzoned_data_io_unlock_at(struct inode *inode, u64 start, u64 len);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -116,6 +118,8 @@ static inline int btrfs_reset_device_zone(struct btrfs_device *device,
 static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
+static inline void btrfs_hmzoned_data_io_unlock_at(struct inode *inode,
+						   u64 start, u64 len) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -218,4 +222,36 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 	return true;
 }
 
+static inline void btrfs_hmzoned_data_io_lock(
+	struct btrfs_block_group *cache)
+{
+	/* No need to lock metadata BGs or non-sequential BGs */
+	if (!btrfs_fs_incompat(cache->fs_info, HMZONED) ||
+	    !(cache->flags & BTRFS_BLOCK_GROUP_DATA))
+		return;
+	mutex_lock(&cache->zone_io_lock);
+}
+
+static inline void btrfs_hmzoned_data_io_unlock(
+	struct btrfs_block_group *cache)
+{
+	if (!btrfs_fs_incompat(cache->fs_info, HMZONED) ||
+	    !(cache->flags & BTRFS_BLOCK_GROUP_DATA))
+		return;
+	mutex_unlock(&cache->zone_io_lock);
+}
+
+static inline void btrfs_hmzoned_data_io_unlock_logical(
+	struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+	btrfs_hmzoned_data_io_unlock(cache);
+	btrfs_put_block_group(cache);
+}
+
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 56032c518b26..3677c36999d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -49,6 +49,7 @@
 #include "qgroup.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "hmzoned.h"
 
 struct btrfs_iget_args {
 	struct btrfs_key *location;
@@ -1325,6 +1326,39 @@ static int cow_file_range_async(struct inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_hmzoned(struct inode *inode,
+					 struct page *locked_page, u64 start,
+					 u64 end, int *page_started,
+					 unsigned long *nr_written)
+{
+	struct extent_map *em;
+	u64 logical;
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end,
+			     page_started, nr_written, 0);
+	if (ret)
+		return ret;
+
+	if (*page_started)
+		return 0;
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, end - start + 1,
+			      0);
+	ASSERT(em != NULL && em->block_start < EXTENT_MAP_LAST_BYTE);
+	logical = em->block_start;
+	free_extent_map(em);
+
+	__set_page_dirty_nobuffers(locked_page);
+	account_page_redirty(locked_page);
+	extent_write_locked_range(inode, start, end, WB_SYNC_ALL);
+	*page_started = 1;
+
+	btrfs_hmzoned_data_io_unlock_logical(btrfs_sb(inode->i_sb), logical);
+
+	return 0;
+}
+
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
@@ -1737,17 +1771,24 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	int do_compress = inode_can_compress(inode) &&
+		inode_need_compress(inode, start, end);
+	int hmzoned = btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED);
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!hmzoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!hmzoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!do_compress && !hmzoned) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				      page_started, nr_written, 1);
+	} else if (!do_compress && hmzoned) {
+		ret = run_delalloc_hmzoned(inode, locked_page, start, end,
+					   page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 			&BTRFS_I(inode)->runtime_flags);
-- 
2.24.0

