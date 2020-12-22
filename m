Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975AC2E0504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgLVDxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLVDxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609230; x=1640145230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAi8e4ryOWkS17e0NBHujW2cp671zJWKZiSe9bRSrZg=;
  b=Xi7IsKPv3NWcshfsraJNq1C6ifkSm6pzFPNR9Kw2VBGO4Spwd5RIdKBP
   PiJwtPvaxPsyRT1sb7QSjt8NqmEdLuj6LKRwNhZt6Gk1TQfR801iSksr6
   sX47U9FgvhKSHggVeWcIZ6H8BdNHmtZ+sTirKomQ4SbFd0j9LnkTwdHpG
   WjfY2vjCyYFsT7E3Mf92/wjxY8ciE81+hpTuqk5pK77lMLw5mvAUFSuhw
   VgjOXzbkliFJIbOAmiO7+xuYnqlk0GQ/a2Pycarmx5S8L242kEvUvC+Cl
   q///b49/luEaz8zjrsb5iMJmlgA1e6PqyvcGYQOTNPLzkTRfU6wSI41Vr
   g==;
IronPort-SDR: h+NKtwcND57fWzvkugz6dTWSdEBgq0FJmwgxtZguSYJD61ytQYmphQqwJVv9gjkntUjTo1BKB3
 dpQGMwmR5OYKJtG3mTO0QfwqvPoo1PwoCn6lWor2p3PVP4GMEVc5uFeSiN/OgZ79f9/RlGXKmY
 WZLRgw5X5AzPsAGUbM2YuNiJNaOHBl6BRAo3NQXUNty7WsCzbvFkt6OX1qnTaDJTD8XG7Jiwym
 /oD59p5qeuvyfXYs86gA6GLxIRDUHxPWTrf5L3MTaAAAQjr6QxtpreGNd0zgy4iAlEMyB79Wsm
 Mhk=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193785"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:53 +0800
IronPort-SDR: tca8aiMn29sqJPItghVM7uUy4XsJX3K+B/f23NRUFbjNc+ltkDc3JqvC8z/kNFPoLK6hRf56LY
 MxQoQ4TjINA/2p6AYKZ7ohrxvkW79xi53CIAdezlOCJlIehFRAyf64UJpZSGBsUDXwuN5Z169m
 I2QNoLV7REU4v/pxegyTKvfLk/aX3lWS6zTZOyBWlXaRCtIUyIeyIJcsO9b1N5fWUheZR4Xdxb
 3QzW1PoGvo3VUz70JBzHCN/fQlrSk+aGSlzLfqZjuYuMpNsYb1mlBX6kDEg7cWDklYxJfZ75b/
 U0z/MPtk+aG00MMteNXiDdeU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:04 -0800
IronPort-SDR: 3eM7reyrx3lfYErw5EfIdm1C6kYmSABVo+wCTq8PT563rcjkAneUKdj571W9GUDfZ/c+Z4ZJMH
 WNw1B6NYOqI4mAVKnYzpID8s9S4rkLlBoO/gyvaM5eCHk21bEfzAwHahEsXuPzNHJYUFBbgCLr
 MR8Yy7mNobvhUvLF2yvkf3J9J0JiR/MpLsJsVzrR0JnzSQxrUaz7I4L2ObsnXMOw4ylVJoHsXg
 fFCC+gYCSJ5xRT3e5bs4G88E7JvHjqVbdr4FOJY/dZqbQrIEOWJ7gSyPYBGP0a8VGjwJ54c/Ag
 L9E=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 18/40] btrfs: reset zones of unused block groups
Date:   Tue, 22 Dec 2020 12:49:11 +0900
Message-Id: <bd2bdfe3a51d928eb2e948d4df66683e5cb1c6c3.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an ZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index eea776180c37..9bc6a05c8e38 100644
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

