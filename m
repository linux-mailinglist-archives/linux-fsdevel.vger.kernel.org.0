Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597E62AD51A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgKJL3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgKJL3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007762; x=1636543762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7E8uxZdIsUk6LH6L2iVS8j99GufLQmEbBv3oVYR1fc=;
  b=JY9HgxxT/XLyP9yHiKDHUTTLFj5O0WoIOIhDcRz7VXazwQpaILy7gEWb
   l/AkYCh11Ek5xWrCFKbvxUq6uFC8h+mp+UNtkOLGJ2HKOF3FTgMq9FOHK
   1dyzrfa6oUXyZoMOyxtQEecREg6KIutk5G60gD9sr33k7GEeBwdciIYcq
   ef96YdnwavmtrZ552LEAbiXE/8DNelXUoftUSGMprV4/7B9Sc2vU07Kkt
   qXxdEmxrtn1qWjRCdZboN2FL4pUTavVHP5Q24PlAhoBqXXh8JGHWek2Sx
   8H6bvYEzAq4JAbLZwhzgOS4drks8r0T6U5ANS+LmDVtEyNNeXt49a9pLh
   w==;
IronPort-SDR: c3PEl/vrmAvpqgs2wjBUnmA1fBD9uYhETiMNu1c3aP+ao7kd/2RPXxthi4aMGJZEsIfOu9dkTb
 DfBCKT1ljHDuRy412ksy6pSLpHCJe/v0QSqcfmGOryBml4iAkkgVGmbcsbaD2I2bTGwMGtBH7j
 l1Sd4jngxTDI3S+qmXz6yNHzrVFxnQd6HIa3tcL73LVcJonfneWyVsAtRmfnycxNsi8vqUt18r
 rz3+RI8BZ8yhm44e3ylMnYnXn5I2gW+tLpEPEhfpJNoRdAN/5ByLri2VuBBs2HOKR6DOA7D/eb
 d7c=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:58 +0800
IronPort-SDR: IXuSQT+nigbB3XBoAoJGc9IX+lU1RmccUm7gEcbw9dv21BkOp1w9U9JzuqxnzybSkpl3SKIaq0
 02/MEJeN8Pd7SzEPUB+7O+4VO4U0ArhoyGz4HqJnYNBWOavypcoVgAzq5Vh+e0YPJjddGDfyOo
 3w8s3TEC+tCup1lKO5pmqzDC5UBSqt8Wmgx611peM8ALzMGz6zpCyMPs70MUlZ7/fZtk+1qZhr
 eDX1RCsz3/djxk3Ek3/8buOj8fwdSAhZhhqhoulJ1iSFI1yVLF4GRRk50B8YktITAI8D1nv0/O
 dqdIks+Chitea2SGURjH0aIj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:00 -0800
IronPort-SDR: +1HAFVzF5Oei295J29EB8YF79qoVEMbaSL0fXloEMH3/fFXFM0cSIIRZbs9nZR6eMDpU+YVh3T
 lNHI0waYZNaBHz7rQd6Y3Ic2g3mQ53iqgmMFzuj0V0kp1/0a0TUTzlwxl+TABozeseB7nq0KsL
 UjHRDGRCRjwJVB30dFRJLY+FBRQfUE31Qf9IVNGIOvK5JO2xw9HtgTnMKAWXPnc7q3gHz3GrjO
 KkkljrU7OSGGTdNH99Uah3tGZWQepcQqdUP3U4Kc5jAFbkcggJ8mypXm/zKAtIkwbnobqr0AG8
 SH4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:58 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 33/41] btrfs: implement copying for ZONED device-replace
Date:   Tue, 10 Nov 2020 20:26:36 +0900
Message-Id: <3518b93d16bfa5f0199a278b4cba6711a96661cc.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 3/4 patch to implement device-replace on ZONED mode.

This commit implement copying. So, it track the write pointer during device
replace process. Device-replace's copying is smart to copy only used
extents on source device, we have to fill the gap to honor the sequential
write rule in the target device.

Device-replace process in ZONED mode must copy or clone all the extents in
the source device exactly once.  So, we need to use to ensure allocations
started just before the dev-replace process to have their corresponding
extent information in the B-trees. finish_extent_writes_for_zoned()
implements that functionality, which basically is the removed code in the
commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
error during device replace").

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 12 +++++++
 fs/btrfs/zoned.h |  8 +++++
 3 files changed, 106 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 371bb6437cab..aaf7882dee06 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -169,6 +169,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1623,6 +1624,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
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
@@ -1645,6 +1665,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
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
@@ -1706,6 +1733,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_is_zoned(sctx->fs_info))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -2973,6 +3004,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
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
+	wait_event(sctx->list_wait,
+		   atomic_read(&sctx->bios_in_flight) == 0);
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3105,6 +3151,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
@@ -3292,6 +3346,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_zoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3414,6 +3471,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
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
@@ -3569,6 +3645,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
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
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8bf5df03ceb8..cce4ddfff5d2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1189,3 +1189,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
 }
+
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length)
+{
+	if (!btrfs_dev_is_sequential(device, physical))
+		return -EOPNOTSUPP;
+
+	return blkdev_issue_zeroout(device->bdev,
+				    physical >> SECTOR_SHIFT,
+				    length >> SECTOR_SHIFT,
+				    GFP_NOFS, 0);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 41d786a97e40..40204f8310ca 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -53,6 +53,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -158,6 +160,12 @@ static inline void btrfs_revert_meta_write_pointer(
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
2.27.0

