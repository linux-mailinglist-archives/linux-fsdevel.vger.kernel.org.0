Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6B732AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjFPI7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245623AbjFPI7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44355B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085933euoutp02d78ec5678cafb6d061413b4c0cb5dfad~pGAuC-PWE2873728737euoutp02Z
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230616085933euoutp02d78ec5678cafb6d061413b4c0cb5dfad~pGAuC-PWE2873728737euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905973;
        bh=hYhRLkPi8FoDCUTYM89A2RNac7EIMazIQAo5IMuTC+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mVFHafhhQ0RweYn15twShwBBZ46FbtZJ8usTR3F3h9T1RthAFxseggOLeBDl+hZLJ
         DSkNl+km/xsruFdQxRXgATygvSlvzFK6KjLlaQkkHOt5QSM+ByR2yadJQv9WQ98EKu
         asSMbsFktl1drzMGf3gAT35rLOnMs8VR3JPf3qYo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230616085932eucas1p1a8b8595d201c77f521ca9c47f9918fc5~pGAt53mE90928509285eucas1p1p;
        Fri, 16 Jun 2023 08:59:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 99.C4.11320.4742C846; Fri, 16
        Jun 2023 09:59:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085932eucas1p1d3d120da7944fc06d714035043697e4d~pGAtmNejj0512805128eucas1p11;
        Fri, 16 Jun 2023 08:59:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085932eusmtrp1f6928a4e49ee4e0f0b21f31506551e8f~pGAtlmZSr0890108901eusmtrp1W;
        Fri, 16 Jun 2023 08:59:32 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-42-648c24746962
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.9E.14344.4742C846; Fri, 16
        Jun 2023 09:59:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085932eusmtip22ea7cb030edfb2cec4c90444bcdd258d~pGAtcnsCH1537815378eusmtip2a;
        Fri, 16 Jun 2023 08:59:32 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:31 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 3/8] test_sysctl: Group node sysctl test under one func
Date:   Fri, 16 Jun 2023 10:59:17 +0200
Message-ID: <20230616085922.3066990-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djPc7olKj0pBrO7LCz27D3JYnF51xw2
        i+l33rNZ3JjwlNGBxWPTqk42j8+b5AKYorhsUlJzMstSi/TtErgyrk3rZy14xF1x78Y7xgbG
        a5xdjJwcEgImEr3rupm7GLk4hARWMEq0zn7GDJIQEvjCKDFnthhE4jOjxIQzN9hhOjY9PcEO
        kVjOKDG/4REjXNXf6b+hMlsZJV6tusUG0sImoCNx/s0dsLkiAuISJ05vZgSxmQUmMErMOsQB
        YgsLeElM3nOGCcRmEVCVuHH9G1g9r4CtxIxdt1khVstLtF2fDtbLKWAn8XhSAztEjaDEyZlP
        WCBmyks0b53NDGFLSBx88QLI5gDqVZb49DwBYkytxKktt5hA7pQQOMAh0bv+LtR8F4n3/cvZ
        IGxhiVfHt0C9LCNxenIPC0TDZEaJ/f8+sEM4qxklljV+ZYKospZoufIEqsNRYuLWC+wQm/kk
        brwVhDiIT2LStulQB/FKdLQJTWBUmYXkhVlIXpiF5IUFjMyrGMVTS4tz01OLjfJSy/WKE3OL
        S/PS9ZLzczcxApPG6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8y050pQjxpiRWVqUW5ccXleak
        Fh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpgWqjPFHzfpXXnedfJAQvDztbryj+u
        6/rt+DS3wvq9rfGdxVV258/XTH+oNnli0JUG3o71x+e75y3vyVvrXPWI8ee61Wn35msvFTJl
        6N8/x1stUa5KSXf19Gdvt72/7hd18zCDuP3veYeKvpieT5Teyr7JvCdY6prTmU2vvoV8YzdX
        0My1nRYrfGdxhNMR41OLW81/VrQ5Homsl54hnO6d9vuiQEXl4QP7as+zPJKUXG5+dsq552zV
        QY3xnz1y/3KsqNv9adtmQc7Euyk/g7Nnpj0Sm6HKHGkUkMt5Km6HzySXZe9kNG61xEkbyLT+
        bfxQe+2424JLNrPFWX/ne0+QKAl4eDDeuc607SUXWzqLEktxRqKhFnNRcSIAefa35YkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7olKj0pBmt/qFjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlXJvWz1rwiLvi3o13jA2M1zi7GDk5JARMJDY9PcHexcjF
        ISSwlFHizrlmVoiEjMTGL1ehbGGJP9e62CCKPjJKXLp3C6pjK6PEs2lPWECq2AR0JM6/ucMM
        YosIiEucOL2ZEcRmFpjAKDHrEAeILSzgJTF5zxkmEJtFQFXixvVvYPW8ArYSM3bdhtomL9F2
        fTpYL6eAncTjSQ3sILYQUE3j7X52iHpBiZMzIfYyA9U3b53NDGFLSBx88QLI5gCaoyzx6XkC
        xMhaic9/nzFOYBSZhaR7FpLuWUi6FzAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMqG3H
        fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeJed6EoR4k1JrKxKLcqPLyrNSS0+xGgK9OZEZinR5Hxg
        TOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTD1sNmkycrEHV20
        fNYsaVbR5SmHXnquS83wr+TV+bKsKjqOfdWM9WvFa5NEHPWOpwlofLuUzGgu/ajvTu7BVGed
        S+eiO5S1Tu/5utVobiuPM39dYeX8Ke43XToOC6z8nulz8s89y79C6hOUJujPzZwsxs7jOZNj
        wnX9o35uYYYf2D6USDUGTum6ynX83SfrXbLLrAtfJb7JiRbOvfNOTTBr3dGreloK3SYJT19v
        v2agtrtj21XfjWZXjZc+U2B/yLwmzmnS4md713rLLtV5nH7AOvDm5vTAhI8Pee/trDysIiIx
        9fQjzY/917Nfi33SNmzeFHww/I/71IJDd95Jbw4S+Ms5/93KqP1SEr+P66xSYinOSDTUYi4q
        TgQAkG7KRzEDAAA=
X-CMS-MailID: 20230616085932eucas1p1d3d120da7944fc06d714035043697e4d
X-Msg-Generator: CA
X-RootMTR: 20230616085932eucas1p1d3d120da7944fc06d714035043697e4d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085932eucas1p1d3d120da7944fc06d714035043697e4d
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085932eucas1p1d3d120da7944fc06d714035043697e4d@eucas1p1.samsung.com>
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

