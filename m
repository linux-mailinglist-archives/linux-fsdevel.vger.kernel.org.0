Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C324D164
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHUJZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:25:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A0C061385;
        Fri, 21 Aug 2020 02:25:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g13so1069217ioo.9;
        Fri, 21 Aug 2020 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMdNY3sv9mJXm4dWbAhnEfdGoUuG/B2UyNnuHuc9KrQ=;
        b=fLO0TSGExzN8cxNQ+HY4Uv30yWCIgeN+YLPICKZFNRU3rnQbPtidPt12hSV2xyv10f
         mtC6t4iAD/s8oUH9+VKkE9kxfAduMByf0LrD+665cQ41y2CLQqXNqBnGc20dFCh/mRPl
         rHdk5YDiN5AcW0tBZ+d9EMKzkVQsEJyDWfj753CqyvC/8HQFsbp83baFAv9J9Iu2FpHK
         eZhzIBpwoX8cdlw9pLVUZA8ZpcjatF8w6Cl+0JNG2OPyScvMtRS8H+GtNlYpgen4Uq8k
         zaeVxVRECCXVtPdTD6DC6Vg+6ut6PawPsEF1lnTfdwR2XLjXmzv8nB0rGWYg3O+6TvCj
         DFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMdNY3sv9mJXm4dWbAhnEfdGoUuG/B2UyNnuHuc9KrQ=;
        b=f9+3VOQB6i7ZH8R0SQDfZiRKWhP6Mi1+xHpgy9ffkA3ppuCq+h/EGK73COsGcMHuE9
         xRShxBYykfUwVuL9V0YWs+TysKaa7RMR84vRYTmFE/oifHwkbni1blXXg5601v6kpdU+
         8lp1JLS7aWaeBtioB5ybItxWyacmDXEPUDaPe5CO0vcXv81kii62DEyiXhlRk9u8X53d
         6/xnW6JphIEIkI/bZrCP6iz5C4+80peJCs949h0XtTboG5b/n4JZDi0Gg+R0adH4euN2
         HoJ+qYqbiow6BqCOHDvwvyMurT2EgpKu/4SisxxBVjociFznknPgCOG1bg4MkvR23nZm
         dODA==
X-Gm-Message-State: AOAM530/mJxr4hnOpFb81weRimd0TJ+ZTlkYa9J5VnA/WCmvOWxw+ryt
        uvBB/1vf66Hyl73g4TiEVvLG/lBJ1QKNK0ic3T8=
X-Google-Smtp-Source: ABdhPJyLT/ftjg3C32lOMXRnk+cpBoBzYYYxiYa7eVyvpwipOeqTw+HhHTsQEVY0uwjyfwdW3GPNbyPdeq7FZujEgw0=
X-Received: by 2002:a5e:980f:: with SMTP id s15mr1707909ioj.5.1598001899978;
 Fri, 21 Aug 2020 02:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597993855.git.osandov@osandov.com> <64cc229872230dc6998a3dbf2264513870a8a6f6.1597994017.git.osandov@osandov.com>
In-Reply-To: <64cc229872230dc6998a3dbf2264513870a8a6f6.1597994017.git.osandov@osandov.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Aug 2020 12:24:48 +0300
Message-ID: <CAOQ4uxgEpYqQ9MeuS=76tOtjFCrL8urkDoPoHxu+A5s4C2HGRA@mail.gmail.com>
Subject: Re: [PATCH man-pages v5] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:38 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This adds a new page, encoded_io(7), providing an overview of encoded
> I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> reference it.
>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: linux-man <linux-man@vger.kernel.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

Omar,

Thanks for making the clarifications. Some questions below.

[...]

