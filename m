Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25B5174C26
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 08:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCAH0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 02:26:22 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35775 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCAH0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 02:26:22 -0500
Received: by mail-il1-f195.google.com with SMTP id g126so6583208ilh.2;
        Sat, 29 Feb 2020 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgMI9gzeDKjwdz0UCklXxTagolmRcd8ptBhfjTJM5A8=;
        b=YIXyQZo+9x6Rfv59dG2RU+7DJUmstQlvshuO+ZpZwYeHEFxBGkF87+6srg0w9pvWWV
         S53zgQTx/f0+Fbeg1gg4/0N3sLd8E1IpMhDptS3GFdgcmRjRpwAqlHzhWaXtFkHutmro
         RVbwx0v3ILrgegjUV3Fb7An0HdiB++SXyhMYmlooPj5AA1KtKSe/qUNXu0+tAt4YETJg
         S87GSJ+dIYmUdXbcHBMt0zQFBznTGj+4InYjkKG6eOvQklloBPEFnvAsZ9qfreav5EMU
         s8Oxa6SIQa+ltLHhX0Gh6EHdM6SZGRGO0hMlVzCFpGcXOOeuGHultgpuX7aMyGiM5UHo
         ZnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgMI9gzeDKjwdz0UCklXxTagolmRcd8ptBhfjTJM5A8=;
        b=SXnve/ogJWG3KYmwogfmGOGYGUGVszixQyynXkzGHDuYW6SPK6lrTeWUnBt5o/WmRk
         MHtowjEUSaGW5u/V5DC3HRpPUYTLWM3RMSAjx6+9cpSdbqvlPMMnK3V5i7xzFVaJYvSi
         jajhViuG3BNAvXY8zLdtL1wKQ8AlSIKrnRNeiZce0uiAD4eQ5Q659qq2Oi4gzSAa2wH2
         xH5R29DowOmC+8LrehGCQ/givxA8uVAZPbT+bKbOtB3LKOXzsq/dcdipghoQKRkRLWRM
         Gt4bvorHNAAmHGTXV3ja4seOgUfYzXDnWn2+9QkR+oG/0XhWf1U8UBcuHqAHC2ZVP607
         Gn3A==
X-Gm-Message-State: APjAAAXoLo48nBW21/qCM9Rv1WuZJMpwNnAkXuUesJEk+v7JwLy9zktJ
        T1uM7XF61nCFJcTlWMvFgGUJ1nCKLassph2tbSI=
X-Google-Smtp-Source: APXvYqwyBLB23Q3JdTt4ZXnNkL9M+MCr+V5OudPYDeAdqTesKuP1r98p3DTKUkbUxRlwP35mdarn0m6FWAczUJrg3lY=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr11593427ilc.275.1583047580949;
 Sat, 29 Feb 2020 23:26:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAOQ4uxgym1C3JZHrLhBmEh_T7UbQOukxTBKVzHqp4NSdjredSg@mail.gmail.com> <20200229180335.GA157744@vader>
In-Reply-To: <20200229180335.GA157744@vader>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 1 Mar 2020 09:26:10 +0200
Message-ID: <CAOQ4uxiKmErX0YLkHs2tE4=OUobxmiYBsDz5982YYmierm2Yig@mail.gmail.com>
Subject: Re: [PATCH man-pages v4] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 8:03 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Sat, Feb 29, 2020 at 12:28:41PM +0200, Amir Goldstein wrote:
> > > +encoded_io \- overview of encoded I/O
> > > +.SH DESCRIPTION
> > > +Several filesystems (e.g., Btrfs) support transparent encoding
> > > +(e.g., compression, encryption) of data on disk:
> > > +written data is encoded by the kernel before it is written to disk,
> > > +and read data is decoded before being returned to the user.
> > > +In some cases, it is useful to skip this encoding step.
> > > +For example, the user may want to read the compressed contents of a file
> > > +or write pre-compressed data directly to a file.
> > > +This is referred to as "encoded I/O".
> > > +.SS Encoded I/O API
> > > +Encoded I/O is specified with the
> > > +.B RWF_ENCODED
> > > +flag to
> > > +.BR preadv2 (2)
> > > +and
> > > +.BR pwritev2 (2).
> > > +If
> > > +.B RWF_ENCODED
> > > +is specified, then
> > > +.I iov[0].iov_base
> > > +points to an
> > > +.I
> > > +encoded_iov
> > > +structure, defined in
> > > +.I <linux/fs.h>
> > > +as:
> > > +.PP
> > > +.in +4n
> > > +.EX
> > > +struct encoded_iov {
> > > +    __aligned_u64 len;
> > > +    __aligned_u64 unencoded_len;
> > > +    __aligned_u64 unencoded_offset;
> > > +    __u32 compression;
> > > +    __u32 encryption;
> > > +};
> >
> > This new API can generate many diverse error conditions that the standard errno
> > codes are not rich enough to describe.
> > Maybe add room for encoded io specific error codes in the metadata structure
> > would be good practice, for example:
> > - compression method not supported
> > - encryption method not supported
> > - the combination of enc/comp is not supported
> > - and so on
>
> I like this idea, but it feels like even more iovec abuse. Namely, for

That's true.

> pwritev2(), it feels a little off that we'd be copying _to_ user memory
> rather than only copying from. It's probably worth it for better errors,
> though.
>

Apropos iovec abuse, if encoded io is going to interpret iovec[0] differently
why not interpret iovec arg differently. The result might be less awkward if
the structure passed to preadv2/pwritev2 is struct encoded_iov * instead
of struct iov *.

