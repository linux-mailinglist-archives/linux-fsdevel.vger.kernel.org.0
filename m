Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC41124D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLDI1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448070; x=1606984070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PrMTxB1eV9pdw4y5Wl0F8npnyNNJeHfv+iAfkzKXh0c=;
  b=nNG1ev4TJlfqb9hRq5dkEnNTCsGlxB9ZWGKL21dCoLPFbF1BLYB0WNx5
   xQZzVoOI1UldneVySE9eU0Bm5no146bkEgkmxUA46tWHnzjt1ZyEh7bdv
   6CDNqbSnWX+WP4QWkg5wAQGbK1EojVkpOzVy7dN0dPmmmIW82wsNBMys/
   wGjgUCdQ1GTN6zUAADVfld1N2JT4Xt7eLTVsPBpicGB1ja18FabEeJq5L
   jQVLbxO47+AKKPutyiudCfWkPJwfXbiMKJe4hvpxd8NPKdz94Grj0Logt
   LesE0QfGSjG5DbMCZRDzDyVUD5B5fTXO6s1ClErGTgZw/kkuGy4IlwJmc
   g==;
IronPort-SDR: 9ArD2WTv6JYd1EulDUpwhd2k/+sirV4YDcB6ugQPu4WZb7zU6/SElotc3H+sR5OjwPA9QIaS77
 PS7diEevxPUClvnjzFD1sY/j+ku2VHp2Hpp4c7B2fwjyIVNfduwEuoXEqS+X0R5h+TFxMp+N5K
 T4amhWgw88WbtKchwf8VTbMXUQCFTEC1HUmrcvXTQko4kMeGIt6W78TIBO7aGIQSnedLRxDzZo
 CwdsDNOkxqr0E1H1BWERylD6qx6AyccRIWoIsJmBePVW+fRe5XwtrFH11MOkj0kkDhSfEJHZYE
 PHQ=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031747"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:50 +0800
IronPort-SDR: QtEAp/ITlxMH9S9vrZigk2NEJEUyA3LwSjiRsra5OVZ/b/rZ2vgyNIwfR5OjboS12n4Cz3OblM
 yc/irx6L9XQrOGooegJgjz13afDivzj+QPOJJ59vvvDVJzHCvc+Glhq7Y6QJ+ogykrmB+yR5xu
 Ml27WcBSw6s6gEKV9hPuoEYM7zpm7ucZJWfv4WaThtQ3vJs+aCIADuv4kpwTpWovTigHvrUj9W
 60P0CzXiuEm26UflNpK9KMup68c9oRnduSyJ3CAFXcz9XDH+t6n62r0Fg9Adh0hQXOGkx9V/I0
 sFifoV2IxwWO4JLT1Uu9pxSK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:33 -0800
IronPort-SDR: d6xIB2QI7lWc9LhcSw1XxsRYmcN+2ThfLAIMqpSRsf1kMKEKjEx4J8qBA510XWxwTCdShzZNjR
 T3oSYnfkyO7+F1TbMwr95z+xhFWzb5LJZJRXeVYKcOKCqRCJthHmAbsw7hkCH1h9p1GdOpnVeX
 7jjqHLgcg2lnJ0APeoT2jjqwxvw/31UeoNG2AAnI6T21ZZG6hWS2InGHPjTPSsxFUTteL+lvzm
 O9UmKOl3tgjGtRROLBrBn1xS62f4YRvEPV8Cz58Fh/TfAjCRYPfDuVd7locsdF8vr+wmlNVh1j
 I70=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 08/15] btrfs-progs: support zero out on zoned block device
Date:   Wed,  4 Dec 2019 17:25:06 +0900
Message-Id: <20191204082513.857320-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we zero out a region in a sequential write required zone, we cannot
write to the region until we reset the zone. Thus, we must prohibit zeroing
out to a sequential write required zone.

zero_dev_clamped() is modified to take the zone information and it calls
zero_zone_blocks() if the device is host managed to avoid writing to
sequential write required zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 14 +++++++++-----
 common/device-utils.h |  1 +
 common/hmzoned.c      | 28 ++++++++++++++++++++++++++++
 common/hmzoned.h      |  8 ++++++++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 2689f157aeea..2ac8e7d9802a 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -67,7 +67,7 @@ int discard_blocks(int fd, u64 start, u64 len)
 	return 0;
 }
 
-static int zero_blocks(int fd, off_t start, size_t len)
+int zero_blocks(int fd, off_t start, size_t len)
 {
 	char *buf = malloc(len);
 	int ret = 0;
@@ -86,7 +86,8 @@ static int zero_blocks(int fd, off_t start, size_t len)
 #define ZERO_DEV_BYTES SZ_2M
 
 /* don't write outside the device by clamping the region to the device size */
-static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
+static int zero_dev_clamped(int fd, struct btrfs_zoned_device_info *zinfo,
+			    off_t start, ssize_t len, u64 dev_size)
 {
 	off_t end = max(start, start + len);
 
@@ -99,6 +100,9 @@ static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
 	start = min_t(u64, start, dev_size);
 	end = min_t(u64, end, dev_size);
 
+	if (zinfo && zinfo->model == ZONED_HOST_MANAGED)
+		return zero_zone_blocks(fd, zinfo, start, end - start);
+
 	return zero_blocks(fd, start, end - start);
 }
 
@@ -212,12 +216,12 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		}
 	}
 
-	ret = zero_dev_clamped(fd, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, zinfo, 0, ZERO_DEV_BYTES, block_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
-		ret = zero_dev_clamped(fd, btrfs_sb_offset(i),
+		ret = zero_dev_clamped(fd, zinfo, btrfs_sb_offset(i),
 				       BTRFS_SUPER_INFO_SIZE, block_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, block_count - ZERO_DEV_BYTES,
+		ret = zero_dev_clamped(fd, zinfo, block_count - ZERO_DEV_BYTES,
 				       ZERO_DEV_BYTES, block_count);
 
 	if (ret < 0) {
diff --git a/common/device-utils.h b/common/device-utils.h
index 885a46937e0d..7d5b622b8957 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -26,6 +26,7 @@
 #define	PREP_DEVICE_HMZONED	(1U << 3)
 
 int discard_blocks(int fd, u64 start, u64 len);
+int zero_blocks(int fd, off_t start, size_t len);
 u64 get_partition_size(const char *dev);
 u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
diff --git a/common/hmzoned.c b/common/hmzoned.c
index 5803b2c17a2b..484877743948 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -180,6 +180,34 @@ int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
 	return fsync(fd);
 }
 
+int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
+		     size_t len)
+{
+	size_t zone_len = zinfo->zone_size;
+	off_t ofst = start;
+	size_t count;
+	int ret;
+
+	/* Make sure that zero_blocks does not write sequential zones */
+	while (len > 0) {
+		/* Limit zero_blocks to a single zone */
+		count = min_t(size_t, len, zone_len);
+		if (count > zone_len - (ofst & (zone_len - 1)))
+			count = zone_len - (ofst & (zone_len - 1));
+
+		if (!zone_is_sequential(zinfo, ofst)) {
+			ret = zero_blocks(fd, ofst, count);
+			if (ret != 0)
+				return ret;
+		}
+
+		len -= count;
+		ofst += count;
+	}
+
+	return 0;
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 631780537a77..a902717335b0 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -55,6 +55,8 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr);
 int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
+int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
+		     size_t len);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
@@ -66,6 +68,12 @@ static inline int btrfs_discard_all_zones(int fd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int zero_zone_blocks(int fd,
+				   struct btrfs_zoned_device_info *zinfo,
+				   off_t start, size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
-- 
2.24.0

