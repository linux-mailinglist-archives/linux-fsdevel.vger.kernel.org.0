Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2924A504A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiDRBOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiDRBOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318413CF1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244332; x=1681780332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fFxtRzmLVLJ9UNZt7AgxwatsrmXxFbO5FEifN0P6lis=;
  b=MjLSJ9DCVKLQ7yOP1YoJ3LE4z7+doSwSHINUQO5gq9uehDdhfPuSIIBD
   JFqao87MiAotOV0sKZPL7rvZdR+KDwKlnMXRp5gM8CXAF+uOZkz0ax/XM
   73IA3yKIBmCieQF7NydnUpMdFT/bGJFlBaUO6s/bu0pssKwSObfRGmOHe
   oi1BgFILeNnzgqJh/os7wnevwY45RdX8dMJV2SyxJElkgieF+s4f+O4IO
   1nZsj6h5BAjRsN8f1AxUxpJuAS2LCHJ2UhNqw52gpYdx2Kg3RJdiGU1S5
   c8qBCjaGswyRV3S8a0rQkDFQNTeNlZ4xl7y+dJApjxoHZKGIYPd/XIRA3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313766"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:11 +0800
IronPort-SDR: GjzBA7c1lIKeG4+/Sv0HqoqUDDpG2XI3pPAvVtKaP5uXV1zptFtM0hYLaZOcs/aaHLsf3OTu5Y
 BTONfXMAW38igg5atf6gqQQqKL2joE9DkvJap05dq7p6WofV9vpKxNm7JLWIGjUD1dfGgJPQaQ
 aFx/7WYqAQvuf7ubHXxw1xq1VHlkVSunuqMq4wAPMejaJeJRoGOaz7m07d4TjZLLlOBshdxqCh
 DGjNzaCml4gzPmouYIQzYW0DHx7O1Zd+A/3p2WVPcMuFpH33NC/JbjhQzgmfA/n0zzmcLWsAXo
 kVURoMGyhFPucuhdxPL9rtYf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:32 -0700
IronPort-SDR: ESyTqLhHnD8ZQnDWqtoRbdqMG/ewggINLOBfLH7XYTt0MZ/dN81ViUgZ7cGS45lVB9NumGAMVe
 Cq08EDRc3a3EdztkP9tT7UNMcvo/tFKtgU76xu1s8oKKEgc557KWhXOPrNpC8h1Y36TJcAtUu3
 dDGCvXicq/1xaCjkyPHDh8ysjgq6cZsfs1OyMfvDuyrLMX2hwzPMNq5teH43Ab3zWD2EjZzaBb
 xvk25MP6zwztYOFRfFRRSVk3LfSImLUk/fBzuMn3nDDLEmAb8alUQCpyqu2NSupMoWRWf2LFQP
 Q18=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRv0kJzz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244330; x=1652836331; bh=fFxtRzmLVLJ9UNZt7A
        gxwatsrmXxFbO5FEifN0P6lis=; b=E2zBESOrktmai5HMTFGZRQiIAkHddF1aDS
        24s0cW1393sPEumYfDOEsDkIVC0J6D2S3dejgIwPWM/z2kPu+2ZVU8jz8sze7wuq
        RTU8C6MKkX4tD5MIFDUAFsOG4iT1yaHfQGbanW0ScUUk9YYbxJCaxaEoowPC4Fjj
        4cFXxixxQM3gtoKW0cksZ02MJtg5WWTnBORkzRDkNomCNl+Zbw5g9CV713sv1LGh
        z7ckSMGYYycm58o46WonTjN8wLHOnPKr+ssELYQhrMLInIgbjK5Hkhb22X9hBMEJ
        YqDgxFDFp7/4Rc9TeNh+B397xNnlRCr8SEG7ndcc14ErG0vo0gxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RtFHyiOEzJJL for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRt2L38z1Rwrw;
        Sun, 17 Apr 2022 18:12:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/8] zonefs: Clear inode information flags on inode creation
Date:   Mon, 18 Apr 2022 10:12:00 +0900
Message-Id: <20220418011207.2385416-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

