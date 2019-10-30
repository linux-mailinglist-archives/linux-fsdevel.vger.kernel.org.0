Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CFEA618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 23:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJ3WVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 18:21:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39199 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfJ3WVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:21:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so2657255pff.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4rD/YLTgUUO37eXnMoEX7LG852zHvHdMKPwSJzGhLcQ=;
        b=W211RSmewW4nj+s7+I17TPMWuTfYAc8Yp3URJCVuN6vHINpUHTil5JjgogYn2iWLKM
         dkv/NtcRq2sTa4u+6ITAj/HnQbhKes8dMRaVUJNBrxyil0OH5kd86sN4KMidpTLTe3Lk
         l8xCAKbc1yGBNhLOGhMj2yABTxmi+gTIcIIWiD4RlHZ/2yKinzkEN+V1euOst9smn5WV
         1dKOGNHpOcBah1g9u7BK8GrPz5ATSI8y+g0CQTiLwOWKh1MMK8PFT3XeWrSKCMgbgq+w
         YqIbo2panq/8fHfZvhqShiBCv/y6hHtHyM/3RriddaMh3ppIZ8ydbaS2Q2QiGJHekDTV
         Bafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4rD/YLTgUUO37eXnMoEX7LG852zHvHdMKPwSJzGhLcQ=;
        b=N6WCCUP51VGF94Yffu87QzpsJmBR8C7zxQJ0z7oNyO5UobWlkBrrJcmGYE7QMCFBuz
         HNFcucqJVZGIUsBz+/trhaLb9Y8pOGfZFIWaXGOgZtB7bnLVhyvBQFaAaT/k1oVoYWmJ
         o+J1KzqkfPbWwZIZVWi/t8lEFLOBpQuQMA7Wb2xfSw5pbRPOyyGpP8dBIz3o1PeQT5QO
         o0Wka96au0Llp1aMGyLHp9IygBtIRUtpVWk1yhcmgvqs/b+SmYEVp/dfUr9gBzUOba8O
         p0qitT3qy84YraZ7UPmLpdxWLE8eNZOacnp7XX2SU62XViJ1P8UizJ7fqkwZc6F8imB6
         FkOQ==
X-Gm-Message-State: APjAAAXojohgZF6VtiXdCdNHW+oLgZhbvIiYD/TfqUFPWpQlBZRTCAb3
        hARcjB5u1pqgPvdG6dX54CKBXg==
X-Google-Smtp-Source: APXvYqyv0fUgFZhKhT4KJDb+g64d0g4aOEGSVCnmLp5+Y67SP4y6SvH1yEt/IW8bJBXmZYCjz+LIMw==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr2031360pgh.212.1572474089619;
        Wed, 30 Oct 2019 15:21:29 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3912])
        by smtp.gmail.com with ESMTPSA id 184sm1046255pfu.58.2019.10.30.15.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:21:28 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:21:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
Message-ID: <20191030222127.GD326591@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
 <20191021182806.GA6706@magnolia>
 <20191021183831.mbe4q2beqo76fqxm@yavin.dot.cyphar.com>
 <20191021190010.GC6726@magnolia>
 <20191022013717.enwdmox4b7la4i74@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022013717.enwdmox4b7la4i74@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:37:17PM +1100, Aleksa Sarai wrote:
