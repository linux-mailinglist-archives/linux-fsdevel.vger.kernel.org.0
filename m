Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D755A17463E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB2KlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 05:41:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42530 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2KlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:41:10 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so5124251ila.9;
        Sat, 29 Feb 2020 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndLrfb06U+DoCAOoYsQDJNouQEgZz0tTOQuZfvG0lFQ=;
        b=OYuH5hmyfB76zoCLpZh4RZ9rucq1fK/fvCbqhDL4vDgVPzc1aLQy5tzhMBmlTz0fxX
         vInlhPf2Vw7tKscML6m20Z58IlJXTF3R2C4uhcvIzgOQntrMvlEP94K0RpJoLTDrpLCf
         gikvD6A79hFjv/qLYtsp0lijgyItkKI9TRUqWVNoQ1pwhfCv4RjVFj5z+bHK5V2Ui9+8
         +BdIsXPF44n5YYVPlJ9GcepO3yVwREMmCYwCSf5m37NQTWVhm2QJhA+ImN2mPr04wb9o
         fdJXH1TkrVpnLHlX9+eGmdNF9We7YjnUFhInBRT7zo/JEI8gkc19fv21UQbw/1e2wd/z
         vrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndLrfb06U+DoCAOoYsQDJNouQEgZz0tTOQuZfvG0lFQ=;
        b=bpJGr9R718XbPeXJ1cmaBFa/uDkk1D3uGhscIaa5pn6ZqdttLPvQN0nl4ThdKjEnFb
         Iktyl9wKFaiajHIH57duAvGi37+RbnN+7Jlp2w8B7raA71H8Mv7vVQPornT1qqNmrfmr
         zEEOHhqFUG01JKCCFhiu8QNy+44rYy268DXnywCtF/5zf3K53CtOuinejMkuYkDlmujc
         vzNwDt9Jz7bXutuFALlw+DXgHMra+XEJelJxNtnqHFEg/XYWQQICbc/87wYCcilvZRXY
         f4X+pdUAOlIr1X9/UQ3l97AAL00ONY/Bj9+TP+JSCxiCS8W970F3SLsA891/rIkKTCCN
         2Dqw==
X-Gm-Message-State: APjAAAWl0ybJsa/CosCJh4w+eu2kvHNzbyqYvAdNRGgOAYR6D2830GPO
        A69wvEqBuSqTQhjMYhIQS9210Hp8tmOQ6nFEFi4gPbB5
X-Google-Smtp-Source: APXvYqyEBMqhY7zv3d8ncYX6Z4Wnnby6H/2LqRMU2jm4xe7qA7T5Kush4anRm1M3LQyDj8pl5DiqEf6hBqDJ7TMVJX0=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr8230109ilc.275.1582972869491;
 Sat, 29 Feb 2020 02:41:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <4f8b9a66f5f6efdb9cab566581acb292f0b5b528.1582930832.git.osandov@fb.com>
In-Reply-To: <4f8b9a66f5f6efdb9cab566581acb292f0b5b528.1582930832.git.osandov@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 Feb 2020 12:40:58 +0200
Message-ID: <CAOQ4uxi_KRZFiEsDj_yn0f+Zo4tgAkKKcuAp3jiAmB4r7xjiEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] fs: add RWF_ENCODED for reading/writing compressed data
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

