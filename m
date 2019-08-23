Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AC9ACAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404210AbfHWKLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfHWKLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555080; x=1598091080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+czJv/GmG70ux1+2aP+G8UuCpWVPl1+fHma1GR8sC8=;
  b=bBvpogC8154sej6Fl5mL1K/7uVeOzE+FGn6AJbnF7tnl1Vvzrkbr4gLu
   DZiuTXoQNjSsXU//ODqcCp8gFCsoir53bOhyPWFD9jcNISJSOuVDq1NWE
   gvGVCtpLNM2xB6CQ0VnlmFbxycmhJI+hPqQ4XnvinDnHe4v21K/venEP5
   i/6VTuLnItQawSlGqaRm5cy7PoeJxphKTfdADRkomgWaB4/FrL83a0sjR
   RkLsdw/uwLef558ksdyNLJlGFc2IJzzMwpL05qwMfwOjgmLxUhou2M1cA
   ew3QGH51ivtQm0F+/zAjX+LP9FzOIWgFEGC+8Fsxh3rBAgKnqD9ajG1eD
   g==;
IronPort-SDR: FzET/B22COTJ4RyyM1vlxMKrxAdjLK9RoeuhVkg0wJEwEEBwExwYRyp/pEbc4M7YbQqTL/pxZZ
 lq4xPj/ryL6+R79iWeWbg8ykqky5aEq3hZGbaK8WZjHrp0S2/Gvo2R8LNyD1t8KPFVsLqOBXX0
 BPqYm78dYsbCjcQ6b5Ayu5kvZ+xNdB3piKI1B2F2CQFdp7+iW69SVHhT9AjHENzGE4VzcP1Ibq
 Gn0QrCeVKc1MQ3Vit+RSyPtTbWL7oi1hU0IHFVH2gS0KbeI4+yRlIm5P9Z/OqRdcSSQKHFUzrO
 +mw=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096236"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:20 +0800
IronPort-SDR: FXG/60sZRBQrt7Cj/ppBElzoLQ27NAstQmKAIxikFaZ2hpNVsfLH2ptjB4munxLPGpGKU+xaZE
 BO8NPUNpVLkROcrZTKq2leYVJyekAWUjz2U2n2/k8/LR2on1xDSKdRsAZZwDWPK05x7Jhqri6d
 V/NaVzVbC6JT22z5SC6fkF1tiWC29llQ3MpSPy+++j5IxJAlBhmG8XR0hn3bHgaiyc7vMTRoO7
 gdGK+SqWDPN81d+BjgCYuh1bXc1feuwFEmka2xPDIjihCeqx3r5V6XGwfT1qa+ChCRHG8ZwQHK
 rJKMl69mRvidHKOgQw9x6rW5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:38 -0700
IronPort-SDR: QXs/QYCj/EPx8a7BI/NnzWYqPhJE2iO+yWAH0oO9d5yBNmikKW4+uBrPpUZMJLX6S12axvoRA7
 1J5/tta71egowT2Lm4/GmlgdGSgRriRdZTaTeT9KLvMdIsnGrW0tQmaWAlZquCP2rxDMHxAYXe
 8mSyK1pZHPc0Lu4g7rWvybjqclu0x3ZHt4r8ZLlUTYpffod87nuk1uGpuUZlUx1dK0FfvK/X28
 qB8pRpxU9jG2d9YRSoQI9EDYhrIBcP6QAwtxVhgDf0LUSKKsnTwtaYjYOw7dm9qpLQZAbvhAfq
 sFE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 05/27] btrfs: disallow space_cache in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:14 +0900
Message-Id: <20190823101036.796932-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
index 84b7b561840d..8f0b17eba4b3 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -231,3 +231,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
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
2.23.0

