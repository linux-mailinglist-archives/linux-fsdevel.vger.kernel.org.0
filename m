Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2D507EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358958AbiDTCih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiDTCig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E3237CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422151; x=1681958151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YR0xXxVtCgGiy2K4HbA7uaHdw3xug5+Pz6/PMMqkrtA=;
  b=o6hxT9i1fkS8st0FrDP48LkW2TSMcyA8++UzXky5eiov2Y21vzR7OnHY
   8xq7mUi1cLT1+qzMNr3So+NXV53Ovj+sOKZCMqhTYOHGjAS+L3XuAoIGc
   /UrvhHnCCSSkpuKPgqyGK9LSddOIdYox1nGFToxhNmnBhTQ4SEq7RyyKh
   O4mIqK4sCJsLGMb+s+MMgqL0UBtUG4UEK+iBkFeHVKQsk3cOq9ocO/Zpj
   WweSIt18oG5aYuT/jYdMH26jsq1xgswZ5r2gFlMX5tnwW6Wys0mVUpRRN
   /oRtgKoB4AFapPMYAW7r9TGKOlC+gn/Yo9Ut5aSIV0l+cNxvila2KyPSN
   A==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177971"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:48 +0800
IronPort-SDR: kCHmZK412Re6ReVcdNJdhU5lplqMQn2Xbl/IQ0Ryra2sVwki+8aSuy7jcG4ULIrWi/9tjYjohV
 6ess6VcdGT1kALfs4ITCCbxN01jSOr5BEyFQjoldj8IJAMLC06u3dRa4znnge8SjWCf8Z61C6M
 R+XMZOaQ1eG1NynsHam6grhCaoKvXJ9g6ftIWx0jLVk9CZ35b3sxfqSfC8c6KdFGuLy35GeuC6
 hPknenFluJ+FqDSTWYbj+q/YI12bDALj2v+xQIvVM2GyCXWdZggJepvVJq/BREfKjnrs10oOAe
 2oI0hcZqsG7MP+r6rro/4rQs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:07 -0700
IronPort-SDR: TzXJIBo9J7UCMxdMNCw8BiE3B2iX9x8fVLkEveicXh5rXJ3cQmy7E8BDouQFXdrNezeXCUoTTB
 hQ4oDo+C6FRgQRpQmUsm9LUfGgSEWe9cifAnnmPs08Z9dMnui7MLAf2pr6QAeFZ0rdMVeYtoFd
 4W5ftOW+9bSeplk8pAL3tGUyRl0/t3o094lfToapPeMQw2fTEE1AA09f5JFIUX0Xg33zetEn7F
 ClcSHr6Ct9Du/DPN4+o32Bdp/DLW82+HhqioHR+TNqL3wyQE3ZtuLP0P+ffcj03l0wH6e5719X
 8EQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCS1qScz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422147; x=1653014148; bh=YR0xXxVtCgGiy2K4Hb
        A7uaHdw3xug5+Pz6/PMMqkrtA=; b=I4NWbc+nX9IW0yuEHWdipIVhj18AJFbNQP
        LMy/KuWOTqGitLAXYztpj/Y8uf0OtjCNWUygWEk6v/CLabhuvXqyqC+1UM/cHrCL
        QkVqEZuw7glIhk63AJ6q0V6ip81slln84w6IrRCaA//CYMukLlM3QsNCahuL2p0D
        6N+RY0n7hwEl6AYB7Qf0wTbcfYQQi9mjbqapaSJfJjam8V2MKXuKSrhNkbgU9kyg
        yboSJPVjPttkxuKO4EzJJ6qFzeBUCCu6i/9LCI2mNjmwaB8H09bF/tGfxkw5WclM
        uGauTVw/ikALMFmRDIixOacPFhbCzhAXhK7NEHtQdL9MZN5mhPsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sI1frqJx1IOa for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:47 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCR3m18z1Rwrw;
        Tue, 19 Apr 2022 19:35:47 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/8] zonefs: Clear inode information flags on inode creation
Date:   Wed, 20 Apr 2022 11:35:38 +0900
Message-Id: <20220420023545.3814998-2-damien.lemoal@opensource.wdc.com>
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

Ensure that the i_flags field of struct zonefs_inode_info is cleared to
0 when initializing a zone file inode, avoiding seeing the flag
ZONEFS_ZONE_OPEN being incorrectly set.

Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3614c7834007..75d8dabe0807 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1142,6 +1142,7 @@ static struct inode *zonefs_alloc_inode(struct supe=
r_block *sb)
 	inode_init_once(&zi->i_vnode);
 	mutex_init(&zi->i_truncate_mutex);
 	zi->i_wr_refcnt =3D 0;
+	zi->i_flags =3D 0;
=20
 	return &zi->i_vnode;
 }
--=20
2.35.1

