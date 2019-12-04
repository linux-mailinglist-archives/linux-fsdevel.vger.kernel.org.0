Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06ED1124CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLDI1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDI1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448079; x=1606984079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mi5seVmN9UgYq/zTrB6RBvi6dWquGtoqLIXs6ZRq31A=;
  b=ciw+LlMprZVJCnRMlxVFjzTQ5GPSNrKoN0H36nz77KTkYAUvSRLS/VeN
   NAKBU/jQrR6Mntg71mLc185kkNeyOdgV37py7rkixLMOs8iWdtGCvg+Qa
   JTWNFp5547YYctR/yz8L75rqZ/yhILXg0wQNqhsnrWW+a4E3KmOM6UZxj
   JpaPsu0wMIvKQzi4elmW9l5rJ7njSXSSe2KG0ZADQJW+aRLB76oloqwg+
   ZqKHFhjVpL5BAn5kSDuHG7MDPFWTGRhhAPYj6gEHYBaYyBECEt1S8KYuN
   s2If/yQ0b4IsPce2XTKIF6gjUXEnlbZGA01HmcWLFhM4WTK+4DDBSVzpU
   A==;
IronPort-SDR: oDBbwZ3YHvhpJxCjKpm4n57vKMpkvDyJhq/AvV1TtbN2NmmcjS85lhRDAzfEPOPYIojhTdgPL3
 LQzPBNQqny1g8D8VHFpdoBPi0zFgju7v1p2anNrUkFCPNz8PY4xRo6mTJB6PMbVfMEYiyG+zGh
 fvYNq1jo/4lT/mMJIPyTPsi5B0J0bk7YLYC0vcYxkx49cn8JZowUNZPo+SvGUldT74Fz7d1cS6
 rRmnYw+GTpyo6Yr5AdStWChuima5PVXw9ahi+mXEWohoUtJ5J7CNmdKLCx0723O3XcHIgybaz7
 4BE=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031734"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:58 +0800
IronPort-SDR: xdKO1Qi3uiLi5aZqzItsXl4S6IDATrkgLD4nQ+ZV5MDj/U1c8Bn+Ug68zdiKhWo2UkKYFjSeFl
 3azWwE1wcm/3+yYF084yb4TDnorOjl5QD0q1uv33CiACVjOtPv0Q/YAw75AWTNN686P5gVCq2w
 2pswaJhnfoIxACTAiFuJa3SnwnyFzmgP0TcEQRgw7PCTur2ut1nSYQDKCpe6lNlx5cVEXybF3G
 46oAPSv+5hsLx0Heg1zfY+F3Qqjo/JbBYStAorTR10mo9/k4NhuRn8tpsebT7BNSz8WzMdw5ua
 wgK5ydh+7ZU8SNtHr+Ow6zV2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:24 -0800
IronPort-SDR: W3P0/abQ0iCgi/o0Dzi5JsIqziUxJEWknm7y9qKygqXpJdQBdVKwYIRQt2HQL6GD0Em5SlNu4U
 3ienbmGeHKNeBCCbeq1yE8aS5fUTFEwqJNmDWcHjc2Nw6DfICBZPUF1COip5zu3WrhQ6uQcWMZ
 hvyLMbhVzr6LqpODvUQ0pn6rJqwX4SEPzjE6wy+2H5XXDQb+ce8UVoiiJicQK+nZYLh+7SdISU
 DV/XDxh+fBakZIjOZW7k+JaI96InJlkHocqT1SkAODiktMSCiNCpb5mGoCs8WSLRdxFF4LbbHs
 wo8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 04/15] btrfs-progs: add new HMZONED feature flag
Date:   Wed,  4 Dec 2019 17:25:02 +0900
Message-Id: <20191204082513.857320-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this feature enabled, a zoned block device aware btrfs allocates block
groups aligned to the device zones and always write in sequential zones at
the zone write pointer position.

Enabling this feature also disable conversion from ext4 volumes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/inspect-dump-super.c | 1 +
 common/fsfeatures.c       | 8 ++++++++
 common/fsfeatures.h       | 2 +-
 ctree.h                   | 4 +++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f22633b99390..ddb2120fb397 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -229,6 +229,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
 	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
+	DEF_INCOMPAT_FLAG_ENTRY(HMZONED)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index ac12d57b25a3..929a076e7b69 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -92,6 +92,14 @@ static const struct btrfs_fs_feature {
 		NULL, 0,
 		NULL, 0,
 		"RAID1 with 3 or 4 copies" },
+#ifdef BTRFS_ZONED
+	{ "hmzoned", BTRFS_FEATURE_INCOMPAT_HMZONED,
+		"hmzoned",
+		NULL, 0,
+		NULL, 0,
+		NULL, 0,
+		"support Host-Managed Zoned devices" },
+#endif
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 3cc9452a3327..0918ee1aa113 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -25,7 +25,7 @@
 		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 
 /*
- * Avoid multi-device features (RAID56) and mixed block groups
+ * Avoid multi-device features (RAID56), mixed block groups, and hmzoned device
  */
 #define BTRFS_CONVERT_ALLOWED_FEATURES				\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
diff --git a/ctree.h b/ctree.h
index 3e50d0863bde..34fd7d00cabf 100644
--- a/ctree.h
+++ b/ctree.h
@@ -493,6 +493,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 12)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -517,7 +518,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
-- 
2.24.0

