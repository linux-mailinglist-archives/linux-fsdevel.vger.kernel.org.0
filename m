Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4C7704E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHDPfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHDPfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589F49C1;
        Fri,  4 Aug 2023 08:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67406207B;
        Fri,  4 Aug 2023 15:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3773FC433C8;
        Fri,  4 Aug 2023 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163307;
        bh=RDuQ6BFz6FjCEa7dptK+gtGahorGZqzLPlS+eNT8jD0=;
        h=Date:From:To:Cc:Subject:From;
        b=fPe2gtxwqjZKONolCDlEHeSh5Bxysh5wmVDQPH3PtegmZJecg+dfaGm2dXaGX2gMF
         7K9y29D/EUCvj1+xdteGKOWUICylHv9hdsIxNKtQPPPt3UE4jogXE4qtGzb4VDJJ2R
         rYb14PWj+WUaXwJOIHs9TctfQjfVfBPAw0D1YO7xwYxyP5Pkp60DpoI8/UqfBZ+uQq
         G0g8ukaUwH1ygOV7v2pG46WMerlL3Nmj3UzZf8ClRLHWclw0ufuTFl/Lc5J4IrLBR5
         Prw7UXLrY571cIES+MH6J3WNZztZheMPvhljGEnrxqYKVwqlsiFJ7ymJIqDLSvAmiy
         ra7g5eVoMjjmg==
Date:   Fri, 4 Aug 2023 08:35:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org
Cc:     araherle@in.ibm.com, axboe@kernel.dk, bfoster@redhat.com,
        dchinner@redhat.com, hch@lst.de, kent.overstreet@linux.dev,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: iomap-6.6-merge updated to 377698d4abe2
Message-ID: <169116323722.3196986.2567390238428391540.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This is everything that I plan to push for iomap for
6.6.

The new head of the iomap-for-next branch is commit:

377698d4abe2 Merge tag 'xfs-async-dio.6-2023-08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA

29 new commits:

Darrick J. Wong (3):
[d42bd17c6a20] Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge
[a67371b7aee9] Merge tag 'iomap-per-block-dirty-tracking' of https://github.com/riteshharjani/linux into iomap-6.6-merge
[377698d4abe2] Merge tag 'xfs-async-dio.6-2023-08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA

Jens Axboe (8):
[3486237c6fe8] iomap: cleanup up iomap_dio_bio_end_io()
[44842f647346] iomap: use an unsigned type for IOMAP_DIO_* defines
[3a0be38cc84d] iomap: treat a write through cache the same as FUA
[daa99c5a3319] iomap: only set iocb->private for polled bio
[7b3c14d1a96b] iomap: add IOMAP_DIO_INLINE_COMP
[9cf3516c29e6] fs: add IOCB flags related to passing back dio completions
[099ada2c8726] io_uring/rw: add write support for IOCB_DIO_CALLER_COMP
[8c052fb3002e] iomap: support IOCB_DIO_CALLER_COMP

Matthew Wilcox (Oracle) (10):
[f7f9a0c8736d] iov_iter: Map the page later in copy_page_from_iter_atomic()
[908a1ad89466] iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
[1b0306981e0f] iov_iter: Add copy_folio_from_iter_atomic()
[a221ab717c43] iomap: Remove large folio handling in iomap_invalidate_folio()
[32b29cc9db45] doc: Correct the description of ->release_folio
[7a8eb01b078f] iomap: Remove unnecessary test from iomap_release_folio()
[ffc143db63ee] filemap: Add fgf_t typedef
[4f6617011910] filemap: Allow __filemap_get_folio to allocate large folios
[d6bb59a9444d] iomap: Create large folios in the buffered write path
[5d8edfb900d5] iomap: Copy larger chunks from userspace

Ritesh Harjani (IBM) (8):
[04f52c4e6f80] iomap: Rename iomap_page to iomap_folio_state and others
[3ea5c76cadee] iomap: Drop ifs argument from iomap_set_range_uptodate()
[cc86181a3b76] iomap: Add some uptodate state handling helpers for ifs state bitmap
[eee2d2e6ea55] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
[0af2b37d8e7a] iomap: Use iomap_punch_t typedef
[7f79d85b525b] iomap: Refactor iomap_write_delalloc_punch() function out
[a01b8f225248] iomap: Allocate ifs in ->write_begin() early
[4ce02c679722] iomap: Add per-block dirty state tracking to improve performance

Code Diffstat:

Documentation/filesystems/locking.rst |  15 +-
fs/btrfs/file.c                       |   6 +-
fs/f2fs/compress.c                    |   2 +-
fs/f2fs/f2fs.h                        |   2 +-
fs/gfs2/aops.c                        |   2 +-
fs/gfs2/bmap.c                        |   2 +-
fs/iomap/buffered-io.c                | 469 +++++++++++++++++++++++-----------
fs/iomap/direct-io.c                  | 161 +++++++++---
fs/xfs/xfs_aops.c                     |   2 +-
fs/zonefs/file.c                      |   2 +-
include/linux/fs.h                    |  35 ++-
include/linux/iomap.h                 |   3 +-
include/linux/pagemap.h               |  82 +++++-
include/linux/uio.h                   |   9 +-
io_uring/rw.c                         |  27 +-
lib/iov_iter.c                        |  43 ++--
mm/filemap.c                          |  65 ++---
mm/folio-compat.c                     |   2 +-
mm/readahead.c                        |  13 -
19 files changed, 660 insertions(+), 282 deletions(-)
