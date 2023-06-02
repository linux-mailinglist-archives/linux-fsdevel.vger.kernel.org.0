Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856BB72001B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjFBLHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjFBLH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D11E4C
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:07:05 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110654euoutp012c39f22392a9b8e16e166ba05d0df2e6~k0t6k6N2G0043200432euoutp01f
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602110654euoutp012c39f22392a9b8e16e166ba05d0df2e6~k0t6k6N2G0043200432euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704014;
        bh=kfxf1qr5GWf+HXq/jSKKNVDlnExuNV1LXklo/nv5rro=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qDbUlCYK5vteGCIvveFEhAOIKnOIZwIOxB1BgxJ64hzXNPxc6sBrHA4igyaR0HQaH
         x0VO1japVLfX6o76J/ShIIWGxJrThIiEibuTk0YGO+FCgOKemr2eSv9k4SopDGz4lp
         /LkxL3viu4qQV3aSWE+kGeVr+8E75esT+wgDNmcE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230602110654eucas1p168408bec9728da4d94d35a3afe9e936e~k0t6cuSv-2550025500eucas1p1x;
        Fri,  2 Jun 2023 11:06:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1A.6A.42423.D4DC9746; Fri,  2
        Jun 2023 12:06:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110653eucas1p19b1f6aac96a61c61e49af5738a0a11ff~k0t6I_-cd0823408234eucas1p1M;
        Fri,  2 Jun 2023 11:06:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230602110653eusmtrp23493124332f3a9b991bafc65ca7bf558~k0t6IexGM2226722267eusmtrp2Y;
        Fri,  2 Jun 2023 11:06:53 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4e-6479cd4deb3a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.EB.14344.D4DC9746; Fri,  2
        Jun 2023 12:06:53 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110653eusmtip117fecc7740d2420720213f1b1b20bde5~k0t6AF1NP0530205302eusmtip1X;
        Fri,  2 Jun 2023 11:06:53 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:52 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 6/8] test_sysclt: Test for registering a mount point
Date:   Fri, 2 Jun 2023 13:06:36 +0200
Message-ID: <20230602110638.789426-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7p+ZytTDI50Mlns2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPLv0ialgt3JF97eVrA2M
        x2W7GDk5JARMJBpefmMCsYUEVjBKXHwr2cXIBWR/YZRoP/EfKvGZUaL7oSBMw4pJs9ghipYz
        SvS/WckC4QAVbZ71B8rZwijxZuc8VpAWNgEdifNv7jCD2CIC4hInTm9mBCliFpjAKNG37hcL
        SEJYwEXi++S7YPtYBFQknu76ww5i8wrYSLya9pENYre8RNv16YwgNqeArcSh02fYIGoEJU7O
        fAI2hxmopnnrbGYIW0Li4IsXzBC9yhIT1v1mhbBrJU5tucUEcoSEwAEOickbT0MlXCTO7zgN
        tUxY4tXxLewQtozE/53zoRomM0rs//eBHcJZzSixrPErE0SVtUTLlSdQHY4SE1auBjqJA8jm
        k7jxVhDiIj6JSdumM0OEeSU62oQmMKrMQvLDLCQ/zELywwJG5lWM4qmlxbnpqcWGeanlesWJ
        ucWleel6yfm5mxiBaeP0v+OfdjDOffVR7xAjEwfjIUYJDmYlEV6hsPIUId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUy2j0/VXjodk1gUtHX2d76i33qs
        JYHyShvzvnXWC3IKivCVCakqXxQ/JWP+Yds7n4dlHpveP3y15SKr04JwRrEtK6ffmW1ke0Ty
        zdE9E/kjA/K4ZpyVfiRk8HuTU7DCaiuRotnim5Uevsh+KGH0skzs8BfWEzsint0/2KfFycrM
        6THj0HkdqQ6/urOpfT13Eu1eW1qdP3XLvfH4o8oKwXuZIUVH1URVbuywZzt9bW0o56y4NfJu
        uxbsvdw0b8E1gyCf351bLJhuTeCoWbYwseKz8f9NCpvV2NTXld6XLtXeyPFxxh+LFetCf++9
        qzf3lvf0FS+sb0l/Z9pjbDvr03HeP6aT1i6fsLsn7cX95L43SizFGYmGWsxFxYkAKSk8g4oD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7q+ZytTDE5f0bbYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeHbpE1PBbuWK7m8rWRsYj8t2MXJySAiYSKyYNIu9i5GL
        Q0hgKaPErV8z2SESMhIbv1xlhbCFJf5c62KDKPrIKHF0ZRczhLOFUWL3qgOMIFVsAjoS59/c
        YQaxRQTEJU6c3swIUsQsMIFRom/dLxaQhLCAi8T3yXeZQGwWARWJp7v+gK3jFbCReDXtIxvE
        OnmJtuvTwYZyCthKHDp9BiwuBFSz/swFqHpBiZMzn4DNZAaqb946mxnClpA4+OIFM8QcZYkJ
        635DvVAr8fnvM8YJjCKzkLTPQtI+C0n7AkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFR
        te3Yzy07GFe++qh3iJGJg/EQowQHs5IIr1BYeYoQb0piZVVqUX58UWlOavEhRlOgPycyS4km
        5wPjOq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSm+xeyq3Ky7
        FZsbZv962cm2UUfj+4YfRxiX8WRFHCq+FPT4Xxh/QeDEjanHOsS9Xs0L2+TGxt08cfb6kKh7
        96v1j7XFLmVdM8t+K1+TnZfvc+ePj0W8p9ue8kjZbzn7dGHTWy6+lGfsbVvzJNYufT+f84XW
        a8cp64V3vRKYxjQlcseU/zPOlrrL+K5eJ5Qu8/7alpYFgfbaSZq5FxbXLGn94y2/w7tAjoux
        3UpxwZU1/DwdrXczok22LWRMMf+UeujOw+LmPIupkp1bj//LcPRJ+h+6Lv94RnN/9KIJrone
        Ntz5d/Y+25ijE9BSHS/sVlmsOOdI3ouOs0d/6fktC/GMaLENqFH6Hhf78L/ydSWW4oxEQy3m
        ouJEAGm23/AzAwAA
X-CMS-MailID: 20230602110653eucas1p19b1f6aac96a61c61e49af5738a0a11ff
X-Msg-Generator: CA
X-RootMTR: 20230602110653eucas1p19b1f6aac96a61c61e49af5738a0a11ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110653eucas1p19b1f6aac96a61c61e49af5738a0a11ff
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110653eucas1p19b1f6aac96a61c61e49af5738a0a11ff@eucas1p1.samsung.com>
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

