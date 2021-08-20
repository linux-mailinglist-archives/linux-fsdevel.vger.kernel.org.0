Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A553A3F326E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHTRtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTRtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:49:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22437C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:48:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b9so1984044plx.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oDw9JQn7vr4FgthPf7YyzlLqJ+cCwfdETdPUxePdPaQ=;
        b=q/7IycLqHV9nhmB5jzY0K+T+yMqRclGEea3ADyEq6+HiNXH4Mpf99xYsvQeD6i4JnC
         zfkpfY3rlngQcOMSDo9hVZbxN+lvuxSwGwftlDWVkjdqNBrdRCl8/iL+mPRR2H/VcXo0
         7GHA/kYEhdSlfZvGgI+Xv3q3TcxV7zC0FAv63k6kQmdR9DkVnbHz5YvmuWTDswy3c6YI
         71iuy97qpOESdRNgTsJipIv7IpoFpXsYGDGEUbWPwRWs0CXMsd5euiJnQg3XSL364vzc
         tkLlx3AW8ixJrMg0m8iAb/bP3ndyw/ZZobSvm1HPUd4zFssBzdIUBSzstxQv/PU52q+w
         fZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oDw9JQn7vr4FgthPf7YyzlLqJ+cCwfdETdPUxePdPaQ=;
        b=SKFm1KVYUL6yL+g9Td/XczuM/guD6TF9TqSJXYpOdVleZ4AkCjMGZzgLOLUZyBa2N0
         w7WRntOmETuQzGKH6CaJnc7CiNXPqn/Wt+zwbGNDiZOay+5C5+W3VOduBNPy/Bvdpuu8
         WhjmcRVcuv3PZLst/yYIzSqTtgvV2zSwQ7Gjz4HTWdN4HDXSt1uKHpoZfYSZDPwnsqa1
         Q/qh99pO2/EMBo6xPJjeyY/28BjXjHCfSjmUwHd+TCpmczYVtj6Mr1TrkMaNRSm1Lo4J
         6QDr4uZ6ilTHQgTW5OBVaBzBOUlkG11347vCP9JTTLciXPgMbAbkcot8mr8aH2eMo7gi
         f7wg==
X-Gm-Message-State: AOAM533ppv6+z+yuiAB8Zx9yU3H63zqfuUImRbCnc+S5UZI6uoOR0Jgz
        UVzWIYRTYLVw+SO+gVYmVN+0mA==
X-Google-Smtp-Source: ABdhPJzDyzGoSd6w3JNBealpMnwcSToFAhL/IKzW0rpNJKxQ3ceF9rKlpNdqp4e8CUZafcIq4CoL6g==
X-Received: by 2002:a17:902:c40e:b029:12c:cbce:2d18 with SMTP id k14-20020a170902c40eb029012ccbce2d18mr17316489plk.60.1629481709625;
        Fri, 20 Aug 2021 10:48:29 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id h20sm7392798pfc.32.2021.08.20.10.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:48:29 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:48:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 07/14] btrfs: add definitions + documentation for
 encoded I/O ioctls
Message-ID: <YR/q69Tiz6PFqFJN@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <9bd601f8c5494342d8c7d8aaa86aa815c2118173.1629234193.git.osandov@fb.com>
 <1e9a95f4-01a3-c356-a348-2992d63c867f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e9a95f4-01a3-c356-a348-2992d63c867f@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:56:37AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In order to allow sending and receiving compressed data without
