Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE97D15A1B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgBLHVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492070; x=1613028070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1d+9QvPZzYOzOKtSVHwxfSzwOvw2zonQshwL92uXyo=;
  b=Oer5Jc+W63zq44SAo/8n+zGusVXc+HQ9mRK0gf/d/+K06GPXtBfgpzsQ
   F1ANI0IAzxVAVw3tncobH8s3ngGuGz7wvQwBE1d+T+sysUOOW5QvPcXUR
   wRIzQ9RZZVQ8kxXmRby7TrLvnGqaKcm7mB34qk6ve7bp4ocRxGdBs4rO8
   /n81nIUkkRZ5hlDTWhw5GMthkzZnqX1TohbmNc/bvi3tRL2bdKB86qq8y
   Yrvl9ii9fyuLJKOtDo3DJp6mTXf25ctgiaptrbmaq1CAx75dSEBk+SQYG
   hVIyYXD6tyW2//AaxzWz0RmPGXepIUBrX4c1mcoT8q1H5s6Wi7sRM8QBY
   Q==;
IronPort-SDR: LJE/msJ9s/U6oJnpXRAlaJDrmFb3mTbFQroxV5WeMQZdQLkKJH5S4L5CLldczOIHtRj5USJfVU
 g2CduQ9pyM9/teKDCfqAC2pXmb6hv+IF8h6tIQpJuYQnG1PqLU5BTcvAIUKMRTBZjxKU1XPmPh
 RFL6rcTgjalr9durEVFMcq1TtEiexFP9TpkjZGE7PYrdSFHLyO/xqFjY+Z/nYf2tR14bdnJ8Q1
 2OdUbeAxb0EIzZ/BvoO3yCvSp73CCNZAK9wVyUwn1mF+cf6vREUYoSBBkL/OQobr+RBJgoWKQz
 fqk=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448907"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:09 +0800
IronPort-SDR: kbIFtWge2GdWRykNYkV4sTaEco1gu4QKqebgcD0c2lxCjQdqdR9zTJM5wGycswD/fvi/8xsQGj
 G+KrPuGv8zrjoHS9z7oJwZoT20GQrV89/tUCFVmhnkLkrVSVwVMxPedkey45c8D3fdy2YkPCy4
 6dK4ea9IbgXGji61ai3vHma1r1sA0cfCeO7dKLaFcSF5aSkLBAVz29L51Mb1v/OYEdNzNAq1oe
 INjaaUg1KBngbCFFLAqcBiLPFC9ryASb8EBgNIhQgra3mgDYRKCa0WOUYDdsxcFNSkB+L1uNM/
 I/b/FC/YPXN4tnC0Zdt4yKHR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:57 -0800
IronPort-SDR: /yvPCQn43nPQ5TuHM9tpfsRNQlM0IaNCIADbr1kKXZQErCndMvOtMBRhYsjpSeh53uisVkb962
 xCgUa1cia7El31GcDZFnu8JJbTJOiQwG/bA2+j031Z8AUgjtFTQCvDtOgBBw8esUDl/Y4jrquc
 S8arFjH/ECTo7yznvsxS4EqWKugmbkBfxez9e8XlMH93PyUhQSpB2yO0w+KPel1ZmPzAIrnb++
 lXLFs2DWHRJMBtO9Ad3oBps7aqoRnRnmwzMaEMg3d8FG620iY+JxpGdzvxmlE1MuGu6Q77SRQ9
 bVY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 06/21] btrfs: factor out init_alloc_chunk_ctl
Date:   Wed, 12 Feb 2020 16:20:33 +0900
Message-Id: <20200212072048.629856-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out init_alloc_chunk_ctl() from __btrfs_alloc_chunk(). This function
initialises parameters of "struct alloc_chunk_ctl" for allocation.
init_alloc_chunk_ctl() handles a common part of the initialisation to load
the RAID parameters from btrfs_raid_array.
init_alloc_chunk_ctl_policy_regular() decides some parameters for its
allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 97 ++++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ed90e9d2bd9b..9181e3ab617d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4841,6 +4841,61 @@ struct alloc_chunk_ctl {
 	int ndevs;
 };
 
+static void
+init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_devices *fs_devices,
+				    struct alloc_chunk_ctl *ctl)
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
+static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
+				 struct alloc_chunk_ctl *ctl)
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
+		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4859,7 +4914,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int ndevs;
 	int i;
 	int j;
-	int index;
 
 	if (!alloc_profile_is_valid(type, 0)) {
 		ASSERT(0);
@@ -4872,45 +4926,14 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
+	init_alloc_chunk_ctl(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
-- 
2.25.0

