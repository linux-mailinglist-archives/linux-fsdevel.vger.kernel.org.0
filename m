Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47412F733A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbhAOG6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAOG6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693920; x=1642229920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BJYZ1aw+WlPJcGdpHT5BxdTOVhSDU0P/EHhQvQXEUE=;
  b=L+54gfJ86J5L/VzoHavFS4eLQTOGJnW9BkJY4CuFF/lluyRVg+VrXRb2
   u8d4nJTt6bO8x1BWCXXVsZPJYarP/43dK69iXRfQAq+6BioJjE7uDUovB
   uAeDdKPEh3xoBT9xEwP6vKmCikb+ntNT6HiWz0Zo5+ZHdkTQEcoAS3X88
   jXLD+FtEjhfYXGCPEz74OK/97K009/THOenivQbWKznZdWPfdnOtjk53Y
   25eZVmldhcKr/EYyZRoTximoKmfFeh089Dp8gfBs0olUe3/lqneoigsyR
   SvyUlmSNBd+WK6+dM1PjpMAEKnnJFIPWwqHGL2NMOFDBa6ooWfDMcnjMi
   w==;
IronPort-SDR: YfXPgmg+aP7Ym8TBmCUssLElVmUSP/06vRzjnSMm6WYT1fQRGKDEjiNviqcMbt4a6N4S2EgbKL
 5RZKpsWQFYDmssFeoID3Qbfe+r6UTWwKVc73SxjNpCLAGmIxMRt4PX5Ry/KsfPFIQEBXLlcxZM
 u0xOVynkqsKrUGb5CLqfYO4Gjpdyqx52pWq+46Orrq2ccJtJlb1pnQ5igPKb1A320obasjvQvx
 QQi6fM3ZGDnmiTnowpdqZXJ8+nVmGQdNqdLyqUJPjXiWw4ulApl5LwJTJFf/KURFctDU3UprHf
 G1Q=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928256"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:41 +0800
IronPort-SDR: R+YUF9dGbDfnMtrfEZgxFgWUB1obKBqVd94VRjVZLgkdRffDYyGu0Pw/KqG56xhkFvg8O6+BrB
 eoDnGXHr2mMLljQ/vCrrIjKPdzdXdr6kefHK9jg9/bzGxnowjvyuKdpwcV+b07HcNCUseLd4vC
 qEOaenZmTMRODVPTpdqfxhnL6uo7EXh6Ve0UNQOjCoEDyKzGFkV5U+gVzZNIzF6RqLmxxN5QNa
 /idgrwrQs3o9kw9q5NwTX9Ym64cCm2aV1/22j9xFM5M6iyNzCGtV+aUXmiNMftA1Uha5S16m9A
 O7/ndphfe2a5Yx5y6z0tAWJn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:23 -0800
IronPort-SDR: MQI5vOOvdbDm5RghpFZWraYHbHHhcupB+imkgRvtRUs+cWLDfmbrGI8lX77D9dOobNDoQuN1uG
 VjNzBwpiz5Z7VyVYHrw/ixe3R2jqJwVaeKep3Xh8jIRZpt924Xq8zxNKkCft8rZiIGDZBl/t/E
 rbnGIROB8GxpO1udlRjhIWTYVK9ro1T1uobTCXlDgWM0VNKW/PY+AecGVH9fJGhHVuoyeiq2Dr
 GJABcHgbAgIrXPgSjrfIrNc/Bj2c7M/llC1wckRrGHkZ2Aod61YDXDmMAY/ennVf00Cuek6CrR
 Pic=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:40 -0800
Received: (nullmailer pid 1916456 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 18/41] btrfs: reset zones of unused block groups
Date:   Fri, 15 Jan 2021 15:53:22 +0900
Message-Id: <b926e0d42cf6d893f738e1b8da10ff8a895bf26c.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
index 21ff5ff0c735..f7c85cc81d1e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1400,8 +1400,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
index c3e955bbd2ab..ac24a79ce32a 100644
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

