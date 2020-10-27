Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92B429C998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830816AbgJ0UEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 16:04:52 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34855 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830738AbgJ0UEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:04:42 -0400
Received: by mail-qt1-f179.google.com with SMTP id s39so1516696qtb.2;
        Tue, 27 Oct 2020 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=lvuf5x8xcoXRYshPqfLRH/YVfKsc4H7qY+zmPxOGIK8=;
        b=FxMWDI+lQh0MrUwTHrAHfdAufCHSDnCSesOqfaYyDiKKZFbyfAXbnNCm0ykDiK0gfz
         /xywBhAW0MOcguqgYSElBc7bqCLYG2X5LE2g1NVJ9qay/w4xJsp/noGSuMeFhzB3N8dK
         W7VgziDbsNuheDGpeAMIiaDrycb4XWp3FCejAgUrFwg/58ZdTlaqE2U8/AseOCvwZnc7
         uV/XdV2XOxIfKeBUmc0e0yLBK682Y65tXMRoZNU4+uppbFzXJAISo7ZvHgyAYPaj4pbD
         RWacdVFPKcwvmYfHOqv5yH6PrOB8BTEe+CtgD1yTat0mT2C/8r1gO/TU6mMOs1w4a3Z3
         +NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=lvuf5x8xcoXRYshPqfLRH/YVfKsc4H7qY+zmPxOGIK8=;
        b=J8qkK4u54nvyGiVbnNvroUoBpGW5UQq4u0mR+sy1Qx7A4u40+RK0N4R8+4e5sb2CC1
         MsDXAfgmBRTfj7IndbokyAVWwQ+bzPJ8xljY64kI3OTfNDMtsUpxG7ffpfYae1mZhJ1l
         iQbOAI/ZEFscA9LZ0aFyIhBGEeMU74F5JXYQgxQxqknW/S0I0S9ik/3cE9+Zc3vRi8pV
         uPyNOsFhrht8xCPr+9S7v0Htkjv8cs0CbqCC5CJuvzVtgQq5laI0JMFv+fVZg/UynTkz
         FtJTK3WuIJOzgioh3ddR6S8d59SBnE2fK41t9YmOJaK4k1mK5pp4umGjyx3OQO27pb+P
         CH6g==
X-Gm-Message-State: AOAM532i+e4gJg2te7naCnYKOdjnaC8uD1WxzvcMn1v1htgQOH0jb/GP
        r0HNwzd8wnGouv0a5APQLs8mobAYxHge
X-Google-Smtp-Source: ABdhPJzoIVpuOqJj2H2LGYm/xV7sRAOv60TEildIugmCXpoRnbePKbgVBPFxKZe+5KSwYU2JDtmUAQ==
X-Received: by 2002:ac8:7955:: with SMTP id r21mr3813632qtt.204.1603829079943;
        Tue, 27 Oct 2020 13:04:39 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id y3sm1549327qto.2.2020.10.27.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:04:39 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:04:33 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: bcachefs-for-review
Message-ID: <20201027200433.GA449905@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's where bcachefs is at and what I'd like to get merged:

https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-review

Non bcachefs prep patches:

      Compiler Attributes: add __flatten
      locking: SIX locks (shared/intent/exclusive)
      mm: export find_get_pages_range()
      mm: Add a mechanism to disable faults for a specific mapping
      mm: Bring back vmalloc_exec
      fs: insert_inode_locked2()
      fs: factor out d_mark_tmpfile()
      block: Add some exports for bcachefs
      block: Add blk_status_to_str()
      bcache: move closures to lib/
      closures: closure_wait_event()

 block/bio.c                                    |   2 +
 block/blk-core.c                               |  13 +-
 drivers/md/bcache/Kconfig                      |  10 +-
 drivers/md/bcache/Makefile                     |   4 +-
 drivers/md/bcache/bcache.h                     |   2 +-
 drivers/md/bcache/super.c                      |   1 -
 drivers/md/bcache/util.h                       |   3 +-
 fs/dcache.c                                    |  10 +-
 fs/inode.c                                     |  40 ++
 include/linux/blkdev.h                         |   1 +
 {drivers/md/bcache => include/linux}/closure.h |  39 +-
 include/linux/compiler_attributes.h            |   5 +
 include/linux/dcache.h                         |   1 +
 include/linux/fs.h                             |   1 +
 include/linux/sched.h                          |   1 +
 include/linux/six.h                            | 197 +++++++++
 include/linux/vmalloc.h                        |   1 +
 init/init_task.c                               |   1 +
 kernel/Kconfig.locks                           |   3 +
 kernel/locking/Makefile                        |   1 +
 kernel/locking/six.c                           | 553 +++++++++++++++++++++++++
 kernel/module.c                                |   4 +-
 lib/Kconfig                                    |   3 +
 lib/Kconfig.debug                              |   9 +
 lib/Makefile                                   |   2 +
 {drivers/md/bcache => lib}/closure.c           |  35 +-
 mm/filemap.c                                   |   1 +
 mm/gup.c                                       |   7 +
 mm/nommu.c                                     |  18 +
 mm/vmalloc.c                                   |  21 +
 30 files changed, 937 insertions(+), 52 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (94%)
 create mode 100644 include/linux/six.h
 create mode 100644 kernel/locking/six.c
 rename {drivers/md/bcache => lib}/closure.c (89%)

New since last posting that's relevant to the rest of the kernel:
 - Re: the DIO cache coherency issue, we finally have a solution that hopefully
   everyone will find palatable. We no longer try to do any fancy recursive
   locking stuff: if userspace issues a DIO read/write where the buffer points
   to the same address space as the file being read/written to, we just return
   an error.

   This requires a small change to gup.c, to add the check after the VMA lookup.
   My patch passes the mapping to check against via a new task_struct member,
   which is ugly because plumbing a new argument all the way to __get_user_pages
   is also going to be ugly and if I have to do that I'm likely to go on a
   refactoring binge, which gup.c looks like it needs anyways.

 - vmalloc_exec() is needed because bcachefs dynamically generates x86 machine
   code - per btree node unpack functions.

Bcachefs changes since last posting:
 - lots
 - reflink is done
 - erasure coding (reed solomon raid5/6) is maturing; I have declared it ready
   for beta testers and gotten some _very_ positive feedback on its performance.
 - btree key cache code is done and merged, big improvements to multithreaded
   write workloads
 - inline data extents
 - major improvements to how the btree code handles extents (still todo:
   re-implement extent merging)
 - huge improvements to mount/unmount times on huge filesystems
 - many, many bugfixes; bug reports are slowing and the bugs that are being
   reported look less and less concerning. In particular repair code is getting
   better and more polished.

TODO:
 - scrub, repair of replicated data when one of the replicas fail the checksum
   check
 - erasure coding needs repair code (it'll do reconstruct reads, but we don't
   have code to rewrite bad blocks in a stripe yet. this is going to be a hassle
   until we get backpointers)
 - fsck isn't checking refcounts of reflinked extents yet
 - bcachefs tests in ktest need to be moved to xfstests
 - user docs are still very minimal

So that's roughly where things are at. I think erasure coding is going to to be
bcachefs's killer feature (or at least one of them), and I'm pretty excited
about it: it's a completely new approach unlike ZFS and btrfs, no write hole (we
don't update existing stripes in place) and we don't have to fragment writes
either like ZFS does. Add to that the caching that we already do and it's
turning into a pretty amazing tool for managing a whole bunch of mixed storage.
