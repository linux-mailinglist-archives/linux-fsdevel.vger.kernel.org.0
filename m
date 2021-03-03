Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8132C523
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhCDATW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53180 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356764AbhCCKsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614768500; x=1646304500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6ImAg6emvQmJv8zhWVsxpXCRemcjfAsHZ2qZ7dGbPg=;
  b=BcGmyhco+312lIDqQuBkGJKDZJQQmtMp4sl5BOYGRLLo92kIBM13g9J/
   6eU6O5Iuq0vInE8K4sU0RXH2INXbmAwDa5fofrxCIoYtp8e/YAlGcPZQr
   KZtQ1nknxKqETH3BUTGEPCxViTx/1YJZHkwLjNn3/DYjgWX+gdj6aCVUY
   5FLWlQPrRTLvAQeCmcMFswg5aAMi+AXBywpPb3D8Z+GjptkJOUZIlydFn
   P5IXydfsF6B8WrxXFJVU0jtg44JLCvMEJByXh5uY/WloYgTXwgtX+v3c+
   7bmL7Fhp2MKeo5IWGC6fh95Rs/Z40dJL3WN5p1Uqpfv+YJhCfDl/IXsFF
   g==;
IronPort-SDR: q7fmtAaUGHpsOiaMt7kBT4OrTZeXZkf9NbbWSJjjYDSUrF8k1iAocZTLKjhlJx35G/C5HPqvPU
 Ayj+3J2iVuXVop8oklhaGWFq+TfoQk2GTAhuvqJp44lvE/4tk8OBTlA2W5yBk8sQ8UWZBj3ua/
 rZMrVUd5zFOBKGeJqJwlWhSeTPrfHLpnajrpBVdz0jVaCiFsbAbTEU8FH+UzDLpdX6P/xKjTes
 bDhSHeQLTGzdLX4PKU2193uJmliuS9v7BILKzAyDYBlSxrItwFnjJg9YuaPdEmUcy/qHKVBDPC
 wRE=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271857768"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:55:54 +0800
IronPort-SDR: UZ6+B6i7DkX2b29PKy4+TzIle9Qim/0gIGVWimah7BZSfe/1MhGfGvdUP77pAA7uz9mvL408oR
 C0XeVF1bNoOWn/gG2kSAHECh++k+T040ynhIwKl1VyU7mPgcuap9543Z4yVDn30f/k6Fgzbqqd
 B+i9NA1Zr0DnGw1UYdWScaSpMWIfzDfc6hK9vDiyPEdcPgxgxnGvoGkKp0B/Jj+Ig15BLariu5
 zesEpy+D/CxWPn0044KepbpasrIyb+U0S9F9QavS2GrTmTiFc8tqzlNIFz/UHvYwh/YZDiPl5H
 RO4NoJ+4sVzR3f4L99HtMX/h
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:37:09 -0800
IronPort-SDR: AcZK7KjqGCFQSlCRBsi8M9LBlj02tVGtu4hgm4vHTWat777MVgS/BlbiLFWPSqchkwbLFjCztT
 jBVuSCJOJFFIG//jwpT7eZXXHwF3vZ5EHfiDBfvecuiiFuGPL3Oe/vM4L65qRpiHCpC1Ug/UVV
 DAdTggdicLSggBrlJF55PSZTq5iBDz04Ld4NohHhsLwSwVyr2IqlhJvi8t4len1GkUNZ6uZvUI
 MBht5Ep+xxCTtqGoQ3gkT62hgQ6Wjj3XCMDRKZV9oVJBHM2JyMdMmXm6QFyX6TGycxW2LcLvdW
 f6s=
WDCIronportException: Internal
Received: from jpf010014.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 00:55:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/3] btrfs: zoned: use sector_t to get zone sectors
Date:   Wed,  3 Mar 2021 17:55:46 +0900
Message-Id: <8068e2e54817aff858207101677e442a21eb10e3.1614760899.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614760899.git.naohiro.aota@wdc.com>
References: <cover.1614760899.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to use sector_t for zone_sectors, or it set the zone size = 0 when
the size >= 4GB (=  2^24 sectors) by shifting the zone_sectors value by
SECTOR_SHIFT.

Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9a5cf153da89..1324bb6c3946 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -269,7 +269,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	sector_t sector = 0;
 	struct blk_zone *zones = NULL;
 	unsigned int i, nreported = 0, nr_zones;
-	unsigned int zone_sectors;
+	sector_t zone_sectors;
 	char *model, *emulated;
 	int ret;
 
-- 
2.30.1

