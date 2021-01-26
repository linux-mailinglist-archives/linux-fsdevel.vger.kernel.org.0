Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5524030496A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbhAZF2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbhAZCa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628256; x=1643164256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9+/RYxer975SEcYFMIh/JyuK33yUpWJ6D9D8jaz4oI=;
  b=mbyD7E1yf9PS0DJh8+hWFvNCviR3s5BKyY2WJUd+Ds5IU7Rd/m6KKmkb
   gag3C07x3FhZbazYTyhpfTlqEbRZl8w28YFQyxQlCNC2W657i3CzncQvV
   eAOFVjlcHc8uDPJ3Q5zx33547tkHWcFv5y4JUmsgNGaiqYxHNzpHlnzW4
   myBv0oIRoIt4CzJyqqY58eWEkVYFKWOzTyIRtPyCNxHT2DRkxq4yregBr
   rr4uR+K9ndLaOq16NbexXLJXdyXQusbpthFk1qfVaIKYVqRskk5kX7XmL
   zXTVhSLNyXEhvk750qw6Vvuw5+f4jh63oTAw6tCcdm8P+T7ZZgYwK6ieS
   A==;
IronPort-SDR: YXez0rRuSon1dQpnoMmLxsxl4HxpsFzkKRI/hRtvGyJ43Q/efJRxg0RGFp1wVo3Pc4N0AyoBhI
 za98K7+rCxqI14h6nEYMhJjT/i4UGBsT/gIQ3c8IcZkxMZ8msFPPv3Fi//LOFXIlvIDkFC7fV5
 OejSpVIBv44hYiYLq958NwPl1Qr8E+p+H1LYw753pIp2ps8KIZon/DUWuZOXWMmo5arroYMlrW
 S4/BQeSlltZO99U8enM9xmOLK3fA8QD8jBvCUa7inW/RISwqI3XM+yOSugWalzQsAwwbe7FB3G
 sIk=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483527"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:16 +0800
IronPort-SDR: I2j3rAKs6nb6FXgP7hsckdjrlGwCNFLh0Ex8B/gm7e4TzVqPMGjU9fe5/RsA0q3DS7G63lC7ew
 mHfcrBn2dZJP4Snc0WZaalPg5LK6S7UvfbKoRN/7a86c9rdPHK2IOsDBeQHUzYHBMsoqESJqeG
 GohFOE1M3Rq9k1dMRy9O9eAj+wZogjl4wnhOLtdOQblH+5Zht1oloV0Xqw2nhnEi22KmAnY0oQ
 uMj3Ak5mjTmZoqe6hsQWnRPzIJ6PqNEnBXzxiS5kmKO/3+uzQORimioxli0PqlwaDx/JTngrqU
 JZpEBfKWOguoxca/m4yuId68
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:43 -0800
IronPort-SDR: SlR6+xEbBoUc9pg8JwWNxwArKL62RgCe278VD2zmwa+EJNnblS88Zi8JIxoYj8cxL3E7p2Bcm5
 QECfLxL70SKpRhgELSbTw53+GjzyL6LutXBg4ERqyH2te9bh6YmtwtjeTC3q2tuJiAtqXKGR5E
 2/XUIb0Nigu6roXNCXlDN6sGz8g8FlmKz1KuLgTp0VY0FiJzkYnyHBwJ1yxwCP0g/tW4yDYtCB
 uTvPPDpkF698GMdTsC0ylBqBcQfbalC+f3ehLWec0wLXmRqmQ11EuR5LFqDq7+/OSWmmezis5q
 SEc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 10/42] btrfs: verify device extent is aligned to zone
Date:   Tue, 26 Jan 2021 11:24:48 +0900
Message-Id: <12cbdd4b2a2d144a5053c93d972855d8bccd03cd.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

