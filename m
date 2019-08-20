Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43495655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfHTExa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfHTEx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276808; x=1597812808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VeiuaukNyeyG+n12dnCxZySC9iDVGiqt8CDL1UFy4l4=;
  b=DUq7rG7ZrSmbD2eWd7daYZfyepvBXP+Nstq0TKqtuTiv1FSvauN275p2
   BoYq5/lzesrH67ThXuBMlld1s03GQMA+n1L5FBg8jTfJ2NJjEiNQI9Lx3
   vFVUpkmBFVbaE2tNtPzHyeDcshPJ6TOhOY7FBwp3yZKmy5o/6aGMbPeG4
   Igls5mBoWOABC+u5zxmLrT5x3q6G28awBFfL0fzT4z77ML6v016SKynpD
   XTDiUvHa4QIaufb1wrIXUdLTRtLREjb8QmYia2M0yw9kaXxJ2CWsfs+cA
   7LD9LetUIKeilYoURmXzvsDXumjoWPbtLpfQbKMbiF1yDBBQvUnsS8Wue
   w==;
IronPort-SDR: M8/dcpvze5YOYGECYjFR5qLvQE3v0o5N7atuPhNVM9V6cHf6ghn4nX7zhSXE/xcIWpzpdnAM8X
 P/0IosDLqC1+OB2e8KEYv4c3ZhC+S/aUfAI4QEFHnu3WyRnrODor89VgthbYthw7w6lTeXzqOi
 fxP5GOId6JIx7ul1LqRqXgBv1rWcF7o8du98QldYvOG5JKsW80xyhXKwDZHL6vP+a86oSaOLwP
 NUNpIVPZqE5UoKa7wq2Vii5znEGEitxRcLaNIklGxn+gUUDSNCkyHqus3mdyOtXz/RVxm0D53P
 3fA=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136319"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:28 +0800
IronPort-SDR: sxV0h5eRJL54z5iTVLpnpGPxP+VWM06EZuiHN/HpNk5PG3okA5I7F1k9PydBuI+tTS0Xk+0frb
 5G+ZTwukrQ+bJKRUpmq5am5rSg4EGJIoEcfy/6Jz4MDpt4YewIuvEjI4H7PwMkzLyYOE3PGsxo
 PmFVPwotBoXS9pdIAVPQiGlvp8+vd0OTIK5gjpiBt2nlEgx0LDmueT1DgfKLpjYcXOn6aEoHMi
 jaD5Wu+AS6oNS9sjCpQRvq5Myk0HXStDnUg8y0IAcuR8gqlZeWWCRJuragp3u2/KaT0QaMkUw6
 /5gwSavsUa9UP5gXZ2QRqTE6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:52 -0700
IronPort-SDR: TW5ErjFy1AvR3O1QoM0dPp+EinlHtzbvqHvSDRipBP3TOjxM2GkiV1pItxZ/lW2gYuN+RHvky9
 macoJdcsy2enyrj1Xcr8BO2IYNDE0mlyyPKQF1vJ0HgmOqmcE2zKVv194Gbx7uevK1QDw97+Ej
 x7qLWT9aBCojFiR5dzbkNLP0QATOoLU19+Me4LNrdU/hXGE3RXdJoSM8X8crgFclLW2glVpqV4
 /XvCj/TnsSbI7bgqlfjZ+z0oLTB+t5gOXpDDcCUGuQKFQstM9iTO7IGeQm5cogpTUCFDo/anok
 xf4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 13/15] btrfs-progs: mkfs: Zoned block device support
Date:   Tue, 20 Aug 2019 13:52:56 +0900
Message-Id: <20190820045258.1571640-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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
 mkfs/common.c | 20 ++++++++++-----
 mkfs/common.h |  1 +
 mkfs/main.c   | 67 +++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index caca5e707233..6b5c5500da67 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -154,6 +154,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
+	u64 system_group_size;
 
 	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
 	if (!buf)
@@ -203,7 +204,10 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
 	btrfs_set_super_csum_type(&super, BTRFS_CSUM_TYPE_CRC32);
 	btrfs_set_super_chunk_root_generation(&super, 1);
