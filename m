Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE983720010
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjFBLHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbjFBLH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70D1BD
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:07:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110647euoutp024c8d01f22cd46006ea1e7be678114c90~k0t0DqSN-2929129291euoutp02v
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602110647euoutp024c8d01f22cd46006ea1e7be678114c90~k0t0DqSN-2929129291euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704007;
        bh=hYhRLkPi8FoDCUTYM89A2RNac7EIMazIQAo5IMuTC+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=F+57COksDqKZDi9A2lx6QJL9Yj7wZ4Sw+rw2cAUwYlNDrjcRTMPcjF8Ty4XEwVn12
         Xpz7SKanbB/wxdTwzMhkcWPl+sdDFGmSIC1tnns1mV8uYocjdp1M4V1vxvp4HBuw42
         i3eNRYuKjLZOBTj9ATfCwB6gEvmRaZ2vrYE5G5Js=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110647eucas1p227c666ec3d609dbb8f6e79cc0a905259~k0tz1tsdT2051020510eucas1p2a;
        Fri,  2 Jun 2023 11:06:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7E.7F.37758.64DC9746; Fri,  2
        Jun 2023 12:06:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110646eucas1p115dd1191419eb10bca47c9a6eefa6450~k0tzlCui_0212702127eucas1p1V;
        Fri,  2 Jun 2023 11:06:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230602110646eusmtrp2700e84b8f332ee8e4b33ed0517dc2f76~k0tzkj-cx2226722267eusmtrp2J;
        Fri,  2 Jun 2023 11:06:46 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-8a-6479cd464dc5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.DB.14344.64DC9746; Fri,  2
        Jun 2023 12:06:46 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230602110646eusmtip2e919595238ac8b6993427301d6341e89~k0tzaxyaX1061810618eusmtip2F;
        Fri,  2 Jun 2023 11:06:46 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:45 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 3/8] test_sysctl: Group node sysctl test under one func
