Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E371FE92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjFBKI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjFBKIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:08:22 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC6197
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:08:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602100815euoutp029b33fb4dd8e768d3d4f9cd4a58e566ba~kz6tc0bTk3154431544euoutp02q
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602100815euoutp029b33fb4dd8e768d3d4f9cd4a58e566ba~kz6tc0bTk3154431544euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685700495;
        bh=hYhRLkPi8FoDCUTYM89A2RNac7EIMazIQAo5IMuTC+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YdMQjQYDQFZKHmHEbzFHq4pdKaktxp/1Zbn5GUR7X+fBmht1BzED0www7/zs29Taw
         GUsBH3/xDoyXow6dHvxYKPzES4Xj1zqoYD4OZkbi66F4pH4u5oR5y5zmDlsAT2Glyb
         r9h3L5ISHPLuO8dkWgdVDdNN5Cs1drurIv5S7qEE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602100814eucas1p2af69e4ad0f660befbf5aa2b2213cc394~kz6siDBzK1995219952eucas1p2t;
        Fri,  2 Jun 2023 10:08:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 81.35.37758.E8FB9746; Fri,  2
        Jun 2023 11:08:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100814eucas1p15571a8954a027cecc68bf8cf670c3cc2~kz6sQWdV92168721687eucas1p1w;
        Fri,  2 Jun 2023 10:08:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602100814eusmtrp1be4717455196156d25dc8bcf60e53fce~kz6sP5CU71803818038eusmtrp1P;
        Fri,  2 Jun 2023 10:08:14 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-3a-6479bf8eb6a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.E1.10549.D8FB9746; Fri,  2
        Jun 2023 11:08:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100813eusmtip1df27e3376303b6489f747f728197d58e~kz6sCO9SQ0240902409eusmtip1G;
        Fri,  2 Jun 2023 10:08:13 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 11:08:13 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 3/8] test_sysctl: Group node sysctl test under one func
Date:   Fri, 2 Jun 2023 12:08:00 +0200
Message-ID: <20230602100805.777917-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602100805.777917-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87p9+ytTDOa+EbHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKuDatn7XgEXfFvRvvGBsY
        r3F2MXJySAiYSBy/+4Wli5GLQ0hgBaPEtfvtrCAJIYEvjBLXZ0VDJD4zSux4v4MdpuPaoj52
        iMRyRon3p+azwlWtXLQOatYWRokD/Y2MIC1sAjoS59/cYQaxRQTEJU6c3gwWZxaYwCgx6xAH
        iC0s4C7RtvwfG4jNIqAisXDjGrA7eAVsJE4+ucgIsVpeou36dDCbU8BWYtmMp0wQNYISJ2c+
        YYGYKS/RvHU2M4QtIXHwxQtmiF5liQnrfrNC2LUSp7bcYgI5VELgAIfE97a9TBAJF4nNu85A
        2cISr45vgfpZRuL05B4WiIbJjBL7/31gh3BWM0osa/wK1WEt0XLlCVSHo0T/gmlAqzmAbD6J
        G28FIS7ik5i0bTpUmFeio01oAqPKLCQ/zELywywkPyxgZF7FKJ5aWpybnlpsnJdarlecmFtc
        mpeul5yfu4kRmDZO/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuEVCitPEeJNSaysSi3Kjy8qzUkt
        PsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp1cDUdIu1d3Fwvm3qv7iYF6dC//p8XVQw
        T1OKLTBwj+zOM4qL9h2Q5N8xoeCt+EveIxVvbFzEquNPfJnVIsBx7k5PxpGWGM8NcmIyFT/8
        KlNYT1V4CQbXGfMrXI1OmC47TX2GaOfMi0sjVxivklyyZeax2q65fOpHFBTN8vRfXednaDn5
        7vgdO8kzMof+N0q5x/IH/A8XuzP9bqPw0X2uB6+recQxz2Wbmafj8Xul4cubbQyz2Geej7vg
        eqmz6ljkH9YpH5nFz8+Wd7mwxG7qSeuiOVJ85jKRE90P9y4tlUyUevFj55yfNRu/rprS8SQ3
        /MTiywI3jhydf/GIn67v1F+X+Uy3/29ZVyxiyXi3T3OvEktxRqKhFnNRcSIAOtj8GYoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7p9+ytTDL5uYLTYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLuDatn7XgEXfFvRvvGBsYr3F2MXJySAiYSFxb1MfexcjF
        ISSwlFHi/b92FoiEjMTGL1dZIWxhiT/XuthAbCGBj4wS96/rQzRsYZQ4e+IiI0iCTUBH4vyb
        O8wgtoiAuMSJ05vB4swCExglZh3iALGFBdwl2pb/AxvEIqAisXDjGrAFvAI2EiefQMyREJCX
        aLs+HczmFLCVWDbjKRPEYhuJ848mMUPUC0qcnPmEBWK+vETz1tnMELaExMEXL5gh5ihLTFj3
        G+qBWonPf58xTmAUmYWkfRaS9llI2hcwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjKht
        x35u3sE479VHvUOMTByMhxglOJiVRHiFwspThHhTEiurUovy44tKc1KLDzGaAv05kVlKNDkf
        GNN5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M/MdX5h8xEr66
        QrvQfc406U8rvR5ryc7d1Gx6IqzoPP9FUZ9XbcytH+sSU5/f2liv+fd76HPbs/m/gt7cOcqi
        LD8jdGWDSMS6Qjf99SbGZr4i8TN61y5cnc6SyLG06kR2wavV/f53KzlKJ9Zqa5y60GjEu1Mi
        0bjB7rp79ewyw8m31j7XzTu2VWt/bVFQTI7nrKd7+pwXaO3rtsqTMSwNKc7NvM3/3Pz5h/1h
        Xz0972c2thad36FzXLxl3muPabfPRRkkzY5wYJq7qY3xS/7CHa99udpn7Y3IyvHIYz72bQ7v
        yeQvh41ZW7/Fl25RnnanN+azhLDDiXklbxUcdTUs3pZ7zTQOX5oaP0vc3VmJpTgj0VCLuag4
        EQBdLM/BMQMAAA==
X-CMS-MailID: 20230602100814eucas1p15571a8954a027cecc68bf8cf670c3cc2
X-Msg-Generator: CA
X-RootMTR: 20230602100814eucas1p15571a8954a027cecc68bf8cf670c3cc2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602100814eucas1p15571a8954a027cecc68bf8cf670c3cc2
References: <20230602100805.777917-1-j.granados@samsung.com>
        <CGME20230602100814eucas1p15571a8954a027cecc68bf8cf670c3cc2@eucas1p1.samsung.com>
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

