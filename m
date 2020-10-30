Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0652A06FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgJ3NxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgJ3NxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065987; x=1635601987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1C/2p/Nba/F+w2tDO6tPz67/tKR4rWG74TMOqTsf+E=;
  b=e2HFm+xasqZH6Abk200UFCC54YPdZmSfFH6BLAG5ND68yRLGWYHysUdM
   TbKvxXmlR6QJSdhJCC94+WttdRcAfvjGInbLdcUyjbahVYIrh/QGBVI+N
   Bc9Kfxu/uGmEssj0LiXxUD2HDRCuD4jby20usQrC3EfpyVyptujd9Q1C5
   P+/Gei6wmtTttPnFIEYmP4kLF5JS/cmwEwjcDDDKuYQtk3M4dP2C68ZED
   1DiTT3suvVjTgBdWA3Zg/tZ0Oi4+R5BFbCVlskzIu4EOHrMNnoY1Z2YDS
   vGF0qyv1yIGmbksL0LihAxtqh+aih6h5FIoEkehlOD9qpNh/nkCfTU6kd
   A==;
IronPort-SDR: I7PGtxbyvFaPVNGaZzmwNlGzluRMOmuaEWgq4Ni2svBuqnaImi9GvlYfSoP94VAtstHaG2Bit6
 4DHY5hDOhL8tsksVJ57lQehpxHFwzb3GWQPsN1v0uQ5WpgVfWgTv8QjqB6T3c7eCbdMH0hIQhQ
 YTurdbYwg5fHjwOUwdY4uhhV72hT8ezWZGIjijqut10EMJdzqQST1zRnT3bQ/mrBumAvQva5KR
 NUUdm08oSZvEx+prrfne8mXcsa2s68Rb8mBL2QrBJjidEeQsEZb8n9iav+tnEUUxMCiI1x38kQ
 LqA=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806638"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:01 +0800
IronPort-SDR: wo1pIKdBil/Bpt//gM04kXyx8r+iUCuuLzXVHqx2eD2M+updbIgF7kJKXr/l0DY2+lHyt5LGCL
 Rq/NdQ7LgOZaAMcjqKMuwET3f2nx1Gvqb077X05rkqsTw3QD1SIqddScXB8RjbEXiSZHOYlKvY
 LF0TRJGVRhIWOwPkFqmkxgI3NrKGnd95DVpeAvxKtWqF2Y8AqbD6tXWVkPpTR+KYazKXBZHHzq
 AO9wSmUNZQDF8H6j3FR0NdONdIIbVazw43xF0rWZpPaBDYlwfPWz8aUL/jkdq1W3NaAfg20GKB
 iWjMqrab1vYN3UbICZms75s3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:15 -0700
IronPort-SDR: knsOkGky5Kt2xMZ40AZj0axnj3EoIw1Kuxy16Zeobu32E5e+sSfRKOCtHl2JPf9ZBqrdiAqQ89
 1M7sTa482k5UOfcXLoRM9LDteBZfnKfCyRGCElrP0aG1ELfmOsFc6EZu/8JUoAH3Kf2IA28jQH
 qybVkOzmqs39YcJxqY5TjuJdJzpmHFgtDt7mYNc2CnqLJycQ6UrHglj/bEJpvToDxuBVdUBIir
 XOHU7FLxw5lanng4pCNX+R0+kONaRMxX2Jd2CtJCaoWAAOEiVevPXGBpPNcAEpBbscyoKfebwE
 lj4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 33/41] btrfs: implement copying for ZONED device-replace
Date:   Fri, 30 Oct 2020 22:51:40 +0900
Message-Id: <2370c99060300c9438ca1727215d398592f52434.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
 fs/btrfs/zoned.h |  7 ++++
 3 files changed, 105 insertions(+)

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
index f672465d1bb1..1b080184440d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1181,3 +1181,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
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
index 262b248a9085..fb4f1cfce1e5 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -52,6 +52,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -139,6 +141,11 @@ btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				struct extent_buffer *eb)
 {
 }
+static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
+					    u64 physical, u64 length)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

