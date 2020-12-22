Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97A92E04E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLVDwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVDwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609130; x=1640145130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTqmR39NZa50+GsSfqSXeZ5uEGvutOxJFpJGtFeS/S4=;
  b=BOZZMZxuSjCvdnedQY5OUJhoAXIEskHBS1jP0mvbolTbLArfrhTPcXm4
   PzPoWUvDA6DHWALNCV7b9nVLfZYu2BjuMW0YmodFvVRGJRHOMltr+34+3
   YTwYRNOU5XQ54qxbR2JAXAwc8nab48zZHEs5X7RxuMRAHlo+m+SGL29zQ
   5emm0hQ95KbQ5xRr503Tm/CoQM8JQoIQdQtaca+gO8zbVh+LKcyecqI23
   4DjULeVc/DjktC6AkC5QMKkOZA8H6a54QiC+m1djhrrjR7QLaJkkW/4hO
   q0FuVApPOpT1XtU3eBgw5IjO8fa1I447tMcXCrzElN/czpib7p4MhPWWW
   A==;
IronPort-SDR: RaUArahMfIIg8z6A/9nZMNthCp6hz1XmzzPcXsngOwXi+1KOaUQSeNmVUOrobsVEoEmwvaB6PD
 xZfuE4MeDbtBfYLe34PA7ANdbAtyuy2U/wviPvk4gDETlrRwF5sz3emE/REtNZPT8w1HeZBmlL
 lGNwx5XDQP2oiWtRrbuJdXHgeCS2nAX5/9spFrvDNnKxLQHCBr+3JcSLb8RnvjeP01js2s2iNo
 vDSvyPg7Y76ynacOLnCVEpULGHwAaH1ytEpBap42hWbV7peCFiviHsmmNsReWRy/Vq9rbVQvYy
 tpw=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193726"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:30 +0800
IronPort-SDR: am785JMzsy2sn2Xt+ZIURx5f4S8Lzgaa55V6Jo0etJ1WGxpxJq3bvgKVY8e2D6jgS43CMHf0aF
 gJINKlHHo2GjMQW9/Ux6OCgKzXhXxGgCKqeN6VfER+Z/vnL5RduwrHero3GfO/6LDNTiRxxOHC
 /q0LPidKeZ6pIBLqUv52fBOxbYiWUZXRI7+5mswGP+CF1KSC9rGdesyXjrujSiEpzNO/B9h9RZ
 A9WliIADCf9oULO+vHrKAfNZ+kr9twmkjLfkwvuyB2DrPDT1xTStJkDxoKoT2a1xGR2mJH+Bdn
 RRuNGNZ0PnSccubrdb8mFgVE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:41 -0800
IronPort-SDR: 6wiUSmeIcDEvmdV60XHtuRQNMjVfVf4BQcPR33cWuDADig5khiS8YGYJJPXW2ll6L6NAhV5scO
 kukBiEQBAAAznuVqP3y6O4Yh4+BsLWv+qDcsEc2s2PDx6pMtNmQXUlmFehTc31WeWbc4ml+dKm
 As4R9cKULXvDgvYBi2dT696U02LufEY9yy1sK0CzgZ7jLeqdJrhygpTUBfo8NqvtV5XiTHgTUS
 Q1z8bGv0w/us4+2+ZqqiyIX+E71NA4Cr/f/wXdPXVpnV1zb6LvyVtkOShLBfsTJ6AzWkV4kbV4
 XKw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 04/40] btrfs: change superblock location on conventional zone
Date:   Tue, 22 Dec 2020 12:48:57 +0900
Message-Id: <42c1712556e6865837151ad58252fb5f6ecff8f7.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot use log-structured superblock writing in conventional zones since
there is no write pointer to determine the last written superblock
position. So, we write a superblock at a static location in a conventional
zone.

The written position is at the beginning of a zone, which is different from
an SB position of regular btrfs. This difference causes a "chicken-and-egg
problem" when supporting zoned emulation on a regular device. To know if
btrfs is (emulated) zoned btrfs, we need to load an SB and check the
feature flag. However, to load an SB, we need to know that it is zoned
btrfs to load it from a different position.

This patch moves the SB location on conventional zones so that the first SB
location will be the same as regular btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 90b8d1d5369f..e5619c8bcebb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -465,7 +465,8 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 	int ret;
 
 	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
-		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
+		*bytenr_ret = (zones[0].start << SECTOR_SHIFT) +
+			btrfs_sb_offset(0);
 		return 0;
 	}
 
-- 
2.27.0

