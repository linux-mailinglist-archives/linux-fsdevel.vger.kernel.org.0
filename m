Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4C12E3C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgABIYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:05 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52783 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgABIYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102082400epoutp03bec6572e340a030c32e05ba055bf9ac5~mBEtDz_tD3210632106epoutp03N
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102082400epoutp03bec6572e340a030c32e05ba055bf9ac5~mBEtDz_tD3210632106epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953440;
        bh=ydyKKmBzXpY49usHpmayOEiAlXL0yE/F37CIy60lIpU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CgUmVHAJ6sdz5ASx02Azo7lX4ozZ1+nlj4AcoH57Ud7JnXlo6NR1KHle1FqT12ece
         +WRvb/Uj8bN8O5kNr8xGBga6d4JEVQeIOIiFLbl6jhfwEFRkuySC9Jk/wcYmxXitcX
         OafLzVXAYYLsESPIXRTbrHKnq19xdl4Jrf5GSlkc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200102082400epcas1p4f594978eaa390dafb69af159e5bd0ffa~mBEsuTU2l2549825498epcas1p4W;
        Thu,  2 Jan 2020 08:24:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47pLfR3SQ9zMqYkW; Thu,  2 Jan
        2020 08:23:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.B1.51241.F98AD0E5; Thu,  2 Jan 2020 17:23:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082359epcas1p2aa1eca9729a6ec54ec3b8140615dca6e~mBErmH5jo1480914809epcas1p2q;
        Thu,  2 Jan 2020 08:23:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200102082359epsmtrp180b8d4ba648827fa22333283dd60de27~mBErla5tx2259122591epsmtrp1w;
        Thu,  2 Jan 2020 08:23:59 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-25-5e0da89f3b18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.88.06569.F98AD0E5; Thu,  2 Jan 2020 17:23:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082358epsmtip2f551a0984091fe0a234501dd05d10da9~mBErZAW062522625226epsmtip2j;
        Thu,  2 Jan 2020 08:23:58 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 00/13] add the latest exfat driver
Date:   Thu,  2 Jan 2020 16:20:23 +0800
Message-Id: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmvu78FbxxBq9eSVs0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07M
        LS7NS9dLzs+1MjQwMDIFqkzIyTi+bSd7wUrNiv7HjSwNjF8Vuhg5OSQETCT2dDUydjFycQgJ
        7GCU+PzsFwtIQkjgE6PEopnCEPY3Ron9e2thGp6cOgZVs5dRYk+7H0QzUP2R70eBEhwcbALa
        En+2iILUiAjYS2yefYAFpIZZYBNQ/fyvrCAJYQFTiVtTpoLZLAKqEr87FzCD9PIK2EgsXiIH
        sUteYvWGA8wgvRICc9gk1iz6zASRcJE4MHEPO4QtLPHq+BYoW0riZX8bO8gcCYFqiY/7mSHC
        HYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3XEYQm1mAT+Ld1x5WiCm8Eh1tQhAlqhJ9
        lw5DHSAt0dX+AWqph8TO1h9g5UICsRLXF3FPYJSdhTB/ASPjKkax1ILi3PTUYsMCU+T42cQI
        TmNaljsYj53zOcQowMGoxMN7Yx5PnBBrYllxZe4hRgkOZiUR3vJA3jgh3pTEyqrUovz4otKc
        1OJDjKbAkJvILCWanA9MsXkl8YamRsbGxhYmZuZmpsZK4rwcPy7GCgmkJ5akZqemFqQWwfQx
        cXBKNTDOW3CEc5mJWPuxa2H5ijVBU9ZLaBgtLZze9Gly+5ZlO/eumW5yaNJT/g3b7kncF5tb
        cMW01P3NqpaVjZZJ2esm/tgp/ra7YqH1iugnv/b5TlfeVr+pSnDNjoBjPyMVgirNPVSe/jKM
        fm8aO+9K8d3lNT6zPp5gX7UzL0gxhu/J772rJ3Y8+rnxgRJLcUaioRZzUXEiAABruZ95AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvO78FbxxBtO2sVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGUc37aTvWClZkX/40aWBsavCl2MnBwS
        AiYST04dY+li5OIQEtjNKHHq9XdGiIS0xLETZ5i7GDmAbGGJw4eLIWo+MEpsP7gdLM4moC3x
        Z4soSLmIgKNE767DYHOYBXYxSpw4fRpsjrCAqcStKVNZQWwWAVWJ350LwHp5BWwkFi+Rg1gl
        L7F6wwHmCYw8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIeXltYOxhMn4g8x
        CnAwKvHw3pjHEyfEmlhWXJl7iFGCg1lJhLc8kDdOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98
        /rFIIYH0xJLU7NTUgtQimCwTB6dUA+NkkYv+izYHvn/e6Gq4Wef0l20Nfuu/L+lI/btKpnmy
        77d2leTvgUt8zYrnmawWXDQxZU7am8BDoU/79usfuXSy9atdhf02Tesgk5svPGuCFN+c9bDi
        Vq84/PhDr5X29W0t+07fUonQ/5UTmbxtOVNTRfUjbuaA8NXfLn02lD5dmeuyUHyWnLwSS3FG
        oqEWc1FxIgALJ0EyKwIAAA==
X-CMS-MailID: 20200102082359epcas1p2aa1eca9729a6ec54ec3b8140615dca6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082359epcas1p2aa1eca9729a6ec54ec3b8140615dca6e
References: <CGME20200102082359epcas1p2aa1eca9729a6ec54ec3b8140615dca6e@epcas1p2.samsung.com>
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
 fs/exfat/dir.c       | 1305 +++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |  569 +++++++++++++++++
 fs/exfat/exfat_raw.h |  196 ++++++
 fs/exfat/fatent.c    |  472 ++++++++++++++
 fs/exfat/file.c      |  350 ++++++++++
 fs/exfat/inode.c     |  708 ++++++++++++++++++++
 fs/exfat/misc.c      |  253 ++++++++
 fs/exfat/namei.c     | 1456 ++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c       |  809 +++++++++++++++++++++++
 fs/exfat/super.c     |  723 +++++++++++++++++++++
 17 files changed, 7487 insertions(+), 1 deletion(-)
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