> On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Tue, Oct 22, 2019 at 05:38:31AM +1100, Aleksa Sarai wrote:
> > > On 2019-10-21, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > On Tue, Oct 15, 2019 at 11:42:40AM -0700, Omar Sandoval wrote:
> > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > 
> > > > > Btrfs supports transparent compression: data written by the user can be
> > > > > compressed when written to disk and decompressed when read back.
> > > > > However, we'd like to add an interface to write pre-compressed data
> > > > > directly to the filesystem, and the matching interface to read
> > > > > compressed data without decompressing it. This adds support for
> > > > > so-called "encoded I/O" via preadv2() and pwritev2().
> > > > > 
> > > > > A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> > > > > this flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > > > is used for metadata: namely, the compression algorithm, unencoded
> > > > > (i.e., decompressed) length, and what subrange of the unencoded data
> > > > > should be used (needed for truncated or hole-punched extents and when
> > > > > reading in the middle of an extent). For reads, the filesystem returns
> > > > > this information; for writes, the caller provides it to the filesystem.
> > > > > iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> > > > > used to extend the interface in the future. The remaining iovecs contain
> > > > > the encoded extent.
> > > > > 
> > > > > Filesystems must indicate that they support encoded writes by setting
> > > > > FMODE_ENCODED_IO in ->file_open().
> > > > > 
> > > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > > ---
> > > > >  include/linux/fs.h      | 14 +++++++
> > > > >  include/uapi/linux/fs.h | 26 ++++++++++++-
> > > > >  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
> > > > >  3 files changed, 108 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > > index e0d909d35763..54681f21e05e 100644
> > > > > --- a/include/linux/fs.h
> > > > > +++ b/include/linux/fs.h
> > > > > @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> > > > >  /* File does not contribute to nr_files count */
> > > > >  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
> > > > >  
> > > > > +/* File supports encoded IO */
> > > > > +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> > > > > +
> > > > >  /*
> > > > >   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
> > > > >   * that indicates that they should check the contents of the iovec are
> > > > > @@ -314,6 +317,7 @@ enum rw_hint {
> > > > >  #define IOCB_SYNC		(1 << 5)
> > > > >  #define IOCB_WRITE		(1 << 6)
> > > > >  #define IOCB_NOWAIT		(1 << 7)
> > > > > +#define IOCB_ENCODED		(1 << 8)
> > > > >  
> > > > >  struct kiocb {
> > > > >  	struct file		*ki_filp;
> > > > > @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, int);
> > > > >  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
> > > > >  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> > > > >  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> > > > > +struct encoded_iov;
> > > > > +extern int generic_encoded_write_checks(struct kiocb *, struct encoded_iov *);
> > > > > +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
> > > > > +extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
> > > > > +				struct iov_iter *);
> > > > >  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
> > > > >  				struct file *file_out, loff_t pos_out,
> > > > >  				loff_t *count, unsigned int remap_flags);
> > > > > @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> > > > >  			return -EOPNOTSUPP;
> > > > >  		ki->ki_flags |= IOCB_NOWAIT;
> > > > >  	}
> > > > > +	if (flags & RWF_ENCODED) {
> > > > > +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> > > > > +			return -EOPNOTSUPP;
> > > > > +		ki->ki_flags |= IOCB_ENCODED;
> > > > > +	}
> > > > >  	if (flags & RWF_HIPRI)
> > > > >  		ki->ki_flags |= IOCB_HIPRI;
> > > > >  	if (flags & RWF_DSYNC)
> > > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > > index 379a612f8f1d..ed92a8a257cb 100644
> > > > > --- a/include/uapi/linux/fs.h
> > > > > +++ b/include/uapi/linux/fs.h
> > > > > @@ -284,6 +284,27 @@ struct fsxattr {
> > > > >  
> > > > >  typedef int __bitwise __kernel_rwf_t;
> > > > >  
> > > > > +enum {
> > > > > +	ENCODED_IOV_COMPRESSION_NONE,
> > > > > +	ENCODED_IOV_COMPRESSION_ZLIB,
> > > > > +	ENCODED_IOV_COMPRESSION_LZO,
> > > > > +	ENCODED_IOV_COMPRESSION_ZSTD,
> > > > > +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> > > > > +};
> > > > > +
> > > > > +enum {
> > > > > +	ENCODED_IOV_ENCRYPTION_NONE,
> > > > > +	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> > > > > +};
> > > > > +
> > > > > +struct encoded_iov {
> > > > > +	__u64 len;
> > > > > +	__u64 unencoded_len;
> > > > > +	__u64 unencoded_offset;
> > > > > +	__u32 compression;
> > > > > +	__u32 encryption;
> > > > 
> > > > Can we add some must-be-zero padding space at the end here for whomever
> > > > comes along next wanting to add more encoding info?
> > > 
> > > I would suggest to copy the extension design of copy_struct_from_user().
> > > Adding must-be-zero padding is a less-ideal solution to the extension
> > > problem than length-based extension.
> > 
> > Come to think of it, you /do/ have to specify iov_len so... yeah, do
> > that instead; we can always extend the structure later.
> > 
> > > Also (I might be wrong) but shouldn't the __u64s be __aligned_u64 (as
> > > with syscall structure arguments)?
> > 
> > <shrug> No idea, that's the first I've heard of that type and it doesn't
> > seem to be used by the fs code.  Why would we care about alignment for
> > an incore structure?
> 
> When passing u64s from userspace, it's generally considered a good idea
> to use __aligned_u64 -- the main reason is that 32-bit userspace on a
> 64-bit kernel will use different structure alignment for 64-bit fields.
> 
> This means you'd need to implement a bunch of COMPAT_SYSCALL-like
> handling for that case. It's much simpler to use __aligned_u64 (and on
> the plus side I don't think you need to add any fields to ensure the
> padding is zero).

I'll used __aligned_u64 for the next submission.
