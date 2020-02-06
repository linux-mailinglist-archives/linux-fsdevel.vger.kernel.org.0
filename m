Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FE154220
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgBFKoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985870; x=1612521870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOk86koK/WO8BD/51mSjXedYTlZGA76glGdlVYTVTIk=;
  b=Im5QHiMm1bEuhjTKXu9g5YD8GZHIXA9h9RmbpGPirPHlTzG+pXuUokJy
   yJNfezLO7VBEZhmLGHrcNV2f49d1jjkASXgZfZ50ManmeAUmehxp/JrYh
   PMpu5d7ZR7LoekS/YmAFAXWeCP6BN1uTDBFcIjxqQ0kVm9gSqSsqX4xGw
   0uMG3EHx0hDySUn0VGwVpfjn8McyTw6gZCtn8kT5+W9BZWaJnuoumRIgh
   PxQOvAqXVsWua9LZvcyJYQEeCXBmCkGokH3lvpE0579jrMAcrMtA7vFyK
   ECttjmZjrGPerSTneuKs1GRqSs6SeIazr68vQ+7wiQi+SM9s+E1VZHIzR
   g==;
IronPort-SDR: hvC/A2nJqjzc5kZzpX/6KkuNmjlGdZaaSrlJN/0hYE6B7RRPyPZrjFzzMU9KoaRQ5xpbZPXJAz
 T4E8qLHKd3MkVjL69YO/5BzTO+S4p4aDMc9G/qHCMQjjSkPgd+TQcgwcmAEjnFBokUFP1sePvd
 pWr+iuQzMH/ClA6YVlg1lzeBArdSUw0AdJ1kCmydl/W+FJfmzWL9M/44Mi/9DRFOpUBrUEqw4N
 8kqgH1MyiCgT4k4gaqpD+qpr0sa/3Ke61sig+GbNJcwKxAlLd1owZ9D/FkgQNy/RfLAaRqEkv1
 h3g=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209515"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:30 +0800
IronPort-SDR: jf6MgPxwjcQa6VHDFZeWWQ1Scu7fUfGuBDjt5qNkCEImFL+ZSZMh5BIG32GV/1Opxo/pGFjm+2
 TfMm1GGfarp8iIkQ/loAYTs1C/pDngFagzP/B1l3ki6khnP9+9u4cWlWZfx9Nv2v0ifXjfx3DG
 SgiyscGoAx8Zb37wfFuTb4X6IftmbVAXIg+utyr8KgSJJ4BB3vshrysoRfudG90eRpBEIvNBnx
 0Fs6PL9izfI+El+v1iBi+lOkPZxKHT9vx+/FACsqZ1ispfeWpM8lPdPxAzCGB9x+fb5vuMPQjK
 oteGCIMozZz/PQKg1zRsNoDX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:30 -0800
IronPort-SDR: aPkiZWG/ERxmVgwv9/B9byqCcxGfeFrOLbwK0hsxwPOLZDtmtOHP+DoSoBqSy8u1ccSzZnhmVd
 5Ba6aq6cTmITVJ3oh/ezSKfrDlvMJSmi54eh4u9GDdqCs1sCUDp2fz4X6sAxLQnEV4wTZvRc0K
 33zEnjE+AAk+sAMrLXAlLX1LEDa4qrf04exglDModk3rMWDBni/U0oTaUPtd/keVaxXata1Zaz
 3JKuK+lfZBWLBMaVCxkt1BFrS/jV9SWNJ2IEHFviOVw23+UgsOravOlOUX3CQQJNDe1PvdQaRT
 E/A=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/20] btrfs: factor out decide_stripe_size()
Date:   Thu,  6 Feb 2020 19:42:01 +0900
Message-Id: <20200206104214.400857-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out decide_stripe_size() from __btrfs_alloc_chunk(). This function
calculates the actual stripe size to allocate. decide_stripe_size() handles
the common case to round down the 'ndevs' to 'devs_increment' and check the
upper and lower limitation of 'ndevs'. decide_stripe_size_regular() decides
the size of a stripe and the size of a chunk. The policy is to maximize the
number of stripes.

