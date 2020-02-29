Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2C174897
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgB2SK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 13:10:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40897 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgB2SK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:10:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2530580plp.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sy8AOJ/15eT2KVP4UWt2JpZHRiEAQnmxmL1o6lYero=;
        b=boYMWy0uH+IGGQmZ9jR9o/oMeVuC1J2Vk0aQ4D2AJNgzv3nUtfC9EIbHaRI6i34gPM
         SbkrlyvZArKyc4DPoNXiYhlrvZn5dJNu4CfnBhWX901WWM9vTpB3uBlLfW5jbtWrSjyo
         eo4HOrEdyMyaUzvNWnK9V9mTH1+ZoBKjbNRfBGDx2In7lCAptkh5Uv2tyolS0IgUm4cR
         gXzx3q2/uy3u//9LAxtkRuVB8T3qFjf9e2w/FoBBawSCIHs2k3Q1i+pN7Dbza8GvyuC/
         JXZFYjEtriuIs7gT4que4PlLtylT4e6HTqDLfvao16GrS3JequXyBMiemXgY+d8lXe6A
         DBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sy8AOJ/15eT2KVP4UWt2JpZHRiEAQnmxmL1o6lYero=;
        b=WvYK74z5RktM653KBIwmZYFRGr8nr1h1t4wujnkUFApqOxT9vw/X8g+DlnNCSt3zh6
         cQZAsXeLkBbrPse8A/zQXkKgXUU8bsbQn8Hcul7wXdGS1dy7nxZ5C+HHrHd7A0gDgQ4s
         0XpGfHqZSOp1EBBGblAVJ/BRFqXGewB8uwVdSf62GnNJuUFBfW8KdLOOCG+4IXZrQukq
         AVwfF1vt3oBS1ccaCF95XTNmVWkOsM5CfjvE7PWegT5CMJ+A0okTu7VsnxygvxAV+xta
         +zBXWLpRgUfOrXuUaevVRtGzu6i7AF+ephgz+wRtzOVO3HIgERjytYe5c0FABpUlKjZe
         lYWQ==
X-Gm-Message-State: APjAAAW42JetwGLyYyQw6AXp8hL7OQnEbBLzYVA7NvdJGtWb4QvYP9MZ
        9alSmP2w+B0nMae/Id6/QfeJDA==
X-Google-Smtp-Source: APXvYqybeS5MbSric+KrWp1UODE4dnY4mGpqShiZFnfzfg5BetSTd/rk0guzRj9/e465cj5luyQuQw==
X-Received: by 2002:a17:902:be04:: with SMTP id r4mr9771281pls.315.1582999857094;
        Sat, 29 Feb 2020 10:10:57 -0800 (PST)
