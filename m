Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95A65205C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 13:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiLTMaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 07:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLTMaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:30:20 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 04:30:16 PST
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3A3895;
        Tue, 20 Dec 2022 04:30:16 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 14CAE1D1D;
        Tue, 20 Dec 2022 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1671538825;
        bh=HBbrQVVAfFXTWMS850ixZnZhRFgDb7JtS4RSHs5t/uk=;
        h=Date:To:CC:From:Subject;
        b=WfY2QzBw+iwCkzZKs3w5iRenvHkbASXNW24KA5EM0BYran43QcbfcMnqHZAL637LC
         5/F2m6jgffq5xs0DN/Rae5jRXD4kGcFuMxa2t0SOWAKMzI43YmLpAcd++kobbi1kiG
         sH780K2R9fDV1hss9k6x5ltKHoSPOXIgwJ1v7f9Q=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 19DE11F9D;
        Tue, 20 Dec 2022 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1671539029;
        bh=HBbrQVVAfFXTWMS850ixZnZhRFgDb7JtS4RSHs5t/uk=;
        h=Date:To:CC:From:Subject;
        b=qzEuUj5NAaEkDmOBTs2t4/QIowQryCiU/4AlgmfDOTbceyGVxMykVET7dKqIoUZxs
         zH0pmRQsuQw55kilUg8rCdhob9ZsxFFx5/aMP+SZEDfFqqVkbnFLNEF7xb19MjRG9f
         MUmfVrlXyoQUUXGzyWE3DKsyPXlUrcXf1RMBioaw=
Received: from [192.168.211.163] (192.168.211.163) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Dec 2022 15:23:48 +0300
Message-ID: <3826a578-c371-bace-96a5-4e5dc83b5602@paragon-software.com>
Date:   Tue, 20 Dec 2022 16:23:47 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 6.2
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.163]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing ntfs3 code for 6.2.

Added:
- add hidedotfiles option;
- add option "nocase";
- add windows_names mount option.

Fixed:
- fixed xfstests (tested on x86_64):
generic/083 generic/263 generic/307 generic/465;
- some logic errors;
- some dead code was removed or refactored.

The code was in linux-next branch since November.

There is merge conflict in linux-next [1].

Regards,

Konstantin

[1]: https://lore.kernel.org/lkml/20221115101756.5d311f25@canb.auug.org.au

----------------------------------------------------------------

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

    Linux 6.0-rc7 (Sun Sep 25 14:01:02 2022 -0700)

are available in the Git repository at:

    https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.2

for you to fetch changes up to 36963cf225f890f97fd84af0a82d323043edd0f1:

    fs/ntfs3: Make if more readable (Tue Oct 11 20:21:03 2022 +0300)

----------------------------------------------------------------

Abdun Nihaal (2):
       fs/ntfs3: Fix slab-out-of-bounds read in ntfs_trim_fs
       fs/ntfs3: Validate attribute data and valid sizes

Alon Zahavi (1):
       fs/ntfs3: Fix attr_punch_hole() null pointer derenference

Dan Carpenter (2):
       fs/ntfs3: Harden against integer overflows
       fs/ntfs3: Delete duplicate condition in ntfs_read_mft()

Daniel Pinto (10):
       fs/ntfs3: Fix junction point resolution
       fs/ntfs3: Add windows_names mount option
       fs/ntfs3: Document windows_names mount option
       fs/ntfs3: Fix hidedotfiles mount option by reversing behaviour
       fs/ntfs3: Make hidedotfiles mount option work when renaming files
       fs/ntfs3: Add hidedotfiles to the list of enabled mount options
       fs/ntfs3: Document the hidedotfiles mount option
       fs/ntfs3: Rename hidedotfiles mount option to hide_dot_files
       fs/ntfs3: Add system.ntfs_attrib_be extended attribute
       fs/ntfs3: Document system.ntfs_attrib_be extended attribute

Edward Lo (9):
       fs/ntfs3: Validate data run offset
       fs/ntfs3: Add null pointer check to attr_load_runs_vcn
       fs/ntfs3: Add null pointer check for inode operations
       fs/ntfs3: Validate attribute name offset
       fs/ntfs3: Validate buffer length while parsing index
       fs/ntfs3: Validate resident attribute name
       fs/ntfs3: Validate index root when initialize NTFS security
       fs/ntfs3: Validate BOOT record_size
       fs/ntfs3: Add overflow check for attribute size

