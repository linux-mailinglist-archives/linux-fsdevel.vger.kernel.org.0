Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EB53C947
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiFCL1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCL1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:27:04 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBB13D44;
        Fri,  3 Jun 2022 04:26:59 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 49AEC2698;
        Fri,  3 Jun 2022 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654255584;
        bh=HVPX9ugwZpjN4d10W+xJnrpqV9wwOQw9BPCuiHwX/Z4=;
        h=Date:To:CC:From:Subject;
        b=XsmIGJkbYCZ/8M03RLAOCj60tGHjaZZ4KYoBL30IENFRY8HO6vvRAvdPppu2Le/qX
         szw96Y1ikALRSYczYTpcb/3JtYAaUlw/cRSWAi1GPVXk9Yuh/601qhJVYMbZCeQgZd
         0pzI+fbueqaKRPf6g26GluIBZziY5AaDvC1fhb+Q=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 3 Jun 2022 14:26:57 +0300
Message-ID: <c5c16f3d-c8a7-96b0-4fd6-056c4159fcef@paragon-software.com>
Date:   Fri, 3 Jun 2022 14:26:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 5.19
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing ntfs3 code for 5.19.

Fixed:
- some memory leaks and panic;
- fixed xfstests (tested on x86_64)
generic/092 generic/099 generic/228 generic/240 generic/307 generic/444;
- bugfix (memory leak) for 5.18 [1];
- some typos, dead code, etc.

Most of the code was in linux-next branch for several months,
but there are some patches, that were in linux-next branch only
for a couple of days. Hopefully it is ok - no regression
was detected in tests.

Note: after first 9 commits there was merge with Linux 5.18.
I'm not sure if this complicates things, so I've listed all commits too.

Regards,

Konstantin

[1]: https://www.spinics.net/lists/ntfs3/msg01036.html

----------------------------------------------------------------

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

   Linux 5.15 (Sun Oct 31 13:53:10 2021 -0700)

are available in the Git repository at:

   https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_5.19

for you to fetch changes up to 724bbe49c5e427cb077357d72d240a649f2e4054:

   fs/ntfs3: provide block_invalidate_folio to fix memory leak (Mon May 30 13:36:45 2022 +0200)

All commits:

724bbe49c5e4 fs/ntfs3: provide block_invalidate_folio to fix memory leak
f26967b9f7a8 fs/ntfs3: Fix invalid free in log_replay
< merge with 5.18 happened >
52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUEUED
114346978cf6 fs/ntfs3: Check new size for limits
3880f2b816a7 fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)
9186d472ee78 fs/ntfs3: In function ntfs_set_acl_ex do not change inode->i_mode if called from function ntfs_init_acl
3a2154b25a9f fs/ntfs3: Optimize locking in ntfs_save_wsl_perm
2d44667c306e fs/ntfs3: Update i_ctime when xattr is added
87e21c99bad7 fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions
e95113ed4d42 fs/ntfs3: Keep preallocated only if option prealloc enabled
e589f9b7078e fs/ntfs3: Fix some memory leaks in an error handling path of 'log_replay()'

----------------------------------------------------------------

Konstantin Komarov (8)
  fs/ntfs3: Update valid size if -EIOCBQUEUED
  fs/ntfs3: Check new size for limits
  fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)
  fs/ntfs3: In function ntfs_set_acl_ex do not change inode->i_mode if called from function ntfs_init_acl
  fs/ntfs3: Optimize locking in ntfs_save_wsl_perm
  fs/ntfs3: Update i_ctime when xattr is added
  fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions
  fs/ntfs3: Keep preallocated only if option prealloc enabled

Mikulas Patocka (1)
  fs/ntfs3: provide block_invalidate_folio to fix memory leak

Namjae Jeon (1)
  fs/ntfs3: Fix invalid free in log_replay

Christophe JAILLET (1)
  fs/ntfs3: Fix some memory leaks in an error handling path of 'log_replay()'

  fs/ntfs3/file.c    |  12 +++++++++---
  fs/ntfs3/frecord.c |  10 +++++++---
  fs/ntfs3/fslog.c   |  12 +++++++-----
  fs/ntfs3/inode.c   |   9 ++++++--
  fs/ntfs3/xattr.c   | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
  5 files changed, 149 insertions(+), 30 deletions(-)
