Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DAF154223
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgBFKoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:34 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985872; x=1612521872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OapUE4/TXFDkDREFr3VroUVQcjh5AHK4xiF6zG3Xe+M=;
  b=p8gFZA1owtoB34lADSPRfrBh3PIcjvZ5uzqlsj9CzSItYediTtkDCqS3
   IuiAL7NwAlNqJLw9taxzqz8gfwm/MFgWik2JuE6yKh4kWJlytqfHedYza
   Rz4R6nEMxa8kdrYpoCVewu4Qd80JenACb2fAQUJF1/Yw85k/fF7iroMAZ
   MKcagG49l8NflAv9FhgX2XMgNsmptyH9VjUGdTYQRBAwiAqajQiTK0cOe
   n/gaHxA0ZxRTfdY2cFJH08oDhzPwiV7rA11dF3P3OUPdek5rI/fHz1pg0
   zvQRS2hLyNHqlYRZiX6a4WOIySjm1v3mQbI6zuN1lYaFO5hUdoCgSSJTH
   g==;
IronPort-SDR: i3A0ulnW1riEarh3pKi2TSKzpBHOqBhgRZ93xTIErnEPJ51BAFR/97NFRq/20Qr4yGDeIi3ypQ
 z1bfXPIemhcMADBvJevdc600rengpn3CIsTrH3nJzG/js7aC26c1Ml6Av0H2gii5T55M9N00xb
 Mou3n0Y99ctZGmB/631rVdtmk1zqZQiURfGaYnJxN82LdwOcycH/gGU6qszG/DG7dPr6+BO9/7
 sejPeyzTHB0X5sHiW97fCSKnuJyv4vw2h6CBmW+TPE/PS7Bh0Af+k/KDj/fyOAhYExMZ+Oiyd7
 89I=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209519"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:32 +0800
IronPort-SDR: HXKs7rFTmDo7bKWDHRI2aHNqWHphjkWQ1lHrTaDVLGVHEcoDf7e5kX/omyFYYNsxzk5zHJXZau
 5oQnY3HFG8m0cwSnAB3cxagdczlSHNETUJWz3r6n6RDsM80FnKUEiHjHOYJhZEQfK+S6CoUOJ0
 3Djp3QP8gjdiMre4BPhrrUvExbESYEAdjZBj1fCjfHEvXT7OtSSdgq3UqTwnIjc4/+hlD9xSl4
 c5tzxRn4EPL2WxVNU3jDgFvZ0BGehkban4vfGR5eGAB794m1pJiEPV3niEsb4CjYfFOXOHPC2k
 soZiSvRHyjrqUlxySyAxoH41
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:32 -0800
IronPort-SDR: M3oCF/RQnCLLRyIPEvOh5Qs8BPXwuHYl4sZ2WKxsJBkf8OSc1OVE4vcuaC3eJF1RlGi0U/7q1q
 mbCzNQLq70t6JUecXOzN9k1Plje0jzdUDCVteCM5EE0N5zXwfGhPGKCgSfuYHKD8WZ6bKKyIEM
 1gHz1/pyCrVvVoQTsWQjIwVRi8lqbyMSLyZZvptqSdaxNMpGF94fEFo6JS/YoncbKfVA4twh14
 A1pIHk13UjLqnNhOA+prlmqRcFOmxCCCR9pxj/WifbAR6wYMnvFgFBh7RaiIRs7OZWbwrwUg63
 dc0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/20] btrfs: factor out create_chunk()
Date:   Thu,  6 Feb 2020 19:42:02 +0900
Message-Id: <20200206104214.400857-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
creates a chunk. There is no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 126 +++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 85c01df26852..15837374db9c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5051,86 +5051,53 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-			       u64 start, u64 type)
+static int create_chunk(struct btrfs_trans_handle *trans,
+			struct alloc_chunk_ctl *ctl,
+			struct btrfs_device_info *devices_info)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_fs_devices *fs_devices = info->fs_devices;
 	struct map_lookup *map = NULL;
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
-	struct btrfs_device_info *devices_info = NULL;
-	struct alloc_chunk_ctl ctl;
+	u64 start = ctl->start;
+	u64 type = ctl->type;
 	int ret;
 	int i;
 	int j;
 
