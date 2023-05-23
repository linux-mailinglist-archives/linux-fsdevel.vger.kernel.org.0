Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2ED70DC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjEWMWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjEWMWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E1109
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122226euoutp01ba8b842fb32ce9051c4abffddd461049~hxTBO1uol1696116961euoutp01a
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523122226euoutp01ba8b842fb32ce9051c4abffddd461049~hxTBO1uol1696116961euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844546;
        bh=PSEJhzKvpVyR/pqvYhGYpQKS9kejgYF7JkoWjFXjyTo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=TsVPzu/gdpuIbDymwA0yuai6EvAGTVxv9zZCeCtZlweKsNZDXQ5/lO9FJ9Cb58xJa
         vogW/6zQr8+W3wesETNS2BzT//jkj+zZJJYT0kamB1udzFSYiupuMcLkjkpIEOSiBt
         pWXzowuq+qvYIm8zQKDZzo3xe/cUHuP6zPyfdzvQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122226eucas1p1e18f5acfe5110c795265c93f5efcee4f~hxTA3Iiwz2731327313eucas1p14;
        Tue, 23 May 2023 12:22:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.16.11320.200BC646; Tue, 23
        May 2023 13:22:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122226eucas1p2bc0a2c060f01f460a11e90545f9da9aa~hxTAhQ5iA2886828868eucas1p2C;
        Tue, 23 May 2023 12:22:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122226eusmtrp25d4fcc81b8357666bf232d27fc9b313a~hxTAgcCMZ0635006350eusmtrp2a;
        Tue, 23 May 2023 12:22:26 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-7f-646cb0026184
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.71.14344.100BC646; Tue, 23
        May 2023 13:22:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122225eusmtip1067406525da12eb8ce270bbec5693002~hxTAU8pIc1745417454eusmtip10;
        Tue, 23 May 2023 12:22:25 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:25 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 1/8] parport: Move magic number "15" to a define
Date:   Tue, 23 May 2023 14:22:13 +0200
Message-ID: <20230523122220.1610825-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7pMG3JSDB49k7R4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxoQDR9gKpnBV3H92grWBcTdHFyMHh4SAiUTjW90u
        Ri4OIYEVjBJrljxjhHC+MEps+z2NrYuRE8j5zChxfTMHiA3ScLflP1TRckaJe58uMcEVHXlX
        C5HYwijxdsENsASbgI7E+Td3mEFsEQFxiROnN4N1MwvsZJLo77wFtkJYwFli1dzDjCA2i4Cq
        xJtV58AaeAVsJdZv2cEGsVpeou36dLAaTgE7iUPP9rFC1AhKnJz5hAXEZgaqad46mxnClpA4
        +OIFM0SvksTqrj9Qc2olTm25xQRyhITADw6JIxueQhW5SEz9PIEdwhaWeHV8C5QtI/F/53yo
        hsmMEvv/fWCHcFYzSixr/MoEUWUt0XLlCVSHo8SSNSD/g4KYT+LGW0GIi/gkJm2bzgwR5pXo
        aBOawKgyC8kPs5D8MAvJDwsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpp/T/45/
        2cG4/NVHvUOMTByMhxglOJiVRHhPlGenCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQ
        nliSmp2aWpBaBJNl4uCUamAK+eJyzm7+1+/XTDP4FbkKKgUEzrEtcV1gXLzhdpASNwfjwlv3
        Hwh81Lta1vkgwPZg3OarnKeOXVD34RWyme2XVd+3PPhFp4SV07e0dZ1nlP4nbDweySKV2ljJ
        L3Lha9rFawuXfeUpLA5ZULKz+d55lecP/v3h4/2yzdXib7RjlYtZ8k3FHYvnWy23M1ljJVx4
        5u4RkS6NvH3O8fenSb0+sz5aOP+W3snNZz692Tx9ZXDw27PfT3Ltf6K6jmV2c/ytG2us76Vp
        rg1g8Y77WnXg703v+QbT3NmPbhRNVchKuOI598bapxurzz3UOn1Y+Lwqz9ulmYXvA9aaNPI+
        WvnUKF+N98kxVasXF4/tuj0zWYmlOCPRUIu5qDgRAIcivAGuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7pMG3JSDKatY7J4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexoQDR9gKpnBV3H92grWBcTdHFyMnh4SAicTdlv+MXYxcHEICSxklrqz/wQSRkJHY
        +OUqK4QtLPHnWhcbRNFHRokpd+4wQThbGCWebNrJDFLFJqAjcf7NHTBbREBc4sTpzWBjmQW2
        M0lM+LuLDSQhLOAssWruYUYQm0VAVeLNqnNgDbwCthLrt+xgg1gnL9F2fTpYDaeAncShZ/vA
        zhACqml9tYkVol5Q4uTMJywgNjNQffPW2cwQtoTEwRcvmCHmKEms7voDNbNW4vPfZ4wTGEVm
        IWmfhaR9FpL2BYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjc9uxn1t2MK589VHvECMT
        B+MhRgkOZiUR3hPl2SlCvCmJlVWpRfnxRaU5qcWHGE2B/pzILCWanA9MEHkl8YZmBqaGJmaW
        BqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUzrVZ9nG4eZZJzyus/4p/1PqevT+5E/
        fVvupeUfPelg5z533+RXz4/6mO7YfMvn7dtX/9I/fmudvXFPy6QFk1ZIxk2dVzMrVG9P/CKZ
        +h0hx/S3vTk1xfWGncVzFQMD9S+vjmt/CeLKXLitmcFPMmqnbVPilQ3PY0769Xn4rNGf842D
        P/Hl3+cqWzfFetZUH3kfveMbS/cxLcPnBRzMs8tcJ2pYzD0msz5rss2lye8Wvj+0pOZBXvOr
        FI2CJztq1+1atFA19GWaYHTgnI0HTtRe/uu9T7qkYPI0Ab6HAovWp15fJKHCYrRQVWliK9Oq
        R2wBVrKCB6wSZy6aa/yr6IfwRb3CiVm+657PPHpXvcywTYmlOCPRUIu5qDgRABQ9P3lYAwAA
X-CMS-MailID: 20230523122226eucas1p2bc0a2c060f01f460a11e90545f9da9aa
X-Msg-Generator: CA
X-RootMTR: 20230523122226eucas1p2bc0a2c060f01f460a11e90545f9da9aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122226eucas1p2bc0a2c060f01f460a11e90545f9da9aa
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122226eucas1p2bc0a2c060f01f460a11e90545f9da9aa@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Put the size of a parport name behind a define so we can use it in other
files. This is a preparation patch to be able to use this size in
parport/procfs.c.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/share.c | 2 +-
 include/linux/parport.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 62f8407923d4..2d46b1d4fd69 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -467,7 +467,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	atomic_set(&tmp->ref_count, 1);
 	INIT_LIST_HEAD(&tmp->full_list);
 
-	name = kmalloc(15, GFP_KERNEL);
+	name = kmalloc(PARPORT_NAME_MAX_LEN, GFP_KERNEL);
 	if (!name) {
 		kfree(tmp);
 		return NULL;
diff --git a/include/linux/parport.h b/include/linux/parport.h
index a0bc9e0267b7..243c82d7f852 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -180,6 +180,8 @@ struct ieee1284_info {
 	struct semaphore irq;
 };
 
+#define PARPORT_NAME_MAX_LEN 15
+
 /* A parallel port */
 struct parport {
 	unsigned long base;	/* base address */
-- 
2.30.2

