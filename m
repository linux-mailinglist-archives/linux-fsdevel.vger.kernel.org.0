Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2288DE463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfJUGS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 02:18:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34494 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUGS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:18:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so4511573ywa.1;
        Sun, 20 Oct 2019 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjY8A8xOBmYzrgtp+G6/g/6XuUcYw5TbbA3eoNEfp4E=;
        b=Coj9+OvsJk/TWQuh7HctrGCzOR2xLeLnBLK2rGl3RjXujV0fi4IVUNsCstEZyDYVAv
         RR26YFYTZcrUFU/aOeNrYtOW8q8qSro8Xpoqm0TtHitCWTQVE1X98ARKJvRaC8zCYYxD
         g+2O/Owy61yz0HcGht+wy7fqmXbiZadaMfd73YaBYDvV/sgkbgl2ezDW2USB+p2xXoxG
         wrrx+C2/UV0B4MpjgvKwtZw2oIuW1Sfekhu1K7NBHCcuwRs8+xmwuwRmXtBD4FnZSUwZ
         OVeDvjLUBXj4IewF+hVEDeI0Z7kCaIyhzMAN7Iuj+/nY+Q7KGRk/MLx/TsqT2D9lCjob
         QCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjY8A8xOBmYzrgtp+G6/g/6XuUcYw5TbbA3eoNEfp4E=;
        b=LkZEkoTnkGR44q2X0IN0DdVh8XFpOsjS/jGFEbJoPbIC6A42VInjh/3Dfb3bcq8aMG
         FpidnDiYPF4KJDnNQhBGxGpTTJe77bsgPHF0hmg3L3EG+KrdlpTQR3FZgvy9bqby6CiG
         KTs0pTsi3RqGO7EaikKAO4EyB59jkiDttwA8Vcwhv+xIkU/vju5EEymAI/d1pNT5JbXn
         RYp6bGlU1f1leULN99RSKF+V2XuNOM3OYR5ZYzf8Phmi1qqwEemtC0OGfj1S8ZlGVqaI
         rFdb3QCfnZTUZUmaGUBct0gWSHlgX17nnqg9grybtMdLcFwP8DULJf2Q15eavUtxrSHE
         aIFA==
X-Gm-Message-State: APjAAAWa3UI38czn1B0+AeFmGGK/ziiaBkCSsNpGHwUzakLJ3Da21/GQ
        UhdI0LccPzcGTgvuFeJPGB7siJ+WTvmZ02rrJfw=
X-Google-Smtp-Source: APXvYqxUnGAV8xk7E+t+QEadMbn/XzXZ5afGi/fDG+rjLIaSQVUX7uJRCXeiWgUw6iusNulUxUkxFSO6W89n283pXcg=
X-Received: by 2002:a81:a18e:: with SMTP id y136mr5006275ywg.294.1571638704923;
 Sun, 20 Oct 2019 23:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571164762.git.osandov@fb.com> <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
In-Reply-To: <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Oct 2019 09:18:13 +0300
Message-ID: <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
Subject: Re: [PATCH man-pages] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC: Ted

What ever happened to read/write ext4 encrypted data API?
https://marc.info/?l=linux-ext4&m=145030599010416&w=2

Can we learn anything from the ext4 experience to improve
the new proposed API?


On Wed, Oct 16, 2019 at 12:29 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This adds a new page, rwf_encoded(7), providing an overview of encoded
> I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> reference it.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  man2/fcntl.2       |  10 +-
>  man2/open.2        |  13 ++
>  man2/readv.2       |  46 +++++++
>  man7/rwf_encoded.7 | 297 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 365 insertions(+), 1 deletion(-)
>  create mode 100644 man7/rwf_encoded.7
>
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index fce4f4c2b..76fe9cc6f 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -222,8 +222,9 @@ On Linux, this command can change only the
>  .BR O_ASYNC ,
>  .BR O_DIRECT ,
>  .BR O_NOATIME ,
> +.BR O_NONBLOCK ,
>  and
> -.B O_NONBLOCK
> +.B O_ENCODED
>  flags.
>  It is not possible to change the
>  .BR O_DSYNC
> @@ -1803,6 +1804,13 @@ Attempted to clear the
>  flag on a file that has the append-only attribute set.
>  .TP
>  .B EPERM
> +Attempted to set the
> +.B O_ENCODED
> +flag and the calling process did not have the
> +.B CAP_SYS_ADMIN
> +capability.
> +.TP
> +.B EPERM
>  .I cmd
>  was
>  .BR F_ADD_SEALS ,
> diff --git a/man2/open.2 b/man2/open.2
> index b0f485b41..cdd3c549c 100644
> --- a/man2/open.2
> +++ b/man2/open.2
> @@ -421,6 +421,14 @@ was followed by a call to
>  .BR fdatasync (2)).
>  .IR "See NOTES below" .
>  .TP
> +.B O_ENCODED
> +Open the file with encoded I/O permissions;

