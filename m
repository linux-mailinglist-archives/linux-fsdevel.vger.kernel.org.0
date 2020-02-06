Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA54815421A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgBFKo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgBFKoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985864; x=1612521864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4ydwjZ/r7kMTlhRRfIDF4/7/q1Bojz3U154DtmyH9U=;
  b=IB69G1HwXgUEsOQUU0Hs2lAGEuYvJV0O0zgZ4cYvlIU+eI9dT4gvcBOk
   fK0JwK23nr3Hz1HuCu9a1J5G+tUgNlB0QCkN1hNAlXrBwEvvHccwVOKPU
   KIykF1de6pSaLIdiOL7aUrdF7EtHOyUKHLuqYCA6CJRQGdgoqq0l+yeWN
   yW+2Sll9+Ombal1kM3M9NHHA3agS/gn3l9pWNjWkEi12FVtcu4rWx3HxB
   Ben/XyqqU/FefNlzM4h7hZ8f4Fha8ypijrqMoCHsO/yaSlOY77ZCriTSR
   e1ksGBWiq6UGkPywRT0rSe8U58l2QRm0p5ZESn5W+ese1F+4pGONGHSkp
   Q==;
IronPort-SDR: //cJmhahaUZvEQUesvE9CUYx8O0/I/F+DLcz75D2AgaIlfw8DOxDSG+3VqSHesiriv+FplMKDn
 xe1sHhBKmaml3fa1jzAPv2NKvlZM6RW3Xl0lz7LfIuN1/wmlVRPWT1ayZYYH6fsMj+iys/5usQ
 hxpgaDRERc5P/U7ao25h3ijk2jt/eN5xuTRtzfB684HJAI49ayKPacUjFMf1VAyZL0yDt8Xr0C
 uMa6Iefcn8Oh85O0ZxYG5rxnOKbtKffesUPfoxz5Oo/8RDOwbLBuU5pwv218M/d56jfprG2xwp
 nis=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209493"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:24 +0800
IronPort-SDR: MQv/MTJFqUq1+0DfPJZaQLhgoQ2/wB+6fLD7O5spiMboY1xbAt6urTr0gTkjWrHaTdlrReEdaE
 CwIU+fGGst7LTxoX84y0dZUAZAtOgxlfImmmWTXuOTg2xRibVKv0T00alJ8hJxI4lQYRPpHlS+
 q8DFfXrGqb84ZH6r4WEk8PvwomhQIOEbo1sJM5J2eme3AZcJJ7NNnT1iEeJ4KEAuv156BqnLuE
 p1KXtjPxGWms9vZJ7xjC0mcH/ij0Qwm6uHtlCZpk0ox+KYIF8d7Dojl5tJ27v3k2FuYs+K7yMw
 WBdBm7KLDeTUIYkScz3Phw9W
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:23 -0800
IronPort-SDR: FhFF6gQyg8jwNePhJEYo8Oz2KNXECuHMfJzIek1NIzTXznTWLd31pOevK0avDXOpTYWascks26
 efUHtcnSVT77iiIxSfUBfgiHwtq5uEX10fKJ0zKw+BHfqlIcMX+EIkt/6/iyDTOVwygVRci5kF
 nclmrm7hKdrEENLR+/kCpv509ADilG5s1QNLAlzsw0OzBR0HTFjfbCKKK1+LdX138bnKz/dya0
 hqN8ht1+J+L11x3z0JJCoUT7t+eeyrjco+jZ1oUgF94pDc0TXRrRCuKA2ADoMTzPs2tRkXNaX2
 rE4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/20] btrfs: introduce alloc_chunk_ctl
Date:   Thu,  6 Feb 2020 19:41:58 +0900
Message-Id: <20200206104214.400857-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce "struct alloc_chunk_ctl" to wrap needed parameters for the chunk
allocation.  This will be used to split __btrfs_alloc_chunk() into smaller
functions.

This commit folds a number of local variables in __btrfs_alloc_chunk() into
one "struct alloc_chunk_ctl ctl". There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9bb673df777a..cfde302bf297 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4818,6 +4818,29 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID1C34);
 }
 
