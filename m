Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCC30F087
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhBDKYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhBDKYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434281; x=1643970281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TRIIwMxHz8AYXIAQwMcpVIPM838tqUOQe+pVMTcvumU=;
  b=M1LLpXsv+tU2J8lRVZiBNazUqXDSRYKYeFtPOgCPG5rEfTS03DKRQd3o
   Vxs9TxJD1um5RpJrmgFhSdG3kKtkTFmxUUXeVjQuFtOmF3/5IK3Mdd1/M
   1/L5iMz9lyyovbOfCwKzkVkjzAWmNg8gCkOE75QiC3RS56Od99G5JcZ2/
   Yo3sjhNpXtNIJj4XpVy7mBe9grlLFaW9alYeOQF1kleU2b5DZPWrHyRSJ
   QrFJoHrimCmm03V8neC7idM3On2rGoP1gI/U6lNw5JsCQgY6c640cc4FL
   hH5xgGaPHh3Mecq9T0CkVWqoaCgCqb/3752XDuTs8ahDIFIKMzEC99s7T
   w==;
IronPort-SDR: hdXqqbTTjuvb9UAjzV0VKn5dLTnEMQw2Yy9tJqmfpR3LUNwHdSvBv2FDb2m/EtjXbwdF4qrZbW
 kMErPv/x6DYwM57zExnfDbL9xSUxCFnyYqr76q/pKWl7OcMK9sMov/WjrU0RrxQdp45SosjxcT
 ltK7ziE8Pbr6mj66tKmR2LCw1Pl96wwS14+d7ZL6niney3xPkN1QgyI+SflyjlLZPrsj9RWwI8
 qr1hwlt19VEd1s1lygM1tvuEUl1uWuC2S41EtrLufRcCewgjB+8PyKnHjWnaApjRuVC0OIZW3X
 HW8=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107952"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:00 +0800
IronPort-SDR: UdemrVGqbchGRWB3xF5muBnrJejNnHimSvtJr4hiLtgDKgLPTKXj7Xndkqlky51WltKKAts+dl
 TtmXH4Xz1AZ1zJBCBM+zjxQFb2k1S9Vfeyksq7IIBKXOa/a5KmpooxZNxCmlRMvExmOsp+BCNH
 vGCLnuIUwBB2ToW/cz+k7Jn50HYEhY1GsOnJCfqXh/PO1mkSZD+LMb451eVvzS1vwk+sCah9Lz
 BSPb8d3T6/4/V9AVoRAVkk1MmrXSxzXkLSghULWbS4DGCxe7OTYzkuM0LJPP9T+5vvjymg6Q/H
 awYSFTVz5IyjK/Z0HNRAZ5bE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:03 -0800
IronPort-SDR: 0zUz16AZNbMTwZ8N0B/1YV3ome2lUnDX75znjW07ME+9ne2+25hN/XU960B5h/5wxcdNouT7sL
 oOKX2hHS8eIdLpL3aTUcvUgqtLp97olKFEZKybuxQiFl3PD+xWSkBqh6sF/jFt5ASfSxWwyoAe
 IjFBEy7qn+dRDTDjfgApWgKurnPUoea8zsYjaMEwIHyt6sQvLxkQdlwVSXinFIL/4TiDBwDcQw
 R8D/0q0Hs8ap8446jy03tSGuMBVlcYHXukbaC8YNfuz56vA/eKIHxNUdhuBRJGFRyJDBmYCmBE
 puc=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:22:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 04/42] btrfs: zoned: use regular super block location on zone emulation
Date:   Thu,  4 Feb 2021 19:21:43 +0900
Message-Id: <906d62e60392f97e9ce10346ca7c79ff5f20e6da.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A zoned btrfs filesystem currently has a superblock at the beginning of
the superblock logging zones if the zones are conventional. This
difference in superblock position causes a chicken-and-egg problem for
filesystems with emulated zones. Since the device is a regular (non-zoned)
device, we cannot know if the filesystem is regular or zoned while reading
the superblock. But, to load the superblock, we need to see if it is
emulated zoned or not.

Place the superblocks at the same location as they are on regular btrfs on
regular devices to solve the problem. It is possible because it's ensured
that all the superblock locations are at an (emulated) conventional zone on
regular devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0b1b1f38a196..8b3868088c5e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -552,7 +552,13 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	u32 zone_num;
 
-	if (!zinfo) {
+	/*
+	 * For a zoned filesystem on a non-zoned block device, use the same
+	 * super block locations as regular filesystem. Doing so, the super
+	 * block can always be retrieved and the zoned flag of the volume
+	 * detected from the super block information.
+	 */
+	if (!bdev_is_zoned(device->bdev)) {
 		*bytenr_ret = btrfs_sb_offset(mirror);
 		return 0;
 	}
-- 
2.30.0

