Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678CC85E67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfHHJbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfHHJbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256698; x=1596792698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnp/vX92Ol+fm3AJcz5D2qt3jc+Tr939ENAUlT2pB5E=;
  b=hzacS94wazbmSRb8LSyLeAt76X81hi4D2dq47Znw2lsElv1C0VpNw3di
   cvKOJw78yWHtX0wuJQCIZI2NyvpMerPR8d0f62xrSoHTlPfWqrEwuTQOv
   FM6pNh0S1b2zJJrXwCtn0RmuscwaU3ixpAu2OzMb8gd98VmTR/s2Q8vzP
   YA7Y3r9dRDz15LgRKhHv4j0oj629s3NOztn4OeI0Q6CgjCtmyyuFx48yV
   D0I7mpCr+iH3A+JYgtTDo+cA3crXI5VCZ70BoJRgTk4PObhG1g9SmC/1Y
   rcYMjKtingdQkw+p5hQh/KgTTGwGm0gMRRSQcbzIah4uog5rC1VeJn3vY
   Q==;
IronPort-SDR: 0Gyn6HW12bTrGyOeva8toH06iRlM9H5A5OI2wrRRSnVZpLlLy9QSivbJrBmkfhidQ6gCD2084+
 nhoxeJMDIeGJRic/OG3yvCMV392XpSN058FSyoc0rV/HnLfkAQjJp8ReXUEaj9wR4L4gXh4Sjd
 EHLkb+nHv8i6hXou6WJHoFw00afHMFDXTStK3ico62amZA/12LcQcD7suqnmgDCyHc2HQTtKsk
 o58u+8zyYA92pY8HMKh3UibI4OA4LA8ymRB7lI7DCa9ETTNXpnCqxJ2v/qmn/2sOY6ENY6zYOk
 5Ac=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363370"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:38 +0800
IronPort-SDR: uzwtNRcJoyjn1DBDSlVyYg0oHWq2eBbn8OtnCaVFBvt/wKtjbSpdZvatAnZ6BsD6pBgujOtC/H
 MeWwwgjEJ/weHEEWJzqJcaS9YH4kQoa0u1hYy3vudeQgMHtmQcT+xPV9rOAuDE8GTNjpn7Of41
 /3NzQ5NcNJQFC9RXaNUPRmQrzGUPFnA9u/WQ0FS6hmZ6xbPS8EFWijfS9vqgIP1314yI1rGG6X
 f7wr/RoFzOnQiFh0FpNmP/ppMoeDm7q3umS7okYiNJ76pa/1cI0gRhhcdnW7kaECBKiMogD7ZE
 9lbXn1R0qBrXA1wZmLA1L3g8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:22 -0700
IronPort-SDR: J5GqJEzM8HhV0pXjAe5bD2rmHw/4IEaW/ZcVEqaS0eHig2xD48sv7pK5PmZlS31U4bNfqz7uib
 3byRjjpoOfLfmEiGZLx3VhQ1tcJowpqCxv1uy9Gk1N6FqFx2gQPkDnTdmB2FZJg3L/ghxvI8fM
 jv7TJN3EhXf3b+6OfD9TzFVYzg/L2W9jUO0CFvkmfZUvKkxSdvPJ1P+Xde6ArwLv30EusAVW1R
 8emgh7lf+VOjPdmQNrBED9y72jFNtuvPGt+3oJu8mgdi4iD8m3O/KvkrT3TccZI98DKbI0SPtt
 i7U=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 13/27] btrfs: reset zones of unused block groups
Date:   Thu,  8 Aug 2019 18:30:24 +0900
Message-Id: <20190808093038.4163421-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an HMZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 27 +++++++++++++++++++--------
 fs/btrfs/hmzoned.c     | 18 ++++++++++++++++++
 fs/btrfs/hmzoned.h     | 18 ++++++++++++++++++
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d0d887448bb5..8665aba61bb9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1936,6 +1936,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1943,19 +1946,23 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+
+			/* zone reset in HMZONED mode */
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
 			if (!ret)
 				discarded_bytes += bytes;
 			else if (ret != -EOPNOTSUPP)
 				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how that could happen JDM */
-
 			/*
 			 * Just in case we get back EOPNOTSUPP for some reason,
 			 * just ignore the return value so we don't screw up
@@ -8985,8 +8992,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 		spin_unlock(&space_info->lock);
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		/*
+		 * DISCARD can flip during remount. In HMZONED mode,
+		 * we need to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD) ||
+				btrfs_fs_incompat(fs_info, HMZONED);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 38cc1bbfe118..5968ef621fa7 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -596,3 +596,21 @@ int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info)
 
 	return btrfs_commit_transaction(trans);
 }
+
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes)
+{
+	int ret;
+
+	ret = blkdev_reset_zones(device->bdev,
+				 physical >> SECTOR_SHIFT,
+				 length >> SECTOR_SHIFT,
+				 GFP_NOFS);
+	if (!ret) {
+		*bytes = length;
+		set_bit(physical >> device->zone_info->zone_size_shift,
+			device->zone_info->empty_zones);
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index e95139d4c072..40b4151fc935 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -32,6 +32,8 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache);
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes);
 int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -107,4 +109,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
 	return ALIGN(pos, device->zone_info->zone_size);
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
2.22.0

