Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB94E18CE03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 13:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCTMtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 08:49:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18199 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTMtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584708589; x=1616244589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I1kK01/K2iy1x/uBo3Qqwva2phrX4djBxNCuqjc03C4=;
  b=Qf0ueiJmgsUPUDJCj6gPqXjdzbfaEiY+c5wC90f7RcrMcV4HxJsv226Z
   cnKJcOe64uM+wIxcNe5hl40+c+rcj8agqpaEovQpveYpLQPNJP+1IEjOd
   XVQhQzSfdFK5pFLs8FOyA+TFvNiN05bPpjTXbDxe8VPudadEoJ/qufMPo
   +9a/4mG5+sPwmTPHHMsMlGw22PzNAt9JqQ2J+VZm1G6l2oys5AnJ9kEsd
   dvPTUBnNZXKItQ2T86zF2wFuXvP+Y3wQx+QkIujRrt+f53QK6NcAngGzE
   hloz36bcoH78XWPvv3vqDsmH0wAcl96VepsAMi4XchGMFRh+2TTSYfLKM
   Q==;
IronPort-SDR: 5PdvUQblfQCLnfaW7zgkFm4wEOzgAwCmFiZf2vzFiy7HADuhpzkckL12fx4a+4rMh9+wvW2gWy
 9MRP3lD1521qjyBIlg+AACYBW28akrrksaPG57rsZaIoM1pzHRL9/9q2rZemn3pjq5thlVb4M2
 ZzAKpgm+mVEHIzCRf78fCNJjLZXGFBjz0XvRDqlARoFnuW5mcB/jby2vITvgeQC2lxBHtaqwmN
 8rMuOVOzwNUIooJE3DAZu7wkWcRzA+iERcnKWoEPiL2laja2w+rL50t6pHazONnkbp07+W2+u1
 4rU=
X-IronPort-AV: E=Sophos;i="5.72,284,1580745600"; 
   d="scan'208";a="133062601"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2020 20:49:49 +0800
IronPort-SDR: 71hV3NJod1F1aCFTZ1YwDTtwlTLR72crlcOoUTAlmyEehRpCMBdgjE74xgrmNzxU0wxaZ3WIyL
 uFDeAbatboD8vIzpLCkkQC88jdEI/TCo0D9wHT2rIE8/Aw/XcA11dVAkCaNS4c06/OXFfgFXGU
 K/TFZ2AmFTGknVFsAU7S/cy88mImk0LiU3/+7gQ12CBoLa9+RXP9SOsW4Hzw27VyI65wdYZ6Pq
 cCNp3UMqHEQzgGPR5sek+Z0sbHJDnX/Am2EVBlPJUcxFSfPx+ySS90DGYTNeOCrzW/fp95V5AW
 bjnBBcDNkSUlQjttE4h+O3gm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 05:41:12 -0700
IronPort-SDR: RXcTHa6CxEMTTzuofUGRiC5z68OlofJAaBMSQ5pUaTqNnGLLunxUQ2LZy1z93KS0y0H5UFar/x
 AoWJ0YvODn/kx5u+SDLPALBcihH5UQb+fGDvEadwstqsQe4EzjtV22pPWZDLAKcAvLvldBrTCf
 6i8Xf/lLUEKWc6bD28W6CXewEYw5HlLsUQ2/ZyeDBKAFhw3T4jRArafjGH7vxOAOWJJp6IyRZL
 0v+KT3hAguKWbSmcp/y71BUAyWYfKg00LqasPdaz5apFIEgvPbE5pU/ZV0eJHftULmvQs3hRto
 Qs4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Mar 2020 05:49:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonfs: Fix handling of read-only zones
Date:   Fri, 20 Mar 2020 21:49:48 +0900
Message-Id: <20200320124948.2212917-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The write pointer of zones in the read-only consition is defined as
invalid by the SCSI ZBC and ATA ZAC specifications. It is thus not
possible to determine the correct size of a read-only zone file on
mount. Fix this by handling read-only zones in the same manner as
offline zones by disabling all accesses to the zone (read and write)
and initializing the inode size of the read-only zone to 0).

For zones found to be in the read-only condition at runtime, only
disable write access to the zone and keep the size of the zone file to
its last updated value to allow the user to recover previously written
data.

Also fix zonefs documentation file to reflect this change.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/filesystems/zonefs.txt | 18 +++++++++++++-----
 fs/zonefs/super.c                    | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
index d54fa98ac158..78813c34ec47 100644
--- a/Documentation/filesystems/zonefs.txt
+++ b/Documentation/filesystems/zonefs.txt
@@ -258,11 +258,11 @@ conditions.
     |    option    | condition | size     read    write    read    write |
     +--------------+-----------+-----------------------------------------+
     |              | good      | fixed    yes     no       yes     yes   |
