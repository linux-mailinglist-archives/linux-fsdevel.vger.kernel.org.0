Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACCB85E79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfHHJb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfHHJbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256715; x=1596792715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ml3KMhXO+H6Ky5Bs7beA24Bl2I2FMFKC8vXmTBkJNNc=;
  b=ruiEwqpeDqmLLCknIokI4CSEmSNxzLA948QxpmwZ2G4PFjIg3HOO/R3V
   29/ecjYSFSNHTi2yfI5gauebR7UHrQWgN4yYX9cDJxqla+La2T1vxpFwd
   RYCH4bp7OqobAnlNEkn8YoMq3t6i6zTHsF/f/C9jnuPtErZ466FDkt2HI
   8XU4e0FPGx9YtGpuA6y1DVupGnslx8vCahCxv5I9+7Xe8McobS+dtbgOh
   uo9I95aCYycCgd/IWBzoQ//TBj0acV8K3dUYACwwVQM797yCx4NM6I74g
   u5JKI+yvSCftyn03iY5hje1EcBUebraQ++3wPpkkiQseTYVbtDkt9oR0p
   Q==;
IronPort-SDR: gYaznZAMpjZjGsHz+7yjwY8MiEmtdijLp/ny81ogvZheQ7BzuJibahsyet9kXhJFCSKJ7SBYF/
 +DF97vxwhFT0hmUvcECJZOu9aTJ8xqzV1kK44/9VH+Q3rIxk25WPJDXtLIg08Vbxcj+g579lOy
 x1tZYOwSw3Hw9yiFsIMml2XrD7LUyM0x7e7083tj6zYh+W/HKRCiDamMc1pYx7hS2amFZ6wZYZ
 lKVK8XHeUPoyIFqB3s2oQhGtRpiZa4qcJQ4k7JIloK8nvQP2DLE4NgVJv6RMMxTXulpUixIRV2
 Hsw=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363410"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:55 +0800
IronPort-SDR: BNQt6a7gCQ3RxwPI19pbBI9DvdE/efrkc0OFCFwHkiGHmMLRgCcRbmX/fDylsh4zsjYqff+plE
 Co5HfhvqRaPKLcmjlXkVeKhAUgqlLiamJwe+RRXCOgI4DZByisyIv/IvCdU6GFvz/AEJNF69Cy
 xlrYs992+4oT608XMkbVMVb5vs4mb2KoZno5VxniHRQMRTBfXbtKoxBaREc98t8dCW7arAmGQR
 BDh8gPQoQUUZKqZlbpFSPRTBVaJWsvH8Rt2K2xYsf3EogR1lSVKDwxBPJYa2OQr2BOhapWIAYq
 kIfti47TBLBfJ4vYVln0Z3+u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:39 -0700
IronPort-SDR: h+6JuoFrNRJHbV0UF6iM3ySjRNzKNVz3H5lPYTCMDXcJFOLdGiKHUTkjYHp+LOpoQ83+LGsUbZ
 6QoXLC0lrBuRQtqIQrnrXY9JyPpalk4yq8xSzUTIOdZi7bKpCb75VoxI4eI1IGVPAorjWTzRd+
 TCbSLwJ0C23viCEtkvAGjh7QT8mNT7hWYdbYcIlwMDuB5+mMz+elSAqgc/KzLlZ8mCMRq4uSg9
 AqcvFo6utg8lyqWfxvwoUW8DtDtXkJBl39Cu87TtufhdRHc7Z0v5YJz42M+SyJBudnyiXjtgxz
 jB0=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 22/27] btrfs: disallow mixed-bg in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:33 +0900
Message-Id: <20190808093038.4163421-23-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in HMZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 4b13c6c47849..123d9c804c21 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -235,6 +235,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "HMZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
 out:
-- 
2.22.0

