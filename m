Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9877E2FFC9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbhAVG0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbhAVGZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296746; x=1642832746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7QyYw3V4ker5UN7e3i23Eb5OMrt3b58vDZYUM5rczo=;
  b=EhQVcNpYzEgELUby6FigLeyO40IXGaxCbcKO0gFUmFPbewsEuLeW+um0
   bLrY+evEXogjrU1d0F0KT4R1dKOKRF75ru30kSkbod6/vNxjjFjHkcmYs
   MYDbEE06NR+COF/hNC9coHd3B40JwIl68PbBxNMGAEGavWCbKwijRsWHV
   5GJQK5bJDM00Zl5UJiDa7gz73BdaeJVLjAGaLnOEJP0ZxNsltJEZ7mTyL
   gTnsFOH+ZxDC8adpKJAVMS7uE90LMpe9lK1QONQvCvyb1ZmVaJL6XEbtO
   piFYpLXWoI5SFAhqV2rVr+vp8FCVgGfuK6Cel1b7UMQGf25lJEbVTy2nB
   w==;
IronPort-SDR: 6pRqML5o2TwBI/279P2J851lRvRorXW+pU1YHkByUzCYhAE9e4pp/MreecnlTXVRg5W8IT9Q9Q
 wwCzycRguwM5Ng6B07G4WZhaDtFLudvS94yCVf+31VA7eGmSiABOFZiRY1+VyEjAhJbER9s0sq
 OWIRaNjCTMvZjAGQR3W/UavTpqrXs6v+RlXL00pJ1nBCu1tYGCMv6iAjU1MWWeO7C/F/p4XZoF
 lwiasEdklUb3gYFXta+NAb98165ts4Ueu4qHMJLi5NdkXv5kWUJknEv6OK21+ZKHjg8ktR1PCj
 THQ=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:50 +0800
IronPort-SDR: dGx106aXHODaJ03C7pnyxx15R3NgK30k0tunVdEm0QYkha8St40NqAOtRaUMsMNvRW6oT00De5
 ZPQoXpUbgO5gaZqRNy4HylKkg28A6YCVeYYKlLHQp3DXLCq/ftbdFzNwGM1H2AsN5KztwBMPYj
 hUDOoEEht0FRgPFpmF78vIIJlGeLwdKVXKM5FDNbW4RVUodhOiDMGA7xRjhj6VlK6i+HUPZFBv
 7GebG5aULiSFYMEFxdpXN68FxIIGzZIyYLgZYa0mrg7tyqtfVOXddGFNXFJBpYI51XIcrksPbK
 AyJnRE66HKfAv5izhEYoTJGU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:22 -0800
IronPort-SDR: i3TsLEX78CL/gUyIbDFFhXg2pSEGcNx4kAJxHucpnMJ0yrGAOR+w402l2IpjMqaVWyzdhmWCNm
 YLFeM3NYa/sm4rniafMEXLZ8bCxyHug0OJdIH3GdW/kkZnGF7mQ8L+YaKjnIm/QqggpY20CAiG
 ZDKty0cL5XWrJ5vIn7UmiWbL7MJsny4tyuX991XxQ0x0FbtLwSQhGFKSbf/h8M4xGQNM8GHB8q
 bAv/RaWeFPYLFQWqbVBwgseW7JgXwSKYNZYB6W7L0Y+CpiVxOPL2EUxb4C4WjQyE8M9G6Qk4Cr
 4wY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:49 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 18/42] btrfs: reset zones of unused block groups
Date:   Fri, 22 Jan 2021 15:21:18 +0900
Message-Id: <9c1916a262fd8daf176abfb935de904ad83e1ad4.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index d4c336e470dc..e05707f2d272 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1391,8 +1391,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
index 9dbc8031c73f..6a644f64b22e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1333,6 +1333,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1340,14 +1343,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
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