-    | remount-ro   | read-only | fixed    yes     no       yes     no    |
+    | remount-ro   | read-only | as is    yes     no       yes     no    |
     | (default)    | offline   |   0      no      no       no      no    |
     +--------------+-----------+-----------------------------------------+
     |              | good      | fixed    yes     no       yes     yes   |
-    | zone-ro      | read-only | fixed    yes     no       yes     no    |
+    | zone-ro      | read-only | as is    yes     no       yes     no    |
     |              | offline   |   0      no      no       no      no    |
     +--------------+-----------+-----------------------------------------+
     |              | good      |   0      no      no       yes     yes   |
@@ -270,7 +270,7 @@ conditions.
     |              | offline   |   0      no      no       no      no    |
     +--------------+-----------+-----------------------------------------+
     |              | good      | fixed    yes     yes      yes     yes   |
-    | repair       | read-only | fixed    yes     no       yes     no    |
+    | repair       | read-only | as is    yes     no       yes     no    |
     |              | offline   |   0      no      no       no      no    |
     +--------------+-----------+-----------------------------------------+
 
@@ -307,8 +307,16 @@ condition changes. The defined behaviors are as follow:
 * zone-offline
 * repair
 
-The I/O error actions defined for each behavior are detailed in the previous
-section.
+The run-time I/O error actions defined for each behavior are detailed in the
+previous section. Mount time I/O errors will cause the mount operation to fail.
+The handling of read-only zones also differs between mount-time and run-time.
+If a read-only zone is found at mount time, the zone is always treated in the
+same manner as offline zones, that is, all accesses are disabled and the zone
+file size set to 0. This is necessary as the write pointer of read-only zones
+is defined as invalib by the ZBC and ZAC standards, making it impossible to
+discover the amount of data that has been written to the zone. In the case of a
+read-only zone discovered at run-time, as indicated in the previous section.
+the size of the zone file is left unchanged from its last updated value.
 
 Zonefs User Space Tools
 =======================
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 69aee3dfb660..3ce9829a6936 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -178,7 +178,8 @@ static void zonefs_update_stats(struct inode *inode, loff_t new_isize)
  * amount of readable data in the zone.
  */
 static loff_t zonefs_check_zone_condition(struct inode *inode,
-					  struct blk_zone *zone, bool warn)
+					  struct blk_zone *zone, bool warn,
+					  bool mount)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 
@@ -196,13 +197,26 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 		zone->wp = zone->start;
 		return 0;
 	case BLK_ZONE_COND_READONLY:
-		/* Do not allow writes in read-only zones */
+		/*
+		 * The write pointer of read-only zones is invalid. If such a
+		 * zone is found during mount, the file size cannot be retrieved
+		 * so we treat the zone as offline (mount == true case).
+		 * Otherwise, keep the file size as it was when last updated
+		 * so that the user can recover data. In both cases, writes are
+		 * always disabled for the zone.
+		 */
 		if (warn)
 			zonefs_warn(inode->i_sb, "inode %lu: read-only zone\n",
 				    inode->i_ino);
 		inode->i_flags |= S_IMMUTABLE;
+		if (mount) {
+			zone->cond = BLK_ZONE_COND_OFFLINE;
+			inode->i_mode &= ~0777;
+			zone->wp = zone->start;
+			return 0;
+		}
 		inode->i_mode &= ~0222;
-		/* fallthrough */
+		return i_size_read(inode);
 	default:
 		if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
 			return zi->i_max_size;
@@ -231,7 +245,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * as there is no inconsistency between the inode size and the amount of
 	 * data writen in the zone (data_size).
 	 */
-	data_size = zonefs_check_zone_condition(inode, zone, true);
+	data_size = zonefs_check_zone_condition(inode, zone, true, false);
 	isize = i_size_read(inode);
 	if (zone->cond != BLK_ZONE_COND_OFFLINE &&
 	    zone->cond != BLK_ZONE_COND_READONLY &&
@@ -274,7 +288,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 		if (zone->cond != BLK_ZONE_COND_OFFLINE) {
 			zone->cond = BLK_ZONE_COND_OFFLINE;
 			data_size = zonefs_check_zone_condition(inode, zone,
-								false);
+								false, false);
 		}
 	} else if (zone->cond == BLK_ZONE_COND_READONLY ||
 		   sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO) {
@@ -283,7 +297,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 		if (zone->cond != BLK_ZONE_COND_READONLY) {
 			zone->cond = BLK_ZONE_COND_READONLY;
 			data_size = zonefs_check_zone_condition(inode, zone,
-								false);
+								false, false);
 		}
 	}
 
@@ -975,7 +989,7 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	zi->i_zsector = zone->start;
 	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
 			       zone->len << SECTOR_SHIFT);
-	zi->i_wpoffset = zonefs_check_zone_condition(inode, zone, true);
+	zi->i_wpoffset = zonefs_check_zone_condition(inode, zone, true, true);
 
 	inode->i_uid = sbi->s_uid;
 	inode->i_gid = sbi->s_gid;
-- 
2.25.1

