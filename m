Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2062FFC9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbhAVG0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbhAVGZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296744; x=1642832744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=217WurwqngJSQS+/uREeJ26E/Vutk6ZF1Zu9PxkqegM=;
  b=M9kmW/GGOt4BxXnEBk2NhyCl9F3fR7N6iF47siYb33YyK0Dr1SoA5ivd
   YbRGlmBlY68FBrkzBLj5u/qlkIV3nExMJmzN8S6DjOdCocti9qO392rDW
   OB0M/b227RlX0L0dU8KeXTHkCHt6oChyIgmlHYqAyeWHI+ZZQvZaYvh9W
   wmI3HnlZaH8Xw53KkC4hwAcF0fUFAFGFrAV7E3onxCtv2uLLwSmIoxvEg
   k0oHoRdKq+FpVEmuWLddLx/eFc57iLnQDfqBXjz9k4J6W1FERwhJ1z2N0
   l3YtTcjtx2tq70q6YYVsWan3k6nPvrny/wMl6Gbx30WLi2nxUmb4bWrPM
   A==;
IronPort-SDR: OI+lAVkGCjaj8WMTu8w1niPPl2zSnc9BmO1NOv+b+9BmZiu4z0hYlG1R/B8dZMONuqU0XClwel
 WFVj5cbp6AKAIbWA5U1tqkusyrI6gxqDcKTq66D9oXx0Mw7HD5wfTUeAPa50D9W06nxNxYAN+g
 2l2ddzC5IipP2RF05rlEoB7BQNDtJ2SWd8V3X1UeIH4JfubtGIZ8u7tQMdg5pyFCHIjFR1dD6+
 EHIwPpBslGA09Ql8QnnTeI84JNws2ADedt7p1CXlEGaeBFCOq4fQkwOLxn+mEfcHpyyN3pmNOQ
 ELw=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:49 +0800
IronPort-SDR: PKorHpQg8rdB8EBcsTM8c2YLIazLyVpmvvcf0IaGQ4vVdIZMcw6ZnSrEUjcDs19jo9xerdmpeo
 2emiDnjI1G2bbHDK2wJP+X7a/1rzMw3DN7JqIJ4cF1aYaBDhrxNIF32QayoVjZJGcC84/Ak16g
 7lYa2G2zGo47nD01D/LC0FKVlJVdTgGzJXo/YbaxSd1tgJUJYi7fBCvZjQQKBb/r+rUrnqEwQA
 zfcte99ruhEBWb5l7DGJ1UCtc5Hg/MAiFxMh/CelfqbeTZUYFg7dxwiunGbys+pxp6+OkK2br4
 gVh6MEQrSsjymTkw1AuOZAEY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:20 -0800
IronPort-SDR: kgBLsE8jkvybmSqKy1ZWt0/bO9v2KIBM2jL6DwPQbpX76GcUStrVQo57eI0TJixltwCNXLAHhz
 gwKcPuSFE+A+6J6m3uMMay8wPvV/kOlvlW6aRUgAUXJwiRyPpEfPTPw9d3xTfLC2Us2stYPA8s
 KhwFm5U+0u9m+r2wZWPdgEr4ynKSNnJPfy4pY7sZbq5eqyYiovgCLaeW2llgtTh6wd94OBTpZf
 DaGxSlQlr+Vn0eu9TbMItFEmpGPv0ep7ZNWPL9FTJZ57KWvXBL1GGI2k3WsN2Z1neehlL41qQf
 dNc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:47 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 17/42] btrfs: enable to mount ZONED incompat flag
Date:   Fri, 22 Jan 2021 15:21:17 +0900
Message-Id: <fa52ccc4bef980428bd3fe38bf96cc63d0444f95.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1bd416e5a731..4b2e19daed40 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -298,7 +298,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.27.0

