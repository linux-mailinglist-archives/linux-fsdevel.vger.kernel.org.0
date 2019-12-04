Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45E1124E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLDI2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:28:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLDI2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448091; x=1606984091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FW1ER6aGFXHA3B7ZDtB14wqSkBNa+wEWDdGk78w4Rt4=;
  b=aQfsB0nWbKILz8OpilOo6tbE9ZWnwREr/smA6nhv3oDvcPxXdvBOyf0t
   Y1iC8Dl7qGDeEz0tnFYdy3QvxIkJ4GOzR2qjz0pDrGk8NWI5j6yCPmG6l
   9iKq5dazHBi8cju5iuqJECcYlkYJbpECFfSDB9Cx4MCBxyGSFVJf/cXTH
   5FswHt6AmwqTgqjZHIGd/aIq6aZ5weh46DwlrszJcAzWwr/nZnKrdiHfI
   vWP56q9TOwEKOmv7NFzni+/kZ2Ao99v7fWt8u+8OgfU2LvQKagLyvlluk
   yT1Md5YSuVbFo0xL+oWvZd1ZL870wb+qYB0pQuFpL+BZE5yG4lURt1WuF
   w==;
IronPort-SDR: 5fGnf4XZ+GUwVaGItfgngD+uQkagfD85rCqYvaFN6sTtFVXNnYZuqcE/rHs0ufXPIefW85uLoh
 qSBdN4nSJctNoH4rn90/gLC/DxoJmVbzmBLxqRD9sogyZkM/adapqYX0r4Impxq0XKDD9RLQ9/
 4LSNtQN05vdKAcFqwxIq1ZM8WDBx1waB5LZYYK2mKlu+qzIPr9e6DXTH5J7q4y2d+gIV2wO5KS
 dO8ycugjLC0tOJ6DkafK7l6Gx0/3vYFYgeEHA72ZF6MD9HO0gRpFUibeOQDwC/T8+bxAh0pc4O
 mCM=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031769"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:11 +0800
IronPort-SDR: YlzzFFCQ63+DoMKDPH6tBPRj+lDuL4ms3Gjx217jka5nMARSGRJdXJeKZ3ysRtW56ddlMv0N8O
 FfCuJtnr64MVcYeVNxT9BHbgy43CaNi9r2r+gLyiSRpJGQC2Bim7YEHKPTKK2qky/LOEIsV+Fe
 oJw/oqw34s2pjrn+rzs/mlc+zCNvDdST3xFZGS90Opg+WvUY7QH6cg5ZVYhQqkmtoLYxQ4Snh+
 yQabOiqZYMwIaez5M+v47MkozDsCOu1Nrxy+m82mrAZ+lbtgmGRBndjg7TTsb2KiCaTn+3hpJ3
 QCC2ijqyv5o1SWov1iDn6JVV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:47 -0800
IronPort-SDR: ya80aueA3aW5HpvrFt4TiKmJzT7+bfimu4V6Gd6LQbVGzTTke1vcNaUJaJ6KBs9lZ21kVRAFTF
 6HAk1D6dk36jptcu6f+aryctybTmRwJhyTesMfKZjXR7N859WdP3Q+w6xfiQCN/ETA/2v5AWa4
 rjniW+oEgsSSteoMKekR3xhcOp3Wn5/CH4z7S37SyoMIl6DbXj8VZp7Vbay6nyg7KAz1Z6aH8D
 Qe8lqk/W9rFF0jtCEspJfe15xTi425tgsIHfcEqME3tl5UDIedSVKopfYE8F1TTln4rwpTkwsD
 ZI8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 14/15] btrfs-progs: device-add: support HMZONED device
Date:   Wed,  4 Dec 2019 17:25:12 +0900
Message-Id: <20191204082513.857320-15-naohiro.aota@wdc.com>
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
 cmds/device.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..f85820cb1cc0 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -36,6 +36,7 @@
 #include "common/path-utils.h"
 #include "common/device-utils.h"
 #include "common/device-scan.h"
+#include "common/hmzoned.h"
 #include "mkfs/common.h"
 
 static const char * const device_cmd_group_usage[] = {
@@ -61,6 +62,9 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	int discard = 1;
 	int force = 0;
 	int last_dev;
+	int res;
+	int hmzoned;
+	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
@@ -96,12 +100,35 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		return 1;
 
+	res = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (res) {
+		error("error getting feature flags '%s': %m", mntpnt);
+		return 1;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
-		int	devfd, res;
+		int	devfd;
 		u64 dev_block_count = 0;
 		char *path;
 
+		if (hmzoned && zoned_model(argv[i]) == ZONED_NONE) {
+			error(
+		"cannot add non-zoned device to HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
+		if (!hmzoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+			error(
+	"cannot add host managed zoned device to non-HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
 		res = test_dev_for_mkfs(argv[i], force);
 		if (res) {
 			ret++;
@@ -117,7 +144,8 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 
 		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		close(devfd);
 		if (res) {
 			ret++;
-- 
2.24.0