> > decompressing it, we need an interface to write pre-compressed data
> > directly to the filesystem and the matching interface to read compressed
> > data without decompressing it. This adds the definitions for ioctls to
> > do that and detailed explanations of how to use them.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> > 
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index d7d3cfead056..95da52955894 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -861,6 +861,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
> >  		__u8 align[7];
> >  };
> >  
> > +/*
> > + * Data and metadata for an encoded read or write.
> > + *
> > + * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
> > + * compression). This can be used to read the compressed contents of a file or
> > + * write pre-compressed data directly to a file.
> > + *
> > + * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
> > + * preadv/pwritev with additional metadata about how the data is encoded and the
> > + * size of the unencoded data.
> > + *
> > + * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
> > + * the metadata fields, and returns the size of the encoded data. It reads one
> > + * extent per call. It can also read data which is not encoded.
> > + *
> > + * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
> > + * from the iovecs, and returns the size of the encoded data. Note that the
> > + * encoded data is not validated when it is written; if it is not valid (e.g.,
> > + * it cannot be decompressed), then a subsequent read may return an error.
> > + *
> > + * Since the filesystem page cache contains decoded data, encoded I/O bypasses
> > + * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
> > + */
> > +struct btrfs_ioctl_encoded_io_args {
> > +	/* Input parameters for both reads and writes. */
> > +
> > +	/*
> > +	 * iovecs containing encoded data.
> > +	 *
> > +	 * For reads, if the size of the encoded data is larger than the sum of
> > +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> > +	 * ENOBUFS.
> > +	 *
> > +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> > +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> > +	 * increase in the future). This must also be less than or equal to
> > +	 * unencoded_len.
> > +	 */
> > +	const struct iovec __user *iov;
> > +	/* Number of iovecs. */
> > +	unsigned long iovcnt;
> > +	/*
> > +	 * Offset in file.
> > +	 *
> > +	 * For writes, must be aligned to the sector size of the filesystem.
> > +	 */
> > +	__s64 offset;
> > +	/* Currently must be zero. */
> > +	__u64 flags;
> > +
> > +	/*
> > +	 * For reads, the following members are filled in with the metadata for
> > +	 * the encoded data.
> > +	 * For writes, the following members must be set to the metadata for the
> > +	 * encoded data.
> > +	 */
> > +
> > +	/*
> > +	 * Length of the data in the file.
> > +	 *
> > +	 * Must be less than or equal to unencoded_len - unencoded_offset. For
> > +	 * writes, must be aligned to the sector size of the filesystem unless
> > +	 * the data ends at or beyond the current end of the file.
> > +	 */
> > +	__u64 len;
> > +	/*
> > +	 * Length of the unencoded (i.e., decrypted and decompressed) data.
> > +	 *
> > +	 * For writes, must be no more than 128 KiB (this limit may increase in
> > +	 * the future). If the unencoded data is actually longer than
> > +	 * unencoded_len, then it is truncated; if it is shorter, then it is
> > +	 * extended with zeroes.
> > +	 */
> > +	__u64 unencoded_len;
> > +	/*
> > +	 * Offset from the first byte of the unencoded data to the first byte of
> > +	 * logical data in the file.
> > +	 *
> > +	 * Must be less than unencoded_len.
> > +	 */
> > +	__u64 unencoded_offset;
> > +	/*
> > +	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
> > +	 *
> > +	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
> > +	 */
> > +	__u32 compression;
> > +	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
> > +	__u32 encryption;
> > +	/*
> > +	 * Reserved for future expansion.
> > +	 *
> > +	 * For reads, always returned as zero. Users should check for non-zero
> > +	 * bytes. If there are any, then the kernel has a newer version of this
> > +	 * structure with additional information that the user definition is
> > +	 * missing.
> > +	 *
> > +	 * For writes, must be zeroed.
> > +	 */
> > +	__u8 reserved[32];
> > +};
> > +
> > +/* Data is not compressed. */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
> > +/* Data is compressed as a single zlib stream. */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
> > +/*
> > + * Data is compressed as a single zstd frame with the windowLog compression
> > + * parameter set to no more than 17.
> > + */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
> > +/*
> > + * Data is compressed page by page (using the page size indicated by the name of
> > + * the constant) with LZO1X and wrapped in the format documented in
> > + * fs/btrfs/lzo.c. For writes, the compression page size must match the
> > + * filesystem page size.
> > + */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
> > +#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
> > +
> > +/* Data is not encrypted. */
> > +#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
> > +#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
> 
> How about an enums for encryption/compression.

With #define, the user can use #ifdef to check if the constants are
defined and provide their own definitions if not (that's what I did in
the xfstests example programs). Another option is the enum+#define
pattern:

enum {
	BTRFS_ENCODED_IO_COMPRESSION_NONE,
#define BTRFS_ENCODED_IO_COMPRESSION_NONE BTRFS_ENCODED_IO_COMPRESSION_NONE
	BTRFS_ENCODED_IO_COMPRESSION_ZLIB,
#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB BTRFS_ENCODED_IO_COMPRESSION_ZLIB
	BTRFS_ENCODED_IO_COMPRESSION_ZSTD,
#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD BTRFS_ENCODED_IO_COMPRESSION_ZSTD
	BTRFS_ENCODED_IO_COMPRESSION_LZO_4K,
#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K BTRFS_ENCODED_IO_COMPRESSION_LZO_4K
	BTRFS_ENCODED_IO_COMPRESSION_LZO_8K,
#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K BTRFS_ENCODED_IO_COMPRESSION_LZO_8K
	BTRFS_ENCODED_IO_COMPRESSION_LZO_16K,
#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K BTRFS_ENCODED_IO_COMPRESSION_LZO_16K
	BTRFS_ENCODED_IO_COMPRESSION_LZO_32K,
#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K BTRFS_ENCODED_IO_COMPRESSION_LZO_32K
	BTRFS_ENCODED_IO_COMPRESSION_LZO_64K,
#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K BTRFS_ENCODED_IO_COMPRESSION_LZO_64K
	BTRFS_ENCODED_IO_COMPRESSION_TYPES,
};

But that seems to confuse people. I don't feel strongly one way or
another.
