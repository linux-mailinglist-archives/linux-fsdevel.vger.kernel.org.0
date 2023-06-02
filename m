Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D055720004
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjFBLHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjFBLHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943BE56
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:06:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110641euoutp02ca9e7672ebfe20cf2819238a37b408c0~k0tuyaTK52892728927euoutp024
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602110641euoutp02ca9e7672ebfe20cf2819238a37b408c0~k0tuyaTK52892728927euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704001;
        bh=/IvdWLJTufhWWn69HB/rMKuMcUhIzU3EVWuNWQ6mpUM=;
        h=From:To:CC:Subject:Date:References:From;
        b=ptrVYktW4BYAvj2ZGPBazSZXMo0/4zI7icnu0l9YWHsUyHQBLDJUZhyv1S6lm/c12
         3jH1NTyjBHM5lJrEM3e3idkWEz35q2yxBvBBr95uCKYD8Za6cs+2exQCMWV8B2Dln8
         7kBk6hiTn2V25oCvnk3LHKEJmwD2fDV10D75YnqY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110640eucas1p279fa8c4ec67c6f8356cc210b6efbf637~k0tuFa9CM2052220522eucas1p2Y;
        Fri,  2 Jun 2023 11:06:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F8.67.11320.04DC9746; Fri,  2
        Jun 2023 12:06:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e~k0ttmYNQO0212702127eucas1p1S;
        Fri,  2 Jun 2023 11:06:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110640eusmtrp109aa7063083d030c74088e9a6b687fac~k0ttl66xg2194821948eusmtrp1O;
        Fri,  2 Jun 2023 11:06:40 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-67-6479cd406f96
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.A9.10549.04DC9746; Fri,  2
        Jun 2023 12:06:40 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110640eusmtip1d6d2f7eb83ffec13792372da0c4b1d35~k0ttX_WIb0527605276eusmtip1K;
        Fri,  2 Jun 2023 11:06:40 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:39 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 0/8] Remove child from struct ctl_table
Date:   Fri, 2 Jun 2023 13:06:30 +0200
Message-ID: <20230602110638.789426-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7oOZytTDPYc17LYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DK+Nh9i6nggVDFqU2r2RoY
        T/B1MXJySAiYSHybNIe5i5GLQ0hgBaPEo8n/mCCcL4wSBy4uYIRwPjNKTPi3iK2LkQOs5eoJ
        LYj4ckaJr60nmeCKTk+/AzVrC6PEw4P/mUCWsAnoSJx/A5Lg5BAREJc4cXoz2FhmgQmMEn3r
        frGAJIQFzCWeX94DZrMIqEjM3HKOEcTmFbCRmLNnDTPEtfISbdenQ8UFJU7OfAJWzwwUb946
        mxnClpA4+OIFVL2yxIR1v1kh7FqJU1tugZ0qIbCSQ+LStAZ2iISLxI97/SwQtrDEq+NboOIy
        Eqcn97BANExmlNj/7wM7hLOaUWJZ41cmiCpriZYrT9ghIeMoseV+KYTJJ3HjrSDEQXwSk7ZN
        Z4YI80p0tAlBNKpJrL73hmUCo/IsJO/MQvLOLCTvLGBkXsUonlpanJueWmyUl1quV5yYW1ya
        l66XnJ+7iRGYNk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4RUKK08R4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwGRisHynp5ZV7KGzr5LM+28YCnRqVncE
        /Tf9zrUw4/ePiw8en6+Uyj94M6RQpP8N3wODtNsRIkqvLTvOCfi1MInqb5jgK3vRg3d+6O0f
        KX/agwo8RWtK4i8GN6+fyCz6yz9t/sXe20+1I42/fRKceq0sX0W5e45ZXbtbnyvv3Sblt7t7
        73DPf3L0Vdlu8aTOOavc5l1wS/tnJ+2lbWWiftny4Cy/fY7GxjbuMqf/qTFKarltFP+Z6zr1
        SXXGiSf7/l0svhX5btmLK6mLVHW4q8U9GI9uX3mnVNGQadM/C+91+Yp1wtZnuL8znjo66c5D
        feXb0xtfH72x5csT21k5t2Z1za2v47ktHKt/RvSLkRJLcUaioRZzUXEiAIFino6KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4XV2Hs5UpBpe+cFrs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlfOy+xVTwQKji1KbVbA2MJ/i6GDk4JARMJK6e0Opi5OIQ
        EljKKPF6wQr2LkZOoLiMxMYvV1khbGGJP9e62EBsIYGPjBJzv4hBNGxhlLjweQ0zSIJNQEfi
        /Js7YLaIgLjEidObGUGKmAUmMEr0rfvFApIQFjCXeH55D5jNIqAiMXPLOUYQm1fARmLOHohB
        EgLyEm3Xp0PFBSVOznwCVs8MFG/eOpsZwpaQOPjiBVS9ssSEdb+hLq2V+Pz3GeMERqFZSNpn
        IWmfhaR9ASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAI2Xbs5+YdjPNefdQ7xMjEwXiI
        UYKDWUmEVyisPEWINyWxsiq1KD++qDQntfgQoynQPxOZpUST84ExmlcSb2hmYGpoYmZpYGpp
        ZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwBQcWr2h80FwUsQG/1VF1c18X56ZuBe5PXCK
        m+4/q32vv+BVvi+LVELqtwVNalxlovb13uR/OZ4Kt92srpxbxul+5ODFttunNU5bfr+6QFUs
        J3TG+fprbPUX/kktNrm8yeyHwSLh0MjFqmuX7tDqbXIsKS9bOUFr2bZFrMU5NziYwl0ro6we
        /djLoL3td0+C0d7dTIyLCiZei93yof3GjQ9SH+fzaTAzhq30SNbQdLARD9nQ9T6waZJEwOzd
        lybs3bazJLLp0taZ589qBIl8nDGd3V7S60quvaL10t1iRULFM1z0/uf4BrDNs+zdculL1eXC
        wkynlXb75u//vbDhXkjbbKOkpyzFn1rnHVSeeUiJpTgj0VCLuag4EQCNM0bwGQMAAA==
