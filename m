Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E552D183D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgLGSLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 13:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGSLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:11:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F0C061749;
        Mon,  7 Dec 2020 10:10:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so13733235wrt.0;
        Mon, 07 Dec 2020 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MP/vfNe7BU8hvXqdJOxmvN3WxoMergKl8mdaAqECZWU=;
        b=p3ii8PMLESJu1gqhxnwLLA4OyAObHqR9dgQVQ0BSMZgT3h7haByqpMHm2M94qAFYcZ
         2YZ2pTPhSZXfhKQ/5S5Ri6+A9n0tAAs2priJN+iE1XyBjuwfXlXditFPtCuD+BmdqBIK
         +7uUmZOctxQEX7M3Bt8LYcETGjFSwZhtEp7BT7zFRpdkfl0qo9xDzb4mse4sLm7dW0WU
         MxmltzX4hodkfC1IwqV1zF92dUuWoJGJLDZE4L62N8ZVXVrGjCvwlt6qJBQ3USxFKKpL
         drhUVvn12gQ95EwaUxawWTX//b++C5TIojKy+Rg93hzvUXYWmlD0NKtYTiEL/4vUXSNy
         /r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MP/vfNe7BU8hvXqdJOxmvN3WxoMergKl8mdaAqECZWU=;
        b=LjGonPR6xqSYjQ8hahMH0sBKIYq8aObFW1yQsQnT5TdXtsW3yWYjuz9Obr5iAYwirH
         ++NCZBsBw5vD2RWXlHwns+bVq5LRENpUbzzicUoVVzR94VcjaHQZLchz+xPq1pFXUUDK
         hG8Wcz1+whVhC7+qG21Hozx13gv+TmLYNeSD2r2W4QiCFbrhKoxfKszLuAczhbpqRNU+
         gZ2TWVkDRHNIYvV4OW8nap6GZNvmc8WStcwSnDH1IvhYmAI0Zv2TST6oVS4HQ6/7sG5+
         N1UFys0p0pTL9JigZRPVZnuuKjHGJAtoQnNewT7roZEgE5JH9TvEdCMDJxp9kI1BDhrU
         FIhA==
X-Gm-Message-State: AOAM532W+E/byRHt0o2FTuuh7F7Ue62fEnSeJoav/WnOuIhKFpP6lp+m
        aAdBFeEm5vbXB1LMdnVLysVWGNttyj8OOA==
X-Google-Smtp-Source: ABdhPJzeu9Y88kp5H/OlFcMSIAnsvYSPX5MZjDeu03AjBk+A4Ws614hF9W38veHsE3lhVAoNrI5BQw==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr20764395wrl.34.1607364655601;
        Mon, 07 Dec 2020 10:10:55 -0800 (PST)
Received: from [192.168.8.107] ([185.69.145.78])
        by smtp.gmail.com with ESMTPSA id k2sm11016153wru.43.2020.12.07.10.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:10:55 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
Date:   Mon, 7 Dec 2020 18:07:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201201120652.487077-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/12/2020 12:06, Ming Lei wrote:
> Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> iter.
> 
> Turns out it isn't necessary to iterate every page in the bvec iter,
> and we call iov_iter_npages() just for figuring out how many bio
> vecs need to be allocated. And we can simply map each vector in bvec iter
> to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> bvec iter.
> 
> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> real usage.
> 
> This patch is based on Mathew's post:

Tried this, the system didn't boot + discovered a filesystem blowned after
booting with a stable kernel. That's on top of 4498a8536c816 ("block: use
an xarray for disk->part_tbl"), which works fine. Ideas?

