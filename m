Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3554F34384F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVFWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46748 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVFWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210322052211epoutp03786c34d67f5c8b3c0395fb861a801034~ukp-vZ-4F0411204112epoutp03T
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210322052211epoutp03786c34d67f5c8b3c0395fb861a801034~ukp-vZ-4F0411204112epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390531;
        bh=xsBknzlDxmSfXAIXNzGrnEmNwCb0KAIpNYMKuTCtwZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6sFXbpnj1iY3SfhQapGtD0+FzUcN+6+lj1aIAqwdkeg2rLUd77QO9yLvHwSqrf6S
         8N6ykn1MiNlZLY8gSEDWTRxrjRLJzBTUhiypNqGboFZOf9qscveTGN0VgLn2IJI9U6
         YbiCjljlAVY4c4Yc5VS7IMmHkhZQXpW/BUTgfvTM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210322052211epcas1p2fc3e4af73fcc7fc31996c050b55110a5~ukp-NOHkL2684726847epcas1p2r;
        Mon, 22 Mar 2021 05:22:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F3jYG1nh1z4x9Q1; Mon, 22 Mar
        2021 05:22:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.DF.22618.28928506; Mon, 22 Mar 2021 14:22:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210322052209epcas1p377f1542bcc9ec50219d2e57aa92d944b~ukp9rpaMl0477604776epcas1p3X;
        Mon, 22 Mar 2021 05:22:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322052209epsmtrp153afb827eaea1817ae1c2c99913b6e44~ukp9qt53K2013120131epsmtrp1T;
        Mon, 22 Mar 2021 05:22:09 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-3b-605829820f92
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.36.08745.18928506; Mon, 22 Mar 2021 14:22:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052209epsmtip1a469f00e6d3c195cfe07048c77f689b8~ukp9XpxpF1778317783epsmtip1Z;
        Mon, 22 Mar 2021 05:22:09 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5/5] MAINTAINERS: add cifsd kernel server
