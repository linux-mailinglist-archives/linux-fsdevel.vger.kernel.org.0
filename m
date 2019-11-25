Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A436D1085BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYAGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:31 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:21605 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfKYAGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191125000629epoutp042fc01bf974b4b9634b768c05d2a69241~aPxdg6Gwz1290312903epoutp047
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191125000629epoutp042fc01bf974b4b9634b768c05d2a69241~aPxdg6Gwz1290312903epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640389;
        bh=LB45WzBOQI0KmJUhhSFF2FmDFRt66YAbZuIxnR+Pkxg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ORgRROeb50CxL2xLredYk/oPgYUEdFSQ7PY1TqdBP+JGZzL1PiM7v0mNmZv9utWLU
         QCgUf2lOmHKN1vhgdYFwki6mtUOUaljqtgktzN3WN4h0n53Dcfx2ipnXLANdsu6DMR
         UmHiQohawTZW2FDoXnq6xYLgrcT1+tlv+fedhByU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191125000628epcas1p3c2f193b9e78380d777a27a8899352661~aPxdAM__B3108631086epcas1p37;
        Mon, 25 Nov 2019 00:06:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47LnPv6QTFzMqYkv; Mon, 25 Nov
        2019 00:06:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.32.48019.30B1BDD5; Mon, 25 Nov 2019 09:06:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191125000627epcas1p376a5a32c90e491f8cac92d053fb5e453~aPxb2y35Y0344003440epcas1p3o;
        Mon, 25 Nov 2019 00:06:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191125000627epsmtrp2a86715a5ca073b192f0740cb1756eadf~aPxb1-u0_2415424154epsmtrp2h;
        Mon, 25 Nov 2019 00:06:27 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-8c-5ddb1b036d04
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.60.10238.30B1BDD5; Mon, 25 Nov 2019 09:06:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000627epsmtip2e63a7a60173d2f4e4bba8e12ce19a1f3~aPxbqXmvE2594225942epsmtip2F;
        Mon, 25 Nov 2019 00:06:27 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 00/13] add the latest exfat driver
Date:   Sun, 24 Nov 2019 19:03:13 -0500
Message-Id: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60ynA1gyFJQnBKkT+UAFWktxUIoakYzKB3H5UNPUkU4KsVs6
        hQhGrWCAEDViP1QU1JiYCJhWqIisFUQ07hiUJRiX4IKENSoqFVsG1L/z7jnnnfvuuzgiycfC
        8CyjlbUYGT2J+aN17dGyGCS8Xy2zX46n2t+fFlEFVxwYda2qQ0C9GuhDqKbmByj1ouECRs2U
        fRRSU2eOUDPDx1DK9fuukOoaHUPXB9C3ywZEdGt5tYhu7LVh9ElXJaAdrm6Urn14kJ6sWUK3
        3RrG6P4PdWi63259UibLaFmLlDVmmLRZRp2K3Lpds1GjTJDJY+SJ1GpSamQMrIpMSUuPSc3S
        e5slpTmMPttbSmc4joxLTrKYsq2sNNPEWVUka9bqzXKZOZZjDFy2URebYTKskctkq5Re5V59
        ZvdQjcg8GnGg2PMFtYHG0BLgh0MiHhYNtwAflhD1AF6YjCwB/l48AeDbiinAH74B2PjIBeYd
        1Y5BAU80A1hvt4n+Wl523/CqcBwjVsBp10KfIYRYB2vPu1GfBiFeAfih76zQRwQTSliRP4j6
        MEpEwTs/RmaxmEiCzx4UC/m0SFjldCM+MyTcGLzf8U3AEylwsunRHA6GQ50uEY/D4ORIM+Zr
        AhIH4XgrwpeLAfz0XcVjBex1OIU+CUJEQ0dDHF9eCm//Kp99JEIEwpGvx4X8LWJYXCjhJVHw
        ZFf7XGg4LCkamwulocN+TcRPUQ2f2i4ip0BE2b+ASwBUgkWsmTPoWE5ujv//j2rA7P4tp+pB
        05O0NkDggFwgdl7vU0uETA6Xa2gDEEfIEHHq4x61RKxlcvNYi0ljydazXBtQemdXioQtzDB5
        t9lo1ciVqxQKBRWfsDpBqSBDxfjUc7WE0DFWdj/LmlnLvE+A+4XZQOQ65FOp0dPz075nMPr4
        tN/Ko/njyfS08035YWnL1q6gd2Ld07htHqGgUj/k1ow4r6YEFKwtDBw4sW1i8ee8XbWvQ5d1
        nfP3vOtBinLc9lOHTmvrdgRETNX0pe4TdUoqzBvUQeOS2HuBnjTMvy5ZNUZpRzdvwWJ2Ribu
        KpVtujlAolwmI1+OWDjmDwXYhEmVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC6z9O1Yg0m7ZC0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxtVXm9gL3stWdPx9zdLAuFu8i5GTQ0LARGLN+qdMILaQwG5GieUHnCDi0hLHTpxh7mLk
        ALKFJQ4fLu5i5AIq+cAosfLBS7A4m4C2xJ8toiDlIgKOEr27DrOA1DALPGaUOHH+CSNIQljA
        VGJe01MWEJtFQFXi4M93YDavgI3EhZMdrBC75CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOBw1NLcwXh5SfwhRgEORiUe3g1rb8UKsSaWFVfmHmKU4GBWEuF1
        O3sjVog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQZGfbM3
        mTEpywJOnpQ3NJh0pW/1pBdBm/9mL9jUaXnN07knfucSvTli0je2m2eLXYqq3T3PZ9kd/jce
        nEx859055LN0vMV5kxfP2xbftFTrxbnpO/R9g2QslxfdPHfe8zyPce3G8PbwzLsXftZ7hgsV
        3FhXts41+22vUPpksdLpLYINHR3+tn5KLMUZiYZazEXFiQD3N5KTQwIAAA==
