Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75049361805
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhDPDGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:06:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63380 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDPDGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618542338; x=1650078338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQ6+wwXkURXembXlQMNkynRjOBYDsHmNyV1LL8+afz8=;
  b=fqkP3td3DpUZdTiIHlGI7oPNI1F5rZ9HgoDUkSfdSEu3CZobsMOUNlF0
   qwjYLYD0gxE3P+kPe22QBiGbNk6eN1XBlBrc8erOjSa8dQYdDrKbKcw4z
   av7uw5TDBAFy8gUnRxwIYdwMsicMnqc92aIL0oq3g9jIQoHP0yC6Y29kr
   SeAFFb7ob5tlPKD8Q9Wfsgz7gnyjPQo0dv5YUT+CHpWxMMMO132/EDGZ7
   ieAUh2FKBQfnJ+nHppFxslNUH5O6wsvU9ug3+tplN+faO2bfiHhV9vpxH
   ATEubWmeTQxNRTE1d3a9hXuAL2k2BqlcZKzTiCx2Rcpr+5QieQC8skTL6
   g==;
IronPort-SDR: ubaeraa/y/oGwdXcr44I2Ex6Lmdf9Nlm9bnqBZ0zDi2haPBjK/3AL19FAJ8deckj1LhMzPm5fn
 GypBFltnTDuM/jdK8bkXiImtZ5CG8EjhdfcYxuzeZFH96PXmcg08BRz3x0dLELqPsyYX8thDsB
 rLqSJz0r/KsiZZTgEk7Y6TZBJR+oZ9jyS51hLwsL8OXRou98ILzfPgP6fnTQSNiLyRXEQ51Rfg
 CZG/O8uWC0dlb4NseEDuXrEGn8yzolpr1znVH3kJm4jkODm4B3KjnhLf6h98Pz66txnHmCWdhc
 kXY=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169567895"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:37 +0800
IronPort-SDR: T4D4eMzl0JlQKHdbeIbzthfGeK904rX+zDMhJvMqBXRQhdDXHoYVE+061Iw7LpQItS6tw3jsI8
 K/bHniXZ7JjiB0xI/Zkn8BlNwWt+pBA+84IwU89PMfLtU5Ytc+fCQbpMrEb/4fqmijha2dzEHk
 atBWFtCwgadNXxYjgRDfzQOEi2MFmaK9l5BOxr0PbXdRPJ5terNIkPrNVckOj19sDaa4RziANO
 F8F9VgWM3Vy/A9LZdEAWb3OTneM2vpj0obNRf4SI8B0BbYkUN/SSFwy4+GrHgv3uo65fvoZmUn
 IHZp/rLjxpj2A6vqNSymbRAV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:44:56 -0700
IronPort-SDR: XeFcQprEuAFYDJO6DpiQxcsC7N+LCT2SR+Mu5LEf4Xaflth/DDQwNi/0LW5UM7TnbJeuRqTSwF
 A2caLaeVJPDIYpfpbqPdd+zoeTtgjcmwbGRtXPz+zFA/vSzLCL5oDZB1U1YXfv4rUoljrjQEml
 /GhFt+gXWizqvsuzIuD6xmX3mwwUI6vOaANrC/xXYqaNcz/AyDVJCnaZPyBki04K2v/eRMhvDK
 QTOVUkM8S+NS7fijSsafqxW0t+EdNdG09b4gvBZhddV08G/EQ+6pPc6oENmirSES3hRM8Xy5PG
 Eqo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:37 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: zoned: fail mount if the device does not support zone append
Date:   Fri, 16 Apr 2021 12:05:27 +0900
Message-Id: <20210416030528.757513-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For zoned btrfs, zone append is mandatory to write to a sequential write
only zone, otherwise parallel writes to the same zone could result in
unaligned write errors.

If a zoned block device does not support zone append (e.g. a dm-crypt
zoned device using a non-NULL IV cypher), fail to mount.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/btrfs/zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eeb3ebe11d7a..70b23a0d03b1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -342,6 +342,13 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
+	if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {
+		btrfs_err(fs_info, "zoned: device %pg does not support zone append",
+			  bdev);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
 	if (!zone_info->seq_zones) {
 		ret = -ENOMEM;
-- 
2.30.2

