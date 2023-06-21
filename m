Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14672738048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFUJse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFUJsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:48:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A3EA
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:48:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621094828euoutp02560be9b64b0ea63a3672c246ffe8ec64~qo53f0lMS1958919589euoutp02w
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:48:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621094828euoutp02560be9b64b0ea63a3672c246ffe8ec64~qo53f0lMS1958919589euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687340908;
        bh=dbte9P3LahOTAa8vkLg+Y6+keP5p3Zx/hRuNObHLKVE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BcGKGimtwHugbx0GY6b12ut2JhRSDV5A7THYwSZ3iL8kfg1IAl93KPpRaEgpNplkS
         YdBde4XCVHCUZIkxmpYwFJMYF3DG96cLoC8hnIHeuqAoL8Jd9a9HTcXij5/eYL5U6D
         o/Wciu0IPzA162vaQIEjdwTYjudVFMVN0dXRtSTY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621094828eucas1p2380095a1edd4d673c43affc5299fbab4~qo53OTIyo1478514785eucas1p2T;
        Wed, 21 Jun 2023 09:48:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.FA.42423.C67C2946; Wed, 21
        Jun 2023 10:48:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621094828eucas1p22b0b45adc25f881fe00a20d96d495d95~qo523PHWH0198801988eucas1p2I;
        Wed, 21 Jun 2023 09:48:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621094828eusmtrp11d40c79030349f6083303a91ed30fe41~qo522rCpK1249712497eusmtrp1f;
        Wed, 21 Jun 2023 09:48:28 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-e6-6492c76c5a13
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.06.10549.C67C2946; Wed, 21
        Jun 2023 10:48:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621094828eusmtip181b98584f1c8352c62496699c33e6758~qo52sbIGp1838018380eusmtip1d;
        Wed, 21 Jun 2023 09:48:28 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (106.1.227.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jun
        2023 10:48:27 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 11/11] sysctl: rm "child" from __register_sysctl_table doc
Date:   Wed, 21 Jun 2023 11:48:02 +0200
Message-ID: <20230621094817.433842-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621094817.433842-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
        CAMSVWEXC02.scsc.local (106.1.227.72)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87o5xyelGKz6K2dxpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFFcNimpOZllqUX6dglcGb1L
        rzAWrBKruPdnOlMD41nBLkZODgkBE4lN926ydTFycQgJrGCUWH/6NiOE84VR4vTRFnaQKiGB
        z4wSyxd5wXSca1jHDlG0nFFixaJpzBAOUNHmfRMY4WbNPb2BGaSFTUBH4vybO2C2iEC8xOw1
        2xlBbGaBXIlZy5eAxYUFvCQu/VjNBmKzCKhKzF15A8jm4OAVsJHYcj0PYrO8RNv16WCtnAK2
        Eq9X9IO18goISpyc+YQFYqS8RPPW2cwQtoTEwRcvmCF6lSWu71vMBmEnS7T8+csEYV/hkDj+
        uwRklYSAi8Tzh9YQYWGJV8e3sEPYMhKnJ/ewgLwlITCZUWL/vw/sEM5qRolljV+hBllLtFx5
        wg4xyFGieYIbhMknceOtIMQ5fBKTtk1nhgjzSnS0CU1gVJmF5IFZSB6YheSBBYzMqxjFU0uL
        c9NTiw3zUsv1ihNzi0vz0vWS83M3MQLTyOl/xz/tYJz76qPeIUYmDsZDjBIczEoivLKbJqUI
        8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYFIXqv576dqz
        x7vFnJLnnz7aNlnN8NWZrlfbsn7/2lmw0MyK9XKnPZNMZvjMKlVLR6urxnUz+bIOHAtlklr7
        uVbz2cP578LcxDK/5yoGdCm/Vfa9Zl5leNropKfuj5CcfydEf1cUCNg/lGoQljoSuauuYZ7H
        QQvDRyder9907O/6Hs8E8z7e5RKaen7nNXqV7myoPHYluXR9/bFfsw7vMJef93X7kQ1vVLyO
        zdINFlM8I+7P/vxQKvu9E6sfFeQ53pk85ZiBsqtK4OmUhK9dxx+VKWrOFy/1Ec+wVvteZ3/u
        L9eESQ9/q66f6bbvzy7OkMT0ZWb8LytN2a9YycdnhW1/5KNvzZ4bmct4/+y9V0osxRmJhlrM
        RcWJAKKUufuSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7o5xyelGEybyG5xpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb1LrzAWrBKruPdnOlMD41nBLkZO
        DgkBE4lzDevYuxi5OIQEljJK3Fu7nwkiISOx8ctVVghbWOLPtS42iKKPjBK7/s6C6ljBKDH7
        9mZ2kCo2AR2J82/uMIPYIgLxErPXbGcEsZkFciVmLV8CFhcW8JK49GM1G4jNIqAqMXflDSCb
        g4NXwEZiy/U8iGXyEm3Xp4O1cgrYSrxe0Q/WKiSQL7Fl7Sywg3gFBCVOznzCAjFeXqJ562xm
        CFtC4uCLF8wQc5Qlru9bzAZhJ0tM2vOLcQKjyCwk7bOQtM9C0r6AkXkVo0hqaXFuem6xoV5x
        Ym5xaV66XnJ+7iZGYKRtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIru2lSihBvSmJlVWpRfnxR
        aU5q8SFGU6A3JzJLiSbnA2M9ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
        j4mDU6qBqcO2j2Ou7TmuRbduLfk8wT+muOpZCBfTWU1NM3vlFZL/1/gIhu+b4/T0ejqPq9qD
        tQadDSecrK6cVdO28XLbNn3O6iUCeQ3pRiLKlYn3L4SwvfnJfPv73E/qpft/dnJ22xy00gtk
        ZTzFqXJLbtXSL6kBvv1PQnq8Hh02kpk236I7pM38glDf8hndqxe3TJ8eu5S/VyNK2ecD61Jl
        xpr4DV4BKYb3Ft3s+cr7Zd8dmcr5+scK3Nbkb9q/4LPvuZmu3lPfv9i9Xq6vy10r9LWer5hB
        VNiiWW2JtUHHDddEiRS99ZR50XOgv+XYnj5fS4bYNs/S72xfqj48CPZ6YZxXIyj/kXnKibuh
        nmHmh/8osRRnJBpqMRcVJwIALybYTz0DAAA=
