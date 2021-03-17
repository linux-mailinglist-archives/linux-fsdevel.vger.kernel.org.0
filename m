Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC333F84E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhCQSph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhCQSpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:45:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330CC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 11:45:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b184so1754455pfa.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YW9sFjqp97bhdYt8JWFRpF7hWLMW5DjM6fbGxnWtY+o=;
        b=qRVekhfIMfv7kOhCjx92EP04cJ7NFnIbK+JUar9xuUADE/SZtoO2Mnp5j06V6rrhKc
         03WsQTyU7zJzDZtZswqzqjq3QAp0go01d+84h32IMSDKHPLTlFMwDte3VB22Pr1w/1EX
         Ohv3akLBTaQNBTvVQGqJM9vAzqeoRgzGMJVrE7K9ctIBdS5pqZKY1p6YTC6boti9bmEI
         yisWy16lVNeqXsBXveiAlGiAErkxz2sUjIcZXwP+IzkHn0zGAQteOLjccunOdiFsfudU
         /yy3jjyAEqZoQ/5gNxe0fNOI9Uoi1D3O0qbl6QUeh40Z3ErpUYimol/BFadN43aPTI0B
         /m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YW9sFjqp97bhdYt8JWFRpF7hWLMW5DjM6fbGxnWtY+o=;
        b=s/H4KW3sv2ATtHl0DgWIiHU5XScmMgBOAz2ji0NEn8bHdLUikvn2D9Pgm/18Y5Czvb
         kiqS+iohPkb7GxVFwIPiUjXHdvCLs1kZnCKiQ2xkS57t0/5kinNcAFdXhXj0vXpQmkJq
         wlTI3o7KEUYI4UjCBfzqfuFpn4JJxpO5ZyvRa5OK11htEo9VwFCHGMxurQPdYCtKPLcm
         7zxYoz6sS9tEiOMqjqg6KEF4e2ERKM33DDUqf4UF2ykVpvSAk1ylaALpAbPmYsAPjGDH
         ZQ/dAqOZXOOoONy+wkyjq5wE8JKKH5RsHz0BcbPRl3qkKKHGNfdGF7n/ftV98bsYVnUg
         AzkQ==
X-Gm-Message-State: AOAM531CvZoRnkeR4igEmdLCnC7dOggYy/0zhgRb9V8zicHZEr4OBcUa
        vfZMYppv79BQ3sMYHiaAKoC6Dw==
X-Google-Smtp-Source: ABdhPJz9efKjQ397r3XHjnIbO8SP5XzgDEGsZDKGvjc79HWGrMxTZ1v9osdmfdQJJWRLzdDbWSpFAg==
X-Received: by 2002:a63:40c5:: with SMTP id n188mr3755030pga.255.1616006705636;
        Wed, 17 Mar 2021 11:45:05 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:156])
        by smtp.gmail.com with ESMTPSA id c22sm19556419pfl.169.2021.03.17.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:45:04 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:45:02 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v8 01/10] iov_iter: add copy_struct_from_iter()
Message-ID: <YFJOLlm3GuZgoVSi@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <e71e712d27b2e2c19efc5b1454bd8581ad98d900.1615922644.git.osandov@fb.com>
 <20210317175611.adntftl6w3avptvk@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317175611.adntftl6w3avptvk@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 06:56:11PM +0100, Christian Brauner wrote:
> On Tue, Mar 16, 2021 at 12:42:57PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This is essentially copy_struct_from_user() but for an iov_iter.
> > 
> > Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  include/linux/uio.h |  2 ++
> >  lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> > 
> > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > index 72d88566694e..f4e6ea85a269 100644
> > --- a/include/linux/uio.h
> > +++ b/include/linux/uio.h
> > @@ -121,6 +121,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
> >  			 struct iov_iter *i);
> >  size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
> >  			 struct iov_iter *i);
> > +int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
> > +			  size_t usize);
> >  
> >  size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
> >  size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index a21e6a5792c5..f45826ed7528 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -948,6 +948,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
> >  }
> >  EXPORT_SYMBOL(copy_page_from_iter);
> >  
> > +/**
> > + * copy_struct_from_iter - copy a struct from an iov_iter
> > + * @dst: Destination buffer.
> > + * @ksize: Size of @dst struct.
> > + * @i: Source iterator.
> > + * @usize: (Alleged) size of struct in @i.
> > + *
> > + * Copies a struct from an iov_iter in a way that guarantees
> > + * backwards-compatibility for struct arguments in an iovec (as long as the
> > + * rules for copy_struct_from_user() are followed).
> > + *
> > + * The recommended usage is that @usize be taken from the current segment:
> > + *
> > + *   int do_foo(struct iov_iter *i)
> > + *   {
> > + *     size_t usize = iov_iter_single_seg_count(i);
> > + *     struct foo karg;
> > + *     int err;
> > + *
> > + *     if (usize > PAGE_SIZE)
> > + *       return -E2BIG;
> > + *     if (usize < FOO_SIZE_VER0)
> > + *       return -EINVAL;
> > + *     err = copy_struct_from_iter(&karg, sizeof(karg), i, usize);
> > + *     if (err)
> > + *       return err;
> > + *
> > + *     // ...
> > + *   }
> > + *
> > + * Return: 0 on success, -errno on error (see copy_struct_from_user()).
> > + *
> > + * On success, the iterator is advanced @usize bytes. On error, the iterator is
> > + * not advanced.
> > + */
> > +int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
> > +			  size_t usize)
> > +{
> > +	if (usize <= ksize) {
> > +		if (!copy_from_iter_full(dst, usize, i))
> > +			return -EFAULT;
> > +		memset(dst + usize, 0, ksize - usize);
> > +	} else {
> > +		size_t copied = 0, copy;
> > +		int ret;
> > +
> > +		if (WARN_ON(iov_iter_is_pipe(i)) || unlikely(i->count < usize))
> > +			return -EFAULT;
> > +		if (iter_is_iovec(i))
> > +			might_fault();
> > +		iterate_all_kinds(i, usize, v, ({
> > +			copy = min(ksize - copied, v.iov_len);
> > +			if (copy && copyin(dst + copied, v.iov_base, copy))
> > +				return -EFAULT;
> > +			copied += copy;
> > +			ret = check_zeroed_user(v.iov_base + copy,
> > +						v.iov_len - copy);
> > +			if (ret <= 0)
> > +				return ret ?: -E2BIG;
> > +			0;}), ({
> > +			char *addr = kmap_atomic(v.bv_page);
> > +			copy = min_t(size_t, ksize - copied, v.bv_len);
> > +			memcpy(dst + copied, addr + v.bv_offset, copy);
> > +			copied += copy;
> > +			ret = memchr_inv(addr + v.bv_offset + copy, 0,
> > +					 v.bv_len - copy) ? -E2BIG : 0;
> > +			kunmap_atomic(addr);
> > +			if (ret)
> > +				return ret;
> > +			}), ({
> > +			copy = min(ksize - copied, v.iov_len);
> > +			memcpy(dst + copied, v.iov_base, copy);
> > +			if (memchr_inv(v.iov_base, 0, v.iov_len))
> > +				return -E2BIG;
> > +			})
> > +		)
> 
> 
> Following the semantics of copy_struct_from_user() is certainly a good
> idea but can this in any way be rewritten to not look like this; at
> least not as crammed. It's a bit painful to follow here what's going.

I think that's just the nature of the iov_iter code :) I'm just
following the rest of this file, which uses some mind-expanding macros.
Do you have any suggestions for how to clean this function up?
