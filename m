Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8553C991
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbiFCLtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiFCLtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:49:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8F3A183
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654256984; x=1685792984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQAkmMyblYX0qQilaiMXTAwZ41EjSb4swJ2ChA8/NV8=;
  b=oaqvByziV+7sqGu3Hiy4L2R2N+dRE+YnKkpyEBYXUhM7Uz6guUQxF8ev
   oeKAvhLb6qXpne4IUWHfILJx5DLBCagBzsCMdfCvwENS51WbT+7t8l0eT
   cbWVTFYStKPFUlpW1viHKlqMPoIm1G99AW9eZkYlYbtV2dzhDunt0g5ox
   r1OBg1j6JWYa1BudRDNKpH0jcG1gXiLAXDQKs9aRVMS/jCCZHY5CvJARW
   uUfaRkmQSPbP3yialVH4NWNw658jRGEcis53eR94B6iATQrTZQL2rasxW
   wSoZ9irW/sFWQ2MUKcoT0XfTj0dB4mYpf38iRp1U1AXMe5L4mKDgvSueo
   w==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="306454532"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 19:49:42 +0800
IronPort-SDR: 7yPms3cvEwVq8HxeN8xpq+phw2bWgpPs/hiS8zN8Bxrye0VUCZTR4xrGsPlkDIjBk1XK6Slz54
 0UIzdmDJVy85CFEL0tEjLIGjuy2Nxwg2pf3JCVCjkRxG4roqHuvnhLsOHyhcy/xD98eoS9SF8C
 S/aELM+V10jtztblLjHxg2YavpExZq2NExFewMcJ9YvMdeUI8w4W9ovUGN3e10hydgQ7jNviO/
 of3Y2IWWWDEYq/PwoQfDWhsq3FpPz6f4IS3OYMdrZlFgXH44jr79Ukr6ohks60zwVqIFedQal2
 se5v61KN5tjwz28ntryIjAPZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:08:47 -0700
IronPort-SDR: CLuF7bJ3rBrw9mD+TB1Itja9+/BckjKiTdQ0pfK7ZZ3oyUUZrpffxVcOqfeeF6nkbxJybNzEEI
 RFlhuutLwHnSuEb+VQFFmPWqqNd0+C8unFOXmGNrNrIbzjlSUqEVdGB4/WkdEH60CkOlMn+/5u
 1iexXSMCdzpELCwdW0zrN0aIi/mrC4udon8jxUCEkFFacGDsY1dJUv0esGiw6p15/CCIid51kk
 BryRZcudoHS2H88G52E2CmBtec9TSQXGhRQlYB51WRH7UfgflnI+QowkJX/xNgVLmKb4ep6nvp
 lbs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:49:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LF1QG3zs4z1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654256982; x=1656848983; bh=IQAkmMyblYX0qQilai
        MXTAwZ41EjSb4swJ2ChA8/NV8=; b=oUN8msNb5JOiaB8p1VyPg10Ox/urBHl6HH
        FFY+nq5qwGi6skrQ9FZckzXcyoWdDIHQffnlQVXmy5wOsYjmaf0ciuJYXLIs75aO
        rrutjgHD2LvaOnXbergGr/ciBtbq0LVeiDDBId+8w3gr+kSesCLL7ZPoOKn/kEjN
        VniiRwsf610Udf9Rnr5/1aCZCi+8ZBuA6budHkU9NlFY9zjWe3uMpPwGHldqsr5T
        6y06/lChOxaE0yZKtdvUz8nH3cSWinqiE5Vmf4U4Xc9JCPo+c2vAM3hrDXk2L/d5
        xTx2JfUrHNqEIYcF6GIii/RicCj7dHe5P096/Pk0jYWMaNEPT4gQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O1hv3VU1CyxQ for <linux-fsdevel@vger.kernel.org>;
        Fri,  3 Jun 2022 04:49:42 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LF1QF5dJ1z1Rvlx;
        Fri,  3 Jun 2022 04:49:41 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] zonefs: fix handling of explicit_open option on mount
Date:   Fri,  3 Jun 2022 20:49:37 +0900
Message-Id: <20220603114939.236783-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
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

