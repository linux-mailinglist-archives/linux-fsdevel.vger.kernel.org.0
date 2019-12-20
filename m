Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699411275AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTG1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:27:37 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20069 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLTG1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:36 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191220062733epoutp0428206d197ce2fe2e7b993cb993dc6f05~iAGT6rKQr1295312953epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191220062733epoutp0428206d197ce2fe2e7b993cb993dc6f05~iAGT6rKQr1295312953epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823253;
        bh=C1VgkaKpOShOJd4R4rUGDSkZ5bAsf7fJDpVop6OH5eE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=n+xbAuli+Rg2m6EVdRYfHdQnW1bfC3h5/XEcJmA6bR0a9aF2e8NoafzuPu1DehxpO
         xWFU8T64RMctjcZ6ONR7+o/Aekn2kN3agiGL6/3ef9VThP72nYkRyJ2e0aSLrgOvmP
         SYse0tZhLEtsloBi+6OwbFRliaT7Ny+8Q40656Yk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191220062732epcas1p2fb88e902f8a6b0831907b391d992c6a0~iAGTgmeoA0045200452epcas1p22;
        Fri, 20 Dec 2019 06:27:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47fJh35HZmzMqYkr; Fri, 20 Dec
        2019 06:27:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.DB.48498.3D96CFD5; Fri, 20 Dec 2019 15:27:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219~iAGSDXdpB0237302373epcas1p4-;
        Fri, 20 Dec 2019 06:27:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062731epsmtrp1aef25965feb697072cc9eaf914b56e44~iAGSCmWpv2110821108epsmtrp1J;
        Fri, 20 Dec 2019 06:27:31 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-a6-5dfc69d3d3b3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.0A.10238.3D96CFD5; Fri, 20 Dec 2019 15:27:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062731epsmtip1a5221322ed0a758f5f32e49900c1f80d~iAGR4qDfB2891528915epsmtip1U;
        Fri, 20 Dec 2019 06:27:31 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 00/13] add the latest exfat driver
Date:   Fri, 20 Dec 2019 01:24:06 -0500
Message-Id: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmnu7lzD+xBr/bdCyaF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS9
        5PxcK0MDAyNToMqEnIy7e16yFZxQr5j94zBrA+NB+S5GTg4JAROJzm+3mLsYuTiEBHYwSkzt
        aoJyPjFKHL63jhXC+cYo8eXxOhaYlnufJ7KD2EICexkl1pyVh+s4v2k3UxcjBwebgLbEny2i
        IDUiAvYSm2cfYAGpYRaYwyixo3cWI0hCWMBUYt+6b2A2i4CqxMllO8AW8ArYSEz70McOsUxe
        YvWGA2AnSQjMYJNYdqOBCSLhIvFx6lkoW1ji1fEtUA1SEi/729hBjpAQqJb4uJ8ZItzBKPHi
        uy2EbSxxc/0GVpASZgFNifW79CHCihI7f88FO4dZgE/i3dceVogpvBIdbUIQJaoSfZcOQy2V
        luhq/wC1yEPi230nSIjESvzc0cw8gVF2FsL8BYyMqxjFUguKc9NTiw0LjJCjaBMjOIVpme1g
        XHTO5xCjAAejEg+vQ9rvWCHWxLLiytxDjBIczEoivLc7fsYK8aYkVlalFuXHF5XmpBYfYjQF
        Bt1EZinR5Hxges0riTc0NTI2NrYwMTM3MzVWEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoFR
        QNggvCss9XXYEdOfpkHTa4VnOk0WzTJ6tUvp+OL9S1jMA8XkDjkuP3Fn7rSjdb9s3+TPCLu8
        36tU53I0f+UVzSPbA4JZO1ua5rLcnrzm6x4Onjd/Ph67sudpwD/RXS6uZaXWJy1mOppN6JZa
        x1KnUPNF7g7ftUNXmz6rBHOtVNmzzVvBNKtLiaU4I9FQi7moOBEA3xO+1XcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnO7lzD+xBo+bOS2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbFJdNSmpOZllqkb5dAlfG3T0v2QpOqFfM/nGYtYHxoHwXIyeHhICJxL3P
        E9m7GLk4hAR2M0pMu/KWGSIhLXHsxBkgmwPIFpY4fLgYJCwk8IFR4tR3bZAwm4C2xJ8toiBh
        EQFHid5dh1lAxjALLGKUePdxMitIQljAVGLfum+MIDaLgKrEyWU7WEBsXgEbiWkf+tghVslL
        rN5wgHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBQaWluYPx8pL4Q4wC
        HIxKPLwOab9jhVgTy4orcw8xSnAwK4nw3u74GSvEm5JYWZValB9fVJqTWnyIUZqDRUmc92ne
        sUghgfTEktTs1NSC1CKYLBMHp1QDo1xsLuPHR65ei4p+rWJXf7w19oDctHnTXe/aGnxZP5vP
        StXRn2N9+UpLwdUr/tcwcb/VfdoQEJ8jciX+uoevubH2Ek+RI2KGzFX5OaaajHxv9pW738gT
        fuL9cJ310S3mUzvWv9E9KaSuE8/GYlhjbVXl/n7bebNbPFdc1Za1CMhMPi40P+m5EktxRqKh
        FnNRcSIAHib8iCYCAAA=
X-CMS-MailID: 20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219
References: <CGME20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219@epcas1p4.samsung.com>
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

v8:
 - Rearrange the function grouping in exfat_fs.h
   (exfat_count_dir_entries, exfat_get_dentry, exfat_get_dentry_set,
    exfat_find_location).
 - Mark exfat_extract_uni_name(), exfat_get_uniname_from_ext_entry() and
   exfat_mirror_bh() as static.

v7:
 - Add the helpers macros for bitmap and fat entry to improve readability.
 - Rename exfat_test_bitmap to exfat_find_free_bitmap.
 - Merge exfat_get_num_entries into exfat_calc_num_entries.
 - Add EXFAT_DATA_CLUSTERS and EXFAT_RESERVED_CLUSTERS macro.
 - Add the macros for EXFAT BIOS block(JUMP_BOOT_LEN, OEM_NAME_LEN,
   MUST_BE_ZERO_LEN).
 - Add the macros for EXFAT entry type (IS_EXFAT_CRITICAL_PRI,
   IS_EXFAT_BENIGN_PRI, IS_EXFAT_CRITICAL_SEC).
 - Add EXFAT_FILE_NAME_LEN macro.
 - Change the data type of is_dir with bool in __exfat_write_inode().
 - Change the data type of sync with bool in exfat_set_vol_flags().
 - Merge __exfat_set_vol_flags into exfat_set_vol_flags.
 - Fix wrong statfs->f_namelen.

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
 fs/exfat/balloc.c    |  282 ++++++++
 fs/exfat/cache.c     |  325 ++++++++++
 fs/exfat/dir.c       | 1295 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  559 ++++++++++++++++
 fs/exfat/exfat_raw.h |  202 ++++++
 fs/exfat/fatent.c    |  472 ++++++++++++++
 fs/exfat/file.c      |  343 ++++++++++
 fs/exfat/inode.c     |  694 ++++++++++++++++++++
 fs/exfat/misc.c      |  240 +++++++
 fs/exfat/namei.c     | 1459 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  809 +++++++++++++++++++++++
 fs/exfat/super.c     |  732 +++++++++++++++++++++
 17 files changed, 7451 insertions(+), 1 deletion(-)
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

