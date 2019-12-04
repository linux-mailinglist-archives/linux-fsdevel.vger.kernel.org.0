Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E77C1124E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLDI17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLDI16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448088; x=1606984088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKEeNdIWhF7Iv1E5tol5mrhucL4RWf/bkKmdkmBW/EM=;
  b=aZCCrcqbxGEGmWLVyE2WknXaxTG8w+1OZleu62doZlKal+PG2UIuk//Q
   xZwNFv+CtGp5rGyMQ0kBR0KBKTgvXhEvZfievF5ad+2d02XuYhB8ECh8c
   Fbjq9FedLAPXI681AdCLuhvdUOeQdazkFnKq74kaYYRGh/0mtiSlwQ2Yv
   fEcYv0nYDwwAn5POB4FbzYQoj6FTqZiD205wb5EYP0DFLVCrZVTejAmOF
   y+LwEHeA84DcDAmt/WspFhWZxGBmllQE9yIWL9cneY3bGfMwO200kbcHo
   vkH4oudjKmg9gy6Eid9RPama75HTxHQ1OCDE5HxzCl/trz75ZhFDqwdHI
   g==;
IronPort-SDR: HtxftwZtJy9L6wxN0uxJdgWTB2keeiLM1+7V16LAuPLYYaJ0Pr+rbffP3xICk5k106hCSJ6WfH
 O1FDYipWd4ecLkjdVabeu1VcBv/2sWW5z1+PbQQckltIQ9WJ5UJQ0gfxcq2DpHtU4s/8hZaQ9Y
 ubse8XWJYzIC+SWo/8dh9Y18kROp5OGXsq3vrM9UVTmvP4WuznFgAe9XAuA6wvHBdBXjUN6FIN
 qMGblwMETbwe+0mA7PC6Cy9ZCplVR1NR0CSRKADw0I/ILDDjp2vCBBFKtEQseIOlGsVXGJFtXM
 Lj4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031766"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:08 +0800
IronPort-SDR: iuOPaAPpBz8Wg9+m7s7qNbhRI/kS3rf6+18DXPMib20j/7lRQ/nwXnuRrIJyWPCwPm2M7wyU0B
 mLOMzC20t9JTfQ5FBz2TLK9xxF0Wvg6d/U6FPLmK97Z9vgeZ4aHP3GUXpzbt0QNrSXq3L5xjnE
 Xxug+ahdghskiDAaaTBD9i1PThnhJbuwLNB+hw2G46kjLKemT/LxMNwtqSt20f/MkhhBSoTuCJ
 AGpVEJY5PcTNny8wKo7b6yseqcEb9LtIHke2hxMUwwacqFPp3qtPal5Q5yvkLp230wQmBLEkYS
 9LdVXaMkagIm3CVJ3SndTvCm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:45 -0800
IronPort-SDR: DnRkELUoEJIxmruqWfNJOHWxBdrGPMVWD89dTWoBEN+E0cjmwRndAZ1S/Zw3iv0c6smsvEbTHq
 cLamUiXGSSxvQI3d9zo/+mAKlauTjKSdn+WwSJUp0MqaIfOCZqxwd2j9YswYhmdqtPSwZMj2kt
 jDDiVtsuLyHcYH94WewshGUxuOdkFXR6eAhc1/QusYktEYJ1x81NNKqrNfXD2PIGzg6OEcAjCt
 MRcM2lDP7gby9j3FXY+cn6N0t+HOtDg36AzecDdDpz31Nju6Wl3gy12uDZ2Kv6iiSHBTpFNSTi
 CI8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 13/15] btrfs-progs: mkfs: Zoned block device support
Date:   Wed,  4 Dec 2019 17:25:11 +0900
Message-Id: <20191204082513.857320-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch makes the size of the temporary system group chunk equal to the
device zone size. It also enables PREP_DEVICE_HMZONED if the user enables
the HMZONED feature.

Enabling HMZONED feature is done using option "-O hmzoned". This feature is
incompatible for now with source directory setup.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 extent-tree.c |  8 ++++++++
 mkfs/common.c | 38 +++++++++++++++++++++++++-------------
 mkfs/common.h |  1 +
 mkfs/main.c   | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 89a8b935b602..23b8bf44f4fe 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -32,6 +32,7 @@
 #include "free-space-tree.h"
 #include "common/hmzoned.h"
 #include "common/utils.h"
+#include "mkfs/common.h"
 
 #define PENDING_EXTENT_INSERT 0
 #define PENDING_EXTENT_DELETE 1
@@ -2799,6 +2800,13 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.offset = size;
 
 	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	if (ret == -ENOENT &&
+	    cache->key.objectid == fs_info->fs_devices->zone_size * 2) {
+		/* Write pointer for initial SYSTEM block group */
+		cache->write_offset = cache->alloc_offset =
+			fs_info->nodesize * (MKFS_BLOCK_COUNT - 1);
+		ret = 0;
+	}
 	BUG_ON(ret);
 
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/mkfs/common.c b/mkfs/common.c
index 469b88d6a8d3..c7406a3bd230 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -25,6 +25,7 @@
 #include "common/utils.h"
 #include "common/path-utils.h"
 #include "common/device-utils.h"
+#include "common/hmzoned.h"
 #include "mkfs/common.h"
 
 static u64 reference_root_table[] = {
@@ -155,6 +156,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
+	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+	u64 system_group_size =  BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
+	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED)) {
+		system_group_offset = cfg->zone_size * 2;
+		system_group_size = cfg->zone_size;
+	}
 
 	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
 	if (!buf)
@@ -186,7 +194,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
 	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
