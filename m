Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746A306041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhA0Pxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhA0Pwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:52:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D746C061573;
        Wed, 27 Jan 2021 07:51:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bx12so3006353edb.8;
        Wed, 27 Jan 2021 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JVlzrgK9SUerNgH3pE4q6TjesJOSjQO6YHuJJtZtBgI=;
        b=D4eLJNoK6h+kZQnchbdA1XMPrifYaJoLZm0XDkP0+XhtheaOEpc+aiRQd8L8KOAbvE
         G1IBUvjiseWUZMwBfK/RvP5nY/xAzNHnxOJu3SyjEr+16rEOxzeHIL8G8hXfSl36R55u
         PS7dXudzhYklk34XVE4OHHU88zipw+YVgXkNV/xmx6xPW6QrGZ4X758At5XPHfWPhCy3
         Ihzc4KTdxQQB+srnPP9UbSEtzf+cAndDgsHZU/3gXAYovQgUbqdb+IY/GNCCek1ZqDZh
         bltBjGtaDMipWoIo61BtXv+H90v8pNO1G0rpg9SD1FqJe5N6Pl3qz/6sN1tEHrzQQoPB
         bhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JVlzrgK9SUerNgH3pE4q6TjesJOSjQO6YHuJJtZtBgI=;
        b=RWE0EyIRVfDIepwymyih/sWRLKKQjNmiujfzTmqcT2vwefwTF3oyRGjOHoYy1MuyML
         2Deu+qceWtlq82NeknwEz5NSkKQKdzSefJ/ymdO8QxoV/A5RmMP1ribvW+CBmRNNrMa+
         TcB2nXsufncZxKwZZFWQIxUEEV4mn3BtncwSfUsrhNOV3EBxd5kBVGLio6KXt4VT9wvS
         dzGt4R7j5Gkfy7v4iJerQnOz9+k/VVFBkVv/FCAWcMljA5GsWJmz8mx89filo5ZKXf48
         uydEyNz3dJUbGwtZ9mmgtrf9Ps6gRZOzsqnsDNkI1JGINKf+zK4AfL+TiC7erxQwVRWt
         OvZw==
X-Gm-Message-State: AOAM532rOjA39wA8LTivVC2zllhAeFvMsLg0HrMIKh/Fcc0b/wtShqua
        /Zgh58ELU+HjjnMijxHNgJoUfZgEDPs=
X-Google-Smtp-Source: ABdhPJz5K4BNsOMsWFKFdItRQ7KGAqEGO8Wkwdf78h8YPOkn8lMpVfoojhLQ4x2My8ddA4agmrdFYw==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr10080427edv.54.1611762712451;
        Wed, 27 Jan 2021 07:51:52 -0800 (PST)
Received: from [192.168.8.160] ([148.252.129.161])
        by smtp.gmail.com with ESMTPSA id f16sm1004796ejh.88.2021.01.27.07.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:51:51 -0800 (PST)
Subject: Re: [PATCH] iov_iter: optimise iter type checking
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
Date:   Wed, 27 Jan 2021 15:48:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210116051818.GF3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/01/2021 05:18, Al Viro wrote:
> On Sat, Jan 09, 2021 at 10:11:09PM +0000, Pavel Begunkov wrote:
> 
>>> Does any code actually look at the fields as a pair?
>>> Would it even be better to use separate bytes?
>>> Even growing the on-stack structure by a word won't really matter.
>>
>> u8 type, rw;
>>
>> That won't bloat the struct. I like the idea. If used together compilers
>> can treat it as u16.
> 
> Reasonable, and from what I remember from looking through the users,
> no readers will bother with looking at both at the same time.

Al, are you going turn it into a patch, or prefer me to take over?


