Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E415A1BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBLHVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492075; x=1613028075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5J3r4zGFRGNFn0u8ZAVRF19XIMYrkmLlIpuh19RyZc=;
  b=k18lWZm7y+9l4YS6a/O7HZ97ZvTq1EaZd4/V8Szlv5ddn4rLIlOQ4ziY
   IqjA+POuRGKBO60S7D3PxHs8El8VdCHoB8WNSWBNyZpiriLomxR6/kJkz
   7SnkitKv7p6G9hFqlhGCrHp+d6xgUFJk9Z86dxRIETdYAlD7h5asUAXVb
   OSBfngnK6fGmKOCP2FjQsJvHg2SmcQnVHtYwW1bVwvMpCEO6rN6rHEt9N
   o5TETsqaY8ArtTLc73V9dchRV+UGYex6KWv5ZZTOdmux1w4yHVMi4+tbk
   f2LNOKr33U5FhBJkkklg+USI/4SBgnUuwDhjzdTspu9DgtATXs4g/JBnK
   Q==;
IronPort-SDR: 7nQl2c30WI3iQUSBjwy2e5PLe14WDrQnoqavAYfnXbtqJ8COw3z+L5KOdKcHO0838LLvdSvHJc
 Oy/HwR7MO7u3FPxQTxqigDhjTO9ARn4LmyJGYKrn5v2F374Rqh5gFNy6iXOLwpaH3b9PVwMKny
 tSesQi3BZWzivhiVTncxT1NwZZyWj8vn1lwWlTe75atAWo0/hf/p73I917Yc0ajJBta3t7zqHs
 y+B8Zj5zdDznLI5+RXzYQBKWRYxrCkqsyVgaoIzCaCZi+rthcnTUas62zKMdWANHZhemv7ap9n
 eJo=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448910"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:15 +0800
IronPort-SDR: uGycJsfhsii2uqSu3rzZtIG1FsBpiSrULayyF5xr4l6C3ZelHG7flDR0mg6en5yLrtX9XIbecF
 rygLw+mcKRLHIXGzonAjo5vK7YIy/950+UAiyq/mrvjo3JlYtgMe1MHl9+tBIPEdFmcluCl5k5
 FePwSLAwmFZ591Ja9u+LHZ8eUIrbEO5wOqOJNIiqmEi4YEcKVyDEwJdKy0Mn4PPQY1P9me2/R2
 mhQ5wEvQRghWikWYi35miDxJKq7dWHPioADG8ClL3uPHOIDcaZyhubfafa46+rnXBoNYLv0Q7g
 JoDByPMYfhlyh7zdT9QlOp2T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:01 -0800
IronPort-SDR: /obRnkoZ62xQNEcg3Vw2rjAN1MO8bSfAVqvLT0rRUf+Dn9XWGVnTG2gspVlqfU/aTIX215NMQN
 epLxEJMRufjh/cjF94buYWPc3mrrisYXdMbus36i1nzv9XOT34+Qo/g2i4DOyZ5P5rJSqjIEKb
 0Ydm2i/+eyqFM2d/kaNQgs0UD8hf1nAEJPiKOLveJ9eol2YhBIeZI6H03g/wKWknxaR3oCIkX1
 HrsBG2HfmH8xkJsCX5jfD9pvNDeE+DKYOgwgqGsgI6hx+8N0fe5vTms/SMoDxcNLFDHGl2pSOf
 6c0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:10 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 08/21] btrfs: factor out decide_stripe_size()
Date:   Wed, 12 Feb 2020 16:20:35 +0900
Message-Id: <20200212072048.629856-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 138 ++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bd3ed830a28..00085943e4dd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4974,6 +4974,84 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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
@@ -4984,8 +5062,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
 	struct alloc_chunk_ctl ctl;
-	int data_stripes;	/* number of stripes that count for
-				   block group size */
 	int ret;
 	int i;
 	int j;
@@ -5019,61 +5095,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
-		ctl.stripe_size =
-			min(round_up(div_u64(ctl.max_chunk_size, data_stripes),
-				     SZ_16M),
-			    ctl.stripe_size);
-	}
-
-	/* align to BTRFS_STRIPE_LEN */
-	ctl.stripe_size = round_down(ctl.stripe_size, BTRFS_STRIPE_LEN);
 
 	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
@@ -5097,8 +5121,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	map->type = type;
 	map->sub_stripes = ctl.sub_stripes;
 
-	ctl.chunk_size = ctl.stripe_size * data_stripes;
-
 	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
 
 	em = alloc_extent_map();
-- 
2.25.0

