Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A506CF8EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 03:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjC3Byz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC3Byw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:54:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2C19B
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680141276; x=1711677276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDLgZuR2WQ1f8pZqRHnTlUQA4fTCB4J1XsBtiDUa2SQ=;
  b=YdYcyPxm5t4mIryW9u2W5kU4NoR0grSyUFOs7QJlPFqRnLyvszNNyZjc
   bbuKg0iEFxqZOx9TtVsun1vdiaiizxqdvSzWcZV4m9Hu9iqvgwxTjhn9J
   txjKAelWRc4fBk4C8Awq/tZlwjJjO1RHvjkwMTBQ20Jssg0BWST+dXIko
   wL3XD0tSXrD7OZtEQ8hjO3HkQ50AvIDs3dTWv8PJEnau4DJrVke4Remye
   bf04O1/a5J87rLV16HH7U+uJXRqYvndQ5VDprmJDwjO1Ceb7rmrjV8QIE
   /O1CYlvjuEFJT7wuZ9lFv/OIqhIB3Ifbi9LkXRSPo2EEHitLXmj/wzGfF
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="338912435"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 09:54:28 +0800
IronPort-SDR: Uw5bQO4FzZgBxQXIYRQz3+Oh2hDgjZlNl9a26edV/KsQH4+hD5JjHyV5nYyU/LS/3JwC1t9lSE
 hNe52TvvGqX+8JH68BLMENNvYycXwTaYaUI+HAk2FyB2kg16dJ8DQYnposvNDpjYxoZm+M7fsZ
 ypcSIxSxSCPgx0JyWMh9jxv2Xnqm6GcJH8nNmZ3Bq+K8m28Ueskf06NhCrBkc+6beBdUkjSR6h
 o8MsoUNBUtdm8KvvKuxEQBJXL0WqDgjOBQqGhcwV1ielPsfEZW1RckdW5EQEdfkq7M975O3b5R
 2eQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:10:37 -0700
IronPort-SDR: 7cDfsmL//c7BEAaDl+HMAuVM+UHxb364hoc0c5zynGTBvAwyMSjhiRomjgf4kXnJCWyAosJ9Wk
 0zz8tDeoD1w2oe2x8yIM9G10Y+bk3eow/nK6Xyal5n50Th/gwu+1lZnV4qpL/nc1+b1arGHo+P
 kzMgGRl9GqREtc9j7dA9WtdrR+BQK2Kppagtv0AtfvH4Rh3beC0KLQ2eP5GVtj+oMSbWp3Cv4o
 bxM7pd4GW/GQOMwhB86FIpNwgsEfQ9u4OoC1SAI0HUgjyEnyOf2Px2CYVKncasGAmrn/nLTYre
 Hpg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 18:54:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn6102SKcz1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:54:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680141267; x=1682733268; bh=PDLgZuR2WQ1f8pZqRH
        nTlUQA4fTCB4J1XsBtiDUa2SQ=; b=YdE78jvCr9n7JGoee150TmT9pP+JStQrql
        9s2txelBZX3l0LfCrYFslmQg3BR/icSDf6Cv0vIApgtaztisOF+PQ7upyRh0+6Mx
        6Bsf8ad8D3ytpkNam611xsZTPEL60xtpe08NgA7hbNMTUZj6oVqK4hp+mhApnX0V
        MBaw/mPGQBX2AVKzfdgpbtwMzrvJFpkQMyN5FI1ZmwnW95zniLszCzEC8H+0U5us
        yVuKVwpkyGnaZnQBracV/1GmrzgLthMho54nuKiB0j48zpjrzKNljWA+RgyZSoKf
        Jz9ia41aNQVXHcJJnmpBu+mEAwmD4S6ifId0xebPMXXEAUJokOwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LHgmwUxTm9eJ for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 18:54:27 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn60z1R7pz1RtVm;
        Wed, 29 Mar 2023 18:54:27 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space
Date:   Thu, 30 Mar 2023 10:54:23 +0900
Message-Id: <20230330015423.2170293-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
References: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
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

The call to invalidate_inode_pages2_range() in __iomap_dio_rw() may
fail, in which case -ENOTBLK is returned and this error code is
propagated back to user space trhough iomap_dio_rw() ->
zonefs_file_dio_write() return chain. This error code is fairly obscure
and may confuse the user. Avoid this and be consistent with the behavior
of zonefs_file_dio_append() for similar invalidate_inode_pages2_range()
errors by returning -EBUSY to user space when iomap_dio_rw() returns
-ENOTBLK.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c6ab2732955e..132f01d3461f 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -581,11 +581,21 @@ static ssize_t zonefs_file_dio_write(struct kiocb *=
iocb, struct iov_iter *from)
 		append =3D sync;
 	}
=20
-	if (append)
+	if (append) {
 		ret =3D zonefs_file_dio_append(iocb, from);
-	else
+	} else {
+		/*
+		 * iomap_dio_rw() may return ENOTBLK if there was an issue with
+		 * page invalidation. Overwrite that error code with EBUSY to
+		 * be consistent with zonefs_file_dio_append() return value for
+		 * similar issues.
+		 */
 		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, NULL, 0);
+		if (ret =3D=3D -ENOTBLK)
+			ret =3D -EBUSY;
+	}
+
 	if (zonefs_zone_is_seq(z) &&
 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
 		if (ret > 0)
--=20
2.39.2

