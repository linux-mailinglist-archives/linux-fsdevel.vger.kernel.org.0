Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF01732ACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245458AbjFPJAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343887AbjFPI7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46130CB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085937euoutp01f41d2d36c70cb02944dbe0463951b0e7~pGAyMo1Hd0287502875euoutp011
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230616085937euoutp01f41d2d36c70cb02944dbe0463951b0e7~pGAyMo1Hd0287502875euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905977;
        bh=bxclUZv9jPrQ5jKcyYEbND/Krq83dxgsRJ8rzENWdE8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=axotJ3q9jypT/P70UZod6ZYCnJKI3b7eew1unLG9EFfIT2BpiziHXtpd1MKziIcTh
         0ZOEvtXkjJqaQ0SLaNxV4JfO/gAjFkkLGc2UZOtVVpCozDTBfduMV+K69FuFP9NwEh
         HPlqMHci/IPTlw3sCMkhqL1Vqv4tVQk0hJd/JKeM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230616085937eucas1p2049999b954d45f4ea4c8bb141d303b2b~pGAyHQPra1525715257eucas1p2Y;
        Fri, 16 Jun 2023 08:59:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.C4.11320.9742C846; Fri, 16
        Jun 2023 09:59:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085937eucas1p2128b2ddb3c01c887a606f376de850767~pGAxw7LIy1755217552eucas1p2B;
        Fri, 16 Jun 2023 08:59:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085937eusmtrp18f4a6e5e8bc6988652294b0a7480e8bc~pGAxwYBGj0876708767eusmtrp1R;
        Fri, 16 Jun 2023 08:59:37 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-51-648c2479a117
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.2B.10549.9742C846; Fri, 16
        Jun 2023 09:59:37 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085936eusmtip26d75365940dfa4d7f6bbbc981595f2bb~pGAxmWPUB1986419864eusmtip2-;
        Fri, 16 Jun 2023 08:59:36 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:36 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 5/8] test_sysctl: Add an option to prevent test skip
Date:   Fri, 16 Jun 2023 10:59:19 +0200
Message-ID: <20230616085922.3066990-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87qVKj0pBu+apCz27D3JYnF51xw2
        i+l33rNZ3JjwlNGBxWPTqk42j8+b5AKYorhsUlJzMstSi/TtErgyVtztZin4J1ux7tJTtgbG
        +xJdjJwcEgImEltbWtm6GLk4hARWMEp8WPmYHcL5wijxb9kLZgjnM6NE45edjDAt8+ZdY4FI
        LGeUWLlrPhtc1f7++VD9WxklDk1sYwFpYRPQkTj/5g4ziC0iIC5x4vRmsFHMAhMYJWYd4gCx
        hQXcJY7N3gJWzyKgKvHn5EYmEJtXwFbiwOHtzBCr5SXark8H6+UUsJN4PKmBHaJGUOLkzCcs
        EDPlJZq3zmaGsCUkDr4A+YEDqFdZ4tPzBIgxtRKnttxiArlTQuAIh8TphnZ2iISLxPn7a1kh
        bGGJV8e3QMVlJE5P7mGBaJgM9OW/D+wQzmpGiWWNX5kgqqwlWq48YYfY5iixaGclhMknceOt
        IMQ9fBKTtk2HuodXoqNNaAKjyiwkH8xC8sEsJB8sYGRexSieWlqcm55abJSXWq5XnJhbXJqX
        rpecn7uJEZg0Tv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhXXaiK0WINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDkw+Xakpq8qyKJe4TL+1b73f219KVHX8y
        f+dW1TI92WgixuPWssXl7pULsl+nOMldVuBovbjyp+NkCzedpTKTKqKv3/giL3qqquSldfzD
        L6t+zVzXaq/pOeeSnYjF1L/ch2bt+yjxcXHG3+Ktweqppwpt5gRfMn3Badwu1sB5dWmF74LA
        SDfWQ/IxWzncmFRue5w30BC6G8AqlJa3ZfdHuaaiD/feNC+4csxgzg53pzq20l7+eQXuMuyP
        rzP+fTDLbDUH375puw88u/qRI6RKnqXCoKCnbfe1OZ8PzJjEzvSgTite9Uv5nsTr0kohBzdd
        tPtYJbPbXV/I8KTsrMiXDl26HQxPZM+kLL/cuzN7nRJLcUaioRZzUXEiAFNvRSSJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7qVKj0pBpf2s1js2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlrLjbzVLwT7Zi3aWnbA2M9yW6GDk5JARMJObNu8bSxcjF
        ISSwlFHi2Z9rTBAJGYmNX66yQtjCEn+udbFBFH1klNj+eBUzhLOVUeLNx9fsIFVsAjoS59/c
        YQaxRQTEJU6c3swIYjMLTGCUmHWIA8QWFnCXODZ7CwuIzSKgKvHn5EawbbwCthIHDm9nhtgm
        L9F2fTpYL6eAncTjSQ1g84WAahpv97ND1AtKnJz5hAVivrxE89bZzBC2hMTBFy+AbA6gOcoS
        n54nQIyslfj89xnjBEaRWUi6ZyHpnoWkewEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA
        iNp27OfmHYzzXn3UO8TIxMF4iFGCg1lJhHfZia4UId6UxMqq1KL8+KLSnNTiQ4ymQG9OZJYS
        Tc4HxnReSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT+qrqeTH1
        uTLdzQ4rmwyyrOO2Pi4NO/bxfuX9yzK/e6au4+bYE8NfOWWnyIdbi4tkVFNVPKNdo67e5y36
        s6hS+k0p55+77ofDrn2d8pexZe7NHPZlDL0Jl3Zz/jo75XNh5a3tcmITK7/kqnQs91L+M3OK
        yrPabPkz56e4yp5cfoFT5Hrnqpb5sZyxU8oellofCgrc9svYk/ecMX96dGfgm3mpQa3iEfv6
        X2kv84w9KTnJIYFP4UKOSYTa1C/r9xgvZ2WPU34/8cG1OZJFF/k3pq8NuOr5q+nJ9JPLDu+Y
        vtIgJPzgihsCMrrXNrOxu8ls3vbo7snGa1P4V+96seD1mjXzV8scCD9yfmV3/iK3TCWW4oxE
        Qy3mouJEAPuksBIxAwAA
