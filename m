Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659CD1753A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCBG0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:18 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59318 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCBG0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:18 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200302062616epoutp04a31958c13105ca805dae63389427178a~4aLBwu_042079020790epoutp04T
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200302062616epoutp04a31958c13105ca805dae63389427178a~4aLBwu_042079020790epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130376;
        bh=1JassymyZWgXEYwox6M2rkXySq4efOfNw2fYegjjaOA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EKe/my2m5lD68tdhCoEaL/XXFSg0VBWv9UiTN0PsLwTPY3Fz9P+qZy94kLgrsK4s6
         +SqyB0+gRJIlv7uEtXpNHWzqhWx8l+HHtpLICDRYhlpQDlG0L1gbRJD8VepMY8Er2J
         /9Cv8UFTGTEzwdXtFSkg/y4B5cqM8xSSvkT8cUMk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302062615epcas1p2ec79b5b0f16a34d49e14be3c7f8a03a8~4aLBWwc3s2684626846epcas1p2G;
        Mon,  2 Mar 2020 06:26:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48W9Bt1bRXzMqYkl; Mon,  2 Mar
        2020 06:26:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E7.52419.607AC5E5; Mon,  2 Mar 2020 15:26:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9~4aK-rHJmi2684626846epcas1p29;
        Mon,  2 Mar 2020 06:26:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302062613epsmtrp1cc70a01f3b9c6ab283936b4a0876cafb~4aK-qT4H31398513985epsmtrp1n;
        Mon,  2 Mar 2020 06:26:13 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-b6-5e5ca706eae3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.EA.06569.507AC5E5; Mon,  2 Mar 2020 15:26:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062613epsmtip2679ebaabdd72de19642449fd98eaa527~4aK-hW0gL2393223932epsmtip2V;
        Mon,  2 Mar 2020 06:26:13 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 00/14] add the latest exfat driver
Date:   Mon,  2 Mar 2020 15:21:31 +0900
Message-Id: <20200302062145.1719-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmri7b8pg4g7tf2S3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x/65a9g9dt9sYPPo27KK0ePzJjmPQ9vfsHlsevKWKYAjKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsb3G9PYC1baV3T8ncTa
        wHjXsIuRk0NCwETi9LPpTF2MXBxCAjsYJV7PvMkG4XxilLhw8SNU5hujxL3GvWwwLX3nnjFD
        JPYySjycfZMZruXwr0tALRwcbALaEn+2iII0iAhIS5zpvwQ2iVmggUmi+UATO0hCWMBMonFR
        IzOIzSKgKvFl6z8WEJtXwFpi+eMrzBDb5CVWbzgAtkBCYAebxLI9W6ESLhIXW3czQtjCEq+O
        b2GHsKUkXva3sYMcISFQLfFxP1R5B6PEi++2ELaxxM31G1hBSpgFNCXW79KHCCtK7Pw9F2wi
        swCfxLuvPawQU3glOtqEIEpUJfouHWaCsKUluto/QC31kPh+sAUcPkICsRKT5rezTWCUnYWw
        YAEj4ypGsdSC4tz01GLDAmPkSNrECE58WuY7GDec8znEKMDBqMTDu+N5dJwQa2JZcWXuIUYJ
        DmYlEV5fTqAQb0piZVVqUX58UWlOavEhRlNg2E1klhJNzgcm5bySeENTI2NjYwsTM3MzU2Ml
        cd6HkZpxQgLpiSWp2ampBalFMH1MHJxSDYzT2oPjtM9st/90yZsp6aQI0+vrB6LTv/Fv3Lnu
        rfqEOWcbf/6//WQZe/T52fc1Hrzae/91ndpnhneVB1amhl40aN8SoHDX329J9E2nhU6TdR9+
        fr1Z2WaiwNY5XdwGEQvvFG731asumb527pT7FfvMavJiYjYH/fzQ9eH/4b+paf+Onwuxvqi0
        WYmlOCPRUIu5qDgRAMMl6UqSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvC7r8pg4gwsLdC3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x/65a9g9dt9sYPPo27KK0ePzJjmPQ9vfsHlsevKWKYAjissmJTUnsyy1SN8ugSvj
        +41p7AUr7Ss6/k5ibWC8a9jFyMkhIWAi0XfuGXMXIxeHkMBuRom5rR1sEAlpiWMnzgAlOIBs
        YYnDh4shaj4wSnxb/IwNJM4moC3xZ4soSLkIUPmZ/ktMIDXMAj1MEp+nLGYCSQgLmEk0Lmpk
        BrFZBFQlvmz9xwJi8wpYSyx/fIUZYpe8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhglJdarlec
        mFtcmpeul5yfu4kRHIhaWjsYT5yIP8QowMGoxMO743l0nBBrYllxZe4hRgkOZiURXl9OoBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZG32WKR87ZzVrV
        Nv2kQ8bEvVzTtJIMDPP1lN9XaXD9Wbv+FTPfJVuR6lXpK36yvNre+8/rOsdte4Y6UcZ/s1Zy
        rmbl2MtqfiGopfL7G5WS+V/93jyQ7ko9Vq6V3jk5ZQmbya+as/GLlkQahPhsEym6Uc8Tf/rD
        5uNmi4WOL4mfZJYVatm5SEhciaU4I9FQi7moOBEAXktvUUACAAA=
