Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD63112471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLDIT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLDIT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447598; x=1606983598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8QXk6brR3tcRJ1SASk/5og+UoqtTNWx3qVdS+e9vws=;
  b=L9bYPg+0MCHa4pIgxXP9C64xE83nnkIiW3nXKd8kjalMK+zIHkIDYOgo
   +4ZGV/ZGqZsL52MG5DI29qkC3oGvaegF0wFHFPwP53zPsQ7iwFp4L8yvU
   AWx5oMSz9ypy7W4/hylQ4IMwdcmvwb6ShdsphLEOSQRxATAB0CaQz/u4g
   dp/vCAuvJiF4a1r8kKa4o7oF0g9EhwEl0fCgw5cCin9HLJnY8tYaKRWi/
   r2qg3QIIATmGpHzTh7E5fMhu88XITopB/c28l2F9zxdd7HPXvqAdRz5Zy
   4fm4BEges8PiJWdvsWFcKVmI7J/oGmqWfh+VkipHjQmDhtiIxGAMMr1sJ
   Q==;
IronPort-SDR: lFNi0pDP/AVlrZ5H/aEVD2eYlv/74PGBYxCEtduQANQ+umuubeFWIW4FpPPXuCuSHDxuvmEUHF
 UsE/vtcIbDWVC1RkJqkwm4lO54kpLrE0TVY0xMqi5Ph8mS8xtkrYhul1swaaKRZiJjJgaLDHG6
 tmSPxHMiFyqqaPG2ySpWqdHOV7q6hBdajOMsThgx+jjxlBCbkv04U6gP5peyTAnch8XGpZ9u3q
 gGGjNY2divUebEA255TPxCV14C8Lops8pk2yNA+jUhDquroVpnNQG/LUGkQWonDo2WJet+UaIE
 or4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355092"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:57 +0800
IronPort-SDR: M10k4O1do4JU6hlKiJNSquMOWm7MuMOY8Ktlj5+B1tH8cQDa0iNETWjB0671fxamGJtlW3klm7
 sPJaaHRvvabdePEJ3OMX+dMOZOIvAVo2NqrXrVwevoKKmqxLFEpGK8KbjgKbbe3HSItl2rjJHo
 d5xmxX1acASeXZQN2n0IYBJTnwiXQzzbHFd7Hrg8aHSit/LIQCm75xYEVrAEtxLhcOxL/M9S/4
 a156sO4nyrNwe1BwdtwsSNkwuAbqyOTM72TdlIT6vROxao005mNiK2sf6LnIGJuXfYQzycDFQg
 cqvisxGkkbIs/j1QDINANmBG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:22 -0800
IronPort-SDR: RZW/2bvSfn1V40J4b8Q4MSKwHQ6p0YPxwqTXIr4rkqy5CVTRZfpkuq/cC1brxygJS+KdpbfjW4
 /sggY+EEpnZARoN7n1KW1kVMKiC2ascwGtYuPxnbaey0If1C5GdcERYdEsvSUA7a5DUtyIzih2
 94EegkS7Q1fgfHocoLGLd+lt2RwnLAPP7kFJdW2AcJ4ccXd3pATjX5ntEass95nbSBM2AVCz4t
 cPTeUATMb+dr1IKXmsShe6E6j40SNdH4Y9YUSkHp9ImvkkT1g9Fy/NnW1pqv4PInQp7kUBpIw8
 nXA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 15/28] btrfs: serialize data allocation and submit IOs
Date:   Wed,  4 Dec 2019 17:17:22 +0900
Message-Id: <20191204081735.852438-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

