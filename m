Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5936C576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhD0LoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:44:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhD0LoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:44:25 -0400
Received: from ip5f5bf209.dynamic.kabel-deutschland.de ([95.91.242.9] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lbM7w-0001JU-VF; Tue, 27 Apr 2021 11:43:41 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs mapping helpers update
Date:   Tue, 27 Apr 2021 13:43:32 +0200
Message-Id: <20210427114332.1713512-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
References: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This adds kernel-doc to all new idmapping helpers and improves their naming
which was triggered by a discussion with some fs developers. Some of the names
are based on suggestions by Vivek and Al. We also remove the open-coded
permission checking in a few places with simple helpers. Overall this should
lead to more clarity make it easier to maintain.

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.helpers.v5.13

for you to fetch changes up to db998553cf11dd697485ac6142adbb35d21fff10:

  fs: introduce two inode i_{u,g}id initialization helpers (2021-03-23 11:15:26 +0100)

/* Testing */
All patches are based on v5.12-rc4 and have been sitting in linux-next. No
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

Please consider pulling these changes from the signed fs.idmapped.helpers.v5.13 tag.

----------------------------------------------------------------
fs.idmapped.helpers.v5.13

----------------------------------------------------------------
Christian Brauner (4):
      fs: document mapping helpers
      fs: document and rename fsid helpers
      fs: introduce fsuidgid_has_mapping() helper
      fs: introduce two inode i_{u,g}id initialization helpers

 fs/ext4/ialloc.c     |   2 +-
 fs/inode.c           |   4 +-
 fs/namei.c           |  11 ++---
 fs/xfs/xfs_inode.c   |  10 ++---
 fs/xfs/xfs_symlink.c |   4 +-
 include/linux/fs.h   | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 135 insertions(+), 20 deletions(-)
