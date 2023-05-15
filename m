Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690167025D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbjEOHPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjEOHO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:57 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55310D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071455euoutp02a0962504203d204e925b9d6f40a7a45d~fP8OdFF-l1751317513euoutp02q
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230515071455euoutp02a0962504203d204e925b9d6f40a7a45d~fP8OdFF-l1751317513euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134895;
        bh=wOcIDhuiqBxMdQKtjn6oQCYKMuhnFN8tdpIeGEFWguE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=m8m/MH1DJ0qDwhxr2zJ6IZnzV6E0nFohs6sU5tFe/Kt7Vi5sWok1WpeSOLEVmSvUr
         NV08DufANDJ6ApuxX7it7WzVBBp5lYniSoKdvz5tZ3QcalWSm/in6arJnOy6XI6nyd
         syg4fRq3cFC+NABNstcsQEWoc6NMgogTi8yKL8+A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515071454eucas1p13e6c044a4bb6960a4996cd7ac6e48f7e~fP8OMAct00789107891eucas1p1Z;
        Mon, 15 May 2023 07:14:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.71.42423.EEBD1646; Mon, 15
        May 2023 08:14:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515071454eucas1p2ae422c4bad233cd6170dce9e7f8304d9~fP8N5YQIl0188101881eucas1p2b;
        Mon, 15 May 2023 07:14:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515071454eusmtrp25e55d254521c96bd2b43c1c6087c1412~fP8N4pi2G2610526105eusmtrp2N;
        Mon, 15 May 2023 07:14:54 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-98-6461dbee2da2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4E.D9.14344.EEBD1646; Mon, 15
        May 2023 08:14:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071454eusmtip145bbc0b7e77efb759a927071b2b33359~fP8NsEp1f3254032540eusmtip1I;
        Mon, 15 May 2023 07:14:54 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:53 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 4/6] parport: Remove register_sysctl_table from
 parport_default_proc_register