> On the write side... it's only set in iov_iter_{kvec,bvec,pipe,discard,init}.
> I sincerely doubt anyone would give a fuck, not to mention that something
> like
> void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
>                         struct pipe_inode_info *pipe,
>                         size_t count)
> {
>         BUG_ON(direction != READ);
>         WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
> 	*i = (struct iov_iter) {
> 		.iter_type = ITER_PIPE,
> 		.data_source = false,
> 		.pipe = pipe,
> 		.head = pipe->head,
> 		.start_head = pipe->head,
> 		.count = count,
> 		.iov_offset = 0
> 	};
> }
> 
> would make more sense anyway - we do want to overwrite everything in the
> object, and let the compiler do whatever it likes to do.
> 
> So... something like (completely untested) variant below, perhaps?
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 72d88566694e..ed8ad2c5d384 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -19,20 +19,16 @@ struct kvec {
>  
>  enum iter_type {
>  	/* iter types */
> -	ITER_IOVEC = 4,
> -	ITER_KVEC = 8,
> -	ITER_BVEC = 16,
> -	ITER_PIPE = 32,
> -	ITER_DISCARD = 64,
> +	ITER_IOVEC,
> +	ITER_KVEC,
> +	ITER_BVEC,
> +	ITER_PIPE,
> +	ITER_DISCARD
>  };
>  
>  struct iov_iter {
> -	/*
> -	 * Bit 0 is the read/write bit, set if we're writing.
> -	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
> -	 * the caller isn't expecting to drop a page reference when done.
> -	 */
> -	unsigned int type;
> +	u8 iter_type;
> +	bool data_source;
>  	size_t iov_offset;
>  	size_t count;
>  	union {
> @@ -52,7 +48,7 @@ struct iov_iter {
>  
>  static inline enum iter_type iov_iter_type(const struct iov_iter *i)
>  {
> -	return i->type & ~(READ | WRITE);
> +	return i->iter_type;
>  }
>  
>  static inline bool iter_is_iovec(const struct iov_iter *i)
> @@ -82,7 +78,7 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
>  
>  static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  {
> -	return i->type & (READ | WRITE);
> +	return i->data_source ? WRITE : READ;
>  }
>  
>  /*
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1635111c5bd2..133c03b2dcae 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -81,19 +81,18 @@
>  #define iterate_all_kinds(i, n, v, I, B, K) {			\
>  	if (likely(n)) {					\
>  		size_t skip = i->iov_offset;			\
> -		if (unlikely(i->type & ITER_BVEC)) {		\
> +		if (likely(i->iter_type == ITER_IOVEC)) {	\
> +			const struct iovec *iov;		\
> +			struct iovec v;				\
> +			iterate_iovec(i, n, v, iov, skip, (I))	\
> +		} else if (i->iter_type == ITER_BVEC) {		\
>  			struct bio_vec v;			\
>  			struct bvec_iter __bi;			\
>  			iterate_bvec(i, n, v, __bi, skip, (B))	\
> -		} else if (unlikely(i->type & ITER_KVEC)) {	\
> +		} else if (i->iter_type == ITER_KVEC) {		\
>  			const struct kvec *kvec;		\
>  			struct kvec v;				\
>  			iterate_kvec(i, n, v, kvec, skip, (K))	\
> -		} else if (unlikely(i->type & ITER_DISCARD)) {	\
> -		} else {					\
> -			const struct iovec *iov;		\
> -			struct iovec v;				\
> -			iterate_iovec(i, n, v, iov, skip, (I))	\
>  		}						\
>  	}							\
>  }
> @@ -103,7 +102,17 @@
>  		n = i->count;					\
>  	if (i->count) {						\
>  		size_t skip = i->iov_offset;			\
> -		if (unlikely(i->type & ITER_BVEC)) {		\
> +		if (likely(i->iter_type == ITER_IOVEC)) {	\
> +			const struct iovec *iov;		\
> +			struct iovec v;				\
> +			iterate_iovec(i, n, v, iov, skip, (I))	\
> +			if (skip == iov->iov_len) {		\
> +				iov++;				\
> +				skip = 0;			\
> +			}					\
> +			i->nr_segs -= iov - i->iov;		\
> +			i->iov = iov;				\
> +		} else if (i->iter_type == ITER_BVEC) {		\
>  			const struct bio_vec *bvec = i->bvec;	\
>  			struct bio_vec v;			\
>  			struct bvec_iter __bi;			\
> @@ -111,7 +120,7 @@
>  			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
>  			i->nr_segs -= i->bvec - bvec;		\
>  			skip = __bi.bi_bvec_done;		\
> -		} else if (unlikely(i->type & ITER_KVEC)) {	\
> +		} else if (i->iter_type == ITER_KVEC) {		\
>  			const struct kvec *kvec;		\
>  			struct kvec v;				\
>  			iterate_kvec(i, n, v, kvec, skip, (K))	\
> @@ -121,18 +130,8 @@
>  			}					\
>  			i->nr_segs -= kvec - i->kvec;		\
>  			i->kvec = kvec;				\
> -		} else if (unlikely(i->type & ITER_DISCARD)) {	\
> +		} else if (i->iter_type == ITER_DISCARD) {	\
>  			skip += n;				\
> -		} else {					\
> -			const struct iovec *iov;		\
> -			struct iovec v;				\
> -			iterate_iovec(i, n, v, iov, skip, (I))	\
> -			if (skip == iov->iov_len) {		\
> -				iov++;				\
> -				skip = 0;			\
> -			}					\
> -			i->nr_segs -= iov - i->iov;		\
> -			i->iov = iov;				\
>  		}						\
>  		i->count -= n;					\
>  		i->iov_offset = skip;				\
> @@ -434,7 +433,7 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
>  	int err;
>  	struct iovec v;
>  
> -	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
> +	if (i->iter_type == ITER_IOVEC) {
>  		iterate_iovec(i, bytes, v, iov, skip, ({
>  			err = fault_in_pages_readable(v.iov_base, v.iov_len);
>  			if (unlikely(err))
> @@ -450,19 +449,26 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
>  			size_t count)
>  {
>  	WARN_ON(direction & ~(READ | WRITE));
> -	direction &= READ | WRITE;
>  
>  	/* It will get better.  Eventually... */
> -	if (uaccess_kernel()) {
> -		i->type = ITER_KVEC | direction;
> -		i->kvec = (struct kvec *)iov;
> -	} else {
> -		i->type = ITER_IOVEC | direction;
> -		i->iov = iov;
> -	}
> -	i->nr_segs = nr_segs;
> -	i->iov_offset = 0;
> -	i->count = count;
> +	if (uaccess_kernel())
> +		*i = (struct iov_iter) {
> +			.iter_type = ITER_KVEC,
> +			.data_source = direction,
> +			.kvec = (struct kvec *)iov,
> +			.nr_segs = nr_segs,
> +			.iov_offset = 0,
> +			.count = count
> +		};
> +	else
> +		*i = (struct iov_iter) {
> +			.iter_type = ITER_IOVEC,
> +			.data_source = direction,
> +			.iov = iov,
> +			.nr_segs = nr_segs,
> +			.iov_offset = 0,
> +			.count = count
> +		};
>  }
>  EXPORT_SYMBOL(iov_iter_init);
>  
> @@ -915,17 +921,20 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
>  {
>  	if (unlikely(!page_copy_sane(page, offset, bytes)))
>  		return 0;
> -	if (i->type & (ITER_BVEC|ITER_KVEC)) {
> +	if (likely(i->iter_type == ITER_IOVEC))
> +		return copy_page_to_iter_iovec(page, offset, bytes, i);
> +	if (i->iter_type == ITER_BVEC || i->iter_type == ITER_KVEC) {
>  		void *kaddr = kmap_atomic(page);
>  		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
>  		kunmap_atomic(kaddr);
>  		return wanted;
> -	} else if (unlikely(iov_iter_is_discard(i)))
> -		return bytes;
> -	else if (likely(!iov_iter_is_pipe(i)))
> -		return copy_page_to_iter_iovec(page, offset, bytes, i);
> -	else
> +	}
> +	if (i->iter_type == ITER_PIPE)
>  		return copy_page_to_iter_pipe(page, offset, bytes, i);
> +	if (i->iter_type == ITER_DISCARD)
> +		return bytes;
> +	WARN_ON(1);
> +	return 0;
>  }
>  EXPORT_SYMBOL(copy_page_to_iter);
>  
> @@ -934,17 +943,16 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
>  {
>  	if (unlikely(!page_copy_sane(page, offset, bytes)))
>  		return 0;
> -	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
> -		WARN_ON(1);
> -		return 0;
> -	}
> -	if (i->type & (ITER_BVEC|ITER_KVEC)) {
> +	if (likely(i->iter_type == ITER_IOVEC))
> +		return copy_page_from_iter_iovec(page, offset, bytes, i);
> +	if (i->iter_type == ITER_BVEC || i->iter_type == ITER_KVEC) {
>  		void *kaddr = kmap_atomic(page);
>  		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
>  		kunmap_atomic(kaddr);
>  		return wanted;
> -	} else
> -		return copy_page_from_iter_iovec(page, offset, bytes, i);
> +	}
> +	WARN_ON(1);
> +	return 0;
>  }
>  EXPORT_SYMBOL(copy_page_from_iter);
>  
> @@ -1172,11 +1180,14 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
>  			size_t count)
>  {
>  	WARN_ON(direction & ~(READ | WRITE));
> -	i->type = ITER_KVEC | (direction & (READ | WRITE));
> -	i->kvec = kvec;
> -	i->nr_segs = nr_segs;
> -	i->iov_offset = 0;
> -	i->count = count;
> +	*i = (struct iov_iter) {
> +		.iter_type = ITER_KVEC,
> +		.data_source = direction,
> +		.kvec = kvec,
> +		.nr_segs = nr_segs,
> +		.iov_offset = 0,
> +		.count = count
> +	};
>  }
>  EXPORT_SYMBOL(iov_iter_kvec);
>  
> @@ -1185,11 +1196,14 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
>  			size_t count)
>  {
>  	WARN_ON(direction & ~(READ | WRITE));
> -	i->type = ITER_BVEC | (direction & (READ | WRITE));
> -	i->bvec = bvec;
> -	i->nr_segs = nr_segs;
> -	i->iov_offset = 0;
> -	i->count = count;
> +	*i = (struct iov_iter) {
> +		.iter_type = ITER_BVEC,
> +		.data_source = direction,
> +		.bvec = bvec,
> +		.nr_segs = nr_segs,
> +		.iov_offset = 0,
> +		.count = count
> +	};
>  }
>  EXPORT_SYMBOL(iov_iter_bvec);
>  
> @@ -1199,12 +1213,15 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
>  {
>  	BUG_ON(direction != READ);
>  	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
> -	i->type = ITER_PIPE | READ;
> -	i->pipe = pipe;
> -	i->head = pipe->head;
> -	i->iov_offset = 0;
> -	i->count = count;
> -	i->start_head = i->head;
> +        *i = (struct iov_iter) {
> +		.iter_type = ITER_PIPE,
> +		.data_source = false,
> +		.pipe = pipe,
> +		.head = pipe->head,
> +		.start_head = pipe->head,
> +		.count = count,
> +		.iov_offset = 0
> +	};
>  }
>  EXPORT_SYMBOL(iov_iter_pipe);
>  
> @@ -1220,9 +1237,11 @@ EXPORT_SYMBOL(iov_iter_pipe);
>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
>  {
>  	BUG_ON(direction != READ);
> -	i->type = ITER_DISCARD | READ;
> -	i->count = count;
> -	i->iov_offset = 0;
> +	*i = (struct iov_iter) {
> +		.iter_type = ITER_DISCARD,
> +		.data_source = false,
> +		.count = count,
> +	};
>  }
>  EXPORT_SYMBOL(iov_iter_discard);
>  
> 

-- 
Pavel Begunkov