-	btrfs_set_super_cache_generation(&super, -1);
+	if (cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED)
+		btrfs_set_super_cache_generation(&super, 0);
+	else
+		btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
@@ -314,12 +318,17 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
+	if (cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED)
+		system_group_size = cfg->zone_size -
+			BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+	else
+		system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
 	dev_item = btrfs_item_ptr(buf, nritems, struct btrfs_dev_item);
 	btrfs_set_device_id(buf, dev_item, 1);
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
-	btrfs_set_device_bytes_used(buf, dev_item,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
@@ -347,7 +356,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
-	btrfs_set_chunk_length(buf, chunk, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_chunk_length(buf, chunk, system_group_size);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
@@ -413,8 +422,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		    (unsigned long)btrfs_dev_extent_chunk_tree_uuid(dev_extent),
 		    BTRFS_UUID_SIZE);
 
-	btrfs_set_dev_extent_length(buf, dev_extent,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_dev_extent_length(buf, dev_extent, system_group_size);
 	nritems++;
 
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
diff --git a/mkfs/common.h b/mkfs/common.h
index 28912906d0a9..d0e4c7b2c906 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -53,6 +53,7 @@ struct btrfs_mkfs_config {
 	u64 features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
+	u64 zone_size;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 948c84be5f39..83463f8d819a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -68,8 +68,13 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
+	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	int ret;
 
+	if (fs_info->fs_devices->hmzoned)
+		system_group_size = fs_info->fs_devices->zone_size -
+			BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+
 	if (mixed)
 		flags |= BTRFS_BLOCK_GROUP_DATA;
 
@@ -90,8 +95,8 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
 				     BTRFS_BLOCK_GROUP_SYSTEM,
 				     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER,
-				     BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	allocation->system += BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+				     system_group_size);
+	allocation->system += system_group_size;
 	if (ret)
 		return ret;
 
@@ -297,11 +302,19 @@ static int create_one_raid_group(struct btrfs_trans_handle *trans,
 
 static int create_raid_groups(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root, u64 data_profile,
-			      u64 metadata_profile, int mixed,
+			      u64 metadata_profile, int mixed, int hmzoned,
 			      struct mkfs_allocation *allocation)
 {
 	int ret;
 
+	if (!metadata_profile && hmzoned) {
+		ret = create_one_raid_group(trans, root,
+					    BTRFS_BLOCK_GROUP_SYSTEM,
+					    allocation);
+		if (ret)
+			return ret;
+	}
+
 	if (metadata_profile) {
 		u64 meta_flags = BTRFS_BLOCK_GROUP_METADATA;
 
@@ -548,6 +561,7 @@ out:
 /* This function will cleanup  */
 static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 			       struct mkfs_allocation *alloc,
+			       int hmzoned,
 			       u64 data_profile, u64 meta_profile,
 			       u64 sys_profile)
 {
@@ -599,7 +613,11 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group_item);
 		if (is_temp_block_group(path.nodes[0], bgi,
 					data_profile, meta_profile,
-					sys_profile)) {
+					sys_profile) ||
+		    /* need to remove the first sys chunk */
+		    (hmzoned && found_key.objectid ==
+		     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER)) {
+
 			u64 flags = btrfs_disk_block_group_flags(path.nodes[0],
 							     bgi);
 
@@ -783,6 +801,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int metadata_profile_opt = 0;
 	int discard = 1;
 	int ssd = 0;
+	int hmzoned = 0;
 	int force_overwrite = 0;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
@@ -796,6 +815,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
+	u64 system_group_size;
 
 	crc32c_optimization_init();
 
@@ -920,6 +940,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
+	hmzoned = features & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
 		goto error;
@@ -929,6 +951,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (source_dir_set && hmzoned) {
+		error("The -r and hmzoned feature are incompatible");
+		exit(1);
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -960,6 +987,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
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
@@ -1111,7 +1148,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
 			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(verbose ? PREP_DEVICE_VERBOSE : 0));
+			(verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
@@ -1122,9 +1160,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
 
@@ -1140,6 +1180,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.zone_size = zone_size(file);
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1150,6 +1191,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	fs_info = open_ctree_fs_info(file, 0, 0, 0,
 			OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
+
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
@@ -1223,7 +1265,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				block_count,
 				(verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		if (ret) {
 			goto error;
 		}
@@ -1246,7 +1289,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 raid_groups:
 	ret = create_raid_groups(trans, root, data_profile,
-			 metadata_profile, mixed, &allocation);
+			 metadata_profile, mixed, hmzoned, &allocation);
 	if (ret) {
 		error("unable to create raid groups: %d", ret);
 		goto out;
@@ -1269,7 +1312,7 @@ raid_groups:
 		goto out;
 	}
 
-	ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
+	ret = cleanup_temp_chunks(fs_info, &allocation, hmzoned, data_profile,
 				  metadata_profile, metadata_profile);
 	if (ret < 0) {
 		error("failed to cleanup temporary chunks: %d", ret);
@@ -1320,6 +1363,10 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
+		printf("Zoned device:       %s\n", hmzoned ? "yes" : "no");
+		if (hmzoned)
+			printf("Zone size:          %s\n",
+			       pretty_size(fs_info->fs_devices->zone_size));
 		btrfs_parse_features_to_string(features_buf, features);
 		printf("Incompat features:  %s", features_buf);
 		printf("\n");
-- 
2.23.0

