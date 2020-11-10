Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D52AD523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgKJL3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12030 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgKJL3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007785; x=1636543785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HetSTPx+/iWbmDorkK+6Niy9oo3oHMHL4RCyAkTV0GM=;
  b=J3HowSG7FlS0oH3TRXD9U0TqqwS44FEkkSODo2/63sbUS5Fkc7jdwCOF
   zMoWDsVeJsZAmdDFhdym/r+kofQndqK5uqbLVLXngk/kFzpvr1gDB2VSN
   wzwxYnHMEv+kKNiCm8GX8CWtGkcTMmrqVhTvJ67qgfPjckORdCKI3tgK1
   cTpt1kGU0sws5ZzPpB+Cp8OeHn+AcXcUHfg9lyGK/auPnxtoUhc4aqi3J
   9VTBXZqjOcOjyTWD4QUNtcRRkPM3wftVoC/ahlN2/JN7c3b8dp6b/iOxS
   MqkYNvYI8BGJko/UaoDlTx/HHDE1jBWD7LgiPmwOzN2t+jkK9UjfUMVW5
   w==;
IronPort-SDR: yI9z9omTgOzNsXt9YfGOg+pBbjuMLk71clO/gjyQC+/ks+83RE7NZpebVe63SQO4Hr6+05eJtv
 /MMD5jxLRhJ6KepbHdcQskEMbV2LFxPmub2nfAs6Y3nVVEH0i0qliw2BpAai+bVfzf+VqukhU5
 hxQtT6TxZGgpy6mw2M/10ulTZNosmtKu0lgMqiemU08W0vi5nS/ASnGcMaJxZsK7pmTunlMkE7
 ahqL4jAmva+RnQHcCBaiv8wk7HrPIoHmTOP/bR4JurBs5Mhojh8zeCcWwutitakyCtgYhmEX0u
 ziA=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376751"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:12 +0800
IronPort-SDR: jjGVshq6AY1TNMtxQobHumDbrbBIrcPy7El0dE0DkGPjaVZXuzETZqgx0lwIZDwvZ1CMLhegIi
 yU9XYGcAdtnplGwCShIVIa5XGqOOYOYSHwLS1Xi+IoREqCq0JI3IAC2tcZX5R/RRYdRYNur7F/
 6h7ETQoMLjWr/N9sMC7+FTtsz0CPM1eWP8klbjPJFU+nTayAbEBkExxBGJA3PcdLbPGiOEjP9t
 4QP/PSC6mK0TUH1TdiDbdQTNn/GFgpXp0WKT3o9dAtgYBofsQtVRlXHPukadfxBjN4hspg1eTo
 0L4kDQGTP1pSfLkaAHWUsFMZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:13 -0800
IronPort-SDR: dMJGR/j82JzHfEPDJ7iLDjyXhcY31sdScHrTfnd4a1qPvCylXcjwP2RMY1vXWiKVdaY2J6jVCq
 2i0nquFZ2lYDNu7D86P3bd46l01Oijnl6+87zfrBKlwNZGyCML6t68i46UbyHGQsg9ag9r72wP
 Yuau1S1F4Z2fyBDzHKrjnDcC45rWcMzEvcnOTpekZhKjUbQVGBRv7LC7AJq4+GcDvaiNS4h3y6
 5dDiSqvve7uvFMb+IYSvDzi+PYFfQola0yOEJytIVo9RHp07mS9FQXqhoPz9yr3rcBFWQihnta
 v/8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 41/41] btrfs: enable to mount ZONED incompat flag
Date:   Tue, 10 Nov 2020 20:26:44 +0900
Message-Id: <9792b90dd95d44f86b5ddc3e25373286ec9fbf04.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index 2fd7e58343ce..935b3470a069 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -302,7 +302,8 @@ struct btrfs_super_block {
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

