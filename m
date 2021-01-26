Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60F3034DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbhAZF3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbhAZCf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628527; x=1643164527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQaHpRpvpvOmMKBtrqop2a0m3vKpXCqXRe8FvJCx62k=;
  b=lJE/GqxoCVf+wURRfSH75apFWe6SXAvFKZZN3TNWp4nbKqrzt6imjvdv
   DxaXTCXp0+gZ8FOz3fDi33ojf1QDvgt6LkmC4ybKuudwNuSZPvk/Qdzin
   69Y+l1ZyLadJjbAg4kN7nY996z7HEf1F6QWbbnA40TZoUC6M7EYBEhAbG
   lClzUBIR7iD1Hr3BEacrA+MVeHLBiEFamtV0uxJaUUoHIbnWW4p1dEUMk
   83bKcUo3HxyBazHVasoIxtWhbiBhw1E6WkEtRpkwhGOoyBksETZIk9WQ9
   nC6oKnj4NnwNa39h/vL6KoMt/sEuAkZ7PJzbycxL5KA3Cm278b3eOuLKb
   g==;
IronPort-SDR: FfDIcsaM1bwhI1+QnAIOn7MBO+hv/Z530ovQU2Y/6/ZO0QNAOT8HgPzLPJhe/+NbfrP01qooAD
 msS9+p1O3uAZp36mWqazp2HicrP50h2aADdhSnEGMk2ppkGvvS1PSKgwXwXW79XmQ2sD4Qnzlc
 WQEvCWncEEOrL63P4dsrYcTMZPA41xWlI9nwwEsNc3OKa9MCcYoMHrqAQWIVcIx2LyqYru4FqH
 E5QyZUralUmMgmBzLW2UIfH8iLOE7IWgt1L/ZmRp+VQc9gjpmAYvxlSAF9gITtiNNZO2axEUH0
 dyw=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483542"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:30 +0800
IronPort-SDR: wKzXZdoerhXJpBswUgouKVvc5yR7QAAXZAvVUeMwi1JPbQqC+ASGZgekkTfTSF2Y786+VtVnj6
 eSWhokvp/r1tm9bRStUBFw7fYymmmSY7sK4u4XL+ms27IIYiOz5ZQ1yxV+ttWcMEFQWwOunNGV
 SkPZxFcFFiTdu5N3yK42AmRceeNPWqR3/rrJPgfVKX9o8CPzLDFmQHixLiJug6kJmZS5PejYEK
 0oRXquQgo6GpaGID1T5gkgZaOxEL0jcQyxKvtixMHRVp1X4C27dRFB/g66BbQKPhBOLXueqd43
 w7VCpOKObsXzPnBVSOpco8TQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:56 -0800
IronPort-SDR: 83UhUV6g5XlHJfVta+zVvwoiadUBXAPQY3pWgr2/KTM6LaUrWDjtrg/r6dV2v4eDmMuW/dzajq
 Qv0REkHplS2vyLa6i4nLQk9EZCj+d8ZjXstdYE5gmsKdfQZd3elujOz+MBfq0y0K1o4ZrsWh6T
 7Rw5gpUJYMmf23CMLOcuWa4YcU2R+/m+947yzxZADGwlTPLPGH5V5+/UZYREMd/tUWNFl/IkHn
 xKTrFmZbKFiywW5BJUN+okypU+8wiArKwiNh2W2feuHBYfZ3qu/5gw1hh/k8BS/fu6riF0PeHc
 6RQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 18/42] btrfs: reset zones of unused block groups
Date:   Tue, 26 Jan 2021 11:24:56 +0900
Message-Id: <10c505102feb1c7bd352057ed528b1a04b36bb57.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an ZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f38817a82901..9801df6cbfd8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1403,8 +1403,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			goto flip_async;
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
+		/*
+		 * DISCARD can flip during remount. In ZONED mode, we need
+		 * to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+				btrfs_is_zoned(fs_info);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36a105697781..4c126e4ada27 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1298,6 +1298,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1305,14 +1308,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+			/* Zone reset in ZONED mode */
+			if (btrfs_can_zone_reset(dev, physical, length))
+				ret = btrfs_reset_device_zone(dev, physical,
+							      length, &bytes);
+			else if (blk_queue_discard(req_q))
+				ret = btrfs_issue_discard(dev->bdev, physical,
+							  length, &bytes);
+			else
 				continue;
 
-			ret = btrfs_issue_discard(stripe->dev->bdev,
-						  stripe->physical,
-						  stripe->length,
-						  &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b2ce16de0c22..331951978487 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -210,4 +210,20 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 p
 	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) ||
+	    !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.27.0

