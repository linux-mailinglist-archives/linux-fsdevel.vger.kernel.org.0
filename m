Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572091ED6DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCT0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCT0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:26:20 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA9C08C5C0;
        Wed,  3 Jun 2020 12:26:19 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgZ1j-002dJy-FL; Wed, 03 Jun 2020 19:26:15 +0000
Date:   Wed, 3 Jun 2020 20:26:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] vfs.git work.splice
Message-ID: <20200603192615.GY23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Christoph's assorted splice cleanups.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.splice

for you to fetch changes up to c928f642c29a5ffb02e16f2430b42b876dde69de:

  fs: rename pipe_buf ->steal to ->try_steal (2020-05-20 12:14:10 -0400)

----------------------------------------------------------------
Christoph Hellwig (7):
      fs: simplify do_splice_to
      fs: simplify do_splice_from
      pipe: merge anon_pipe_buf*_ops
      trace: remove tracing_pipe_buf_ops
      fs: make the pipe_buf_operations ->steal operation optional
      fs: make the pipe_buf_operations ->confirm operation optional
      fs: rename pipe_buf ->steal to ->try_steal

 drivers/char/virtio_console.c |  2 +-
 fs/fuse/dev.c                 |  2 +-
 fs/pipe.c                     | 96 ++++++++++---------------------------------
 fs/splice.c                   | 81 +++++++++++++-----------------------
 include/linux/pipe_fs_i.h     | 40 +++++++++---------
 kernel/relay.c                |  7 ++--
 kernel/trace/trace.c          | 11 +----
 net/smc/smc_rx.c              |  8 ----
 8 files changed, 77 insertions(+), 170 deletions(-)
