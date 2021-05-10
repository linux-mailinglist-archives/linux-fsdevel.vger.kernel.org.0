Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC60379505
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhEJRJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhEJRJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 13:09:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB57FC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:08:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n16so9455722plf.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5P3qhusnpFGwzP6r9B/unqJvsyx8ESPzIYEdQAMnutI=;
        b=XNQaFJ8S56PFZwEeFv5iimMPmvgqC4JI9xB+cYiXBbuiBvnwR0axo1mEIFJmmlxQ/A
         R8zBB1o61qRO1739nBHaJDFJhGUJstuV6y/OyQ3VgW3JRS7gTI/l3oanEZhL25iMtulo
         KQGFSK+BLASDhJ5P5YlrxNqCMK3Evoh8L7B0QRnNlH9nhD8vVhI2WLCOaSvmDjV6adhQ
         HIBtJhXQGiee7r8gv+GytnOD8JCYELLTYVa4H6twQKdECvEp5ZOixY0eg2k9csp4T923
         X6WxaqiFrouhMyu8uua+OmBRyyUj7JrEeinZszmNqkXRYiLr3AD+1qCaOF/yT2LUZSwB
         kYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5P3qhusnpFGwzP6r9B/unqJvsyx8ESPzIYEdQAMnutI=;
        b=qj3z7V9fcr/BRMiHY8i1UyuUWAYvTnMQKLo4XG9AcMsbnhiKPbob3vIgD82HOgkWZ6
         Ce24fwnaAU/Quka/HbnbKQeq2t9IvL3rycoqjbAbdsir6cH4qPkL2C1XC5zCagpP44RO
         6WFsZ3Ed0gI6KSTygT99PDAS5DioWzkMo69HAGpIbqtTCKlRbPP1eBuibpfwV86qNxfw
         5lsnTkq1e1zRLkSl32nvLcXiodATfn8agk4wxXrsI5vq6rN39sikh5skLiiQIVf4FPZr
         lhVD9hNho8PT4p6oypfcuuvv1OqtFJIhXUU79ZDNRxaQsr3GF7MYFOAhZh2HyWrWIZMk
         rkBQ==
X-Gm-Message-State: AOAM531dpEpkZIjyvMPvszTafvZz8sWYLU/k17GBh2XTyzT7JjCr3a/T
        B5Hi7xWabWyWWx753aPf5FwMHnNwO3yvWg==
X-Google-Smtp-Source: ABdhPJyqUI6xiNJq0jn+2E9x2VbJQDuG0OR/NLTiGA0ooRyJqBVH4QcuOlA0k1nYvd0ATURENmHunw==
X-Received: by 2002:a17:902:7441:b029:ef:46ba:649 with SMTP id e1-20020a1709027441b02900ef46ba0649mr2379899plt.66.1620666530560;
        Mon, 10 May 2021 10:08:50 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::e086])
        by smtp.gmail.com with ESMTPSA id u17sm11366173pfm.113.2021.05.10.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:08:49 -0700 (PDT)
Date:   Mon, 10 May 2021 10:08:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH RESEND v9 0/9] fs: interface for directly reading/writing
 compressed data
Message-ID: <YJlooKWNIen2VRou@relinquished.localdomain>
References: <cover.1619463858.git.osandov@fb.com>
 <YJGBR5SnnQeJdIb1@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJGBR5SnnQeJdIb1@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 04, 2021 at 10:15:51AM -0700, Omar Sandoval wrote:
