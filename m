Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC37053E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjEPQay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEPQ3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:51 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999207EE1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:38 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162926euoutp0291659828d55938d695a847f4afad2fee~frJqunMDC2992529925euoutp02H
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230516162926euoutp0291659828d55938d695a847f4afad2fee~frJqunMDC2992529925euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254566;
        bh=Uighe2MJl9yCP9/daoYtGOQ9P01aVBh946aqBbx2U6o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GnZQ+fpKbYmO9psOZUljI6jzW1HogCxpi1KxB/CSpC/y1T/DXxi4eSEtZ22zj9ixl
         EcS2YqSaxHIEM1vBh9wf0wbVG2xNWQEclSXPmMOoZpZhfROIE/JX+Z06o8YylLICcD
         z4L+awvz3MVeTLhavRnKjuPANTh8SM+8aa+u9hIE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516162925eucas1p2ba41bba44aaf1d50540463cc05ed866f~frJqh23Nk1677416774eucas1p2y;
        Tue, 16 May 2023 16:29:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.C3.42423.56FA3646; Tue, 16
        May 2023 17:29:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230516162924eucas1p210b95df5fd4229aeaa5cb41d6d873f3d~frJpep6b_1671116711eucas1p2u;
        Tue, 16 May 2023 16:29:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162924eusmtrp1e9c208a93cae3a4e19486cee9a86e8e0~frJpeISpr2056220562eusmtrp1G;
        Tue, 16 May 2023 16:29:24 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-c1-6463af65a6f6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.57.10549.46FA3646; Tue, 16
        May 2023 17:29:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162924eusmtip1879164ba7cfddefcb079a7c5106882d0~frJpTzmpT2290922909eusmtip1i;
        Tue, 16 May 2023 16:29:24 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:23 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 5/6] parport: Removed sysctl related defines
Date:   Tue, 16 May 2023 18:29:02 +0200
Message-ID: <20230516162903.3208880-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned3U9ckpBvMmaVmc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJUxpXUqa0EPZ8WiZ72MDYxt7F2MnBwSAiYSm0/PZASxhQRWMEqcWh7bxcgFZH9h
        lDh7eBUzhPOZUWLnrZNwHY37v7JAJJYzSqxs2IZQ1fLzGjuEs4VRoqv3JlgLm4COxPk3d5hB
        bBEBcYkTpzczghQxCzxllLi3dzVbFyMHh7CAvcTx26YgJouAqsSBTQUg5bwCthJvD/YzQWyW
        l2i7Ph3sVk4BO4n3azYxQdQISpyc+YQFxGYGqmneOpsZwpaQOPjiBTNEr5JE+8QHrBB2rcSp
        LbeYQE6QELjDIdH09AtUwkXi06IVbBC2sMSr41ugXpaROD25hwWiYTKjxP5/H9ghnNWMEssa
        v0KdZy3RcuUJVIejxJtnu9lBvpEQ4JO48VYQ4iI+iUnbpjNDhHklOtqEJjCqzELywywkP8xC
        8sMCRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgQnm9L/jn3Ywzn31Ue8QIxMH4yFG
        CQ5mJRHewL7kFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTByc
        Ug1Mc1mTFqxaYH/iwobgA2fYi2cHy6ft9XnpXPEs5KZ8ps8czegrjeo3l6y6dLzB20aZJT5e
        ak3oNPEt96pu+e7Q0vp9XJBzlbF44JELN1j+LpohceKMJ9/ZozvES95M2cNT1aPLw3/5Nu/X
        dUyaWhcf9TeGKuqvqI9JNdzVONdjh/MDlwjWYmnzzJ43adpGWarn58+VtrrwMXum+sUt9ikG
        9aUTld9aCIT3TnAwN4rSZEwo4Lq/eKbC1diHAd++X4ns+7SZSe44PzfPhEU+8xM+eMs1xJRs
        ZLr74Hxay8Plrap6/X5K025vDu6J/pzxX85UhXuC7dY/n/edXueTopthX+C5Uuvaz6nNLxTm
        GIopsRRnJBpqMRcVJwIAcEl6Sp8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7op65NTDN7+U7E4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jSutU1oIezopF
        z3oZGxjb2LsYOTkkBEwkGvd/Zeli5OIQEljKKLF4STczREJGYuOXq6wQtrDEn2tdbCC2kMBH
        RonNx1ghGrYwSnxrOcoCkmAT0JE4/+YOWLOIgLjEidObGUFsZoHHjBJzDsp2MXJwCAvYSxy/
        bQpisgioShzYVABSwStgK/H2YD8TxCp5ibbr08E6OQXsJN6v2cQEsdZWYuLyHhaIekGJkzOf
        sEBMl5do3jqbGcKWkDj44gXU+UoS7RMfQJ1fK/H57zPGCYwis5C0z0LSPgtJ+wJG5lWMIqml
        xbnpucWGesWJucWleel6yfm5mxiBkbft2M/NOxjnvfqod4iRiYPxEKMEB7OSCG9gX3KKEG9K
        YmVValF+fFFpTmrxIUZToDcnMkuJJucDYz+vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEk
        NTs1tSC1CKaPiYNTqoGJ9Yoe4+LMY1FVmxz/XeK4aJDMLxC2dk19ZJ1LS9HJ46eTwpQk5/JN
        tO5OebPg/4L0zHr7nbGH5ZTPXHpYm+Gz4vwlkcLg/bGHV7fwnee5GF659lvWJ+dt9XODRGIY
        l71fG5Qm5bjax9/L03vp/6+Bt76u71kYo92zuIb5tzxHmtU7Vk2tkJqHHd/KU72y+Rm7O+3/
        TJuYqnTQaEes0/WNN2ykSi6mhDM2mop7bzjW6srzWvzVEoeA+0rtboG7j7KXZF/glns9Uc2z
        Kj70xnKj2Q2ObixT8t0uZ0WxhudWzj5/1DbfVZwndPPboFes+9K0lGz9OJRipdaUxeY6BrZO
        e/LjWqfV2iimXumLSizFGYmGWsxFxYkAOR9bR0UDAAA=
X-CMS-MailID: 20230516162924eucas1p210b95df5fd4229aeaa5cb41d6d873f3d
X-Msg-Generator: CA
X-RootMTR: 20230516162924eucas1p210b95df5fd4229aeaa5cb41d6d873f3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162924eucas1p210b95df5fd4229aeaa5cb41d6d873f3d
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162924eucas1p210b95df5fd4229aeaa5cb41d6d873f3d@eucas1p2.samsung.com>
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

The partport driver used to rely on defines to include different
directories in sysctl. Now that we have made the transition to
register_sysctl from regsiter_sysctl_table, they are no longer needed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 5a58a7852464..f985248b2c5b 100644
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