> > > +.EE
> > > +.in
> > > +.PP
> > > +This may be extended in the future, so
> > > +.I iov[0].iov_len
> > > +must be set to
> > > +.I "sizeof(struct\ encoded_iov)"
> > > +for forward/backward compatibility.
> > > +The remaining buffers contain the encoded data.
> > > +.PP
> > > +.I compression
> > > +and
> > > +.I encryption
> > > +are the encoding fields.
> > > +.I compression
> > > +is one of
> > > +.B ENCODED_IOV_COMPRESSION_NONE
> > > +(zero),
> > > +.BR ENCODED_IOV_COMPRESSION_ZLIB ,
> > > +.BR ENCODED_IOV_COMPRESSION_LZO ,
> > > +or
> > > +.BR ENCODED_IOV_COMPRESSION_ZSTD .
> > > +.I encryption
> > > +is currently always
> > > +.B ENCODED_IOV_ENCRYPTION_NONE
> > > +(zero).
> > > +.PP
> > > +.I unencoded_len
> > > +is the length of the unencoded (i.e., decrypted and decompressed) data.
> > > +.I unencoded_offset
> > > +is the offset into the unencoded data where the data in the file begins
> > > +(less than or equal to
> > > +.IR unencoded_len ).
> > > +.I len
> > > +is the length of the data in the file
> > > +(less than or equal to
> > > +.I unencoded_len
> > > +-
> > > +.IR unencoded_offset ).
> > > +.I
> > > +.PP
> > > +In most cases,
> > > +.I len
> > > +is equal to
> > > +.I unencoded_len
> > > +and
> > > +.I unencoded_offset
> > > +is zero.
> > > +However, it may be necessary to refer to a subset of the unencoded data,
> > > +usually because a read occurred in the middle of an encoded extent,
> > > +because part of an extent was overwritten or deallocated in some
> > > +way (e.g., with
> > > +.BR write (2),
> > > +.BR truncate (2),
> > > +or
> > > +.BR fallocate (2))
> > > +or because part of an extent was added to the file (e.g., with
> > > +.BR ioctl_ficlonerange (2)
> > > +or
> > > +.BR ioctl_fideduperange (2)).
> > > +For example, if
> > > +.I len
> > > +is 300,
> > > +.I unencoded_len
> > > +is 1000,
> > > +and
> > > +.I unencoded_offset
> > > +is 600,
> > > +then the encoded data is 1000 bytes long when decoded,
> > > +of which only the 300 bytes starting at offset 600 are used;
> > > +the first 600 and last 100 bytes should be ignored.
> > > +.PP
> > > +If the unencoded data is actually longer than
> > > +.IR unencoded_len ,
> > > +then it is truncated;
> > > +if it is shorter, then it is extended with zeroes.
> >
> > I find the unencoded_len/unencoded_offset API extremely confusing and all
> > the clarifications above did not help to ease this feeling.
> > Please remind me why does the API need to expose unencoded details at all.
> > I understand the backup/restore use case for read/write encoded data.
> > I do not understand how unencoded offset info is relevant to this use case
> > or what are the other use cases it is relevant for.
>
> I agree, it's confusing. However, without this concept on the read side,
> there's no way to represent some file extent layouts, and without the
> write side, those layouts can't be written back out. That would make
> this interface much less useful for backups.
>
> These cases arise in a few ways on Btrfs:
>
> 1. Files with a size unaligned to the block size.
>
>    Ignoring inline data, Btrfs always pads data to the filesystem block
>    size when compressing. So, a file with a size unaligned to the block
>    size will end with an extent that decompresses to a multiple of the
>    block size, but logically the file only contains the data up to
>    i_size. In this case, len (length up to i_size) < unencoded_len (full
>    decompressed length). This can arise simply from writing out an
>    unaligned file or from truncating a file unaligned.
>
> 2. FICLONERANGE from the middle of an extent.
>
>    Suppose file A has a large compressed extent with
>    len = unencoded_len = 128k and unencoded_offset = 0. If the user does
>    an FICLONERANGE out of the middle of that extent (say, 64k long and
>    4k from the start of the extent), Btrfs creates a "partial" extent
>    which references the original extent (in my example, the result would
>    have len = 64k, unencoded_offset = 4k, and unencoded_len still 128k).
>
> 3. Overwriting the middle of an extent.
>
>    In some cases, when the middle of an extent is overwritten (e.g., an
>    O_DIRECT write, FICLONERANGE, or FIDEDUPERANGE), Btrfs splits up the
>    overwritten extents into partial extents referencing the original
>    extent instead of rewriting the whole extent.
>
> These aren't specific to compression or Btrfs' on-disk format. fscrypt
> uses block ciphers for file data, so case 1 is just as relevant for
> that. The way Btrfs handles case 2 is the only sane way I can see for
> supporting FICLONERANGE for encoded data.
>

I see... so now I understand the complication, but that doesn't mean
that the developers reading the encoded_io documentation will or that
they will get the implementation details right.

IMO, if the only use case for encoded io is backup/restore, then we
should make the API simpler and more oriented to this use case, namely,
serialization -
For all I care, btrfs can still return struct encoded_iov in iov[0],
but the user needs not to know about this and this internal detail should
not be documented nor exposed in UAPI.
btrfs send reads a stream of encoded data and metadata that describes it.
btrfs receive writes the encoded data stream and metadata descriptors that
tell the file system about overlapping extents and whatnot.

Is that something that can work out, or does userspace have to be aware
of encoded extents layout?

Thanks,
Amir.
