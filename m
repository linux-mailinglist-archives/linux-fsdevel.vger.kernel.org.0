Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0664104A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUF3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62285 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUF3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:20 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121052916epoutp019a5e0b87050faae03640f471db6abda6~ZFmJnFCvi1193211932epoutp013
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121052916epoutp019a5e0b87050faae03640f471db6abda6~ZFmJnFCvi1193211932epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314156;
        bh=925hO4pkuwo1MXCsRayEWAmelzcb7M/gdrw9o0cdhTs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ODKy1Rym36CtDXuJjKKM2XzN4dXOxPMlLYKjZYwpIBG5VRRqoJKk4jcHvfQeBd7QY
         2Ok4eaMnI+OitEdUTGZN+OThE4OWmU6qKrXAWpP38qO7Q67xDZgr6VmX+2VoQLdb0U
         XrhQYLn3OtusTd+O+J52GcFJN7TjiBkzk/domuHU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191121052916epcas1p129f2d86ae9ca5a949798ea3617de3054~ZFmJHNn1A0317303173epcas1p1A;
        Thu, 21 Nov 2019 05:29:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47JSmC02KFzMqYm4; Thu, 21 Nov
        2019 05:29:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.8C.04072.AA026DD5; Thu, 21 Nov 2019 14:29:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052913epcas1p1b28d2727dca5df42a6f2b8eb6b6dbcbb~ZFmHEWJvx0317303173epcas1p1x;
        Thu, 21 Nov 2019 05:29:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121052913epsmtrp2fcb7e8738f0062e68196398b8012e43e~ZFmHDj0rm1666416664epsmtrp2S;
        Thu, 21 Nov 2019 05:29:13 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000000fe8-95-5dd620aa4d64
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.06.03654.9A026DD5; Thu, 21 Nov 2019 14:29:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052913epsmtip18cc003c4f063d3b9a410f907296ecfd7~ZFmG0jrRV0971209712epsmtip1c;
        Thu, 21 Nov 2019 05:29:13 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 00/13] add the latest exfat driver
Date:   Thu, 21 Nov 2019 00:26:05 -0500
Message-Id: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7O1aTw9Hqa2WtE1YW2uacnfIWJHYqfxgRUbDs4A6bdHZh
        ZyvLKDMzm5csEsUypBulg8UaZhdJt1VEVGgXU+lGYTfpYlmCke14FvXv/d7ned7n4f1eHCH3
        YSq80OrkHFaWp7BJaFswQZPYon5i0HibSDr4+qiC3n/ai9EXWm/K6N5n/Qh9veMOSj+8egKj
        xxvfyunR+r30+FAZSvt/h+R0z+cv6IrJzJXGZwrmRpNHwVzrK8GYGn8LYLz+xyhz6W4x8803
        mwlcHsKYgcE2NC9qM59u5lgj51Bz1gKbsdBqyqDWrs9fma9P1WgTtcvopZTaylq4DCo7Ny8x
        p5APh6XU21neFW7lsYJALclMd9hcTk5ttgnODIqzG3m7VmNPEliL4LKakgpsluVajSZZH2Zu
        5c1toe8Ke4uqqO7zkKIEdMe6QRQOiRRY/aBO7gaTcJJoB/C3d1whAiQxDOD9ckQCfgA4Ggwo
        /ipuHvdEFB0Ant1XCqRHWFH98lFYguMYsRj+8k8VBbFEFrx0vBMVOQjRC+Bgf4NcBGIIPewZ
        OCQT+SgRD9+V8mJbSaTDc75fqGQ2B7Ze7JxIAYkQBis/vJJJQDZsPjeOSHUM/HDbH0mngt8+
        dWDiTEgUw683IpQKAN/9zJBqHezzXpSLFIRIgN6rS6T2XHhlrAmINUJEw08jVXJpihJWlJMS
        JR7W9AQjAWZC98EvEVMG1rV9lEl7M8B+rxvUgrjGfwbNALSAaZxdsJg4QWvX/v9FPjBxfov0
        7eDY/dwAIHBATVGaFz42kHJ2u7DTEgAQR6hY5fXeRwZSaWR37uIctnyHi+eEANCHV3cEUU0t
        sIWP2erM1+qTdTodnZK6NFWvo6Yr8dFuA0mYWCe3jePsnOOvToZHqUqAB60pkvvtG1/EzVfH
        DLgCw/Xvb4V0bzL3LNiRkOwZCW7h9OrzDb5VJ2dsmpczXF9atS467cDqNNn3qvZWlzKIneYz
        B921FT/HgiP7QZc5big99/BY86mm+ITUp6EtzXXPG00k1ae521XYnXUhsOHemaRiY9ms3cYU
        X9Ga2oWeSgoVzKx2EeIQ2D8DSftGlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO5KhWuxBl8f6VscfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujG1HvrAXrJKqmPr+DXsD40WRLkZODgkBE4mjs9ewdjFycQgJ7GaUuNRwngUiIS1x7MQZ
        5i5GDiBbWOLw4WKImg+MEte+fmUBibMJaEv82SIKUi4i4CjRu+swC0gNs8BjRokT558wgiSE
        BUwlLt3uZAKpZxFQlXjRlAMS5hWwkVi26Q/UKnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM4HLU0dzBeXhJ/iFGAg1GJhzdD42qsEGtiWXFl7iFGCQ5mJRHe
        PdevxArxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAOCVa
        Wv220KN9GhH3r76xf3L7vOiCT68idmVNjVqTtS/BKtxw3aWzi6+fV7rkIGwqUvMv525R0vSj
        jCvz7n3ZlL1vnW/Lba21f7/WsNT82CKz+q+h+ZLnS9wzqlR3M0VNKavYwC3h8LRu+/VceXsb
        BlsnpnOPlRde3y4c/ETwpHPDo6m2jBsvZyixFGckGmoxFxUnAgCpSak3QwIAAA==
X-CMS-MailID: 20191121052913epcas1p1b28d2727dca5df42a6f2b8eb6b6dbcbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052913epcas1p1b28d2727dca5df42a6f2b8eb6b6dbcbb
References: <CGME20191121052913epcas1p1b28d2727dca5df42a6f2b8eb6b6dbcbb@epcas1p1.samsung.com>
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
 - Rename proper goto labels in several places.
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
 fs/exfat/balloc.c    |  271 ++++++++
 fs/exfat/cache.c     |  325 +++++++++
 fs/exfat/dir.c       | 1335 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  538 +++++++++++++++
 fs/exfat/exfat_raw.h |  194 ++++++
 fs/exfat/fatent.c    |  474 ++++++++++++++
 fs/exfat/file.c      |  343 ++++++++++
 fs/exfat/inode.c     |  693 ++++++++++++++++++++
 fs/exfat/misc.c      |  247 +++++++
 fs/exfat/namei.c     | 1488 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  809 +++++++++++++++++++++++
 fs/exfat/super.c     |  737 +++++++++++++++++++++
 17 files changed, 7493 insertions(+), 1 deletion(-)
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

