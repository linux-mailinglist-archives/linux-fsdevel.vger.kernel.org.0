Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8963709B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKXCpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 21:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXCpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:45:49 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E57A35A
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 18:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669257948; x=1700793948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wq0+GNwO7ec7EiT8GNn/wrUYz3n9rrhG28yuyRURi1o=;
  b=bVR3U7x/D1cm8qllyHBm76AR2/WeWQdi36wo5gvgNPNcc3mGyEhsi4AO
   dUxXnQuUgLMdUmASFJtrteO5AnyZyalEKLI1GlgWu0aZpMYeJ4o3HHUw6
   84bC7CntltObydiIGkBo0U/tU+BGYMPRCV7Z/tAAUWmDvXOxjD5aI1pRg
   SUh5Z/JMG7i9g6Jpol7AeFEcRH3nY/3SdihqU6wQTGIXDsxAAAlIZSOvO
   FDvXjlVv7NRLraAkyVO3/9wQwV+j00LqQJEcclsp+dims0o6xvNUsd6K4
   X8nOiMkDYkR7hm0SEu2PlAnxIO72s5R9/GR2exMMADLgH77lBrlddpih7
   w==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="217350023"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 10:45:47 +0800
IronPort-SDR: nRECsydC3OLTKTT2DVgCuw7YzeIFdfNhnB1WLM7L/RY1A1UweT9iDob9v9jNUjiMftAKwxIHlX
 9qErdP+Lgz/y7sL5+12F9Ylopa8ywqWz+wmClSIy6o77OS8VqDVt4nwqIMfC00PF3MJ93stNUg
 H+pL+ojUpqYiRcUpkIIzBqbXbijHVb7FVvG/yL9FQkWtsR+G4zCyHTm92rh0sz+cG06upVAdA8
 Vtsc6tFol4l9bzwUKBpA+3dWY9F9QZftPrGOJvAm6FG/2euFLGNqn7+H8yZyBU3/lb9ak+VlYo
 I2E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:58:50 -0800
IronPort-SDR: bpwLNyVRSsxFn+AIMoSRWtvoWGrAGL4Y+SZDJZXMBQFcVdsuyvAA+2J/2azqGQlY4f+zsLBVI5
 8tDEM5fmad1vQjJmqWNU1+SEF3vakv8yZqYrwfeIFM2FVihde7LgtGQgCexKaasfJgpwbujKd9
 LA55lXL2PSrH71FCfu5BFXUhh/kNqHLIjuQ/5uuFLhjAV891tY1vO5/KRCdlon76n4qLUo1BJY
 WwXLDdP1JUvCri49hjlLXk/2vaYzVXpjqrY041H6JWqucDTg7ZiOwtt8McF6PAGoIiuUj1t/gs
 pV0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 18:45:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHj6M5RWNz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 18:45:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1669257947;
         x=1671849948; bh=Wq0+GNwO7ec7EiT8GNn/wrUYz3n9rrhG28yuyRURi1o=; b=
        s1CXIAmV8ID34gAUpWvJYaU3jm1A3JE9Y4rG/vsZROHtqYV1rYZ6B3e5+S244eRG
        gBnmHpz85KGxwY8ECTe/xL2IjhX+fvoClcTUVY8SLofylm9ap6ZOc7F2chuV9idM
        IUDFEXOUJlJXRTmyp/COS58ti3Xde7ajqfDibuyTe6fsJ6D61VSG7NjZgreR7fIe
        LbT7/6Vcn9yrwbxDfww2Y72d0cS7w7YeVomL9xPoP5Ph12hZhFcvLqMQnfAg3Bkg
        rdR5o6e67p3vSKuTZU2EKrdeTTBDsGFSVwzPOINVFcgan5+A2v7cLg0BV0NVmG1b
        paJn47BABSezNFLD152m1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mcgWM2Zq0C6U for <linux-fsdevel@vger.kernel.org>;
        Wed, 23 Nov 2022 18:45:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHj6L66CWz1RvLy;
        Wed, 23 Nov 2022 18:45:46 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: Fix active zone accounting
Date:   Thu, 24 Nov 2022 11:45:45 +0900
Message-Id: <20221124024545.243036-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a file zone transitions to the offline or readonly state from an
active state, we must clear the zone active flag and decrement the
active seq file counter. Do so in zonefs_account_active() using the new
zonefs inode flags ZONEFS_ZONE_OFFLINE and ZONEFS_ZONE_READONLY. These
flags are set if necessary in zonefs_check_zone_condition() based on the
result of report zones operation after an IO error.

Fixes: 87c9ce3ffec9 ("zonefs: Add active seq file accounting")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c  | 11 +++++++++++
 fs/zonefs/zonefs.h |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index f0e8a000f073..2c53fbb8d918 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -40,6 +40,13 @@ static void zonefs_account_active(struct inode *inode)
 	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
 		return;
=20
+	/*
+	 * For zones that transitioned to the offline or readonly condition,
+	 * we only need to clear the active state.
+	 */
+	if (zi->i_flags & (ZONEFS_ZONE_OFFLINE | ZONEFS_ZONE_READONLY))
+		goto out;
+
 	/*
 	 * If the zone is active, that is, if it is explicitly open or
 	 * partially written, check if it was already accounted as active.
@@ -53,6 +60,7 @@ static void zonefs_account_active(struct inode *inode)
 		return;
 	}
=20
+out:
 	/* The zone is not active. If it was, update the active count */
 	if (zi->i_flags & ZONEFS_ZONE_ACTIVE) {
 		zi->i_flags &=3D ~ZONEFS_ZONE_ACTIVE;
@@ -324,6 +332,7 @@ static loff_t zonefs_check_zone_condition(struct inod=
e *inode,
 		inode->i_flags |=3D S_IMMUTABLE;
 		inode->i_mode &=3D ~0777;
 		zone->wp =3D zone->start;
+		zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
 		return 0;
 	case BLK_ZONE_COND_READONLY:
 		/*
@@ -342,8 +351,10 @@ static loff_t zonefs_check_zone_condition(struct ino=
de *inode,
 			zone->cond =3D BLK_ZONE_COND_OFFLINE;
 			inode->i_mode &=3D ~0777;
 			zone->wp =3D zone->start;
+			zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
 			return 0;
 		}
+		zi->i_flags |=3D ZONEFS_ZONE_READONLY;
 		inode->i_mode &=3D ~0222;
 		return i_size_read(inode);
 	case BLK_ZONE_COND_FULL:
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3233..1dbe78119ff1 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -39,8 +39,10 @@ static inline enum zonefs_ztype zonefs_zone_type(struc=
t blk_zone *zone)
 	return ZONEFS_ZTYPE_SEQ;
 }
=20
-#define ZONEFS_ZONE_OPEN	(1 << 0)
-#define ZONEFS_ZONE_ACTIVE	(1 << 1)
+#define ZONEFS_ZONE_OPEN	(1U << 0)
+#define ZONEFS_ZONE_ACTIVE	(1U << 1)
+#define ZONEFS_ZONE_OFFLINE	(1U << 2)
+#define ZONEFS_ZONE_READONLY	(1U << 3)
=20
 /*
  * In-memory inode data.
--=20
2.38.1