> https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  fs/block_dev.c       | 30 +++++++++++++++---------------
>  fs/iomap/direct-io.c | 14 +++++++-------
>  include/linux/bio.h  | 10 ++++++++++
>  3 files changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d8664f5c1ff6..4fd9bb4306db 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -218,7 +218,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  
>  static ssize_t
>  __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> -		int nr_pages)
> +		int nr_vecs)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> @@ -233,16 +233,16 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  	    (bdev_logical_block_size(bdev) - 1))
>  		return -EINVAL;
>  
> -	if (nr_pages <= DIO_INLINE_BIO_VECS)
> +	if (nr_vecs <= DIO_INLINE_BIO_VECS)
>  		vecs = inline_vecs;
>  	else {
> -		vecs = kmalloc_array(nr_pages, sizeof(struct bio_vec),
> +		vecs = kmalloc_array(nr_vecs, sizeof(struct bio_vec),
>  				     GFP_KERNEL);
>  		if (!vecs)
>  			return -ENOMEM;
>  	}
>  
> -	bio_init(&bio, vecs, nr_pages);
> +	bio_init(&bio, vecs, nr_vecs);
>  	bio_set_dev(&bio, bdev);
>  	bio.bi_iter.bi_sector = pos >> 9;
>  	bio.bi_write_hint = iocb->ki_hint;
> @@ -353,7 +353,7 @@ static void blkdev_bio_end_io(struct bio *bio)
>  }
>  
>  static ssize_t
> -__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> +__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_vecs)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = bdev_file_inode(file);
> @@ -371,7 +371,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  	    (bdev_logical_block_size(bdev) - 1))
>  		return -EINVAL;
>  
> -	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
> +	bio = bio_alloc_bioset(GFP_KERNEL, nr_vecs, &blkdev_dio_pool);
>  
>  	dio = container_of(bio, struct blkdev_dio, bio);
>  	dio->is_sync = is_sync = is_sync_kiocb(iocb);
> @@ -420,8 +420,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		dio->size += bio->bi_iter.bi_size;
>  		pos += bio->bi_iter.bi_size;
>  
> -		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
> -		if (!nr_pages) {
> +		nr_vecs = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES);
> +		if (!nr_vecs) {
>  			bool polled = false;
>  
>  			if (iocb->ki_flags & IOCB_HIPRI) {
> @@ -451,7 +451,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		}
>  
>  		submit_bio(bio);
> -		bio = bio_alloc(GFP_KERNEL, nr_pages);
> +		bio = bio_alloc(GFP_KERNEL, nr_vecs);
>  	}
>  
>  	if (!is_poll)
> @@ -483,15 +483,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  static ssize_t
>  blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
> -	int nr_pages;
> +	int nr_vecs;
>  
> -	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> -	if (!nr_pages)
> +	nr_vecs = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES + 1);
> +	if (!nr_vecs)
>  		return 0;
> -	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> -		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
> +	if (is_sync_kiocb(iocb) && nr_vecs <= BIO_MAX_PAGES)
> +		return __blkdev_direct_IO_simple(iocb, iter, nr_vecs);
>  
> -	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
> +	return __blkdev_direct_IO(iocb, iter, min(nr_vecs, BIO_MAX_PAGES));
>  }
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5bec..cc779ecc8144 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -211,7 +211,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
> -	int nr_pages, ret = 0;
> +	int nr_vecs, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> @@ -250,9 +250,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	orig_count = iov_iter_count(dio->submit.iter);
>  	iov_iter_truncate(dio->submit.iter, length);
>  
> -	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> -	if (nr_pages <= 0) {
> -		ret = nr_pages;
> +	nr_vecs = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
> +	if (nr_vecs <= 0) {
> +		ret = nr_vecs;
>  		goto out;
>  	}
>  
> @@ -271,7 +271,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			goto out;
>  		}
>  
> -		bio = bio_alloc(GFP_KERNEL, nr_pages);
> +		bio = bio_alloc(GFP_KERNEL, nr_vecs);
>  		bio_set_dev(bio, iomap->bdev);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_write_hint = dio->iocb->ki_hint;
> @@ -308,10 +308,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		dio->size += n;
>  		copied += n;
>  
> -		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +		nr_vecs = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
> -	} while (nr_pages);
> +	} while (nr_vecs);
>  
>  	/*
>  	 * We need to zeroout the tail of a sub-block write if the extent type
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ecf67108f091..b985857ce9d1 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -10,6 +10,7 @@
>  #include <linux/ioprio.h>
>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
>  #include <linux/blk_types.h>
> +#include <linux/uio.h>
>  
>  #define BIO_DEBUG
>  
> @@ -807,4 +808,13 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>  		bio->bi_opf |= REQ_NOWAIT;
>  }
>  
> +static inline int bio_iov_iter_nvecs(const struct iov_iter *i, int maxvecs)
> +{
> +	if (!iov_iter_count(i))
> +		return 0;
> +	if (iov_iter_is_bvec(i))
> +               return min_t(int, maxvecs, i->nr_segs);
> +	return iov_iter_npages(i, maxvecs);
> +}
> +
>  #endif /* __LINUX_BIO_H */
> 

-- 
Pavel Begunkov
