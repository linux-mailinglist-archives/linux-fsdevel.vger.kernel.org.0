Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21484116719
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLIGzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:03 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:19575 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfLIGzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:02 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191209065459epoutp043b5d869f399a29b218390c20f965b76b~eoYHyT_Py2007020070epoutp04U
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191209065459epoutp043b5d869f399a29b218390c20f965b76b~eoYHyT_Py2007020070epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874499;
        bh=A0WbscGLp/FBqHZYKkFQAzolQTINH8FBFgyBhh91qlo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=O3rxMzPtTuuFWhNmIbBPdSpwnqBLdDPCoMgC+BikRKm2hFNwx/ZdJ+yM9Rw3DTzEC
         UZ/gTwsT+U8Ft3J/yT9iNocvnVtTmovA/zoBb6qUyZNWL3aKjqB/bchxH3m8cmUlqC
         S/xHhLeRW+NbzFRtDqUVZaEKv+Diq/r25HbxSFNY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191209065458epcas1p4576f756fac74480897c2897f1ca95fbe~eoYHTlt2D1133711337epcas1p4P;
        Mon,  9 Dec 2019 06:54:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47WYpn46S6zMqYkk; Mon,  9 Dec
        2019 06:54:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.87.48019.1CFEDED5; Mon,  9 Dec 2019 15:54:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191209065457epcas1p3130d80fd65c9a1c1af5f67dadc49e913~eoYGCzw6D0815208152epcas1p3x;
        Mon,  9 Dec 2019 06:54:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209065457epsmtrp27680ec5738aabd55502fffbc7eb92b47~eoYGB523D2761927619epsmtrp2L;
        Mon,  9 Dec 2019 06:54:57 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-82-5dedefc1b5bf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.E9.06569.1CFEDED5; Mon,  9 Dec 2019 15:54:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065457epsmtip1c49566f731f8c7eddc23004dd559f6bb~eoYF3slhX1943719437epsmtip1Q;
        Mon,  9 Dec 2019 06:54:57 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 00/13] add the latest exfat driver
Date:   Mon,  9 Dec 2019 01:51:35 -0500
Message-Id: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmru7B929jDU7tVrBoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJWLw1t+CpfMWJ3//ZGhj/SnQxcnJICJhIfLq/iLGLkYtDSGAHo8TFL/eYIZxPjBInzxxn
        hXC+MUrMWXGXDablw5VbLBCJvYwSO/7uY4Vr+bdnL1AVBwebgLbEny2iIA0iAvYSm2cfAGtg
        FmhhlFhw+gczSEJYwFRiy6q57CA2i4CqxIOz+9lBenkFrCWOtcZCLJOXWL3hANhJEgIdbBJd
        3x9AXeEisXLlMUYIW1ji1fEt7BC2lMTndxA3SAhUS3zczwwR7mCUePHdFsI2lri5fgMrSAmz
        gKbE+l36EGFFiZ2/54JNZBbgk3j3tYcVYgqvREebEESJqkTfpcNMELa0RFf7B6ilHhJHL14A
        axUSiJX4Nq2VfQKj7CyEBQsYGVcxiqUWFOempxYbFpggR9EmRnC60rLYwbjnnM8hRgEORiUe
        XgWrt7FCrIllxZW5hxglOJiVRHiXTHwVK8SbklhZlVqUH19UmpNafIjRFBh0E5mlRJPzgak0
        ryTe0NTI2NjYwsTM3MzUWEmcl+PHxVghgfTEktTs1NSC1CKYPiYOTqkGxuBWGe7jL8x3yWtO
        YvFjWDr39sHERyvyJku+KZxxsTy9ZckU/cZ8PotaV3kfabmEr1fDy7dG5a+0Y9C6eFPb847t
        fPZvlZtvtEQ96TjK4JlxdGXQde7LSoo1U/cetjnPsqpNyffQr3mBGauVwz2Cd6+K51UreuT9
        5sas38l37m0xDOj7GOk3R4mlOCPRUIu5qDgRAEiSR7htAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJTvfg+7exBpNuc1g0L17PZrFy9VEm
        iz17T7JYXN41h83ix/R6iy3/jrBaXHr/gcWB3WP/3DXsHrtvNrB59G1ZxejxeZOcx6Htb9gC
        WKO4bFJSczLLUov07RK4MhZvzS14Kl9x4vd/tgbGvxJdjJwcEgImEh+u3GLpYuTiEBLYzSix
        ccE5FoiEtMSxE2eYuxg5gGxhicOHiyFqPjBK7Gi7wgQSZxPQlvizRRSkXETAUaJ312GwOcwC
        XYwSj5q+MYMkhAVMJbasmssOYrMIqEo8OLufHaSXV8Ba4lhrLMQqeYnVGw4wT2DkWcDIsIpR
        MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzh8tLR2MJ44EX+IUYCDUYmHV8HqbawQa2JZ
        cWXuIUYJDmYlEd4lE1/FCvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBa
        BJNl4uCUamCMfLNW/Xa6nLjTz/NJkRPL/rmfUNml/yXH0Ivj7aZ40b8rcvjDo8qFw/buvPv2
        /pEpEhMmXZvw6+xy1djJsQEKl88o9C9t1Lr6+7iRtFzdhk03L6WeNF8s/vzM3P7bGl6GK95a
        f1ryLOPf8jtL+aTeHct49jnr5YMDM7jaNyqvmX/XPjvqpYD9ISWW4oxEQy3mouJEAEOHs1Ab
        AgAA
X-CMS-MailID: 20191209065457epcas1p3130d80fd65c9a1c1af5f67dadc49e913
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065457epcas1p3130d80fd65c9a1c1af5f67dadc49e913
References: <CGME20191209065457epcas1p3130d80fd65c9a1c1af5f67dadc49e913@epcas1p3.samsung.com>
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

v6:
 - Fix always false comparison due to limited range of allow_utime's data
   type.
 - Move bh into loop in exfat_find_dir_entry().
 - Move entry_uniname and unichar variables into
   an if "entry_type == TYPE_EXTEND" branch.

v5:
 - Remove a blank line between the message and the error code in
   exfat_load_upcase_table.
 - Move brelse to the end of the while loop and rename release_bh label
   to free_table in exfat_load_upcase_table.
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
 fs/exfat/dir.c       | 1310 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  538 ++++++++++++++++
 fs/exfat/exfat_raw.h |  191 ++++++
 fs/exfat/fatent.c    |  472 ++++++++++++++
 fs/exfat/file.c      |  343 ++++++++++
 fs/exfat/inode.c     |  693 ++++++++++++++++++++
 fs/exfat/misc.c      |  240 +++++++
 fs/exfat/namei.c     | 1459 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  808 +++++++++++++++++++++++
 fs/exfat/super.c     |  738 +++++++++++++++++++++
 17 files changed, 7428 insertions(+), 1 deletion(-)
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

