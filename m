Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C437A71FE96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjFBKIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjFBKIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:08:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67537180
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:08:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602100815euoutp011b4bb983170deacb2b4ba4c674ead57c~kz6tSriuJ0428904289euoutp01e
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602100815euoutp011b4bb983170deacb2b4ba4c674ead57c~kz6tSriuJ0428904289euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685700495;
        bh=gwuzFK21w1IOUF2ZGdDkpZFWv7+ktlTmNmcMNJTZlNE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Uhqp8u1RDGdYhE7p0dUp2DVn2Kl7t38eCw3GIUnA23//WAv00Qo6yz0z/NL7W77Iw
         NxGeaLro3zsgnBnJrnHtBymiAFNCzuC915usMWxigdc3Ob5AkDzzEnJsO8he/ARi3N
         gHKsmcoisp/4lelD+SMCGfiie39BZkoJcEFKMcIQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602100812eucas1p2ee60d116422b859b8b2368dab22a3455~kz6rBxq_m0507505075eucas1p2c;
        Fri,  2 Jun 2023 10:08:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D7.20.42423.C8FB9746; Fri,  2
        Jun 2023 11:08:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100812eucas1p14c8b09a24157e24c40b2c1869e2d1c56~kz6qxImmN2168821688eucas1p1A;
        Fri,  2 Jun 2023 10:08:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602100812eusmtrp14d669053a0b08bb228c50ede5f255c56~kz6qwdEFe1804218042eusmtrp1E;
        Fri,  2 Jun 2023 10:08:12 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-b0-6479bf8c0d34
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.34.14344.C8FB9746; Fri,  2
        Jun 2023 11:08:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100812eusmtip16688d6ac326554b917db77ef42572fa8~kz6qlNGQ53205432054eusmtip17;
        Fri,  2 Jun 2023 10:08:12 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 11:08:11 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 2/8] test_sysctl: Fix test metadata getters
Date:   Fri, 2 Jun 2023 12:07:59 +0200
Message-ID: <20230602100805.777917-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602100805.777917-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87o9+ytTDFpmGVjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPL3+jblgq1DF3b4tTA2M
        3fxdjJwcEgImEktenmUBsYUEVjBKvLmU2MXIBWR/YZR4eOUyM0TiM6PE+gv2MA3vP59kgiha
        ziix7+98ZggHqGjOnF42CGcLo8SebR/B2tkEdCTOv7kDZosIiEucOL2ZEcRmFpjAKDHrEAeI
        LSxgLTFnZS87iM0ioCJxeO9hMJtXwEbiUctHNojV8hJt16eD9XIK2Eosm/GUCaJGUOLkzCcs
        EDPlJZq3zmaGsCUkDr54wQzRqywxYd1vVgi7VuLUlltgL0gIHOGQ2HDzITtEwkXi28TNUEXC
        Eq+Ob4GKy0icntzDAtEwmVFi/78P7BDOakaJZY1fmSCqrCVarjyB6nCU6Di+HcjmALL5JG68
        FYS4iE9i0rbpzBBhXomONqEJjCqzkPwwC8kPs5D8sICReRWjeGppcW56arFhXmq5XnFibnFp
        Xrpecn7uJkZg0jj97/inHYxzX33UO8TIxMF4iFGCg1lJhFcorDxFiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA5O956lzW789nnwntmNCSdpnT6aNfxZW
        63t/Cz632+VA1cQ42xrOE+rF7WfXmuQ3Od9NzT7d11gWI7cnRLOk96LGjYyp7yJ47sSsivZM
        lzfLnidtUZp3s41r6oSTh9gYz8ZMe8B5N6xMMO3LhnNa0ooP32knXV11W9ZL6Ey7U6mcyG3b
        3azfwlOia0+qhbHsWrViycWZarfWB53pei2xdFuF17mPJ0U6uFVedz3dekrm/YS3KmwLtCaJ
        /djB6e31cLGPLVdXcpnyuf8/3vW5iH2fdv0Dt69gVE3BrNUswu7ad7rcmKJyeG5Pfvkj7rmi
        4ju2nzW72TauZb7MHLXn2CSTowZvE59JlvreEeG9PkGJpTgj0VCLuag4EQAoKPBMiQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7o9+ytTDO5/lrHYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeHr9G3PBVqGKu31bmBoYu/m7GDk5JARMJN5/PsnUxcjF
        ISSwlFGi+eAONoiEjMTGL1dZIWxhiT/Xutggij4ySvQ3XWKBcLYwSmx7+JYFpIpNQEfi/Js7
        zCC2iIC4xInTmxlBbGaBCYwSsw5xgNjCAtYSc1b2soPYLAIqEof3HgazeQVsJB61fITaLC/R
        dn06WC+ngK3EshlPmUBsIaCa848mMUPUC0qcnPmEBWK+vETz1tnMELaExMEXL5gh5ihLTFj3
        G+qDWonPf58xTmAUmYWkfRaS9llI2hcwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjKlt
        x35u2cG48tVHvUOMTByMhxglOJiVRHiFwspThHhTEiurUovy44tKc1KLDzGaAv05kVlKNDkf
        GNV5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MM5k5VhW77Z5n
        re09S3mPIOvifwFs86cc/vpk705PwzXz5WcvSvfexcTG+HKWM/OuksX3Di+9MSnfd88zV9WK
        6pOp08rr5gZ4FXZUHon4/ON2e+WDB665x/ZdfvzFa7Pn+4d/jm67Nf3CrOtiX00O+8Ts/PnZ
        TvvO0pj9J1PtvrXMfyy42vk8h5rSJsUJ/yOEq2pu9N3bkLSUN+8mqxvvtsMW5p+6z3vLV9qe
        mHhYQnje/TLZwlvt7+++vXjdbOH8F1Z2Vg+P5EdPvnLxWPN+d4vEZQ89slKO6GTEBZnWTQ6J
        /i1c/eFtRdScuDmHVm40dghrTZQ2/Vy6flbeozNNETqzXRwOiBwSX3jxkFJJzQ8lluKMREMt
        5qLiRAAr5LtRMgMAAA==
