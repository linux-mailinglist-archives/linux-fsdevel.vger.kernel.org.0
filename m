Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42D1020E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKSJkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28134 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKSJkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:24 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191119094021epoutp03ea071209bf8933d2d13157a6bd5f9159~YhuzC8uOR1746517465epoutp03k
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191119094021epoutp03ea071209bf8933d2d13157a6bd5f9159~YhuzC8uOR1746517465epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156421;
        bh=0cnGpOYdbueaEG9G7RvSonxcZR4iIM1JXB3qpiDbXKw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KsGQYLH3s+OEqNF1kRJxMyEh5Zwfd6mJ3BPYF5duU013zWCQNbyoV+VvA917LC9is
         QKqTwxEntN6Cv2kyj0zO8zvkp5T41G1yBSxHUpIcsDSv9SHi7ffa3McFyrVCd2g8Xl
         WadudvTHXVRg6akeGlV+ifJuxtTF/c/b7EVnURoc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119094020epcas1p2af0faa4f3d40e6cc4e09f497723ea198~Yhuyxqe2i1035810358epcas1p2B;
        Tue, 19 Nov 2019 09:40:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47HLQq6KbhzMqYkj; Tue, 19 Nov
        2019 09:40:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.23.04072.388B3DD5; Tue, 19 Nov 2019 18:40:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b~YhuxRBzuU0594305943epcas1p2o;
        Tue, 19 Nov 2019 09:40:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094019epsmtrp171a3abb8cff6b649f86aa3032aef726f~YhuxQRvi40080100801epsmtrp1j;
        Tue, 19 Nov 2019 09:40:19 +0000 (GMT)
X-AuditID: b6c32a35-9bdff70000000fe8-3e-5dd3b8835584
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.12.03654.388B3DD5; Tue, 19 Nov 2019 18:40:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094019epsmtip2dc65f256c4d727080a692a07c1eba043~YhuxCsjnY0597405974epsmtip2a;
        Tue, 19 Nov 2019 09:40:19 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 00/13] add the latest exfat driver
Date:   Tue, 19 Nov 2019 04:37:05 -0500
Message-Id: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SZ0wTYRjm4zoOYsmlrE+MWC42BmT0KMUTwQEEL4hAYjSKafBCLy3alV5x
        8YMioRBCGGqiogxXDMOwKjKFFI1RjApEDSp/ILJcuFEM2vZw/Hve933Gm/f7UES8wA9As/Vm
        xqSntbjAk9cxGBwRVtA5qpR9L1SQg5MnhWTB5WYBWd94x518Nv4cIXv77vHI0e4LAvJX1TSf
        XDiTR9qWbvPJkffzvK2eVFfVuJDqr24SUj1jFgFVZmsAVPtQLvWpLZCy33wjoF5MdfDS0Qxt
        rIahVYxJwuizDKpsvToO37ErMyFTES0jwoiN5AZcoqd1TByemJIelpStdayISw7T2hxHK51m
        WTxic6zJkGNmJBoDa47DGaNKayRkxnCW1rE5enV4lkEXQ8hkkQoH84BWM/S0FBhf+h/9Xjgu
        tIABcQnwQCEWBSfqK4QlwBMVY50ATlyqAFzxEcC2c1eWi68AWqZPCf5IJhvOItygD8CpZjvy
        VzJVms8vASgqwNbDnzZfp8AH2wLbzw/wnBwEuw3gzGdnIIp6Ywp4a4RwcniYFLacWEScWIRt
        gtbhAh4XtgY2tgy4/CHWIoDneqYBN0iEreUjCIe94dxdm5DDAXC23Oryh1gu/NC/TCl25H6L
        47AcjjW3uNZEsGDY3B3BtYNg12K1yx3BvOC7L6V8zkUEi63L15LCspFBdw6vgiVF88uhFKy+
        eN/VF2NKWPutXVgBVlf9C6gDoAH4MUZWp2ZYwkj8/0ZtwPXrQhSd4PTDFDvAUICvEEnWjSrF
        fPowe0xnBxBFcB9R6sRjpVikoo8dZ0yGTFOOlmHtQOG4XSUS4JtlcPxhvTmTUETK5XIyKnpD
        tEKO+4vQhWGlGFPTZuYQwxgZ0x+dO+oRYAHXkz2ast1mNS/9gyLeSwt6Z/oHbdvWSnY+mWRi
        VfXWyvzwsuDATuOD7QeO1ASGf4i1AJDWfe2Vd2r/ypooaWhMVVPTQJrodcpVzeu9s3R3bVKx
        1BoZmle370b924wxv195IW4x8RPIo+GDXruX5n7sV7cG7ynMWFGUkPw0Pn6pMh/nsRqaCEFM
        LP0bVwqQuIsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvG7zjsuxBqdOcFocfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGWcvtbDWHBH
        vOJn6132BsYDQl2MnBwSAiYSj1fNYO5i5OIQEtjNKDGrYx4jREJa4tiJM0AJDiBbWOLw4WKI
        mg+MElNbfjKBxNkEtCX+bBEFKRcRcJTo3XWYBaSGWeAco8TOZ8sYQWqEBUwl9l0yBKlhEVCV
        2ND0mxnE5hWwlmi72MwCsUpeYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQIDj0tzR2Ml5fEH2IU4GBU4uE9oXI5Vog1say4MvcQowQHs5IIr9+jC7FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MLZNWVTWNy1LX9hgx88N
        nPy/XqpMUPPzjt2pc3hLvbiZu/bi6X1nYowz8hdzPI9InzBvs7Lt39o14kJyjvv5LZlzivkr
        D5evjzAyPnku5IqRH/vR6Hl9c21jDPRXyHyzW7bg0jaxQ+syPxlvvOlWGRalenrnrgN2x4Iu
        vjCSLo4/XMHgyPzspxJLcUaioRZzUXEiAI8c7mI5AgAA
X-CMS-MailID: 20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b
References: <CGME20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b@epcas1p2.samsung.com>
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

v3:
 - fix wrong sbi->s_dirt set.

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