+/*
+ * Structure used internally for __btrfs_alloc_chunk() function.
+ * Wraps needed parameters.
+ */
+struct alloc_chunk_ctl {
+	u64 start;
+	u64 type;
+	int num_stripes;	/* total number of stripes to allocate */
+	int sub_stripes;	/* sub_stripes info for map */
+	int dev_stripes;	/* stripes per dev */
+	int devs_max;		/* max devs to use */
+	int devs_min;		/* min devs needed */
+	int devs_increment;	/* ndevs has to be a multiple of this */
+	int ncopies;		/* how many copies to data has */
+	int nparity;		/* number of stripes worth of bytes to
+				   store parity information */
+	u64 max_stripe_size;
+	u64 max_chunk_size;
+	u64 stripe_size;
+	u64 chunk_size;
+	int ndevs;
+};
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4828,23 +4851,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
 	u64 total_avail;
-	int num_stripes;	/* total number of stripes to allocate */
 	int data_stripes;	/* number of stripes that count for
 				   block group size */
-	int sub_stripes;	/* sub_stripes info for map */
-	int dev_stripes;	/* stripes per dev */
-	int devs_max;		/* max devs to use */
-	int devs_min;		/* min devs needed */
-	int devs_increment;	/* ndevs has to be a multiple of this */
-	int ncopies;		/* how many copies to data has */
-	int nparity;		/* number of stripes worth of bytes to
-				   store parity information */
 	int ret;
-	u64 max_stripe_size;
-	u64 max_chunk_size;
-	u64 stripe_size;
-	u64 chunk_size;
 	int ndevs;
 	int i;
 	int j;
@@ -4858,32 +4869,36 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	ctl.start = start;
+	ctl.type = type;
+
 	index = btrfs_bg_flags_to_raid_index(type);
 
-	sub_stripes = btrfs_raid_array[index].sub_stripes;
-	dev_stripes = btrfs_raid_array[index].dev_stripes;
-	devs_max = btrfs_raid_array[index].devs_max;
-	if (!devs_max)
-		devs_max = BTRFS_MAX_DEVS(info);
-	devs_min = btrfs_raid_array[index].devs_min;
-	devs_increment = btrfs_raid_array[index].devs_increment;
-	ncopies = btrfs_raid_array[index].ncopies;
-	nparity = btrfs_raid_array[index].nparity;
+	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
+	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
+	ctl.devs_max = btrfs_raid_array[index].devs_max;
+	if (!ctl.devs_max)
+		ctl.devs_max = BTRFS_MAX_DEVS(info);
+	ctl.devs_min = btrfs_raid_array[index].devs_min;
+	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
+	ctl.ncopies = btrfs_raid_array[index].ncopies;
+	ctl.nparity = btrfs_raid_array[index].nparity;
 
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		max_stripe_size = SZ_1G;
-		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
+		ctl.max_stripe_size = SZ_1G;
+		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		/* for larger filesystems, use larger metadata chunks */
 		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-			max_stripe_size = SZ_1G;
+			ctl.max_stripe_size = SZ_1G;
 		else
-			max_stripe_size = SZ_256M;
-		max_chunk_size = max_stripe_size;
+			ctl.max_stripe_size = SZ_256M;
+		ctl.max_chunk_size = ctl.max_stripe_size;
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		max_stripe_size = SZ_32M;
-		max_chunk_size = 2 * max_stripe_size;
-		devs_max = min_t(int, devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
+		ctl.max_stripe_size = SZ_32M;
+		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
+		ctl.devs_max = min_t(int, ctl.devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
 	} else {
 		btrfs_err(info, "invalid chunk type 0x%llx requested",
 		       type);
@@ -4891,8 +4906,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
-			     max_chunk_size);
+	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+				  ctl.max_chunk_size);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
@@ -4929,20 +4944,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			continue;
 
 		ret = find_free_dev_extent(device,
-					   max_stripe_size * dev_stripes,
+				ctl.max_stripe_size * ctl.dev_stripes,
 					   &dev_offset, &max_avail);
 		if (ret && ret != -ENOSPC)
 			goto error;
 
 		if (ret == 0)
-			max_avail = max_stripe_size * dev_stripes;
+			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
 
-		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
+		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
 			"%s: devid %llu has no free space, have=%llu want=%u",
 					    __func__, device->devid, max_avail,
-					    BTRFS_STRIPE_LEN * dev_stripes);
+				BTRFS_STRIPE_LEN * ctl.dev_stripes);
 			continue;
 		}
 
@@ -4957,30 +4972,31 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		devices_info[ndevs].dev = device;
 		++ndevs;
 	}
