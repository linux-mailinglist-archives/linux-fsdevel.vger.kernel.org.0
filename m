Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11082F731D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbhAOG5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693838; x=1642229838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLqJJprYlUuRZMJFVCLH3kU4ORDHfyDHPqdKF+CpmbA=;
  b=RkyUMIy+j/aVDtf1Tgff4ijoKwSh4rAq4zOILldR5RMzPDRx3FhdnR8B
   clkz149gU92zLHjsJjfeJFLDfv3yn6IHDy/PTwS6skwHJqHxiL/4Vor3m
   3BdKX1e5n1v5OlIgCBCtrrgmqUGhEMaTtLU7TBtUJR1V+LhttPDtHHySu
   q4mjRnNtygIfUuyPOdd4fCKfOAp1SLWXdTk2kvqIcqmZBjY8t5W4+fNSv
   5q2p/vP/qXzfW79wusCL/R53aXm7vaOUNxVW06H/KRfG+dWY25f3RzGOi
   seEManyl0HO1HL9bijWLppJOuiH93LPat/iF+rVUzQ29ganb2/KYgiiPS
   w==;
IronPort-SDR: wN4dOEd6eCLwMH4qA+nsCjaYZT2d7c5s83ZSWNVoQaO3vsbPWNn5muQNLLwEqSJA6x7j88GHRN
 KHSzxB0AANENEEJ8GyptmXcSkwYcOaa1hgCD63UKhSFaz7v0PP5CFzSo6N819CT2cU26Xr2DVS
 f/KkLXv263BHoCrSCtiN8ssXSH1yqMIks2PGevIv6WgnxVVZaCg12Ozp6Q8CBOSvpxvR2WVGIe
 evGKktNqYyhoK3BKiRUuWd2Q2ynB2B5szbhWyDSsH/1+RImnz9wWrIKCWGydInfexB9hjAXEOx
 9os=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:17 +0800
IronPort-SDR: QGlkErlGI3F7AWJfN/SVgo0Gr/5Y172+EqQ+rMBs72A5yWK0OUiC9uAORffDGzWQV5EEroXt0I
 wkj0meG/5m+TKWYnWviUm4CulZUNnwrYiD+yAjioLEKu8GoKQbtsyOpSpw6Ya2QzBBEDkqJ+oQ
 DxoPF5+5owMZG04MfznfJt2pCIzJuTAIor2fQdzRFLUKSeHfd8sCYy18WIxOcyyvhUxTvx9GqB
 VzH2xApV4VBf54Y7egTgE0Ealipvh/1qfOwAXzN/E6+aqYdcnypo2+Oiz1yVx/IBiVsD8kDbLl
 gZ0b8ZI5VidWsygmnXrFX91A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:59 -0800
IronPort-SDR: Jbld1S1DOjtrInnm0zpgJ4aHxFpSKNdzXhl0d/+wyolpybo2k1yqv8d2LxjOtqqBFezv2DjZAj
 /cWPd2uDT4hAd7eAyK52yrk9VbxsVISWeh62bOxb8lG8JNQqn7IlGVBuhzK/oWTH9NnH1BwR9O
 N1Gm4lpYI/jjQHsPY2n4T6TG0hKtBimWVrdNqRuHoRuX+5puIL6IMwPiruDR6ymL2HHNqz4kWU
 h+x9gEl0JdQY3b2Qyg3NBif9w7sDKXsiaLnukRCIxILDhGiA7q57jYGJmS4GE/0aQJVFiHn7h7
 3Po=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:16 -0800
Received: (nullmailer pid 1916432 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 07/41] btrfs: disallow fitrim in ZONED mode
Date:   Fri, 15 Jan 2021 15:53:10 +0900
Message-Id: <4f14a1ab8ab7b9ed558404c6b3e92ed69d4054f1.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The implementation of fitrim is depending on space cache, which is not used
and disabled for zoned btrfs' extent allocator. So the current code does
not work with zoned btrfs. In the future, we can implement fitrim for zoned
btrfs by enabling space cache (but, only for fitrim) or scanning the extent
tree at fitrim time. But, for now, disallow fitrim in ZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5b9b0a390f0e..a7980c20c77e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -527,6 +527,14 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/*
+	 * btrfs_trim_block_group() is depending on space cache, which is
+	 * not available in ZONED mode. So, disallow fitrim in ZONED mode
+	 * for now.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		return -EOPNOTSUPP;
+
 	/*
 	 * If the fs is mounted with nologreplay, which requires it to be
 	 * mounted in RO mode as well, we can not allow discard on free space
-- 
2.27.0

