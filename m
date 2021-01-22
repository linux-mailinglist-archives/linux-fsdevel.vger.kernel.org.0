Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F12FFCDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAVGYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:24:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhAVGYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296650; x=1642832650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8LrIa6gECYZDXtQkC4uR5xH8wik8We3GtwQpzwZDMQ=;
  b=om/VNzq0Q/IS+J9tz8vAe/dCkZerYSxhJVJrkWP6808SFg+Gm0JJ1NuD
   LE/LmUUcmQj9MMHOdviBlWwZJxd2G71kvL71mxiS25BpGbkY5NZIOi1jw
   oGBbZC28ayktI3vYtfwbxYwGKe7XZtsVzNlAS5bSrvhq6vXMBHmLAhxa6
   u9ad7ikzXCxgeO67FhkeWSXrOgZ03WYhvNX2QRKl36taILWTBmBgz+bLS
   liZUoThpeNlRDR0lWoE0qKOelVzaXHZ+rk8CXoZ0oPBaFokgHP4Oo8qOS
   2TSTxSDSpBi7i4vSo5asw3EEATl+o2kVngNXS6jPPP2sdFtpC94uBrHmj
   g==;
IronPort-SDR: f0TCIH70QaBsPjN0d4vb/heuwHKc40ADL8JINprlxPDhvm+GoJJ/seG9WSlyA6RZtOl81npvCn
 hpwcmKkzngppo+pNh9hnNp2+D/EQQ04HPNwdnt0lfSTYA4Q/NIdg5j3tS2Oc/IOOilxGZU+bSt
 HqPAFQjuwFbCTkrMHnH2VNK4WWolWZ1vMoVku605Y+zY132TDWToPgYVgkkYzNUzZH6LZ5QXM7
 czsYXY4R6Qx3ERWyjV72cDqkdk088WSd/o2zz2Ni71vb+lotfjiySAeIqlEzjCtrZ5uEuJxHNX
 6NM=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391939"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:29 +0800
IronPort-SDR: QkwOp3mzFGQ+WueVIwTSho0OTVmrSB066XAeSuPGPwATe1IhQW0DcRk4xO1/fqz+0VYIX0Qxyt
 KfJyoKuMa6lHvvVbbDM9fPvq9V3b9bM3iCxrkoOUPmQdDtMozWonS4kmTdHrtH5RpyTFPKJFjG
 v52AmDSm9/B8Pe+jYdq/BRNZqWa3oiVJhWz7VDEfq6akBBhvEOXx9Ur1RGfx04cDhC4Xjl9gb4
 3If72ysNzou7qJT+pL4mRqWPnF+a9I5l1h+vn4c5HiDqVMrYAhhqWJhHtCn2sT1Db4pVfgeizh
 Z/+H5ktPXhFAeRmHD/p2O8A5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:01 -0800
IronPort-SDR: GYPVu1TtWTgGcJEReCT9FU2wRhDD16NVnqxf+lwlQUMrspqx6hGxBQITREE9Ir3BAAznRR2E8v
 9waDynpaxibn1LpkiibRvoH5yF4ZO6F89i+c5onT0BG9mmuPuP8w5+JbZnOGfzqH5zh4VCcb+m
 cT2gDP+t9lsqyfziqcP8JGRM8VGEwe+bmOvUIRHQ7A9H1lOOFzd+yymvLdYdQ1vModqohMbdOv
 WHvAxU8Bs7t1FAa21SUqPxg/woquyjC8AWM6iTvjhtaIDTKNM7TS+M1s1NY1Nn+lINZ30NuTcM
 5RE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:27 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 05/42] btrfs: release path before calling into btrfs_load_block_group_zone_info
Date:   Fri, 22 Jan 2021 15:21:05 +0900
Message-Id: <9caf351d3da77e5b9f781226b2c199b570cccb62.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since we have no write pointer in conventional zones, we cannot determine
the allocation offset from it. Instead, we set the allocation offset after
the highest addressed extent. This is done by reading the extent tree in
btrfs_load_block_group_zone_info().

However, this function is called from btrfs_read_block_groups(), so the
read lock for the tree node can recursively taken.

To avoid this unsafe locking scenario, release the path before reading the
extent tree to get the allocation offset.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..60d843f341aa 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1797,24 +1797,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-static void read_block_group_item(struct btrfs_block_group *cache,
-				 struct btrfs_path *path,
-				 const struct btrfs_key *key)
-{
-	struct extent_buffer *leaf = path->nodes[0];
-	struct btrfs_block_group_item bgi;
-	int slot = path->slots[0];
-
-	cache->length = key->offset;
-
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	cache->used = btrfs_stack_block_group_used(&bgi);
-	cache->flags = btrfs_stack_block_group_flags(&bgi);
-}
-
 static int read_one_block_group(struct btrfs_fs_info *info,
-				struct btrfs_path *path,
+				struct btrfs_block_group_item *bgi,
 				const struct btrfs_key *key,
 				int need_clear)
 {
@@ -1829,7 +1813,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (!cache)
 		return -ENOMEM;
 
-	read_block_group_item(cache, path, key);
+	cache->length = key->offset;
+	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->flags = btrfs_stack_block_group_flags(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -1988,19 +1974,30 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		need_clear = 1;
 
 	while (1) {
+		struct btrfs_block_group_item bgi;
+		struct extent_buffer *leaf;
+		int slot;
+
 		ret = find_first_block_group(info, path, &key);
 		if (ret > 0)
 			break;
 		if (ret != 0)
 			goto error;
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		ret = read_one_block_group(info, path, &key, need_clear);
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		read_extent_buffer(leaf, &bgi,
+				   btrfs_item_ptr_offset(leaf, slot),
+				   sizeof(bgi));
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		btrfs_release_path(path);
+		ret = read_one_block_group(info, &bgi, &key, need_clear);
 		if (ret < 0)
 			goto error;
 		key.objectid += key.offset;
 		key.offset = 0;
-		btrfs_release_path(path);
 	}
 	btrfs_release_path(path);
 
-- 
2.27.0

