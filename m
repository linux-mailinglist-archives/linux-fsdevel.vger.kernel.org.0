Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD615A1C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgBLHVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492079; x=1613028079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5UIMNkBdCV6IK0Ha1DBLIbFIvKFl4Ob+mO8WqZyf47Q=;
  b=m4y2/0YqbnVMqkY5I7n7MKlcxJpp6J7ipTAHxLY8bd6E+wDZEDwCfMI3
   na5G48pOhbW414FXZuwqpiGDa82FJ48iH9rOvp/6Xpf+wOgZ+8YzokqpF
   63x71Tvy/fZCiYriDG7A6KPgW9D0iiNyh+xoyMxY7USgkEStJ25f/e7z4
   ZFkQmywWFpS90x/ULSvM2b/RNjrvGxstW6aE++RE5zw4REuweP4XUPqQr
   FUUSeTG/mqEP6OD5nfsnj5d4+wiHoX/Q0lmYiQBtjQ2p+Fe30EOSrIxgt
   hdrMZXvoYmgivGKwd+x4pDx/S8gHRDtiaUSNDzvyq1OrEC+2P4A6jbbJ9
   A==;
IronPort-SDR: 6zISnJ1f7lU+cL+DEazkO63va+TqezrW1dxKisselbjhIJTbJdhRI4ZhlD+YYPgzAOy+jl5lJe
 aIpE+nvW9gHvy/nHdeXDD+dl02WQJNsSzj4b1n+P84JgyqZ+2V/Asw8niw5wbAvZUA3310ib4w
 jvAgPdjr244eD7/Ly8NOJQiHlEcx9ICzK592wNC/UvBmCL7FvsFAffF7gTwVc6vH8uehIvr2Ry
 UD5Ip/LvOFyQ0+HjOYBTc52ynYiLuExz/fPpagX+ArHWi6YqDZp31zfXMu+AnAQmjPfaJ/7h5K
 Xj4=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448918"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:19 +0800
IronPort-SDR: BMm1yDDjWG83WqEhE0NQYfF/HG6LqYTeTf1mG++XhoSJm9JJ33pKwOxZhugH+hSusv9g0CDCcX
 XRaw0u9pWUpF3DkdmTfUpkJrj4tA0qu76sI8HgC1XSKtjbiUzbjhsjj+TGUW9evlVBHojevEgI
 9Go2SfS9EtuqlziMcsss1u75YjT58wmPAL1I8AVxVswr+uXopJ6Yvbz3UcF7fQIcvzZaN30OEj
 SBdnEFCuRegaWBg/a5rsHTjLBII9WGnwtznWN6Hp60ReHtNrTE+cmyZBxT0EnZHdF7LAqtzW+c
 VdP+ADsTlo+rN/Qv3mxAdlRE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:05 -0800
IronPort-SDR: rAUwtKnZS0jVuDUyLALcK8tOvnurR/BxquvuiZvKUoCr0/yK1RudaQLrCVfWdKsC/fsnQrt/UB
 1OegdfJkIAXSk9N2opFVHm+8pqhnIG0Q5UbCY4BOsOWR0k8TXSwdjOabA53OZL6Wnz7hPl9Dwj
 48Zjv2rAMa8YVP6f0zYv63UJDGCZjMil6q+J6oU1PVwQCvbv6Lfb7bPbeD9+gL9lcVb2BvbKam
 5DTAnZoGAtlnnmWxpk7b66N2XvYbVQ6kz1hvyGDqZMmL2lyxC0DPq5qkNcKhvoMvnPhilO1lwX
 S0g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 10/21] btrfs: parameterize dev_extent_min
Date:   Wed, 12 Feb 2020 16:20:37 +0900
Message-Id: <20200212072048.629856-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
index 3e2e3896d72a..38c2c425b997 100644
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
@@ -4869,6 +4870,7 @@ init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_devices *fs_devices,
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 				  ctl->max_chunk_size);
+	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
 static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
@@ -4904,7 +4906,6 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	u64 total_avail;
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
-	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 	int ret;
 	int ndevs = 0;
 	u64 max_avail;
@@ -4932,7 +4933,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			total_avail = 0;
 
 		/* If there is no space on this device, skip it. */
-		if (total_avail == 0)
+		if (total_avail < ctl->dev_extent_min)
 			continue;
 
 		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
@@ -4943,12 +4944,12 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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