X-CMS-MailID: 20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9
References: <CGME20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9@epcas1p2.samsung.com>
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

v14:
 - update file system parameter handling. 

v13:
 - rcu-delay unloading nls, freeing upcase table and sbi.
 - Switch to ->free_inode().
 - Push rcu_barrier() from deactivate_locked_super() to filesystems.
 - Remove unused variables in exfat_sb_info structure.

v12:
 - Merge the #12 patch into the #11 patch.
 - Remove an incorrect comment about time_offset mount option.

v11:
 - Use current_time instead of ktime_get_real_ts64.
 - Add i_crtime in exfat inode.
 - Drop the clamping min/max timestamp.
 - Merge exfat_init_file_entry into exfat_init_dir_entry.
 - Initialize the msec fields in exfat_init_dir_entry.
 - Change timestamps written to disk always get stored in UTC instead of
   active timezone.
 - Update EXFAT_DEFAULT_IOCHARSET description in Kconfig.
 - exfat_get/set_entry_time() take a time_ms argument.

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
 - Process utf16 surrogate pair as one character.
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

Namjae Jeon (13):
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
  MAINTAINERS: add exfat filesystem
  staging: exfat: make staging/exfat and fs/exfat mutually exclusive

Valdis Kletnieks (1):
  exfat: update file system parameter handling

 MAINTAINERS                   |    7 +
 drivers/staging/exfat/Kconfig |    2 +-
 fs/Kconfig                    |    3 +-
 fs/Makefile                   |    1 +
 fs/exfat/Kconfig              |   21 +
 fs/exfat/Makefile             |    8 +
 fs/exfat/balloc.c             |  280 +++++++
 fs/exfat/cache.c              |  325 ++++++++
 fs/exfat/dir.c                | 1238 ++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h           |  519 ++++++++++++
 fs/exfat/exfat_raw.h          |  184 +++++
 fs/exfat/fatent.c             |  463 +++++++++++
 fs/exfat/file.c               |  360 ++++++++
 fs/exfat/inode.c              |  671 +++++++++++++++
 fs/exfat/misc.c               |  163 ++++
 fs/exfat/namei.c              | 1448 +++++++++++++++++++++++++++++++++
 fs/exfat/nls.c                |  831 +++++++++++++++++++
 fs/exfat/super.c              |  722 ++++++++++++++++
 18 files changed, 7244 insertions(+), 2 deletions(-)
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

