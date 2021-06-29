Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10133B722D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhF2Mhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 08:37:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37374 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhF2Mhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:37:47 -0400
Received: from ip5f5bf01b.dynamic.kabel-deutschland.de ([95.91.240.27] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lyCxR-0008Ad-S6; Tue, 29 Jun 2021 12:35:17 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mount_setattr updates
Date:   Tue, 29 Jun 2021 14:35:11 +0200
Message-Id: <20210629123511.1191153-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
A few releases ago the old mount API gained support for a mount options which
prevents following symlinks on a given mount. This adds support for it in the
new mount api through the MOUNT_ATTR_NOSYMFOLLOW flag via mount_setattr() and
fsmount(). With mount_setattr() that flag can even be applied recursively.

There's an additional ack from Ross Zwisler who originally authored the
nosymfollow patch. As I've already had the patches in my for-next I didn't add
his ack explicitly.

/* Testing */
All patches are based on v5.13-rc4 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.nosymfollow.v5.14

for you to fetch changes up to 5990b5d770cbfe2b4254d870240e9863aca421e3:

  tests: test MOUNT_ATTR_NOSYMFOLLOW with mount_setattr() (2021-06-01 15:06:51 +0200)

Please consider pulling these changes from the signed fs.mount_setattr.nosymfollow.v5.14 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.mount_setattr.nosymfollow.v5.14

----------------------------------------------------------------
Christian Brauner (2):
      mount: Support "nosymfollow" in new mount api
      tests: test MOUNT_ATTR_NOSYMFOLLOW with mount_setattr()

 fs/namespace.c                                     |  9 ++-
 include/uapi/linux/mount.h                         |  1 +
 .../selftests/mount_setattr/mount_setattr_test.c   | 88 +++++++++++++++++++++-
 3 files changed, 92 insertions(+), 6 deletions(-)
