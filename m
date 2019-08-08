Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25485E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfHHJbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732202AbfHHJbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256704; x=1596792704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+439xCDucUCzK3Jj6tvgdGIkZ65+VhZ5mm/gT/YK5E=;
  b=ZmV2M96TmURUwfTIXPppxdwWAER14p/WWS+noY+4Cx6pa9UN5LyJolMe
   +5gNXgYUneanpnrCsk/aT/I4dUzkehemQUCnto3pcu0nz3+kbWeOLc06f
   DKn5CQJZ5n7e36Idmo3c4xfYKvPybsjVZIqYLOjaJdt8tsaQPtsrrW4us
   a6Lc2Qlc4gnPrOz1blWOFS3tB1WmBDJ3Ja1IaV8TtG88eGMhbxoktBdfK
   RHGRb7YuyjgA36I0isT7dCfZRLR/LltIZR+mpFgmqnF4bqisySwGwFGV2
   CqKOUooBuwrHtjqCbZjK8pUXDj4HB0ccEYNVv05333RfUpRHacN6Qn7zJ
   w==;
IronPort-SDR: 2TMmi3lXiElEHLzQzRKt/CNV7NfYcDOWjJAPMslmCZzzCPic+J62zgYt6kitjsGPCl14pg5M9r
 571rQJslZMsobZTgfQLw5GdZ4ACz+rtdzqqTdI96KKIxQt8r8QCjX6nyM6ZK3fldwf3xnRM/Jy
 IgvKAXvZKj8bwUi56z5/rlfkS1ap5FEVUrfA0dwNAd+imKTDMjG6qn9kj0vwVRE+UdjsahGEpW
 nLWlIb1ddYwuB9Wha66rOZ3i7n5XzPUt5GPLy91F/Mh4tl+6+Ee6boHnUB78A9VPStJeMmLBLT
 gZ0=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363381"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:43 +0800
IronPort-SDR: G4BV1zFHLmJVmhe7m+kHNm2qdVYT0YJ1yXG/2IixIVwqm4OefdQE+qzX8XWZjhhwdgRuuf6gRc
 dMUPsJFH1Al1JpLmmO97s9bay1GY1ULVIoosIFWIVlRwsZdvh4RvKG4RPP5Z+x2uX/IP4B223t
 tU5uU2k+a11SJnR+QABtdihq0pj/Bv2Ny09ED6TE0r6BGO3a5PWnfNuaRNSiVW0OaRNAzVVg64
 75Vm5wwS/6/iA+qq07E1u3h6yQJMFeDC9Nc41u5gJ/wlb+VHm07lMs1HfUBIOFLufhmkQiPqvi
 Mb8g+EnYUQiiT5RSfIxQv1SE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:28 -0700
IronPort-SDR: a0FXLMkufqMqShzalCB1sd/2Th8akOxgGvcLfVQcoOAq7L7Hz9J2bWToZW9F0boLELyNzPPK1l
 c3xjgyTwxtG+mxW7ytoeGax1HCE4aiNlYdIjVkIm6A+YJxouqR/ePDFm7ZLdqOl3oIVs0Loq1B
 0/hmAooJn8nQBNERVdS4+krfLbQ7BIIcu1NRbnjo23yI3IVj8qdsaR4nmkkkSrxZuz0ZPcDSDW
 LK0Wz6jK1dCqSa7lBYQrn2PC7YqvW60WzlJ6lg7RV+uH49VzD6g37svBbgBOCvlSsCGwvpIFhY
 viY=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 16/27] btrfs: serialize data allocation and submit IOs
Date:   Thu,  8 Aug 2019 18:30:27 +0900
Message-Id: <20190808093038.4163421-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To preserve sequential write pattern on the drives, we must serialize
allocation and submit_bio. This commit add per-block group mutex
"zone_io_lock" and find_free_extent_seq() hold the lock. The lock is kept
even after returning from find_free_extent(). It is released when submiting
IOs corresponding to the allocation is completed.

Implementing such behavior under __extent_writepage_io is almost impossible
because once pages are unlocked we are not sure when submiting IOs for an
allocated region is finished or not. Instead, this commit add
run_delalloc_hmzoned() to write out non-compressed data IOs at once using
extent_write_locked_rage(). After the write, we can call
btrfs_hmzoned_unlock_allocation() to unlock the block group for new
allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/extent-tree.c |  5 +++++
 fs/btrfs/hmzoned.h     | 34 +++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       | 45 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3d31a1960c4d..1e924c0d1210 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -619,6 +619,7 @@ struct btrfs_block_group_cache {
 	 * zone.
 	 */
 	u64 alloc_offset;
+	struct mutex zone_io_lock;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bc95a73a762d..5b1a9e607555 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5532,6 +5532,7 @@ static int find_free_extent_seq(struct btrfs_block_group_cache *cache,
 	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
 		return 1;
 
+	btrfs_hmzoned_data_io_lock(cache);
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
 
@@ -5563,6 +5564,9 @@ static int find_free_extent_seq(struct btrfs_block_group_cache *cache,
 out:
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
+	/* if succeeds, unlock after submit_bio */
+	if (ret)
+		btrfs_hmzoned_data_io_unlock(cache);
 	return ret;
 }
 
@@ -8104,6 +8108,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	btrfs_init_free_space_ctl(cache);
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
+	mutex_init(&cache->zone_io_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
 	cache->alloc_type = BTRFS_ALLOC_FIT;
 
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 3a73c3c5e1da..a8e7286708d4 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -39,6 +39,7 @@ int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+void btrfs_hmzoned_data_io_unlock_at(struct inode *inode, u64 start, u64 len);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
@@ -140,4 +141,37 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
 		!btrfs_dev_is_sequential(device, pos);
 }
 
+
+static inline void btrfs_hmzoned_data_io_lock(
+	struct btrfs_block_group_cache *cache)
+{
+	/* No need to lock metadata BGs or non-sequential BGs */
+	if (!(cache->flags & BTRFS_BLOCK_GROUP_DATA) ||
+	    cache->alloc_type != BTRFS_ALLOC_SEQ)
+		return;
+	mutex_lock(&cache->zone_io_lock);
+}
+
+static inline void btrfs_hmzoned_data_io_unlock(
+	struct btrfs_block_group_cache *cache)
+{
+	if (!(cache->flags & BTRFS_BLOCK_GROUP_DATA) ||
+	    cache->alloc_type != BTRFS_ALLOC_SEQ)
+		return;
+	mutex_unlock(&cache->zone_io_lock);
+}
+
+static inline void btrfs_hmzoned_data_io_unlock_logical(
+	struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group_cache *cache;
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
index ee582a36653d..d504200c9767 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -48,6 +48,7 @@
 #include "qgroup.h"
 #include "dedupe.h"
 #include "delalloc-space.h"
+#include "hmzoned.h"
 
 struct btrfs_iget_args {
 	struct btrfs_key *location;
@@ -1279,6 +1280,39 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
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
+			     end, page_started, nr_written, 0, NULL);
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
@@ -1645,17 +1679,24 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
 	unsigned int write_flags = wbc_to_write_flags(wbc);
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
 		ret = cow_file_range(inode, locked_page, start, end, end,
 				      page_started, nr_written, 1, NULL);
+	} else if (!do_compress && hmzoned) {
+		ret = run_delalloc_hmzoned(inode, locked_page, start, end,
+					   page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 			&BTRFS_I(inode)->runtime_flags);
-- 
2.22.0

