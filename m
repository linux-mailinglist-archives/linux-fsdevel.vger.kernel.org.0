Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6982A06D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgJ3Nwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21982 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgJ3Nwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065950; x=1635601950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yp4sWa7sTEUtLZclF9ZhtgP5sfBabo6NdB/4KCl1KQM=;
  b=lW9BtdKZq5W79q1hWy3eHBWQuGrHUgjOEuMlFiPx/tL7jVPddWPCw/61
   SSyEXQJxcSU4u6k/mcQTf63VpbxJJ3NWDXqz4/sAhNYtNwRfOQy5i6cAl
   5APZsO5faIXKlO7V4IZ9XdPs1OM1qrpxHZyRqsUHGUSa4+ZmQpLKQPLrj
   P4p0T6H3LBiDUs7FQp5gjGCX5tyBWnghhVES88Uui6mwzNk7fwuQDv50l
   Cw9u2dZXMNEneBoKneC/C5fCH7zWI0m2xCbn/hixeHqs5wSIEyFgXe94C
   32ug3KOiONBL7Mv10dURwmdjFcZtQjnpGREWx3coNW79rl7zevpunqulq
   g==;
IronPort-SDR: 1vQgHIL4rSL5wbGwojnYe4ZMQsc8AXKk3gj9x6/Q2M+1ZFLSDh1mmlxl0ombWCih0u3jMfsRTU
 qqL7gau5inzFehq+bKOlJ69WYqedMz/gJy+WPzxPC8NP36GHXFSP1XQaRcDZ9y/q9ZEudtVLkB
 r8azStHer5sdY4Hy15efAU9S0ph9yeycjhoycmdmcu2K5/QFHn6BX2yNLv8FMkxSSeH4yndtlg
 BShU7HaoQpuGYPlnNq7lefyYxA5ROwOUUHkuf9Q2hupj0s371CLMHnZJj0QOExr4FJYQRwFxNl
 pVA=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806586"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:30 +0800
IronPort-SDR: J2LynzpVWIAJi9DWbi/AuqO5y/bukaIe1nXQz2kxFV2Cp+LekE9qRgp6So9M8eB2fG49plEB34
 26uRQVIE3+n0z1CDTOZ5QNYhw5MlEL3wc9Npt2jqvr9jd0Zejo+4tVuQVI0IeOJqt/VZmzv7GS
 6BVAPzCBopqz9+uAcfkpKyQ8oNkbF4ON1+ryDMWnsni0cWs/UrrY5VxNYE7zkkjT+rrEnd81ZA
 VP4FejAwhji4SfFt7eIArUUafwG7yLaRrkys+8DSPB99A8PZefXRKt7In8n7QNZrA4IzZf98xM
 oxHBrQMMosNa3B9vJNHHavsp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:44 -0700
IronPort-SDR: cxGdWdOQypRgl/skraXD7rxeU4MbOgnk77orHFtuJm8uwxhazmxdNAf/qI/cxcvcJCrigMm0Y8
 cv7kpZ84kKaAFBb7Oml23hPnJvGIOx8r9GeCGytO1FlitRW9bWb584HHGKBsQzLaXGVJhMx5e/
 kcIlxtZsgrBKgdyiJSnOm96GHTUuZ24jhlKX8mNbrLHBQspb4qoOO8ruR5+7Cae8gfKx8hdudp
 ACGp+PTnztvulE7ygD/TUuevlHJFUPxZ6kmt0WcImz21PSMFspjabeL0C92yPD+MVINGUwK0FN
 GUY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:29 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:14 +0900
Message-Id: <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
INODE_MAP_CACHE inode.

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
| INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
|-------------------+-----------------------------------------------------|
| MIXED_BG          | Allocated metadata region will be write holes for   |
|                   | data writes                                         |

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/super.c | 12 ++++++++++--
 fs/btrfs/zoned.c | 18 ++++++++++++++++++
 fs/btrfs/zoned.h |  5 +++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3312fe08168f..9064ca62b0a0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -525,8 +525,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_is_zoned(info)) {
+			btrfs_info(info,
+			"clearring existing space cache in ZONED mode");
+			btrfs_set_super_cache_generation(info->super_copy, 0);
+		} else
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -985,6 +991,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_zoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b42e13b8227..3885fa327049 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -265,3 +265,21 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
+	 * SPACE CACHE writing is not CoWed. Disable that to avoid write
+	 * errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+			  "space cache v1 not supportted in ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index a63f6177f9ee..0b7756a7104d 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -24,6 +24,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -43,6 +44,10 @@ static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	btrfs_err(fs_info, "Zoned block devices support is not enabled");
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

