Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9441124C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLDI1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDI1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448072; x=1606984072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bhNyzLhl9owrliJRAQ0iti/RcuoOYOekzekOMWKVqU=;
  b=FdQukjnQQYIvMsGTIXLkwoOPNj9z4edHXDX7aJNq2cqll7VHGBmp4JDq
   iwsoiv/BhTRkvJzRxIiB8U2BrB5Ta36inquYpveojbO1qydAucLQAfsQa
   HeF619rSToEbeB7TtJKh0XrvOX8wGsb70HJDRo8VGh6Hgddlvru3GO1/p
   8zCOb8ekpEJbPvbN3LRSqXBg1FRNWVUngPvZF6IfB2SopBnHzkXQdR5ng
   Sfo31n9SYiOhIBtQyODReo7irbO8+Wu4e10jt/EUaYpmwpMy9QSk2Z7F+
   L4iGvLqktjdq/IXf0EzpVrNGmNMamP2gTWJG+EJISbVqPnx2UJ09XTW/0
   A==;
IronPort-SDR: plkWdUdQD9KBmAkq02Xy/iNayLiXe3prJBXOmqR5soS64PdoqLm/X+G8fQnqjiIL96lFClzO0w
 q6sNsuED7wBrYP945OoVnbYcFxx6mMZQEi7oC6LM8ISnopQIv0v0zr4VpUVhtyrxXAkw7NK4cZ
 ZxAkzKA6HC58DoU3yekdr6jowdpoTtCPhgGPtDFJ11W6EJ1sxYg84/7r9rNA8JLYWtcMI4Wei+
 oJZIpH4vm3zOB9sfgvVpGTnzAvDhwtZ7K71vSdKhs/iCSv90QbcXNantZx5AjwxKQmBWIqemFD
 +Mg=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031728"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:49 +0800
IronPort-SDR: 072lL82USHHv6OHdRszRrL7dsL14AZPxAM29ML+rOnR9TtCCTI4CfL5KYWtRY2woWdQ3eAZvJh
 RSwKEcqf1JjiXLhm2iFrThDf46O6M43G4TZF9RhbcCr+6UaP7UbXqeoVODbNYJFpnhUOKENZr+
 A5LfetHka2NzQsykhd//61HXg1UBaqHiejuMAvJIgAOH9frzzZanx1SFtSBU1VQtvedZhAzFG7
 BgvSa7Wl5krOac/h23wBfsseBNpPTecNiqq6PqaL4Oq8mPq/u1RfHmHLIV7jiHoO4W3oIzIxGg
 LU+bAMB642uGdIH+PijaqCn3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:17 -0800
IronPort-SDR: 5Lf6IOEvuYl/lFv69OoGTdiyE87BhROKR2nCSnOgaqG3FlvsjvoQlPAp79lYEp/9jY2eapCuzE
 H8LAkUaWRvHgmI50HTHZ392nWN6Z5dY0InixtB/N0gVqhaZsOGRHf1UhhmmakpSThjEjCVf1d4
 x5Q54PyMdtkKy7dTukjq9i6kWdGh/8x4hfVXxTaA+L8GSzkz72mt3igkHD4YcLDaPWPfUW7AA8
 mB73TirFE/RsPVWi5Hh5G5mby+vBtfQI+cCeu9x2CZRNzzwcySiS/pS+7QaAE+VQYrEx0WFzJS
 7zs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 01/15] btrfs-progs: utils: Introduce queue_param helper function
Date:   Wed,  4 Dec 2019 17:24:59 +0900
Message-Id: <20191204082513.857320-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the queue_param helper function to get a device request queue
parameter.  This helper will be used later to query information of a zoned
device.

Furthermore, rewrite is_ssd() using the helper function.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
[Naohiro] fixed error return value
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 common/device-utils.h |  1 +
 mkfs/main.c           | 40 ++-----------------------------------
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index b03d62faaf21..7fa9386f4677 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -252,3 +252,49 @@ u64 get_partition_size(const char *dev)
 	return result;
 }
 
+/*
+ * Get a device request queue parameter.
+ */
+int queue_param(const char *file, const char *param, char *buf, size_t len)
+{
+	blkid_probe probe;
+	char wholedisk[PATH_MAX];
+	char sysfs_path[PATH_MAX];
+	dev_t devno;
+	int fd;
+	int ret;
+
+	probe = blkid_new_probe_from_filename(file);
+	if (!probe)
+		return 0;
+
+	/* Device number of this disk (possibly a partition) */
+	devno = blkid_probe_get_devno(probe);
+	if (!devno) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	/* Get whole disk name (not full path) for this devno */
+	ret = blkid_devno_to_wholedisk(devno,
+			wholedisk, sizeof(wholedisk), NULL);
+	if (ret) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/%s",
+		 wholedisk, param);
+
+	blkid_free_probe(probe);
+
+	fd = open(sysfs_path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, buf, len);
+	close(fd);
+
+	return len;
+}
+
diff --git a/common/device-utils.h b/common/device-utils.h
index 70d19cae3e50..d1799323d002 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -29,5 +29,6 @@ u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
+int queue_param(const char *file, const char *param, char *buf, size_t len);
 
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 316ea82e45c6..14e9ae7aeb6d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -432,49 +432,13 @@ static int zero_output_file(int out_fd, u64 size)
 
 static int is_ssd(const char *file)
 {
-	blkid_probe probe;
-	char wholedisk[PATH_MAX];
-	char sysfs_path[PATH_MAX];
-	dev_t devno;
-	int fd;
 	char rotational;
 	int ret;
 
-	probe = blkid_new_probe_from_filename(file);
-	if (!probe)
+	ret = queue_param(file, "rotational", &rotational, 1);
+	if (ret < 1)
 		return 0;
 
-	/* Device number of this disk (possibly a partition) */
-	devno = blkid_probe_get_devno(probe);
-	if (!devno) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	/* Get whole disk name (not full path) for this devno */
-	ret = blkid_devno_to_wholedisk(devno,
-			wholedisk, sizeof(wholedisk), NULL);
-	if (ret) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/rotational",
-		 wholedisk);
-
-	blkid_free_probe(probe);
-
-	fd = open(sysfs_path, O_RDONLY);
-	if (fd < 0) {
-		return 0;
-	}
-
-	if (read(fd, &rotational, 1) < 1) {
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
 	return rotational == '0';
 }
 
-- 
2.24.0