Date:   Mon, 22 Mar 2021 14:13:44 +0900
Message-Id: <20210322051344.1706-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmrm6TZkSCwc4WNovGt6dZLI6//stu
        8Xt1L5vF63/TWSxOT1jEZLFy9VEmi2v337NbvPi/i9ni5//vjBZ79p5ksbi8aw6bxY/p9RZv
        7wDV9vZ9YrVovaJlsXvjIjaLtZ8fs1u8eXGYzeLWxPlsFuf/Hmd1EPGY1dDL5jG74SKLx85Z
        d9k9Nq/Q8ti94DOTx+6bDWwerTv+snt8fHqLxaNvyypGjy2LHzJ5rN9ylcXj8yY5j01P3jIF
        8Ebl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPauk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJ+Pd8JWvBBu6K1dMnsDYwPubsYuTkkBAwkZh+6g5bFyMXh5DADkaJ/R/+MkM4nxgl1j38
        yQThfGaUmNXynwmmZWfzQxaIxC5Gife/FiK03Fo5B6iKg4NNQFvizxZRkAYRgViJGzteg9Uw
        C1xjlji+YCYjSEJYwFLi6bQnLCA2i4CqxKV5fWwgNq+AtcSr0y8YIbbJS6zecIAZxOYUsJGY
        trwTbLOEwAMOidXLbrFAFLlInJi4mB3CFpZ4dXwLlC0l8bK/jR3kIAmBaomP+5khwh2MEi++
        20LYxhI3129gBSlhFtCUWL9LHyKsKLHz91ywE5gF+CTefe1hhZjCK9HRJgRRoirRd+kwNEyk
        JbraP0At9ZBY8uYZNHz6GSV+b3jPNIFRbhbChgWMjKsYxVILinPTU4sNC0yQY2wTIzg1a1ns
        YJz79oPeIUYmDsZDjBIczEoivCeSQxKEeFMSK6tSi/Lji0pzUosPMZoCw24is5Rocj4wO+SV
        xBuaGhkbG1uYmJmbmRorifMmGTyIFxJITyxJzU5NLUgtgulj4uCUamCa/CF+tlDl1S3HmLy+
        hdVsrBecO/1LVUXXyr/BP8XUTLtZJl3K7XS7/aQ6fkfLBcm6ykuNb8MPRLV++544YdPlotCM
        uStm9a9er3bo+MzVZxqnBIYoBk6+Luz967/BweMqD7q/iTmds/jE2r4rapPR0qlM6/dq7a28
        tKqnota53IQ/x/3OAXdfI49LrbfmfwgMvxLLoqFwaEkrp4txd4xzcceUqXsW8jO84HESY0tt
        tfvwPs4pbPIT51zJd/s78r8zThBbFR2rMWlx3zdnD80/tt7Powo3TbZSXxZo9J7l3hzTqpwn
        QYsatslU2VrtmFqRU8t2/HiOsKiadsucRRp5K7v2P3Yq3PX0wDdbFkElluKMREMt5qLiRACq
        301iVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6jZkSCwalpchaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtifPZLM7/Pc7qIOIxq6GXzWN2w0UWj52z
        7rJ7bF6h5bF7wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK
        4I3isklJzcksSy3St0vgyvj3fCVrwQbuitXTJ7A2MD7m7GLk5JAQMJHY2fyQpYuRi0NIYAej
        xJmmuYwQCWmJYyfOMHcxcgDZwhKHDxdD1HxglDjR38gCEmcT0Jb4s0UUpFxEIF7iZsNtsDnM
        Aq+YJVatPc0EkhAWsJR4Ou0JC4jNIqAqcWleHxuIzStgLfHq9AuoXfISqzccYAaxOQVsJKYt
        7wSrFwKqmdl6n2kCI98CRoZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBEaSltYNx
        z6oPeocYmTgYDzFKcDArifCeSA5JEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJ
        anZqakFqEUyWiYNTqoHpjK/1nItl27R8cm/aMRgvNK08felmoFxWW91FwzwrT80372Nq1kws
        UP0oWmO56CD7V7aNe5dzxCldaz1Xor3faoXO9lqlpU3l+blf1db/77vxYvPGkKDdN73Pm63J
        371iu9u1FwkWukt4jap22W3d4PJ+gsWjAJkJvh8F9l3MvGT52XeXkseTaaVTxQNn/6+zSHZr
        jLwStP7LDtvsjiNsU0J3Pp2fc/m2rSrr8SZVUf1NwjWn1m0//F3CdlrlDXmm9JmzZyee6d+j
        f2jDrxtBRwKzXWekN6W694TaLzdf+jRZ2lWZlXlSRvPq9rmWXK2KMhlbb1ztdfSzOMJcsT1v
        vTKv26IKa6kJq7el7JZQYinOSDTUYi4qTgQAi4piJA8DAAA=
X-CMS-MailID: 20210322052209epcas1p377f1542bcc9ec50219d2e57aa92d944b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052209epcas1p377f1542bcc9ec50219d2e57aa92d944b
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052209epcas1p377f1542bcc9ec50219d2e57aa92d944b@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself, Steve French, Sergey Senozhatsky and Hyunchul Lee
as cifsd maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..30f678f8b4d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4434,7 +4434,7 @@ F:	include/linux/clk/
 F:	include/linux/of_clk.h
 X:	drivers/clk/clkdev.c
 
-COMMON INTERNET FILE SYSTEM (CIFS)
+COMMON INTERNET FILE SYSTEM CLIENT (CIFS)
 M:	Steve French <sfrench@samba.org>
 L:	linux-cifs@vger.kernel.org
 L:	samba-technical@lists.samba.org (moderated for non-subscribers)
@@ -4444,6 +4444,16 @@ T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
 
+COMMON INTERNET FILE SYSTEM SERVER (CIFSD)
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+M:	Steve French <sfrench@samba.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-cifs@vger.kernel.org
+L:	linux-cifsd-devel@lists.sourceforge.net
+S:	Maintained
+F:	fs/cifsd/
+
 COMPACTPCI HOTPLUG CORE
 M:	Scott Murray <scott@spiteful.org>
 L:	linux-pci@vger.kernel.org
-- 
2.17.1

