Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83625732AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjFPJAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjFPI7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760D30FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085942euoutp02aa1deced84b1f2cbdbd746814f9fed42~pGA2TzAJ_3175431754euoutp02V
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230616085942euoutp02aa1deced84b1f2cbdbd746814f9fed42~pGA2TzAJ_3175431754euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905982;
        bh=k6w26tA5MuuVW167a8RaVYBvH9le+QbGGVR79rArU/4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FctFWHJPsD3dDo/3kFxh3zjFrLgqE8tEobwKRK/rDJNSz3MUbE0MGaJ5DTVgL0xA+
         Q7B3ynnHVixyIUSMEdvNTk9kkZu49WWQE8DiZoftcFjCsWkdw5zKLPSEjzhSyEPRu6
         lrIdn+HJoLIAw4NnESjVEzLcUCmzDFMOt9zI/i2c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230616085941eucas1p21635b3c7e00f84049d5b66ea5fcd22a3~pGA2OB0bz0552005520eucas1p2y;
        Fri, 16 Jun 2023 08:59:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 51.D4.11320.D742C846; Fri, 16
        Jun 2023 09:59:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085941eucas1p152b54db1511bfdd1afab32621aec847e~pGA1_NAv72668626686eucas1p1U;
        Fri, 16 Jun 2023 08:59:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230616085941eusmtrp2ea835b8ccfdbc7908ca8719bd6ab21c5~pGA19aaMh1371213712eusmtrp2y;
        Fri, 16 Jun 2023 08:59:41 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-5e-648c247d4969
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.AE.14344.D742C846; Fri, 16
        Jun 2023 09:59:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085941eusmtip20ee9de30262fab02e77e310597033a2d~pGA1xagG11986719867eusmtip28;
        Fri, 16 Jun 2023 08:59:41 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:40 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 7/8] sysctl: Remove debugging dump_stack
Date:   Fri, 16 Jun 2023 10:59:21 +0200
Message-ID: <20230616085922.3066990-8-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djPc7q1Kj0pBrcWm1rs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlnJ/4kbmgh6XiwJQn7A2M
        25m7GDk5JARMJNZN+MPYxcjFISSwglFi6vI1rBDOF0aJjysuMUM4nxkl3p24CtfSc7gPqmo5
        o8TrOzNY4aqONS1nh3C2Mkos2byVBaSFTUBH4vybO2DtIgLiEidOb2YEsZkFJjBKzDrEAWIL
        C1hLrL7VAxZnEVCVONJ1E8zmFbCVWLV9FhPEanmJtuvTweKcAnYSjyc1sEPUCEqcnPmEBWKm
        vETz1tnMELaExMEXL4BsDqBeZYlPzxMgxtRKnNpyiwnkTgmBPRwSqw7MgnrNRWJ172sWCFtY
        4tXxLewQtozE/53zoRomM0rs//eBHcJZzSixrPEr1HXWEi1XnrBDbHOUePk2GsLkk7jxVhDi
        Hj6JSdumQ93DK9HRJjSBUWUWkg9mIflgFpIPFjAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dL
        zs/dxAhMGqf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8C470ZUixJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgcnpSdIGR98XxroR/0OXXpyrvf1pa5eMmqoq
        59H3py93Pf8lP+V0dn14x7cHizd67WARLFuefzLjJM+CosyHP0KPNpuxHj5tpDdn5qyZ4T/2
        L+Y9fWG/fYrvt0/11gVnGda4Fvu/eXN14W7mEuVru2U36e17ynTvRHHShNvdny86lW6u1toT
        duZCxFfRa28Sr09dsKF6Xo7M+kalyA1R2QLyKjNfhKfcr1TKn7hLsSDKPLWV8W7WmWg3kyp1
        W8NHod9WPdtXO/PAx0CtJMUv3wzepc+PjWVp+L/mguPbP85p9/betS/732Xb9chzw1Hz4oLa
        +fFMtr2Nfw4rXFJxTYko3LOsqfrKii3L8pNWWdxWYinOSDTUYi4qTgQAArDPqIkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7q1Kj0pBkeeKFjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlnJ/4kbmgh6XiwJQn7A2M25m7GDk5JARMJHoO97F2MXJx
        CAksZZSY+uM0O0RCRmLjl6usELawxJ9rXWwQRR8ZJfoePGaBcLYySvT8f8wGUsUmoCNx/s0d
        sLEiAuISJ05vZgSxmQUmMErMOsQBYgsLWEusvtUDFmcRUJU40nUTzOYVsJVYtX0WE8Q2eYm2
        69PB4pwCdhKPJzWAXSQEVNN4u58dol5Q4uTMJywQ8+UlmrfOZoawJSQOvngBZHMAzVGW+PQ8
        AWJkrcTnv88YJzCKzELSPQtJ9ywk3QsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERtS2
        Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzLTnSlCPGmJFZWpRblxxeV5qQWH2I0BXpzIrOUaHI+
        MKbzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYxB8n7eBvSlyy
        7Lxeb57Et5ZU5v6c6fEOy8LfPPDPlZkjeFc0Qux7HOfmr6bO1UWeU2qcOu1Pd9vwZmZGPXv0
        91OcGYv8aZ/99/y2VVx9vvOMRNd+2Qw+macMOVIVX53kPn/hT5u7YdakVcya+t3q5+UsKzjS
        OzYesQt+H9Lkt4JH1vXW+10XtISVPq684rV/74wWV3aTCyZ9y7NiWv8fNs0MdY6cqxMomF9g
        PYv3fEtiMNulsKabZpkF5WvcOH3veSz9aDRP+vYTfvkVSloxNgb6l5dozNCrZ39Xd23xmuRv
        ezxLsp6VZ2U2mu4+fDDeIOveHqYpt5ddPye0RT2ZScuqvf+Z+e279SYem5VYijMSDbWYi4oT
        AZlX6PsxAwAA
X-CMS-MailID: 20230616085941eucas1p152b54db1511bfdd1afab32621aec847e
X-Msg-Generator: CA
X-RootMTR: 20230616085941eucas1p152b54db1511bfdd1afab32621aec847e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085941eucas1p152b54db1511bfdd1afab32621aec847e
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085941eucas1p152b54db1511bfdd1afab32621aec847e@eucas1p1.samsung.com>
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

Remove unneeded dump_stack in __register_sysctl_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8873812d22f3..07804097f997 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1406,7 +1406,6 @@ struct ctl_table_header *__register_sysctl_table(
 	spin_unlock(&sysctl_lock);
 fail:
 	kfree(header);
-	dump_stack();
 	return NULL;
 }
 
-- 
2.30.2

