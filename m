Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DD2E04EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLVDwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVDwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609149; x=1640145149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ED4EOEUJg6a3xFIzZ2Ewk0nDsoWASDuLgC90jwAnokQ=;
  b=MMtK7Y9vOR5QYBX7W8CK/Xpd9gHZRvJIgmSTcZVJe8A/iN+N8fSMx2QD
   S3e8cJ/xBmyaFZRSVAMrUw3LIVx8PGdFCG/4iEv77NkmrHJdUGAXEhPw6
   UBxY7j4Yjdi/3gsRLu8JsmoPbMKgVA+OrofaxTYpFdZ7p1RZj8XiFIrzu
   V3Fm3Z0mp4bhvtXN3zPJnvU9Z1nKBGG3ctfEC49lVGRbhhW8wwRax4z0G
   X5BiqLivo3BmAk2IIp7vt/WZQLJnf7zVvv3XDBgl5NxdHioMSf8xZF2lf
   sBwORkuC/svcPPMyfQY4BzRlR1PG1EFcyYztHrhyEzEdnI0trgb25cUDx
   Q==;
IronPort-SDR: pFliGu/I3lIbwmHpzyRhwaw5BS9RxC1/QFRDNgxDLf2O4nkwoaS/tWGGBzka/G/ARyv4SVHWrp
 ceN/7XO61T08VSeL+Gx9NFKRxBLpsq33oXHcw6+poRWC7+Uruk5lkJ+ozxdccn6hYRc7JlI/k/
 9B+eJRKrhQUtFn8FAQHOVscSE/BxIWPxuUe4zRl5izA/fohnpMXlLFr2jkynGrhjyOebVu5zH9
 Z2b6mHq5/GHAV4wkiv8PKVHZO2j1vPhL/s+jODp/9OY4dfOfnR0rIPeFygszW5I+8HrtwnxrJD
 ng8=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193735"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:33 +0800
IronPort-SDR: MUN8h6YItS/IkzhqKWAyzWB0IdGfLlfIS4L8yMfSgYyJ8gY9Gt7nbVJZYBqN0LG1rmc8ld5dj4
 fntFy5p9B3cIaqCXrhfzQ15xAlWaWHIWHN1IOLcApQWaUTA4mq3pM5hJFJVi6zDy57hSFo6VfX
 ax0p8vpYvO4TNJ5P2yjqi3iALH2wLmm1LNJltcrUV6IFdxBzGKa6CCnUX4r8rZW2OJLQ3tDPcL
 cGFs4ZznQH2+iitsB5NuOLo0rLRjl/dRYyWbOpAjBFHdYk403AV2joo1geaoHQj7FqkLYbFBjA
 VM8MyIEir3SRM9IhRsd4tpy2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:44 -0800
IronPort-SDR: rjk9IsCQX+siPAx6V27L8Zyucp9G7Mwyg/lGFV+fdswJXE3J/V7EXyB5YMnf7RFNCBDodog8Op
 yF/9RBXIhNvm7kvB9Dsii8VUTsKjRLMjLhXLeq6TBJRj2kzXQ5TE9KDZOI2+zi7kmxhhaxo2Ga
 ak9EAlRFHQ8lu/4eYQVMaBrh6C3THKxlwxL+yG0vyUbo1bRiPITLnNN4neHD/SgBvB//19diRI
 PvXZ1b/2NuYnt93hYcuwBWC5f5vdyMxFAvgrsnCAcphogbgXOVfQNBdFydFtJv/ANdlSkRTwnO
 gOc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 06/40] btrfs: do not load fs_info->zoned from incompat flag
Date:   Tue, 22 Dec 2020 12:48:59 +0900
Message-Id: <fb24b16fb695d521254f92d70241246f859ffa36.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since fs_info->zoned is unioned with fs_info->zone_size, loading
fs_info->zoned from the incompat flag screw up the zone_size. So, let's
avoid to load it from the flag. It will be eventually set by
btrfs_get_dev_zone_info_all_devices().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/zoned.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e7b451d30ae2..192e366f8afc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3136,8 +3136,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
-	fs_info->zoned = (features & BTRFS_FEATURE_INCOMPAT_ZONED);
-
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e5619c8bcebb..ae566a7da088 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -431,6 +431,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
+	/*
+	 * Check mount options here, because we might change fs_info->zoned
+	 * from fs_info->zone_size.
+	 */
+	ret = btrfs_check_mountopts_zoned(fs_info);
+	if (ret)
+		goto out;
+
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size);
 out:
 	return ret;
-- 
2.27.0

