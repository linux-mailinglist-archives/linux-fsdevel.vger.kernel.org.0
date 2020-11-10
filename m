Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DDE2AD4ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgKJL2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11954 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgKJL2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007705; x=1636543705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eq53qh42p+Y2mSsc6rtBdbwPxpAi/ndOdRmRcNutkHE=;
  b=nSf/p80nK1JFILDRQnX9qZpR8kEVVaj/8VWhs+RSNA6zW0ufJ4HNZCEd
   vLZyN6oNE1JrAAE0mdp/+xDG2PbdPVOIVA5z6YTEsJTucJf6UkGRoSRIM
   99r5+Une4PCiLbNqSvlkK/gkgBsPCwLtefZA75BrHWUD5Z0wP10i9ASG2
   AmODRDIxvmUO8bLYfnMMF+cFf+0cdjOJ3PPiAtYKJhNiIVfYQGG8k6UJP
   em7dLcYZDLwZeWVf3stZRLVOP7Pv7SecN3uiHJ3fk7xLzeMzwJOlJ/SQE
   9vwDFajmxAdbTTtpGxEOHcl+ItMAulcUedpkl11t2njWWnh+ryKdDweh9
   w==;
IronPort-SDR: WmTP4HLy4TpPkNcB2uHzKx67MtBCpwjebFzYijVMzOz7lrFtyC0hg6+LudH+c/Mn338hR8jU0G
 /GNfW9WQcKu9veKD5S/dmKNjvFWb8wcrDouaUVYrw8PWHop1mUyzG1PBvxPtB6tXL53aXQSTEh
 1wKlqqT7Ir8zKFKqrbCN1x4HUL0yexGwxGki69065j/9YEgn/wwrt0Kwbq4HTrnDsrQFkou0TA
 oiHrkiTiME3KjkKjtcY5voL4rOHPmJ9qrrRTw4EnE2Q2GudUICYV8NOVTEREMQe4tMkVfoHnHC
 PV4=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376447"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:21 +0800
IronPort-SDR: zrR9Ns92DsjTuAu8zvTVjYvPSEfsQ4as7dGxYebOnOo9uhD5/tXH6TprjPTiAh6DFVgSm++fC8
 mLRl0Yw+DKlL8K0AGX4EURb9EdbPKwshnNRRdxIzCQV3YkyFkfKRYREbIklY7hKXxli/nHbtzJ
 6hWGBC23JbYFb9wuwFleFX/nWeaqez1PWaGowy1LmbU/WFwy/SbrefxcpjFGZ1QpXOEcmZ/L7e
 qDXn+DQbDBbk1FWPHmgmbD++AEWedHztkXoxy6ULEYbbVTeZUZzmm0ne69oV30M13sJpb+wRXH
 odPhQ8OjjSHObZYZHlGwBoem
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:22 -0800
IronPort-SDR: gslDqKU3fWXTJiMCIOxqMKivSSoDBgD8eqMwVEsrF1zT46lmNXLCdYMcu2Aa8s8aWkbSZGYEWK
 Rqt2J2D21V+KM9u4yxPrJykSUEQ3R2AY+VwFPmEt9tiOsGFdrV2Y/qKo8753q08ZcZLhbidlNs
 4yXYPMbsJNTuOe8UO+zwiEPz2QgnlhS6LcWfZd0Nrmo7DcZMbNZLASoJcTFz8O7hq+EiDYDUQK
 RfaHXHsfb+WPOfpqlo1IjJvZxjZSbwcPfvmBv4EJ4PxhDszgQHtYJT8WrPMeRlO3fMwCKWhTFR
 Sf8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 10/41] btrfs: disallow mixed-bg in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:13 +0900
Message-Id: <b4cb1394eb65fb4a28fb5eb18e905dc817199272.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index bd153932606e..f87d35cb9235 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -266,6 +266,13 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "zoned: mixed block groups not supported");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
-- 
2.27.0

