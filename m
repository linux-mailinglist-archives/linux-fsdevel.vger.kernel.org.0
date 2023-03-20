Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F96C0ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCTGmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCTGmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:42:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A0EC54
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679294529; x=1710830529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=de3wFguE/TQMNMnPRlrr59cJCceTeP07Wea80FkmTBc=;
  b=msrPGvqmxnmD37tkRtO3k7A+KdTrWdp9b6q+7/PgYCSo5A+huc9Dzt6H
   Imlswj8r7nSGAnA5bNsPCsquw6D6do3mfBsFL6N8+I+iO8p+caRbBYzq7
   VZ+ENbpBxm7VYFkMoBPOoJDhm4DBwdI6tM3C3tXgm+ZvMlr0KswAViQSK
   epeGRf3OgVKb1yt+ATujQjnzoL/PdYCR102y6vY0ymBh9Nf69e5Ik1Kid
   kw9Wc/8Gq4joxf1Z1DJsbI7LCaeDbw3EsPo3K+PZ5oKlqEfi/ZxNrsh/P
   v3Nb1EU0YQJ6Pv08yBB3Mulp27IsmGgP3ByKRuoIqhsUZhTAR4qrWlEev
   g==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="225820318"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 14:42:08 +0800
IronPort-SDR: +SVPFJNw5QPUu0vtUsMPI2AdmaNNfOBbDV7axIcNgnDNrjKA9LXdRBxyZSVIx6LrNubig+wyxy
 /Xk/bsZ7Foe7JObqD2erxCRhs8B8WP4fchfqtozP36Bgh1ZQgtD2Fj/wuxsTwSFgYJR3takZvb
 4SwZj/fvGq6oofJkZeNnTCRdwQPA3+1jgqsKi7Tp9KyMKtnGceGXBS/KrCF75tDpUkwG1pwK4L
 2HI9ccmMj8eBK5v03bMKrZfbn8gTN0WbpZWYEtTfmyn35UgBiiCGWoX82nWJULErxdDEgS/sMy
 GZo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 22:58:28 -0700
IronPort-SDR: ibB41TjPqjwY4QKk3AIiCUZOD3OktPOMXeL2oBom0iw2GmOg2TATeVEbGtOU64zw62a7jNA4HV
 RdxjhOum5sSbGCFlrehVXLBZjZYNTA6m/MNNwsgGYFX/LVgVplAM6ce1lJQdmicRHvE3a0pZUh
 YBQ75mFI1Hz6DQ7W/Ypoa6z6wdIM3uJ7pK+oFKNQEdnnDfZno4gIJJ8Rex6AJj4/tOkJ437B6y
 uO7CqZo6L8iRgpFmFwrqs+ZTvHPJ/joesa/JHDRRzjV6D2P0SeDO0ehN6lbCJDo+fTziXfirMh
 u4g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 23:42:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg4sW6Mppz1RtVn
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 23:42:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679294527;
         x=1681886528; bh=de3wFguE/TQMNMnPRlrr59cJCceTeP07Wea80FkmTBc=; b=
        o2k9UwC+EcFAE33dYUhKVCI4x7EDap2KKnx+nJ4/M7G9jpY5L+mo8D89aQ8KZfT7
        pGXfgZhnxpPygPXNPnR53sykcrQrp/argDRe5aaYH0GYc0fvgrHMWEqkWtcGQMfz
        dzJFEYGrKYGV5DEnLTkCK6j4sCqhNtMCJcvL15lq/0GUi2QB7YghcGD3DNNQ22tE
        oZKg+C4hX4paioUZ5WtZcCByoEG+jaA6Lto7mzd2mLTsMC9ZsikxI0YmEgv+6Q/z
        7xPFUD1ikdjLUcU951XiyQ5cA8qlvqLcQRDUxQ5C4enw5s1xfZgMDRztcQHoHZ3P
        acnmwT5/rTGYpk7FanJe5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RQXR4cbBA-CM for <linux-fsdevel@vger.kernel.org>;
        Sun, 19 Mar 2023 23:42:07 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg4sV5PV8z1RtVm;
        Sun, 19 Mar 2023 23:42:06 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: Prevent uninitialized symbol 'size' warning
Date:   Mon, 20 Mar 2023 15:42:05 +0900
Message-Id: <20230320064205.148895-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zonefs_file_dio_append(), initialize the variable size to 0 to
prevent compilation and static code analizers warning such as:

New smatch warnings:
fs/zonefs/file.c:441 zonefs_file_dio_append() error: uninitialized
symbol 'size'.

The warning is a false positive as size is never actually used
uninitialized.

No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202303191227.GL8Dprbi-lkp@intel.com/
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 738b0e28d74b..a545a6d9a32e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -383,7 +383,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)
 	struct block_device *bdev =3D inode->i_sb->s_bdev;
 	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
 	struct bio *bio;
-	ssize_t size;
+	ssize_t size =3D 0;
 	int nr_pages;
 	ssize_t ret;
=20
--=20
2.39.2

