Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7472A18AF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEINtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 09:49:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38024 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEINtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 09:49:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so1918850ywe.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Pv4A1zb3Mhb4eOXqAV2Jw7O6xyv/OsFCBFGvqeN0zqs=;
        b=HHkNqnn/eBcsMC8pK3GcAfpYzwH2CltkcpKsVzoPxRfYyMhrf/dJ+yhfay9vPmdrs/
         Ze3bY4KaeOIC39DxPuXWWzP9VTZ3qNCGGwo0T73490+TCcgucO0BMdAncc/j6pzo1C4O
         bOY5wLFlTcWK40idBw2xREOJ5JJbS8SBmdNLEh5h26ggYHEoZ+a+y28mvhev0hmeAfZ+
         bvogyaAbtPHHDEHzmQhb5D1usHsPubX7X1u1UnXO3gcYJ3ArvucmDFKbNuExFrjDp28v
         qfQUTmul4zuzNoVCG1zyDv96ossgB53MZRv+LYroBk6qZaLYp4y/nTOrS4QgvC95n5I2
         +mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Pv4A1zb3Mhb4eOXqAV2Jw7O6xyv/OsFCBFGvqeN0zqs=;
        b=hSM9ZL6hNv7mKFj9HjuWeRMBEYTQLULPlF1l6uvR+0fKYLqUtXoVTLpQieWY8fC9XO
         ojgwS9jHxZeR/iL45gBCi5oZwIPY6MDQI2JxFLHecT/L/bdfaOfaQaw3jwdE6g82Nsqy
         Mjr5Qm7SHUZpKHMw5MLSpufB0pRbubj8JgF9LvbRlJbJtGRP4sOezL/6QyEvWGm3EJ6D
         wEYFEmiusxGiq4AxpQE0BSknN4/glhlPsFH24sLYktFb5U/MPnMT4d9BTjly/GdHEWEd
         BoW3LctsALDWaLO6fKQ8aOqxImBt0G7YbZPxTN5HOVnnUhUrydRvRygRjBaSo+4D1nTw
         JEzw==
X-Gm-Message-State: APjAAAUSIKDMTCukYZK5PWYB+rlSOxY7VKge/3Z4FN+20NusDefIOch4
        N66Polq2RsFXTjJ/bZHlBMZM7LPn3UNQ4T4agtQlnw==
X-Google-Smtp-Source: APXvYqz6WaV9mlVdAtbgxL3AbrGOwGkNPE4qJy3tdO0atez6THn9tbvlOSjzhBD08JPzAE2j/z3LY9hsW1OAJlSI2G0=
X-Received: by 2002:a81:2fd6:: with SMTP id v205mr1891698ywv.205.1557409758423;
 Thu, 09 May 2019 06:49:18 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 9 May 2019 09:49:06 -0400
Message-ID: <CAOg9mSTd0B7m83=+HqJPHMZBOM3fpDtN+_ntXTHhFXV5KMvBPw@mail.gmail.com>
Subject: [GIT PULL] orangefs: pagecache series and one fix
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus...

One of our patches in the pagecache series will conflict with the
orangefs patch in Al's "->free_inode" series...

-Mike Marshall

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.2-ofs1

for you to fetch changes up to 33713cd09ccdc1e01b10d0782ae60200d4989553:

  orangefs: truncate before updating size (2019-05-03 14:39:10 -0400)

----------------------------------------------------------------
Orangefs: This pull request includes one fix and our "Orangefs through
the pagecache" patch series which greatly improves our small IO
performance and helps us pass more xfstests than before.

fix: orangefs: truncate before updating size

Pagecache series: all the rest

----------------------------------------------------------------
Martin Brandenburg (20):
      orangefs: implement xattr cache
      orangefs: do not invalidate attributes on inode create
      orangefs: simplify orangefs_inode_getattr interface
      orangefs: update attributes rather than relying on server
      orangefs: hold i_lock during inode_getattr
      orangefs: set up and use backing_dev_info
      orangefs: let setattr write to cached inode
      orangefs: reorganize setattr functions to track attribute changes
      orangefs: remove orangefs_readpages
      orangefs: service ops done for writeback are not killable
      orangefs: migrate to generic_file_read_iter
      orangefs: implement writepage
      orangefs: do not return successful read when the client-core disappeared
      orangefs: move do_readv_writev to direct_IO
      orangefs: skip inode writeout if nothing to write
      orangefs: avoid fsync service operation on flush
      orangefs: write range tracking
      orangefs: implement writepages
      orangefs: add orangefs_revalidate_mapping
      orangefs: truncate before updating size

Mike Marshall (3):
      orangefs: remember count when reading.
      orangefs: pass slot index back to readpage.
      orangefs: copy Orangefs-sized blocks into the pagecache if possible.

 fs/orangefs/acl.c              |   4 +-
 fs/orangefs/file.c             | 389 ++++++++----------
 fs/orangefs/inode.c            | 914 ++++++++++++++++++++++++++++++++++++-----
 fs/orangefs/namei.c            |  40 +-
 fs/orangefs/orangefs-bufmap.c  |  13 +
 fs/orangefs/orangefs-bufmap.h  |   2 +
 fs/orangefs/orangefs-debugfs.c |   4 +-
 fs/orangefs/orangefs-kernel.h  |  56 ++-
 fs/orangefs/orangefs-mod.c     |   1 +
 fs/orangefs/orangefs-sysfs.c   |  22 +
 fs/orangefs/orangefs-utils.c   | 179 ++++----
 fs/orangefs/super.c            |  39 +-
 fs/orangefs/waitqueue.c        |  18 +-
 fs/orangefs/xattr.c            | 106 ++++-
 14 files changed, 1298 insertions(+), 489 deletions(-)