-	BUG_ON(!alloc_profile_is_valid(type, 0));
-
-	if (list_empty(&fs_devices->alloc_list)) {
-		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-			btrfs_debug(info, "%s: no writable device", __func__);
-		return -ENOSPC;
-	}
-
-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
-		BUG();
-	}
-
-	ctl.start = start;
-	ctl.type = type;
-	set_parameters(fs_devices, &ctl);
-
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
-	if (!devices_info)
+	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
+	if (!map)
 		return -ENOMEM;
+	map->num_stripes = ctl->num_stripes;
 
-	ret = gather_device_info(fs_devices, &ctl, devices_info);
-	if (ret < 0)
-		goto error;
-
-	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
-	if (ret < 0)
-		goto error;
-
-	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
-	if (!map) {
-		ret = -ENOMEM;
-		goto error;
-	}
-	map->num_stripes = ctl.num_stripes;
-
-	for (i = 0; i < ctl.ndevs; ++i) {
-		for (j = 0; j < ctl.dev_stripes; ++j) {
-			int s = i * ctl.dev_stripes + j;
+	for (i = 0; i < ctl->ndevs; ++i) {
+		for (j = 0; j < ctl->dev_stripes; ++j) {
+			int s = i * ctl->dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
 			map->stripes[s].physical = devices_info[i].dev_offset +
-						   j * ctl.stripe_size;
+						   j * ctl->stripe_size;
 		}
 	}
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
-	map->sub_stripes = ctl.sub_stripes;
+	map->sub_stripes = ctl->sub_stripes;
 
-	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
+	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
 	em = alloc_extent_map();
 	if (!em) {
 		kfree(map);
-		ret = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	em->map_lookup = map;
 	em->start = start;
-	em->len = ctl.chunk_size;
+	em->len = ctl->chunk_size;
 	em->block_start = 0;
 	em->block_len = em->len;
-	em->orig_block_len = ctl.stripe_size;
+	em->orig_block_len = ctl->stripe_size;
 
 	em_tree = &info->mapping_tree;
 	write_lock(&em_tree->lock);
@@ -5138,11 +5105,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (ret) {
 		write_unlock(&em_tree->lock);
 		free_extent_map(em);
-		goto error;
+		return ret;
 	}
 	write_unlock(&em_tree->lock);
 
-	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
+	ret = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
 	if (ret)
 		goto error_del_extent;
 
@@ -5150,20 +5117,19 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		struct btrfs_device *dev = map->stripes[i].dev;
 
 		btrfs_device_set_bytes_used(dev,
-					    dev->bytes_used + ctl.stripe_size);
+					    dev->bytes_used + ctl->stripe_size);
 		if (list_empty(&dev->post_commit_list))
 			list_add_tail(&dev->post_commit_list,
 				      &trans->transaction->dev_update_list);
 	}
 
-	atomic64_sub(ctl.stripe_size * map->num_stripes,
+	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
-	kfree(devices_info);
 	return 0;
 
 error_del_extent:
@@ -5175,6 +5141,56 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	free_extent_map(em);
 	/* One for the tree reference */
 	free_extent_map(em);
+
+	return ret;
+}
+
+static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+			       u64 start, u64 type)
+{
+	struct btrfs_fs_info *info = trans->fs_info;
+	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
+	int ret;
+
+	BUG_ON(!alloc_profile_is_valid(type, 0));
+
+	if (list_empty(&fs_devices->alloc_list)) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG))
+			btrfs_debug(info, "%s: no writable device", __func__);
+		return -ENOSPC;
+	}
+
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
+		BUG();
+	}
+
+	ctl.start = start;
+	ctl.type = type;
+	set_parameters(fs_devices, &ctl);
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info)
+		return -ENOMEM;
+
+	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto error;
+
+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto error;
+
+	ret = create_chunk(trans, &ctl, devices_info);
+	if (ret < 0)
+		goto error;
+
+	kfree(devices_info);
+	return 0;
+
 error:
 	kfree(devices_info);
 	return ret;
-- 
2.25.0

