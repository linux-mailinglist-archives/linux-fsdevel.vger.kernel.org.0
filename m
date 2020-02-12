Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD115A1BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBLHVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492076; x=1613028076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ye2SKlsfzwS1oBfYCAJOotkkeAlWpJ1dzlzFlE1InAo=;
  b=LpFb9MUH3IlMiTvVgzJDRyyDUUSAJTXQ4lMhKQGHdvYsxXo2snx9qOCV
   viZ+JY/20hsH8OcVDLMIbqNDBmo7jDxxUDqwps+rydB2xvGjwqeH7ijYI
   QeogO2FKKpFNJ5sOiqDZmZA+mhEMdtBDrE81ct3FOP0D9Y7UFQSbyUqOF
   9Xt8qCsVI91zIjD5TRpm2Ue6v8Huvof/NJkDNXwfQ9iSWBaT5b8vGqxxC
   +9/5hHXNYuVtfrqSzMtztWFAoi7TZER1qgHZfvYOYzuxcXo6M+Nu6JplF
   daIsSSBbx2lLEhUQKOtvqEaQ/n9GOcAZ41wIiv3GXJFxtFW6IhMHcmq8E
   g==;
IronPort-SDR: 8n0Q+Vm0EwLiCX/mKn+qMcAnqy/p5KFyPeCZ24R2a2YS5SAwOkVfp1kZqkvtStk9wz4BYQt0qc
 r0XVcenlolvf/4kS7rrwQ/Eh9vvsTaBhupTV08yVaCq3V+fTjh+VOe7fiZwQJkokUNEj5rVfrf
 xo6OrWEe3WBUwBSwIdVxX1gFnBDvBfaC7sQIBK1RuGGZE0GZ+yxSow6w6mf6NemNoWQKUPOHcz
 Mn0VPj7fcp15fvwLKbG5AZNo+NazC1KGdiUe3tEx760C1uoP8voE6s0V9CUp1/X85YzqAj5Wky
 Eio=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448915"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:16 +0800
IronPort-SDR: /6l/+qSrJ9DEcOQ+VRiE5zyAV7aiv7yqEQ0VfYAdZY6cv3WiUayB8dnqb0sjBBn3gy228MJsPB
 SFAzxSdKjClMd/am1odFwajqBfqgOtWKQ7xeeUZtLTdax1umJXOwN6JRvqflTTUx8VoLXX86+i
 0tuazh6KgX1CjSMtA7Egex4149GQXo1F9Lh6KiInqLFMe3WivQs/XMGRDM5na3NMKKeo42UZvE
 yyjSG/DFMc3yfKrx/gYd3vwdcQO+9wQYJT0IeseyqT+91c1N8UxQWtoZoLlfAkapNsHK1gYJwo
 TYWwJ2JclHcaMLCeSAT2eLJU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:03 -0800
IronPort-SDR: H+2m/vvrXz7Zf7GfjZFDvTRu3cmIP667hWUoij/bee3akSX1Tqhv/23WfrESq09+CvS0QcSD4O
 y5zHZrcebexWBqZOHzToBSGkbt2QWWDHAS+rRlv5BVDqwRFmAN49irdDcM7dqGgsm/mgNMOdnX
 gtzqGxpWjYm3IcQQzNbuZR/0x8+iEYAu82p4CNuBgU7v4OvP6og5hWCCChX2rq43JvcjfD5Uey
 VrzKhcSrc9DWbJ6fH3/tD9WvtAoSMV2ZRZfFC95YgSajJa/EYKnUhWRMirT2bsVvlY+PyChLpE
 DwQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:12 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 09/21] btrfs: factor out create_chunk()
Date:   Wed, 12 Feb 2020 16:20:36 +0900
Message-Id: <20200212072048.629856-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
 fs/btrfs/volumes.c | 130 ++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 00085943e4dd..3e2e3896d72a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5052,90 +5052,53 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
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
 
-	if (!alloc_profile_is_valid(type, 0)) {
-		ASSERT(0);
-		return -EINVAL;
-	}
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
-	init_alloc_chunk_ctl(fs_devices, &ctl);
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
-
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
@@ -5143,11 +5106,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
 
@@ -5155,20 +5118,19 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -5180,7 +5142,55 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	free_extent_map(em);
 	/* One for the tree reference */
 	free_extent_map(em);
-error:
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
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
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
+	init_alloc_chunk_ctl(fs_devices, &ctl);
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info)
+		return -ENOMEM;
+
+	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto out;
+
+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto out;
+
+	ret = create_chunk(trans, &ctl, devices_info);
+
+out:
 	kfree(devices_info);
 	return ret;
 }
-- 
2.25.0

