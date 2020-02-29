Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF330174635
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 11:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgB2K24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 05:28:56 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44818 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgB2K24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:28:56 -0500
Received: by mail-il1-f193.google.com with SMTP id x7so5078563ilq.11;
        Sat, 29 Feb 2020 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6soXnreFhiLOSWkknvJdeg3Yaqsoja1tXZ4FhCjte5U=;
        b=AGU1RiEHkOchjo5dKHE5MR4axgGTDMyvm3sMwIvHuJU9OsSsjbt7XZ3CEEgnZ/hN4r
         07TAfTfXoK/ht9glOlcYetmoxS1BuLaU+aKCjwKgQJkYV254fFjZydbNhyvX+0IRhH0S
         lASA4nTjlTZbR3cCS47PplihcbXF9/fKR3ZoVnXfo4uW7JYaVv18yPdV6cgVWRHGnOpb
         tMGhfDOiFzMJZwxtGs8+/mfxaNXzmO+DfcvUwRIsJqHj7ZOe3IMH9YUnAd5H4mvalgeQ
         Tf+lT7zriFCybLmna+VJRDlMaD2VCDDZTAW5d5MiG1NWCfVwrFyITnzHEefAslTSHIh5
         iX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6soXnreFhiLOSWkknvJdeg3Yaqsoja1tXZ4FhCjte5U=;
        b=Ixc6FDOe2IPfBv463g8v76C5U7fE+pkUZtzbKpYvBc8nVepPHSC/OR96+w1ZnZ6CKa
         Q7E98NAhnvp7jvUYAoMhsmwxr4Z1z28kvGX87NDeESOpfh8CqphxhP65ljMgc4FLPxdR
         Iby+7GUcKe5II73EfY4kGEDXgbrQkN/ipv9ywj+Z1b30fxIwdUE4igMI7AVzJY/aZRHm
         9qYjN/NeeAMfnlQwBccmSLUCWjlHlqx6ItpR1UK+luFjKyGFqYGJyqVzrgRJSyLUahdR
         gSk/+0ziuvO0yLI5Pb6sN0QVQHBFdL6sw/0hJvWM8PRno4+2oZbGT5STLW6hQJUyygb5
         F1IQ==
X-Gm-Message-State: APjAAAXLltTozacraN9CaVO7DD1fxc1nMWYZ5bWfNwMmGT5qrrtUN1sC
        k4P+I1efSjWFvrjJjOpa3DpYNuqdTXWjkXv4Lxo=
X-Google-Smtp-Source: APXvYqxqKmpfI/wHw2PtOEfwSHma5sY5tFbujXs2VFal/ky16cm3BXBPQQKfnfQGdW7bjuGBWQl1EbGQWkMvVn4VUas=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr8300215ili.72.1582972133413;
 Sat, 29 Feb 2020 02:28:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
In-Reply-To: <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 Feb 2020 12:28:41 +0200
Message-ID: <CAOQ4uxgym1C3JZHrLhBmEh_T7UbQOukxTBKVzHqp4NSdjredSg@mail.gmail.com>
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

This new API can generate many diverse error conditions that the standard errno
codes are not rich enough to describe.
Maybe add room for encoded io specific error codes in the metadata structure
would be good practice, for example:
- compression method not supported
- encryption method not supported
- the combination of enc/comp is not supported
- and so on


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

I find the unencoded_len/unencoded_offset API extremely confusing and all
the clarifications above did not help to ease this feeling.
Please remind me why does the API need to expose unencoded details at all.
I understand the backup/restore use case for read/write encoded data.
I do not understand how unencoded offset info is relevant to this use case
or what are the other use cases it is relevant for.

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

Sigh! If I were an attacker I would be drooling right now.
We want to create a new API to read/write raw encrypted data (even though
you have not implemented any encryption yet) and we use the same old
vulnerable practices that security people have been fighting for decades?
I am not very comfortable with this attitude.
I think we should be much more prudent for the first version of the API.

How about not allowing to set O_ALLOW_ENCODED without O_CLOEXEC.
We may or may not allow to clear O_CLOEXEC while O_ALLOW_ENCODED
is set, in case this is the user intention, but leaving the API as it is is just
asking for trouble IMO.

Thanks,
Amir.