-		cfg->blocks[i] = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER +
+		cfg->blocks[i] = system_group_offset +
 			cfg->nodesize * (i - 1);
 	}
 
@@ -204,7 +212,10 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
-	btrfs_set_super_cache_generation(&super, -1);
+	if (cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED)
+		btrfs_set_super_cache_generation(&super, 0);
+	else
+		btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
@@ -320,8 +331,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_device_id(buf, dev_item, 1);
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
-	btrfs_set_device_bytes_used(buf, dev_item,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
@@ -342,14 +352,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 	/* then we have chunk 0 */
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_disk_key_offset(&disk_key, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_CHUNK_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
-	btrfs_set_chunk_length(buf, chunk, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_chunk_length(buf, chunk, system_group_size);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
@@ -359,7 +369,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_chunk_num_stripes(buf, chunk, 1);
 	btrfs_set_stripe_devid_nr(buf, chunk, 0, 1);
 	btrfs_set_stripe_offset_nr(buf, chunk, 0,
-				   BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+				   system_group_offset);
 	nritems++;
 
 	write_extent_buffer(buf, super.dev_item.uuid,
@@ -398,7 +408,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		sizeof(struct btrfs_dev_extent);
 
 	btrfs_set_disk_key_objectid(&disk_key, 1);
-	btrfs_set_disk_key_offset(&disk_key, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
@@ -410,14 +420,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_dev_extent_chunk_objectid(buf, dev_extent,
 					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_dev_extent_chunk_offset(buf, dev_extent,
-					  BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+					  system_group_offset);
 
 	write_extent_buffer(buf, chunk_tree_uuid,
 		    (unsigned long)btrfs_dev_extent_chunk_tree_uuid(dev_extent),
 		    BTRFS_UUID_SIZE);
 
-	btrfs_set_dev_extent_length(buf, dev_extent,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_dev_extent_length(buf, dev_extent, system_group_size);
 	nritems++;
 
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
@@ -464,13 +473,16 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	buf->len = BTRFS_SUPER_INFO_SIZE;
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
-			cfg->blocks[MKFS_SUPER_BLOCK]);
+	ret = sbwrite(fd, buf->data, cfg->blocks[MKFS_SUPER_BLOCK]);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
 	}
 
+	ret = fsync(fd);
+	if (ret)
+		goto out;
+
 	ret = 0;
 
 out:
diff --git a/mkfs/common.h b/mkfs/common.h
index 1ca71a4fcce5..b7742dedbae1 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -55,6 +55,7 @@ struct btrfs_mkfs_config {
 	u64 num_bytes;
 	/* checksum algorithm to use */
 	enum btrfs_csum_type csum_type;
+	u64 zone_size;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 14e9ae7aeb6d..0aa73cce728b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -48,6 +48,7 @@
 #include "crypto/crc32c.h"
 #include "common/fsfeatures.h"
 #include "common/box.h"
+#include "common/hmzoned.h"
 
 static int verbose = 1;
 
@@ -68,8 +69,16 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
+	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	int ret;
 
+	if (fs_info->fs_devices->hmzoned) {
+		/* Two zones are reserved for superblock */
+		system_group_offset = fs_info->fs_devices->zone_size * 2;
+		system_group_size = fs_info->fs_devices->zone_size;
+	}
+
 	if (mixed)
 		flags |= BTRFS_BLOCK_GROUP_DATA;
 
@@ -89,9 +98,8 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	 */
 	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
 				     BTRFS_BLOCK_GROUP_SYSTEM,
-				     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER,
-				     BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	allocation->system += BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+				     system_group_offset, system_group_size);
+	allocation->system += system_group_size;
 	if (ret)
 		return ret;
 
@@ -789,6 +797,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int metadata_profile_opt = 0;
 	int discard = 1;
 	int ssd = 0;
+	int hmzoned = 0;
 	int force_overwrite = 0;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
@@ -803,6 +812,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
+	u64 system_group_size;
 
 	crc32c_optimization_init();
 
@@ -934,6 +944,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
+	hmzoned = features & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
 		goto error;
@@ -943,6 +955,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (source_dir_set && hmzoned) {
+		error("The -r and hmzoned feature are incompatible");
+		exit(1);
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -974,6 +991,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	file = argv[optind++];
 	ssd = is_ssd(file);
+	if (hmzoned) {
+		if (zoned_model(file) == ZONED_NONE) {
+			error("%s: not a zoned block device", file);
+			exit(1);
+		}
+		if (!zone_size(file)) {
+			error("%s: zone size undefined", file);
+			exit(1);
+		}
+	}
 
 	/*
 	* Set default profiles according to number of added devices.
@@ -1130,7 +1157,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
 			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(verbose ? PREP_DEVICE_VERBOSE : 0));
+			(verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
@@ -1141,9 +1169,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	if (dev_block_count < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+	system_group_size = hmzoned ?
+		zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
-				(unsigned long long)BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+				(unsigned long long)system_group_size);
 		goto error;
 	}
 
@@ -1161,6 +1191,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
 	mkfs_cfg.csum_type = csum_type;
+	mkfs_cfg.zone_size = zone_size(file);
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1244,7 +1275,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				block_count,
 				(verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		if (ret) {
 			goto error;
 		}
@@ -1341,6 +1373,10 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
+		printf("Zoned device:       %s\n", hmzoned ? "yes" : "no");
+		if (hmzoned)
+			printf("Zone size:          %s\n",
+			       pretty_size(fs_info->fs_devices->zone_size));
 		btrfs_parse_features_to_string(features_buf, features);
 		printf("Incompat features:  %s\n", features_buf);
 		printf("Checksum:           %s",
-- 
2.24.0

