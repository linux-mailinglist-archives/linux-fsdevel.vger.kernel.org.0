Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7A732AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjFPJAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjFPI7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC330E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:41 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085940euoutp0156217b9edbec427d4353fe067cac04cb~pGA0xfqG70219502195euoutp01k
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230616085940euoutp0156217b9edbec427d4353fe067cac04cb~pGA0xfqG70219502195euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905980;
        bh=kfxf1qr5GWf+HXq/jSKKNVDlnExuNV1LXklo/nv5rro=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bnmgi3t+PyMzL05stx63GEQYXohAVP2y6oHJzhWYU3avPBAUmI5vUBKYf/hNIH0mI
         SvAXcVV6kxHl9V/V4eA9R96643hmzoQdyhr8gXT4q0AtU3R6ydPZDnQNj+O/UkRa6P
         kjRw/j9uXl4mhDxzpilkLiKliFIa85npf5LUGHyE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230616085940eucas1p222cde6bbd26954fa7c85168511eb5645~pGA0leklA1074010740eucas1p2Z;
        Fri, 16 Jun 2023 08:59:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.D4.11320.C742C846; Fri, 16
        Jun 2023 09:59:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085939eucas1p24e5c916a261653ce64bb65c7d12d2830~pGA0T_ivb1074010740eucas1p2Y;
        Fri, 16 Jun 2023 08:59:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230616085939eusmtrp21011ce618e2f36069088ccd3403a1948~pGA0TV7gC1371213712eusmtrp2t;
        Fri, 16 Jun 2023 08:59:39 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-56-648c247cb3e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.9E.14344.B742C846; Fri, 16
        Jun 2023 09:59:39 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085939eusmtip283390eb1560c05c5a6b780f28d30849c~pGA0GnKWL2148921489eusmtip2G;
        Fri, 16 Jun 2023 08:59:39 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:39 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 6/8] test_sysclt: Test for registering a mount point
Date:   Fri, 16 Jun 2023 10:59:20 +0200
Message-ID: <20230616085922.3066990-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87o1Kj0pBlf+sVns2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPLv0ialgt3JF97eVrA2M
        x2W7GDk5JARMJF7s6GTqYuTiEBJYwShxd80+ZgjnC6PE2lUr2SCcz4wS29bNAHI4wFoe39OA
        iC9nlLi+7BE7XFHj3z+sEM5WRoldn/azgyxhE9CROP/mDjOILSIgLnHi9GZGEJtZYAKjxKxD
        HCC2sIC7xKIXT8DiLAKqEouPtzOB2LwCthLTjr5ngThWXqLt+nSwGk4BO4nHkxrYIWoEJU7O
        fMICMVNeonnrbGYIW0Li4IsXzBBXK0t8ep4AMaZW4tSWW2A/Swgc4ZCYcOYMO0TCRWL1jlYm
        CFtY4tXxLVBxGYn/O+dDNUxmlNj/7wM7hLOaUWJZ41eoDmuJlitP2CG2OUo0HGWEMPkkbrwV
        hLiHT2LStulQ9/BKdLQJTWBUmYXkg1lIPpiF5IMFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS
        9ZLzczcxAlPG6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8y050pQjxpiRWVqUW5ccXleakFh9i
        lOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpgkg+e8u9kwHWGeY986/0qVAt2V+l7K7BM
        mc21q8lbauODLreYw4ezdKu6z/ZuaDe58b7yw8yA5aeesig/TL19UveKy8xte24FPbU+YhdS
        usLdvFlF86yITP5hkdXy5Zu0N732mnCSYe8rOa7nJUUWjx0/F3N55JaUPGpbH+sRMqtiukj0
        5JN3vi7JbHvw89rUuQt/rjmj9MzieOb1m8/7T2kdjVpXZOX4XHORofLnAokXHhZtP6Trlrfv
        u3d9QnCuZ9J8UyGedRcZfhodq/devVfL72H598tNuutnLNpovivo2FbFnWvnzcow83T/MaNk
        6x7/iy/W/a4+Uvwp5UFIarjJQqu3Hf/Ufbl/LHewmKDEUpyRaKjFXFScCABdEMv8iAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7rVKj0pBl/+6lrs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlPLv0ialgt3JF97eVrA2Mx2W7GDk4JARMJB7f0+hi5OIQ
        EljKKPGovZWxi5ETKC4jsfHLVVYIW1jiz7UuNoiij4wSVx8sY4FwtjJKPHi1HayDTUBH4vyb
        O8wgtoiAuMSJ05vB4swCExglZh3iALGFBdwlFr14AhZnEVCVWHy8nQnE5hWwlZh29D0LxDZ5
        ibbr08FqOAXsJB5PamAHsYWAahpv97ND1AtKnJz5hAVivrxE89bZzBC2hMTBFy+YIT5Tlvj0
        PAFiZK3E57/PGCcwisxC0j0LSfcsJN0LGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbT
        tmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8y050pQjxpiRWVqUW5ccXleakFh9iNAV6cyKzlGhy
        PjCi80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamOysNv2YlsP8
        eUWX4mFpYW29Ar5rPRqt0rtWTnfc7vC99VK/9CUe+RAV48iAPbNd2GQnqzLvLDC0u2IW47io
        6dTlTzFsLclGL4/q/Yt/vPjFJcYD3zgfnOZX2R2UGmyzYanVrm890ZfXHI+L1T7i+JB5dZOM
        acZ0ozVMzY8UmH76Pt9YuGxK9vsC7h17+nPkPjvXXNphMlfX/4eN3xbzLLX9C2ey8Tjuufbs
        TfFMvaJFJ38djLFwmVJ+eGPiphOVkc1V/d9vF4nc2v7k6LIrCyp3/hbpM9+2qXmF5fa3Ss8M
        TrFXXo/pWHpJ82r9UpEP7id3rkv80yn0ZJ+PnNgi9Ycfd5QeP/3pwQnNxybLW+yVWIozEg21
        mIuKEwGa2hg4MAMAAA==
