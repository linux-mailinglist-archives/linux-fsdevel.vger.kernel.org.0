Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6B542690
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiFHGoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiFHGEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:04:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9426D90D
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654664351; x=1686200351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEIEXCYZy1bxZWP7CIJZ7DkiyLXVfXSlBA1Ynd5HU38=;
  b=ROzPSbY7aOM386Bo5uWX5FyJn8yv29m/66h0vTkx7iJ4nRbJnlNki8Zp
   cC0Zd/FiMSfj8BiaGYQW6WA9s7RudbzNKZPI0MezHZQdksit8aYayFEuz
   NqM2WDSZhIIHiuOajD1Ki3O/uYd+q++NWJOY0MR+BCn2iEAuux23W63jw
   tANg0Stux63CEld14IexU6azfuiP3VhyVnx+tNltareuPZpnsRe+LDkYS
   aE6HN9yirBAHUrrCw/kgoFgERomOIqpTjhYghiFXKNBCJHWKl/67tVzSp
   /mz9CnSx1PmDsz60rfhUs0xksIhiGH6y4gwcbSbET1N7TtNzhmgRLXbSv
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201289625"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 12:56:31 +0800
IronPort-SDR: rhbpqddpf6h9y2FCWSJNNUVPaDCL40UoStDewDxF+RUv9GsCm6aHUh85tAF6IsdSp48rC0CZ6U
 GH4eaLzOTipsXprKGxV8igTUWagBym7pb5CgVhkj/cOnWZYLAnDgnwH8ZthSakaS6oSJgEXm9k
 Gq6akIEzFZBvjwjq62krKLWgh7kZ1is66GMq5V0MVHdL15sQeNyMZDq+C6hJoUYCE77XsqQphU
 6rVJvyR8qPAKVTicw5ZQykBO66TJUZMzvm4lpDuVBYziQj8ecdul9zfiTM/QQsL9x9w3zaTiks
 C+FJZzGNJ2FiHzV5DI72LH4t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:15:20 -0700
IronPort-SDR: jawGZo+S+b5S8PC10FsZELZ3jBQ8F2xgeRTmA+XAo/80jOezJdgRK4Jlgwq3I3CgpVtbRmEk9J
 z5gMWgWOk5Fv3LTi/z6G3y59z0zuhTM+AZo5mAYTLY0tKZjivk1co3fyzAqE5EkkJnzjcJ9goa
 PIHOVUFmsM46+22AjceBuFWJSMeRAlB2Fm6eVgvz9EPDD73MFDxtFp0MHM28+gnJLsBmtlVLum
 0VnlPRoXUul6OoAxEZjPzA8z5W2Z30nsJytxkARjihW1j/uE7QFRg7wos29rFPidRKbDlPWLyW
 hos=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:56:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHw1C46RLz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:56:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654664191; x=1657256192; bh=gEIEXCYZy1bxZWP7CI
        JZ7DkiyLXVfXSlBA1Ynd5HU38=; b=ro3njAENukHogAe8v1Mn68ai4id+gOAk84
        Rya5AexUlRqcbtGm5tJ0E2iWKGXY/A3xkU8wh8dhYlXgOrm9pqoOYBb/oh/JG6AV
        xm5Uj9+/elbqoLemr8ei2ArApMVXujuqmN9eeA3H7qjMOu2bC2q/Foav+2KpjQBK
        tfxPojSR1nGZxZz+7eOn0Po8NhuVT/mDTYrePpls2D88jiGWtz0yjIX4pLVDhW9B
        my5fg3faR3f98irnZz6xbEq0u20U4ZfcYR9iyL5JeKI6T6213hO/AzwbqX550WD5
        ezgKFh/zuC3RopkQXToK7vkntO9pYOdIuhgWSy0VV8Bt7a8wgKkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jpGHqflJRT40 for <linux-fsdevel@vger.kernel.org>;
        Tue,  7 Jun 2022 21:56:31 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHw1B4K0kz1Rvlx;
        Tue,  7 Jun 2022 21:56:30 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] zonefs: fix handling of explicit_open option on mount
Date:   Wed,  8 Jun 2022 13:56:25 +0900
Message-Id: <20220608045627.142408-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ignoring the explicit_open mount option on mount for devices that do not
have a limit on the number of open zones must be done after the mount
options are parsed and set in s_mount_opts. Move the check to ignore
the explicit_open option after the call to zonefs_parse_options() in
zonefs_fill_super().

Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bcb21aea990a..ecce84909ca1 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1760,12 +1760,6 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
=20
 	atomic_set(&sbi->s_wro_seq_files, 0);
 	sbi->s_max_wro_seq_files =3D bdev_max_open_zones(sb->s_bdev);
-	if (!sbi->s_max_wro_seq_files &&
-	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
-		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount opt=
ion\n");
-		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
-	}
-
 	atomic_set(&sbi->s_active_seq_files, 0);
 	sbi->s_max_active_seq_files =3D bdev_max_active_zones(sb->s_bdev);
=20
@@ -1790,6 +1784,12 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 	zonefs_info(sb, "Mounting %u zones",
 		    blkdev_nr_zones(sb->s_bdev->bd_disk));
=20
+	if (!sbi->s_max_wro_seq_files &&
+	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
+		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount opt=
ion\n");
+		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
+	}
+
 	/* Create root directory inode */
 	ret =3D -ENOMEM;
 	inode =3D new_inode(sb);
--=20
2.36.1

