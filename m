Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35F2AD4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJL2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11954 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgKJL23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007709; x=1636543709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/wCGnSG/8q6cq2UEr6gw9asvw1dGZ/c1MPBO/Bqf7Y=;
  b=WCXpKJn9R1E7CljgWE1ZLn6yf81eA9/ZZgNgdbZ2yroM6LL2Eiw1jC7M
   cHyALpkqvAx985vSoR7Njm8glUND0IUTojLPSqSzF7mZKioHJQeyn42hG
   8Vcn7ylzjKofdRT+4YKJBwjB73Yn0Jn3eWDrdLEwqo0+9VFmJMWQol+iA
   4Jx2g2ehVqZ0y5dVPO6Jju2oHxmXQYt9dUG+LYjJ+rrx79LZC1SEkD67K
   w283rNrZYkzwJtUDLXjveBNJX2y+6fb4bMUQ5XC7FDEYIm/fuWUkSm1qR
   WJDAL+NeMzcySHUFQOu01keLVXHwsUed/nfMtgI1yDlNmnPiqs+iPo6Or
   g==;
IronPort-SDR: ktZ37FR1mA1Kjx8DNC07H3R1JSq3tcEqbFhCXyUsokt+3FhAWP9Me+PyCkVk+YwFU7yFuTUmXS
 BgaSMznSvIs7zoN9Rtjnd8T2C0Ui0dKGrIL8SXqceMvvCMIUO+tgPjurWdPnb7VuQRTfPRNopn
 u3bB219v4VI51q1SePsj0Twf3uF7Z4DNEBBWMNH3erMlTNPeJAVb8gr1JCPZp5/cVBPMkpiaLR
 8gZxuVs334BPElNiHBh8rNYJoMWVtGwbct6akivV1Hox6ECG8oUy5Ah9dGUae4pYqhJ6ew9fMb
 1H8=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376462"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:26 +0800
IronPort-SDR: Vqbywq8H6QSupN5bPwhhB10ZPjNmzR2wHeGilLVQx5aD/OKmmSyK2q1DdBt3u5sQdVNQKwe3VJ
 YL5zUofzeq0I+hYAIqyuGqXwl8BouUbZ0HvehOaMBY9Dd0Yove/vCYVrpk2q//npmmo730nfts
 fDU4oVPdEfz7N08dMs1ipNY3a4lS9EYfsXo6l6io/2wKgCfJfHX9eT5rq6X5mJCOf1cZPXdUT+
 smY0RQBZRH5IwDxGo9nWdvZdxQ/OZ10g5iBZlG1kJXsyYi0MlHjacKICOl0RiyEYZmGL6OGHhD
 wa7pdupRSGiE+KZs2zUoRvxt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:27 -0800
IronPort-SDR: rtHgONUiG9HOA8UXCoAZeEy9I6qO6CuGTTsHCDmuifCdGYwbd4kQbp7kyqUu3xqoltNzBo8A8P
 rVuIZyuho6FAvvu32Qx7WejA2QkfigsLQHV7GSTFgb5rRTWL2PktmpWmoqn4xeXXvuEZoKcbLo
 HJdFn0k+2FKPD0FMbkVg68irKaDEX7PiMSAB/+o+zlpzBNueatIcMN5WnBz/9aSQYgCkU+Pz62
 2tFjvDc8R9b102jRUcwd/86D2slSa6qjXlcR74KCInw5Dca/MDU3JLkS+t9ypZJkVNpwLiDbNR
 8oE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:25 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 13/41] btrfs: verify device extent is aligned to zone
Date:   Tue, 10 Nov 2020 20:26:16 +0900
Message-Id: <f1cfa63dd372df107ef954e90ca2e58b2ecf0a67.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check in verify_one_dev_extent() to check if a device extent on a
zoned block device is aligned to the respective zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7831cf6c6da4..c0e27c1e2559 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7783,6 +7783,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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