1. I find the name of the flag confusing.
Yes, most people don't read documentation so carefully (or at all)
so they will assume O_ENCODED will affect read/write or that it
relates to RWF_ENCODED in a similar way that O_SYNC relates
to RWF_SYNC (i.e. logical OR and not logical AND).

I am not good at naming and to prove it I will propose:
O_PROMISCUOUS, O_MAINTENANCE, O_ALLOW_ENCODED

2. While I see no harm in adding O_ flag to open(2) for this
use case, I also don't see a major benefit in adding it.
What if we only allowed setting the flag via fcntl(2) which returns
an error on old kernels?
Since unlike most O_ flags, O_ENCODED does NOT affect file
i/o without additional opt-in flags, it is not standard anyway and
therefore I find that setting it only via fcntl(2) is less error prone.


> +see
> +.BR rwf_encoded (7).
> +The caller must have the
> +.B CAP_SYS_ADMIN
> +capabilty.
> +.TP
>  .B O_EXCL
>  Ensure that this call creates the file:
>  if this flag is specified in conjunction with
> @@ -1168,6 +1176,11 @@ did not match the owner of the file and the caller was not privileged.
>  The operation was prevented by a file seal; see
>  .BR fcntl (2).
>  .TP
> +.B EPERM
> +The
> +.B O_ENCODED
> +flag was specified, but the caller was not privileged.
> +.TP
>  .B EROFS
>  .I pathname
>  refers to a file on a read-only filesystem and write access was
> diff --git a/man2/readv.2 b/man2/readv.2
> index af27aa63e..aa60b980a 100644
> --- a/man2/readv.2
> +++ b/man2/readv.2
> @@ -265,6 +265,11 @@ the data is always appended to the end of the file.
>  However, if the
>  .I offset
>  argument is \-1, the current file offset is updated.
> +.TP
> +.BR RWF_ENCODED " (since Linux 5.6)"
> +Read or write encoded (e.g., compressed) data.
> +See
> +.BR rwf_encoded (7).
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> @@ -284,6 +289,13 @@ than requested (see
>  and
>  .BR write (2)).
>  .PP
> +If
> +.B
> +RWF_ENCODED
> +was specified in
> +.IR flags ,
> +then the return value is the number of encoded bytes.
> +.PP
>  On error, \-1 is returned, and \fIerrno\fP is set appropriately.
>  .SH ERRORS
>  The errors are as given for
> @@ -314,6 +326,40 @@ is less than zero or greater than the permitted maximum.
>  .TP
>  .B EOPNOTSUPP
>  An unknown flag is specified in \fIflags\fP.
> +.TP
> +.B EOPNOTSUPP
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and the filesystem does not implement encoded I/O.
> +.TP
> +.B EPERM
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and the file was not opened with the
> +.B O_ENCODED
> +flag.
> +.PP
> +.BR preadv2 ()
> +can fail for the following reasons:
> +.TP
> +.B EFBIG
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and buffers in
> +.I iov
> +were not big enough to return the encoded data.

I don't like it that EFBIG is returned for read.
While EXXX values meaning is often very vague, EFBIG meaning
is still quite consistent - it is always a write related error when trying
to change i_size above fs/system limits.

In the case above, I find E2BIG much more appropriate.
Although its original meaning was too long arg list, it already grew
several cases where it generally means "buffer cannot hold the result"
like the case with msgrcv(2) and listxattr(2).