> +.PP
> +As the filesystem page cache typically contains decoded data,
> +encoded I/O bypasses the page cache.
> +.SS Extent layout
> +By using
> +.IR len ,
> +.IR unencoded_len ,
> +and
> +.IR unencoded_offset ,
> +it is possible to refer to a subset of an unencoded extent.
> +.PP
> +In the simplest case,
> +.I len
> +is equal to
> +.I unencoded_len
> +and
> +.I unencoded_offset
> +is zero.
> +This means that the entire unencoded extent is used.
> +.PP
> +However, suppose we read 50 bytes into a file
> +which contains a single compressed extent.
> +The filesystem must still return the entire compressed extent
> +for us to be able to decompress it,
> +so
> +.I unencoded_len
> +would be the length of the entire decompressed extent.
> +However, because the read was at offset 50,
> +the first 50 bytes should be ignored.
> +Therefore,
> +.I unencoded_offset
> +would be 50,
> +and
> +.I len
> +would accordingly be
> +.IR unencoded_len\ -\ 50 .
> +.PP
> +Additionally, suppose we want to create an encrypted file with length 500,
> +but the file is encrypted with a block cipher using a block size of 4096.
> +The unencoded data would therefore include the appropriate padding,
> +and
> +.I unencoded_len
> +would be 4096.
> +However, to represent the logical size of the file,
> +.I len
> +would be 500
> +(and
> +.I unencoded_offset
> +would be 0).
> +.PP
> +Similar situations can arise in other cases:
> +.IP * 3
> +If the filesystem pads data to the filesystem block size before compressing,
> +then compressed files with a size unaligned to the filesystem block size will
> +end with an extent with
> +.I len
> +<
> +.IR unencoded_len .
> +.IP *
> +Extents cloned from the middle of a larger encoded extent with
> +.B FICLONERANGE
> +may have a non-zero
> +.I unencoded_offset
> +and/or
> +.I len
> +<
> +.IR unencoded_len .
> +.IP *
> +If the middle of an encoded extent is overwritten,
> +the filesystem may create extents with a non-zero
> +.I unencoded_offset
> +and/or
> +.I len
> +<
> +.I unencoded_len
> +for the parts that were not overwritten.

So in this case, would the reader be getting extents "out of unencoded order"?
e.g. unencoded range 0..4096 and then unencoded range 10..20?
Or would reader be reading the encoded full block twice, once for
ragne 0..10 and once for range 20..4096?



> +.SS Security
> +Encoded I/O creates the potential for some security issues:
> +.IP * 3
> +Encoded writes allow writing arbitrary data which the kernel will decode on
> +a subsequent read. Decompression algorithms are complex and may have bugs
> +which can be exploited by maliciously crafted data.
> +.IP *
> +Encoded reads may return data which is not logically present in the file
> +(see the discussion of
> +.I len
> +vs.
> +.I unencoded_len
> +above).
> +It may not be intended for this data to be readable.
> +.PP
> +Therefore, encoded I/O requires privilege.
> +Namely, the
> +.B RWF_ENCODED
> +flag may only be used when the file was opened with the
> +.B O_ALLOW_ENCODED
> +flag to
> +.BR open (2),
> +which requires the
> +.B CAP_SYS_ADMIN
> +capability.
> +.B O_ALLOW_ENCODED
> +may be set and cleared with
> +.BR fcntl (2).
> +Note that it is not cleared on
> +.BR fork (2)
> +or
> +.BR execve (2);
> +one may wish to use
> +.B O_CLOEXEC
> +with
> +.BR O_ALLOW_ENCODED .
> +.SS Filesystem support
> +Encoded I/O is supported on the following filesystems:
> +.TP
> +Btrfs (since Linux 5.10)
> +.IP
> +Btrfs supports encoded reads and writes of compressed data.
> +The data is encoded as follows:
> +.RS
> +.IP * 3
> +If
> +.I compression
> +is
> +.BR ENCODED_IOV_COMPRESSION_ZLIB ,
> +then the encoded data is a single zlib stream.
> +.IP *
> +If
> +.I compression
> +is
> +.BR ENCODED_IOV_COMPRESSION_LZO ,
> +then the encoded data is compressed page by page with LZO1X
> +and wrapped in the format documented in the Linux kernel source file
> +.IR fs/btrfs/lzo.c .

:-/ So maybe call it ENCODED_IOV_COMPRESSION_BTRFS_LZO?

I understand why you want the encoding format not to be opaque, but
I imagine the encoded data is not going to be migrated as is between
different filesystems. So just call it for what it is - a private
filesystem encoding
format. If you have a format that is standard and other filesystems are likely
to use, fine, but let's not make an API that discourages using
"private" encoding, just for the sake of it and make life harder for no good
reason.

All the reader of this man page may be interested to know is which
filesystems are expected to support which encoding types and a general
description of what they mean (as you did).
Making this page wrongly appear as a standard for encoding formats is not
going to play out well...

> +.IP *
> +If
> +.I compression
> +is
> +.BR ENCODED_IOV_COMPRESSION_ZSTD ,
> +then the encoded data is a single zstd frame compressed with the
> +.I windowLog
> +compression parameter set to no more than 17.

Even that small detail is a bit limiting to filesystems and should
therefore be tagged as a private btrfs encoding IMO.

Thanks,
Amir.
