Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49C32602D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBZJgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:36:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36887 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhBZJgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614332197; x=1645868197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kdtAsbTBP00lyhU+B3B7OsH8iutl9wuwNn5sytkkY0=;
  b=TkRnobmiRLr+Mc5Ceyls8O4c/07kt9BEl+ujNIOYThJGEyR+jOxnwWS/
   XOKb3E+fvbPpNqIeKUBV2Fb+/EErrDViy810HG3R6pMDzbpCp9L3Wbxb0
   +1UfeBg0laUMW3s5YWGa/CE0qAQz8Uz61LKFoXCvvoq3skP+nHGEbSakP
   eREqBb3mQBa6dxoMu6RSY47t04xuQNA6DdqrPnBf/xoUsMz7IvavWDWmq
   u4JqHnkACmX1zdyGRhHd/iXXiK02fOv5sTIzJEKvVyvbFAU9BTpecyB/7
   XbQgu0DFdB+Pm7w/13iGKMSh9YsJWLNUzeBu3WYXEPCU4qEEiTs2DCZZL
   g==;
IronPort-SDR: l2H7TpW8thheAF/tGELuipf3nr/J4r3CM2kvz7/FO39y4FLrxWuQz8Srf1EMMYEGvxRBRbrRUz
 cjWwW3LhcR69ic1IRTubnDeNkqWHXo/GOcmnrOYsQoPLfmrU7WJ/ry/VKPhM8NBz5izsCQwXoG
 GU7sN+tI/UCXIizYSVlMrpBk5uG/49Zll2la7KvMg+kf4Is3cLjt/mdm4oaqAS3ZeGam7IpO66
 9781v+z6ONQuDEE3rP+qJH4FSBcZfuLPjan28a2cQrPK8OnK6U9zPorPXoezqYmMM2gjALSqGy
 wH4=
X-IronPort-AV: E=Sophos;i="5.81,208,1610380800"; 
   d="scan'208";a="162045392"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 17:35:32 +0800
IronPort-SDR: BjN50WzRePzsbEsIuYyip46If5HqRRexfHkdN+mWuMUrIAEuXx/49ucYqlYiD1xRsRYM8GBQpG
 zCSn2QyRnCqK9Fclo7kjN2dgD6EBoMLuc2I4YNbi1JwtWwoTfHgaT4UN1FXWPKHWfA2JuF7fYT
 uYyQceM6h5gS/UQpdGtW0hvI4yVjwHiqTb/SU4h/UlFRSfQnf5UcAvm4TWp42tiHKljMKbf4IT
 xYRGcfgaMCpBQpRRFaXGV1Y3JWjSNMlhb9TBiHtMmbLdTIEeiuVqJUuhfXPk/6jmf0idNiytEB
 av1vTD1/Z36+6F1ohl1OYIhI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 01:18:45 -0800
IronPort-SDR: KMg/wyzgb6QBiws6ahYx/c7soGesUbyOjyGoxbf4Mx6A+5Rxwy1EzODwX8AfZKu/CXdpaQiSF5
 S6k+EEhLlsEgM6Yn5Vs5pecNmDrGpN/BczAiLV1XBjBO8hsO33GwtRmpTOCYALhvyipWLlSIhy
 y8wwl0guqSZcgzSYzVTMCGWtmEQeeJYZ0/UjuSoaw8h9hPP7UQAtxN70X2xQdXWOYoSBwlWdWz
 048H7Aj8AgO3P+13zzVGIVm7sG8ELoCRCgQ1/k+qMCmgESV4PQOEGon9em0gd6kGTMeEoy8JhQ
 Bj4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.63.216])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2021 01:35:31 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Date:   Fri, 26 Feb 2021 18:34:36 +0900
Message-Id: <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614331998.git.naohiro.aota@wdc.com>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit moves the location of superblock logging zones basing on the
static address instead of the static zone number.

The following zones are reserved as the circular buffer on zoned btrfs.
  - The primary superblock: zone at LBA 0 and the next zone
  - The first copy: zone at LBA 16G and the next zone
  - The second copy: zone at LBA 256G and the next zone

We disallow zone size larger than 8GB not to overlap the superblock log
zones.

Since the superblock zones overlap, we disallow zone size larger than 8GB.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9a5cf153da89..40cb99854844 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -112,10 +112,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 
 /*
  * The following zones are reserved as the circular buffer on ZONED btrfs.
- *  - The primary superblock: zones 0 and 1
- *  - The first copy: zones 16 and 17
- *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
- *                     the following one
+ *  - The primary superblock: zone at LBA 0 and the next zone
+ *  - The first copy: zone at LBA 16G and the next zone
+ *  - The second copy: zone at LBA 256G and the next zone
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
@@ -123,8 +122,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
 
 	switch (mirror) {
 	case 0: return 0;
-	case 1: return 16;
-	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
+	case 1: return 1 << (const_ilog2(SZ_16G) - shift);
+	case 2: return 1 << (const_ilog2(SZ_1G) + 8 - shift);
 	}
 
 	return 0;
@@ -300,6 +299,16 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
+	/* We don't support zone size > 8G that SB log zones overlap. */
+	if (zone_sectors > (SZ_8G >> SECTOR_SHIFT)) {
+		btrfs_err_in_rcu(fs_info,
+				 "zoned: %s: zone size %llu is too large",
+				 rcu_str_deref(device->name),
+				 (u64)zone_sectors << SECTOR_SHIFT);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	nr_sectors = bdev_nr_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
-- 
2.30.1

