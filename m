Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE611DCD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfLMEKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210248; x=1607746248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuXMQSDljydNyydK04Js/j2ADAd1KRqir9xX0N0qj8Q=;
  b=QXM5n5cOJ5V4c3lEuShvFxnBDH/YYzYExwoVnqYz0x7luKRg0hGxbRXu
   +MM080d1h86OAG5uOkkTsgozjQSRUgHzloprh7kl22v1/z6WIKdhqwCHa
   L1iJnAAl6yo3lVEu5Thopy0oCeodepI3A48yIvv//fe+P4mUGN2J6z4PC
   x7Y8bDBhPle4pq53at1WMA7atgYf1F8YCW9JH22P6WzQmuv6iTn0G82lF
   3zIf21+8t37Iua2S/F30kzr/6roSKyZOTvVVE1wJH8Uw00WfasA0EZMEm
   EMCA0Xb1gcagqxTAIbnyXPlM+Bk5Y2Ijpawlk/33kDjQW9uaJVpYL9zl2
   w==;
IronPort-SDR: EzUkBKblhAlsrTBOzLCzEcOqwkixrMLDJoLpYuOvPrhF1y47UQ4x4F1xKcR51u7UECWF8AjRy5
 nDQC/0n8+sNJ3i6WXhtwTysyKf2TFYn4JW/M3UgTEjb1WJnMeWCFiO3+Y/jZpn1kdYkYZf2Q+f
 BFI6V4TwlSwtNO2YFhnAK3/7/ToSH1QAM5jeOFdw0cOrnCbvuae/cIwvQs8CMIk/U/rUsqnNyH
 Sxr5SJ1sdnZ3aWENlcLCFX1QgSJ7yZ04TmyiG/Qda/iYSWBvgPHr7qp0WwcVEfJyTDS6r8WAGD
 2tw=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860107"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:48 +0800
IronPort-SDR: PjpHPo4MVnZikNUwVUWOSZrIJAGZHWsVCRAMZN6+ppSi4czqoeCpaLpEeNHi8kDawLAJBVK2sx
 Nzmnw9snkJ0Fhdl8d/zlH9Z1NjtVI9N9BmYSU9y0AADVLdHCjO/21TtlO8ZHMxQsVFXQHqYVa8
 vt47MRFiwexF/hdV3XWxEpK1giXuX4BUbGIOWn0oufowvsQO8KgWin+wIFSgbO6MFTa6nazO9U
 F22EfUK5QPDPkmz7NGmSr8YpLOBVuK/p7UFvVDerDExem6zvNwtnneANruwc4iTLxQMED6VlEm
 rKVce9xOKfIMHT8fKGRhIOcb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:20 -0800
IronPort-SDR: CdyW01rxs+B0DoggYYWfCbmg2DNCkG4eYGuXV1sUWf5yG7n+/TpYE64M+MKdcL+ZvBtCUjT0Tj
 PyOPfO5AXQ43E64Mtyt7LPLwUprEI8hMBiz3GgW5tf/gA/ctfzpJto4Ln7mPY8/u7HNeaPpGnK
 Q62qxaG+RL+k28gPt8RwpKUo1gYeMqA5WO4/oG1nMU6/2MQoWWvYdcCsekFU3hmSSw0YECaoDL
 FCr7IYjKt9Cu0VMTWpbYnVVtBN4JQDpxonYlub9NicpTi86SrIW0yLtcXYjt7CwJKp+PhDl/eF
 bk8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:46 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 05/28] btrfs: disallow space_cache in HMZONED mode
Date:   Fri, 13 Dec 2019 13:08:52 +0900
Message-Id: <20191213040915.3502922-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

Note: we can technically use free-space-tree (space cache v2) on HMZONED
mode. But, since HMZONED mode now always allocate extents in a block group
sequentially regardless of underlying device zone type, it's no use to
enable and maintain the tree.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
 fs/btrfs/hmzoned.h |  5 +++++
 fs/btrfs/super.c   | 11 +++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 1b24facd46b8..d62f11652973 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -250,3 +250,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 out:
 	return ret;
 }
+
+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
+{
+	if (!btrfs_fs_incompat(info, HMZONED))
+		return 0;
+
+	/*
+	 * SPACE CACHE writing is not CoWed. Disable that to avoid write
+	 * errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+			  "space cache v1 not supportted in HMZONED mode");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 8e17f64ff986..d9ebe11afdf5 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -29,6 +29,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -48,6 +49,10 @@ static inline int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 	btrfs_err(fs_info, "Zoned block devices support is not enabled");
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 616f5abec267..1424c3c6e3cf 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -442,8 +442,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_fs_incompat(info, HMZONED))
+			btrfs_info(info,
+			"ignoring existing space cache in HMZONED mode");
+		else
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -879,6 +884,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_hmzoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
-- 
2.24.0

