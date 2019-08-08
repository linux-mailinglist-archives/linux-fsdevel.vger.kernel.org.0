Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF085E55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfHHJbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59647 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbfHHJbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256682; x=1596792682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tlSRYL+GTtWyMRutPWGcsp9feWnsZ7UbgYNziYdC/js=;
  b=V5093T7PvKdI/jY8O8csXEx+Ijkg4H7z15H6YNLkeOiWfkcq8NHf+6W+
   /qgqxjhtJE9jSbwP+hG5LbZPAVtEJokv7nJROgikoYi7y05INln1nnk/j
   WR92wvbbB2LBwp7e3NxVxYf2NTcOUoV5QATtAfAp56YYtuD5MOWvm4Nrx
   8efh+ril3DloJG8JD56f0des49P+Dz9V7MC3JiHN+wYbv6lX3Sq0uoAlZ
   5EeBzSy80vcZPYQyg3bVqt6jzcfcae5yaLjLS0TfsX2blHhIp45EqyyB/
   g4vvNYO/x3yM+ClomLLuIrPvBo8bvbSS1mzHGo7Ov5qPaFDGc/aRn4CRA
   A==;
IronPort-SDR: 6mWWnD9eVAsrS4/ERNWZMUZUflpUqsG+t42BHQU2HqfBKmzeJ3BWX/ZA7VImSMaMelt+7pV/2Y
 xOd410orh+3jHhklQ5iQXLdzBh9rUeYy/2OqMyT4Kms8zqcEz8e0RZBpVhAOVC6ObYb0OhBkbp
 ByZ5Nvp7Dz9MAOJDVx1yskC6oqRXF3Fu/QRM6AeflEmxSi+gZwXXRxOhTr+L/UqmQBfHAQbZ+O
 U8MkdSF6o5ee4yZd75R1iauqgfc3E5C6vJs+vVz5L+LDesI6qHhDPeHCOtkFYqwth1f4Pb3iEQ
 RqI=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363315"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:22 +0800
IronPort-SDR: L1Sf3DNe40Ghm4ZNVkhDBD4Qe4VqjwcPiOuYlJI+2yVGOYKGyZbgMvl4fjWZcTZFkpwusOsOWG
 6nQaLJaddj/6K8+V4KkFYIu9e3LE4NF+CJ+xOShk1uEp8/M1RI/eCcs2H0UDPyL7niW6MBruZh
 mwNteL2TPryA9h4QBNMZT0mqYT+yws7ERcMZlKIF77FpALTzYeG72vzUbYJi276kv1etf/BjRp
 ip9e0J3H55uDs9J9kb0JLbJfaqU0XEzLkwarLUviFCTCnaLilW83AmHp9wYmRk97wxDvKmICPI
 dsCjlnsNnnW2tSdr0Q/pHTal
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:06 -0700
IronPort-SDR: 562Ffc8W/J3sp2S09jR2zOKeoNrL+cJl6jQmACFX/1uKC2spM4dr7Bx21RimySJ4rq/XWhWbYS
 7x84e3fMmFz9eihV3fv2vCSkfHw94DZqYMXcT9x7WilEr/6fRc1juD+FcVwRrN1D7hPw87b6kf
 fVik+GXuvePtDWYPxlo7abFfUww2oCB7x2gjmYrqNg/tjFFv4tgpZRQ+WWUDWyX1l2nZnQ64L8
 vbTSiA9ZQz3HwwFNvy8phGwc++tjnrjkk2lDQuqdHibxzaSW4AiaY7tr/YnXrJnN/l34bheqSo
 txc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 05/27] btrfs: disallow space_cache in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:16 +0900
Message-Id: <20190808093038.4163421-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As updates to the space cache are in-place, the space cache cannot be
located over sequential zones and there is no guarantees that the device
will have enough conventional zones to store this cache. Resolve this
problem by disabling completely the space cache.  This does not introduces
any problems with sequential block groups: all the free space is located
after the allocation pointer and no free space before the pointer. There is
no need to have such cache.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
 fs/btrfs/hmzoned.h |  1 +
 fs/btrfs/super.c   | 10 ++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 641c83f6ea73..99a03ab3b5de 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -234,3 +234,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
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
+	 * SPACE CACHE writing is not CoWed. Disable that to avoid
+	 * write errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable disk space caching with HMZONED mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 29cfdcabff2f..83579b2dc0a4 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -28,6 +28,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d7879a5a2536..496d8b74f9a2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -440,8 +440,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_fs_incompat(info, HMZONED))
+			WARN_ON(1);
+		else
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -877,6 +881,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_hmzoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
-- 
2.22.0

