Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851A015421C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgBFKo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgBFKo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985866; x=1612521866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVb2Fml4UToQKpz/onea8bOZqpvV38ZjN7YRwIN4PBE=;
  b=VS90URudXEWl9CYpcAXDJDuXs01E4kXAGQG3w21SUjnjhLO+NQdVxSKH
   vDjYHhZFLRHN7JLIHeVsd7YiUHXtmPqFAv2KZl6F163pGWg9IWMdP0ssF
   MGHo5bLRHLFU5WvqWwMjuT80dFjl8TQrWjH4/bVhMLQX0lFN6iex7ORL+
   cScu3sIgMfgf0ty/XK502n0WHCW1Ll7/5660O9qj6iH0q0guC3VBWUuHK
   nKhdRVf/Q9iZ3MYochDoarFF20PF0necNjfDDkAenn83fOF+Oday8NI2Z
   qnBeU4ZBM0X/0RvfMbqM6tNCBwhPi+To7nAYfsjjHMF8kCDIW3VrjYJwK
   g==;
IronPort-SDR: vRltQV3/I/8CiwXV3fiR38IfaGyvkF+TM07GS+U4QarQ5of88m1R9WPdqhe8cjXujpnm9SakpN
 7dqhKT8Eu4lC7CpLmb8G1l5gcW72P8U3IwWw1baPUAo78gxbHXvoxYdkGqs2lZNFP8gwEHT5Qx
 dIoIsFut5Jilufc+shmQujwxolkC07EB4dCJJCS7iKbTatOX/A9OSJmvSJgu8lp+QzK/IaVGZz
 +Xrf1tGbOm3MXwSmsjcTrUCRR0FUELpj3GmZleHI0/TOIfuF8uiIMyyq8cfYq3XwLhXaqbNadQ
 Hg4=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209499"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:26 +0800
IronPort-SDR: r48tn/hTjRMRIZqg2byT60/rkNkczk4KvUhjWRCNFVnrUbG5j7S5ybCJs5vMHK7tEg9paKv3GL
 cl8xDxbFi2iX38vAxrxGPmqssOF89Sz6pAErjm9DgE67C+Z0C0k7mewC+9y8tOf0rklz0rRhBb
 vv5ezfp6VfgcS3mUgNpT3s9n4P29p1kgaHroJr1Ut+xZJ6t4QLXgQTtgOgxJcDAF5/Gitae6YI
 k9oPcV8p0ypM4FAmx0vW4oqKx3SESAjfOHYy5wWa2V9/vEtaq1QjesPuZGKC324ZH1OCo7VG7F
 k/AfBmAwnRvbWVv+aHbZB8lh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:25 -0800
IronPort-SDR: nDVXff1t6eI2d7u+wddNlr0gDUylbME3AWlv9zmYHjLA+M8uvyO4U4MX+wBsQRlE+lzT+vegL6
 u7YHtYeB0myMtAn4PN2S5miZ/Ma0eoHlWmxkLj3VmAP90r6BR+dW5gzcz4QvOr5sPSBFbjvT3x
 CPiKmQui0G5nUyRN0TwImXXonvmAj17F02FS7InWAg+nwPM0acDCZV38WAl/sI+ii30Pf2cA6m
 bNJGJ5EvBWlrrPJKZUAbkWuMjH/8SBjnp+jmfcSvSarIl6drHz/DpBbx0KFWQNt+Vq2cNtn6lf
 /LM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/20] btrfs: factor out set_parameters()
Date:   Thu,  6 Feb 2020 19:41:59 +0900
Message-Id: <20200206104214.400857-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out set_parameters() from __btrfs_alloc_chunk(). This function
initialises parameters of "struct alloc_chunk_ctl" for allocation.
set_parameters() handles a common part of the initialisation to load the
RAID parameters from btrfs_raid_array. set_parameters_regular() decides
some parameters for its allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 96 ++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cfde302bf297..a5d6f0b5ca70 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4841,6 +4841,60 @@ struct alloc_chunk_ctl {
 	int ndevs;
 };
 
+static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
+				   struct alloc_chunk_ctl *ctl)
+{
+	u64 type = ctl->type;
+
+	if (type & BTRFS_BLOCK_GROUP_DATA) {
+		ctl->max_stripe_size = SZ_1G;
+		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+		/* for larger filesystems, use larger metadata chunks */
+		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+			ctl->max_stripe_size = SZ_1G;
+		else
+			ctl->max_stripe_size = SZ_256M;
+		ctl->max_chunk_size = ctl->max_stripe_size;
+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+		ctl->max_stripe_size = SZ_32M;
+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
+		ctl->devs_max = min_t(int, ctl->devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
+	} else {
+		BUG();
+	}
+
+	/* We don't want a chunk larger than 10% of writable space */
+	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+				  ctl->max_chunk_size);
+}
+
+static void set_parameters(struct btrfs_fs_devices *fs_devices,
+			   struct alloc_chunk_ctl *ctl)
+{
+	int index = btrfs_bg_flags_to_raid_index(ctl->type);
+
+	ctl->sub_stripes = btrfs_raid_array[index].sub_stripes;
+	ctl->dev_stripes = btrfs_raid_array[index].dev_stripes;
+	ctl->devs_max = btrfs_raid_array[index].devs_max;
+	if (!ctl->devs_max)
+		ctl->devs_max = BTRFS_MAX_DEVS(fs_devices->fs_info);
+	ctl->devs_min = btrfs_raid_array[index].devs_min;
+	ctl->devs_increment = btrfs_raid_array[index].devs_increment;
+	ctl->ncopies = btrfs_raid_array[index].ncopies;
+	ctl->nparity = btrfs_raid_array[index].nparity;
+	ctl->ndevs = 0;
+
+	switch (fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		set_parameters_regular(fs_devices, ctl);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4859,7 +4913,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int ndevs;
 	int i;
 	int j;
-	int index;
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4869,45 +4922,14 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ctl.start = start;
-	ctl.type = type;
-
-	index = btrfs_bg_flags_to_raid_index(type);
-
-	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
-	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
-	ctl.devs_max = btrfs_raid_array[index].devs_max;
-	if (!ctl.devs_max)
-		ctl.devs_max = BTRFS_MAX_DEVS(info);
-	ctl.devs_min = btrfs_raid_array[index].devs_min;
-	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
-	ctl.ncopies = btrfs_raid_array[index].ncopies;
-	ctl.nparity = btrfs_raid_array[index].nparity;
-
-	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		ctl.max_stripe_size = SZ_1G;
-		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
-	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-		/* for larger filesystems, use larger metadata chunks */
-		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-			ctl.max_stripe_size = SZ_1G;
-		else
-			ctl.max_stripe_size = SZ_256M;
-		ctl.max_chunk_size = ctl.max_stripe_size;
-	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		ctl.max_stripe_size = SZ_32M;
-		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
-		ctl.devs_max = min_t(int, ctl.devs_max,
-				      BTRFS_MAX_DEVS_SYS_CHUNK);
-	} else {
-		btrfs_err(info, "invalid chunk type 0x%llx requested",
-		       type);
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
 		BUG();
 	}
 
-	/* We don't want a chunk larger than 10% of writable space */
-	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
-				  ctl.max_chunk_size);
+	ctl.start = start;
+	ctl.type = type;
+	set_parameters(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
-- 
2.25.0

