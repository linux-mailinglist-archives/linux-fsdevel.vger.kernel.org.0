Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6541DFABE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKMIWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:22:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58047 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfKMIWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:21 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191113082218epoutp03e55895207cc514d89acdf6a983bfd0fc~Wqy77vL3i1608316083epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191113082218epoutp03e55895207cc514d89acdf6a983bfd0fc~Wqy77vL3i1608316083epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633338;
        bh=W84qaLINlxuKD/L6tIHrVxSqsVUuJduu0RyQdXrP4co=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pz5nVvTPgvZKjAq2Mr6TDGWBIlIsL2PWcMv9mAA1RmWoL3au7Vot7ufz3gyph6Ou9
         XDVVyeb5Q2vU0TFwO3ud+yqiyV9WGeigYsykRnw04tv3/M+g6q65R7FmbaNuq3ZIjH
         oy6kkwJlXc5QtK7oS13oYCFeHK2jnYXCz1jKWovw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113082217epcas1p39e18bd023e892806290b249cebe383ba~Wqy7aZVXC0735307353epcas1p3i;
        Wed, 13 Nov 2019 08:22:17 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47CczX2VC5zMqYkq; Wed, 13 Nov
        2019 08:22:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.7B.04085.83DBBCD5; Wed, 13 Nov 2019 17:22:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0~Wqy5-9Ka-0268802688epcas1p2G;
        Wed, 13 Nov 2019 08:22:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113082216epsmtrp2917024ce48da3490fcb55e6100b88a77~Wqy5-PRB82310523105epsmtrp2O;
        Wed, 13 Nov 2019 08:22:16 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-67-5dcbbd389233
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.84.24756.73DBBCD5; Wed, 13 Nov 2019 17:22:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082215epsmtip100469ce1154ef352cced953209c3c358~Wqy5xT-Lb2834328343epsmtip1w;
        Wed, 13 Nov 2019 08:22:15 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 00/13] add the latest exfat driver
Date:   Wed, 13 Nov 2019 03:17:47 -0500
Message-Id: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmga7F3tOxBi/nC1o0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORmPnx1nLlgoWrF7yly2BsYzAl2MnBwSAiYSp08uYO5i5OIQEtjBKNE8
        9RcbhPOJUaJn+V4o5xujxKZbL9lhWi4+mswIkdjLKPG1awEbSAKs5fHx6C5GDg42AW2JP1tE
        QcIiAvYSm2cfYAGpZxaYwyixo3cWI0hCWMBIYumh3cwgNouAqsTdW3NZQGxeAWuJ7v//WCCW
        yUus3nAA7D4JgRlsEtO2XGSGSLhIzFj8CcoWlnh1fAvUdVISn9+BnM0BZFdLfNwPVdLBKPHi
        uy2EbSxxc/0GVpASZgFNifW79CHCihI7f88FO41ZgE/i3dceVogpvBIdbUIQJaoSfZcOM0HY
        0hJd7R+glnpIXDuxlBESCrESv/bcZpvAKDsLYcECRsZVjGKpBcW56anFhgXGyHG0iRGcxLTM
        dzBuOOdziFGAg1GJh1di4alYIdbEsuLK3EOMEhzMSiK8OypOxArxpiRWVqUW5ccXleakFh9i
        NAWG3URmKdHkfGCCzSuJNzQ1MjY2tjAxMzczNVYS53VcvjRWSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gXHun8MTGMwUV+SZuEwwuS16ItNuxr0v4e8k7R/q61vreOeut/Cwl+ALuXustSvyrVNQtbtA
        1gVDq88a56v8jbXuxl4pYu6pcpmS3PFk8v73Cmsf79Hm4I3J/rBR9i/LhsjEOXExbziflPyY
        wPulsXJrZ8SGvt/lv4/3GYseMcq70yv/hm2CmhJLcUaioRZzUXEiAIAzdGJ4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnK753tOxBofemFg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6Mx8+OMxcsFK3YPWUuWwPjGYEuRk4OCQETiYuP
        JjN2MXJxCAnsZpRoO3GfBSIhLXHsxBnmLkYOIFtY4vDhYoiaD4wSB7bcYAeJswloS/zZIgpS
        LiLgKNG76zALSA2zwCJGiXcfJ7OCJIQFjCSWHtrNDGKzCKhK3L01F2w+r4C1RPf/f1C75CVW
        bzjAPIGRZwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCw0tLcwXh5SfwhRgEO
        RiUeXomFp2KFWBPLiitzDzFKcDArifDuqDgRK8SbklhZlVqUH19UmpNafIhRmoNFSZz3ad6x
        SCGB9MSS1OzU1ILUIpgsEwenVANjaMKbmfLVwl5Ga/Q9NivHzViwIVfVN0GHx/ZEd2jhktoL
        zh95HqzYW3HPaOpXlx0ytoLZXxs+TI6bEOK5tjPyCdc999Pfv8wwaVGZbvx7foN6dqf1pqSJ
        uRJF/FW/2c5P799/zFKn88KVzifqXKmHegPkHBNaDixpOl61OTJMLeXpJN66LSeUWIozEg21
        mIuKEwHhdk16JwIAAA==
X-CMS-MailID: 20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com>
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

Namjae Jeon (13):
  exfat: add in-memory structure and headers
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
 fs/exfat/balloc.c    |  267 ++++++++
 fs/exfat/cache.c     |  325 +++++++++
 fs/exfat/dir.c       | 1338 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  533 +++++++++++++++
 fs/exfat/exfat_raw.h |  190 ++++++
 fs/exfat/fatent.c    |  475 ++++++++++++++
 fs/exfat/file.c      |  346 ++++++++++
 fs/exfat/inode.c     |  691 +++++++++++++++++++
 fs/exfat/misc.c      |  247 +++++++
 fs/exfat/namei.c     | 1492 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  817 +++++++++++++++++++++++
 fs/exfat/super.c     |  752 +++++++++++++++++++++
 17 files changed, 7512 insertions(+), 1 deletion(-)
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