+	ctl.ndevs = ndevs;
 
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
 	 */
-	ndevs -= ndevs % devs_increment;
+	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
 
-	if (ndevs < devs_min) {
+	if (ctl.ndevs < ctl.devs_min) {
 		ret = -ENOSPC;
 		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
 			btrfs_debug(info,
 	"%s: not enough devices with free space: have=%d minimum required=%d",
-				    __func__, ndevs, devs_min);
+				    __func__, ctl.ndevs, ctl.devs_min);
 		}
 		goto error;
 	}
 
-	ndevs = min(ndevs, devs_max);
+	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
 
 	/*
 	 * The primary goal is to maximize the number of stripes, so use as
@@ -4989,14 +5005,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * The DUP profile stores more than one stripe per device, the
 	 * max_avail is the total size so we have to adjust.
 	 */
-	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
-	num_stripes = ndevs * dev_stripes;
+	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
+				   ctl.dev_stripes);
+	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
 
 	/*
 	 * this will have to be fixed for RAID1 and RAID10 over
 	 * more drives
 	 */
-	data_stripes = (num_stripes - nparity) / ncopies;
+	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
 
 	/*
 	 * Use the number of data stripes to figure out how big this chunk
@@ -5004,44 +5021,44 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * and compare that answer with the max chunk size. If it's higher,
 	 * we try to reduce stripe_size.
 	 */
-	if (stripe_size * data_stripes > max_chunk_size) {
+	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
 		/*
 		 * Reduce stripe_size, round it up to a 16MB boundary again and
 		 * then use it, unless it ends up being even bigger than the
 		 * previous value we had already.
 		 */
-		stripe_size = min(round_up(div_u64(max_chunk_size,
+		ctl.stripe_size = min(round_up(div_u64(ctl.max_chunk_size,
 						   data_stripes), SZ_16M),
-				  stripe_size);
+				       ctl.stripe_size);
 	}
 
 	/* align to BTRFS_STRIPE_LEN */
-	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
+	ctl.stripe_size = round_down(ctl.stripe_size, BTRFS_STRIPE_LEN);
 
-	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
+	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	map->num_stripes = num_stripes;
+	map->num_stripes = ctl.num_stripes;
 
-	for (i = 0; i < ndevs; ++i) {
-		for (j = 0; j < dev_stripes; ++j) {
-			int s = i * dev_stripes + j;
+	for (i = 0; i < ctl.ndevs; ++i) {
+		for (j = 0; j < ctl.dev_stripes; ++j) {
+			int s = i * ctl.dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
 			map->stripes[s].physical = devices_info[i].dev_offset +
-						   j * stripe_size;
+						   j * ctl.stripe_size;
 		}
 	}
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
-	map->sub_stripes = sub_stripes;
+	map->sub_stripes = ctl.sub_stripes;
 
-	chunk_size = stripe_size * data_stripes;
+	ctl.chunk_size = ctl.stripe_size * data_stripes;
 
-	trace_btrfs_chunk_alloc(info, map, start, chunk_size);
+	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -5052,10 +5069,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	em->map_lookup = map;
 	em->start = start;
-	em->len = chunk_size;
+	em->len = ctl.chunk_size;
 	em->block_start = 0;
 	em->block_len = em->len;
-	em->orig_block_len = stripe_size;
+	em->orig_block_len = ctl.stripe_size;
 
 	em_tree = &info->mapping_tree;
 	write_lock(&em_tree->lock);
@@ -5067,20 +5084,22 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	write_unlock(&em_tree->lock);
 
-	ret = btrfs_make_block_group(trans, 0, type, start, chunk_size);
+	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
 	if (ret)
 		goto error_del_extent;
 
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *dev = map->stripes[i].dev;
 
-		btrfs_device_set_bytes_used(dev, dev->bytes_used + stripe_size);
+		btrfs_device_set_bytes_used(dev,
+					    dev->bytes_used + ctl.stripe_size);
 		if (list_empty(&dev->post_commit_list))
 			list_add_tail(&dev->post_commit_list,
 				      &trans->transaction->dev_update_list);
 	}
 
-	atomic64_sub(stripe_size * map->num_stripes, &info->free_chunk_space);
+	atomic64_sub(ctl.stripe_size * map->num_stripes,
+		     &info->free_chunk_space);
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
-- 
2.25.0

