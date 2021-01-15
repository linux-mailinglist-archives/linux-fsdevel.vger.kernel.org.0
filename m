Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05582F7326
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbhAOG5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693867; x=1642229867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tH11szVcdkzxaEsE9Bv8s+Q0+RrZaKM22QEuPXRbkE=;
  b=loCYuM6ts5bAvwBsYAv7LD1/JSnlOwpvC0+2uVX1ii1K/S19AJ7nj9ZP
   5JQ1q7+B7qeQQ6p+nCRr+zGEWU4RHiXYEGHzshLRIumpqWnRzNFbIvgv/
   Atf5EIp7UMY6gSiE9KP5rcsIJFELB6fMn3hNOCg595AlX3ldJzXNQsINE
   zmuVvslEWbaToSDbkq/zIpKm4tKMZy294iieqeJRBwcctDUqGySTGy1Bq
   XqF4dVk/QlFc+5qlsiN1cel7kcNVZ/DlqmlxVQ7J6R4G++1CkM9j4m60N
   2dHkOquHoZw3F9vrD1N4WG59aqpm3FEt/q/XDg2P3BmhS9NR5+qOEMk4D
   A==;
IronPort-SDR: ZWeBSIjYSgLZ8J/4BM2kaaaAfcFlxoH1sKMwN3ocN7G9/onc8K3uznsQZKQkPLwOZhNA44y9ty
 zj6SUvZZd68NcZxWaErp6EW2J8EiZY5gARMkKUxqRJSYoOKrTK0TKAZmJiiYi0DHlueKLc8HX6
 /pwseumIx6BvbefSRMi5t4lAd+wmrvaT0eKg7Y//IffLWeykEc0uskWymRlGy9scXkZ8n9nqno
 UrFt1+6eE++QNyG6P6q2B03snT10ZabKKAQkVEzN5wJg7+A15JYM1xCvzHRzzpcn4hADcUeOfh
 QLY=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928219"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:25 +0800
IronPort-SDR: +FDLuiFvLPldvs0wLShCWo5G62p0KqZEFcX7uLzn8PuNkFrYDvqwNwKBhFc09a3hoikXCipz3I
 Vjc3VLFl3Mvnggt0kfGChLmaHg4JJtl85UJmPG5UW3/GBM1zZqvFu4MDjGk3KkO/xaS5TdjkPp
 D8vDA1S5J72JKgrqIr6lidQLjXKeN58vtGhYJUTVpLkemBr3ZsviI6nCW55vglm1IdIDfQP1F9
 NhPIJa/HT8ux82XnMduWTejFAdSpMVBk4qZwuooCTAW6ntfi7jsHeCYafljuoONfxgoDz/RVzs
 HojVNhCwiTjULKn0WtwVydk5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:07 -0800
IronPort-SDR: gHKaSFbQ5KzJ6xY9jEm6WD3G6ib0XtWLUNPqZz333Pfqz5MiK5KSub22i3kAGEst4gf6jmlhRM
 XnkxzcLGOuWWLIwR24cPeMcQiC2h5z3MaMh1VK2sfg3C1LLnAXZRo6BnZzjFVD34zTxKYGQLQD
 y39+mMaBcfm0X5qT7wfr/vWqcJBL0utm9vb+OqP5puCl4JghruYJF33uYdNgLVB/CAQH/+BbXS
 CdZsWVzErXXH0GlNugcFKj3xXvigYSE2DCAi5D9zaCjfct9sYLn+2dvkQWQkT7Jh+ifARHAsVT
 2P8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:24 -0800
Received: (nullmailer pid 1916440 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 10/41] btrfs: verify device extent is aligned to zone
Date:   Fri, 15 Jan 2021 15:53:14 +0900
Message-Id: <bb7dce4754dff5137deb9b7b16de2852f9ac794d.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
index 4f02b570736e..be26fdfefc8c 100644
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

