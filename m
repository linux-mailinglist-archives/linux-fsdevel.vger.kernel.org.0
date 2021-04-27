Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA836C56A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhD0LkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:40:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60709 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhD0LkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:40:17 -0400
Received: from ip5f5bf209.dynamic.kabel-deutschland.de ([95.91.242.9] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lbM3t-00013F-AD; Tue, 27 Apr 2021 11:39:29 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs helper kernel-doc update
Date:   Tue, 27 Apr 2021 13:38:46 +0200
Message-Id: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
After last cycles changes we missed to update the kernel-docs in some places
that were changed during the idmapped mount work. Lukas and Randy took the
chance to not just fixup those places but also fixup and expand kernel-docs for
some additional helpers.

There are no functional changes in this PR which is why I split it out from the
following one.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.docs.v5.13

for you to fetch changes up to 92cb01c74ef13ca01e1af836236b140634967b82:

  fs: update kernel-doc for vfs_rename() (2021-03-23 11:20:26 +0100)

/* Testing */
All patches are based on v5.12-rc2 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 f2-vm 5.12.0-rc6-idmapped-cfebad8730dd #387 SMP PREEMPT Tue Apr 27 10:39:29 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/633 files ...  27s
xfs/152 files ...  68s
xfs/153 files ...  36s
Ran: generic/633 xfs/152 xfs/153
Passed all 3 tests

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

(Note, in case you care about this at all I changed my tag naming pattern
 simply because I ran into limitations with branch naming in git using "/"
 separators and I like to have a 1:1 correspondence between the branch and the
 tag name.)

Please consider pulling these changes from the signed fs.idmapped.docs.v5.13 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.docs.v5.13

----------------------------------------------------------------
Christian Brauner (1):
      fs: update kernel-doc for vfs_rename()

Lukas Bulwahn (1):
      fs: turn some comments into kernel-doc

Randy Dunlap (3):
      libfs: fix kernel-doc for mnt_userns
      namei: fix kernel-doc for struct renamedata and more
      xattr: fix kernel-doc for mnt_userns and vfs xattr helpers

 fs/libfs.c         |  1 +
 fs/namei.c         | 14 +++-----------
 fs/xattr.c         | 14 ++++++++------
 include/linux/fs.h | 17 ++++++++++++++---
 4 files changed, 26 insertions(+), 20 deletions(-)
