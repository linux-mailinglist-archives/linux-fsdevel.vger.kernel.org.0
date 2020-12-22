Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E932E04EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLVDwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLVDwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609156; x=1640145156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DLMsPpwGaiGfPa+b5F7+MFUNCdl+ilE2MdGK45Nr0fU=;
  b=a9mHmFuH32LUBk8K64oFvsOnFxZ1ll/TWZZHEYGP/BSxr9Xc8uq2jYJX
   xrOX2QT8rcFietbH1/CVhXzbrQJZu+9DV4/JcepJdaGQo6xps1lKRs56J
   tmJ1aTaVTpzh1IWXs0v/jiYeB4c9AbC+Mp9WsOdmnM+SHNr8rqIMV0hrX
   gelWbW0f4N5ef+u7M5eOthsMRfECNTWgBkap3A6ZUraOWk1fgKcWgSGyh
   34iwOGylKCSqYEqse02+lf67dy2uxpm0ecdeQxe1r0ghT9JnV/hJXeTSo
   w94dyRSKYFL4aRXx/GXQ2xp/VTxyake9+py8gt8NSdryeaVXCcE4zq+nt
   w==;
IronPort-SDR: 3Zsk7DEAyiOFCuv/Kut2hh+ITDTUwPFUx7JH+UY95vP/6HFIzKZ45r7bH7sns6lyS1YZspWR2g
 qVkkC/KmoE09u8Nk+wO6brd50I3lmxzTLdvc9dQPMTxC9FuNbru3ysDx/lmbXQOqvtWu/jYu8d
 Ho6jrmAXzv5yB6NQs85mcUNG6FfyLSviufqzmv3xY45z4iRYq9uNSZ/HR7PB4o+69vXRSoAlg0
 XwCkgSUGRyC0MuBtsUwmq6iPD/ezuOvfu05ss8h2BTDbLWQ1UOGdaH7qeKPmbSPsI6tcvUT7hp
 kys=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193739"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:35 +0800
IronPort-SDR: VfKpTnuGhRvfmM7s45MpQCyReVyT7kfny73t4ietxQXzOZWIMUrZaD9/pblTYPvbRitrvtDWYZ
 xgtoQP91jlewIJGEn/SJ2MW5C7qidjuPbR6VAMQTAIJOfh7B9ztALO6onAd/ZuzQuTELbMxG0h
 UOspFi+TpFYB7NGsttrycFVlBseVsNLZihupLiWl1L+zf+B3XoXWJ/aDsdZ2LYg/2ZB+iLntrT
 W9IJmL9zWoRazfxgVUrbtehF09CFHWxi35kxPkrKp4T0Hr/iYJDMKNlgc5JB9SlkE5K5O0/5yY
 WmFDXRBA2uCLhFHIcmZM39gi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:46 -0800
IronPort-SDR: pa/9VTVWaPwEncQU5ifStxTBWWtsHd3Ptlq7in1MNjj4mYBVsBmaSGzBZzdN9Muomz26yg3bH/
 sGz51/tSERUc2wqlXkwBxHyZ7z2gJmFAbzFhszKzgJDP99CkWJBScXBBCP0klDPd5lqskR1npN
 VJ2b3vyebX/dCeDraDQiAoCUYBKhbO4TEGp9KzjqERBMDxda853ea/A51jnPx9R/V0/msT50bq
 WzC5uqIZsNxThs3SnXFeHPw0H+sdxZdu8RsOHktClmFctqUnWvifIV2lFy9Ans30M47WcSyLbv
 i5Y=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 07/40] btrfs: disallow fitrim in ZONED mode
Date:   Tue, 22 Dec 2020 12:49:00 +0900
Message-Id: <7e1a3b008e0ded5b0ea1a86ec842618c2bcac56a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index 5b9b0a390f0e..6df362081478 100644
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
+	if (fs_info->zoned)
+		return -EOPNOTSUPP;
+
 	/*
 	 * If the fs is mounted with nologreplay, which requires it to be
 	 * mounted in RO mode as well, we can not allow discard on free space
-- 
2.27.0