X-CMS-MailID: 20230621094828eucas1p22b0b45adc25f881fe00a20d96d495d95
X-Msg-Generator: CA
X-RootMTR: 20230621094828eucas1p22b0b45adc25f881fe00a20d96d495d95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621094828eucas1p22b0b45adc25f881fe00a20d96d495d95
References: <20230621091000.424843-1-j.granados@samsung.com>
        <20230621094817.433842-1-j.granados@samsung.com>
        <CGME20230621094828eucas1p22b0b45adc25f881fe00a20d96d495d95@eucas1p2.samsung.com>
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

Remove "child" from code documentation in proc_sysctl.c. Child was
replaced with a explicit size value in ctl header and there is no need
to have it around in the documentation.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9e7e17dd6162..8dbc5b2316a5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1306,27 +1306,22 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure without any child. This table
- * 	 should not be free'd after registration. So it should not be
- * 	 used on stack. It can either be a global or dynamically allocated
- * 	 by the caller and free'd later after sysctl unregistration.
+ *
+ * @table: the top-level table structure. This table should not be free'd
+ * 	after registration. So it should not be used on stack. It can either
+ * 	be a global or dynamically allocated by the caller and free'd later
+ * 	after sysctl unregistration.
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
+ * array.
  *
  * The members of the &struct ctl_table structure are used as follows:
- *
  * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
  *            enter a sysctl file
- *
- * data - a pointer to data for use by proc_handler
- *
- * maxlen - the maximum size in bytes of the data
- *
- * mode - the file permissions for the /proc/sys file
- *
- * child - must be %NULL.
- *
+ * data     - a pointer to data for use by proc_handler
+ * maxlen   - the maximum size in bytes of the data
+ * mode     - the file permissions for the /proc/sys file
+ * type     - Defines the target type (described in struct definition)
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
@@ -1334,8 +1329,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes (where child is not NULL) are not allowed,
- * sysctl_check_table() verifies this.
+ * under /proc; non-leaf nodes are not allowed.
  *
  * There must be a proc_handler routine for any terminal nodes.
  * Several default handlers are available to cover common cases -
-- 
2.30.2

