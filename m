Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2A7053C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjEPQ3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjEPQ3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55158A62
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162915euoutp01d16186fafe9db32bb86bf44167dd9bfc~frJhWMihB2554025540euoutp01r
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516162915euoutp01d16186fafe9db32bb86bf44167dd9bfc~frJhWMihB2554025540euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254555;
        bh=W7dihzloyOGHX/P6A7ZB8/M0bX3upeQ6S1Swn9gTfuA=;
        h=From:To:CC:Subject:Date:References:From;
        b=BF1cTWL4hPnKuDstUWcL2cR+9WabFfStQ66EJv+xFaeFKD87tSrjWnva+nf5m98ml
         KMsXlGtcD8gsVuSZrciRNScxhmTK3w8MCu+5Ec9ZRKvEOoyhGNcYqyrDLxF19uoI0P
         KEPUgLtRwAjVjocd1OyQXPOGQ8hXIr4aQz8nFung=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516162915eucas1p2ad0d6bdd44c9c2ede2eae760875abc8b~frJhOlulI0694006940eucas1p2E;
        Tue, 16 May 2023 16:29:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.FF.35386.B5FA3646; Tue, 16
        May 2023 17:29:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc~frJgsc_yG1394513945eucas1p22;
        Tue, 16 May 2023 16:29:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230516162915eusmtrp2fd8a9117c9ad59c7279d620e62b81993~frJgr9hmY0735707357eusmtrp2J;
        Tue, 16 May 2023 16:29:15 +0000 (GMT)
X-AuditID: cbfec7f4-cc9ff70000028a3a-41-6463af5b47d5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.79.14344.B5FA3646; Tue, 16
        May 2023 17:29:15 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162915eusmtip157f3831bb77d23fd738fc5d75d0bb9ce~frJgfXWgH0564905649eusmtip1_;
        Tue, 16 May 2023 16:29:15 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:13 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 0/6] sysctl: Remove register_sysctl_table from parport
Date:   Tue, 16 May 2023 18:28:57 +0200
Message-ID: <20230516162903.3208880-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned3o9ckpBvcm6lmc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJVxa8ocloJbPBVdPefYGhjXc3UxcnJICJhIrD9/m6WLkYtDSGAFo8SOWXugnC+M
        EvO6v7OCVAkJfGaU+LrLCKZjwoxmJoii5YwS/d0PGOGKjn+IgUhsYZToeNPIDpJgE9CROP/m
        DjOILSIgLnHi9GZGkCJmgaeMEvf2rmbrYuTgEBbwlNi8WgekhkVAVWLWi+1MIDavgK3Eq+2b
        mSA2y0u0XZ/OCBEXlDg58wkLiM0MFG/eOpsZwpaQOPjiBTNEvZJE+8QHrBB2rcSpLbfArpYQ
        OMEhcf7MRhaIhIvEl8b7UEXCEq+Ob2GHsGUk/u+cD9UwmVFi/78P7BDOakaJZY1foU6ylmi5
        8oQd5AMJAUeJp7M4IEw+iRtvBSEO4pOYtG06M0SYV6KjTQiiUU1i9b03LBMYlWcheWcWkndm
        IXlnASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMD0cvrf8S87GJe/+qh3iJGJg/EQ
        owQHs5IIb2BfcooQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUwWSYO
        TqkGptk+pwoE+fpS1njG/0niq2R1TV+xTmano6tZcrv2fx5nm+0MkmzfJs9jdw0+qst14qPc
        7awbyz4HTFt2Tto4nF8lYnl29cTugiPZZ6a87Q9O3fQqaGNr47knDI+PK8ZvOflL2HBu0b7/
        O1fdNetZrF/5dGfzzPs19SU5q7y47KtC1XsWBkcEFd/Ma/L3z3JMe1pR8lot7pbDdBEPXhE/
        JxMOnnlVZmfn2znkHL41Q2elTVR0vejf0DY94zazfpM93902rD3ltXzGrzvb+3M6ddgmTC41
        enimhPuou9nUDqHSLN/j9juun3AJfZU5p7/TqHur72fXZWeyDxufYHbuned/75SSeprLgx9L
        +DKVWIozEg21mIuKEwEe+cL+ngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7rR65NTDNY9Zbc4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j1pQ5LAW3eCq6
        es6xNTCu5+pi5OSQEDCRmDCjmamLkYtDSGApo8TWi9vYIBIyEhu/XGWFsIUl/lzrYoMo+sgo
        cXPvcqiOLYwS3/6/ZQapYhPQkTj/5g6YLSIgLnHi9GZGEJtZ4DGjxJyDsl2MHBzCAp4Sm1fr
        gIRZBFQlZr3YzgRi8wrYSrzavpkJYpm8RNv16YwQcUGJkzOfsECMkZdo3jqbGcKWkDj44gUz
        RL2SRPvEB1CH1kp8/vuMcQKj0Cwk7bOQtM9C0r6AkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+
        7iZGYDRtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMIb2JecIsSbklhZlVqUH19UmpNafIjRFOif
        icxSosn5wHjOK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgWqwT
        6VDqzrnAhvmg59WfFeJMaXPlVLX/OxaaTuVoNV6YYOiw9hW/p+3zDSuXSZm8COPy4wu5pn1J
        OOP4HL93m7V2FFW4Bk5+knT6+rm8tMnTXoSJSrgETbIR/VG15h37imBZ7kAWtZXiWywE7knp
        uS5S4Kwt+jh3wzFJMZmX812f+x7d0fdUV/LcEadzIVOkXjjMYVmf/HZH59N1JRJ9r78tfcUi
        stTF5Bb3kmN3wlP2f4/4Fnf5n4Gsyeam+tqJ219o3LT/nGh34cPxe+zWC17sd21R39U0q2TV
        qzybvWJOtTVfc74dKpDeUNC2q4L7b++qkhi2syyaffdO8vBa233/o5ys+rtm7WoP5tuRSizF
        GYmGWsxFxYkAB0klvy8DAAA=
X-CMS-MailID: 20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc
X-Msg-Generator: CA
X-RootMTR: 20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc
References: <CGME20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc@eucas1p2.samsung.com>
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

V2:
* Added a return error value when register fails
* Made sure to free the memory on error when calling parport_proc_register
* Added a bloat-o-meter output to measure bloat
* Replaced kmalloc with kzalloc
* Added comments about testing
* Improved readability when using snprintf

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

 drivers/parport/procfs.c | 169 +++++++++++++++++++++------------------
 drivers/parport/share.c  |   2 +-
 fs/proc/proc_sysctl.c    |   5 +-
 include/linux/parport.h  |   2 +
 include/linux/sysctl.h   |   8 +-
 5 files changed, 95 insertions(+), 91 deletions(-)

-- 
2.30.2

