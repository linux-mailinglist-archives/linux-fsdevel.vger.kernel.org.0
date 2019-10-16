Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725C0D8CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfJPJuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 05:50:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfJPJuy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:50:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70157B2F6;
        Wed, 16 Oct 2019 09:50:50 +0000 (UTC)
Subject: Re: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
References: <cover.1571164762.git.osandov@fb.com>
 <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <17ed54f3-40c2-2aea-ed9f-9c1307bdf806@suse.com>
Date:   Wed, 16 Oct 2019 12:50:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15.10.19 г. 21:42 ч., Omar Sandoval wrote:
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

In the future when encryption is also supported. What should be the
mechanism to enforce ordering of encoding operations i.e. first compress
then encrypt => uncoded_len should be the resulting size after the
encrypt operation. To me (not being a cryptographer) this seems the
sensible thing to do since compression will be effective that way.
However, what if , for whatever reasons, a different filesystem wants to
support this interface but chooses to do it the other around -> encrypt,
then compress?

> should be used (needed for truncated or hole-punched extents and when
> reading in the middle of an extent). For reads, the filesystem returns
> this information; for writes, the caller provides it to the filesystem.
> iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> used to extend the interface in the future. The remaining iovecs contain
> the encoded extent.
> 
> Filesystems must indicate that they support encoded writes by setting
> FMODE_ENCODED_IO in ->file_open().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  include/linux/fs.h      | 14 +++++++
>  include/uapi/linux/fs.h | 26 ++++++++++++-
>  mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 108 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..54681f21e05e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
>  
> +/* File supports encoded IO */
> +#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
> +
>  /*
>   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
>   * that indicates that they should check the contents of the iovec are
> @@ -314,6 +317,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_ENCODED		(1 << 8)
>  
>  struct kiocb {
>  	struct file		*ki_filp;
> @@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, int);
>  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
>  extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
>  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
> +struct encoded_iov;
> +extern int generic_encoded_write_checks(struct kiocb *, struct encoded_iov *);
> +extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
> +extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
> +				struct iov_iter *);
>  extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				loff_t *count, unsigned int remap_flags);
> @@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  			return -EOPNOTSUPP;
>  		ki->ki_flags |= IOCB_NOWAIT;
>  	}
> +	if (flags & RWF_ENCODED) {
> +		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
> +			return -EOPNOTSUPP;
> +		ki->ki_flags |= IOCB_ENCODED;
> +	}
>  	if (flags & RWF_HIPRI)
>  		ki->ki_flags |= IOCB_HIPRI;
>  	if (flags & RWF_DSYNC)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 379a612f8f1d..ed92a8a257cb 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -284,6 +284,27 @@ struct fsxattr {
>  
>  typedef int __bitwise __kernel_rwf_t;
>  
> +enum {
> +	ENCODED_IOV_COMPRESSION_NONE,
> +	ENCODED_IOV_COMPRESSION_ZLIB,
> +	ENCODED_IOV_COMPRESSION_LZO,
> +	ENCODED_IOV_COMPRESSION_ZSTD,
> +	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
> +};
> +
> +enum {
> +	ENCODED_IOV_ENCRYPTION_NONE,
> +	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
> +};
> +
> +struct encoded_iov {
> +	__u64 len;
> +	__u64 unencoded_len;
> +	__u64 unencoded_offset;
> +	__u32 compression;
> +	__u32 encryption;
> +};
> +
>  /* high priority request, poll if possible */
>  #define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
>  
> @@ -299,8 +320,11 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
>  
> +/* encoded (e.g., compressed or encrypted) IO */

nit: s/or/and\/or/ or both are exclusive?

> +#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND)
> +			 RWF_APPEND | RWF_ENCODED)
>  
>  #endif /* _UAPI_LINUX_FS_H */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1146fcfa3215..d2e6d9caf353 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2948,24 +2948,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
>  	return 0;
>  }
>  
> -/*
> - * Performs necessary checks before doing a write
> - *
> - * Can adjust writing position or amount of bytes to write.
> - * Returns appropriate error code that caller should return or
> - * zero in case that write should be allowed.
> - */
> -inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> +static int generic_write_checks_common(struct kiocb *iocb, loff_t *count)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file->f_mapping->host;
> -	loff_t count;
> -	int ret;
>  
>  	if (IS_SWAPFILE(inode))
>  		return -ETXTBSY;
>  
> -	if (!iov_iter_count(from))
> +	if (!*count)
>  		return 0;
>  
>  	/* FIXME: this is for backwards compatibility with 2.4 */
> @@ -2975,8 +2966,21 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
>  		return -EINVAL;
>  
> -	count = iov_iter_count(from);
> -	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
> +	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
> +}
> +
> +/*
> + * Performs necessary checks before doing a write
> + *
> + * Can adjust writing position or amount of bytes to write.
> + * Returns a negative errno or the new number of bytes to write.
> + */
> +inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	loff_t count = iov_iter_count(from);
> +	int ret;
> +
> +	ret = generic_write_checks_common(iocb, &count);
>  	if (ret)
>  		return ret;
>  
> @@ -2985,6 +2989,58 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  }
>  EXPORT_SYMBOL(generic_write_checks);
>  
> +int generic_encoded_write_checks(struct kiocb *iocb,
> +				 struct encoded_iov *encoded)
> +{
> +	loff_t count = encoded->unencoded_len;
> +	int ret;
> +
> +	ret = generic_write_checks_common(iocb, &count);

That's a bit confusing. You will only ever write encoded len bytes, yet
you check the unencoded len. Presumably that's to ensure the data can be
read back successfully? Still it feels a bit odd. IMO this warrants a
comment.

When you use this function in patch 5 all the checks are performed
against unencoded_len yet you do :

count = encoded.len;

> +	if (ret)
> +		return ret;
> +
> +	if (count != encoded->unencoded_len) {
> +		/*
> +		 * The write got truncated by generic_write_checks_common(). We
> +		 * can't do a partial encoded write.
> +		 */
> +		return -EFBIG;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(generic_encoded_write_checks);
> +
> +ssize_t check_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> +		return -EPERM;
> +	if (iov_iter_single_seg_count(iter) != sizeof(struct encoded_iov))
> +		return -EINVAL;
> +	return iov_iter_count(iter) - sizeof(struct encoded_iov);
> +}
> +EXPORT_SYMBOL(check_encoded_read);
> +
> +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,

nit: This might be just me but 'import' doesn't sound right, how about
parse_encoded_write ?


> +			 struct iov_iter *from)
> +{
> +	if (!(iocb->ki_filp->f_flags & O_ENCODED))
> +		return -EPERM;
> +	if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> +		return -EINVAL;
> +	if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> +		return -EFAULT;
> +	if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> +	    encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE)
> +		return -EINVAL;
> +	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> +	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> +		return -EINVAL;
> +	if (encoded->unencoded_offset >= encoded->unencoded_len)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(import_encoded_write);
> +
>  /*
>   * Performs necessary checks before doing a clone.
>   *
> 
