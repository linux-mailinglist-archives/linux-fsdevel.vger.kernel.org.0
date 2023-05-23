Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35FA70DC74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjEWMWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbjEWMWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82711F
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122234euoutp01b9cd0018141c5403163a66d2be7ced7a~hxTH8Xg-U1724917249euoutp01W
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523122234euoutp01b9cd0018141c5403163a66d2be7ced7a~hxTH8Xg-U1724917249euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844554;
        bh=QqhHAxqdZ9zwu193bF6IzoCs6DWDxorB5tYMiEmfePM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RPx54jD6tED1Tft6UIeXuw/GhU8Q5UFG3cFrROA6OtLM33S1bZ8H8xbhiUh4OGeej
         CdycuRWhzxL9pSUaYH4HxTyGbVo4IS4A/61Ad14oh6lnuKC5t1rz2VVTuL5eFR6o/T
         oT5ntZBeVi74DGnkklqwkIOK7ZNlyYfGjL+nMiwE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122233eucas1p19b3effbf7c26fea6a587059aa3ffd7dc~hxTHrDLwU1810218102eucas1p1V;
        Tue, 23 May 2023 12:22:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.16.11320.900BC646; Tue, 23
        May 2023 13:22:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122233eucas1p1cb488b94dc2449b3bd0314b1f536a6e9~hxTHWdCVh2731327313eucas1p1-;
        Tue, 23 May 2023 12:22:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122233eusmtrp26992cefa0f96faee69ec101d2242b608~hxTHVx4bn0682206822eusmtrp2T;
        Tue, 23 May 2023 12:22:33 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-a0-646cb009b381
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.BF.10549.900BC646; Tue, 23
        May 2023 13:22:33 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122233eusmtip10cbbd9f4c983e0e1296a2d4a9227bbe4~hxTHMp4Nr0731007310eusmtip1U;
        Tue, 23 May 2023 12:22:33 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:32 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 5/8] parport: Removed sysctl related defines
Date:   Tue, 23 May 2023 14:22:17 +0200
Message-ID: <20230523122220.1610825-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7qcG3JSDO6917R4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxu3pH5gLDnJWHDlwia2BcRt7FyMnh4SAicSunX9Z
        QWwhgRWMElvXs3QxcgHZXxglTs+czAjhfGaUWDPvNFzHqvP7mSASyxkluk/1McFVnTvxnQ1i
        1hZGiQ89jCA2m4COxPk3d5hBbBEBcYkTpzeDjWUW2Mkk0d95C6xBWMBe4vrHf2BFLAKqEiv6
        l4PZvAK2Eru6VrJCrJaXaLs+HWwop4CdxKFn+1ghagQlTs58wgJiMwPVNG+dzQxhS0gcfPGC
        GaJXSWJ11x82CLtW4tSWW2BXSwh84ZB4PW8C1AIXibMf/0A1CEu8Or4F6mcZif8750M1TGaU
        2P/vAzuEs5pRYlnjVyaIKmuJlitPoDocJQ4d/QQ0iQPI5pO48VYQ4iI+iUnbpkOFeSU62oQm
        MKrMQvLDLCQ/zELywwJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBCej0v+NfdjAu
        f/VR7xAjEwfjIUYJDmYlEd4T5dkpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5ak
        ZqemFqQWwWSZODilGpi2ynw45KNQ8Cj3vkX7T9X1oSmvY12KX9vc6lNd0zO9Uz6CeeWC+9UB
        wtXbS+MkTPKaGow//Ze9PPvzJi2XCauZrm6abTjnxpk9m55mlG0vTdxbLnE7aFuXlT1L1ben
        638eufCwrTRkkt/j6mkXUrZ0fXqyXWCjfs7tmO4tTRV3/6xc9Fema3qW3g6mJXt/Lu/0P/L2
        ick3DtfWU547jzQav2vNTFuXfPJC9MnY94/5X+099Jj3Zpw3+03vyReP58feMu6cI3O0blLd
        uqRdb0L+Hag40zlvWkSkvtPzvcmli19KnF8v1vuqWuq97NZ70ULWU5fLFUn59Tqx7MyyKRRT
        /TTdIXGPiF38+pQtLaK8SizFGYmGWsxFxYkAbHMTcq8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7qcG3JSDA78E7d4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexu3pH5gLDnJWHDlwia2BcRt7FyMnh4SAicSq8/uZuhi5OIQEljJKLL08hREiISOx
        8ctVVghbWOLPtS42iKKPjBIP1n9ghnC2MEp8utrABlLFJqAjcf7NHWYQW0RAXOLE6c2MIEXM
        AtuZJCb83QVWJCxgL3H94z+wIhYBVYkV/cvBbF4BW4ldXSuh1slLtF2fDnYGp4CdxKFn+8Di
        QkA1ra82sULUC0qcnPmEBcRmBqpv3jqbGcKWkDj44gUzxBwlidVdf9gg7FqJz3+fMU5gFJmF
        pH0WkvZZSNoXMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzPbcd+bt7BOO/VR71DjEwc
        jIcYJTiYlUR4T5RnpwjxpiRWVqUW5ccXleakFh9iNAX6cyKzlGhyPjBB5JXEG5oZmBqamFka
        mFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MGX8FtBy8lgfUhPL9Obp96Ztea9k/PKv
        6i3lWXijVyBYcP3mDVqOaxTT1/X/WCGSV/p4aXO9+NUJ3i+V7wttVPYTCHgQ+Xnxmb8nedNd
        8wW6NZmvzP9f4TLl76bWXsH5EpEnG8/vLldRc3K0FTFpl08W2nVHO9anwLc/Z6lf7j/JiZt/
        Cf5o/fTx0HSZ4nPP9VZvrxPK3NGg/CDtqN8CC7uUC7P+LXvMtfNS7QJXN6WZHndYljAK9/2J
        O8XpmLxVY6sWQ87dnFksPKwTi+T91xmxJxvJKPhPXfzaxj/+VHuvtlCq6Ptes8OG29LfTnmS
        07/0gixfmjtHyM/+4qkKoS2CqkEtivkPT9oaS9srsRRnJBpqMRcVJwIA+pBZ+FgDAAA=
X-CMS-MailID: 20230523122233eucas1p1cb488b94dc2449b3bd0314b1f536a6e9
X-Msg-Generator: CA
X-RootMTR: 20230523122233eucas1p1cb488b94dc2449b3bd0314b1f536a6e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122233eucas1p1cb488b94dc2449b3bd0314b1f536a6e9
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122233eucas1p1cb488b94dc2449b3bd0314b1f536a6e9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The partport driver used to rely on defines to include different
directories in sysctl. Now that we have made the transition to
register_sysctl from regsiter_sysctl_table, they are no longer needed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 1a26918d2cc8..cbb1fb5127ce 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -243,13 +243,6 @@ do {									\
 	return 0;
 }
 
-#define PARPORT_PORT_DIR(CHILD) { .procname = NULL, .mode = 0555, .child = CHILD }
-#define PARPORT_PARPORT_DIR(CHILD) { .procname = "parport", \
-                                     .mode = 0555, .child = CHILD }
-#define PARPORT_DEV_DIR(CHILD) { .procname = "dev", .mode = 0555, .child = CHILD }
-#define PARPORT_DEVICES_ROOT_DIR  {  .procname = "devices", \
-                                    .mode = 0555, .child = NULL }
-
 static const unsigned long parport_min_timeslice_value =
 PARPORT_MIN_TIMESLICE_VALUE;
 
-- 
2.30.2

