Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC522A06F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgJ3NxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgJ3NxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065985; x=1635601985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IsgXCjwhP7h5iONIZeWOyieIlDJD/IVYMJp+/jHltfU=;
  b=ETRzRIDC2FfoncsYcZFKBBDgCb8oJ/KkYebNkvW09sbXkaGCS7ml5RAN
   bzzRYAJpLr1OdHxwph47BZmW+053mL8QF9AVswrKRt/lYsvkIDnPxNYkQ
   GrSds33fknqU1aG9XnCDONOfmo9mkZBvWtKCppzXTAjlUCTOdEEuMXiJy
   XDqTfmgZHp6aWKzy1P1CuTNODyNIVniY2inih0atXx4aWYicGR6QIvOEa
   Tw8e5vLi+SozjpC5PO6nNhme7Dm5ExoT9Gc6XGYzLBttyxRYSK/uzRzoG
   B/hsEpu2fOBXAmhPy6ts9WjeIoxcz4sXOG8BtB43rXRSa37m0c1CxTRC2
   w==;
IronPort-SDR: 6Yo/djRoQfwrV5OxpewnMGQ3Rke05fSK3X2GiJDg7uekDMWVxfDG+5IIvL8w0yk6UAllor+2xR
 xcmt06AVvPUJO4hGqVvgSHMO5ZJYU4klJrZvNxTvjKy+UZLFPLQ3lDWSoNwxkarfzV9PNBImf4
 We6ZafMsCNDoaGvwiwEO2D5Uhw28I3O5traMxO+vIRSy6Ks+xlCM3oNCUhfF10q8AJYc4gHw5D
 qYdlSKDya+zrdz2yGhebKPrnqBytIAuFlDtNJG3RFQZPSyem5FQk6xgxoJGWZIH7QYg6kGcRhf
 hHE=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806624"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:50 +0800
IronPort-SDR: WF+58+dKaKHc3KOwSIx3GFfssKxW/7piZ4U4TAPeqq87k8z+uVX6cGxyx23711uEkIB4gBy8AY
 FLcihna51G+MsKJtZl0rFVY1ELm7ZVA+TNlUMX0/RY4q539G2PMqwUvZRkfF4CqACd8eaKOmUL
 z6sK6Dk6vUu4CARGt2HWbb4dS52gulTcv+kaFMFCbdXHZT8ctCCKTqISSm2qEimYQz2KYLM90c
 jWKlB4qgFUuJBr2bGuWozuJciRutK6+Nh9KuzubglDVNn1VJh1vPenA6skLWgpa9/m0a/csRTD
 nT+A6EcE17dX1nhePkznVILs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:05 -0700
IronPort-SDR: 0dtVsGyAiiT2ac/Uo6vL2gtHrThZtsdZhFY8au/Tb20/dwIboaPwUOzDYFlBqIx3EkTnS3EHR6
 VTqd2T1TU0qPkAx5eEEiBhqh3FDRaqdTfw8f28DOftmoih9wmQ4eiAf6mlCUdjz4qE5MCaiWG7
 f498kxbM0TRmOF5KR5NomLQA0V8HO00ZwppfAaHeZqUylBKYgrUClCbLuECsayU/6nkjQCoNAA
 dhtjkbzSAvTcZijuzETfhD8xEU6amuDMvH9uLGXc7AxH7f62Ncqzq/efatJ0XXftd1ocZRGCSf
 m40=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 24/41] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Fri, 30 Oct 2020 22:51:31 +0900
Message-Id: <3ee4958e7ebcc06973ed2d7c84a9cf9240d6e7d7.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_rmap_block currently reverse-maps the physical addresses on all
devices to the corresponding logical addresses.

This commit extends the function to match to a specified device. The old
functionality of querying all devices is left intact by specifying NULL as
target device.

We pass block_device instead of btrfs_device to __btrfs_rmap_block. This
function is intended to reverse-map the result of bio, which only have
block_device.

This commit also exports the function for later use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 28 ++++++++++++++++++++++------
 fs/btrfs/block-group.h |  3 +++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 82d556368c85..21e40046dce1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1644,8 +1644,11 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 }
 
 /**
- * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
+ * __btrfs_rmap_block - Map a physical disk address to a list of logical
+ *                      addresses
  * @chunk_start:   logical address of block group
+ * @bdev:	   physical device to resolve. Can be NULL to indicate any
+ *                 device.
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
  * @naddrs:	   length of @logical
@@ -1655,9 +1658,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  * Used primarily to exclude those portions of a block group that contain super
  * block copies.
  */
-EXPORT_FOR_TESTS
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+int __btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1675,6 +1678,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1689,14 +1693,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	for (i = 0; i < map->num_stripes; i++) {
 		bool already_inserted = false;
 		u64 stripe_nr;
+		u64 offset;
 		int j;
 
 		if (!in_range(physical, map->stripes[i].physical,
 			      data_stripe_length))
 			continue;
 
+		if (bdev && map->stripes[i].dev->bdev != bdev)
+			continue;
+
 		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
+		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
 		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
@@ -1710,7 +1718,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1732,6 +1740,14 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	return ret;
 }
 
+EXPORT_FOR_TESTS
+int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+{
+	return __btrfs_rmap_block(fs_info, chunk_start, NULL, physical, logical,
+				  naddrs, stripe_len);
+}
+
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5be47f4bfea7..401e9bcefaec 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -275,6 +275,9 @@ void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
+int __btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-- 
2.27.0

