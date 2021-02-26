Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B532602F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBZJg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:36:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36890 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBZJgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614332199; x=1645868199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SoX56XfySXk87m1h2JIWoGOGVh2sjp3JwBTbIeAArTI=;
  b=PbcJoZvO/scSnKrr0TgJRrDbEmpFVv2U6Uf3rx9FnmgJOBcGi6xi+Dda
   bVevd7e+XJYIWFed8ciNL3+NbsVeZMVDZ5U/p9f6TycvOLHXhITR4FW2a
   8SLsBFoGfBmea4ifu092f+P73in9+cSruS46Zammas5ZZD5XwbcEeB0e+
   4qmUF42oK25IQaYZt6gJTq6EpwOz5N4+gD3+Y0E+ywwwV7Mkj6uQ2r0oj
   sGyJuC+emzewqN/iXO3EEuQVduKE8+JMiMH+ChVP+ep8Muo+WvMpSgQ1n
   e9/MrUu0pU49918+kmrbFi/Xu92Yy7oZcTGm/9UMBw227DO1w1ji2y5Ap
   A==;
IronPort-SDR: Ft2TbW0XSIjYUzdsBVF0vnt7M1HW3zeHLvxbiGs0ZZZTu7TAPrasWwK08ZOYJ0IkY65KPwWb9E
 CxiB+9f/xQUtXG6KHvhitiKqypHbYbgFqwadUXzyr+tIhoGtIaCPZMnzOMo6EtKDpf/3nFvKGI
 pNwQMzvoSoOH/CFAL9P99LGQ/sWv5h/YpJ3ty1GZnKCunVBZLbvIvUkwe3q+XLH9OEsdvIS+S/
 RJkslft2qeAdjITC26/u5OXY7PcwKAmhWmGS4GfMuTfaGDRhqLI6HnIakCXCmUwcVVgfSpSXGW
 Ur8=
X-IronPort-AV: E=Sophos;i="5.81,208,1610380800"; 
   d="scan'208";a="162045395"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 17:35:33 +0800
IronPort-SDR: GK/luGfZrNye6wdHTMuGF7XC9i6IG16xk0N/B60Z9t34qBCK9+lQ260WlsvFNhT95ndbh0OLFz
 i2/pjpymARUlmo03cx9XMvKAf/frSd0BSW7bb9pJWp+HG+KnJe/1chkgeCKBJ7KszEwxR4e92P
 meYUDsWJuiWgs+1vz+MPVtMvLQ/LB2sJBpEbeFbrzc0erG3D8SdmP1J3j3x7SSZFLMMWcdif+q
 oUV65K5Fen+83uZHgw8Z/HybndSSWCto+cf67nkG0zJ6TwGRgXJj8h1vECRCuTAf59sDHoEgLT
 T6WP8WBfZPLvRUGoVAJh51I7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 01:18:46 -0800
IronPort-SDR: c4YoJ7CGewNGsmT4JQC5n4rtfrovShVKufppnieaVLcFEZ7xBB9iRokEPwH6gCVJf030HakMvk
 YYS4ET8n3OcthdIRc1ZUd7HiEg09a2uvIxQ0V1aDRnSfFkDpl4IVFi8ivsdJxehcWvC6gVAYha
 wxV0m2bzg2nVXFWh+Vz751/SXLSnwcVBzGAQ3pItqVPYIcaRwqHahyb0w2fJ9iZ1tnhhmnBeNb
 fbhU0jEGO8HJD1XZ4f/aAh7LGTj7OlDZHJsmci7kBuNR//0X9lrNbu/6ucjs3aGFBRz/v1uA1N
 PY4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.63.216])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2021 01:35:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs: zoned: add missing type conversion
Date:   Fri, 26 Feb 2021 18:34:37 +0900
Message-Id: <e6519c3681550015fbeeb0565f707d72705a39f1.1614331998.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614331998.git.naohiro.aota@wdc.com>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to cast zone_sectors from u32 to u64 when setting the zone_size, or
it set the zone size = 0 when the size >= 4G.

Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 40cb99854844..4de82da39c10 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -312,7 +312,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	nr_sectors = bdev_nr_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
-	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
+	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->max_zone_append_size =
 		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
-- 
2.30.1