Received: from vader ([2607:fb90:8365:d596:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id l37sm6283692pjb.15.2020.02.29.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 10:10:56 -0800 (PST)
Date:   Sat, 29 Feb 2020 10:10:53 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v4 3/9] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20200229181053.GB157744@vader>
References: <cover.1582930832.git.osandov@fb.com>
 <4f8b9a66f5f6efdb9cab566581acb292f0b5b528.1582930832.git.osandov@fb.com>
 <CAOQ4uxi_KRZFiEsDj_yn0f+Zo4tgAkKKcuAp3jiAmB4r7xjiEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi_KRZFiEsDj_yn0f+Zo4tgAkKKcuAp3jiAmB4r7xjiEA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 12:40:58PM +0200, Amir Goldstein wrote:
> On Sat, Feb 29, 2020 at 1:14 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > Btrfs supports transparent compression: data written by the user can be
> > compressed when written to disk and decompressed when read back.
> > However, we'd like to add an interface to write pre-compressed data
> > directly to the filesystem, and the matching interface to read
> > compressed data without decompressing it. This adds support for
> > so-called "encoded I/O" via preadv2() and pwritev2().
> >
> > A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> > this flag is set, iov[0].iov_base points to a struct encoded_iov which
> > is used for metadata: namely, the compression algorithm, unencoded
> > (i.e., decompressed) length, and what subrange of the unencoded data
> > should be used (needed for truncated or hole-punched extents and when
> > reading in the middle of an extent). For reads, the filesystem returns
> > this information; for writes, the caller provides it to the filesystem.
> > iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> > used to extend the interface in the future a la copy_struct_from_user().
> > The remaining iovecs contain the encoded extent.
> >
> > This adds the VFS helpers for supporting encoded I/O and documentation
> > for filesystem support.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  Documentation/filesystems/encoded_io.rst |  74 ++++++++++
> >  Documentation/filesystems/index.rst      |   1 +
> >  include/linux/fs.h                       |  16 +++
> >  include/uapi/linux/fs.h                  |  33 ++++-
> >  mm/filemap.c                             | 166 +++++++++++++++++++++--
> >  5 files changed, 276 insertions(+), 14 deletions(-)
> >  create mode 100644 Documentation/filesystems/encoded_io.rst
> >
> > diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
> > new file mode 100644
> > index 000000000000..50405276d866
> > --- /dev/null
> > +++ b/Documentation/filesystems/encoded_io.rst
> > @@ -0,0 +1,74 @@
> > +===========
> > +Encoded I/O
> > +===========
> > +
> > +Encoded I/O is a mechanism for reading and writing encoded (e.g., compressed
> > +and/or encrypted) data directly from/to the filesystem. The userspace interface
> > +is thoroughly described in the :manpage:`encoded_io(7)` man page; this document
> > +describes the requirements for filesystem support.
> > +
> > +First of all, a filesystem supporting encoded I/O must indicate this by setting
> > +the ``FMODE_ENCODED_IO`` flag in its ``file_open`` file operation::
> > +
> > +    static int foo_file_open(struct inode *inode, struct file *filp)
> > +    {
> > +            ...
> > +            filep->f_mode |= FMODE_ENCODED_IO;
> > +            ...
> > +    }
> > +
> > +Encoded I/O goes through ``read_iter`` and ``write_iter``, designated by the
> > +``IOCB_ENCODED`` flag in ``kiocb->ki_flags``.
> > +
> > +Reads
> > +=====
> > +
> > +Encoded ``read_iter`` should:
> > +
> > +1. Call ``generic_encoded_read_checks()`` to validate the file and buffers
> > +   provided by userspace.
> > +2. Initialize the ``encoded_iov`` appropriately.
> > +3. Copy it to the user with ``copy_encoded_iov_to_iter()``.
> > +4. Copy the encoded data to the user.
> > +5. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> > +6. Return the size of the encoded data read, not including the ``encoded_iov``.
> > +
> > +There are a few details to be aware of:
> > +
> > +* Encoded ``read_iter`` should support reading unencoded data if the extent is
> > +  not encoded.
> > +* If the buffers provided by the user are not large enough to contain an entire
> > +  encoded extent, then ``read_iter`` should return ``-ENOBUFS``. This is to
> > +  avoid confusing userspace with truncated data that cannot be properly
> > +  decoded.
> > +* Reads in the middle of an encoded extent can be returned by setting
> > +  ``encoded_iov->unencoded_offset`` to non-zero.
> > +* Truncated unencoded data (e.g., because the file does not end on a block
> > +  boundary) may be returned by setting ``encoded_iov->len`` to a value smaller
> > +  value than ``encoded_iov->unencoded_len - encoded_iov->unencoded_offset``.
> > +
> > +Writes
> > +======
> > +
> > +Encoded ``write_iter`` should (in addition to the usual accounting/checks done
> > +by ``write_iter``):
> > +
> > +1. Call ``copy_encoded_iov_from_iter()`` to get and validate the
> > +   ``encoded_iov``.
> > +2. Call ``generic_encoded_write_checks()`` instead of
> > +   ``generic_write_checks()``.
> > +3. Check that the provided encoding in ``encoded_iov`` is supported.
> > +4. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
> > +5. Return the size of the encoded data written.
> > +
> > +Again, there are a few details:
> > +
> > +* Encoded ``write_iter`` doesn't need to support writing unencoded data.
> > +* ``write_iter`` should either write all of the encoded data or none of it; it
> > +  must not do partial writes.
> > +* ``write_iter`` doesn't need to validate the encoded data; a subsequent read
> > +  may return, e.g., ``-EIO`` if the data is not valid.
> > +* The user may lie about the unencoded size of the data; a subsequent read
> > +  should truncate or zero-extend the unencoded data rather than returning an
> > +  error.
> > +* Be careful of page cache coherency.
> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> > index 386eaad008b2..e074a3f1f856 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -37,6 +37,7 @@ filesystem implementations.
> >     journalling
> >     fscrypt
> >     fsverity
> > +   encoded_io
> >
> >  Filesystems
> >  ===========
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3cd4fe6b845e..aa7efd3430d1 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> >  /* File does not contribute to nr_files count */
> >  #define FMODE_NOACCOUNT                ((__force fmode_t)0x20000000)
> >
> > +/* File supports encoded IO */
> > +#define FMODE_ENCODED_IO       ((__force fmode_t)0x40000000)
> > +
> >  /*
> >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
> >   * that indicates that they should check the contents of the iovec are
> > @@ -314,6 +317,7 @@ enum rw_hint {
> >  #define IOCB_SYNC              (1 << 5)
> >  #define IOCB_WRITE             (1 << 6)
> >  #define IOCB_NOWAIT            (1 << 7)
> > +#define IOCB_ENCODED           (1 << 8)
> >
> >  struct kiocb {
> >         struct file             *ki_filp;
> > @@ -3109,6 +3113,13 @@ extern int sb_min_blocksize(struct super_block *, int);
> >  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
> >  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> >  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> > +struct encoded_iov;
> > +extern int generic_encoded_write_checks(struct kiocb *,
> > +                                       const struct encoded_iov *);
> > +extern int copy_encoded_iov_from_iter(struct encoded_iov *, struct iov_iter *);
> > +extern ssize_t generic_encoded_read_checks(struct kiocb *, struct iov_iter *);
> > +extern int copy_encoded_iov_to_iter(const struct encoded_iov *,
> > +                                   struct iov_iter *);
> >  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >                                 struct file *file_out, loff_t pos_out,
> >                                 loff_t *count, unsigned int remap_flags);
> > @@ -3434,6 +3445,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> >                         return -EOPNOTSUPP;
> >                 ki->ki_flags |= IOCB_NOWAIT;
> >         }
> > +       if (flags & RWF_ENCODED) {
> > +               if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > +                       return -EOPNOTSUPP;
> > +               ki->ki_flags |= IOCB_ENCODED;
> > +       }
> >         if (flags & RWF_HIPRI)
> >                 ki->ki_flags |= IOCB_HIPRI;
> >         if (flags & RWF_DSYNC)
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 379a612f8f1d..f8c6c1e08def 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -278,6 +278,34 @@ struct fsxattr {
> >                                          SYNC_FILE_RANGE_WAIT_BEFORE | \
> >                                          SYNC_FILE_RANGE_WAIT_AFTER)
> >
> > +enum {
> > +       ENCODED_IOV_COMPRESSION_NONE,
> > +#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
> > +       ENCODED_IOV_COMPRESSION_ZLIB,
> > +#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
> > +       ENCODED_IOV_COMPRESSION_LZO,
> > +#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
> > +       ENCODED_IOV_COMPRESSION_ZSTD,
> > +#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
> > +       ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> > +};
> > +
> > +enum {
> > +       ENCODED_IOV_ENCRYPTION_NONE,
> > +#define ENCODED_IOV_ENCRYPTION_NONE ENCODED_IOV_ENCRYPTION_NONE
> > +       ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> > +};
> > +
> 
> What are those defines???

They're so you can check whether an enum value is defined in the UAPI
headers via ifdef. E.g., if we were to add
ENCODED_IOV_COMPRESSION_SOME_NEW_ALGORITHM, applications could use:

#ifndef ENCODED_IOV_COMPRESSION_SOME_NEW_ALGORITHM
#define ENCODED_IOV_COMPRESSION_SOME_NEW_ALGORITHM 4
#endif

In my experience, this makes dealing with lagging UAPI headers less
annoying. This is done elsewhere in UAPI headers (e.g.,
include/uapi/linux/in.h).