This commit has no functional changes.


Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 137 ++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 02bd86d126ff..85c01df26852 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4973,6 +4973,84 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
+static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
+				      struct btrfs_device_info *devices_info)
+{
+	int data_stripes;	/* number of stripes that count for
+				   block group size */
+
+	/*
+	 * The primary goal is to maximize the number of stripes, so use as
+	 * many devices as possible, even if the stripes are not maximum sized.
+	 *
+	 * The DUP profile stores more than one stripe per device, the
+	 * max_avail is the total size so we have to adjust.
+	 */
+	ctl->stripe_size = div_u64(devices_info[ctl->ndevs - 1].max_avail,
+				   ctl->dev_stripes);
+	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+
+	/*
+	 * this will have to be fixed for RAID1 and RAID10 over
+	 * more drives
+	 */
+	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+
+	/*
+	 * Use the number of data stripes to figure out how big this chunk
+	 * is really going to be in terms of logical address space,
+	 * and compare that answer with the max chunk size. If it's higher,
+	 * we try to reduce stripe_size.
+	 */
+	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
+		/*
+		 * Reduce stripe_size, round it up to a 16MB boundary again and
+		 * then use it, unless it ends up being even bigger than the
+		 * previous value we had already.
+		 */
+		ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
+							data_stripes), SZ_16M),
+				       ctl->stripe_size);
+	}
+
+	/* align to BTRFS_STRIPE_LEN */
+	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
+	ctl->chunk_size = ctl->stripe_size * data_stripes;
+
+	return 0;
+}
+
+static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
+			      struct alloc_chunk_ctl *ctl,
+			      struct btrfs_device_info *devices_info)
+{
+	struct btrfs_fs_info *info = fs_devices->fs_info;
+
+	/*
+	 * Round down to number of usable stripes, devs_increment can be any
+	 * number so we can't use round_down()
+	 */
+	ctl->ndevs -= ctl->ndevs % ctl->devs_increment;
+
+	if (ctl->ndevs < ctl->devs_min) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
+			btrfs_debug(info,
+	"%s: not enough devices with free space: have=%d minimum required=%d",
+				    __func__, ctl->ndevs, ctl->devs_min);
+		}
+		return -ENOSPC;
+	}
+
+	ctl->ndevs = min(ctl->ndevs, ctl->devs_max);
+
+	switch (fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		return decide_stripe_size_regular(ctl, devices_info);
+	default:
+		BUG();
+	}
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4983,8 +5061,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
 	struct alloc_chunk_ctl ctl;
-	int data_stripes;	/* number of stripes that count for
-				   block group size */
 	int ret;
 	int i;
 	int j;
@@ -5015,60 +5091,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto error;
 
-	/*
-	 * Round down to number of usable stripes, devs_increment can be any
-	 * number so we can't use round_down()
-	 */
-	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
-
-	if (ctl.ndevs < ctl.devs_min) {
-		ret = -ENOSPC;
-		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
-			btrfs_debug(info,
-	"%s: not enough devices with free space: have=%d minimum required=%d",
-				    __func__, ctl.ndevs, ctl.devs_min);
-		}
+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	if (ret < 0)
 		goto error;
-	}
-
-	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
-
-	/*
-	 * The primary goal is to maximize the number of stripes, so use as
-	 * many devices as possible, even if the stripes are not maximum sized.
-	 *
-	 * The DUP profile stores more than one stripe per device, the
-	 * max_avail is the total size so we have to adjust.
-	 */
-	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
-				   ctl.dev_stripes);
-	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
-
-	/*
-	 * this will have to be fixed for RAID1 and RAID10 over
-	 * more drives
-	 */
-	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
-
-	/*
-	 * Use the number of data stripes to figure out how big this chunk
-	 * is really going to be in terms of logical address space,
-	 * and compare that answer with the max chunk size. If it's higher,
-	 * we try to reduce stripe_size.
-	 */
-	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
-		/*
-		 * Reduce stripe_size, round it up to a 16MB boundary again and
-		 * then use it, unless it ends up being even bigger than the
-		 * previous value we had already.
-		 */
-		ctl.stripe_size = min(round_up(div_u64(ctl.max_chunk_size,
-						   data_stripes), SZ_16M),
-				       ctl.stripe_size);
-	}
-
-	/* align to BTRFS_STRIPE_LEN */
-	ctl.stripe_size = round_down(ctl.stripe_size, BTRFS_STRIPE_LEN);
 
 	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
@@ -5091,8 +5116,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	map->type = type;
 	map->sub_stripes = ctl.sub_stripes;
 
-	ctl.chunk_size = ctl.stripe_size * data_stripes;
-
 	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
 
 	em = alloc_extent_map();
-- 
2.25.0

