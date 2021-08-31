Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD823FC563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhHaKEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:04:02 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53064
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234263AbhHaKEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:04:02 -0400
Received: from wittgenstein.fritz.box (i577BC18B.versanet.de [87.123.193.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 281203F355;
        Tue, 31 Aug 2021 10:03:06 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] idmapped updates
Date:   Tue, 31 Aug 2021 12:02:52 +0200
Message-Id: <20210831100252.2298022-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
The bulk of the idmapped work this cycle is adding support for idmapped mounts
to btrfs. While this required the addition of a (simple) new vfs helper all the
work is going through David Sterba's btrfs tree. It was way simpler to do it
this way rather then forcing David to coordinate between his btrfs and my tree.
Plus I don't care who merges it as long as I feel I can trust the maintainer
and the btrfs folks were really fast and helpful in reviewing this work.
As always, associated with the btrfs port for idmapped mounts is a new fstests
extension specifically concerned with btrfs ioctls (e.g. subvolume creation,
deletion etc.) on idmapped mounts which can be found in the fstests repo as
5f8179ce8b00 ("btrfs: introduce btrfs specific idmapped mounts tests").

Consequently, this PR should hopefully be boring. It only contains
documentation updates, specifically about how idmappings and idmapped mounts
work.

(In case any question come up I'll be on vacation next week so responding might
take a while.)

/* Testing */
All patches are based on v5.14-rc3 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.15

for you to fetch changes up to ad19607a90b29eef044660aba92a2a2d63b1e977:

  doc: give a more thorough id handling explanation (2021-08-11 15:28:32 +0200)

Please consider pulling these changes from the signed fs.idmapped.v5.15 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.v5.15

----------------------------------------------------------------
Christian Brauner (1):
      doc: give a more thorough id handling explanation

 Documentation/filesystems/idmappings.rst | 1026 ++++++++++++++++++++++++++++++
 Documentation/filesystems/index.rst      |    1 +
 2 files changed, 1027 insertions(+)
 create mode 100644 Documentation/filesystems/idmappings.rst
