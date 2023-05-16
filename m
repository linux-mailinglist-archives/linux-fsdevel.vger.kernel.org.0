Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E77053C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEPQ3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjEPQ3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:39 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1B93D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162917euoutp027189aabc2cbc8b155f626d1b91ccd418~frJitncke2601326013euoutp028
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230516162917euoutp027189aabc2cbc8b155f626d1b91ccd418~frJitncke2601326013euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254557;
        bh=AGwOrjkXnJsShntN6ZdjyKWZaxqN+Gn01iPpEEkziA0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AAAjJt7gtjzVj7q0qgovub2EjhB1ebSKwjPHrKx9qfwf0KRVd3RPTM1oSuqII+cEb
         D1oUHW3qtkNA45/LP245EeFfzou+7i3VyRhs2Mb0rtgk+Phq8qcutKdm0yqcf61brx
         RRYRKDouTPxy34DM0ricR4OtUCcGd45qCe3V3I2s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230516162917eucas1p1377a9c65d25ae3ac438e7f1101481c25~frJibMq8E2072920729eucas1p1p;
        Tue, 16 May 2023 16:29:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EB.C3.42423.C5FA3646; Tue, 16
        May 2023 17:29:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162916eucas1p190019c8af454bd55da6da37209f93024~frJiHeDOn2040620406eucas1p1c;
        Tue, 16 May 2023 16:29:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162916eusmtrp13e8f9f3a6137633a2e002b5157df09ec~frJiG3mpj1955419554eusmtrp1h;
        Tue, 16 May 2023 16:29:16 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-ae-6463af5ce206
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.47.10549.C5FA3646; Tue, 16
        May 2023 17:29:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230516162916eusmtip20b36ead6e668e2e4069fe56ae279f381~frJh3lKal2583225832eusmtip25;
        Tue, 16 May 2023 16:29:16 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:15 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 1/6] parport: Move magic number "15" to a define
Date:   Tue, 16 May 2023 18:28:58 +0200
Message-ID: <20230516162903.3208880-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned2Y9ckpBke/W1mc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJWx7d1WpoL7nBWT5n9ga2Ds5uhi5OSQEDCROPfpAFsXIxeHkMAKRonbh+8xQThf
        GCV27epnh3A+M0r8v/IHyOEAa/m9NBgivpxRYsmPv4xwRacW/oTq2MIocaNzPxvIEjYBHYnz
        b+4wg9giAuISJ05vButgFnjKKHFv72qwImEBZ4lTyx6ygtgsAqoS/zdPAWvgFbCVaD8+kwXi
        WnmJtuvTGUFsTgE7ifdrNjFB1AhKnJz5BKyGGaimeetsZghbQuLgixfMEL1KEu0TH7BC2LUS
        p7bcAntUQuAOh8SR3pXsEAkXiWdLHzNC2MISr45vgYrLSJye3MMC0TCZUWL/vw/sEM5qRoll
        jV+ZIKqsJVquPIGGkqPEsznMECafxI23ghAH8UlM2jYdKswr0dEmNIFRZRaSF2YheWEWkhcW
        MDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEwxp/8d/7SDce6rj3qHGJk4GA8xSnAw
        K4nwBvYlpwjxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpg
        CvvcX5g7qexMRrDBabu789OePF8QEB3nfrTll10U38MzywvzUpWN5/9sfKV8ynrd6s8+Upqd
        vn7y9Z/4/3/X+m6x94tx8/kul6kWvc+MgrvLjx3wdPA2EHrHxnGG0/XJ44dv7Q880+d9fvCk
        rLv/pun8+6y/nv/+2ltwxTaWzpa3LLf8c579mTVRLpdBpOGE/Wa9N6nciYn3lK3sT8mnt2mW
        bWza/UFbYGPezGt/frGzHzifHn9nzpaFC1Yxa3E5FXwSEfSRmBD79uKUmbNv5C4MkCy4JraG
        u3ey1Jx5M3fsvn1RecGbx8mBG+SmrtrVnT2pUctMeudC/2dLivOX+FxK3DfnX7WlmtaWXwIX
        ZJVYijMSDbWYi4oTAcmsjaWgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7ox65NTDOY0qVuc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex7d1WpoL7nBWT
        5n9ga2Ds5uhi5OCQEDCR+L00uIuRi0NIYCmjxKb1x9i6GDmB4jISG79cZYWwhSX+XOsCiwsJ
        fGSUWDjZBKJhC6PE4lsfGUESbAI6Euff3GEGsUUExCVOnN4MFmcWeMwoMeegLIgtLOAscWrZ
        Q7ChLAKqEv83TwGr5xWwlWg/PpMFYpm8RNv16WC9nAJ2Eu/XbGKCWGwrMXF5DwtEvaDEyZlP
        WCDmy0s0b53NDGFLSBx88YIZYo6SRPvEB1AP1Ep8/vuMcQKjyCwk7bOQtM9C0r6AkXkVo0hq
        aXFuem6xoV5xYm5xaV66XnJ+7iZGYOxtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIb2JecIsSb
        klhZlVqUH19UmpNafIjRFOjPicxSosn5wOjPK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8s
        Sc1OTS1ILYLpY+LglGpg2jwvMN2StUzuAGNtwTbfl0e74yecvGBhwGyTzVgit6K16eUci10B
        fT8y2GdJbO62/dfXKGZkfaWfxWZ6QdyP/MuchnJTpgXbcN7hyzAo+WN3L8cr6dKHbR/CZVz6
        u90VLXbkujJkWqkfcp8ifkWK6dUjv2D3ch7FA13SyUelDNJLwuovd8jtOr3op/Uq7kgL5Qgd
        dn9V1kcM7oVu/oJPxW41BF/+Lfyx2V3w1ZrbrexhrYVCuxNYN3n110ilfjsmt32mZVbwV5db
        m1snbuPcJGjrcLqapU/wYvCUVj8zpijGQ9N5vqy//O1P93sB8ajAEwKvG+7sncuj/1Cs1rj6
        y4pHaxZtf6KyR//MXyWW4oxEQy3mouJEAHqYnt1GAwAA
X-CMS-MailID: 20230516162916eucas1p190019c8af454bd55da6da37209f93024
X-Msg-Generator: CA
X-RootMTR: 20230516162916eucas1p190019c8af454bd55da6da37209f93024
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162916eucas1p190019c8af454bd55da6da37209f93024
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162916eucas1p190019c8af454bd55da6da37209f93024@eucas1p1.samsung.com>
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

