Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5900B154225
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgBFKog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985874; x=1612521874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVemCP0xNYYaPjT5DDr7EmVm02gdjnLY5u6jKJpIfmg=;
  b=hgiL65DuumB0Xx7WWdhtNveAWBzIO4MA0JsyGivv6SoVAYAwuSLitXWV
   Vprm6EOTSRDpyf5Ai7GK4biGWprolUoNV83OQeIwM/3Hp7U6bsSIz0mc9
   sG3LX+DXgjYE6f8P/6vKkkyupJesFuUPr58j4nskRTFt2lHuAUCe8oIFo
   kpGwnPY35cbBKCCqDObQ5R7VdA+zfQw2wrpHnB9zJ+l1JQytDJQqPf7bB
   cmhglfp+ApcvOnI6FGBkbzKvV43KgC7dy/PweVuTTshL/jTqNo4mAVtvK
   USRTHItfJnFqJsrcGx0Mc4DbFGhr6zztfdwAODTOnVY7RBUZQz8CsOiDC
   w==;
IronPort-SDR: Kqr24Flayh9GRHqTkOfN7cXVG5rh/cOCnge4X5dxe6FB+CAnLiKCrgWdgXA+Qizt68xVjhiuOW
 55BvlwI8MOU1mAIUg9yEDv9+qPB+qM6gM3xE3i62XiTpw6sekhYo6pMD5PjrKch0ss/O10uc2N
 7mCL5PBZnPFJ8aG+1l8j51GvufquPqBJaTh/dMbDH3DhbpTx+98V5FcwogjfhV6uhQ4qExUBd7
 SJtD1sUk99kc+Xvno2G5uleSMw/Wgb1Vtf9MLKcqERUGxAK+TYL6loIimGGMM2kw8lf3rkx7kJ
 5p0=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209525"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:34 +0800
IronPort-SDR: 8PgToHsg+cQv7VJe/QKB1WDnUjHz96ny3JxfwAG5trG7h7F64XNDu7AayvKMUN34BkYz8q66c6
 UooPYbrXl1rE150/81l/6dCPbN5XR9l87rai/lTydhM3emITpU3Hwm0EQ2W/QStY6J/FYk+9yI
 IecZ0CPeAK4OBnzQg2sbGQ/DJTfPgGnW80+Z88vBPe8IIO0QHn3U2hucYHTzZ0bVHCzFHpiK2l
 OAuyZgSAku5adBM53VHOQ59o+WfLysZSGrRq+AC2dqjNzpGemO3Kw+PBHJlFk24MKlX48XecCy
 TlVyThtQfPXngYG7TthiQ2Ll
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:34 -0800
IronPort-SDR: l0FXs5nBHWJ358tW3J5es40Fnpa6IxY/M/R3m8p4/nriJDsVDn6Lv2N4/JNqe/TaUuZm/k5n5T
 ZmTHYJ8d3PVNK0x7BEFGoAHPSNoY8j/XaFV0UCuZio8PMgNLLGoVYE5snice1ocR0obz3ezG0C
 4mCTQqnlsE7hkW6K+8R4ErZ46+OhocmdSFXtot7VB2TktINJ81FiFY9j6YKL0FxAS1hZFZmsLy
 AqSZzGN7axfZAn7cy+33fpNxKWlyt6nGfC6+WP8RzjQMQjMeoETJmBg56bZ8aE9Coe+QcLSnou
 v7I=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/20] btrfs: parameterize dev_extent_min
Date:   Thu,  6 Feb 2020 19:42:03 +0900
Message-Id: <20200206104214.400857-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, we ignore a device whose available space is less than
"BTRFS_STRIPE_LEN * dev_stripes". This is a lower limit for current
allocation policy (to maximize the number of stripes). This commit
parameterizes dev_extent_min, so that other policies can set their own
lower limitation to ignore a device with an insufficient space.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 15837374db9c..4a6cc098ee3e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4836,6 +4836,7 @@ struct alloc_chunk_ctl {
 				   store parity information */
 	u64 max_stripe_size;
 	u64 max_chunk_size;
+	u64 dev_extent_min;
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
@@ -4868,6 +4869,7 @@ static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 				  ctl->max_chunk_size);
+	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
 static void set_parameters(struct btrfs_fs_devices *fs_devices,
@@ -4903,7 +4905,6 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	u64 total_avail;
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
-	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 	int ret;
 	int ndevs = 0;
 	u64 max_avail;
@@ -4931,7 +4932,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			total_avail = 0;
 
 		/* If there is no space on this device, skip it. */
-		if (total_avail == 0)
+		if (total_avail < ctl->dev_extent_min)
 			continue;
 
 		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
@@ -4942,12 +4943,12 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		if (ret == 0)
 			max_avail = dev_extent_want;
 
-		if (max_avail < dev_extent_min) {
+		if (max_avail < ctl->dev_extent_min) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
 			"%s: devid %llu has no free space, have=%llu want=%llu",
 					    __func__, device->devid, max_avail,
-					    dev_extent_min);
+					    ctl->dev_extent_min);
 			continue;
 		}
 
-- 
2.25.0