X-CMS-MailID: 20230616085937eucas1p2128b2ddb3c01c887a606f376de850767
X-Msg-Generator: CA
X-RootMTR: 20230616085937eucas1p2128b2ddb3c01c887a606f376de850767
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085937eucas1p2128b2ddb3c01c887a606f376de850767
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085937eucas1p2128b2ddb3c01c887a606f376de850767@eucas1p2.samsung.com>
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

Tests were being skipped because the target was not present. Add a flag
that controls whether to skip a test based on the presence of the target.
Actually skip tests in the test_case function with a "return" instead of
a "continue".

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 66 ++++++++++++++++--------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index a6d79d7a36e4..9c0e9711138b 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -14,24 +14,26 @@ TEST_FILE=$(mktemp)
 
 # This represents
 #
-# TEST_ID:TEST_COUNT:ENABLED:TARGET
+# TEST_ID:TEST_COUNT:ENABLED:TARGET:SKIP_NO_TARGET
 #
 # TEST_ID: is the test id number
 # TEST_COUNT: number of times we should run the test
 # ENABLED: 1 if enabled, 0 otherwise
 # TARGET: test target file required on the test_sysctl module
+# SKIP_NO_TARGET: 1 skip if TARGET not there
+#                 0 run eventhough TARGET not there
 #
 # Once these are enabled please leave them as-is. Write your own test,
 # we have tons of space.
-ALL_TESTS="0001:1:1:int_0001"
-ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"
-ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
-ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
-ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
-ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
-ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int"
-ALL_TESTS="$ALL_TESTS 0008:1:1:match_int"
-ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error"
+ALL_TESTS="0001:1:1:int_0001:1"
+ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001:1"
+ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002:1"
+ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001:1"
+ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003:1"
+ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001:1"
+ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int:1"
+ALL_TESTS="$ALL_TESTS 0008:1:1:match_int:1"
+ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 
 function allow_user_defaults()
 {
@@ -614,7 +616,6 @@ target_exists()
 	TEST_ID="$2"
 
 	if [ ! -f ${TARGET} ] ; then
-		echo "Target for test $TEST_ID: $TARGET not exist, skipping test ..."
 		return 0
 	fi
 	return 1
@@ -902,16 +903,36 @@ function get_test_target()
 	echo ${TEST_DATA} | awk -F":" '{print $4}'
 }
 
+function get_test_skip_no_target()
+{
+	test_num $1
+	awk_field=$(remove_leading_zeros $1)
+	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$awk_field'}')
+	echo ${TEST_DATA} | awk -F":" '{print $5}'
+}
+
+function skip_test()
+{
+	TEST_ID=$1
+	TEST_TARGET=$2
+	if target_exists $TEST_TARGET $TEST_ID; then
+		TEST_SKIP=$(get_test_skip_no_target $TEST_ID)
+		if [[ $TEST_SKIP -eq "1" ]]; then
+			echo "Target for test $TEST_ID: $TEST_TARGET not exist, skipping test ..."
+			return 0
+		fi
+	fi
+	return 1
+}
+
 function run_all_tests()
 {
 	for i in $ALL_TESTS ; do
-		TEST_ID=${i%:*:*:*}
+		TEST_ID=${i%:*:*:*:*}
 		ENABLED=$(get_test_enabled $TEST_ID)
 		TEST_COUNT=$(get_test_count $TEST_ID)
 		TEST_TARGET=$(get_test_target $TEST_ID)
-		if target_exists $TEST_TARGET $TEST_ID; then
-			continue
-		fi
+
 		if [[ $ENABLED -eq "1" ]]; then
 			test_case $TEST_ID $TEST_COUNT $TEST_TARGET
 		fi
@@ -946,18 +967,19 @@ function watch_case()
 
 function test_case()
 {
+	TEST_ID=$1
 	NUM_TESTS=$2
+	TARGET=$3
 
-	i=0
-
-	if target_exists $3 $1; then
-		continue
+	if skip_test $TEST_ID $TARGET; then
+		return
 	fi
 
+	i=0
 	while [ $i -lt $NUM_TESTS ]; do
-		test_num $1
-		watch_log $i ${TEST_NAME}_test_$1 noclear
-		RUN_TEST=${TEST_NAME}_test_$1
+		test_num $TEST_ID
+		watch_log $i ${TEST_NAME}_test_${TEST_ID} noclear
+		RUN_TEST=${TEST_NAME}_test_${TEST_ID}
 		$RUN_TEST
 		let i=$i+1
 	done
-- 
2.30.2

