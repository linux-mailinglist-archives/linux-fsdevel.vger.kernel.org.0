Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B771AC12D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635182AbgDPM0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503287AbgDPM0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:26:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1BC061A0C;
        Thu, 16 Apr 2020 05:26:13 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 184so2269038vsu.3;
        Thu, 16 Apr 2020 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=kPwHsM5ou4zTiMgJhviliwIKit1TMcBKGVo7LEjxb5w=;
        b=TFrCKsA927/WogbYCc+mwIPy2wqdfAAG3iQa4Rgz3K+GWsvY83ifs/+30oqR6S9Zlq
         JUilrIEYbY53EZzJ+rF8yoIJ2S54Cib4Zy2sDV8Y/doWhVDFVZ7tCh3+jaAnH847NK82
         Po16wgKVCGLpthVlDW97XFJRGU2uQSdEG+497HYBnz1Wlf6nBl0XBI8j7y7RpJDcof4n
         2AiZHmar6ElHeLWnkbbHxxR6JbH3RRxHQTWNTZ3liyrqwYY2SpTFWpt9QO12OUjfVoX1
         o9hTkpUBcKBqix7w/n/62WnO1u89gmYrrYUSWb+ocOEhI+4p7EJVnsRNeybXNDbatdPQ
         FLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=kPwHsM5ou4zTiMgJhviliwIKit1TMcBKGVo7LEjxb5w=;
        b=nX5VsETUZZqs0ZiPtnn7i8Tr/+IDIy4BhvSB57H+7rY8FHlDDyq2IhT//JTZeeTc/j
         jP6WrCXVw1OOR77El5R+rWtTYpPiTmeYWy3Dwrtlnl+hYIaZppnPooRP36QIbZVKKemq
         j4zbJh3Ud7yG01HK/nRy/G/cqgtRK8Ag5qaLzsautW44Sa3y2Vf9WHEzMmuYc/NdrCS9
         mIagJaLMLSx17SUMVtK4i4jEW/J9BMy1Yjmks9bSn3D8WHkvFg6Mw5DddcRIg1S7QFYh
         bLrDq+vDQm4RKUlR2zp8a2AOGhgZ5HJF7IGdhMQUy3vQG/jYWhyeLLdlGLven+HBE1Vl
         HdoQ==
X-Gm-Message-State: AGi0PuZYDFFapc+akw8oH2kbqtj52we4jnFBllkSH19duWl4izbm77M5
        FE8aF0aKfzf1YRkKBY4AhFWDKBhqgInOGtyIAGk=
X-Google-Smtp-Source: APiQypLmNIFhvhAU3zGvQ9gFRM4pnRt++LfJOgODNpOG9NWPxc5POes4WaPyvnGFj387ksS3DJ7gQ5XGmj4mur+YDrU=
X-Received: by 2002:a67:ce07:: with SMTP id s7mr1267353vsl.134.1587039972470;
 Thu, 16 Apr 2020 05:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
In-Reply-To: <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 16 Apr 2020 14:26:01 +0200
Message-ID: <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com>
Subject: Re: [PATCH man-pages v4] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux btrfs Developers List <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Omar,

(Unless you CC both me and mtk.manpages@gmail.com, it's easily
possible that I will miss your man-pages patches.)

What's the status here? I presume the features documented here are not
yet merged, right? Is the aim still to have them merged in the future?

Thanks,

Michael

