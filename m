Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE06C1417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCTNzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCTNzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:55:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF912CF8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679320519; x=1710856519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gVSMnZvqx2CLPk5NJMYryLHY0VhJ8kt/nCgaW4Vh1EI=;
  b=YvuNcDl++stZ7584WfGLECQDDPmS9ze18EFBE0ZiV/dMN2KzGSux71rd
   rXnWm0jc8CRo+sE7WySgu9QoZvmcsCK6ZESZhKoGmHu2i1niXy9mU1UNo
   BqgmMHE8SVLmie+VzQZ28B0ypEOrrbi8EGPSIRhaNKK0ZvTHb4x8kR9xg
   H1TnGOGYp69f4c7GdujslhtUtIAAKsQ5xzSyOmCmZhc3Dr1Ve1aDKOqcO
   JPUWVMUdJIU4eu8YutBbehe+F4yxfkrxJ0OACp4NfWijQNfY4BDEy147k
   nNRo8LE3N2yC0nzdxC3VdPfs8rqu+n2syDbpbEEFk6a/iSf537eRV1z/X
   A==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330455520"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 21:55:17 +0800
IronPort-SDR: 7eSJVC8tFgQiYrGrqnafl8Tt+libMwqGS8JUKY6Vl1LXe3JmcKjrgtunho2dEYaqI29vTq7NKy
 jIvbtRsjPB40we/vVYgaqtvU2vvYo4vYFd+tZns+31M9mtAXqhXGxFetqAO7cb25FSGEaD80Pc
 viynVEyRsbzjwkhsrdMd4M8uO4t7G1y6gLg+e4WT2ytHzGEhR8OGBOpLKpY315EW4TR2SbrstG
 3GsTsHQgixCE9FM8tTW4tPFST5FO1aPo2VUKRbAOeP59cHyt5/AG2GVGDKMMN9VPGvxGah8APo
 IZo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 06:11:38 -0700
IronPort-SDR: cRqpv/Rgsmm++A/xFDNGDlZF7+f19ZuViXIV3GAfR+vKE+lEMpNzJeca6sED9RrA31plsn4TJ1
 2Swm1I138FiQ8NJPhxB4K7dnyiyWvQm7djiX5zYHITOEU+N6Lq4CGghP7Ci2PlgLdrspgUebtC
 ggZ9vOpIQQnP8HlAixnEa0/6aInOmFn6ZUOETLk0HLLtvqYdpWt2KkqxP3TbpmM0H9zB78Y5F+
 0xGiHshHEUC5wKa0bO+Z72qlpHqFw2woGyhYFl5qiDVNtn2E1MaIJhkN5cXuUI0oYtkVU/hRi3
 +U8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 06:55:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PgGTK4YpBz1RtVn
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 06:55:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679320517;
         x=1681912518; bh=gVSMnZvqx2CLPk5NJMYryLHY0VhJ8kt/nCgaW4Vh1EI=; b=
        pH7apFJYb4row5rSJpa1xeEq2Ob6+uxClvyCojxGzbyHbEZQG049B8kY+nePRmTi
        +O7uNMej+Xw91m4LwJ8y8gDLe/fsHBIou7tSBhfRf4b7WB2kMPzRYIDPAdVhfvQN
        D7q+7JPcGwA5kobTA1YPztP+xV4enP7E+yrfrejT9ZKCbNFXtJfWSroiWcnuqJVP
        i/QCuhxLUv372aSvrsZi1g2YmW9E8g5uq4Bm48MdOLQ/jBUvFIgfQYoZekUngHSk
        cywC3ENPCyPUd05Vs5Z1oXSvia4dMvUCXiq3ZKlC7XJh0hbDviMCG3gQ/tIqbA3Z
        w87nRJyHWtENE/0sTCqBUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmiRp-LSyQkt for <linux-fsdevel@vger.kernel.org>;
        Mon, 20 Mar 2023 06:55:17 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PgGTJ6F77z1RtVm;
        Mon, 20 Mar 2023 06:55:16 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: Fix error message in zonefs_file_dio_append()
Date:   Mon, 20 Mar 2023 22:55:15 +0900
Message-Id: <20230320135515.152328-1-damien.lemoal@opensource.wdc.com>
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

Since the expected write location in a sequential file is always at the
end of the file (append write), when an invalid write append location is
detected in zonefs_file_dio_append(), print the invalid written location
instead of the expected write location.

Fixes: a608da3bd730 ("zonefs: Detect append writes at invalid locations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index a545a6d9a32e..617e4f9db42e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -426,7 +426,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)
 		if (bio->bi_iter.bi_sector !=3D wpsector) {
 			zonefs_warn(inode->i_sb,
 				"Corrupted write pointer %llu for zone at %llu\n",
-				wpsector, z->z_sector);
+				bio->bi_iter.bi_sector, z->z_sector);
 			ret =3D -EIO;
 		}
 	}
--=20
2.39.2

