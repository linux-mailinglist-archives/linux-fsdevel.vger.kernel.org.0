Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99E114763
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 19:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfLES60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 13:58:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34031 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfLES60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:58:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id h13so1626570plr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m3VZo8UZwHMiRuNQQUqY7rgJ8zqY6lqXNVV5STmF31Y=;
        b=bE0k3fD+BPwpoluxSJNreDDUDkIK4Kf/E4qPIONcXx08wciHl90LnkTPpVpma+8Q/M
         dmnJwnodZr1C5fMMVU/xc7BuvFsf9oJeAg1X+jNWvVf5H3rM3oyp+r08i9pecoMo9qJJ
         qwvY8Oa8WDtCHCCe8khYEs9E3xstecgJ9M0IF6gA127MLkgcZCGN47eq67KSU5aFbDMY
         JsTz6vG3cieY/U2K++uCXx7RS8ZEnGwdjYyxyg2Zeb8mk708flRMGJcylgmtlnNTH31S
         TXBwUJVxSHWIi8TeTJPO+h7IG3GOBDd7QYi1jnf05HttmSpVmRcvzq7rEXV25s3TOKck
         IciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3VZo8UZwHMiRuNQQUqY7rgJ8zqY6lqXNVV5STmF31Y=;
        b=dvlYWvwFW+TkOg0AAn6m1hTHdOhw5BCYbdLw5uqRK6Sf5DAs33M+pIvv6246PhU4Ld
         ltXTUj1nsMxr3feEtv+YnWnMpIG0283HIIFn2jcuDghj3NvKTtcyxyqwec35Me7/vZVi
         W0CfriA/0RdhitOkd6inGr2d4ngXfTz6R6N1w10jFNJOmCcWhHmUyqV4oTzUIxPX+YwU
         +tb6ongf8bf6yLMp+1sulQw60TC69I2Ivn4/oYKcE7Q2FO0sQRHZL2JUfHEqyLMPaWNe
         F+KdRXiTpzQPr0k8qQQPXnksfVCbWr7zVEtukkCO67nKL591fICoKyrT3FxusvsRY/RS
         GRPA==
X-Gm-Message-State: APjAAAVQZh8A9N6Q3pJ2LP3gJb7/Q1SLpncKh8idsbmReL6LZN0Efzz4
        xDERceS9OIEvkYNLyFo9Bng8pwulehqR7w==
X-Google-Smtp-Source: APXvYqx4U8KW8xYiE4vgm2m26+SHXAdrlEokkTP+G731PEQDyP5ZUjTnwZY5L4PH4pUKyh5IIHVbjA==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr9095554pjr.142.1575572305046;
        Thu, 05 Dec 2019 10:58:25 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:cb2])
        by smtp.gmail.com with ESMTPSA id 9sm13462408pfx.177.2019.12.05.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:58:24 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:58:23 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v3 00/12] fs: interface for directly reading/writing
 compressed data
Message-ID: <20191205185823.GB18377@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <4d5bf2e4c2a22a6c195c79e0ae09a4475f1f9bdc.1574274173.git.osandov@fb.com>
 <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:24:20AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> This series adds an API for reading compressed data on a filesystem
> without decompressing it as well as support for writing compressed data
> directly to the filesystem. As with the previous submissions, I've
> included a man page patch describing the API, and test cases and example
> programs are available [1].
> 
> This version reworks the VFS interface to be backward and forward
> compatible and support for writing inline and bookend extents to the
> Btrfs implementation.
> 
> Patches 1-3 add the VFS support. Patches 4-7 are Btrfs cleanups
> necessary for the encoded I/O support that can go in independently of
> this series. Patches 8-10 are Btrfs prep patches. Patch 11 adds Btrfs
> encoded read support and patch 12 adds Btrfs encoded write support.
> 
> A few TODOs remain:
> 
> - Once we've settled on the interface, I'll add RWF_ENCODED support to
>   fsstress and friends and send up the xfstests patches in [1].
> - btrfs_encoded_read() still doesn't implement repair.
> 
> Changes from v2 [2]:
> 
> - Rebase on v5.4-rc8
> - Add patch 1 introducing copy_struct_from_iter() as suggested by Aleksa
> - Rename O_ENCODED to O_ALLOW_ENCODED as suggested by Amir
> - Add arch-specific definitions of O_ALLOW_ENCODED for alpha, parisc,
>   and sparc
> - Rework the VFS interface to be backward and forward compatible
> - Document the VFS interface as requested by Dave
> - Use __aligned_u64 for struct encoded_iov as noted by Aleksa
> - Fix len/unencoded_len mixup in mm/filemap.c as noted by Nikolay
> - Add support for writing inline and bookend extents to Btrfs
> - Use ENOBUFS for "buffers not big enough for encoded extent" case and
>   E2BIG for "encoded_iov has unsupported fields" case
> 
> Please share any comments on the API or implementation. Thanks!
> 
> 1: https://github.com/osandov/xfstests/tree/rwf-encoded
> 2: https://lore.kernel.org/linux-btrfs/cover.1571164762.git.osandov@fb.com/
> 
> Omar Sandoval (12):
>   iov_iter: add copy_struct_from_iter()
>   fs: add O_ALLOW_ENCODED open flag
>   fs: add RWF_ENCODED for reading/writing compressed data
>   btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
>   btrfs: don't advance offset for compressed bios in
>     btrfs_csum_one_bio()
>   btrfs: remove dead snapshot-aware defrag code
>   btrfs: make btrfs_ordered_extent naming consistent with
>     btrfs_file_extent_item
>   btrfs: add ram_bytes and offset to btrfs_ordered_extent
>   btrfs: support different disk extent size for delalloc
>   btrfs: optionally extend i_size in cow_file_range_inline()
>   btrfs: implement RWF_ENCODED reads
>   btrfs: implement RWF_ENCODED writes
> 
>  Documentation/filesystems/encoded_io.rst |   79 +
>  Documentation/filesystems/index.rst      |    1 +
>  arch/alpha/include/uapi/asm/fcntl.h      |    1 +
>  arch/parisc/include/uapi/asm/fcntl.h     |    1 +
>  arch/sparc/include/uapi/asm/fcntl.h      |    1 +
>  fs/btrfs/compression.c                   |   15 +-
>  fs/btrfs/compression.h                   |    5 +-
>  fs/btrfs/ctree.h                         |   13 +-
>  fs/btrfs/delalloc-space.c                |   38 +-
>  fs/btrfs/delalloc-space.h                |    4 +-
>  fs/btrfs/file-item.c                     |   54 +-
>  fs/btrfs/file.c                          |   61 +-
>  fs/btrfs/inode.c                         | 2463 +++++++++++-----------
>  fs/btrfs/ordered-data.c                  |  106 +-
>  fs/btrfs/ordered-data.h                  |   28 +-
>  fs/btrfs/relocation.c                    |    9 +-
>  fs/fcntl.c                               |   10 +-
>  fs/namei.c                               |    4 +
>  include/linux/fcntl.h                    |    2 +-
>  include/linux/fs.h                       |   16 +
>  include/linux/uio.h                      |    2 +
>  include/trace/events/btrfs.h             |    6 +-
>  include/uapi/asm-generic/fcntl.h         |    4 +
>  include/uapi/linux/fs.h                  |   33 +-
>  lib/iov_iter.c                           |   82 +
>  mm/filemap.c                             |  165 +-
>  26 files changed, 1807 insertions(+), 1396 deletions(-)
>  create mode 100644 Documentation/filesystems/encoded_io.rst

Ping. Al, would you mind taking a look at the generic bits/interface?
