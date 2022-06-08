Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F07543CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiFHT25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiFHT2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:28:55 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555B1BD7DF
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 12:28:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 19so643456iou.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=h2mY7zyA+c+kuW/DDyFyJfUWlPLOwaWAWYWQmgpX/Gw=;
        b=jdpEYD+6M+egLvpU/ufa7xp2OQwmX/41oSYCWVA10Sepi/dwj6tVibKNI27+DqXNg0
         C1ww3fXwgeBicYi71ZrY8T4FLUq5hNLpdbUuleSoYaQ6Ig2uGdzLlWAV7CoH/Y1e1uUy
         Hz0kC0XUO6tz/UnKYOqKxCbEtfLB+dCvm/Cs7A1qm+fjDlK0usQa/1vY7pqHDHOa4c80
         G2hrvg1YOYJ+8z0OS5i9R297LaLvDK29dJYkO6d6XsrzQl4A5qt7SgPCRllwiwAfu7Ec
         djGF3UMdzkQLOdW4xI+Xykj8nl9v6/uy4P95YVM/ydUtgrsY/jSKA+Q0nMlF1j4bczJc
         SZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=h2mY7zyA+c+kuW/DDyFyJfUWlPLOwaWAWYWQmgpX/Gw=;
        b=FjH02jxwzGE1fYQIRN/kiqSwg7W87DpEqfV48FwJYisr0rvgCEC4C9BQm6NGK2j9Ug
         O0fwdSTLoTI60lRsgqxxJKwcqbbIA7HrAD62E2ICWVar1Mx5wzyV0Na85LD9lpq1cK8o
         1FMTlS5Ub8y3vU+Xg8zQLk2UboTr0tU4YRb8ZxTw+L/TPphjdsXvvG6TCWnTp5+rGSng
         ZH+3jyfWyTNCwr/abjeTp7pcSuqfUPmMAw+bgKusA0BXVwJhwFncIvzz6WIxUm6G1jb1
         yzwREw0i0Z0U8wtxN5XdHNSdrU9QKJZWZO2G3nGdVe1gdD/gsJqMDkrshJbZGn0rv3sV
         RhFQ==
X-Gm-Message-State: AOAM532Xquvu3+ZUpCfl0IhLtsAwtOCRekTbeB/1LrsKCrU1NmWeMUe2
        a+73fytWo6jgCGz5+B8srVQg9JxK/ThXUX3DowXbQ6N4iZQ=
X-Google-Smtp-Source: ABdhPJzwR1tPvCBisbGcaIXCsEJrFqxusESkmIp2aisOk/cxck4BYazSw0v9r8+bnHbeSv24WLz7PLgiJgmAHlhPqg4=
X-Received: by 2002:a05:6638:25d3:b0:32e:e5ee:496c with SMTP id
 u19-20020a05663825d300b0032ee5ee496cmr19225349jat.52.1654716534186; Wed, 08
 Jun 2022 12:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 8 Jun 2022 21:28:18 +0200
Message-ID: <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
Subject: Re: [RFC][PATCHES] iov_iter stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 6:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Rebased to -rc1 and reordered.  Sits in vfs.git #work.iov_iter,
> individual patches in followups
>
> 1/9: No need of likely/unlikely on calls of check_copy_size()
>         not just in uio.h; the thing is inlined and it has unlikely on
> all paths leading to return false
>
> 2/9: btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression
>         new flag for iomap_dio_rw(), telling it to suppress generic_write_sync()
>
> 3/9: struct file: use anonymous union member for rcuhead and llist
>         "f_u" might have been an amusing name, but... we expect anon unions to
> work.
>
> 4/9: iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
>         makes iocb_flags() much cheaper, and it's easier to keep track of
> the places where it can change.
>
> 5/9: keep iocb_flags() result cached in struct file
>         that, along with the previous commit, reduces the overhead of
> new_sync_{read,write}().  struct file doesn't grow - we can keep that
> thing in the same anon union where rcuhead and llist live; that field
> gets used only before ->f_count reaches zero while the other two are
> used only after ->f_count has reached zero.
>
> 6/9: copy_page_{to,from}_iter(): switch iovec variants to generic
>         kmap_local_page() allows that.  And it kills quite a bit of
> code.
>
> 7/9: new iov_iter flavour - ITER_UBUF
>         iovec analogue, with single segment.  That case is fairly common and it
> can be handled with less overhead than full-blown iovec.
>
> 8/9: switch new_sync_{read,write}() to ITER_UBUF
>         ... and this is why it is so common.  Further reduction of overhead
> for new_sync_{read,write}().
>
> 9/9: iov_iter_bvec_advance(): don't bother with bvec_iter
>         AFAICS, variant similar to what we do for iovec/kvec generates better
> code.  Needs profiling, obviously.
>

I have pulled this on top of Linux v5.19-rc1... plus assorted patches
to fix issues with LLVM/Clang version 14.
No (new) warnings in my build-log.
Boots fine on bare metal on my Debian/unstable AMD64 system.

Any hints for testing - to see improvements?

-Sedat-

> Diffstat:
>  arch/powerpc/include/asm/uaccess.h |   2 +-
>  arch/s390/include/asm/uaccess.h    |   4 +-
>  block/fops.c                       |   8 +-
>  drivers/nvme/target/io-cmd-file.c  |   2 +-
>  fs/aio.c                           |   2 +-
>  fs/btrfs/file.c                    |  19 +--
>  fs/btrfs/inode.c                   |   2 +-
>  fs/ceph/file.c                     |   2 +-
>  fs/cifs/file.c                     |   2 +-
>  fs/direct-io.c                     |   4 +-
>  fs/fcntl.c                         |   1 +
>  fs/file_table.c                    |  17 +-
>  fs/fuse/dev.c                      |   4 +-
>  fs/fuse/file.c                     |   4 +-
>  fs/gfs2/file.c                     |   2 +-
>  fs/io_uring.c                      |   2 +-
>  fs/iomap/direct-io.c               |  24 +--
>  fs/nfs/direct.c                    |   2 +-
>  fs/open.c                          |   1 +
>  fs/read_write.c                    |   6 +-
>  fs/zonefs/super.c                  |   2 +-
>  include/linux/fs.h                 |  21 ++-
>  include/linux/iomap.h              |   2 +
>  include/linux/uaccess.h            |   4 +-
>  include/linux/uio.h                |  41 +++--
>  lib/iov_iter.c                     | 308 +++++++++++--------------------------
>  mm/shmem.c                         |   2 +-
>  27 files changed, 191 insertions(+), 299 deletions(-)
