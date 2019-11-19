Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648D6101A1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKSHOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:07 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41543 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfKSHOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:07 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191119071404epoutp01a555e13af654df57f820cf4e28d9eb62~YfvEy2eA01797917979epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191119071404epoutp01a555e13af654df57f820cf4e28d9eb62~YfvEy2eA01797917979epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147644;
        bh=5UpF4qpTY1c5nosCfSUtboLLKhCAkWzqI8IScXDC0VE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Isn2d9mirBN5mUTf85MJsg5Qmc2RWVrvyvPIB45KL5AmdlQ2a4rLjNbQTchacwxjo
         866nyNb9mS2VHYo67iRWgVpWqupTJVlgXdtx4/i0tJCWL2np8Ak7F3isEM2RjmnSuK
         2IOUwuzf/ufObPlATI/YftiVD026slcIr5lU9Z4g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191119071403epcas1p3eb394208dbd10f6fd1e46ef30d4203ed~YfvEJGju12635426354epcas1p3m;
        Tue, 19 Nov 2019 07:14:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47HHB22k7wzMqYkb; Tue, 19 Nov
        2019 07:14:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.E8.04237.A3693DD5; Tue, 19 Nov 2019 16:14:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191119071401epcas1p4a42c781276e89928a24d53379fe13d64~YfvCNeTVf0776007760epcas1p4S;
        Tue, 19 Nov 2019 07:14:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119071401epsmtrp2057ff7965928a1dd34c67d68f3074d91~YfvCMqp2c0193901939epsmtrp2I;
        Tue, 19 Nov 2019 07:14:01 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-fe-5dd3963a6d0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.84.03814.93693DD5; Tue, 19 Nov 2019 16:14:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071401epsmtip19fc8edd8a49b27f3c530e89557de7da6~YfvCEwC0d1281112811epsmtip1X;
        Tue, 19 Nov 2019 07:14:01 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 00/13] add the latest exfat driver
Date:   Tue, 19 Nov 2019 02:10:54 -0500
Message-Id: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRT38z52F00uU/PLKNcNETV1c02vmiVkdUEJyegPYcybu2zSXuxu
        kYYkRKukTDG0NEE0oTlBmcPSkmqWNcOytJdhUkGJlPbAnqLtdg3773d+j/MdzncIRD6HRROl
        Fgdnt7AmCl+F9g7GK5My68e0yieBSPpYWxdOuz13QulnkxMIfX0ggNJj/RdxeqnxPUb/aDhK
        +xZvY/TjuU9ojpTpa5yUMDeaOyXMtReVOFPt6wDMV+8Gxn/lA868fNeLFkiKTFuNHKvn7ArO
        UmLVl1oM2VReoW6HTpOmVCWpMuh0SmFhzVw2lZtfkLSr1BScjFIcYk3OIFXA8jyVsm2r3ep0
        cAqjlXdkU5xNb7KplLZknjXzToshucRqzlQplamaoLPYZKyrvQBsvVGH586cQytBu7wKSAlI
        boFTo2eRKrCKkJNXATw90iARiy8Afpg9D8TiG4CeKbfkX6Tp4QImCgMAujuHVyJDzyuDzQgC
        JxPhgi9SCESQ22FP001U8CBkD4Cvve2oIISTGhiYf4YIGCVjofvncVzAMjIL/vwVWH4tBnq6
        b/4dEJKXcegab0NFIRe+O3MfE3E4nLnrWw5Ew6+zA7gwBCSPwM83EJE+CeD092wRq+GLrm5M
        sCBkPOzqTxHpjbDvdzMQMEKGwdn505jYRQZPupbXFQurHw+GingdrDrxSSJaGOiuKRFoOamF
        gfompAasb1zp3wJAB1jD2XizgeNVNs3/f+QFf48tIeMqGHqQ7wckAajVMkXcmFaOsYf4MrMf
        QAKhImR73oxq5TI9W1bO2a06u9PE8X6gCa6uFomOLLEGT9fi0Kk0qWq1mt6Slp6mUVNRMuLH
        I62cNLAO7iDH2Tj7v1woIY2uBETyRKr+t3R+0V9YtrsubLO6hVlyu6qmN01mDrfE3JMu1g9l
        vSHiJlRnO9Hq/t68mbTP13yvip7Wo+mtNVN94W9D+LXHxqeogsSDNoUOCbnUUOZcU5qzP9PQ
        MOLee6ri44zHiLuSPraWD3dUmDDjk1uh+zjvgaXidq9rp/11OYXyRlaVgNh59g9L8UwTggMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnK7ltMuxBnf2i1o0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK2PyxJmMBdvEK973TmFpYFwq
        1MXIySEhYCIx+/wf1i5GLg4hgd2MEkuXrGKCSEhLHDtxhrmLkQPIFpY4fLgYJCwk8IFRYuKh
        UpAwm4C2xJ8toiBhEQFHid5dh1lAxjCDjNky/RcjSEJYwFTi5NfrzCA2i4CqxMqfrWwgNq+A
        tcTPXyfZIVbJS6zecIB5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwYGm
        pbWD8cSJ+EOMAhyMSjy8J1QuxwqxJpYVV+YeYpTgYFYS4fV7dCFWiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA2Mec9Q9yzM9vl9F5sdkckRMaE6Rflrt
        Yzsz4YzZUi2jSjaOj887/jxaUu1t9HOWV967b6sWcvzfGfRdK+b4auUViw9uj/Nm8maftunP
        JT/BNq+M589mVhSrR13dpNXsLxT+enttXy9TmcSmr3wbRbb97V29zHLh/A25h4OeiK7itZjD
        adi6ZIoSS3FGoqEWc1FxIgCB7dFdMAIAAA==
X-CMS-MailID: 20191119071401epcas1p4a42c781276e89928a24d53379fe13d64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071401epcas1p4a42c781276e89928a24d53379fe13d64
References: <CGME20191119071401epcas1p4a42c781276e89928a24d53379fe13d64@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the latest Samsung exfat driver to fs/exfat. This is an
implementation of the Microsoft exFAT specification. Previous versions
of this shipped with millions of Android phones, an a random previous
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

v2:
 - Check the bitmap count up to the total clusters.
 - Rename proper goto labels in seveal place.
 - Change time mode type with enumeration.
 - Directly return error instead of goto at first error check.
 - Combine seq_printfs calls into a single one.

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
 fs/exfat/balloc.c    |  271 ++++++++
 fs/exfat/cache.c     |  325 +++++++++
 fs/exfat/dir.c       | 1338 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  534 +++++++++++++++
 fs/exfat/exfat_raw.h |  190 ++++++
 fs/exfat/fatent.c    |  475 ++++++++++++++
 fs/exfat/file.c      |  346 ++++++++++
 fs/exfat/inode.c     |  691 +++++++++++++++++++
 fs/exfat/misc.c      |  247 +++++++
 fs/exfat/namei.c     | 1492 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  817 +++++++++++++++++++++++
 fs/exfat/super.c     |  752 +++++++++++++++++++++
 17 files changed, 7517 insertions(+), 1 deletion(-)
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

