Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD130F0DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhBDKb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:31:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhBDKaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434623; x=1643970623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eULFqCHZufhwsqXDO/ov5uQGBbrw/vQdJbF508DeY7k=;
  b=atCSq54EdV2DDSwGZBCt0hvKIlxhV7wIVHjsmFzqq2vlVaT4pZNPKLSW
   B8whyzcSHtNur5HWUu0W4WDMsEVXkMeoAIxjq9b2nC9RmSDG6iqtqvQeu
   BImu14nXcPvvR3Dqrw3PI27BVZV/PcPav7ZL0wTFad3dNXChh/avMrkYd
   ElSTbyvR7M1rg5lUCXGe4V9nzI2P3dCfhjO0Yk1z+m6wbYhcUThEP3Gcy
   e5Y45n+F1o3Ket1auyih9stqtN4vWCEmzvxvpSWnp/lu0E98lXi04hMxg
   fbD4m1/3WkeleS9EOdxv+iDxWJevojkSOjoa/1LmT9tAZmPbwHhJtgWb2
   w==;
IronPort-SDR: KHB0unAwi0aGGV7KXLIYrpLYufMBm2q3pZ21tLGHccyubC0hi1iniku2Nti8kpfArOyNx3InKq
 JUG8Xio8vwutwGIavTAAqtk83ZcBU9dAzelJFMq6iKYxsVfdDMaDKuXPYqFu33e4IKgcvLcp0B
 v25wXQ923a4d+7Sa5lk6ORBvYvPfVjIjggB48nu8Bryc4v3GUQT7Y/HKX2F18b0pNLASbMT7pl
 b6ovmc+VGwF4DTVf2rwNF1XW/lwWnsGCGRdJaZjZzHqwL4Vbt89EwMncjq3ogAhIC12vWCVGR9
 Ovk=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108057"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:42 +0800
IronPort-SDR: N9DJmRT704NcrzhaUrmeclGNK3eWe41AS8XIwOkZ8EZcz2bYJheKiOf7+ENObYVEfCgMK5dbel
 zNiEu+k9sja0BD+pAiT/tagKJ45kw5XPZigtGI+4R31KGWAT3lxxFB1JvrW9CBnizxyVHiPb6+
 A+h/GFnKxi0dfkEFc4OSBBQJefPIbx6e05C+y46e2yjrtI+QD/MuAXQX1d2wPVAnuJvV+/0SrD
 qToh+sExU+z+6satiXWfP6cKRcLw5EzlrItSLIubt2785cujG2VFLEw/y3woCUosz1G6Yy1asI
 EPqOHn/ea8U5ivlMKnSLxQB6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:45 -0800
IronPort-SDR: 6LFTwgSLL09dVZz9tkzcI6SuvLQ/nBpIQ22nDf0xWfQOwNw9kobR8VAhVy4oAFjd+W/SWH25+I
 dnQhYnbTOylUyRKdb5z+g9Cuxj1pvxe8WBnYxW7LmEHZAs4AFIXlN1fonZSc86gV3SZjk8PF8B
 6lRCAAQ0P1JDFzJdgeIsYlPXYNtEzku26cqucjYZM3wAbZcccz5j8Oc7ynec/uMEbc6pYYi9T0
 qr4DvoMNwIPvsyM57TJdWjJPrSqTabJKg4IhiZwlmuOhEz/xuhsW4Zjs8oUbTDq0XmsCGiumOi
 N3I=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:41 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 34/42] btrfs: zoned: implement copying for zoned device-replace
Date:   Thu,  4 Feb 2021 19:22:13 +0900
Message-Id: <e9d6d48875e80c7ba76cfb2e57a09bc5e1066f98.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 3/4 patch to implement device-replace on zoned filesystems.

This commit implements copying. To do this, it tracks the write pointer
during the device replace process. As device-replace's copy process is
smart enough to only copy used extents on the source device, we have to
fill the gap to honor the sequential write requirement in the target
device.

The device-replace process on zoned filesystems must copy or clone all the
extents in the source device exactly once. So, we need to ensure
allocations started just before the dev-replace process to have their
corresponding extent information in the B-trees.
finish_extent_writes_for_zoned() implements that functionality, which
basically is the removed code in the commit 042528f8d840 ("Btrfs: fix
block group remaining RO forever after error during device replace").

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/zoned.c   |  9 +++++
 fs/btrfs/zoned.h   |  7 ++++
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index da4f9c24e42d..92904902d160 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -166,6 +166,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1619,6 +1620,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
+static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
+{
+	int ret = 0;
+	u64 length;
+
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return 0;
+
+	if (sctx->write_pointer < physical) {
+		length = physical - sctx->write_pointer;
+
+		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
+						sctx->write_pointer, length);
+		if (!ret)
+			sctx->write_pointer = physical;
+	}
+	return ret;
+}
+
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage)
 {
@@ -1641,6 +1661,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
+		ret = fill_writer_pointer_gap(sctx,
+					      spage->physical_for_dev_replace);
+		if (ret) {
+			mutex_unlock(&sctx->wr_lock);
+			return ret;
+		}
+
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
 		sbio->dev = sctx->wr_tgtdev;
@@ -1702,6 +1729,9 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_is_zoned(sctx->fs_info))
+		sctx->write_pointer = sbio->physical + sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3025,6 +3055,20 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+static void sync_replace_for_zoned(struct scrub_ctx *sctx)
+{
+	if (!btrfs_is_zoned(sctx->fs_info))
+		return;
+
+	sctx->flush_all_writes = true;
+	scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3165,6 +3209,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	blk_start_plug(&plug);
 
+	if (sctx->is_dev_replace &&
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+		mutex_lock(&sctx->wr_lock);
+		sctx->write_pointer = physical;
+		mutex_unlock(&sctx->wr_lock);
+		sctx->flush_all_writes = true;
+	}
+
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
@@ -3353,6 +3405,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_zoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3475,6 +3530,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int finish_extent_writes_for_zoned(struct btrfs_root *root,
+					  struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	btrfs_wait_block_group_reservations(cache);
+	btrfs_wait_nocow_writers(cache);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
+
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -3629,6 +3703,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * group is not RO.
 		 */
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
+		if (!ret && sctx->is_dev_replace) {
+			ret = finish_extent_writes_for_zoned(root, cache);
+			if (ret) {
+				btrfs_dec_block_group_ro(cache);
+				scrub_pause_off(fs_info);
+				btrfs_put_block_group(cache);
+				break;
+			}
+		}
+
 		if (ret == 0) {
 			ro_set = 1;
 		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 52ec6721ada2..1312b17a6b49 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5978,7 +5978,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 	struct btrfs_block_group *cache;
 	bool ret;
 
-	/* Non-ZONED mode does not use "to_copy" flag */
+	/* Non zoned filesystem does not use "to_copy" flag */
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 72d9c8ba98a3..396723947934 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1379,3 +1379,12 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
 }
+
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
+{
+	if (!btrfs_dev_is_sequential(device, physical))
+		return -EOPNOTSUPP;
+
+	return blkdev_issue_zeroout(device->bdev, physical >> SECTOR_SHIFT,
+				    length >> SECTOR_SHIFT, GFP_NOFS, 0);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 0755a25d0f4c..5ed1ea2009ea 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,6 +55,7 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -169,6 +170,12 @@ static inline void btrfs_revert_meta_write_pointer(
 {
 }
 
+static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
+					    u64 physical, u64 length)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.30.0

