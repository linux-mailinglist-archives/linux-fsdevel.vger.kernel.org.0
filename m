Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD29ACBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404435AbfHWKLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbfHWKLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555098; x=1598091098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bmu9r9dyfmzCSO2sk7kl9FUepC5eW+BqiR751zfVd2Y=;
  b=XbKxNVtPrrkHzMqUhqepAyeyuty9UhkfHTnEQ7/j3DzNT6NwmATZYUPY
   +K+HNrkMnUehcM1QmhlvWnUQNglma8xEgVFUZpNMlhwX2ANyYjCN2xE+A
   BgpwKemYZjp9QLAqOdXMJ5pPSQWQEUN/GyWkuYy5qIWREcSLBwIrgHvlO
   KXhk56PQm3c41EzOxzVMvyHm3ZAECfk7QWU2tfNLHs9liODRktGN/Qgtv
   D3iTNP2wikMnyK6Ip0BhCMTK4ZPBa60dNz460FlS3mOa7mg4vViqziV+K
   K/lXm2KoFzt0C/HhA+WEvGjONcGxM7GX2BTb1v6I1M5NEewe0lzzohL/y
   w==;
IronPort-SDR: tRNQPcbetg/LF7aFrugQaSFzKXqaOWLO5jiD6z1Q1EyQ9j1QfUMhbkgrIhVXfn+okZXkqcfPSL
 Rn30stW9Rrp6mK2AXc3dRQqUDSKzHTzCKjJ3/1R6H37DbY83UsgAjXCzGofkWwOSmaz6fohncb
 eEZxvxg1X5D5KOo5h/Zbozidbn/K+wtPkJoxF28OhVTEXOrs9A8VptTLKAgYEFcfXDxEDT1DzC
 JgAnQeZLAxTP91YHhXk9goShbDj8fNYGIBMAqmhmXK3Upvv5mRSDzi2XoNEszPFsTgmAUCN3ih
 q3Q=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096253"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:38 +0800
IronPort-SDR: q2SrYUMrPlRCg88RnsAMjunZ77vS4F6Z3LlBtkbZ346M4EEfFlzYosv3jQB/4mT9KGPh+PxoGx
 GW9/d0nVBU47nQGWL8k4yvU/DfxgWsYD38tEuAFzIHNi44NvHfAat9/OofMl5fm8Yx2hnjy561
 vLW5batf5pP/HauWi4TEjCzyZMLi0v4pCQ8qyyY+0DLuQqEfKMC6nznWe0WflnmVhzm6CY64tD
 v5SStsjvZA4WCoTaJqYH46/F33MoCXY/Ax1uPz/U3tCpDhk8kc16KNtvTESKMyH+uDq2Xvi5DQ
 82s1KKL4lvesxkmnsAE1uN0K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:56 -0700
IronPort-SDR: vapz2JTb7nBIgK51gYrDmSvmvB4QcbQT4oH1y6/RZEsHjHL/zxyqiSn1fDlueEe6Q9wKlywRkB
 M79a2AIF+upYAHhXjs9nBZ41Oj5zg05m3JRN/E6DBfRk7y5nkcMSvV4WE8l080FIDpQAGeMLYq
 9dznCuprcmS3C45LBpUXC8Px71q9xjDYD/BuHSL14/IHlBOXMCiXEH+c084SWe4Hkafq4xE/rj
 pmHR2JM4Wy+BblPueyyGppgdi+8+tznwYGpJbmgbCPzyiLe94NF7OJ097Qloe1pno7KJJirA7t
 FL4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:37 -0700
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
Subject: [PATCH v4 14/27] btrfs: limit super block locations in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:23 +0900
Message-Id: <20190823101036.796932-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When in HMZONED mode, make sure that device super blocks are located in
randomly writable zones of zoned block devices. That is, do not write super
blocks in sequential write required zones of host-managed zoned block
devices as update would not be possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  4 ++++
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/hmzoned.h     | 12 ++++++++++++
 fs/btrfs/scrub.c       |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b25cff8af3b7..38a9830b4893 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3545,6 +3545,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
@@ -3611,6 +3613,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		bh = __find_get_block(device->bdev,
 				      bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 457252ac7782..ddf5c26b9f58 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -239,6 +239,14 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 			if (logical[nr] + stripe_len <= cache->key.objectid)
 				continue;
 
+			/* shouldn't have super stripes in sequential zones */
+			if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+				btrfs_err(fs_info,
+		"sequentil allocation bg %llu should not have super blocks",
+					  cache->key.objectid);
+				return -EUCLEAN;
+			}
+
 			start = logical[nr];
 			if (start < cache->key.objectid) {
 				start = cache->key.objectid;
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 40b4151fc935..9de26d6b8c4e 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -10,6 +10,7 @@
 #define BTRFS_HMZONED_H
 
 #include <linux/blkdev.h>
+#include "volumes.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -125,4 +126,15 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 	return true;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device,
+					      u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned
+	 * device, non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL ||
+		!btrfs_dev_is_sequential(device, pos);
+}
+
 #endif
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0c99cf9fb595..e15d846c700a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -18,6 +18,7 @@
 #include "check-integrity.h"
 #include "rcu-string.h"
 #include "raid56.h"
+#include "hmzoned.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -3732,6 +3733,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-- 
2.23.0

