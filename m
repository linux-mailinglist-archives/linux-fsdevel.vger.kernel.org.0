Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D322A06DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgJ3Nwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21982 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgJ3Nwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065954; x=1635601954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s2KKkfnoTWevfkYQvf5DwhYyLT6JaMkKfA2n4Tx7U8Y=;
  b=hgwu2ZDW4U5TgLL7IVtbkw2VIrtpEgQr/9PO7qDOJQNWvCbu8y0JV3E9
   xntNIhV8i2TzVr+/ka9k0eDak0W9OFpOV/UhDkT0la/9mJumiieGkFivQ
   luUlwsmcGpMpNLY3vrLuEY2WEczAP5deeekxJsOjDjdis/E3h5zrvJNQ3
   KMBGwGx0ZlGnbzRzhppMa2JLxKW9x6K6/JQBMZql2CZCcEvlaz4gYBV8g
   tTkOikRoIEcvP8aWgNowHoTuZJ/0ChPkxsP4Vo/vXVVBK5JlR7beoCowG
   vZDQ0sQ6xElLBtEMbubjdc/6AkcEM8OwTh+f7cY/NOGM0BcEREfBAkqii
   A==;
IronPort-SDR: RgMDPCtp7TkTmpDiV+/fcct5v+x6A1MI85JYo3uB1W0k+lCCjYvjVLItxF7u8kWZaBqZ0siVeq
 nAQS27HYMkcUD8a3xFzjN7Mak3m8/Mvv9msnBoRKjLbwl/SLSEBgTZx/PXC8udiSN4flfiGuIo
 Fx+ry4qhD2PEgwSBM6MhDuTRpVkPG0InP9HdTeKNim5N4XTHhkUpnQ7MQyPFa30GuY5rhqhYR1
 dvwpCHKjrCIFHZZm3nfQGY4lubX/teErZQrzMT0vYJ43ZvBCzrOteK+e+MNcT9Mll/IhW5ZALp
 EC4=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806592"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:34 +0800
IronPort-SDR: 4pzZvVT/RW88te7AnlWzA5mLI3VCsEy7CAjbI6tH526qi37n9nOsMgZxalPl8RWpH3ycBFZzOR
 nLbdCNpBXTjVcolQawSaFZRFVPA01UpMYUQCY1ErWf+QuypyuBHuhoqw+vSNqZemFT+05wjZJc
 EzX7JO3Y3MIUAt/4QN/0FT97K1PF8obdGA4Q6vwZbUEDRIkKQZhDQjQApPgYtv2IfftTWYBdIc
 poTr85UJ4V8S7kGbD25Hyy49R7cHy0gthc7Ubzlioo5vjhjf6Ht8Khh0vCZnePBCofzcLfoq6+
 4pjRxBAcsKXgnwaocyjPPeqq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:48 -0700
IronPort-SDR: 4u3PZhFe0LtRevulN/Cm+mk2sK9MsHM08wLLo8TmtjDd1a4eldMLqi5Ln4ZophLRGlisD28TeC
 35lapuvGfsP4Vm7UsmNPX/5Rzufk3EFvA5VGmfT0EcUHhyRuX2Vk9Yj7ImZbvXzfgWJTeutdEa
 mtWClCXVyS/kMjdammY6+VYV0MmSvGpR9947qJmPU2IOmLKtzfe93hGW+QU7YB/d7UFd+Xrgyq
 040IJB5Mb3TnkY+RwUwexWSqEmnz2dp1Xu4aghvGPy1ZPrhMBpRdTbM2XoALe4qbpp2BPW/Aqq
 Jnw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 10/41] btrfs: disallow mixed-bg in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:17 +0900
Message-Id: <1aec842d98f9b38674aebce12606b9267f475164.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in ZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with ZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1939b3ee6c10..ae509699da14 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -257,6 +257,13 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "ZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
-- 
2.27.0

