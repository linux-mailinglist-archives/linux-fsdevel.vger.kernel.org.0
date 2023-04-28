Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBD6F1278
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjD1HhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345451AbjD1HhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:37:19 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 00:37:00 PDT
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268940FE;
        Fri, 28 Apr 2023 00:36:59 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5EA9B2181;
        Fri, 28 Apr 2023 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1682666720;
        bh=KDYaVo5PyVLtkC6s1yjYte0w6cjpa9PrJoFAS7zuJbA=;
        h=Date:From:Subject:To:CC;
        b=fzeccGUfIw4aI/FHAMCPI6PUHbs0tFSv4oyZ788jZu1KeSTToBTmDF2Kpv2gKNOJm
         9AUAna3Eq1OTWsplnkyU1S+2xfP46C6cdwEIHkZk0a5CVbgkIqECHFmCXCgFSMhpqP
         yP7lgCuVrfASElnhDfRN2P0TcQaTTgk0rVDYtT3Q=
Received: from [192.168.211.149] (192.168.211.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Apr 2023 10:30:02 +0300
Message-ID: <f949c754-6d38-af12-fa83-176e9971132e@paragon-software.com>
Date:   Fri, 28 Apr 2023 11:30:01 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 6.4
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.149]
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

Please pull this branch containing ntfs3 code for 6.4.

Added:
- add missed "nocase" in ntfs_show_options;
- extend information on fails\errors;
- small optimizations.

Fixed:
- some logic errors;
- some dead code was removed;
- code is refactored and
   reformatted according to the new version of clang-format.

Removed:
- noacsrules option. Currently, this option does not work properly.
   Its use leads to unstable results. If we figure out how to implement it
   without errors, we will add it later;
- writepage.

Regards,

Konstantin

----------------------------------------------------------------

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

    Linux 6.3-rc4 (Sun Mar 26 14:40:20 2023 -0700)

are available in the Git repository at:

https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.4

for you to fetch changes up to 788ee1605c2e9feed39c3a749fb3e47c6e15c1b9:

    fs/ntfs3: Fix root inode checking (Mon Feb 20 09:39:35 2023 +0400)

----------------------------------------------------------------

Abdun Nihaal (1):
   fs/ntfs3: Fix NULL dereference in ni_write_inode

Chen Zhongjin (1):
   fs/ntfs3: Fix memory leak if ntfs_read_mft failed

Daniel Pinto (1):
   fs/ntfs3: Fix wrong cast in xattr.c

Edward Lo (3):
   fs/ntfs3: Enhance the attribute size check
   fs/ntfs3: Validate MFT flags before replaying logs
   fs/ntfs3: Add length check in indx_get_root

Jia-Ju Bai (1):
   fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Jiasheng Jiang (1):
   fs/ntfs3: Add check for kmemdup

Konstantin Komarov (17):
   fs/ntfs3: Add null pointer checks
   fs/ntfs3: Improved checking of attribute's name length
   fs/ntfs3: Check for extremely large size of $AttrDef
   fs/ntfs3: Restore overflow checking for attr size in mi_enum_attr
   fs/ntfs3: Refactoring of various minor issues
   fs/ntfs3: Use bh_read to simplify code
   fs/ntfs3: Remove noacsrules
   fs/ntfs3: Fix ntfs_create_inode()
   fs/ntfs3: Optimization in ntfs_set_state()
   fs/ntfs3: Undo endian changes
   fs/ntfs3: Undo critial modificatins to keep directory consistency
   fs/ntfs3: Remove field sbi->used.bitmap.set_tail
   fs/ntfs3: Changed ntfs_get_acl() to use dentry
   fs/ntfs3: Code formatting and refactoring
   fs/ntfs3: Add missed "nocase" in ntfs_show_options
   fs/ntfs3: Print details about mount fails
   fs/ntfs3: Fix root inode checking

Ye Bin (1):
   fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Yu Zhe (1):
   fs/ntfs3: fix spelling mistake "attibute" -> "attribute"

Zeng Heng (1):
   fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()

ZhangPeng (2):
   fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
   fs/ntfs3: Fix OOB read in indx_insert_into_buffer

  Documentation/filesystems/ntfs3.rst |  11 -
  fs/ntfs3/attrib.c                   |  17 +-
  fs/ntfs3/bitmap.c                   |  25 +--
  fs/ntfs3/file.c                     |  50 ++---
  fs/ntfs3/frecord.c                  |  46 ++--
  fs/ntfs3/fslog.c                    |  83 ++++----
  fs/ntfs3/fsntfs.c                   |  84 ++++----
  fs/ntfs3/index.c                    |  81 +++++---
  fs/ntfs3/inode.c                    | 134 ++++++------
  fs/ntfs3/lznt.c                     |  10 +-
  fs/ntfs3/namei.c                    |  19 +-
  fs/ntfs3/ntfs.h                     |   3 -
  fs/ntfs3/ntfs_fs.h                  |  19 +-
  fs/ntfs3/record.c                   |  15 +-
  fs/ntfs3/run.c                      |   6 +-
  fs/ntfs3/super.c                    | 312 ++++++++++++++++------------
  fs/ntfs3/xattr.c                    |  70 +++----
  17 files changed, 528 insertions(+), 457 deletions(-)

