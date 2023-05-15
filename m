Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3757025D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjEOHPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjEOHO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF71732
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:58 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071457euoutp024cab07f7e4b83d91f58ef4ec11b9026b~fP8QZxjvS1782817828euoutp02f
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230515071457euoutp024cab07f7e4b83d91f58ef4ec11b9026b~fP8QZxjvS1782817828euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134897;
        bh=VFuEoWb1Dy0exlvcNJiwJDdruaCS+52aQEQy5tudvTA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JiFee9hz+KP8Fh/s5tpUlVnA27nXki66irZl29Aybv9PFUdoQtuq4dPZ5uHG2ZB/6
         m1LZJWGQUWfLxQukOCI/x6uLRxqmFbayk9BBlL9o6EGz3E5TcFCj4t/uYA2dO9OeKw
         /JfFcnHfWWRf5n9BE0WLWOHeSzOz7WtaWTcX0W1s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515071456eucas1p1032e87fe11d6ea05f069fd476c955295~fP8Pxf85F2871128711eucas1p14;
        Mon, 15 May 2023 07:14:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.71.42423.0FBD1646; Mon, 15
        May 2023 08:14:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071456eucas1p1e92a011498b7f3ca2e02cdc8f0d39415~fP8PdjBX20316603166eucas1p1k;
        Mon, 15 May 2023 07:14:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515071456eusmtrp2266c3fff24ea8edab25772245f77e218~fP8Pc9tza2610526105eusmtrp2P;
        Mon, 15 May 2023 07:14:56 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-9d-6461dbf0f4ff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.D9.14344.FEBD1646; Mon, 15
        May 2023 08:14:56 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515071455eusmtip289abcf3633e673dd8b78232d839902f3~fP8PMOnKJ2243722437eusmtip2I;
        Mon, 15 May 2023 07:14:55 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:54 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 5/6] parport: Removed sysctl related defines
Date:   Mon, 15 May 2023 09:14:45 +0200
Message-ID: <20230515071446.2277292-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd0PtxNTDPY2iFic6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJXx9dAp1oKbHBU3OpqZGxhvsHUxsnNICJhILFbtYuTiEBJYwSjx88N/NgjnC6NE
        78ovjBDOZ0aJ1f0fgDKcYA37v3+GSixnlJg0vYEVrurrp4XsEM4WRol3zR2sIC1sAjoS59/c
        YQaxRQTEJU6c3gzWzizwlFFi7r9eJpCEsICNxMZfP9hBbBYBVYmP86aDNfMK2Eqc61sLtVte
        ou36dEYQm1PATmLd/qNMEDWCEidnPmEBsZmBapq3zmaGsCUkDr54wQzRqyTx9U0vK4RdK3Fq
        yy0mCPsOh8TViREQtovE3g1LoOLCEq+Ob2GHsGUk/u+czwRytITAZEaJ/f8+sEM4qxklljV+
        heqwlmi58gSqw1Gic8UMoDgHkM0nceOtIMRBfBKTtk1nhgjzSnS0CU1gVJmF5IVZSF6YheSF
        BYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzOl/xz/tYJz76qPeIUYmDsZDjBIc
        zEoivO0z41OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1
        MNXVXqurFj0ilKcUfvj4EqHFE58l1iSctr2xSs5ocYGQ78d1LztccxRixC0e21S/TD3S4fx/
        plWl95mqi6G7H1897PHc/x37gXe9OjrbvsstcTj8oaXJX7tZ4t3LE+bbpj8s9fze/T7z6MPT
        mj+SFy4JqJl5OSgs90LHrPjJAno2fJe0T6ktkxHKevRdd15GTnuj8ZmjzwoO2ifszPWV1akX
        0raS4ZrsPnNV7GaNkw0P248UNmUXfA0MEZt23My0Nl1BgPkz03X+3lpNRT2NHVGX6/R+W5dc
        y7zmML31lsOfCYJ9+Y+OHEvLnhr0v/bv5D3hGj9SOu4pa24xyjRZs+U5Y32kp8A8xfnJ91f4
        KLEUZyQaajEXFScCAKHMWtmfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7ofbiemGFw6wGRxpjvXYs/ekywW
        l3fNYbO4MeEpo8WB01OYLZbt9HNg85jdcJHFY+esu+weCzaVemxa1cnm8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G10OnWAtuclTc
        6GhmbmC8wdbFyMkhIWAisf/7Z8YuRi4OIYGljBKTDhxhgUjISGz8cpUVwhaW+HOtiw2i6COj
        xMwnf5kgnC2MEhPfnQIbxSagI3H+zR1mEFtEQFzixOnNYGOZBZ4CdRx6ygSSEBawkdj46wc7
        iM0ioCrxcd50sBW8ArYS5/rWQt0kL9F2fTojiM0pYCexbv9RsF4hoJrTu7ZB1QtKnJz5BOxU
        ZqD65q2zmSFsCYmDL14wQ8xRkvj6phfqhVqJz3+fMU5gFJmFpH0WkvZZSNoXMDKvYhRJLS3O
        Tc8tNtIrTswtLs1L10vOz93ECIzAbcd+btnBuPLVR71DjEwcjIcYJTiYlUR422fGpwjxpiRW
        VqUW5ccXleakFh9iNAX6cyKzlGhyPjAF5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRm
        p6YWpBbB9DFxcEo1MC0KW938SNlh/ryFfFL3jLf3ZNi1HOu18/mv173yaYbW230v+4Lvxrj6
        1t+6+eDZ/arfYWmHRP0PK0gvMak6rKB9i8Oyc+bHd2+5as+4b1k5O5y77J/91hTldlMeVuY8
        ba3nwXPizzF2xlae1dWWK2d+1sS/+t8vsUbxCaoXE+5OX34wVfzi0f86rj2cU7OZJZcdlonZ
        tIi5qJ87b+PiYrEFB3+4bj35NZ6PQ65t8rW0V3utd01lD9/Q7Vb0Uzw2bpb36/jlv49tnHim
        kVP72WJ5QY6UJQf+P3vlsyqp40bnJAb9Ez3+F4Q63BTZ4g480G8//EBZc9vFiyrZ8T9jPd95
        Gs+P5F6++0izr8yrCCWW4oxEQy3mouJEAC+FTjtJAwAA
X-CMS-MailID: 20230515071456eucas1p1e92a011498b7f3ca2e02cdc8f0d39415
X-Msg-Generator: CA
X-RootMTR: 20230515071456eucas1p1e92a011498b7f3ca2e02cdc8f0d39415
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071456eucas1p1e92a011498b7f3ca2e02cdc8f0d39415
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071456eucas1p1e92a011498b7f3ca2e02cdc8f0d39415@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The partport driver used to rely on defines to include different
directories in sysctl. Now that we have made the transition to
register_sysctl from regsiter_sysctl_table, they are no longer needed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 56f825fcfae6..e3f773ea6b4f 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -243,13 +243,6 @@ do {									\
 	return 0;
 }
 
-#define PARPORT_PORT_DIR(CHILD) { .procname = NULL, .mode = 0555, .child = CHILD }
-#define PARPORT_PARPORT_DIR(CHILD) { .procname = "parport", \
-                                     .mode = 0555, .child = CHILD }
-#define PARPORT_DEV_DIR(CHILD) { .procname = "dev", .mode = 0555, .child = CHILD }
-#define PARPORT_DEVICES_ROOT_DIR  {  .procname = "devices", \
-                                    .mode = 0555, .child = NULL }
-
 static const unsigned long parport_min_timeslice_value =
 PARPORT_MIN_TIMESLICE_VALUE;
 
-- 
2.30.2

