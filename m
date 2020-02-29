Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF26917488A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgB2SDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 13:03:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52956 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgB2SDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:03:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so2640715pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z89W4g4aiTyqMWeFu9TbmpRWadrcXuWSXAxV5E/i9Ks=;
        b=NUAUSjMc3PylWqoNwD9tmPdW1meYULD//Jlozs3Xa+VZ5Ui3CCoFpfStCRKbMx1a3r
         F3/Vl9YoQbPRExQjDKDl+Z5TjtfwgSErqpiPASKhCKtkeJDmORLQoqBnHIXaQU96diqY
         xyoISm6dKqGIti0CFVD+4YQBStyo13x4cVbpJlhWoyvOidgFvCrSQOpc7FVoz2fkwfUU
         vX4SLHgFgA4LtXPlbJDmqJ25Nu4fYgMONjX3Rogf03cQXkOHYM6RA4x1VmNlADfwRMf7
         yfpmFipstyhAqK6dUohMXoDNt/4DZ01v4WBnx9lARerqGtZocE+pzlkCw8Vcdwi50sR9
         EE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z89W4g4aiTyqMWeFu9TbmpRWadrcXuWSXAxV5E/i9Ks=;
        b=DN195Knjoik3M5iDbjcTkOped+T7Rd3rKOgcOrJ6XAKybop/1M+f+Bp+3UxctW9FaR
         bM4gDb7Uw17ND0PtH+vTdCCmQ0+QLGuF7cP/iXWMbUkL0kVAVZeye1xxoTNr8VQYQ3KW
         fxs+eWOMQw4aMLcq2lEvwNzA6Uh+SKfnJrNo7Ox99Bs1o6PLtDTpjdzlyoEFLZn5WuQR
         3LQInn5R/fRO6jLQlUwIsPhejk3e2yY5N5Jb4xfL/UWzwpWh2JRKNlEN1kcXvuAp2DZC
         RyZIkJlBSCBZaMC01Bv0eBfmI61q+jt25/LHDUeKUxsIQ4OuR5YN1TqSFQma6TwZyOk9
         n+VQ==
X-Gm-Message-State: ANhLgQ2IqQpNIqqljI9KqDGcLCdFLhnAP00+gFlQe/+WClR84JA9gleQ
        tOdwWzzHiy5N9eiRnC1S0RwkLUWy35M=
X-Google-Smtp-Source: ADFU+vvMt8ivPleB4YG6JegTWPMHA/ki9R8MO9nGfTA1OEmFOIvT68B8kGaLz5bk0qlPx/4kYflYfA==
X-Received: by 2002:a17:90a:9303:: with SMTP id p3mr3769348pjo.35.1582999419354;
        Sat, 29 Feb 2020 10:03:39 -0800 (PST)
