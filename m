Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656AD2AD53A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgKJLaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:30:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11954 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJL2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007696; x=1636543696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lqxdx35FUap/CAvTMJciFfgXpY7uJ4ECqpMTE8oPvhg=;
  b=SmjsNjR0mNfYoFdMrW29l/DRD4JByCG2uJOat9I5LtzvLf3176eD5A6R
   Q4xtNL7YHKvakemyOX4UAIRVjYpdrHsxi4nNkm6Q3mGaJ5r+F3t3eX5wJ
   tGJjgRjykA40cB9lW6TcCDVESp3uD2vuLz+jwyeG2R1aWN41gL+x8x2Xu
   u9KAydONuNj+6WntZ/LBvJHoq3Zhd9jQMolYYEvuYgrLovs20E07iqEKF
   XFRPLS8O36RbvdsPwKRUfl3ajb8cTNiB6R321VIHwzubMrPd75S7r+t71
   lmVUaIXwd/xI9Nijm8M/KC4B0oO4o1tGnOIXUhXu4nB3dWxdm06EKqcsA
   A==;
IronPort-SDR: wnl2pV3WreKfeSerkD3vZKxSPW1bPnIxukRYcT7pSnueSU0mXFAzHu3IgItbHkY5GssAH8EQob
 mWWKSVonclkBxl8/kHBhV/IUuOs8a3B+ZSsHwyNoojo1lyodWhxWh9h6vK5VTj32hQyldcCcNo
 UemC/OVZc4qBZM/H1TQX35k8ql8s07S30osSrRyzsLDZt9HBOysrU/48axO6rAkV9frbVUbhFf
 rlGR0ivVbMwIU/23UE9AdjCXWVuwiEZRXiJfQ2hoan5lewD0o/5ttd4UipYc1ntocxMz50oy0/
 Hyk=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376422"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:16 +0800
IronPort-SDR: O+TcR1keJPqb9hWipHSP6HnP7BsQ0s3byC481LVTEEfNgIb3scoLc0inVNclRutdcKbQv3iJoX
 nE8Jj50MObqgZos7vMakpMocmHk7U/Ifdakr8kxrmj9djdcMYxbVuCou1Sey6gDOAnT0K7S1ep
 uqbmr/EkY0GbhaTRjXtO6riuy5jo7w7StS+boIA0k2yu042R/txfE/4hs+mZOlnkLKlJuLA/hc
 iZ/PHqhnIO1h+05XRUN/WaduDGvnMA3xvrRN/n8vqEyOnigiBiVEf+BXEyflfyfcug+CmFCTZq
 /WxO6D8YwKdqwAOpyY67DtKz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:17 -0800
IronPort-SDR: G9ICEja8KLzU+TWEHUehzuZoGKMM09JtPyOgZdtiyLJZMEyu1oB+IQsYGKN3wfQLOJBfJbrgUx
 npOf6DoTryIHeyCqwXIk+Ob9007tKfaazV6ofgXs4bR3VBPtKKo8RbrdOLSBU2lOewpS5X2+X4
 ByFrpKWPz0mDbp9q/nwHcEMYHorSMW3AMXm692OgiGWZYvDwZ5aCMYtOs6z6guOWqpL00X6ydt
 KCNTBt4YqEGrO1aKUqq81akyISNgtNkKC1TKCHgIutM7IWqsSgCYYqm/sQFEQ5yG/k0yS5ocXE
 vuk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 07/41] btrfs: disallow space_cache in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:10 +0900
Message-Id: <2276011f71705fff9e6a20966e7f6c601867ecbc.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As updates to the space cache v1 are in-place, the space cache cannot be
located over sequential zones and there is no guarantees that the device
will have enough conventional zones to store this cache. Resolve this
problem by disabling completely the space cache v1.  This does not
introduces any problems with sequential block groups: all the free space is
located after the allocation pointer and no free space before the pointer.
There is no need to have such cache.

Note: we can technically use free-space-tree (space cache v2) on ZONED
mode. But, since ZONED mode now always allocate extents in a block group
sequentially regardless of underlying device zone type, it's no use to
enable and maintain the tree.

For the same reason, NODATACOW is also disabled.

In summary, ZONED will disable:

| Disabled features | Reason                                              |
|-------------------+-----------------------------------------------------|
| RAID/Dup          | Cannot handle two zone append writes to different   |
|                   | zones                                               |
|-------------------+-----------------------------------------------------|
| space_cache (v1)  | In-place updating                                   |
| NODATACOW         | In-place updating                                   |
|-------------------+-----------------------------------------------------|
| fallocate         | Reserved extent will be a write hole                |
|-------------------+-----------------------------------------------------|
| MIXED_BG          | Allocated metadata region will be write holes for   |
|                   | data writes                                         |

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/super.c | 13 +++++++++++--
 fs/btrfs/zoned.c | 18 ++++++++++++++++++
 fs/btrfs/zoned.h |  6 ++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3312fe08168f..1adbbeebc649 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -525,8 +525,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_is_zoned(info)) {
+			btrfs_info(info,
+			"zoned: clearing existing space cache");
+			btrfs_set_super_cache_generation(info->super_copy, 0);
+		} else {
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+		}
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -985,6 +992,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_zoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2897432eb43c..d6b8165e2c91 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -274,3 +274,21 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 out:
 	return ret;
 }
+
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+{
+	if (!btrfs_is_zoned(info))
+		return 0;
+
+	/*
+	 * Space cache writing is not COWed. Disable that to avoid write
+	 * errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+			  "zoned: space cache v1 is not supported");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 52aa6af5d8dc..81c00a3ed202 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -25,6 +25,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -48,6 +49,11 @@ static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return -EOPNOTSUPP;
 }
 
+static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