On Sat, 29 Feb 2020 at 00:16, Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This adds a new page, encoded_io(7), providing an overview of encoded
> I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> reference it.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  man2/fcntl.2      |  10 +-
>  man2/open.2       |  13 ++
>  man2/readv.2      |  64 ++++++++++
>  man7/encoded_io.7 | 298 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 384 insertions(+), 1 deletion(-)
>  create mode 100644 man7/encoded_io.7
>
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index bb1ac1f5d..15a1010a6 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -222,8 +222,9 @@ On Linux, this command can change only the
>  .BR O_ASYNC ,
>  .BR O_DIRECT ,
>  .BR O_NOATIME ,
> +.BR O_NONBLOCK ,
>  and
> -.B O_NONBLOCK
> +.B O_ALLOW_ENCODED
>  flags.
>  It is not possible to change the
>  .BR O_DSYNC
> @@ -1821,6 +1822,13 @@ Attempted to clear the
>  flag on a file that has the append-only attribute set.
>  .TP
>  .B EPERM
> +Attempted to set the
> +.B O_ALLOW_ENCODED
> +flag and the calling process did not have the
> +.B CAP_SYS_ADMIN
> +capability.
> +.TP
> +.B EPERM
>  .I cmd
>  was
>  .BR F_ADD_SEALS ,
> diff --git a/man2/open.2 b/man2/open.2
> index 3ab4ee17b..256cb4247 100644
> --- a/man2/open.2
> +++ b/man2/open.2
> @@ -421,6 +421,14 @@ was followed by a call to
>  .BR fdatasync (2)).
>  .IR "See NOTES below" .
>  .TP
> +.B O_ALLOW_ENCODED
> +Open the file with encoded I/O permissions;
> +see
> +.BR encoded_io (7).
> +The caller must have the
> +.B CAP_SYS_ADMIN
> +capability.
> +.TP
>  .B O_EXCL
>  Ensure that this call creates the file:
>  if this flag is specified in conjunction with
> @@ -1176,6 +1184,11 @@ did not match the owner of the file and the caller was not privileged.
>  The operation was prevented by a file seal; see
>  .BR fcntl (2).
>  .TP
> +.B EPERM
> +The
> +.B O_ALLOW_ENCODED
> +flag was specified, but the caller was not privileged.
> +.TP
>  .B EROFS
>  .I pathname
>  refers to a file on a read-only filesystem and write access was
> diff --git a/man2/readv.2 b/man2/readv.2
> index af27aa63e..8b5458023 100644
> --- a/man2/readv.2
> +++ b/man2/readv.2
> @@ -265,6 +265,11 @@ the data is always appended to the end of the file.
>  However, if the
>  .I offset
>  argument is \-1, the current file offset is updated.
> +.TP
> +.BR RWF_ENCODED " (since Linux 5.7)"
> +Read or write encoded (e.g., compressed) data.
> +See
> +.BR encoded_io (7).
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
> @@ -314,6 +326,58 @@ is less than zero or greater than the permitted maximum.
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
> +.B O_ALLOW_ENCODED
> +flag.
> +.PP
> +.BR preadv2 ()
> +can fail for the following reasons:
> +.TP
> +.B E2BIG
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and
> +.I iov[0]
> +is not large enough to return the encoding metadata.
> +.TP
> +.B ENOBUFS
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and the buffers in
> +.I iov
> +are not big enough to return the encoded data.
> +.PP
> +.BR pwritev2 ()
> +can fail for the following reasons:
> +.TP
> +.B E2BIG
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and
> +.I iov[0]
> +contains non-zero fields
> +after the kernel's
> +.IR "sizeof(struct\ encoded_iov)" .
> +.TP
> +.B EINVAL
> +.B RWF_ENCODED
> +is specified in
> +.I flags
> +and the alignment and/or size requirements are not met.
>  .SH VERSIONS
>  .BR preadv ()
>  and
> diff --git a/man7/encoded_io.7 b/man7/encoded_io.7
> new file mode 100644
> index 000000000..72b40353f
> --- /dev/null
> +++ b/man7/encoded_io.7
> @@ -0,0 +1,298 @@
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
> +.TH ENCODED_IO  7 2019-10-14 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +encoded_io \- overview of encoded I/O
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
> +    __aligned_u64 len;
> +    __aligned_u64 unencoded_len;
> +    __aligned_u64 unencoded_offset;
> +    __u32 compression;
> +    __u32 encryption;
> +};
> +.EE
> +.in
> +.PP
> +This may be extended in the future, so
> +.I iov[0].iov_len
> +must be set to
> +.I "sizeof(struct\ encoded_iov)"
> +for forward/backward compatibility.
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
> +(less than or equal to
> +.IR unencoded_len ).
> +.I len
> +is the length of the data in the file
> +(less than or equal to
> +.I unencoded_len
> +-
> +.IR unencoded_offset ).
> +.I
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
> +If the unencoded data is actually longer than
> +.IR unencoded_len ,
> +then it is truncated;
> +if it is shorter, then it is extended with zeroes.
> +.PP
> +For
> +.BR pwritev2 (),
> +the metadata should be specified in
> +.IR iov[0] .
> +If
> +.I iov[0].iov_len
> +is less than
> +.I "sizeof(struct\ encoded_iov)"
> +in the kernel,
> +then any fields unknown to userspace are treated as if they were zero;
> +if it is greater and any fields unknown to the kernel are non-zero,
> +then this returns -1 and sets
> +.I errno
> +to
> +.BR E2BIG .
> +The encoded data should be passed in the remaining buffers.
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
> +then a subsequent read may return an error.
> +.PP
> +For
> +.BR preadv2 (),
> +the metadata is returned in
> +.IR iov[0] .
> +If
> +.I iov[0].iov_len
> +is less than
> +.I "sizeof(struct\ encoded_iov)"
> +in the kernel and any fields unknown to userspace are non-zero,
> +then this returns -1 and sets
> +.I errno
> +to
> +.BR E2BIG ;
> +if it is greater,
> +then any fields unknown to the kernel are returned as zero.
> +The encoded data is returned in the remaining buffers.
> +If the provided buffers are not large enough to return an entire encoded
> +extent,
> +then this returns -1 and sets
> +.I errno
> +to
> +.BR ENOBUFS .
> +This returns the number of encoded bytes read.
> +If the
> +.I offset
> +argument to
> +.BR preadv2 ()
> +is -1, then the file offset is incremented by
> +.IR len .
> +This will only return one encoded extent per call.
> +This can also read data which is not encoded;
> +all encoding fields will be zero in that case.
> +.PP
> +As the filesystem page cache typically contains decoded data,
> +encoded I/O bypasses the page cache.
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
> +Btrfs (since Linux 5.8)
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
> +The length of the encoded data must be less than or equal to
> +.IR unencoded_len .
> +.RE
> --
> 2.25.1
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
