Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17272732AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbjFPI7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbjFPI7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7930C6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085931euoutp0210e7918507669740cc7011406f821aee~pGAsQ_Dia2873228732euoutp02R
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230616085931euoutp0210e7918507669740cc7011406f821aee~pGAsQ_Dia2873228732euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905971;
        bh=gwuzFK21w1IOUF2ZGdDkpZFWv7+ktlTmNmcMNJTZlNE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ELoF/9yUQ7IjrBkRGfgL1x+5x7nyLwVG0D4iC3JV05CoWun1x1Zw3lyPCyPO0xAGl
         TKvRMMMOK2TRtYy/I6h8hmBb+E/kYZQf/TFK5qw14NNsxbLOW5jQYUtv7CV6FMNnfM
         UpjaqRYGf/EMbGCCM55ZsKXbm2xoyLhQmeRo4ZbY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230616085931eucas1p2bc2687a34c3ff9d55124f6115568dc59~pGAsI7-gc1069610696eucas1p2m;
        Fri, 16 Jun 2023 08:59:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.C4.11320.2742C846; Fri, 16
        Jun 2023 09:59:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085930eucas1p2d1b7ee012df532b3dcf15f96cd2f8c18~pGAr4XYjz0641806418eucas1p2w;
        Fri, 16 Jun 2023 08:59:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085930eusmtrp12126bbccdb46c5978b271a0fd6a1786f~pGAr3tq6Z0890108901eusmtrp1P;
        Fri, 16 Jun 2023 08:59:30 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-38-648c24725a0b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.9E.14344.2742C846; Fri, 16
        Jun 2023 09:59:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085930eusmtip1fd95dc136c7c8f4e24f37577e65ff7fb~pGArtLQ4O1526615266eusmtip1O;
        Fri, 16 Jun 2023 08:59:30 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:29 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 2/8] test_sysctl: Fix test metadata getters
Date:   Fri, 16 Jun 2023 10:59:16 +0200
Message-ID: <20230616085922.3066990-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djPc7rFKj0pBve2MVns2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPL3+jblgq1DF3b4tTA2M
        3fxdjJwcEgImEgt/nmbsYuTiEBJYwShx8mMflPOFUaLj4g9mkCohgc+MEt2nS2A6Zp5/wg4R
        X84o8a5fAq7m/ZJkiOatjBK32r6zgiTYBHQkzr+5AzZIREBc4sTpzYwgNrPABEaJWYc4QGxh
        ATuJG08XsIHYLAKqEt+WvQVbwCtgK/Fh93NGiMXyEm3Xp4PZnED1jyc1QNUISpyc+YQFYqa8
        RPPW2cwQtoTEwRcvgGwOoF5liU/PEyDG1Eqc2nKLCeROCYEDHBKXD/9hg0i4SDT/+sgCYQtL
        vDq+hR3ClpE4PbmHBaJhMqPE/n8f2CGc1YwSyxq/MkFUWUu0XHkC1eEoMf/fJ3aIzXwSN94K
        QhzEJzFp23Sog3glOtqEJjCqzELywiwkL8xC8sICRuZVjOKppcW56anFRnmp5XrFibnFpXnp
        esn5uZsYgQnj9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHeZSe6UoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUw7ZivVsuRdfvH1JgXqXcKO5p7y1gWPLux
        ew3DBO8FtxWVPe4d0LonV9U/M937okVl75SOUIG35+5Lse5Sbnz+f8Gr/X8OTtFbZmocIqH1
        csuFzdPfePgkTqs59Ey+oNBZ+afzNi12R4H7Il11s0oX2QkW+EkpT8pfFm4arbjVMbxNukNE
        qvLwjtDnTzUXiZypfcfjleJwmOFeZs5f/drCxZKzrvXcj0uKLZEqm+qR/WO6wt8/h3xWP32p
        dXdBwafrWhUJX7k/tZ3O6uZgefP+RcXeRwW/ez7Gzr6kumrt8YwC1t3Tlh2xd92hI/mKre71
        1qLLQWpTTh4/wPu16GDq3awt52o9w7pVn1RtXL9qhxJLcUaioRZzUXEiANzVP2OHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pFKj0pBv9f61js2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlPL3+jblgq1DF3b4tTA2M3fxdjJwcEgImEjPPP2HvYuTi
        EBJYyiix/Mh+FoiEjMTGL1dZIWxhiT/Xutggij4ySnyduIgFwtnKKHFk10SwDjYBHYnzb+4w
        g9giAuISJ05vZgSxmQUmMErMOsQBYgsL2EnceLqADcRmEVCV+LbsLTuIzStgK/Fh93NGiG3y
        Em3Xp4PZnED1jyc1gNUIAdU03u6HqheUODnzCQvEfHmJ5q2zmSFsCYmDL14A2RxAc5QlPj1P
        gBhZK/H57zPGCYwis5B0z0LSPQtJ9wJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBEbXt
        2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+yE10pQrwpiZVVqUX58UWlOanFhxhNgd6cyCwlmpwP
        jOm8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamhB2ewembrmfy
        zoldI/XW9Uz7461qBsZHNzhev7DOZuGK/7mvO3U2Hd3y7+Pzh5r/H0Ser9240tPqEd9vYe4H
        xfeOp9yQ/MG10Wgfk4PB3dTGaq+y2Sz6loccVbj5rky5+KTf3X7rp6s9B1TY7wsYToj/tPFP
        QN5uDu3J7EdaE07M6VttOCNd7+cEYTZvLfUaQ6OLRZbHt0vt3uSr+3jdXo1pqz0eGhWJ7Fi/
        2GVu5t/PVwOVjdYcTD/lol1kebrBSUFLJeZFPlNMybtGRjXx3qYnRe4b9zhUv+KakZQupf/t
        WS5318L/Xd8UTf1X7JjOv85rhrpv+e5tdw74/ZLYfeLY3j28nlqRt57pbBLnVmIpzkg01GIu
        Kk4EAEl0ieUxAwAA
X-CMS-MailID: 20230616085930eucas1p2d1b7ee012df532b3dcf15f96cd2f8c18
X-Msg-Generator: CA
X-RootMTR: 20230616085930eucas1p2d1b7ee012df532b3dcf15f96cd2f8c18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085930eucas1p2d1b7ee012df532b3dcf15f96cd2f8c18
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085930eucas1p2d1b7ee012df532b3dcf15f96cd2f8c18@eucas1p2.samsung.com>
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

