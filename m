Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE09564D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfHTExX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfHTExV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276801; x=1597812801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7TVvSLmTvJ7ZjC/YqB2D4J4WF4j++F7FE/ZWWk3V+Mk=;
  b=SVQ3/aTZhcrOnPMF5qWnUKeYBY3ol/NoSqzliZIxQuECtzEuJR8ub3B7
   tjGEWUm+VrGjRtZe4J3IJ9p7GYs+fdlCxYpRTxJ4F6NcGb6XOYnlCPKm3
   cChkY2WMVQK44J6wznW/tdZ6EejlGqXQgTtAVeSN3Ggp/B1zhU2muw7TB
   HwjX5z6JNmeuN/RwExRYEpSnqJ6XNGNzimkA9ef4yoCg5I+vt9nefofwF
   iZ+T40nDqxqoqG43Smhv9C0FhJiRFCdh5BwoGXR2CgsK0RGDB9eak8HBp
   FLgZbyzIgQtBykPlmmKdRQHchdhqeAKu0bCYAEftjk+giTukevgeMteEz
   A==;
IronPort-SDR: KmoEXUt99knkJsZaaklAse2zZ6rtDGvM7UmbhwcnQxNh2sjVI6s13z7VLfESO8KSwfkV3EuaJT
 7477MAo5XHDcZCYaI33XP2ANiv8uw45gCMjGoYOw9C/LL+EknQp1n3tyF1Ii509JJdnhTH3p+r
 npUfxFqcreiEvWRRo/e/11wsypAoi3blRscyNbj/zP4Aa+yv9rWag6V/tb4bL+2Yk4N6Yabooe
 2+RRNedKHxAbNjMQEvgMFWHPyF6TEjygOXtQbDjlmF76aNs0bTYWgGWaJUsD1bvNB0fWPwDXjy
 Jv4=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136306"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:20 +0800
IronPort-SDR: hiCcHc6Xiwt3zzOV3oy0RWj5eQT29hzYgLkuTkjlIkerhFOwu4TSSxreUI4HJUJ0lOQFRtcDr6
 1GDWGIgDU8bqhSSoUxdI9r4xQ31aCqB+RvIroijTm5RENCJwGbwISyHiyhAbxmWIuFHIcd+NwZ
 a8pb0W5+TPsG+ytCIZlRE8XHCV/vaMbLQAtb7kQS2KDlY/eiLFpj/iHOF82DG9pIbCqp2GT4rB
 DEyvnBNzBm5cj4tu84roOpiXuy87s61E8qEmioZn6GLXb2FyASbL2LvJH+3w3wqHClDfBcVFIc
 1o0m2RWija9NWwzpZTwotIdM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:45 -0700
IronPort-SDR: gL0md5HAY+HJKOKP+IyQgyxGOsU/DcBat+CNuHMWGG9UuJOMsLOcBJBwxrbVfWnLyPsKWplJTe
 g0KJQAVhuZSSfYnbjMPdkwXtn6cxvirr121QfT5XaUnxZ9/f7xqD3J4XSQdndqm3qLlcY6GeMF
 qOQM6Wp3gvntkrzOHxAgxLgHrvfmPbGJycMzzeTKBJan0ESHucI5w68BB1nJydwUwmdTJsHxaY
 bH0Jn4S0tnvJDcR4Sw0p8O3tO2Bdr8BonOzD1lETw8lMOG24fF03LvY/TMz/lnnVLu8fUnByAr
 iGk=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 09/15] btrfs-progs: support zero out on zoned block device
Date:   Tue, 20 Aug 2019 13:52:52 +0900
Message-Id: <20190820045258.1571640-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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
 common/hmzoned.c      | 29 +++++++++++++++++++++++++++++
 common/hmzoned.h      |  7 +++++++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index c7046c22a9fb..840399c860c3 100644
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
+static int zero_dev_clamped(int fd, struct btrfs_zone_info *zinfo, off_t start,
+			    ssize_t len, u64 dev_size)
 {
 	off_t end = max(start, start + len);
 
@@ -99,6 +100,9 @@ static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
 	start = min_t(u64, start, dev_size);
 	end = min_t(u64, end, dev_size);
 
+	if (zinfo->model == ZONED_HOST_MANAGED)
+		return zero_zone_blocks(fd, zinfo, start, end - start);
+
 	return zero_blocks(fd, start, end - start);
 }
 
@@ -206,12 +210,12 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		}
 	}
 
-	ret = zero_dev_clamped(fd, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, &zinfo, 0, ZERO_DEV_BYTES, block_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
-		ret = zero_dev_clamped(fd, btrfs_sb_offset(i),
+		ret = zero_dev_clamped(fd, &zinfo, btrfs_sb_offset(i),
 				       BTRFS_SUPER_INFO_SIZE, block_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, block_count - ZERO_DEV_BYTES,
+		ret = zero_dev_clamped(fd, &zinfo, block_count - ZERO_DEV_BYTES,
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
index 70de111f22da..12eb8f551853 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -243,3 +243,32 @@ int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo)
 
 	return 0;
 }
+
+int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
+		     size_t len)
+{
+	size_t zone_len = zinfo->zone_size;
+	off_t ofst = start;
+	size_t count;
+	int ret;
+
+	/* Make sure that zero_blocks does not write sequential zones */
+	while (len > 0) {
+
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
diff --git a/common/hmzoned.h b/common/hmzoned.h
index c4e20ae71d21..75812716ffd9 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -57,6 +57,8 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
 int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo);
+int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
+		     size_t len);
 #else
 static inline bool zone_is_sequential(struct btrfs_zone_info *zinfo,
 				      u64 bytenr)
@@ -67,6 +69,11 @@ static inline int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo)
 {
 	return -EOPNOTSUPP;
 }
+static int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
+			    size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
-- 
2.23.0

