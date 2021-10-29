Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B480E43FCC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJ2M5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 08:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231527AbhJ2M5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B217760295;
        Fri, 29 Oct 2021 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635512119;
        bh=6S42dh5xDanUU4TsiUbc3jqRNzdVkGf5kSXIUYAeo1k=;
        h=Subject:From:To:Cc:Date:From;
        b=cmGGEV7yy+ChtrShjXstBdrZy2tVA8yH7Nn/m86Vl1fzS0n1C/wcjbxqRm0dguc7E
         UoDTHnDWjmRdqtnGbzNM2+ITrjIOQD02UO9BlDbtzBVLhN5Kc5BAQ62aIlVM3DDAkf
         5cEx+/F/hIhx0KgRB7r2QxhBHFtt+UfoCOFMDZ5vE//gtl3p4vSwJRFYhbJs2M3MWP
         T7l08noNryw+z+TawgsFyVHoIljbuBdXlL4kM0tk/40mfr8bK2rD1k3LillPuBi8az
         ee13cFkdmrR5YksHqFU0s+XFhVmYMXxA9jJFQ7ogk0R4dlGTPF8oDUY0xoCrpjqLGE
         yjnBaBDK5otbg==
Message-ID: <44baecaf3d322ef0674b7b9b88026cf18d371d14.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v5.16
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Date:   Fri, 29 Oct 2021 08:55:17 -0400
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit bf9f243f23e6623f310ba03fbb14e10ec3a61290:

  Merge tag '5.15-rc-ksmbd-part2' of git://git.samba.org/ksmbd (2021-09-09 16:17:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.16

for you to fetch changes up to 482e00075d660a16de822686a4be4f7c0e11e5e2:

  fs: remove leftover comments from mandatory locking removal (2021-10-26 12:20:50 -0400)

----------------------------------------------------------------
I know it's a bit early, but I don't expect to take in any more file
locking patches before the merge window opens.

Most of this is just follow-on cleanup work of documentation and
comments from the mandatory locking removal in v5.15. The only real
functional change is that LOCK_MAND flock() support is also being
removed, as it has basically been non-functional since the v2.5 days.
----------------------------------------------------------------
J. Bruce Fields (1):
      locks: remove changelog comments

Jeff Layton (3):
      locks: remove LOCK_MAND flock lock support
      Documentation: remove reference to now removed mandatory-locking doc
      fs: remove leftover comments from mandatory locking removal

Mauro Carvalho Chehab (1):
      docs: fs: locks.rst: update comment about mandatory file locking

 Documentation/filesystems/index.rst |   1 -
 Documentation/filesystems/locks.rst |  17 ++----
 fs/ceph/locks.c                     |   3 --
 fs/gfs2/file.c                      |   2 -
 fs/locks.c                          | 161 +++++++++-----------------------------------------------
 fs/namei.c                          |   4 +-
 fs/nfs/file.c                       |   9 ----
 fs/read_write.c                     |   4 --
 include/uapi/asm-generic/fcntl.h    |   4 ++
 9 files changed, 36 insertions(+), 169 deletions(-)

-- 
Jeff Layton <jlayton@kernel.org>

