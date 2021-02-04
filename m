Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52B30F09B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhBDKZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:25:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhBDKZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434329; x=1643970329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2MTSnZ4cDqTo+Aig7VYuEA+zyZqGpjVEWEtDj3dIdQ=;
  b=Qve978VDbCf1/BsUqqRdDwQkeGfUmzmKIxMggYEbSaJ1RqnFlYV6zV03
   f8g1T+0H4FYHkFOUzZtB1vrFUYG6ZoXRn8Slb9CN+KJH0/XPqYtujbDei
   S25Hy63YuqQ+ZIyDLJZvxuMxLacAVHRyYSkgrAGrWhdyP0S6+Ns8Yzub6
   dBYib15PpCOEQijpVauuB7vQm/KTGrc1Wk6t3h8CIFa5QHqbo5j764XWe
   scGU4DKUnghh/O/azFThksbNcut8kYhzgksteUrVvRQLhrde8FJS+Sfh9
   isPd8y8WY2fNyNj/ziDwSVa55KHFfwzFEBb+sXxA21lmYY46O8INbE6DS
   g==;
IronPort-SDR: s6Keji1o/bDymm6tUmdQWYpu5wqw/cW3xTVxIUqWhAQ7VPTAe+dQ2Vj16NYAVceLhXu/0rAVSl
 CLSE6K0AkqiXOeMjiEQ4jjUeyKo0PWSpRTmlC05GasPKa8TW+z+jbO+E7t79nh0LWencj4Lg3r
 /3+t8mr8sh1WWlANk/7ZyqHmLeyLZpa9zAYahoNvOOR5XHel2s1MM2lF1f6bArM2z4By7stxac
 8lrvj+xJdR3mjMTtKDs1f/yaflm8R65Tp8e02RZ7cjYZdlVnHqTAgFFVE/JgUyTWcqToxjnjXg
 DVY=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107981"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:09 +0800
IronPort-SDR: JUTH/mKsPqIk9RKSAjOTjhH17syHrzClvYXDUQl7hIdSM0bQwEe9M9jRHWezgoOQAhQq9sYaGg
 ycBQGwGq0LhcrKXecgCVL4LDIMHQtSzFWG5Gj7/+TFo2/w/tP3QGzg1OPSumiBmqj4QtuyZ1Lw
 LaUc62fhJnxDcZcpX+MAfm3B26dPHpDwu3mkEAQxYSGJcFTSTF9oDcVFqbHZYkOBO3+vVb4XNl
 p6KjO4HQlS6rGtICPz7Ac+hvRoH/g3V4+wzEWIpPXxSZfGGSnmSVi8eKtNzRvul15d+MgNI0HX
 BpJ+vnGuqbTHmmOthKywTU2m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:12 -0800
IronPort-SDR: 4iQ2RSgTu720Bly2Cw4Qa557lZER+oqpRuZEvsMs3Du3Zc5Ry+MKiXHb+si+5NwGI3uZecIZUO
 D1osJSCd2jEukbPY6zq7pqZ1oonVfJRcOp+hnz0MjLMJa5FPxWxLYNYglgoZrQOe7/ExmLr66U
 +cClry/GMu+xHF6DSLHuLMeAshtjOuCfkqfgJ5bEECyVPkuQGwWwFo/Lu1qjk7eSNNkvOSysaI
 oezeRJGBFbck6sIJKOLr1CuAmKCKjflI+qq5/qKKnAcl5VdE3w/4rqd4P9aXCxvldMwn1yjloE
 KOI=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 10/42] btrfs: zoned: verify device extent is aligned to zone
Date:   Thu,  4 Feb 2021 19:21:49 +0900
Message-Id: <09a33e303c77de18547ebc2319cfc1a070da49c8.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check in verify_one_dev_extent() to ensure that a device extent on a
zoned block device is aligned to the respective zone boundary.

If it isn't mark the filesystem as unclean.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae2aeadad5a0..10401def16ef 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7769,6 +7769,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.30.0

