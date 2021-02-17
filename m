Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6039B31D732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 11:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhBQJ7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 04:59:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37659 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhBQJ7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613555959; x=1645091959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P2dkQw9rsvgDkb/5Sb3kIt9CVGAPiEfi7G33wzPCfRc=;
  b=iJHF3swCdv8UqX+bZEg04tln6qWVpnkeyjP+H+mitOINYwDh3rMOLpgb
   kQf/jSEKfQkNRv1XQXZU35MtGBZ4cWQRqIPD0SLWwyNaEID8HB5E6Rsxl
   pGmGTzoMEcoeY4yONYBOi+QUQ779GWTrEOokOS0iEjUp90pfPOQkTt37g
   P54LxEDPnRRAzlOoIc3x2orO6iuRkPEJLH1Aad+4Dt1Qv7OBQvFt4bmjk
   N6I6QQHoa6smqHYG1NNcBO8uBRYkT0CiAJiWxS+/caoc6r18GuWCWOnnd
   kPkjm7fxMEv0LgddPzbmh4ZQ7Vq4wWzy9kPiMtW6Gqq6kSJzaJF15+H6l
   g==;
IronPort-SDR: BsnpJgMqSLE93t0nl2k1172TdnTHqprm1YW3Rcp0NX7XbuPDLFQwLr7r0rsZmy1yOHbaGun/5I
 lVuYdaMf4UwTHbzJoGroM4ZqTt5ayh/23z1ZeahBGl+3uYAvpIoKPhXA0Ro+w+AM/fx+T5RHUR
 QZZb4xf0Ga3JKLBklyywzW39MXelQOw63sQBoP9FZpedamW0JQxS5mK3PICFSde2PrQyC5EjGf
 rMd7tY7zQBTKPfExk7JgH6hfMi8Vo9cqNaJb+Q2cr9Cq0npylrqePO0KXpSkwAlvXQFUTVUzGS
 Y7o=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="160138843"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 17:58:12 +0800
IronPort-SDR: YSA0jWR0+avWf9Ru38jUCrW2+eb4OikyOURQVq+h4AyB4+WWzv4mmxYr7bMVZidcqRkWinjgvb
 ezYYF7TO3FicjhnyGB2urHjIy8Wvj45+r6lwbepvEzBFZZlc7VIoBvbM2CXAu7mA1h6CryOCC0
 /fSU+bCaZUufQdMJowrs9pEKc8ZtTgFcyqL3Vb0hrq/vU/nP2WxDSENyyLVz3HSCOflilut/9l
 zcJHszhhNW3hkSo+OoQ5V9YBpXs82Mh/c7jex/peRqi+eKobR4RNBqs6SzB1r0wLlfVOi5pshs
 qiBeBsUdrXkvWpHjVuPbuwHJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 01:39:57 -0800
IronPort-SDR: Ockj7F79LlE3skJOC/SmoWOjDxkT9CCuHQMD3ICbDvJWdK3tu0l9G2/pFAz2LhCLo3cm7Z5Bsz
 TxaK48iIBUTH0R9sRR6jL7zpjNxdg56vzg4+SW5SEB2vzV2nrcLatNTv+MoSWhL+Y5lkTtq3DX
 4tcGirr+uczv3FPFlOQv1cJtK2DK1KMFGvYmbgG2O3JZd+Czsspado4Azn1Zd/pKGBqMWp/g4n
 IcP5yU5/hdWPoPdS/XnvxxlCITiSZd3peFalz8sOreKHYxKjViE7sb/WYSP/IXznKDXpC1Fgfa
 xDs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Feb 2021 01:58:11 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] zonefs: Fix file size of zones in full condition
Date:   Wed, 17 Feb 2021 18:58:11 +0900
Message-Id: <20210217095811.2517221-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Per ZBC/ZAC/ZNS specifications, write pointers may not have valid values
when zones are in full condition. However, when zonefs mounts a zoned
block device, zonefs refers write pointers to set file size even when
the zones are in full condition. This results in wrong file size. To fix
this, refer maximum file size in place of write pointers for zones in
full condition.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: <stable@vger.kernel.org> # 5.6+
---
 fs/zonefs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..3fe933b1010c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -250,6 +250,9 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 		}
 		inode->i_mode &= ~0222;
 		return i_size_read(inode);
+	case BLK_ZONE_COND_FULL:
+		/* The write pointer of full zones is invalid. */
+		return zi->i_max_size;
 	default:
 		if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
 			return zi->i_max_size;
-- 
2.28.0

