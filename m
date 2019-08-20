Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8848295644
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfHTExO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHTExL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276791; x=1597812791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hPZsva0Rs7IA/IUggNKiwBxmrFQNJUWM1nqdShu19v8=;
  b=DIuMUSZxqsD6x6FGa4d6qx9RycZbVAe9BKc1RsM9v5FX21E/8QBbBEqv
   aVzivQe9Dg+hXkheWcEzA+BI1ZE3xNCVIpnAZxsf3+Gi+s4KIZA21Fli+
   ablppSHMu4H8L4Hjd7+gi4gCfTeFgu3njqWPa3VIPBFrVhhNjHzulPK20
   XhLKsUuPS76lt/Knry+Rwtudx+os0j7mBHENvSWoVzEGNi/foePw5WURK
   p80rWpY/BXtTr8FOroawr1BOMOXJUtUcMd3OCXP1Ll0ScjK5N/GzqUkMM
   J6cAF5WkTRHgyn2YjTN/tlbrejg7LWM000IAHst3RTkUsuTgeswOHhGnh
   g==;
IronPort-SDR: 7xoLp7TsIS9mAtWewz4ts7oZ+zjgtCiibg4ny44J/vs+QY1LGC3zxeXnQa3p+kUcmPsdrt8paq
 1TtmoEtzgxZ/9azMlhyalUf3SE+/gh26/rYcEdfGNfjXtm7XszRjn3dTuSr53bGORQOkJAfjoT
 V9PiuqdLP5Fs1YDlHNjU5l4DDtGLNJAzGFewUmFxcaK5ZJ6WGJiYC16tucNTNHDvIZS4vNDs0g
 nCq99hzngyhxSF3bpO4KQIMcuvAJoRuEpjZAiBIqyUQ8DmyX61tdVmoEgD3mp8yU25q96XcGGT
 B8s=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136290"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:11 +0800
IronPort-SDR: dIAFyaThvY2RcpbJN3FLyWAGLlE0NhI1mnryZuc2hYvE0QMCsR8BVCbLK4CwTOGLWtC05ks0BN
 LK3glZxaJo1lgGb5Emq6Oj6uOqspveVBEe25aObiDeepNb8PQNfA3SacrEY3O8GvWincrl3tTW
 qaBCCSzKqBT2jyv53tHrmsRhtNIoKOrA8CatqShI/nAZ0VEpfavHAL6xtHwSTmSeB91sPNM8jh
 htoeiRb5dseMP28TZMJPR0dlxEyBQDtakNCB5IQn3REn4V0GDSTw87MWKOlJSDdWKpGRWajY2h
 gCX4mi6kAD1vnVOzvM7+TGzG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:35 -0700
IronPort-SDR: dysHhv9kqpT/qEDZP4Xxyq9BXkMm5rQZ7AUPjgXrfXdhnIY8JeulYaRSjVlG98GmVMepAre4op
 Ul8CqVCZ4Q4QTXflkPtDY96qrygaBUzC1zWpIIMeAIfTkAyE4vFebXPmJIcbyeMnvHCLg9U8bo
 MyCJr3MVmtWXncV6INBcbIR3VP6QJXq0PRD3G0OsI5utQGr1kUkgRo7TeF8nkjgoQ+tpi83fCw
 pp2uDxGaySH5VcDCvNOAGO2PAnc4GDaKN8HFMSXqO3m/dJkBqvOrJlU/OCmouqrTy3QRMTI3K5
 ozU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 04/15] btrfs-progs: add new HMZONED feature flag
Date:   Tue, 20 Aug 2019 13:52:47 +0900
Message-Id: <20190820045258.1571640-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this feature enabled, a zoned block device aware btrfs allocates block
groups aligned to the device zones and always write in sequential zones at
the zone write pointer position.

Enabling this feature also force disable conversion from ext4 volumes.

Note: this flag can be moved to COMPAT_RO, so that older kernel can read
but not write zoned block devices formatted with btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/inspect-dump-super.c | 3 ++-
 common/fsfeatures.c       | 8 ++++++++
 common/fsfeatures.h       | 2 +-
 ctree.h                   | 4 +++-
 libbtrfsutil/btrfs.h      | 2 ++
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 65fb3506eac6..e942d37f8c9b 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -229,7 +229,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(HMZONED)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 50934bd161b0..b5bbecd8cf62 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -86,6 +86,14 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
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
index 0d12563b7261..a56e18119069 100644
--- a/ctree.h
+++ b/ctree.h
@@ -490,6 +490,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -513,7 +514,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 944d50132456..5c415240f74c 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -268,6 +268,8 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+/* Missing */
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.23.0

