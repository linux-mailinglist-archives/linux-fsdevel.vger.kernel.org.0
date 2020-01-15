Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F413BB14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAOI2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37514 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOI2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:24 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200115082821epoutp01d31827b0100164ed6ad542f68ca10fb4~qAhNQBRpj1574615746epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200115082821epoutp01d31827b0100164ed6ad542f68ca10fb4~qAhNQBRpj1574615746epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076901;
        bh=BXX6+4pvZh5wrB2K0cL8X76QOB9BlOVJkMnYxZmQJXc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Bi7yrjmHhRyXQkYdDLbF2OTzk43t+NazPbL0EcZoWy3itPNIsvW1BhcYrzDcewjOV
         HyS5H8Bx1eBz2d8YE5HqbMeRX1fFw2wnEJy3YX3Vrl2hDBzvYMh0i7x4NzjZS3XV/5
         zBPqlJ0Wv/vjCqkASdeoZ/Q30iqPz26Il7t3fv1c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200115082820epcas1p30b4c37cf97a82ee9f01a3560d5bfabd5~qAhMltQUn3105131051epcas1p3j;
        Wed, 15 Jan 2020 08:28:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47yL7R4QRCzMqYly; Wed, 15 Jan
        2020 08:28:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.AE.57028.22DCE1E5; Wed, 15 Jan 2020 17:28:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200115082818epcas1p4892a99345626188afd111ee263132458~qAhKeKEoY3123031230epcas1p4Z;
        Wed, 15 Jan 2020 08:28:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115082818epsmtrp116e8319670acf493ddf637170fba6fa2~qAhKdTJJN0484504845epsmtrp1C;
        Wed, 15 Jan 2020 08:28:18 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-45-5e1ecd22fe6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.4A.10238.22DCE1E5; Wed, 15 Jan 2020 17:28:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082818epsmtip1864356369192f49c3e5200ae46803604~qAhKS1RUA0089400894epsmtip1d;
        Wed, 15 Jan 2020 08:28:18 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 00/14] add the latest exfat driver
Date:   Wed, 15 Jan 2020 17:24:33 +0900
Message-Id: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRzu3e3jtCbH1HxRtHVQYbbcOTdP0QqSuChIKIKiXKe7Nmlf3G2S
        lWWFn0RlRIU1EIuiaUxq+bEKdWYqYVRCNfvQyCDFdGa1So22nVH/Pb/n9zzv73nf94cisq+i
        eLTIbGNYM23ExZHClu7kVAU+kJSvbC1XkvPnHknIk1ddYvJmY4+AfPl2CCHvP+gXkoOeK2Ly
        x8VjZO3jWQHp/v1QRD6f8gs3RFKzv84Bqr3urYTqcDRJqHu+MjF12u0E1MztJMrbOiHOk+w2
        ZhsYWsewcsZcaNEVmfU5+Jbt2o1atUZJKIhMMgOXm2kTk4Pnbs1TbCoyBuPh8mLaaA9SeTTH
        4anrslmL3cbIDRbOloMzVp3RSiitaznaxNnN+rWFFlMWoVSmqYPKfUbD4KwTWDvIg+2jDqQM
        XFxTA1AUYunQ6U+oAZGoDGsDcGTohJAvvgB4K5iaL74D2Dveg9SAiLBj4qdfwDceAHi93vXP
        cj3QgITOFWMpcM4dGzLEYOvhncudYQ2CdQE48dQhCTWiMQ3s+lwZxkJsBewfey8KYSmWDX0f
        BwX8tGWwsbkTCZkh1iSGtSOjQr6RC/ucp0Q8jobjvW4Jj+Ph2JkKCX+5w3C6YyF1FYCfAjk8
        VkGfq1kUkiBYMnR5Unl6OWyfdYAQRrAoOPntlIg/RQqrKmS8ZAU8/bx7IVkCrKn0LwyloPtF
        Q5iXYXuh59Kw8CxIrPs3oB4AJ1jKWDmTnuEIK/H/H90G4Y1brW4D559s9QIMBfgSqfxNYr5M
        RBdzJSYvgCiCx0j7LwUpqY4uOcSwFi1rNzKcF6iDb1eLxMcWWoL7a7ZpCXWaSqUi0zUZGrUK
        j5Pm1iflyzA9bWMOMIyVYf/6BGhEfBkgPLIL21KIiuOBA/Jku/ikcmqHtqDlrmLn+P25b7q4
        wwPNR/eYJttKF0UP91VPOsud+pG5R1ffZWY75D7L615y1/pyRew12P4hasbU2HdDUfkksLeN
        LXqz2eVYeU861JBYTR5J2a96UTqdJSnwNUw9mzmzih0o3YArFmPzTemvcCFnoInVCMvRfwCM
        GgbEhwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnK7SWbk4gzlt/BZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8DiwOXx+9ckRo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD0+b5LzOLT9DVsAexSXTUpqTmZZapG+XQJXxuXfqxgL9ltU7Hwy
        l7mBcbpOFyMnh4SAicSbnx+Yuhi5OIQEdjNK3N0wiQkiIS1x7MQZ5i5GDiBbWOLw4WKImg+M
        Eg9vdbCDxNkEtCX+bBEFKRcRcJTo3XWYBaSGWeA0o0T3xodgc4QFzCQOvm1nB7FZBFQlTr58
        yApi8wrYSNx8ehlql7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7
        iREcdFqaOxgvL4k/xCjAwajEw6twRzZOiDWxrLgy9xCjBAezkgjvyRlAId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhhl4/af5fqxQkPk0D8FZdcfT+Se
        ZJxq2f9hs8yNtNNSj/xF2XI6m65Xc9z0O7dKbF5mvYF/Ydj3xJfxiTf9++80ed2e4bPxXahm
        5r+Jz2aXdew9rbVns5vxXFX7s6edQicdWfrxpO76PPVC44+7vkyfJ6i8KJDhbJw328lOu+wi
        NYace0ddkpcosRRnJBpqMRcVJwIAxpSB/DYCAAA=
