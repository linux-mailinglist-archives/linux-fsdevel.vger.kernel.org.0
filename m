Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63A720009
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjFBLHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFBLHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:04 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8311E63
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:06:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110645euoutp018644b9c80c38267ba0bf378f49ae9b4f~k0tytLmhx0110301103euoutp015
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602110645euoutp018644b9c80c38267ba0bf378f49ae9b4f~k0tytLmhx0110301103euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704005;
        bh=gwuzFK21w1IOUF2ZGdDkpZFWv7+ktlTmNmcMNJTZlNE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lcErz3Znew6Cqgq6ClEyB0FClsY3UnYnjd0HLH70Qz3y2F9yhnV3JaRUXWBniT47r
         u++2iOnhmF0rlaTnXDYEx223Mo1dGpcbe+Xapd8uuLQnJ4NyJeM1bINIY+0PJCanCd
         6NFT30IHbGkWNHfw2pOnXwiWNVjfSKBccKG3m+ec=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110645eucas1p2443fb17acbed500c524607354f4e339f~k0tyoJ_Bo0783007830eucas1p2P;
        Fri,  2 Jun 2023 11:06:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.6A.42423.54DC9746; Fri,  2
        Jun 2023 12:06:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110645eucas1p1ee5f3fe8c849258d7773288e1607e183~k0tyREed30212702127eucas1p1U;
        Fri,  2 Jun 2023 11:06:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110645eusmtrp14019d1d594f4a33202fbe00e12e43d12~k0tyQn6No2194821948eusmtrp1Z;
        Fri,  2 Jun 2023 11:06:45 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-33-6479cd45188b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.A9.10549.54DC9746; Fri,  2
        Jun 2023 12:06:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230602110645eusmtip23cc9b3b71b8ced0fc78dfa05a342c3a8~k0tyGqxd_1061810618eusmtip2E;
        Fri,  2 Jun 2023 11:06:45 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:44 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 2/8] test_sysctl: Fix test metadata getters
Date:   Fri, 2 Jun 2023 13:06:32 +0200
Message-ID: <20230602110638.789426-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87quZytTDK4eU7bYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKeHr9G3PBVqGKu31bmBoY
        u/m7GDk4JARMJO6csexi5OIQEljBKPH1SDcjhPOFUWLHscvsEM5nRomu2fuAHE6wjrWzG6Gq
        ljNKrJ31hwmu6vT+r6wQzhZGibZdT1hBWtgEdCTOv7nDDGKLCIhLnDi9GaydWWACo0Tful8s
        IAlhAWuJOSt7wXawCKhI9HxZzgRi8wrYSOycu5kNYre8RNv16YwgNqeArcSh02fYIGoEJU7O
        fAI2hxmopnnrbGYIW0Li4IsXzBC9yhIT1v1mhbBrJU5tuQV2toTAAQ6Jv90fmSDB4SIxpSsM
        okZY4tXxLVA/y0icntzDAlE/mVFi/78P7BDOakaJZY1fmSCqrCVarjyB6nCUOHy8mxliKJ/E
        jbeCEAfxSUzaNh0qzCvR0SY0gVFlFpIXZiF5YRaSFxYwMq9iFE8tLc5NTy02zEst1ytOzC0u
        zUvXS87P3cQITBun/x3/tINx7quPeocYmTgYDzFKcDArifAKhZWnCPGmJFZWpRblxxeV5qQW
        H2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamBiW7pqlT+3/NeKf/+frTN+LvGzf1e6
        Eff/xyqaG9e6dchEPz77f+l/8xVWj/7bf+SfHb9l5u/8YlHmiVtd1Wp80rdpHnnVp694zrn/
        dOuZkA23XLMdGH+kbHWLa3Cv+jLPvnyCqf3SSNPYwJaF3xWdZr7UOiWhIaPj3rbhR+GkGy9d
        yjo78hWOzIo2mmUqrrzRSGLZy0WVu+PVrYWe6RacusAZKNLyRu57gauwS/SJibfMrAznuchn
        M0iVPmW8mPU366vczjtTvh9x473hffVWe0LcI+13L1al8Am+Ws+3OHhq0ILvVxfa22ftqFA4
        cPO5Y0OI22Ym5RrPasMbTMd2H3gvs7Llxf4/pmcmz/2ixFKckWioxVxUnAgAMesZQIoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7quZytTDOau5rPYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeHr9G3PBVqGKu31bmBoYu/m7GDk5JARMJNbObmTsYuTi
        EBJYyiix8v0pRoiEjMTGL1dZIWxhiT/Xutggij4ySjQ+nssO4WxhlJjUtZ0FpIpNQEfi/Js7
        zCC2iIC4xInTm8HGMgtMYJToW/cLrEhYwFpizspedhCbRUBFoufLciYQm1fARmLn3M1sEOvk
        JdquTwc7g1PAVuLQ6TNgcSGgmvVnLrBD1AtKnJz5BGwmM1B989bZzBC2hMTBFy+YIeYoS0xY
        9xvqhVqJz3+fMU5gFJmFpH0WkvZZSNoXMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyq
        bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4hcLKU4R4UxIrq1KL8uOLSnNSiw8xmgL9OZFZSjQ5
        HxjXeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTHvbb+lOuZwx
        8UCp21Ffh3XC/zjC9E+0n+VWOxNoZPGZX4THp8u61nurXGRrc0yuZSO3n9L1CC5GnuyKx8vr
        ymM79+ln7LcM4jvPwiS2OfZMwK9Z2ht7BUskf2m/1FI3eMnqkyCS1+pTuavvCtPMHZaLNJsK
        hPMNeJbN9Zm1XG2BzPf84NKgqX1NH9q5G+S8tZdsCFzcnMYm1s7+WvzxeqFrV1rPeWeL3tBf
        PKPq44ETkgmXDy9teMX8RkpP7zVTQUVojF1I/OvJvw7pLO+5klkdPrE6ddNiXcaNIfvb1m96
        qf9yUtDtY1VCRW/XVjlP+njqnfelM3NrVY0cD/z7r3p3Ik/qo1MzVz3MEDRWYinOSDTUYi4q
        TgQApbbyXDMDAAA=
X-CMS-MailID: 20230602110645eucas1p1ee5f3fe8c849258d7773288e1607e183
X-Msg-Generator: CA
X-RootMTR: 20230602110645eucas1p1ee5f3fe8c849258d7773288e1607e183
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110645eucas1p1ee5f3fe8c849258d7773288e1607e183
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110645eucas1p1ee5f3fe8c849258d7773288e1607e183@eucas1p1.samsung.com>
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