> On Mon, Apr 26, 2021 at 12:06:03PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This series adds an API for reading compressed data on a filesystem
> > without decompressing it as well as support for writing compressed data
> > directly to the filesystem. I have test cases (including fsstress
> > support) and example programs which I'll send up once the dust settles
> > [1].
> > 
> > The main use-case is Btrfs send/receive: currently, when sending data
> > from one compressed filesystem to another, the sending side decompresses
> > the data and the receiving side recompresses it before writing it out.
> > This is wasteful and can be avoided if we can just send and write
> > compressed extents. The patches implementing the send/receive support
> > were sent with the last submission of this series [2].
> > 
> > Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> > are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> > patch 9 adds Btrfs encoded write support.
> > 
> > These patches are based on Dave Sterba's Btrfs misc-next branch [3],
> > which is in turn currently based on v5.12-rc8.
> > 
> > This is a resend of v9 [4], rebased on the latest kdave/misc-next
> > branch.
> > 
> > Omar Sandoval (9):
> >   iov_iter: add copy_struct_from_iter()
> >   fs: add O_ALLOW_ENCODED open flag
> >   fs: add RWF_ENCODED for reading/writing compressed data
> >   btrfs: don't advance offset for compressed bios in
> >     btrfs_csum_one_bio()
> >   btrfs: add ram_bytes and offset to btrfs_ordered_extent
> >   btrfs: support different disk extent size for delalloc
> >   btrfs: optionally extend i_size in cow_file_range_inline()
> >   btrfs: implement RWF_ENCODED reads
> >   btrfs: implement RWF_ENCODED writes
> > 
> > 1: https://github.com/osandov/xfstests/tree/rwf-encoded
> > 2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
> > 3: https://github.com/kdave/btrfs-devel/tree/misc-next
> > 4: https://lore.kernel.org/linux-btrfs/cover.1617258892.git.osandov@fb.com/
> > 
> > Omar Sandoval (9):
> >   iov_iter: add copy_struct_from_iter()
> >   fs: add O_ALLOW_ENCODED open flag
> >   fs: add RWF_ENCODED for reading/writing compressed data
> >   btrfs: don't advance offset for compressed bios in
> >     btrfs_csum_one_bio()
> >   btrfs: add ram_bytes and offset to btrfs_ordered_extent
> >   btrfs: support different disk extent size for delalloc
> >   btrfs: optionally extend i_size in cow_file_range_inline()
> >   btrfs: implement RWF_ENCODED reads
> >   btrfs: implement RWF_ENCODED writes
> > 
> >  Documentation/filesystems/encoded_io.rst | 240 ++++++
> >  Documentation/filesystems/index.rst      |   1 +
> >  arch/alpha/include/uapi/asm/fcntl.h      |   1 +
> >  arch/parisc/include/uapi/asm/fcntl.h     |   1 +
> >  arch/sparc/include/uapi/asm/fcntl.h      |   1 +
> >  fs/btrfs/compression.c                   |  12 +-
> >  fs/btrfs/compression.h                   |   6 +-
> >  fs/btrfs/ctree.h                         |   9 +-
> >  fs/btrfs/delalloc-space.c                |  18 +-
> >  fs/btrfs/file-item.c                     |  35 +-
> >  fs/btrfs/file.c                          |  46 +-
> >  fs/btrfs/inode.c                         | 929 +++++++++++++++++++++--
> >  fs/btrfs/ordered-data.c                  | 124 +--
> >  fs/btrfs/ordered-data.h                  |  25 +-
> >  fs/btrfs/relocation.c                    |   4 +-
> >  fs/fcntl.c                               |  10 +-
> >  fs/namei.c                               |   4 +
> >  fs/read_write.c                          | 168 +++-
> >  include/linux/encoded_io.h               |  17 +
> >  include/linux/fcntl.h                    |   2 +-
> >  include/linux/fs.h                       |  13 +
> >  include/linux/uio.h                      |   1 +
> >  include/uapi/asm-generic/fcntl.h         |   4 +
> >  include/uapi/linux/encoded_io.h          |  30 +
> >  include/uapi/linux/fs.h                  |   5 +-
> >  lib/iov_iter.c                           |  91 +++
> >  26 files changed, 1563 insertions(+), 234 deletions(-)
> >  create mode 100644 Documentation/filesystems/encoded_io.rst
> >  create mode 100644 include/linux/encoded_io.h
> >  create mode 100644 include/uapi/linux/encoded_io.h
> 
> Ping.

Ping. Al, I originally sent v9 over a month ago, and I've been sending
out this series for over a year, so I'd appreciate it if you could take
a look. It's fine if you hate it, but I'd like to know where to go from
here.

Thanks,
Omar
