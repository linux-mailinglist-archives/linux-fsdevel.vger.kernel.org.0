Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED6E2FFC95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbhAVGZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:25:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbhAVGY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296698; x=1642832698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9+/RYxer975SEcYFMIh/JyuK33yUpWJ6D9D8jaz4oI=;
  b=IMZAXN1ARB6eeJKQcOg+KejZS9MLen2viGrYWXsFnLRqcUn74lkeT+2x
   kEJ8WKlYhvy8cE75oOLLtYYHYA5apxIB2eIgasEDccQJY87KSLN+lLTmZ
   qiDTY7FquGtfNXdaPU0jrsZRFztllVZ58Ag68Dot33laTxEJPiu01eEAV
   W1lT38izHCLRKO/EcqpDk3gDP/jwcpJlGzcQdJZiAK6lMNlzSKkSkgmC0
   p840nefWUE3zaz8rNnlAM1MbO0agsEcuRk4RjUSxyuoLC0gIk2bSTV7Rw
   xRHihijgOQ6AaYVhDpBWD7/7EnSAEUOnU6l8GfsLKjBrTngFTkNWFKeN3
   g==;
IronPort-SDR: H5uPYE42q2BmK+buIYjVmXOD3yk0AVJYdYGciJ34wScQJV+83oAXC/AlKyLwdKn86+YP0nY5IG
 45kremn7lAKzNGEdGSF9M5cghIiRkpaTlErpWlAcS8qPGtTKmDuvJLQip5qO7mC0jeMVsSjxcB
 /PRhfwvPnMg8xO160CqmWWofOOx8w1ELL8/BOnMWbTIZop4IJSXdw5MjzM2m/fIGk3fuimw8j5
 GEAHuRpcE6d2dRNQ3d/H4WmkX54QY+03lXIFNeh7yXBZn0V1r2gkBT81pRNyz8Git4s2f75ATK
 Vns=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391964"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:37 +0800
IronPort-SDR: pKFyybzJIXSIkh6n44Y5rKusBwM1nuhz3qP4az138Go2eciYmY9IXYId6tmFMgh3mPrMFWBU7Z
 6nZJgUHkoPPsgmiRLxpOO72dZn9GD6TUqKCU+3JxCnAZS/NSyWTexMAEvrClV2CrO2pxz0YYtt
 YFTxsITwpZ37yz48hhEaYR28ee8Tm26IXT1fVbUiBxX5wXj1bfAU+tNg2iG8huCloA9XffOdi2
 OjhPvRRrk16JYAa/Fp6vR43iLC8/Pma1UOpxsfksIRP7cLO+lZx0hn4aZgFu+eezPbAI7nicFP
 mWzlY1QF0FcXfhsrYL2Jgjja
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:09 -0800
IronPort-SDR: UDS69Jse1ee9ppUGBy3B1zkeX7Is60qzsKFoykFqoEuG7adwITNtHp6MicjFyI5ze6+AdBOTCc
 3D2UY+gZYkhIOD1hIssp7ekoOUZI9Dw1yZSBuWqIHUTELztOfrsKQoUet2OwNqcmlZg7kvuigf
 co7hQh7KQjIhrBxU2eYjkHpsx7Az2bmT+Unr1Rl7n1a4KyH7Z11wIWeu+tlVMw7xYN89yT6muo
 RLHbCd95gBWZfs0ss0qNz1K7SCdy7xOiQEJSvp2eY6Sm5PXenBrVClasDnPofcB9lBZWfgKwYv
 RIA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:35 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 10/42] btrfs: verify device extent is aligned to zone
Date:   Fri, 22 Jan 2021 15:21:10 +0900
Message-Id: <2ffd3693e8d81d619345f9cc31070cd98191c84d.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check in verify_one_dev_extent() to check if a device extent on a
zoned block device is aligned to the respective zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 27208139d6e2..2d52330f26b5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7776,6 +7776,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.27.0

