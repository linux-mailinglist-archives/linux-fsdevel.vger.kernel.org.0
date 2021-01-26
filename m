Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79653034E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbhAZFaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbhAZCll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628901; x=1643164901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEpyROl0duy87zl70YlYF58Pje4QttE4JRT5DM7flLw=;
  b=iNMEQLEgvfFRhJ2zAOFHy3aqw2x+CuxvZ8PBHWz+xAZez1A2SvPAQYcb
   A5J0vKQYfvXoEXIIj2Vjn3HK7mpHfxYyNCVdqpCpfUq3rw/abS9W6+of/
   4Mngz024vQ424dNp3YOEMRAiVHXUiJWoQq80UqtkBZdQahHwbfHu5aNuP
   jaLsFi4bOr6dxm6PGDTfVxcxtZEVkM3ua0J3xSNK68PLBQHzOADBU+n4+
   SELajYModTywZMlDDf68FX2jAem7Z9Q9yZP44OWpfMF+r9Wmf9swflWCb
   ejBmF+4WkMgDgetVMrI7thARBUyXUx2J1HVcwMgxb2Jc6IjRNaNKMcgie
   Q==;
IronPort-SDR: yqacMs1sk/2ycdvegTtZTN9PJwzTcZcsVQ2YpQ6q1+Xdqqk89thYeWdOWebg5HVCe+TYiYN7px
 FQVkw7OftoGPFSe13cW/7FgZGgR/U2On/GKGua6Uyo0mz/3bYDTEzPmeEUgaRLmbwJrcybifh7
 i3f28nP3MUnzekX5/KMtpl/8pyzK7KFR3qo45MT9VjtJZaUzGu+jIvFsr2n7l1mkk0vONP2Wpn
 BkypSP1G2+JYmN/U47QR7F0HvvDTLu7jjcPXmz/kP5VRvs6tbTXoXq1OenocWYlyjDpSFSTfoN
 3c8=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483576"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:58 +0800
IronPort-SDR: ifMP5iUvCT+RKUtBBmVMvepVNdWNGmN+VxbjkzM+W6V3WUeArJYKfBFgHOowqQViuKTGQiza4v
 a+rF2sdN2DnC6fNXVSjbLxf3M3v5/0i2VgOFeAF5we3rpgGoozWy0JN2ma3zU+bpQc2/8y1Srs
 ihu4P9IH+I94KDFgJHxmNXYQdC4yRV952sSlXbhFOUkeWxUQWkQmBIanksH2CWivOl1R2C7cxC
 YgNOrDZnqAxpnDzEL/w4YrCQl34dTrekMZmJ1sex8t1AEdpZOiA6hjnZXNynoNOkBp1JpyUsF+
 flDB/+VKzsXP8NXY8cnOsZVJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:25 -0800
IronPort-SDR: kQsRC8cwdpex/13xB54Wq1+UsLX2P2pk9IEutuzOwb8WUKEAvBGYnRmu3luTuLp+bho3aIsHVq
 jv6cnDShhvSlsqEvxampC5cSdid8Clmy7Q9/S6JBUyD6oqphApkqjdnHJuyfbSJ1MuuXVr1hQD
 hO7iUFxtstrpOgEFp7pHxSe+BZUDJf6UJO45RFNPCjuGxPZgZllbN/Lm65Jhf6pfsDQQ8uYOcO
 WaSlYUNMjoWGMqEX/P/kCL9MtkKBDM1MGilrPeZGLEeZVVbDRr/92SvvDsaLiKzLiGFMf8OBE/
 GtY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 35/42] btrfs: implement copying for ZONED device-replace
Date:   Tue, 26 Jan 2021 11:25:13 +0900
Message-Id: <3e67e5199d8472decccb96a10844d5265e4daaa9.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 12 +++++++
 fs/btrfs/zoned.h |  8 +++++
 3 files changed, 106 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b57c1184f330..b03c3629fb12 100644
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
@@ -1705,6 +1732,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_is_zoned(sctx->fs_info))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3028,6 +3059,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
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
@@ -3168,6 +3214,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
@@ -3356,6 +3410,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_zoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3478,6 +3535,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
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
@@ -3633,6 +3709,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
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
index 462a6337d460..ecda55474c20 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1386,3 +1386,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
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
index a42e120158ab..a9698470c08e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,6 +55,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -169,6 +171,12 @@ static inline void btrfs_revert_meta_write_pointer(
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