X-CMS-MailID: 20230616085939eucas1p24e5c916a261653ce64bb65c7d12d2830
X-Msg-Generator: CA
X-RootMTR: 20230616085939eucas1p24e5c916a261653ce64bb65c7d12d2830
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085939eucas1p24e5c916a261653ce64bb65c7d12d2830
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085939eucas1p24e5c916a261653ce64bb65c7d12d2830@eucas1p2.samsung.com>
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

Test that target gets created by register_sysctl_mount_point and that no
additional target can be created "on top" of a permanently empty sysctl
table.

Create a mount point target (mnt) in the sysctl test driver; try to
create another on top of that (mnt_error). Output an error if
"mnt_error" is present when we run the sysctl selftests.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c                        | 45 ++++++++++++++++++++----
 tools/testing/selftests/sysctl/sysctl.sh | 16 +++++++++
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 555244687443..8036aa91a1cb 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -30,6 +30,13 @@ static int i_zero;
 static int i_one_hundred = 100;
 static int match_int_ok = 1;
 
+
+static struct {
+	struct ctl_table_header *test_h_setup_node;
+	struct ctl_table_header *test_h_mnt;
+	struct ctl_table_header *test_h_mnterror;
+} sysctl_test_headers;
+
 struct test_sysctl_data {
 	int int_0001;
 	int int_0002;
@@ -153,16 +160,14 @@ static void test_sysctl_calc_match_int_ok(void)
 			match_int_ok = 0;
 }
 
-static struct ctl_table_header *test_sysctl_header;
-
 static int test_sysctl_setup_node_tests(void)
 {
 	test_sysctl_calc_match_int_ok();
 	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
 	if (!test_data.bitmap_0001)
 		return -ENOMEM;
-	test_sysctl_header = register_sysctl("debug/test_sysctl", test_table);
-	if (!test_sysctl_header) {
+	sysctl_test_headers.test_h_setup_node = register_sysctl("debug/test_sysctl", test_table);
+	if (!sysctl_test_headers.test_h_setup_node) {
 		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
 	}
@@ -195,6 +200,26 @@ static int test_sysctl_run_unregister_nested(void)
 	return 0;
 }
 
+static int test_sysctl_run_register_mount_point(void)
+{
+	sysctl_test_headers.test_h_mnt
+		= register_sysctl_mount_point("debug/test_sysctl/mnt");
+	if (!sysctl_test_headers.test_h_mnt)
+		return -ENOMEM;
+
+	sysctl_test_headers.test_h_mnterror
+		= register_sysctl("debug/test_sysctl/mnt/mnt_error",
+				  test_table_unregister);
+	/*
+	 * Don't check the result.:
+	 * If it fails (expected behavior), return 0.
+	 * If successful (missbehavior of register mount point), we want to see
+	 * mnt_error when we run the sysctl test script
+	 */
+
+	return 0;
+}
+
 static int __init test_sysctl_init(void)
 {
 	int err;
@@ -204,6 +229,10 @@ static int __init test_sysctl_init(void)
 		goto out;
 
 	err = test_sysctl_run_unregister_nested();
+	if (err)
+		goto out;
+
+	err = test_sysctl_run_register_mount_point();
 
 out:
 	return err;
@@ -213,8 +242,12 @@ module_init(test_sysctl_init);
 static void __exit test_sysctl_exit(void)
 {
 	kfree(test_data.bitmap_0001);
-	if (test_sysctl_header)
-		unregister_sysctl_table(test_sysctl_header);
+	if (sysctl_test_headers.test_h_setup_node)
+		unregister_sysctl_table(sysctl_test_headers.test_h_setup_node);
+	if (sysctl_test_headers.test_h_mnt)
+		unregister_sysctl_table(sysctl_test_headers.test_h_mnt);
+	if (sysctl_test_headers.test_h_mnterror)
+		unregister_sysctl_table(sysctl_test_headers.test_h_mnterror);
 }
 
 module_exit(test_sysctl_exit);
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 9c0e9711138b..444b2befda82 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -34,6 +34,7 @@ ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001:1"
 ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int:1"
 ALL_TESTS="$ALL_TESTS 0008:1:1:match_int:1"
 ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
+ALL_TESTS="$ALL_TESTS 0010:1:1:mnt/mnt_error:0"
 
 function allow_user_defaults()
 {
@@ -813,6 +814,20 @@ sysctl_test_0009()
 	return 0
 }
 
+sysctl_test_0010()
+{
+	TARGET="${SYSCTL}/$(get_test_target 0010)"
+	echo -n "Testing that $TARGET was not created  ..."
+	if [ -d $TARGET ]; then
+		echo "TEST FAILED"
+		rc=1
+		test_rc
+	fi
+
+	echo "ok"
+	return 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -830,6 +845,7 @@ list_tests()
 	echo "0007 x $(get_test_count 0007) - tests setting sysctl from kernel boot param"
 	echo "0008 x $(get_test_count 0008) - tests sysctl macro values match"
 	echo "0009 x $(get_test_count 0009) - tests sysct unregister"
+	echo "0010 x $(get_test_count 0010) - tests sysct mount point"
 }
 
 usage()
-- 
2.30.2

