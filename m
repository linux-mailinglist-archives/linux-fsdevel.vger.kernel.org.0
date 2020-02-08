Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A9156817
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 23:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgBHWqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 17:46:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36466 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgBHWqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:46:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0Ys1-009czZ-7I; Sat, 08 Feb 2020 22:46:37 +0000
Date:   Sat, 8 Feb 2020 22:46:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vboxsf
Message-ID: <20200208224637.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vboxsf, with fixups for fs_parse changes folded in.  Identical to what
had been in -next - git diff work.vboxsf merge.nfs-fs_parse comes empty.
It is a rebase (on top of merge.nfs-fs_parse.1), but it's a single commit
and here the tree being identical to what had been tested is all that
matters - feeding it in two chunks (original commit + fixups) would be
completely pointless, IMO.  That should be it for bisect hazards from
fs_parse API changes...

The following changes since commit f35aa2bc809eacc44c3cee41b52cef1c451d4a89:

  tmpfs: switch to use of invalfc() (2020-02-07 14:48:44 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.vboxsf

for you to fetch changes up to 0fd169576648452725fa2949bf391d10883d3991:

  fs: Add VirtualBox guest shared folder (vboxsf) support (2020-02-08 17:34:58 -0500)

----------------------------------------------------------------
Hans de Goede (1):
      fs: Add VirtualBox guest shared folder (vboxsf) support

 MAINTAINERS                 |   6 +
 fs/Kconfig                  |   1 +
 fs/Makefile                 |   1 +
 fs/vboxsf/Kconfig           |  10 +
 fs/vboxsf/Makefile          |   5 +
 fs/vboxsf/dir.c             | 427 +++++++++++++++++++++
 fs/vboxsf/file.c            | 379 +++++++++++++++++++
 fs/vboxsf/shfl_hostintf.h   | 901 ++++++++++++++++++++++++++++++++++++++++++++
 fs/vboxsf/super.c           | 491 ++++++++++++++++++++++++
 fs/vboxsf/utils.c           | 551 +++++++++++++++++++++++++++
 fs/vboxsf/vboxsf_wrappers.c | 371 ++++++++++++++++++
 fs/vboxsf/vfsmod.h          | 137 +++++++
 12 files changed, 3280 insertions(+)
 create mode 100644 fs/vboxsf/Kconfig
 create mode 100644 fs/vboxsf/Makefile
 create mode 100644 fs/vboxsf/dir.c
 create mode 100644 fs/vboxsf/file.c
 create mode 100644 fs/vboxsf/shfl_hostintf.h
 create mode 100644 fs/vboxsf/super.c
 create mode 100644 fs/vboxsf/utils.c
 create mode 100644 fs/vboxsf/vboxsf_wrappers.c
 create mode 100644 fs/vboxsf/vfsmod.h