X-CMS-MailID: 20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e
X-Msg-Generator: CA
X-RootMTR: 20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e
References: <CGME20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e@eucas1p1.samsung.com>
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

Resending as the first set got mangled with smtp error.

This is part of the effort to remove the empty element of the ctl_table
structures (used to calculate size) and replace it with an ARRAY_SIZE call. By
replacing the child element in struct ctl_table with a flags element we make
sure that there are no forward recursions on child nodes and therefore set
ourselves up for just using an ARRAY_SIZE. We also added some self tests to
make sure that we do not break anything.

Patchset is separated in 4: parport fixes, selftests fixes, selftests additions and
replacement of child element. Tested everything with sysctl self tests and everything
seems "ok".

1. parport fixes: @mcgrof: this is related to my previous series and it plugs a
   sysct table leak in the parport driver. Please tell me if you want me to repost
   the parport series with this one stiched in.

2. Selftests fixes: Remove the prefixed zeros when passing a awk field to the
   awk print command because it was causing $0009 to be interpreted as $0.
   Replaced continue with return in sysctl.sh(test_case) so the test actually
   gets skipped. The skip decision is now in sysctl.sh(skip_test).

3. Selftest additions: New test to confirm that unregister actually removes
   targets. New test to confirm that permanently empty targets are indeed
   created and that no other targets can be created "on top".

4. Replaced the child pointer in struct ctl_table with a u8 flag. The flag
   is used to differentiate between permanently empty targets and non-empty ones.

Comments/feedback greatly appreciated

Best
Joel

Joel Granados (8):
  parport: plug a sysctl register leak
  test_sysctl: Fix test metadata getters
  test_sysctl: Group node sysctl test under one func
  test_sysctl: Add an unregister sysctl test
  test_sysctl: Add an option to prevent test skip
  test_sysclt: Test for registering a mount point
  sysctl: Remove debugging dump_stack
  sysctl: replace child with a flags var

 drivers/parport/procfs.c                 |  23 ++---
 fs/proc/proc_sysctl.c                    |  82 ++++------------
 include/linux/sysctl.h                   |   4 +-
 lib/test_sysctl.c                        |  91 ++++++++++++++++--
 tools/testing/selftests/sysctl/sysctl.sh | 115 +++++++++++++++++------
 5 files changed, 204 insertions(+), 111 deletions(-)

-- 
2.30.2

