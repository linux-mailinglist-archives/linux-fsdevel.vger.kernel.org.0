Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51C271FE8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjFBKIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFBKIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:08:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17A180
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:08:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602100809euoutp01dc02368a423a888f2f86639a3b42cccd~kz6oF7AjJ0428904289euoutp01a
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602100809euoutp01dc02368a423a888f2f86639a3b42cccd~kz6oF7AjJ0428904289euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685700489;
        bh=YMh8Ybc8ZUhmFobAF8M2OSS9v8d0UX2pSUgXc6DqSNY=;
        h=From:To:CC:Subject:Date:References:From;
        b=FpZ2uz9p7xrKGDBdWYA84As+YaBBdVQj+LlfIX53ZlrKEgCCZrOK65ABxTBqm0TV6
         d1eRzdvA+x7Tf9mmZw8qHKSbqhrTqPqY1/kd2xm8GbAjF3rFLVaTCNe2GCBdm7kTze
         LtDnqpgkC4aHQbjqlgfI5Z89vVH26z73SMcm5m6w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602100809eucas1p204242a767a6ae83c3e61eb9ae3ba99eb~kz6oAp1oC0507505075eucas1p2U;
        Fri,  2 Jun 2023 10:08:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AE.25.37758.98FB9746; Fri,  2
        Jun 2023 11:08:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230602100809eucas1p2c8bb96fb0de40a0f38ab28611246f95c~kz6nt6e6D1573015730eucas1p2w;
        Fri,  2 Jun 2023 10:08:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602100809eusmtrp1765fdb334f9cc2a9e47219413270d330~kz6ntbXBx1803818038eusmtrp1F;
        Fri,  2 Jun 2023 10:08:09 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-2d-6479bf898be1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.34.14344.98FB9746; Fri,  2
        Jun 2023 11:08:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230602100809eusmtip286e1106ead142a78db2efe8dde0e6c6b~kz6nfJWms0046600466eusmtip2L;
        Fri,  2 Jun 2023 10:08:09 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 11:08:08 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 0/8] Remove child from struct ctl_table
Date:   Fri, 2 Jun 2023 12:07:57 +0200
Message-ID: <20230602100805.777917-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djP87qd+ytTDHpWKljs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlHDuznL1gqVDFnSWH2BoY
        Z/F1MXJySAiYSOy+8YO9i5GLQ0hgBaNE/7otjBDOF0aJHS23mSGcz4wSTbdOs8O0PGrewAZi
        CwksZ5T4clcZrqht+Qyo9i2MEhv+TGMFqWIT0JE4/+YOM4gtIiAuceL0ZkYQm1lgAqPErEMc
        ILawgLnE88t7WLoYOThYBFQk1k6MAAnzCthIXFncwwSxWF6i7fp0Roi4oMTJmU9YIMbISzRv
        nc0MYUtIHHzxghmiXlliwrrfrBB2rcSpLbeYQG6TEFjJIXHzYg8byC4JAReJCYvUIGqEJV4d
        3wL1pIzE6ck9LBD1kxkl9v/7wA7hrGaUWNb4Feoia4mWK0/YIQY5SrxaIgRh8knceCsIcQ+f
        xKRt05khwrwSHW1CEI1qEqvvvWGZwKg8C8k3s5B8MwvJNwsYmVcxiqeWFuempxYb56WW6xUn
        5haX5qXrJefnbmIEJozT/45/3cG44tVHvUOMTByMhxglOJiVRHiFwspThHhTEiurUovy44tK
        c1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTBtd/kx9YzIV6Hzlw59ZJ+UMeOP
        Y7HX69VmVtv2HuzYKP1+X/3no58EnEqtYm5Y2cjK+8S0LZ9yV4C77q07f7n8WY51nBuiT/VF
        8oeK93HuaJq8IqRy64EPXl8Vvu1vKuN89Dj4fOZZ15ali5wWxH7VVjntVWFt8DPvnDNL1zSD
        xlfK6/JXfvr5w/t/h07m9Q+2x+7f1F1/3kXWO6KZZ6FjcI7L2Rg1+zU+uS6tjfOX77jE8OA1
        1y9uU74zMi4T/GobzusdDQ/5zCS0vGbHqkf/Zu3YlXfqBuNm9vAnbQJRm9SYzNPerOIpe5f/
        5PLBlIqXmxy0GsN1D97ueppwnz/mS+8/UY+HneKKp45s/PtRiaU4I9FQi7moOBEA3BCi4ocD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd3O/ZUpBvP6OS327D3JYnF51xw2
        i+l33rNZ3JjwlNGBxWPTqk42j8+b5AKYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyjp1Zzl6wVKjizpJDbA2Ms/i6GDk5JARMJB41b2DrYuTi
        EBJYyihxqOc9C0RCRmLjl6usELawxJ9rXVBFHxkllr07wwrhbGGUWHngLjNIFZuAjsT5N3fA
        bBEBcYkTpzczgtjMAhMYJWYd4gCxhQXMJZ5f3gO0gYODRUBFYu3ECJAwr4CNxJXFPUwQy+Ql
        2q5PZ4SIC0qcnPmEBWKMvETz1tnMELaExMEXL5gh6pUlJqz7DXVorcTnv88YJzAKzULSPgtJ
        +ywk7QsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERsi2Yz+37GBc+eqj3iFGJg7GQ4wS
        HMxKIrxCYeUpQrwpiZVVqUX58UWlOanFhxhNgd6ZyCwlmpwPjNG8knhDMwNTQxMzSwNTSzNj
        JXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYm9/v/TOt/VSsKO3xgzWrdfkOnMLi6JUF9ip9z
        mOnlp5NVuJveHUg8EsP9/+nKzDe/1qyfckFz5ebFrFPv7zT6Zn5Lx9xfuen6zJVzPHuuTi7i
        OXcoeG7oGwWFF61faqf/PslbUbXq+8Izk+f8P9bfL/b6ZdTzD3d3TxRqFG4oWCjz8aW9FMvD
        k3eUrU+wFD/eNeHWv/CFT7LLr5dkft6tsMlSlann82LnWdxf9gTX3Frx5fX7RrMp/celnpYt
        bfqUaPN2S+eD7ufrxcQYhf0KOPL+uSQI7dWYaTohj7NPelPzbveXq7xXfMk5dnLqLN0tfOmn
        uN+LunLHz/2VU/l+F6dl98lOo4MHXGI3icdeXarEUpyRaKjFXFScCABFnWLEGQMAAA==
X-CMS-MailID: 20230602100809eucas1p2c8bb96fb0de40a0f38ab28611246f95c
X-Msg-Generator: CA
X-RootMTR: 20230602100809eucas1p2c8bb96fb0de40a0f38ab28611246f95c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602100809eucas1p2c8bb96fb0de40a0f38ab28611246f95c
References: <CGME20230602100809eucas1p2c8bb96fb0de40a0f38ab28611246f95c@eucas1p2.samsung.com>
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