On Sat, Feb 29, 2020 at 1:14 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Btrfs supports transparent compression: data written by the user can be
> compressed when written to disk and decompressed when read back.
> However, we'd like to add an interface to write pre-compressed data
> directly to the filesystem, and the matching interface to read
> compressed data without decompressing it. This adds support for
> so-called "encoded I/O" via preadv2() and pwritev2().
>
> A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> this flag is set, iov[0].iov_base points to a struct encoded_iov which
> is used for metadata: namely, the compression algorithm, unencoded
> (i.e., decompressed) length, and what subrange of the unencoded data
> should be used (needed for truncated or hole-punched extents and when
> reading in the middle of an extent). For reads, the filesystem returns
> this information; for writes, the caller provides it to the filesystem.
> iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> used to extend the interface in the future a la copy_struct_from_user().
> The remaining iovecs contain the encoded extent.
>
> This adds the VFS helpers for supporting encoded I/O and documentation
> for filesystem support.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  Documentation/filesystems/encoded_io.rst |  74 ++++++++++
>  Documentation/filesystems/index.rst      |   1 +
>  include/linux/fs.h                       |  16 +++
>  include/uapi/linux/fs.h                  |  33 ++++-
>  mm/filemap.c                             | 166 +++++++++++++++++++++--
>  5 files changed, 276 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/filesystems/encoded_io.rst
>
> diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
> new file mode 100644
> index 000000000000..50405276d866
> --- /dev/null
> +++ b/Documentation/filesystems/encoded_io.rst
> @@ -0,0 +1,74 @@
> +===========
> +Encoded I/O
> +===========
> +
> +Encoded I/O is a mechanism for reading and writing encoded (e.g., compressed
> +and/or encrypted) data directly from/to the filesystem. The userspace interface
> +is thoroughly described in the :manpage:`encoded_io(7)` man page; this document
> +describes the requirements for filesystem support.
> +
> +First of all, a filesystem supporting encoded I/O must indicate this by setting
> +the ``FMODE_ENCODED_IO`` flag in its ``file_open`` file operation::
> +
> +    static int foo_file_open(struct inode *inode, struct file *filp)
> +    {
> +            ...
> +            filep->f_mode |= FMODE_ENCODED_IO;
> +            ...
> +    }
> +
> +Encoded I/O goes through ``read_iter`` and ``write_iter``, designated by the
> +``IOCB_ENCODED`` flag in ``kiocb->ki_flags``.
> +
> +Reads
> +=====
> +
> +Encoded ``read_iter`` should:
> +
> +1. Call ``generic_encoded_read_checks()`` to validate the file and buffers
> +   provided by userspace.
> +2. Initialize the ``encoded_iov`` appropriately.
> +3. Copy it to the user with ``copy_encoded_iov_to_iter()``.
> +4. Copy the encoded data to the user.
> +5. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> +6. Return the size of the encoded data read, not including the ``encoded_iov``.
> +
> +There are a few details to be aware of:
> +
> +* Encoded ``read_iter`` should support reading unencoded data if the extent is
> +  not encoded.
> +* If the buffers provided by the user are not large enough to contain an entire
> +  encoded extent, then ``read_iter`` should return ``-ENOBUFS``. This is to
> +  avoid confusing userspace with truncated data that cannot be properly
> +  decoded.
> +* Reads in the middle of an encoded extent can be returned by setting
> +  ``encoded_iov->unencoded_offset`` to non-zero.
> +* Truncated unencoded data (e.g., because the file does not end on a block
> +  boundary) may be returned by setting ``encoded_iov->len`` to a value smaller
> +  value than ``encoded_iov->unencoded_len - encoded_iov->unencoded_offset``.
> +
> +Writes
> +======
> +
> +Encoded ``write_iter`` should (in addition to the usual accounting/checks done
> +by ``write_iter``):
> +
> +1. Call ``copy_encoded_iov_from_iter()`` to get and validate the
> +   ``encoded_iov``.
> +2. Call ``generic_encoded_write_checks()`` instead of
> +   ``generic_write_checks()``.
> +3. Check that the provided encoding in ``encoded_iov`` is supported.
> +4. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> +5. Return the size of the encoded data written.
> +
> +Again, there are a few details:
> +
> +* Encoded ``write_iter`` doesn't need to support writing unencoded data.
> +* ``write_iter`` should either write all of the encoded data or none of it; it
> +  must not do partial writes.
> +* ``write_iter`` doesn't need to validate the encoded data; a subsequent read
> +  may return, e.g., ``-EIO`` if the data is not valid.
> +* The user may lie about the unencoded size of the data; a subsequent read
> +  should truncate or zero-extend the unencoded data rather than returning an
> +  error.
> +* Be careful of page cache coherency.
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 386eaad008b2..e074a3f1f856 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -37,6 +37,7 @@ filesystem implementations.
>     journalling
>     fscrypt
>     fsverity
> +   encoded_io
>
>  Filesystems
>  ===========
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..aa7efd3430d1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT                ((__force fmode_t)0x20000000)
>
> +/* File supports encoded IO */
> +#define FMODE_ENCODED_IO       ((__force fmode_t)0x40000000)
> +
>  /*
>   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
>   * that indicates that they should check the contents of the iovec are
> @@ -314,6 +317,7 @@ enum rw_hint {
>  #define IOCB_SYNC              (1 << 5)
>  #define IOCB_WRITE             (1 << 6)
>  #define IOCB_NOWAIT            (1 << 7)
> +#define IOCB_ENCODED           (1 << 8)
>
>  struct kiocb {
>         struct file             *ki_filp;
> @@ -3109,6 +3113,13 @@ extern int sb_min_blocksize(struct super_block *, int);
>  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
>  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
>  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> +struct encoded_iov;
> +extern int generic_encoded_write_checks(struct kiocb *,
> +                                       const struct encoded_iov *);
> +extern int copy_encoded_iov_from_iter(struct encoded_iov *, struct iov_iter *);
> +extern ssize_t generic_encoded_read_checks(struct kiocb *, struct iov_iter *);
> +extern int copy_encoded_iov_to_iter(const struct encoded_iov *,
> +                                   struct iov_iter *);
>  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
>                                 struct file *file_out, loff_t pos_out,
>                                 loff_t *count, unsigned int remap_flags);
> @@ -3434,6 +3445,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>                         return -EOPNOTSUPP;
>                 ki->ki_flags |= IOCB_NOWAIT;
>         }
> +       if (flags & RWF_ENCODED) {
> +               if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> +                       return -EOPNOTSUPP;
> +               ki->ki_flags |= IOCB_ENCODED;
> +       }
>         if (flags & RWF_HIPRI)
>                 ki->ki_flags |= IOCB_HIPRI;
>         if (flags & RWF_DSYNC)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 379a612f8f1d..f8c6c1e08def 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -278,6 +278,34 @@ struct fsxattr {
>                                          SYNC_FILE_RANGE_WAIT_BEFORE | \
>                                          SYNC_FILE_RANGE_WAIT_AFTER)
>
> +enum {
> +       ENCODED_IOV_COMPRESSION_NONE,
> +#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
> +       ENCODED_IOV_COMPRESSION_ZLIB,
> +#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
> +       ENCODED_IOV_COMPRESSION_LZO,
> +#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
> +       ENCODED_IOV_COMPRESSION_ZSTD,
> +#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
> +       ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> +};
> +
> +enum {
> +       ENCODED_IOV_ENCRYPTION_NONE,
> +#define ENCODED_IOV_ENCRYPTION_NONE ENCODED_IOV_ENCRYPTION_NONE
> +       ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> +};
> +

What are those defines???

> +struct encoded_iov {
> +       __aligned_u64 len;
> +       __aligned_u64 unencoded_len;
> +       __aligned_u64 unencoded_offset;
> +       __u32 compression;
> +       __u32 encryption;
> +};
> +
[...]

> +/**
> + * copy_encoded_iov_from_iter() - copy a &struct encoded_iov from userspace
> + * @encoded: Returned encoding metadata.
> + * @from: Source iterator.
> + *
> + * This copies in the &struct encoded_iov and does some basic sanity checks.
> + * This should always be used rather than a plain copy_from_iter(), as it does
> + * the proper handling for backward- and forward-compatibility.
> + *
> + * Return: 0 on success, -EFAULT if access to userspace failed, -E2BIG if the
> + *         copied structure contained non-zero fields that this kernel doesn't
> + *         support, -EINVAL if the copied structure was invalid.
> + */
> +int copy_encoded_iov_from_iter(struct encoded_iov *encoded,
> +                              struct iov_iter *from)
> +{
> +       size_t usize;
> +       int ret;
> +
> +       usize = iov_iter_single_seg_count(from);
> +       if (usize > PAGE_SIZE)
> +               return -E2BIG;
> +       if (usize < ENCODED_IOV_SIZE_VER0)
> +               return -EINVAL;
> +       ret = copy_struct_from_iter(encoded, sizeof(*encoded), from, usize);
> +       if (ret)
> +               return ret;
> +
> +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE)
> +               return -EINVAL;
> +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> +               return -EINVAL;
> +       if (encoded->unencoded_offset > encoded->unencoded_len)
> +               return -EINVAL;
> +       if (encoded->len > encoded->unencoded_len - encoded->unencoded_offset)
> +               return -EINVAL;
> +       return 0;
> +}

Repeating my comment from man page review:
It would be nice if a more granular error ENCODED_IOV_ERR_XXX code could be
set in the  encoded_iov struct.

Thanks,
Amir.
