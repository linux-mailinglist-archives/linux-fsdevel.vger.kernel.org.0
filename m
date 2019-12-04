Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A901B1124E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLDI2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:28:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLDI2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448095; x=1606984095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dPCgUh84ddPIdXNQGUf0B99pZTrM0cDCTQ2s5y40qKs=;
  b=pbutSrS1hzPeBb7dTnngWxl1lFUSK5kb2FvRvJNq5a3hqCcBBJXiK5GO
   Ze5SW+9u1lDi+PVGeZu5PJwEB+LO4xq6gP2gTc24GJ+/Hd0WZSIK9Qilb
   AL+/d9qM9Ih9+bWTwCqezh/MXlcG+xAi/c41G0N9rr9Es3vl0zJ1rpOWg
   K8h9pxOlKHbbZdzpOWMrVnm7TvSYKI1hlRrpq9vvQ4edvlZXvfmiIkboT
   rJWo1MrgAb/OE71HwoESzimcY+1L1ACaGiJ1pnPk7oHkv/VZ75f06zPZy
   pvX2i6uWLltoz2jf+Q/PQ2my95G3Sxfxfch3HjVVpBj8RMq3Ivoh3mcld
   Q==;
IronPort-SDR: EPu0EHhVdPQdM2umkbhQ8QgUIc/k6hUnBuXW14tS1HLgxSlbsMvPJN8aV7I30ck87vq47yWWtn
 nXgFxM1J1XEICVsfzgfk/PzJMC147VkLJ3h6tovEsr7LEY+njPyrvU9N7PHhS1iY80vyqzNtYY
 pNA+OO1PpjmUOGC8sB3tiX9GbCvOO6O0WlgcFP01zTENPjqIYrj+73GeBw//WObpuY2ufN0qro
 4mOdLM7cnQtXsl7iJRTWC9B6gpeAvDhM3g4gjb9fs4d5dNoFe64UdHB1h+qA6VWNvQJAGF/xNb
 dRw=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031776"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:14 +0800
IronPort-SDR: Axtp4PKWPpdf1QCL4YcCWTbOkUrpFjAlW60XU/xXmgvGHJpPMfUgiH+XYJB079ua4n6o3zjXjn
 kWttx3UCek22KQStcW3RkT7oEhj9MmFHALg5syAbCVuDvm+xjVKuDBF6Kh6N+nki1ChUG8sJ2d
 n2EhIkrQnv2z+4NuMitHtC/+BwsYTGHFmYlRnBrdU6+FioTTHAqvpVkl/HxE3GkgsZGWYl7PHZ
 +UusFuykHQIt9xYXl7EA/jOzej9Vyb63v7XUdZG3t4oTSB1tIjZ0jQF2gfonV9r9K/pUZz9+uD
 De+NY+3EFnfAsDllUs45Z4+3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:50 -0800
IronPort-SDR: i0W0oAz1kA7oShAQyeGnOkj1W13v4Nde6kTeyooGzaf5UtaKap6tfq1a2vXk13v9XteZ3JqmKu
 RCgOVxnXiNA/TokgY7mWOq4ZiKtBhWWlNIwBohLXNd2ZX9avsoD2jVwgL6quagQ0x5p0+8suKm
 TJo31WWQjWZcDZbSfzNKQjmbzRx4yKdjzPrJ6N0JnN8rWQGL0XKxUHTFW3BCo88EUBOiOPWqE3
 IidL1FN9hcuknzg3hOmiEEFIAtYdIMKwjCIDVo4ZOpbLBrkAclNINzA4HjqnLhplFoS5CrXoMa
 agU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:28:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 15/15] btrfs-progs: introduce support for device replace HMZONED device
Date:   Wed,  4 Dec 2019 17:25:13 +0900
Message-Id: <20191204082513.857320-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch check if the target file system is flagged as HMZONED. If it is,
the device to be added is flagged PREP_DEVICE_HMZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/replace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 2321aa156fe2..670df68a93f7 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -119,6 +119,7 @@ static const char *const cmd_replace_start_usage[] = {
 static int cmd_replace_start(const struct cmd_struct *cmd,
 			     int argc, char **argv)
 {
+	struct btrfs_ioctl_feature_flags feature_flags;
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
 	int ret;
@@ -126,6 +127,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	int c;
 	int fdmnt = -1;
 	int fddstdev = -1;
+	int hmzoned;
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
@@ -166,6 +168,13 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		goto leave_with_error;
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("ioctl(GET_FEATURES) on '%s' returns error: %m", path);
+		goto leave_with_error;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	/* check for possible errors before backgrounding */
 	status_args.cmd = BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS;
 	status_args.result = BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT;
@@ -260,7 +269,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	strncpy((char *)start_args.start.tgtdev_name, dstdev,
 		BTRFS_DEVICE_PATH_NAME_MAX);
 	ret = btrfs_prepare_device(fddstdev, dstdev, &dstdev_block_count, 0,
-			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE);
+			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto leave_with_error;
 
-- 
2.24.0

