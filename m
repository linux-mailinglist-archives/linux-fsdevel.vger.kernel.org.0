Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F074B2DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGGOOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGGOOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:14:38 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8BDE72;
        Fri,  7 Jul 2023 07:14:37 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 73D7B21B5;
        Fri,  7 Jul 2023 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688738962;
        bh=r515y2vXpvOHrZg95ZCLv5OC11gqtBQ6XJAJt+SxN1U=;
        h=Date:To:CC:From:Subject;
        b=fk7vHzrFfxs7suZ6STIL1eGmz9SNrq5JQKz2HH49nDU6M3iOffTxA7+sBHEMa4ylD
         Lzc/F69rVO/lhc4Luku/e0PoJKQxTke52713RqJ+8wb8RrHaZNxbvwm4a4j5urJ/LX
         eTgcbeUeFNjq98I+WcEvrm3h/k9M2x33OLjWgLc4=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D63731E47;
        Fri,  7 Jul 2023 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688739275;
        bh=r515y2vXpvOHrZg95ZCLv5OC11gqtBQ6XJAJt+SxN1U=;
        h=Date:To:CC:From:Subject;
        b=H1sL5WAMNOV3d5r+wAZYzIrysjR0VEDap4gPGwjg4oVv2FssWA9NrZOSHwtUhUaEg
         QUvOv6qrBqSm8FiKKQoMaoHWcSPIO6G2+cg6/QHruhkSR6osm8VsrtKrNQSDwBvi2v
         ofEBeM6I+2q1iqqMYJWkZTi0KvM2R8dgW4UEcSs8=
Received: from [192.168.211.150] (192.168.211.150) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jul 2023 17:14:35 +0300
Message-ID: <c9649ce0-98c7-71cb-73c3-8a172d6689ff@paragon-software.com>
Date:   Fri, 7 Jul 2023 18:14:34 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: changes for 6.5
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.150]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing ntfs3 code for 6.5.

Added:
- support /proc/fs/ntfs3/<dev>/volinfo and label;
- alternative boot if primary boot is corrupted;
- small optimizations.

Fixed:
- some endian problem;
- some logic errors;
- code is refactored and reformatted.

Regards,

Konstantin

----------------------------------------------------------------

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

    Linux 6.4 (Sun Jun 25 16:29:58 2023 -0700)

are available in the Git repository at:

    https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.5

for you to fetch changes up to 44b4494d5c5971dc8f531c8783d90a637e862880:

    fs/ntfs3: Correct mode for label entry inside /proc/fs/ntfs3/ (Fri 
Jun 30 15:23:07 2023 +0400)

----------------------------------------------------------------

Edward Lo (2):
   fs/ntfs3: Enhance sanity check while generating attr_list
   fs/ntfs3: Return error for inconsistent extended attributes

Jia-Ju Bai (1):
   fs: ntfs3: Fix possible null-pointer dereferences in mi_read()

Konstantin Komarov (11):
   fs/ntfs3: Correct checking while generating attr_list
   fs/ntfs3: Fix ntfs_atomic_open
   fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted
   fs/ntfs3: Alternative boot if primary boot is corrupted
   fs/ntfs3: Do not update primary boot in ntfs_init_from_boot()
   fs/ntfs3: Code formatting
   fs/ntfs3: Code refactoring
   fs/ntfs3: Add ability to format new mft records with bigger/smaller
     header
   fs/ntfs3: Fix endian problem
   fs/ntfs3: Add support /proc/fs/ntfs3/<dev>/volinfo and
     /proc/fs/ntfs3/<dev>/label
   fs/ntfs3: Correct mode for label entry inside /proc/fs/ntfs3/

Tetsuo Handa (1):
   fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()

Yangtao Li (1):
   fs/ntfs3: Use wrapper i_blocksize() in ntfs_zero_range()

Zeng Heng (1):
   ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()

  fs/ntfs3/attrib.c   |   2 +-
  fs/ntfs3/attrlist.c |   7 +-
  fs/ntfs3/bitmap.c   |  10 +-
  fs/ntfs3/file.c     |   6 +-
  fs/ntfs3/frecord.c  |  58 ++++-----
  fs/ntfs3/fslog.c    |  40 +++----
  fs/ntfs3/fsntfs.c   |  99 ++++++++++++----
  fs/ntfs3/index.c    |  20 ++--
  fs/ntfs3/inode.c    |  23 ++--
  fs/ntfs3/lznt.c     |   6 +-
  fs/ntfs3/namei.c    |  31 ++---
  fs/ntfs3/ntfs.h     | 117 ++++++++++--------
  fs/ntfs3/ntfs_fs.h  |  31 ++---
  fs/ntfs3/record.c   |  14 ++-
  fs/ntfs3/run.c      |   4 +-
  fs/ntfs3/super.c    | 280 ++++++++++++++++++++++++++++++++++++++------
  fs/ntfs3/xattr.c    |  20 ++--
  17 files changed, 531 insertions(+), 237 deletions(-)