Date:   Mon, 15 May 2023 09:14:44 +0200
Message-ID: <20230515071446.2277292-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd13txNTDJqXaVqc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJVx58RC5oLZ3BUXP/WwNTAu5+xi5OSQEDCR2LBnBnsXIxeHkMAKRonV/1pZIJwv
        jBJvdh1khXA+M0rM717NDNPyd+VjJojEckaJ86dWscBVvft0FmrYFkaJG3Ovg7WwCehInH9z
        B8wWERCXOHF6MyNIEbPAU0aJuf96mUASwgLxEtt79gPZHBwsAqoSc9YYgoR5BWwl1nceYIRY
        LS/Rdn06mM0pYCexbv9RJogaQYmTM5+wgNjMQDXNW2czQ9gSEgdfvIA6W0ni65teVgi7VuLU
        lltgL0gIPOCQWDS1lRFkr4SAi8SLp5UQNcISr45vYYewZST+75wPVT+ZUWL/vw/sEM5qRoll
        jV+ZIKqsJVquPIHqcJRY/qCPCWIon8SNt4IQB/FJTNo2nRkizCvR0SY0gVFlFpIXZiF5YRaS
        FxYwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITDGn/x3/tINx7quPeocYmTgYDzFK
        cDArifC2z4xPEeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp
        1cCkZ+fWFvjdIO/UC8lLH9cft/i82nz6MiXrxXtXZE7+/s6dQSnjzuv9q2yP8e0pP7lCSacn
        P3aNZkgcd9OyJtVpXcpST60eGCW558d1/+VZJhwoEyQhZ8liavjsoAZbzZbzq28qs/otSt9s
        1VrsI7yLvytCn9HUQ1Hb6h+PXp9j0LYJB9sm5k5QSvj+1WqzutsZxt3qAQeFRQztrEIFmXhC
        dV8bO+ayMO76F3uw2Hs5X+D9B6L9rdf2MF32a3xQ8rD9gY6yx5Hb/yYL2u+NuFqXbPsp2Gbb
        PMvGp7tWzs2uS7l947fP954X/I4yl3JiDVKeT9y6/pnxjcV/fZfU5fN4+m+SetbrIWqkMasx
        U4mlOCPRUIu5qDgRAObF5nKgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7rvbiemGFx4LmZxpjvXYs/ekywW
        l3fNYbO4MeEpo8WB01OYLZbt9HNg85jdcJHFY+esu+weCzaVemxa1cnm8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GnRMLmQtmc1dc
        /NTD1sC4nLOLkZNDQsBE4u/Kx0xdjFwcQgJLGSV2bP3KDJGQkdj45SorhC0s8edaFxtE0UdG
        iVvtC6E6tjBK3L18iAmkik1AR+L8mztg3SIC4hInTm9mBCliFnjKKDHz0FOwImGBWInbE78C
        2RwcLAKqEnPWGIKEeQVsJdZ3HmCE2CYv0XZ9OpjNKWAnsW7/UbBWIaCa07u2sULUC0qcnPmE
        BcRmBqpv3jqbGcKWkDj44gXUB0oSX9/0Qn1QK/H57zPGCYwis5C0z0LSPgtJ+wJG5lWMIqml
        xbnpucVGesWJucWleel6yfm5mxiB8bft2M8tOxhXvvqod4iRiYPxEKMEB7OSCG/7zPgUId6U
        xMqq1KL8+KLSnNTiQ4ymQG9OZJYSTc4HJoC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS
        1OzU1ILUIpg+Jg5OqQYmrinODSybJ3T+XrmebZPgh3mij8Jq1j1kv2up+Ej2sM0Tw+9n35yc
        vtorRHOBlM6q4LeT9ERZuKN+OGZ+PMSu2mT0aEP/6j8vrCpO7Fngvj3C4EWb4wm+2Po5VaxX
        /3fzfu1Id1gkdPxSwiaBC9Zz5M8/WiAnt0+Tb9JWnne5+8PM9s8U6Q1oOOrK9p9F8vTzuJ+m
        ScbMJQ/U855emKte/Fm4Kjj/weLcBd/M+VQdPNVTvt3dYJF667b4mpWsL3afkN0T/+Ks6M0P
        14w8F91/meEkczkqwWOnXZf+09Q9+y79Vj2c/GhH46EkicW6QiUPQ/fK1EXw56XPMGPyuegf
        wLjstAeHLvePtBlNHVNalFiKMxINtZiLihMBYJZTp0gDAAA=
X-CMS-MailID: 20230515071454eucas1p2ae422c4bad233cd6170dce9e7f8304d9
X-Msg-Generator: CA
X-RootMTR: 20230515071454eucas1p2ae422c4bad233cd6170dce9e7f8304d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071454eucas1p2ae422c4bad233cd6170dce9e7f8304d9
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071454eucas1p2ae422c4bad233cd6170dce9e7f8304d9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. Simply change the full path "dev/parport/default"
to point to an already existing set of table entries (vars). We also
remove the unused elements from parport_default_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 902547eb045c..56f825fcfae6 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -430,22 +430,6 @@ parport_default_sysctl_table = {
 			.extra2		= (void*) &parport_max_spintime_value
 		},
 		{}
-	},
-	{
-		{
-			.procname	= "default",
-			.mode		= 0555,
-			.child		= parport_default_sysctl_table.vars
-		},
-		{}
-	},
-	{
-		PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir),
-		{}
-	},
-	{
-		PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir),
-		{}
 	}
 };
 
@@ -598,7 +582,7 @@ static int __init parport_default_proc_register(void)
 	int ret;
 
 	parport_default_sysctl_table.sysctl_header =
-		register_sysctl_table(parport_default_sysctl_table.dev_dir);
+		register_sysctl("dev/parport/default", parport_default_sysctl_table.vars);
 	if (!parport_default_sysctl_table.sysctl_header)
 		return -ENOMEM;
 	ret = parport_bus_init();
-- 
2.30.2