Date:   Fri, 2 Jun 2023 13:06:33 +0200
Message-ID: <20230602110638.789426-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87puZytTDJZutrLYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKuDatn7XgEXfFvRvvGBsY
        r3F2MXJwSAiYSEy9ztPFyMUhJLCCUeLLrkNsEM4XRokP6zuYIZzPjBJrLrxm72LkBOtY+2oV
        C0RiOaPE9SPL2eCq7sw6ApXZwihx5PYqVpAWNgEdifNv7jCD2CIC4hInTm9mBCliFpjAKNG3
        7hcLSEJYwF2ibfk/NhCbRUBFovHfbSYQm1fARmL2ni5miN3yEm3XpzOC2JwCthKHTp9hg6gR
        lDg58wnYHGagmuats5khbAmJgy9eQPUqS0xY95sVwq6VOLXlFhOEfYBDYv0VfQjbReLTxDVQ
        cWGJV8e3QP0sI/F/53wmkKMlBCYzSuz/94EdwlnNKLGs8StUh7VEy5UnUB2OEtcuLGKHhDGf
        xI23ghAH8UlM2jadGSLMK9HRJjSBUWUWkhdmIXlhFpIXFjAyr2IUTy0tzk1PLTbOSy3XK07M
        LS7NS9dLzs/dxAhMG6f/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8AqFlacI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYNr8MWtPmkrdxOCfKYvKQu0iRBT1
        lqYfs1/mXHFISnv306xYbimTFleDuvmcqcFFeo5l3HN3LnCOfflHJ6Gu9laLRcoxwS3Z14Wy
        UvkbLisLu5pFOkqEKwrqlbpnnWa2uNr1coqogf039dDLj/nv7zj9VP6u7ATTI6HMfvvftBry
        irgYL18f/nylgpndxy4RwVeRsaVHF8+dNDnlbUQkF3/c86cLn/AeFl9/fP/RU/9uXHNLEZHZ
        cuFr9978dU9Lm7hPpjayBBvy6wWXJLGVT3ttXnNvitJUpzksxzQXGHmxZwY/uCWd2eTocloq
        xkyz8ZWVXofkxGt787iXXjT8wuydzRKue282T6iQJJsSS3FGoqEWc1FxIgArbRZoigMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7puZytTDH5+U7fYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLuDatn7XgEXfFvRvvGBsYr3F2MXJySAiYSKx9tYqli5GL
        Q0hgKaNEe/dzVoiEjMTGL1ehbGGJP9e62CCKPjJKTH22G8rZwijR2n6VDaSKTUBH4vybO8wg
        toiAuMSJ05sZQYqYBSYwSvSt+8UCkhAWcJdoW/4PrIFFQEWi8d9tJhCbV8BGYvaeLmaIdfIS
        bdenM4LYnAK2EodOnwGrFwKqWX/mAjtEvaDEyZlPwGYyA9U3b53NDGFLSBx88QJqjrLEhHW/
        oV6olfj89xnjBEaRWUjaZyFpn4WkfQEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAqNp2
        7OeWHYwrX33UO8TIxMF4iFGCg1lJhFcorDxFiDclsbIqtSg/vqg0J7X4EKMp0J8TmaVEk/OB
        cZ1XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBUeTf/ZVjhzWMH
        tzmpGcYdPp6qdVg1PZHpiTLLjx86XAa3HHeyhXp0pCie9dvpmRaTfDInfqK1l3iZeti7WEG/
        e7yLiq/9Xrf+6qtFj59yfH/Vn17Hs0a3bjp7zZHDhdvt/Te1aF+2z4uMzXR1YAio2PxfL5zv
        6urClTcFO3q7+79rvP9TLCIzz3Prgp1ul6Yw+/zZxL33+5NvlzTvuyhICV1acmTjNpuCnfyp
        0jFn7ZSuN5sLFT+r+3FWZt7x1jcrth42KXHae8GtNDvmTHRtgeDRoKuZP81zytmFeIRMbicF
        vHFb/+PLh9cqWzdM1JeytVvL2G61/5OI77nNf6Ys5dv87y3jk8i+4rVcd+2VWIozEg21mIuK
        EwE0f9g5MwMAAA==
X-CMS-MailID: 20230602110646eucas1p115dd1191419eb10bca47c9a6eefa6450
X-Msg-Generator: CA
X-RootMTR: 20230602110646eucas1p115dd1191419eb10bca47c9a6eefa6450
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110646eucas1p115dd1191419eb10bca47c9a6eefa6450
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110646eucas1p115dd1191419eb10bca47c9a6eefa6450@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preparation commit to add a new type of test to test_sysctl.c. We
want to differentiate between node and (sub)directory tests.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index e2a816d85ea2..0cf7c547d61a 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -126,9 +126,7 @@ static struct ctl_table test_table[] = {
 	{ }
 };
 
-static struct ctl_table_header *test_sysctl_header;
-
-static int __init test_sysctl_init(void)
+static void test_sysctl_calc_match_int_ok(void)
 {
 	int i;
 
@@ -153,7 +151,13 @@ static int __init test_sysctl_init(void)
 	for (i = 0; i < ARRAY_SIZE(match_int); i++)
 		if (match_int[i].defined != match_int[i].wanted)
 			match_int_ok = 0;
+}
 
+static struct ctl_table_header *test_sysctl_header;
+
+static int test_sysctl_setup_node_tests(void)
+{
+	test_sysctl_calc_match_int_ok();
 	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
 	if (!test_data.bitmap_0001)
 		return -ENOMEM;
@@ -162,8 +166,18 @@ static int __init test_sysctl_init(void)
 		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
 	}
+
 	return 0;
 }
+
+static int __init test_sysctl_init(void)
+{
+	int err;
+
+	err = test_sysctl_setup_node_tests();
+
+	return err;
+}
 module_init(test_sysctl_init);
 
 static void __exit test_sysctl_exit(void)
-- 
2.30.2

