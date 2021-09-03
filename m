Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE24001E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348409AbhICPU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:20:58 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:34864 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235515AbhICPU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:20:56 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 097B11CC;
        Fri,  3 Sep 2021 18:19:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630682391;
        bh=C7LWXvYDBulnF8t609DkfrxLr/asKLyhnDepGTY/Ot0=;
        h=To:CC:From:Subject:Date;
        b=iDbs8OQvp2LnUzBucwMyPHCufaJUX28lcdc6o3G1r4TyTuNun8YhltwmJp3lw/+Dj
         14EH9+6xKGghOhEGNAKNfBFDWYQLE3lBfM4HbgYKUDeXFfnND5spv/UartP+hwR6vx
         tFdTLT9YaAB4BKuhxj13SJUUK1c84Yt0ZsjQvqog=
Received: from [192.168.211.96] (192.168.211.96) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 18:19:50 +0300
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: new NTFS driver for 5.15
Message-ID: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
Date:   Fri, 3 Sep 2021 18:19:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.96]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing ntfs3 code for 5.15.

This is NTFS read-write driver. Current version works with 
normal/compressed/sparse files and supports acl,
NTFS journal replaying.

Most of the code was in linux-next branch since Aug 13, but
there are some patches, that were in linux-next branch only
for a couple of days. Hopefully it is ok - no regression
was detected in tests.

Linus, sorry for messing up, but there was a back merge
from Linux 5.14-rc5 to 5.14-rc7 with github web
interface.

There is build failure after merge of the overlayfs tree
in linux-next [1].

Regards,

Konstantin

[1]: https://lore.kernel.org/linux-next/20210819093910.55f96720@canb.auug.org.au/

----------------------------------------------------------------

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (Sun Aug 8 13:49:31 2021 -0700)

are available in the Git repository at:

  https://github.com/Paragon-Software-Group/linux-ntfs3.git master

for you to fetch changes up to 2e3a51b59ea26544303e168de8a0479915f09aa3:

  fs/ntfs3: Change how module init/info messages are displayed (Sun Aug 29 17:42:39 2021 +0300)

----------------------------------------------------------------
Konstantin Komarov (12)
      fs/ntfs3: Restyle comments to better align with kernel-doc
      fs/ntfs3: Rework file operations
      fs/ntfs3: Add MAINTAINERS
      fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
      fs/ntfs3: Add Kconfig, Makefile and doc
      fs/ntfs3: Add NTFS journal
      fs/ntfs3: Add compression
      fs/ntfs3: Add attrib operations
      fs/ntfs3: Add file operations and implementation
      fs/ntfs3: Add bitmap
      fs/ntfs3: Add initialization of super block
      fs/ntfs3: Add headers and misc files

Kari Argillander (13)
      fs/ntfs3: Change how module init/info messages are displayed
      fs/ntfs3: Remove GPL boilerplates from decompress lib files
      fs/ntfs3: Remove unnecessary condition checking from ntfs_file_read_iter
      fs/ntfs3: Fix integer overflow in ni_fiemap with fiemap_prep()
      fs/ntfs3: Remove fat ioctl's from ntfs3 driver for now
      fs/ntfs3: Restyle comments to better align with kernel-doc
      fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc
      fs/ntfs3: Do not use driver own alloc wrappers
      fs/ntfs3: Use kernel ALIGN macros over driver specific
      fs/ntfs3: Restyle comment block in ni_parse_reparse()
      fs/ntfs3: Fix one none utf8 char in source file
      fs/ntfs3: Add ifndef + define to all header files
      fs/ntfs3: Use linux/log2 is_power_of_2 function

Dan Carpenter (5)
      fs/ntfs3: Fix error handling in indx_insert_into_root()
      fs/ntfs3: Potential NULL dereference in hdr_find_split()
      fs/ntfs3: Fix error code in indx_add_allocate()
      fs/ntfs3: fix an error code in ntfs_get_acl_ex()
      fs/ntfs3: add checks for allocation failure

Jiapeng Chong (1)
      fs/ntfs3: Remove unused including <linux/version.h>

Gustavo A. R. Silva (1)
      fs/ntfs3: Fix fall-through warnings for Clang

Nathan Chancellor (1)
      fs/ntfs3: Remove unused variable cnt in ntfs_security_init()

Colin Ian King (2)
      fs/ntfs3: Fix integer overflow in multiplication
      fs/ntfs3: Fix various spelling mistakes

 Documentation/filesystems/index.rst |   1 +
 Documentation/filesystems/ntfs3.rst | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/Kconfig                    |   46 +++
 fs/ntfs3/Makefile                   |   36 ++
 fs/ntfs3/attrib.c                   | 2093 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/attrlist.c                 |  460 +++++++++++++++++++++
 fs/ntfs3/bitfunc.c                  |  134 +++++++
 fs/ntfs3/bitmap.c                   | 1493 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/debug.h                    |   52 +++
 fs/ntfs3/dir.c                      |  599 ++++++++++++++++++++++++++++
 fs/ntfs3/file.c                     | 1251 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/frecord.c                  | 3257 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/fslog.c                    | 5217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2509 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/index.c                    | 2650 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/inode.c                    | 1957 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/lib/decompress_common.c    |  319 +++++++++++++++
 fs/ntfs3/lib/decompress_common.h    |  338 ++++++++++++++++
 fs/ntfs3/lib/lib.h                  |   26 ++
 fs/ntfs3/lib/lzx_decompress.c       |  670 +++++++++++++++++++++++++++++++
 fs/ntfs3/lib/xpress_decompress.c    |  142 +++++++
 fs/ntfs3/lznt.c                     |  453 +++++++++++++++++++++
 fs/ntfs3/namei.c                    |  411 +++++++++++++++++++
 fs/ntfs3/ntfs.h                     | 1216 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h                  | 1111 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/record.c                   |  605 ++++++++++++++++++++++++++++
 fs/ntfs3/run.c                      | 1113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/super.c                    | 1512 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/upcase.c                   |  108 +++++
 fs/ntfs3/xattr.c                    | 1119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 30 files changed, 31004 insertions(+)
