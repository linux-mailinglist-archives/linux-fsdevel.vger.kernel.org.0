Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0567025D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjEOHOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjEOHOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:53 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA210C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071448euoutp0103c77e1055ab104815db7379b1cbac45~fP8IgkIxz1728617286euoutp01G
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515071448euoutp0103c77e1055ab104815db7379b1cbac45~fP8IgkIxz1728617286euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134888;
        bh=/aP0//3FVl+X1B67wPtxmNdsXL/N70w6OuKKl0fEO5I=;
        h=From:To:CC:Subject:Date:References:From;
        b=judyQFunXAVrmeeO9xyb5GMrpxNXw0GgCHI/0AOuIf0WurFzKNa6z3+gFQUfquDIf
         Xw7pZHbnaiMhgVnz5OFwJMIZWNso2nin6SfzmAgT7vo4aNWy/aXselv1U6Wtb5QPH/
         Mk1cI6dF3iIEE4mnJdI3b6k4LpD4lDHTmbmZ7LqU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230515071448eucas1p2e379c3dde61f96ac655d7f5ce18c2713~fP8IXU4sm2282722827eucas1p2-;
        Mon, 15 May 2023 07:14:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.76.37758.8EBD1646; Mon, 15
        May 2023 08:14:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15~fP8H_ylB22866528665eucas1p1G;
        Mon, 15 May 2023 07:14:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515071448eusmtrp2a9364f93897ca3b8186d8bd8d095c067~fP8H95Dze2610526105eusmtrp2B;
        Mon, 15 May 2023 07:14:48 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-c8-6461dbe8e36e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.D9.14344.7EBD1646; Mon, 15
        May 2023 08:14:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071447eusmtip1a8efc389a5d8cc6946b05574a390f76e~fP8HuHB5z0401404014eusmtip1O;
        Mon, 15 May 2023 07:14:47 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:46 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 0/6] sysctl: Remove register_sysctl_table from parport
