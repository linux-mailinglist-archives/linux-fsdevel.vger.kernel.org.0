Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34969563D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfHTExG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTExF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276786; x=1597812786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCG/mFoW80K9QLMTeER2ZZ4y5gugUj9OImIyGYzEti4=;
  b=RErLMkGc1sxdiN3RMIKoowbA9gcaMh4/bQObaqXVh2hkpRRMeOLFoujI
   Yy3Uc9neZrES0WZHZZv1UszI04zvYI4SPr278SwyPcDLXv7qvphFA3dqa
   Zu6TKMDrCEfSobdWWd34qfABWhFcKygX9dF6PI+DKlXpT8Jd/HxR5X4W/
   5ZwAGDjMbxGBCC/2DpDJ1TxIDo+PcD5FpZi+E34MvWMwbmKMEOfaSn8u2
   TftuHzXWG6ZGXbJw2fsVBeS3NA494MaAfiVIJDq0fjm3KuLN+6t74C5M5
   UbhvEI745h5N8HHf09EgAIycXXHRhRPQeK8RzTuvSRQzjvNiwRRREOecp
   A==;
IronPort-SDR: 6rS9c7OxbQE/b/O7LK55mdlqoDkLfXokRcNFG6swCM1yJtH9YHGs3J74rgjPoSoKTc1GN6EWZe
 d+bbXW1vn18I72NR+GXP+HXtKa5NcEskrtRaq4mDpUmjozJ1MV6+DQIUYM/aePQV+SOMLlNmIS
 uDnnzMHJC8ids9eV6ZZHBHV6se1dhj5JTGlANYPe7GRFidliMA+yHctq3fkGiQyH+CuLyTAPn6
 uqcoTtNzTmEk3VFfQThh7Bm8v/zVnqjhFp+QAugK4pZ4BBzGVgqDgvs3wB9PCQRmb6mPo5nIrd
 zBc=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:05 +0800
IronPort-SDR: qowQe72KJULUleqBNANvk0UU2CiZeC02kmycOwhWkF7xxDoUhKGVS5KI7KL2QJE4xyIUVIXKQ7
 xOfr4aAyJTKUQgHREaL9DQUJ4nd8Y3626JrHyZxbNsSMJaU5H10XDN8laDnuU3UjR6db+jMYeg
 GYV+UqUCHO/2EpAm3LgHeYc+IxahytchA/T1bnPELK6KWrDo1r1LFDPL6ENuJFLODzaWS+5kwt
 bGlwpKdatj33XiCczFiYFw+KeRPNAgjFpOqqO9MFApVbHE7PtsdBw2G3WrrfrZ69RfuoTHukA7
 Jj8JyQOiHY8WrVSDhpjePoQR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:29 -0700
IronPort-SDR: YxAS8DCbO82RXa5UE3nd3/S00Ap2m4r3aqVq69IS6RV1QrGRo8oesyz+QaCZsAkAamNHL8y5w5
 AN+2YWHOnYxnY6NXzXYGPwmndJ37Gu3MdIQ1IRqsyJWPkdKSnqoAEJIlsDgdogDRfS2hg5Fo7G
 0HBVNXnN34fFpobcLfRJysb08pPp1gnVoBBZi5+0yOHBtJZ0fzruuLIOzbrOKEwsE8c9wk0//C
 5UZlZUUCImTTiPzS90l2kZvj5by66c0l/HeCJWFUFpl41/LoPmw1/pKKwjmxmOumSVqUkAFJ0O
 drQ=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 01/15] btrfs-progs: utils: Introduce queue_param helper function
Date:   Tue, 20 Aug 2019 13:52:44 +0900
Message-Id: <20190820045258.1571640-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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
index 971cb39534fd..948c84be5f39 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -426,49 +426,13 @@ static int zero_output_file(int out_fd, u64 size)
 
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
2.23.0

