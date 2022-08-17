Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1944597470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiHQQoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiHQQn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:43:58 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB630F6E;
        Wed, 17 Aug 2022 09:43:53 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7CEA92147;
        Wed, 17 Aug 2022 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1660754534;
        bh=EHA8PmNWIXmclwoQXYiUp1GSP3DqbAL/8zItVTO2gng=;
        h=Date:To:CC:From:Subject;
        b=eTPt7DTKPc4x3xuSpmh5lDYpIqjPaka20te2ilGPqiNd/POTi/XPcLQ1xqkRGc/Tv
         ZR1VszXzN4s4kOIzhVK6GhAMcn57I2rKJ0j7DkHchTdn/Sekqi9IL1SOhQesdLQB7h
         4uuyjC1fB596qJg52V3D3GryuP+Kt+4sA9JuDaG0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Aug 2022 19:43:51 +0300
Message-ID: <db8cb5d9-56d6-a00a-9cf0-4deec9056433@paragon-software.com>
Date:   Wed, 17 Aug 2022 19:43:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 6.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
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

Please pull this branch containing ntfs3 code for 6.0.

Fixed:
- some logic errors;
- fixed xfstests (tested on x86_64)
generic/064 generic/213 generic/300 generic/361 generic/449 generic/485;
- some dead code was removed or refactored.

Most of the code was in linux-next branch for several weeks,
but there are some patches, that were in linux-next branch only
for a week.

Regards,

Konstantin

----------------------------------------------------------------

The following changes since commit 724bbe49c5e427cb077357d72d240a649f2e4054:

   fs/ntfs3: provide block_invalidate_folio to fix memory leak (Mon May 30 13:36:45 2022 +0200)

are available in the Git repository at:

   https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.0

for you to fetch changes up to d4073595d0c61463ec3a87411b19e2a90f76d3f8:

   fs/ntfs3: uninitialized variable in ntfs_set_acl_ex() (Mon Aug 8 11:34:41 2022 +0300)

----------------------------------------------------------------

Christophe JAILLET (1)
  fs/ntfs3: Remove a useless test

Colin Ian King (3)
  fs/ntfs3: Remove duplicated assignment to variable r
  fs/ntfs3: Remove redundant assignment to variable vcn
  fs/ntfs3: Remove redundant assignment to variable frame

Yan Lei (1)
  fs/ntfs3: Fix using uninitialized value n when calling indx_read

Yang Xu (1)
  fs/ntfs3: Use the same order for acl pointer check in ntfs_init_acl

Dan Carpenter (3)
  fs/ntfs3: uninitialized variable in ntfs_set_acl_ex()
  fs/ntfs3: Unlock on error in attr_insert_range()
  fs/ntfs3: Don't clear upper bits accidentally in log_replay()

Pavel Skripkin (2)
  fs/ntfs3: Make ntfs_update_mftmirr return void
  fs/ntfs3: Fix NULL deref in ntfs_update_mftmirr

Li Kunyu (1)
  fs/ntfs3: Remove unnecessary 'NULL' values from pointers

Jiapeng Chong (1)
  fs/ntfs3: Remove unused function wnd_bits

Konstantin Komarov (26)
  fs/ntfs3: Make ni_ins_new_attr return error
  fs/ntfs3: Create MFT zone only if length is large enough
  fs/ntfs3: Refactoring attr_insert_range to restore after errors
  fs/ntfs3: Refactoring attr_punch_hole to restore after errors
  fs/ntfs3: Refactoring attr_set_size to restore after errors
  fs/ntfs3: New function ntfs_bad_inode
  fs/ntfs3: Make MFT zone less fragmented
  fs/ntfs3: Check possible errors in run_pack in advance
  fs/ntfs3: Added comments to frecord functions
  fs/ntfs3: Fill duplicate info in ni_add_name
  fs/ntfs3: Make static function attr_load_runs
  fs/ntfs3: Add new argument is_mft to ntfs_mark_rec_free
  fs/ntfs3: Remove unused mi_mark_free
  fs/ntfs3: Fix very fragmented case in attr_punch_hole
  fs/ntfs3: Fix work with fragmented xattr
  fs/ntfs3: Make ntfs_fallocate return -ENOSPC instead of -EFBIG
  fs/ntfs3: extend ni_insert_nonresident to return inserted ATTR_LIST_ENTRY
  fs/ntfs3: Check reserved size for maximum allowed
  fs/ntfs3: Do not change mode if ntfs_set_ea failed
  fs/ntfs3: Enable FALLOC_FL_INSERT_RANGE
  fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE) implementation
  fs/ntfs3: Add missing error check
  fs/ntfs3: Fix missing i_op in ntfs_read_mft
  fs/ntfs3: Refactor ni_try_remove_attr_list function
  fs/ntfs3: Fix double free on remount
  fs/ntfs3: Refactoring of indx_find function


  fs/ntfs3/attrib.c  | 557 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
  fs/ntfs3/bitmap.c  |  12 +---
  fs/ntfs3/file.c    | 110 +++++++++++++++++------------
  fs/ntfs3/frecord.c | 128 +++++++++++++++++++++++----------
  fs/ntfs3/fslog.c   |   4 +-
  fs/ntfs3/fsntfs.c  |  92 +++++++++++++++---------
  fs/ntfs3/index.c   |  33 ++++-----
  fs/ntfs3/inode.c   |  19 ++---
  fs/ntfs3/namei.c   |   6 +-
  fs/ntfs3/ntfs_fs.h |  16 +++--
  fs/ntfs3/record.c  |  27 +------
  fs/ntfs3/run.c     | 108 +++++++++++++++++++++++-----
  fs/ntfs3/super.c   |  17 +++--
  fs/ntfs3/xattr.c   |  35 +++++----
  14 files changed, 835 insertions(+), 329 deletions(-)