Received: from vader ([2607:fb90:8365:d596:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id 5sm2791302pfw.179.2020.02.29.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 10:03:38 -0800 (PST)
Date:   Sat, 29 Feb 2020 10:03:35 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH man-pages v4] Document encoded I/O
Message-ID: <20200229180335.GA157744@vader>
References: <cover.1582930832.git.osandov@fb.com>
 <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAOQ4uxgym1C3JZHrLhBmEh_T7UbQOukxTBKVzHqp4NSdjredSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgym1C3JZHrLhBmEh_T7UbQOukxTBKVzHqp4NSdjredSg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 12:28:41PM +0200, Amir Goldstein wrote:
> > +encoded_io \- overview of encoded I/O
> > +.SH DESCRIPTION
> > +Several filesystems (e.g., Btrfs) support transparent encoding
> > +(e.g., compression, encryption) of data on disk:
> > +written data is encoded by the kernel before it is written to disk,
> > +and read data is decoded before being returned to the user.
> > +In some cases, it is useful to skip this encoding step.
> > +For example, the user may want to read the compressed contents of a file
> > +or write pre-compressed data directly to a file.
> > +This is referred to as "encoded I/O".
> > +.SS Encoded I/O API
> > +Encoded I/O is specified with the
> > +.B RWF_ENCODED
> > +flag to
> > +.BR preadv2 (2)
> > +and
> > +.BR pwritev2 (2).
> > +If
> > +.B RWF_ENCODED
> > +is specified, then
> > +.I iov[0].iov_base
> > +points to an
> > +.I
> > +encoded_iov
> > +structure, defined in
> > +.I <linux/fs.h>
> > +as:
> > +.PP
> > +.in +4n
> > +.EX
> > +struct encoded_iov {
> > +    __aligned_u64 len;
> > +    __aligned_u64 unencoded_len;
> > +    __aligned_u64 unencoded_offset;
> > +    __u32 compression;
> > +    __u32 encryption;
> > +};
> 
> This new API can generate many diverse error conditions that the standard errno
> codes are not rich enough to describe.
> Maybe add room for encoded io specific error codes in the metadata structure
> would be good practice, for example:
> - compression method not supported
> - encryption method not supported
> - the combination of enc/comp is not supported
> - and so on

I like this idea, but it feels like even more iovec abuse. Namely, for
pwritev2(), it feels a little off that we'd be copying _to_ user memory
rather than only copying from. It's probably worth it for better errors,
though.

> > +.EE
> > +.in
> > +.PP
> > +This may be extended in the future, so
> > +.I iov[0].iov_len
> > +must be set to
> > +.I "sizeof(struct\ encoded_iov)"
> > +for forward/backward compatibility.
> > +The remaining buffers contain the encoded data.
> > +.PP
> > +.I compression
> > +and
> > +.I encryption
> > +are the encoding fields.
> > +.I compression
> > +is one of
> > +.B ENCODED_IOV_COMPRESSION_NONE
> > +(zero),
> > +.BR ENCODED_IOV_COMPRESSION_ZLIB ,
> > +.BR ENCODED_IOV_COMPRESSION_LZO ,
> > +or
> > +.BR ENCODED_IOV_COMPRESSION_ZSTD .
> > +.I encryption
> > +is currently always
> > +.B ENCODED_IOV_ENCRYPTION_NONE
> > +(zero).
> > +.PP
> > +.I unencoded_len
> > +is the length of the unencoded (i.e., decrypted and decompressed) data.
> > +.I unencoded_offset
> > +is the offset into the unencoded data where the data in the file begins
> > +(less than or equal to
> > +.IR unencoded_len ).
> > +.I len
> > +is the length of the data in the file
> > +(less than or equal to
> > +.I unencoded_len
> > +-
> > +.IR unencoded_offset ).
> > +.I
> > +.PP
> > +In most cases,
> > +.I len
> > +is equal to
> > +.I unencoded_len
> > +and
> > +.I unencoded_offset
> > +is zero.
> > +However, it may be necessary to refer to a subset of the unencoded data,
> > +usually because a read occurred in the middle of an encoded extent,
> > +because part of an extent was overwritten or deallocated in some
> > +way (e.g., with
> > +.BR write (2),
> > +.BR truncate (2),
> > +or
> > +.BR fallocate (2))
> > +or because part of an extent was added to the file (e.g., with
> > +.BR ioctl_ficlonerange (2)
> > +or
> > +.BR ioctl_fideduperange (2)).
> > +For example, if
> > +.I len
> > +is 300,
> > +.I unencoded_len
> > +is 1000,
> > +and
> > +.I unencoded_offset
> > +is 600,
> > +then the encoded data is 1000 bytes long when decoded,
> > +of which only the 300 bytes starting at offset 600 are used;
> > +the first 600 and last 100 bytes should be ignored.
> > +.PP
> > +If the unencoded data is actually longer than
> > +.IR unencoded_len ,
> > +then it is truncated;
> > +if it is shorter, then it is extended with zeroes.
> 
> I find the unencoded_len/unencoded_offset API extremely confusing and all
> the clarifications above did not help to ease this feeling.
> Please remind me why does the API need to expose unencoded details at all.
> I understand the backup/restore use case for read/write encoded data.
> I do not understand how unencoded offset info is relevant to this use case
> or what are the other use cases it is relevant for.

I agree, it's confusing. However, without this concept on the read side,
there's no way to represent some file extent layouts, and without the
write side, those layouts can't be written back out. That would make
this interface much less useful for backups.

These cases arise in a few ways on Btrfs:

1. Files with a size unaligned to the block size.

   Ignoring inline data, Btrfs always pads data to the filesystem block
   size when compressing. So, a file with a size unaligned to the block
   size will end with an extent that decompresses to a multiple of the
   block size, but logically the file only contains the data up to
   i_size. In this case, len (length up to i_size) < unencoded_len (full
   decompressed length). This can arise simply from writing out an
   unaligned file or from truncating a file unaligned.

2. FICLONERANGE from the middle of an extent.

   Suppose file A has a large compressed extent with
   len = unencoded_len = 128k and unencoded_offset = 0. If the user does
   an FICLONERANGE out of the middle of that extent (say, 64k long and
   4k from the start of the extent), Btrfs creates a "partial" extent
   which references the original extent (in my example, the result would
   have len = 64k, unencoded_offset = 4k, and unencoded_len still 128k).

3. Overwriting the middle of an extent.

   In some cases, when the middle of an extent is overwritten (e.g., an
   O_DIRECT write, FICLONERANGE, or FIDEDUPERANGE), Btrfs splits up the
   overwritten extents into partial extents referencing the original
   extent instead of rewriting the whole extent.

These aren't specific to compression or Btrfs' on-disk format. fscrypt
uses block ciphers for file data, so case 1 is just as relevant for
that. The way Btrfs handles case 2 is the only sane way I can see for
supporting FICLONERANGE for encoded data.

> > +.PP
> > +For
> > +.BR pwritev2 (),
> > +the metadata should be specified in
> > +.IR iov[0] .
> > +If
> > +.I iov[0].iov_len
> > +is less than
> > +.I "sizeof(struct\ encoded_iov)"
> > +in the kernel,
> > +then any fields unknown to userspace are treated as if they were zero;
> > +if it is greater and any fields unknown to the kernel are non-zero,
> > +then this returns -1 and sets
> > +.I errno
> > +to
> > +.BR E2BIG .
> > +The encoded data should be passed in the remaining buffers.
> > +This returns the number of encoded bytes written (that is, the sum of
> > +.I iov[n].iov_len
> > +for 1 <=
> > +.I n
> > +<
> > +.IR iovcnt ;
> > +partial writes will not occur).
> > +If the
> > +.I offset
> > +argument to
> > +.BR pwritev2 ()
> > +is -1, then the file offset is incremented by
> > +.IR len .
> > +At least one encoding field must be non-zero.
> > +Note that the encoded data is not validated when it is written;
> > +if it is not valid (e.g., it cannot be decompressed),
> > +then a subsequent read may return an error.
> > +.PP
> > +For
> > +.BR preadv2 (),
> > +the metadata is returned in
> > +.IR iov[0] .
> > +If
> > +.I iov[0].iov_len
> > +is less than
> > +.I "sizeof(struct\ encoded_iov)"
> > +in the kernel and any fields unknown to userspace are non-zero,
> > +then this returns -1 and sets
> > +.I errno
> > +to
> > +.BR E2BIG ;
> > +if it is greater,
> > +then any fields unknown to the kernel are returned as zero.
> > +The encoded data is returned in the remaining buffers.
> > +If the provided buffers are not large enough to return an entire encoded
> > +extent,
> > +then this returns -1 and sets
> > +.I errno
> > +to
> > +.BR ENOBUFS .
> > +This returns the number of encoded bytes read.
> > +If the
> > +.I offset
> > +argument to
> > +.BR preadv2 ()
> > +is -1, then the file offset is incremented by
> > +.IR len .
> > +This will only return one encoded extent per call.
> > +This can also read data which is not encoded;
> > +all encoding fields will be zero in that case.
> > +.PP
> > +As the filesystem page cache typically contains decoded data,
> > +encoded I/O bypasses the page cache.
> > +.SS Security
> > +Encoded I/O creates the potential for some security issues:
> > +.IP * 3
> > +Encoded writes allow writing arbitrary data which the kernel will decode on
> > +a subsequent read. Decompression algorithms are complex and may have bugs
> > +which can be exploited by maliciously crafted data.
> > +.IP *
> > +Encoded reads may return data which is not logically present in the file
> > +(see the discussion of
> > +.I len
> > +vs.
> > +.I unencoded_len
> > +above).
> > +It may not be intended for this data to be readable.
> > +.PP
> > +Therefore, encoded I/O requires privilege.
> > +Namely, the
> > +.B RWF_ENCODED
> > +flag may only be used when the file was opened with the
> > +.B O_ALLOW_ENCODED
> > +flag to
> > +.BR open (2),
> > +which requires the
> > +.B CAP_SYS_ADMIN
> > +capability.
> > +.B O_ALLOW_ENCODED
> > +may be set and cleared with
> > +.BR fcntl (2).
> > +Note that it is not cleared on
> > +.BR fork (2)
> > +or
> > +.BR execve (2);
> > +one may wish to use
> > +.B O_CLOEXEC
> > +with
> > +.BR O_ALLOW_ENCODED .
> 
> Sigh! If I were an attacker I would be drooling right now.
> We want to create a new API to read/write raw encrypted data (even though
> you have not implemented any encryption yet) and we use the same old
> vulnerable practices that security people have been fighting for decades?
> I am not very comfortable with this attitude.
> I think we should be much more prudent for the first version of the API.
> 
> How about not allowing to set O_ALLOW_ENCODED without O_CLOEXEC.
> We may or may not allow to clear O_CLOEXEC while O_ALLOW_ENCODED
> is set, in case this is the user intention, but leaving the API as it is is just
> asking for trouble IMO.

Ok, I'm fine with requiring O_CLOEXEC for O_ALLOW_ENCODED on open. I'm
pretty sure we want to allow clearing it with fcntl, as that is a very
intentional action.