Hawkins Jiawei (1):
       fs/ntfs3: Fix slab-out-of-bounds read in run_unpack

Kenneth Lee (1):
       fs/ntfs3: Use kmalloc_array for allocating multiple elements

Konstantin Komarov (23):
       fs/ntfs3: Add comments about cluster size
       fs/ntfs3: Add hidedotfiles option
       fs/ntfs3: Change destroy_inode to free_inode
       fs/ntfs3: Add option "nocase"
       fs/ntfs3: Rename variables and add comment
       fs/ntfs3: Add ntfs_bitmap_weight_le function and refactoring
       fs/ntfs3: Fix sparse problems
       fs/ntfs3: Remove unused functions
       fs/ntfs3: Simplify ntfs_update_mftmirr function
       fs/ntfs3: Fixing work with sparse clusters
       fs/ntfs3: Change new sparse cluster processing
       fs/ntfs3: Fix wrong indentations
       fs/ntfs3: atomic_open implementation
       fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate
       fs/ntfs3: Changing locking in ntfs_rename
       fs/ntfs3: Restore correct state after ENOSPC in attr_data_get_block
       fs/ntfs3: Correct ntfs_check_for_free_space
       fs/ntfs3: Check fields while reading
       fs/ntfs3: Fix incorrect if in ntfs_set_acl_ex
       fs/ntfs3: Use ALIGN kernel macro
       fs/ntfs3: Fix wrong if in hdr_first_de
       fs/ntfs3: Improve checking of bad clusters
       fs/ntfs3: Make if more readable

Marc Aurèle La France (1):
       fs/ntfs3: Fix [df]mask display in /proc/mounts

Nathan Chancellor (2):
       fs/ntfs3: Don't use uni1 uninitialized in ntfs_d_compare()
       fs/ntfs3: Eliminate unnecessary ternary operator in ntfs_d_compare()

Shigeru Yoshida (2):
       fs/ntfs3: Fix memory leak on ntfs_fill_super() error path
       fs/ntfs3: Avoid UBSAN error on true_sectors_per_clst()

Tetsuo Handa (2):
       fs/ntfs3: Use __GFP_NOWARN allocation at wnd_init()
       fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_fill_super()

Thomas Kühnel (3):
       fs/ntfs3: Fix endian conversion in ni_fname_name
       fs/ntfs3: Add functions to modify LE bitmaps
       fs/ntfs3: Use _le variants of bitops functions

Yin Xiujiang (1):
       fs/ntfs3: Fix slab-out-of-bounds in r_page

Yuan Can (1):
       fs/ntfs3: Use strcmp to determine attribute type

  Documentation/filesystems/ntfs3.rst |  19 +++++++
  fs/ntfs3/attrib.c                   | 392 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
  fs/ntfs3/attrlist.c                 |   5 ++
  fs/ntfs3/bitfunc.c                  |   4 +-
  fs/ntfs3/bitmap.c                   | 168 
+++++++++++++++++++++++++++++++++++++++++++++--------------
  fs/ntfs3/dir.c                      |   4 +-
  fs/ntfs3/file.c                     | 203 
+++++++++++++++++++----------------------------------------------------
  fs/ntfs3/frecord.c                  |  38 ++++++++++++--
  fs/ntfs3/fslog.c                    |  62 +++++++++-------------
  fs/ntfs3/fsntfs.c                   | 190 
++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
  fs/ntfs3/index.c                    | 127 
+++++++++++++++++++++++++++++++++++++--------
  fs/ntfs3/inode.c                    | 210 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
  fs/ntfs3/namei.c                    | 238 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/ntfs.h                     |   6 +--
  fs/ntfs3/ntfs_fs.h                  |  41 +++++++++++----
  fs/ntfs3/record.c                   |   9 ++++
  fs/ntfs3/run.c                      |  28 +++-------
  fs/ntfs3/super.c                    | 119 
+++++++++++++++++++++++++-----------------
  fs/ntfs3/upcase.c                   |  12 +++++
  fs/ntfs3/xattr.c                    | 178 
++++++++++++++++++++++++++++++++++++---------------------------
  20 files changed, 1413 insertions(+), 640 deletions(-)