Thanks,
Amir.

> +.PP
> +.BR pwritev2 ()
> +can fail for the following reasons:
> +.TP
> +.B EINVAL
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and the alignment and/or size requirements are not met.
>  .SH VERSIONS
>  .BR preadv ()
>  and
> diff --git a/man7/rwf_encoded.7 b/man7/rwf_encoded.7
> new file mode 100644
> index 000000000..90f5292e2
> --- /dev/null
> +++ b/man7/rwf_encoded.7
> @@ -0,0 +1,297 @@
> +.\" Copyright (c) 2019 by Omar Sandoval <osandov@fb.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.\"
> +.TH RWF_ENCODED  7 2019-10-14 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +rwf_encoded \- overview of encoded I/O
> +.SH DESCRIPTION
> +Several filesystems (e.g., Btrfs) support transparent encoding
> +(e.g., compression, encryption) of data on disk:
> +written data is encoded by the kernel before it is written to disk,
> +and read data is decoded before being returned to the user.
> +In some cases, it is useful to skip this encoding step.
> +For example, the user may want to read the compressed contents of a file
> +or write pre-compressed data directly to a file.
> +This is referred to as "encoded I/O".
> +.SS Encoded I/O API
> +Encoded I/O is specified with the
> +.B RWF_ENCODED
> +flag to
> +.BR preadv2 (2)
> +and
> +.BR pwritev2 (2).
> +If
> +.B RWF_ENCODED
> +is specified, then
> +.I iov[0].iov_base
> +points to an
> +.I
> +encoded_iov
> +structure, defined in
> +.I <linux/fs.h>
> +as:
> +.PP
> +.in +4n
> +.EX
> +struct encoded_iov {
> +    __u64 len;
> +    __u64 unencoded_len;
> +    __u64 unencoded_offset;
> +    __u32 compression;
> +    __u32 encryption;
> +
> +};
> +.EE
> +.in
> +.PP
> +.I iov[0].iov_len
> +must be set to
> +.IR "sizeof(struct\ encoded_iov)" .
> +The remaining buffers contain the encoded data.
> +.PP
> +.I compression
> +and
> +.I encryption
> +are the encoding fields.
> +.I compression
> +is one of
> +.B ENCODED_IOV_COMPRESSION_NONE
> +(zero),
> +.BR ENCODED_IOV_COMPRESSION_ZLIB ,
> +.BR ENCODED_IOV_COMPRESSION_LZO ,
> +or
> +.BR ENCODED_IOV_COMPRESSION_ZSTD .
> +.I encryption
> +is currently always
> +.B ENCODED_IOV_ENCRYPTION_NONE
> +(zero).
> +.PP
> +.I unencoded_len
> +is the length of the unencoded (i.e., decrypted and decompressed) data.
> +.I unencoded_offset
> +is the offset into the unencoded data where the data in the file begins
> +(strictly less than
> +.IR unencoded_len ).
> +.I len
> +is the length of the data in the file.
> +.PP
> +In most cases,
> +.I len
> +is equal to
> +.I unencoded_len
> +and
> +.I unencoded_offset
> +is zero.
> +However, it may be necessary to refer to a subset of the unencoded data,
> +usually because a read occurred in the middle of an encoded extent,
> +because part of an extent was overwritten or deallocated in some
> +way (e.g., with
> +.BR write (2),
> +.BR truncate (2),
> +or
> +.BR fallocate (2))
> +or because part of an extent was added to the file (e.g., with
> +.BR ioctl_ficlonerange (2)
> +or
> +.BR ioctl_fideduperange (2)).
> +For example, if
> +.I len
> +is 300,
> +.I unencoded_len
> +is 1000,
> +and
> +.I unencoded_offset
> +is 600,
> +then the encoded data is 1000 bytes long when decoded,
> +of which only the 300 bytes starting at offset 600 are used;
> +the first 600 and last 100 bytes should be ignored.
> +.PP
> +Additionally,
> +.I len
> +may be greater than
> +.I unencoded_len
> +-
> +.IR unencoded_offset;
> +in this case, the data in the file is longer than the unencoded data,
> +and the difference is zero-filled.
> +.PP
> +If the unencoded data is actually longer than
> +.IR unencoded_len ,
> +then it is truncated;
> +if it is shorter, then it is extended with zeroes.
> +.PP
> +For
> +.BR pwritev2 (),
> +the metadata should be specified in
> +.IR iov[0] ,
> +and the encoded data should be passed in the remaining buffers.
> +This returns the number of encoded bytes written (that is, the sum of
> +.I iov[n].iov_len
> +for 1 <=
> +.I n
> +<
> +.IR iovcnt ;
> +partial writes will not occur).
> +If the
> +.I offset
> +argument to
> +.BR pwritev2 ()
> +is -1, then the file offset is incremented by
> +.IR len .
> +At least one encoding field must be non-zero.
> +Note that the encoded data is not validated when it is written;
> +if it is not valid (e.g., it cannot be decompressed),
> +then a subsequent read may result in an error.
> +.PP
> +For
> +.BR preadv2 (),
> +the metadata is returned in
> +.IR iov[0] ,
> +and the encoded data is returned in the remaining buffers.
> +This returns the number of encoded bytes read.
> +Note that a return value of zero does not indicate end of file;
> +one should refer to
> +.I len
> +(for example, a hole in the file has a non-zero
> +.I len
> +but a zero return value).
> +A
> +.I len
> +of zero indicates end of file.
> +If the
> +.I offset
> +argument to
> +.BR preadv2 ()
> +is -1, then the file offset is incremented by
> +.IR len .
> +If the provided buffers are not large enough to return an entire encoded
> +extent,
> +then this returns -1 and sets
> +.I errno
> +to
> +.BR EFBIG .
> +This will only return one encoded extent per call.
> +This can also read data which is not encoded;
> +all encoding fields will be zero in that case.
> +.SS Security
> +Encoded I/O creates the potential for some security issues:
> +.IP * 3
> +Encoded writes allow writing arbitrary data which the kernel will decode on
> +a subsequent read. Decompression algorithms are complex and may have bugs
> +which can be exploited by malicous data.
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
> +.B O_ENCODED
> +flag to
> +.BR open (2),
> +which requires the
> +.B CAP_SYS_ADMIN
> +capability.
> +.B O_ENCODED
> +may be set and cleared with
> +.BR fcntl (2).
> +Note that it is not cleared on
> +.BR fork (2)
> +or
> +.BR execve (2);
> +one may wish to use
> +.B O_CLOEXEC
> +with
> +.BR O_ENCODED .
> +.SS Filesystem support
> +Encoded I/O is supported on the following filesystems:
> +.TP
> +Btrfs (since Linux 5.6)
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
> +and wrapped in the format described in the Linux kernel source file
> +.IR fs/btrfs/lzo.c .
> +.IP *
> +If
> +.I compression
> +is
> +.BR ENCODED_IOV_COMPRESSION_ZSTD ,
> +then the encoded data is a single zstd frame compressed with the
> +.I windowLog
> +compression parameter set to no more than 17.
> +.RE
> +.IP
> +Additionally, there are some restrictions on
> +.BR pwritev2 ():
> +.RS
> +.IP * 3
> +.I offset
> +(or the current file offset if
> +.I offset
> +is -1) must be aligned to the sector size of the filesystem.
> +.IP *
> +.I len
> +must be aligned to the sector size of the filesystem
> +unless the data ends at or beyond the current end of the file.
> +.IP *
> +.I unencoded_len
> +and the length of the encoded data must each be no more than 128 KiB.
> +This limit may increase in the future.
> +.IP *
> +The length of the encoded data rounded up to the nearest sector must be
> +less than
> +.I unencoded_len
> +rounded up to the nearest sector.
> +.IP *
> +Referring to a subset of unencoded data is not yet implemented; i.e.,
> +.I len
> +must equal
> +.I unencoded_len
> +and
> +.I unencoded_offset
> +must be zero.
> +.IP *
> +Writing compressed inline extents is not yet implemented.
> +.RE
> --
> 2.23.0
>
