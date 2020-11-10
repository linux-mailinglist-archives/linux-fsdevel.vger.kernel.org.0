Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780402AD536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgKJLaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:30:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11989 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgKJL2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007710; x=1636543710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TL4h9w0H2mkq0W+1q7so0L+cv0bM1FkrasJQ2e/hSj8=;
  b=aaDmZPsZqg/b1sL2esLeBnVyU5gJU6UYETwsctzEinWgxxHbymi8Sp9M
   TvamFw+IiU0kUijZVbFBhtd6iynVMucqEmKECmbETxD4dwOYJfvgsZ15+
   TRMQ9OtjbEDUpMH3mMtvkrRIWeB1FGSA1iS9WD27tnTRyI/fhcj3oW/0+
   OBDJgFD9faTq/nnlFKhkz/+4B0I5Rxs5OnhdCW560qjocsaS6Q/qVCPF3
   4RsPO9XfqnGgjywo9/87wGupmNh8HUhdFk+g/bRfsKaTJQ5dIz6ysc6AM
   SxJDoGnVtlzO8tHqXvSmWf9CvQA6YGnPyf0MlyE7eWowmA/E8m15HSYY7
   w==;
IronPort-SDR: PXq4JBOghS2qLSJDwfi4nus2MSViMtTLL0qWEdBq9iM9mrmkpWg1T1ZShyHqVMQi0NgOZgA562
 1vn/fio+9MHaETL3kAxOioxKVN2tCzBM8rgHIkVk40QMZSAvma5fosuxY+EzgvaMdrQ4NXBjtJ
 FPYWDAcicpArkM1KiMK8FAdfP93TJTJ7W3bEzCLH0hm3h897ydH4vhXYuQbMft3gl1eRjR0lTh
 zW7xB3ADhASaRjSo0g9PONYc+aabpG/lnAjP52EISutjbgFaq/lcBsM+tHXqihF5yFRiU3ZXWV
 IcE=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376488"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:29 +0800
IronPort-SDR: eHg1EYAYQcf7pHTs4GjIbMXaK1/Hge36j31GHW7/0ydBHt7/MP0uBX6Rk8dl1LpxipI1s+HUbE
 pVOJjgM7UnY3Ii83uHLELnWH65rh/+3M72VaMFtjhVTp1+ZqvTZTHy9jYSXJz3r5/6lw5S8oSO
 of/3lIwyGc8oOSEoetm2bVk6L0tWwAMddBPkQ3JevpoSTzTc6etBmtJ4jy4LYB4cDTRLN0mojw
 HBBtXh6scnT9DKsfSd/m9HvxZZXwqjJS+9eE+KeJuhU2QM7/IPDP+EvqlD5oAeTgN8mFjgPVMx
 24ICTeLPgnBhNonq6U3wxnyh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:30 -0800
IronPort-SDR: 2xJJ4wpuyIln1ZVpTZsv4rH3drGaNxA6Imgs0CrEsnTt/WqbJQrSWSSjVG6FBuj+dUaIaZ8oSN
 8/Hf3qqYRy7lJD0FtvfF2ztrXY4lkfX70XDT2LqC92AgdBGY0OtKs73AEgQ2a5sLHsDuTahPNa
 K+K49bdKAiSh63drZ70aBA9Z9EIxLcuCdLOuo6qPcBwYwDBAK6EV07B7VcuwbBg0v3Tds23k5A
 vH8A8K4SOD6x+TVkcYXhsGffiIbiFazJHHq9XeGWKEfmumWU4FSLgdooDkAoE7ik1ueMYmfytv
 dR0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 15/41] btrfs: emulate write pointer for conventional zones
Date:   Tue, 10 Nov 2020 20:26:18 +0900
Message-Id: <4f84109a6857753734228af3cb626bed112703b2.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conventional zones do not have a write pointer, so we cannot use it to
determine the allocation offset if a block group contains a conventional
zone.

But instead, we can consider the end of the last allocated extent in the
block group as an allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 80 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 69d3412c4fef..9bf40300e428 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -784,6 +784,61 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
+static int emulate_write_pointer(struct btrfs_block_group *cache,
+				 u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = cache->start + cache->length;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	/* We should not find the exact match */
+	if (ret <= 0) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	ret = btrfs_previous_extent_item(root, path, cache->start);
+	if (ret) {
+		if (ret == 1) {
+			ret = 0;
+			*offset_ret = 0;
+		}
+		goto out;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
+
+	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+		length = found_key.offset;
+	else
+		length = fs_info->nodesize;
+
+	if (!(found_key.objectid >= cache->start &&
+	       found_key.objectid + length <= cache->start + cache->length)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	*offset_ret = found_key.objectid + length - cache->start;
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -798,6 +853,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -899,12 +955,16 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 	if (num_conventional > 0) {
-		/*
-		 * Since conventional zones do not have a write pointer, we
-		 * cannot determine alloc_offset from the pointer
-		 */
-		ret = -EINVAL;
-		goto out;
+		ret = emulate_write_pointer(cache, &emulated_offset);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = emulated_offset;
+			else
+				btrfs_err(fs_info,
+			"zoned: failed to emulate write pointer of bg %llu",
+					  cache->start);
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -926,6 +986,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 out:
+	/* An extent is allocated after the write pointer */
+	if (num_conventional && emulated_offset > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, emulated_offset, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
-- 
2.27.0