X-CMS-MailID: 20191125000627epcas1p376a5a32c90e491f8cac92d053fb5e453
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000627epcas1p376a5a32c90e491f8cac92d053fb5e453
References: <CGME20191125000627epcas1p376a5a32c90e491f8cac92d053fb5e453@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the latest Samsung exfat driver to fs/exfat. This is an
implementation of the Microsoft exFAT specification. Previous versions
of this shipped with millions of Android phones, and a random previous
snaphot has been merged in drivers/staging/.

Compared to the sdfat driver shipped on the phones the following changes
have been made:

 - the support for vfat has been removed as that is already supported
   by fs/fat
 - driver has been renamed to exfat
 - the code has been refactored and clean up to fully integrate into
   the upstream Linux version and follow the Linux coding style
 - metadata operations like create, lookup and readdir have been further
   optimized
 - various major and minor bugs have been fixed

We plan to treat this version as the future upstream for the code base
once merged, and all new features and bug fixes will go upstream first.

v5:
 - Remove a blank line between the message and the error code in
   exfat_load_upcase_table.
 - Move brelse to the end of the while loop and rename label with
   free_table in exfat_load_upcase_table.
 - Move an error code assignment after a failed function call.
 - Rename labels and directly return instead of goto.
 - Improve the exception handling in exfat_get_dentry_set().
 - Remove ->d_time leftover.
 - fix boolreturn.cocci warnings.

v4:
 - Declare ALLOC_FAT_CHAIN and ALLOC_NO_FAT_CHAIN macros.
 - Rename labels with proper name.
 - Remove blank lines.
 - Remove pointer check for bh.
 - Move ep into loop in exfat_load_bitmap().
 - Replace READ/WRITE_ONCE() with test_and_clear_bit() and set_bit().
 - Change exfat_allow_set_time return type with bool.

v3:
 - fix wrong sbi->s_dirt set.

v2:
 - Check the bitmap count up to the total clusters.
 - Rename goto labels in several places.
 - Change time mode type with enumeration.
 - Directly return error instead of goto at first error check.
 - Combine seq_printf calls into a single one.

Namjae Jeon (13):
  exfat: add in-memory and on-disk structures and headers
  exfat: add super block operations
  exfat: add inode operations
  exfat: add directory operations
  exfat: add file operations
  exfat: add exfat entry operations
  exfat: add bitmap operations
  exfat: add exfat cache
  exfat: add misc operations
  exfat: add nls operations
  exfat: add Kconfig and Makefile
  exfat: add exfat in fs/Kconfig and fs/Makefile
  MAINTAINERS: add exfat filesystem

 MAINTAINERS          |    7 +
 fs/Kconfig           |    3 +-
 fs/Makefile          |    1 +
 fs/exfat/Kconfig     |   21 +
 fs/exfat/Makefile    |    8 +
 fs/exfat/balloc.c    |  272 ++++++++
 fs/exfat/cache.c     |  325 ++++++++++
 fs/exfat/dir.c       | 1307 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  538 ++++++++++++++++
 fs/exfat/exfat_raw.h |  191 ++++++
 fs/exfat/fatent.c    |  472 ++++++++++++++
 fs/exfat/file.c      |  343 ++++++++++
 fs/exfat/inode.c     |  693 ++++++++++++++++++++
 fs/exfat/misc.c      |  240 +++++++
 fs/exfat/namei.c     | 1459 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  808 +++++++++++++++++++++++
 fs/exfat/super.c     |  738 +++++++++++++++++++++
 17 files changed, 7425 insertions(+), 1 deletion(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile
 create mode 100644 fs/exfat/balloc.c
 create mode 100644 fs/exfat/cache.c
 create mode 100644 fs/exfat/dir.c
 create mode 100644 fs/exfat/exfat_fs.h
 create mode 100644 fs/exfat/exfat_raw.h
 create mode 100644 fs/exfat/fatent.c
 create mode 100644 fs/exfat/file.c
 create mode 100644 fs/exfat/inode.c
 create mode 100644 fs/exfat/misc.c
 create mode 100644 fs/exfat/namei.c
 create mode 100644 fs/exfat/nls.c
 create mode 100644 fs/exfat/super.c

-- 
2.17.1