X-CMS-MailID: 20230602100812eucas1p14c8b09a24157e24c40b2c1869e2d1c56
X-Msg-Generator: CA
X-RootMTR: 20230602100812eucas1p14c8b09a24157e24c40b2c1869e2d1c56
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602100812eucas1p14c8b09a24157e24c40b2c1869e2d1c56
References: <20230602100805.777917-1-j.granados@samsung.com>
        <CGME20230602100812eucas1p14c8b09a24157e24c40b2c1869e2d1c56@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The functions get_test_{count,enabled,target} use awk to get the N'th
field in the ALL_TESTS variable. A variable with leading zeros (e.g.
0009) is misinterpreted as an entire line instead of the N'th field.
Remove the leading zeros so this does not happen. We can now use the
helper in tests 6, 7 and 8.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index bfc54b422f25..cb8f83dfe16b 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -730,7 +730,7 @@ sysctl_test_0005()
 
 sysctl_test_0006()
 {
-	TARGET="${SYSCTL}/bitmap_0001"
+	TARGET="${SYSCTL}/$(get_test_target 0006)"
 	reset_vals
 	ORIG=""
 	run_bitmaptest
@@ -738,7 +738,7 @@ sysctl_test_0006()
 
 sysctl_test_0007()
 {
-	TARGET="${SYSCTL}/boot_int"
+	TARGET="${SYSCTL}/$(get_test_target 0007)"
 	if [ ! -f $TARGET ]; then
 		echo "Skipping test for $TARGET as it is not present ..."
 		return $ksft_skip
@@ -778,7 +778,7 @@ sysctl_test_0007()
 
 sysctl_test_0008()
 {
-	TARGET="${SYSCTL}/match_int"
+	TARGET="${SYSCTL}/$(get_test_target 0008)"
 	if [ ! -f $TARGET ]; then
 		echo "Skipping test for $TARGET as it is not present ..."
 		return $ksft_skip
@@ -857,25 +857,32 @@ function test_num()
 		usage
 	fi
 }
+function remove_leading_zeros()
+{
+	echo $1 | sed 's/^0*//'
+}
 
 function get_test_count()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	awk_field=$(remove_leading_zeros $1)
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$awk_field'}')
 	echo ${TEST_DATA} | awk -F":" '{print $2}'
 }
 
 function get_test_enabled()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	awk_field=$(remove_leading_zeros $1)
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$awk_field'}')
 	echo ${TEST_DATA} | awk -F":" '{print $3}'
 }
 
 function get_test_target()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	awk_field=$(remove_leading_zeros $1)
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$awk_field'}')
 	echo ${TEST_DATA} | awk -F":" '{print $4}'
 }
 
-- 
2.30.2

