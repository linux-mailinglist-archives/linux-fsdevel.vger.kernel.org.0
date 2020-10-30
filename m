Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EA2A06F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgJ3NxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgJ3NxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065987; x=1635601987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwCgNuvrYa9VKDt9EmfgkB3IOrCEdDvJeqsCCLkM/Lo=;
  b=LrRaV8HojpN6DNa0X8H36XcviSsdLf/M+oMjei98jMQJrPtNuJdamMXY
   iXCXSm5zc5yeY081yP5pszX1lMbIufMgja5CWqEboSlo4RFG0Gut+u9qU
   iOWCgmMoFwVquDG4hZUN8jP9T2qdcY2u09aYOfM7QMsPa9wS9yFH8zp+R
   hBL4ycxUabQRh+n70ryHcdZwtVg1XCPZmmBDzYXZ3lKolL5gpeNc2Idl5
   IqpHqi1ayv1/EWspOcTUONjngtFEtazXNMKwAHCEV/Dpxm/cVgarLFAQa
   TPO86xEru8ghajJpVHkfrFEZukMTbPBlzdQNGQdUEkmH7o2mZJnINZvMw
   w==;
IronPort-SDR: /Plfh09zZ7y0zpqPspR4OhLeKg/6dTqMiicL75Ntf2qTUoM/mG9lr92dIxrj/ZaX6zM4ZskQwZ
 seEH115t3LiW/xum549FOIeSaCS5e3inVXRvDG8zkT/jzvPdgbT8bdSkFbno2ag26GR0PzMwd0
 uVNVUDs4ovx0jrvqfZ7Nb7ChBhCrfQBuHPzCvJA/qRmaxMIgNi2RZpT8ILtY35tDm3ba7KkqJG
 57AlxvZ33/mAQP3N09GmcdjhcUqC3wGN4P3rBjJ/NUMXYSsseWHfvRHNrcYDZ/RPBFHZ9mgJoX
 dPo=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806639"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:02 +0800
IronPort-SDR: 5ZYVKZrzYkjBspmaodt3SfKWMq9te6yfenkfePei2v2Cvpju5lUfx1iYxNOYqs6dWYxp8+AMVQ
 6utYpfPoko/3BmSwTiHUTfUYkwFN/kjwYVq/5G2qmA3xpTIaOLXBKaagbv0KB+PcJQtYj1mkUP
 1T/GaaO5cjId2T0h3ZZXPoVOhZEiA3QXXQz+wgGXlpOMEZ8YnsCFrM7QRrIuiyDVpb1bKADfty
 RQIjYyrP2b+Q8XB3YCJ5eUEmoSkOx8bXHOaWvKqg2rC19wlexTroBmgEfCF3S99ShpgQIB5XNM
 FD79HBjfi7rUYHk/V598hiqz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:17 -0700
IronPort-SDR: w4DbssFe3EMeC+FWQBjRVyse1K0259hA5NPI/KvGAQBV9NKaimjWC2aCmlV9FhRnmNfu6t/Ist
 9WMhlVydgsJz7cd8PlWtwzDEujL4OiKAJThzm/G/2OOLsrq3PNglCZwYNuNJBnXreNoSWpxSoE
 kFShEhWKPr3rxrrMs0EzV2ed54B09D4nES3C+oxRORT/BLzbLN0kTojNnx4X6o3t81D2qW3CtD
 jV8WBSWJpa30t9WcfclXFYNrzVrfBU54LQhyLbu0yQjoTWkbPvCqTPUqxMVNdIvSBq/NsnpvqN
 +I4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 34/41] btrfs: support dev-replace in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:41 +0900
Message-Id: <aa19bede48b24e48c10503604fd95e14557b7cb2.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 4/4 patch to implement device-replace on ZONED mode.

Even after the copying is done, the write pointers of the source device and
the destination device may not be synchronized. For example, when the last
allocated extent is freed before device-replace process, the extent is not
copied, leaving a hole there.

This patch synchronize the write pointers by writing zeros to the
destination device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++
 fs/btrfs/zoned.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  8 ++++++
 3 files changed, 113 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aaf7882dee06..0e2211b9c810 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3019,6 +3019,31 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 		   atomic_read(&sctx->bios_in_flight) == 0);
 }
 
+static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+					u64 physical, u64 physical_end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+
+	mutex_lock(&sctx->wr_lock);
+	if (sctx->write_pointer < physical_end) {
+		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
+						    physical,
+						    sctx->write_pointer);
+		if (ret)
+			btrfs_err(fs_info, "failed to recover write pointer");
+	}
+	mutex_unlock(&sctx->wr_lock);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3416,6 +3441,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (sctx->is_dev_replace && ret >= 0) {
+		int ret2;
+
+		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
+						    map->stripes[num].physical,
+						    physical_end);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b080184440d..f98aa0fae849 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1193,3 +1194,71 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 				    length >> SECTOR_SHIFT,
 				    GFP_NOFS, 0);
 }
+
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
+	unsigned int nofs_flag;
+	int nmirrors;
+	int i, ret;
+
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &mapped_length, &bbio);
+	if (ret || !bbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_bbio(bbio);
+		return -EIO;
+	}
+
+	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return -EINVAL;
+
+	nofs_flag = memalloc_nofs_save();
+	nmirrors = (int)bbio->num_stripes;
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone);
+		/* failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+	memalloc_nofs_restore(nofs_flag);
+
+	return ret;
+}
+
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos)
+{
+	struct btrfs_fs_info *fs_info = tgt_dev->fs_info;
+	struct blk_zone zone;
+	u64 length;
+	u64 wp;
+	int ret;
+
+	if (!btrfs_dev_is_sequential(tgt_dev, physical_pos))
+		return 0;
+
+	ret = read_zone_info(fs_info, logical, &zone);
+	if (ret)
+		return ret;
+
+	wp = physical_start + ((zone.wp - zone.start) << SECTOR_SHIFT);
+
+	if (physical_pos == wp)
+		return 0;
+
+	if (physical_pos > wp)
+		return -EUCLEAN;
+
+	length = wp - physical_pos;
+	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index fb4f1cfce1e5..bd73f3c48c0c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -54,6 +54,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 			      u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -146,6 +148,12 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 {
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
+						u64 logical, u64 physical_start,
+						u64 physical_pos)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

