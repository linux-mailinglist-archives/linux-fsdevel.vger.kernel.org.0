Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F36CD1DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 07:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjC2F63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 01:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2F61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:58:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4552701
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680069506; x=1711605506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xuGd52oep/ccH2YA7Y3WrG4O/lafMp3cwHNYCHtHJk4=;
  b=EsISnnANe8O03Yttk7RryOh6sbKkTte1PtQ894aXMMQBqDr+CUkfk/df
   pEfhVV8W9wKQdeBrRqH1JjNKAqL6idy6IlVJ6kg57MycJ7hj0gNn++qYC
   BSF083IhDsjmNE29agEyZo7tVfUY0fpWPk+K1b1N9C6KbidOEGkpabkst
   tSnCaeGrfu7ZmpYWwEh2Pe9iy1F+5K6GYk2VBCrwST0nJ2e9zWGwJtobH
   JSZ+ZKz1ucmRc5hGvv6Sg/QZjr9S8A6x1SpWnrk09S6KGAuorr/571Q2t
   aWKzlMIiCo2DCvm7c3uOAylTcqgW4HOHMmrvGf8gd+eBGybyhb1b3B7Uq
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,299,1673884800"; 
   d="scan'208";a="331201892"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 13:58:26 +0800
IronPort-SDR: I2+P6yyujGB8J/6rb3RLbH6LImSRawCzHW6mEiGlUFOYAUZ5Mlm+qUlCXs8ZNphr3wmYbNBI8k
 LXvBKWPLN3Ed5ozqJDPA3A+Uje5dNDbfDUkC5BXwKMpEEPb/spoegjkGZClA2XjFEAOYXybBmd
 FSp7k2aIjuN3q8/Loe3LslDVkJHgWbcxnfOeKYHyesiASHLYNnBUbD6fQFu9Z14CgPwaZPyrmd
 TfXdDDKK/qzhTfzYb5F47i0DZn4hc2XfEXMLuJTi+O6wqruuEkFTQZAjJepVL++mGl7MjIFeUM
 yOQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2023 22:14:35 -0700
IronPort-SDR: hCt+/KfUAXedhC2pr7PsshLj1Q4GLYZhLBe8kJ37Xzv70fktY5Lci0s8TD0OAqqccuQJsqIDTu
 zm35TmFfSg3eZ2XTvY+aIU8JbLt+QTPZsg3DrX7McHXRwDRutrA5XpzN9bAH7rrERi9cnqj65G
 4jz/h9w7bU3GItQNFAhKOLDDeXgNivMW1HLqEmByI6GGFwali/0HVR8iZtoH+GaFN+2XXt2c+3
 QAIkD4rgKwGOP+NNu6l6qAc5Lg+RFn+p98U+37IFgsLiGkv60owiJFN5kGUJNCC/LE80MKOsX6
 CmM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2023 22:58:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmbSx6Cvxz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 22:58:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1680069505;
         x=1682661506; bh=xuGd52oep/ccH2YA7Y3WrG4O/lafMp3cwHNYCHtHJk4=; b=
        PhrkexLj6vsI8F3uIfgqSAMJzSVu9M6RKuAKvQXI51nv+fvKyfHqSmyBxM65Bvjd
        ZNdNT00P4ZPgeo/FK6xYvnsW5GO+DF85vFoLBCS+ZnenPaYUlBz6eKQmG/Q1KvTR
        RqqamfoREwNDAtFoIBr9akTyWGn/cpX8fXMWSwX+EX1NWNjwJXvCqEM7zkqq/NDb
        cwSEgXzAjPZjNkEk5DtbC9+0Ze8OIAuMolcwFLj1NWe3N/7/H1ksuasuRza25j+N
        U2EwPz5hu/BXHmoKIRlwO0FIx4/xlFSgg4bNRI5aQhTfP/aoz7jGEsE9yeooNBRJ
        KcRTWa7eOTYdEGS8GeSCAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wt4nO_okZsgM for <linux-fsdevel@vger.kernel.org>;
        Tue, 28 Mar 2023 22:58:25 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmbSw5rZbz1RtVm;
        Tue, 28 Mar 2023 22:58:24 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH] zonefs: Always invalidate last cache page on append write
Date:   Wed, 29 Mar 2023 14:58:23 +0900
Message-Id: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a direct append write is executed, the append offset may correspond
to the last page of an inode which might have been cached already by
buffered reads, page faults with mmap-read or non-direct readahead.
To ensure that the on-disk and cached data is consistant for such last
cached page, make sure to always invalidate it in
zonefs_file_dio_append(). This invalidation will always be a no-op when
the device block size is equal to the page size (e.g. 4K).

Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 617e4f9db42e..eeab8b93493b 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -390,6 +390,18 @@ static ssize_t zonefs_file_dio_append(struct kiocb *=
iocb, struct iov_iter *from)
 	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
=20
+	/*
+	 * If the inode block size (sector size) is smaller than the
+	 * page size, we may be appending data belonging to an already
+	 * cached last page of the inode. So make sure to invalidate that
+	 * last cached page. This will always be a no-op for the case where
+	 * the block size is equal to the page size.
+	 */
+	ret =3D invalidate_inode_pages2_range(inode->i_mapping,
+					    iocb->ki_pos >> PAGE_SHIFT, -1);
+	if (ret)
+		return ret;
+
 	nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
 	if (!nr_pages)
 		return 0;
--=20
2.39.2

