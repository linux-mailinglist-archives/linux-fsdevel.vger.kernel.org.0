Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59C11DDF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfLMFxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:53:43 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30375 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfLMFxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:43 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213055339epoutp0259054ed59bf7c22c50087eac67b3dda1~f2HuM7Wr32312323123epoutp02S
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213055339epoutp0259054ed59bf7c22c50087eac67b3dda1~f2HuM7Wr32312323123epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216419;
        bh=tAuM5i1Zr5EVUgCsWVGaKaLv6RsoatY+VDmc2bGDoBE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CfbVRnYlilXFmxl+X30wgN2+yN4oxQzzApozDdqBgJN8jBUqkG+hpHqVICBSHAveW
         YDcPAMl7J7HiEFDh1p725OFbMZhwNoERJmiGc1IHvx4Xznfs6YELK+kI0tJQzWJDy7
         /wTcAfQH+aCoT3pO+fKQFgVCMOClib30OjHoX270=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213055339epcas1p174500b2c1b0fab7617ae0e143459cc3b~f2Ht582FU0207402074epcas1p1j;
        Fri, 13 Dec 2019 05:53:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Z0GB2DDlzMqYks; Fri, 13 Dec
        2019 05:53:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.BF.52419.16723FD5; Fri, 13 Dec 2019 14:53:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055336epcas1p267699d8a251e052da0ae8194cf5d1983~f2HrjQNpx1108711087epcas1p2G;
        Fri, 13 Dec 2019 05:53:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055336epsmtrp1109db0bfc2cee6f114d44b336cbe5f27~f2HrimxLN0538305383epsmtrp1V;
        Fri, 13 Dec 2019 05:53:36 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-0a-5df3276108b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.E0.10238.06723FD5; Fri, 13 Dec 2019 14:53:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055336epsmtip209fe04186fc65c23e59ff2ee9233d20d~f2HrYWvLf1338213382epsmtip2Z;
        Fri, 13 Dec 2019 05:53:36 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 00/13] add the latest exfat driver
Date:   Fri, 13 Dec 2019 00:50:15 -0500
Message-Id: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTtc3ZnR3FjWrW+NtRtQERF3XVcHc0XKLapP4wePwSxSadV2xc7
        q2Qlbhi6SPgKSzRTCfEVKCZqvlsVSc3MIJXsQf3RsHyRipU06yj173DuOede7r0YIlkQSrEM
        nYkx6mgNgToIuka8/H1pz81kefW2M5X/pA2lmlvH7Kj+gZcC6m3vI5TaeZhHde6NCqnZ1TVB
        lEg1VPNUpOpbMKOq4s4WoNrscFNZu1fQRGGSJiydodMYo4zRperTMnTqcCL+Qkp0ijJIrvBV
        hFDBhExHa5lwIiYh0Tc2Q8NNQciyaU0WRyXSLEv4R4QZ9VkmRpauZ03hBGNI0xgUcoMfS2vZ
        LJ3aL1WvDVXI5QFKTnlFk96/OA8MVo8b71YXBGbw1bUI2GMQD4Q9lnxgwxK8B8AOC+TxBoCV
        lZIi4MDhLQC7Bh+gh4ad++UiXjQAYOkEzos4w2x9NZeEYSjuA393utg0zngkfFY9LLBpEPwu
        gHWTO4it4IQrobm7bz9UgHvA1cGp/VAxfgZ+eLFlxzdzh63tw4jNDHELCofrJkR8IQaWV7QJ
        eOwEv413HvBSuFxSILINAfFbcH0I4WkLgEvb4Twm4UJbu9AmQXAv2Nbrz9On4fNfNfuLQPCj
        8MfPe0I+RQwtBRJe4gGLZ0cOJjsFiwrXDpqq4FxhO8KvJBlWlLwSlQLXqn8N6gBoAccZA6tV
        M6zCQP5/oQ6w/1bewT2gfTrBCnAMEI7iJnojWSKks9kcrRVADCGcxZG3OUqcRufcZIz6FGOW
        hmGtQMntrgyRuqTquSfVmVIUygCSJKnAoOAgJUmcEGM7b5IluJo2MdcZxsAYD312mL3UDGKa
        jy3OFJhb+3dJud5+5Kpk77z/VFlYv9uyy1hS7HslulwqDXWtIk/aNTR+92vIvjan3tXqj8zU
        Z05MboojJ7+oMiW1oY3I57i4DEfD9OvRxNqmy3EfxyNkuZUrffFU81l0Ppuciz73+NJFz/Wo
        Pp+Q1Vz3vDv189Ycz09Lf4IIAZtOK7wRI0v/BczdGRFsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42LZdlhJXjdB/XOswfRtJhbNi9ezWaxcfZTJ
        Ys/ekywWl3fNYbP4Mb3eYsu/I6wWl95/YHFg99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA
        1igum5TUnMyy1CJ9uwSujD13bjAWHFKtuPb+JksD42PZLkZODgkBE4kfkyexdzFycQgJ7GaU
        ON21gRkiIS1x7MQZIJsDyBaWOHy4GKLmA6PEtLbN7CBxNgFtiT9bREHKRQQcJXp3HWYBqWEW
        6GKUeNT0DWyOsICpRMP23WwgNouAqsT7fWfYQWxeAWuJuwe/MUHskpdYveEA8wRGngWMDKsY
        JVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJDSEtzB+PlJfGHGAU4GJV4eBlSPsUKsSaW
        FVfmHmKU4GBWEuG1rwEK8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUI
        JsvEwSnVwMhqkf+ovmJif+w5gZd60wJ+BehfL+R7OPtjt6aMtKSmrHh9qOTEmzpRC+fs2xPS
        q/mkRP/Gl7/TXpusMu+5/NPXWUwgLaB89TuJG5tmVJ6e8pF7+u8rFu9nOTXcTqkSWbp9z/2D
        k74U/WhTT2E3n/K49VBPi54An99xIbVrrwwLfx6dZFrTUa3EUpyRaKjFXFScCAAdCATkHQIA
        AA==
X-CMS-MailID: 20191213055336epcas1p267699d8a251e052da0ae8194cf5d1983
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055336epcas1p267699d8a251e052da0ae8194cf5d1983
References: <CGME20191213055336epcas1p267699d8a251e052da0ae8194cf5d1983@epcas1p2.samsung.com>
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
 - Fix wrong statfs-f_namelen.

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
 fs/exfat/exfat_fs.h  |  568 ++++++++++++++++
 fs/exfat/exfat_raw.h |  202 ++++++
 fs/exfat/fatent.c    |  472 ++++++++++++++
 fs/exfat/file.c      |  343 ++++++++++
 fs/exfat/inode.c     |  694 ++++++++++++++++++++
 fs/exfat/misc.c      |  240 +++++++
 fs/exfat/namei.c     | 1459 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  808 +++++++++++++++++++++++
 fs/exfat/super.c     |  732 +++++++++++++++++++++
 17 files changed, 7459 insertions(+), 1 deletion(-)
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