X-CMS-MailID: 20200115082818epcas1p4892a99345626188afd111ee263132458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082818epcas1p4892a99345626188afd111ee263132458
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
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

v10:
 - Make PBR structures as packed structure.
 - Fix build error on 32 bit system.
 - Change L suffix of UNIX_SECS_2108 macro with LL suffix to work
   on both 32/64bit system.
 - Rework exfat time handling.
 - Don't warp exfat specification URLs.
 - Add _FS suffix to config name.
 - Remove case_sensitive mount option.
 - iocharset=utf8 mount option work as utf8 option.
 - Rename the misleading nls names to corresponding ones.
 - Fix wrong header guard name of exfat_fs.h.
 - Remove the unneeded braces of macros in exfat_fs.h.
 - Move the ondisk values to exfat_raw.h
 - Put the operators at the previous line in exfat_cluster_to_sector().
 - Braces of EXFAT_DELETE macro would outside the ~.
 - Directly use exfat dentry field name.
 - Add EXFAT_CLUSTERS_UNTRACKED macro.
 - Remove both sets of inner braces in exfat_set_vol_flags().
 - Replace is_reserved_cluster() with an explicit check
   for EXFAT_EOF_CLUSTER.
 - Initialize superblock s_time_gran/max/min.
 - Clean-up exfat_bmap and exfat_get_block().
 - Fix wrong boundlen to avoid potential buffer overflow
   in exfat_convert_char_to_ucs2().
 - Process length value as 1 when conversion is failed.
 - Replace union exfat_timezone with masking the valid bit.
 - Change exfat_cmp_uniname() with exfat_uniname_ncmp().
 - Remove struct exfat_timestamp.
 - Add atime update support.
 - Add time_offset mount option.
 - Remove unneeded CLUSTER_32 macro.
 - Process utf16 surroage pair as one character.
 - Rename MUST_ZERO_LEN to PBR64_RESERVED_LEN.
 - Simplify is_exfat function by just using memchr_inv().
 - Remove __exfat_init_name_hash.
 - Remove exfat_striptail_len.
 - Split dentry ops for the utf8 vs non-utf8 cases.

v9:
 - Add support time zone.
 - Fix data past EOF resulting from fsx testsuite.
 - Remove obsolete comments in __exfat_resolve_path().
 - Remove unused file attributes macros.
 - Remove unneeded #if BITS_PER_LONG.

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

Namjae Jeon (14):
  exfat: add in-memory and on-disk structures and headers
  exfat: add super block operations
  exfat: add inode operations
  exfat: add directory operations
  exfat: add file operations
  exfat: add fat entry operations
  exfat: add bitmap operations
  exfat: add exfat cache
  exfat: add misc operations
  exfat: add nls operations
  exfat: add Kconfig and Makefile
  exfat: add exfat in fs/Kconfig and fs/Makefile
  MAINTAINERS: add exfat filesystem
  staging: exfat: make staging/exfat and fs/exfat mutually exclusive

 MAINTAINERS                   |    7 +
 drivers/staging/exfat/Kconfig |    2 +-
 fs/Kconfig                    |    3 +-
 fs/Makefile                   |    1 +
 fs/exfat/Kconfig              |   21 +
 fs/exfat/Makefile             |    8 +
 fs/exfat/balloc.c             |  282 +++++++
 fs/exfat/cache.c              |  325 ++++++++
 fs/exfat/dir.c                | 1244 ++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h           |  520 ++++++++++++
 fs/exfat/exfat_raw.h          |  184 +++++
 fs/exfat/fatent.c             |  463 +++++++++++
 fs/exfat/file.c               |  355 ++++++++
 fs/exfat/inode.c              |  667 +++++++++++++++
 fs/exfat/misc.c               |  162 ++++
 fs/exfat/namei.c              | 1442 +++++++++++++++++++++++++++++++++
 fs/exfat/nls.c                |  834 +++++++++++++++++++
 fs/exfat/super.c              |  724 +++++++++++++++++
 18 files changed, 7242 insertions(+), 2 deletions(-)
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