Date:   Mon, 15 May 2023 09:14:40 +0200
Message-ID: <20230515071446.2277292-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned0XtxNTDJYfkbQ4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1issmJTUn
        syy1SN8ugStj5+m/TAWPuCrufr3H2MD4hKOLkZNDQsBE4vLcBhYQW0hgBaPE1ucZXYxcQPYX
        Ron5R6YxQSQ+M0r8vyzYxcgB1rBojRFEzXJGiQUNFxFqnm61h0hsAUpsns8IkmAT0JE4/+YO
        M4gtIiAuceL0ZkaQImaBp4wSc//1gnULC7hJHGh6wA5iswioShz8fJQNxOYVsJVYevYXM8Sp
        8hJt16czQsQFJU7OfAJ2NjNQvHnrbGYIW0Li4IsXUPVKEl/f9LJC2LUSp7bcYoKwT3BI7Fsd
        AmG7SFzZsAyqXlji1fEt7BC2jMT/nfOZQA6VEJjMKLH/3wd2CGc1o8Syxq9Qk6wlWq48gepw
        lNi46zA7JIz4JG68FYQ4iE9i0rbpzBBhXomONiGIajWJ1ffesExgVJ6F5J1ZSN6ZheSdBYzM
        qxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQKTy+l/x7/uYFzx6qPeIUYmDsZDjBIczEoi
        vO0z41OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MK27
        yXH69GTOg84q7N0bO91K4hvX3PsguIulnaV2xcl9kgz3i7w3eavZPXv0b4bbyfRNqZtVlhZP
        6Qth2s7mcVv8/pvmbH8xXxOW8LqVO6IXGP8TtIlnS94bx6xYL17A+dF4hfmbB+IbAmrYlpv1
        7Sk4VcwQ9HrHpoJj7qF6U58Grf7GbqW9zO/U5UU7G5gbZt3qYJryr+GYRGLYt5Jnt18d45xT
        OGmpUQ/XLp+bT7hX+2XdFH393uFod06IoR/buerNr5SCcxUv2Oc8FJx+ODth0vnFGh6Xrzzm
        e7Dg78Nfxn6HGzZ5TjuwPyjKjenC9cQfatYcx8TP28jdnWt6q0SY95HZlVkhCfvrf1ezyiix
        FGckGmoxFxUnAgAjiuzYnQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7rPbyemGPxitDjTnWuxZ+9JFovL
        u+awWdyY8JTR4sDpKcwWy3b6ObB5zG64yOKxc9Zddo8Fm0o9Nq3qZPP4vEkugDVKz6Yov7Qk
        VSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pn6b9MBY+4Ku5+
        vcfYwPiEo4uRg0NCwERi0RqjLkYuDiGBpYwS+++9Y+5i5ASKy0hs/HKVFcIWlvhzrYsNougj
        o0TbkoNMIAkhgS2MEhtX+4DYbAI6Euff3AFrFhEQlzhxejMjSAOzwFNGiZmHnoI1CAu4SRxo
        esAOYrMIqEoc/HyUDcTmFbCVWHr2F9RmeYm269MZIeKCEidnPmEBsZmB4s1bZzND2BISB1+8
        gKpXkvj6phfq0lqJz3+fMU5gFJqFpH0WkvZZSNoXMDKvYhRJLS3OTc8tNtIrTswtLs1L10vO
        z93ECIylbcd+btnBuPLVR71DjEwcjIcYJTiYlUR422fGpwjxpiRWVqUW5ccXleakFh9iNAX6
        ZyKzlGhyPjCa80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamMxW
        rZx6JD5Z941GgGV8xgwJpbMb9508lSTQEWfgu33CvBtb57+dfv7tBEGO3km/tzV3vOS4kvSs
        l+HU1obHgYo53R80BZxF1wi5Gm7/1yRbmX486uezlK3Wt1/qFtY25rxK7fkgc+nleV82j1qF
        Zg7jd8Yiq5ZsNLqWwP0nVP3sZ5b4x5ontfYZWi4UCNC+z6yj+L8o02DzyYCfzo3nfquJV2mn
        rVZ6fC6FvStmLe/amVe9nEqFow4+9SyxMaq1975x/f6pQyWTonSlROexf7nuutb+DOf50/mH
        uudtPcJobyO0yuWd/FJn7w27pI4HHWY9/IHJ7WDnTibdqfNjz00U2PKX7VdSbU2Eitl5XyWW
        4oxEQy3mouJEAOF5IhkuAwAA
X-CMS-MailID: 20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15
X-Msg-Generator: CA
X-RootMTR: 20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15
References: <CGME20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. Parport driver uses the "CHILD" pointer
in the ctl_table structure to create its directory structure. We move to
the newer register_sysctl call and remove the pointer madness.

I have separated the parport into 5 patches to clarify the different
changes needed for the 3 calls to register_sysctl_paths. I can squash
them together if need be.

We no longer export the register_sysctl_table call as parport was the
last user from outside proc_sysctl.c. Also modified documentation slightly
so register_sysctl_table is no longer mentioned.

I'm waiting on the 0-day tests results.

Best
Joel

Joel Granados (6):
  parport: Move magic number "15" to a define
  parport: Remove register_sysctl_table from parport_proc_register
  parport: Remove register_sysctl_table from
    parport_device_proc_register
  parport: Remove register_sysctl_table from
    parport_default_proc_register
  parport: Removed sysctl related defines
  sysctl: stop exporting register_sysctl_table

 drivers/parport/procfs.c | 171 +++++++++++++++++++++------------------
 drivers/parport/share.c  |   2 +-
 fs/proc/proc_sysctl.c    |   5 +-
 include/linux/parport.h  |   2 +
 include/linux/sysctl.h   |   8 +-
 5 files changed, 97 insertions(+), 91 deletions(-)

-- 
2.30.2

