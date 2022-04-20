Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3DB507EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358981AbiDTCiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358972AbiDTCij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015E32995
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422155; x=1681958155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eHRi+eb4s/r9SGaBxGO1ndJ7Q/10lApiOZ6y9KYvaZE=;
  b=grQjkf2cuD8NZT18fnamT866Eg57PayYxil7WGHUqJ7uzLK13yaXX/3H
   60cF6OPgnNMEWjZm9yKvO1Lm3iOlMt7ygfvICC43LYl1eZ9ZqfMkUByFK
   PQgJjBpNgpzYoqek6V76pk+a5waiIAfBKQUajVC5THlzsq0uyAiWOQUws
   zHXiZCqfT7fy6fGFKcBHGZoz1AYxG8yq7uAgbZGOnIg3nAdQabUr2j536
   vXOHCx46Te6uKaWjidQh0qfMzMmlK2jcAI5aSVwiQdR2VJGvNgn55KVwO
   gIluLnw4TXH/Dqa2BYhVR0AYJ9CnvTM9BOROU5qnf9Zbt35EPk9dI1dZU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177976"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:53 +0800
IronPort-SDR: 0LPQNeC72sYIQrwPX+tYTepxPP+wt9sgAmk/r7DAJQetYppl5PFDqqSU+4gqJsPRQNGcC6nPgD
 O3vope0/fEqFyZc/ES9YxDaxWwN8f896VDTFHYLe50yaTgLSNBPobM2PYaWU2yIkqS8CQNDMSV
 tpCC64Jhwb2ndLu7MnnGzlI08ZjqDnBVp3oAsyvkxAo11PEAS2qNW/p9Ik9VT3V+5acYa0OaDO
 Yq2bydyJEvXvGzjFA4KYfRzrPp/Wn7DMYhuzFow/O4AvXI+KVgNaAMkv5+70zUtprVC5h8NXVT
 IzVNKmP68Z69UoZ15Ya1O/qg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:12 -0700
IronPort-SDR: /v8pnSotC8cDvg1BcdKdXxeZr2JfXMiwURvTmchGju0k847GBAdC8YFpkxTrEiFCIEXnoMGWlE
 BPb1tjLVTVtySoVzcmyq8fsZqoDzpRu/JzwvQtKotERZ1mFy8kazd/hf59/EtWQYWmlRHWBWD8
 6/A6wHIVZqZiAqKhGp9TbsocWf0i5XVhbBvxLaGu46kXXpgdsSU3h1indmg68Jh3TE00DcyhTB
 QM5NHDedoAXsOtu1sfjHI1V+AF+eJxXeeBuiiUUrquj1dRPB8QOmyPi6Rj3JUwZ+7H8sK6hRYa
 Gkk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCX5Sdfz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422152; x=1653014153; bh=eHRi+eb4s/r9SGaBxG
        O1ndJ7Q/10lApiOZ6y9KYvaZE=; b=sJdsCSX2v0uDfnVehxnIQv9DgKIr86wMdj
        5ZLLzgXQZWUN5EQQNC7v40asPauwDfco1FCSBo1gEQt23GJKR2WdPmkQRVVzTqHt
        1hGd6o7op0l1K+yA8dqdA86U0pVBX0voQ36Tin1bOZ+QSkiSCDKpVJIcjQtbaHSe
        kvVqf3E+gvC0xYLDmmddEfgmlo8ZmYa6nbgBaiAFFOnd5qqrSi/IHCkNJvPqDLnd
        59blGgDFUWVn7Q8+nlUojXWm8zXjSDio9v1fyeCtyVXGh829mKHzp+6LC5kALRNw
        MMUqQqRKMXRTdBpemgqO6XfNKg5unL4UlNoCXp+pxul/aBnI3vJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uIDAt5Y3zKoU for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:52 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCW6xD6z1Rvlx;
        Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 7/8] documentation: zonefs: Cleanup the mount options section
Date:   Wed, 20 Apr 2022 11:35:44 +0900
Message-Id: <20220420023545.3814998-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
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

Use subsections to separate the descriptions of the "error=3D" and
"explicit-open" mount sections.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 Documentation/filesystems/zonefs.rst | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesys=
tems/zonefs.rst
index 6b213fe9a33e..72d4baba0b6a 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -306,8 +306,15 @@ Further notes:
 Mount options
 -------------
=20
-zonefs define the "errors=3D<behavior>" mount option to allow the user t=
o specify
-zonefs behavior in response to I/O errors, inode size inconsistencies or=
 zone
+zonefs defines several mount options:
+* errors=3D<behavior>
+* explicit-open
+
+"errors=3D<behavior>" option
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The "errors=3D<behavior>" option mount option allows the user to specify=
 zonefs
+behavior in response to I/O errors, inode size inconsistencies or zone
 condition changes. The defined behaviors are as follow:
=20
 * remount-ro (default)
@@ -326,6 +333,9 @@ discover the amount of data that has been written to =
the zone. In the case of a
 read-only zone discovered at run-time, as indicated in the previous sect=
ion.
 The size of the zone file is left unchanged from its last updated value.
=20
+"explicit-open" option
+~~~~~~~~~~~~~~~~~~~~~~
+
 A zoned block device (e.g. an NVMe Zoned Namespace device) may have limi=
ts on
 the number of zones that can be active, that is, zones that are in the
 implicit open, explicit open or closed conditions.  This potential limit=
ation
--=20
2.35.1

