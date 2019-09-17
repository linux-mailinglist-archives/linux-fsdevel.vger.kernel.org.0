Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAFB4549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 03:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfIQBlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 21:41:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfIQBlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:41:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA2UH-0004mL-FE; Tue, 17 Sep 2019 01:41:01 +0000
Date:   Tue, 17 Sep 2019 02:41:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] work.mount - infrastructure
Message-ID: <20190917014101.GF1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Infrastructure bits of mount API conversions; the rest is
more of per-filesystem patches and it'll go in a separate pull
request.  Requests, actually, since some are (thankfully) in
the individual filesystem trees now (a huge NFS pile, for example).

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base

for you to fetch changes up to 0f071004109d9c8de7023b9a64fa2ba3fa87cbed:

  mtd: Provide fs_context-aware mount_mtd() replacement (2019-09-05 14:34:23 -0400)

----------------------------------------------------------------
Al Viro (1):
      new helper: get_tree_keyed()

David Howells (2):
      vfs: Create fs_context-aware mount_bdev() replacement
      mtd: Provide fs_context-aware mount_mtd() replacement

Eric Biggers (1):
      vfs: set fs_context::user_ns for reconfigure

 drivers/mtd/mtdcore.h      |   1 +
 drivers/mtd/mtdsuper.c     | 179 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fs_context.c            |   4 +-
 fs/nfsd/nfsctl.c           |   3 +-
 fs/proc/root.c             |   3 +-
 fs/super.c                 | 104 ++++++++++++++++++++++++++
 include/linux/fs_context.h |  12 ++-
 include/linux/mtd/super.h  |   3 +
 ipc/mqueue.c               |   3 +-
 net/sunrpc/rpc_pipe.c      |   3 +-
 10 files changed, 301 insertions(+), 14 deletions(-)
