Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9D39D9E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGKlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 06:41:35 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46619 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhFGKlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:41:35 -0400
Received: by mail-wr1-f42.google.com with SMTP id a11so15136054wrt.13;
        Mon, 07 Jun 2021 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4xfi/BIIZDakHWphz8cAHHVuPoLUgNVnu9MXQz7t4ww=;
        b=dU0KK1itqPuS7fTpW8Uhe0deZ3zT3Nrl2+5GhKv/K477VWEP6XIkrFzkUXoTeylmNN
         iuMZJKPA8d+2985aMnQQOkSD2cHfT+SvDymWppfFP5TRBnFSdyxpO6g5a5kzhu1WFhee
         TOJMzeTpKiwghKJbM+e6ym6BJ0fU6xLtyDIpRlLKv0KQeGvGDNfewg5cgraalnqgeuAq
         jZSC8it7R1ijPjKPvMapEsISMtspnlIcDuQMfiDCwiAPbtstdutGiTzi9tUC7ueVgSF/
         Olq3iW4+QL6hzjcx5aHKMd/ioEoWNeFyy3WVQREfxZgSWBi4vZPGAyOrMFKLvFPTTE+w
         FrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4xfi/BIIZDakHWphz8cAHHVuPoLUgNVnu9MXQz7t4ww=;
        b=LVf1fx17Rz2GHKptxAainoIuctQ7dq4tmhN3FAt3F3HT7UKhImyIl2gg7EZQI7sJGi
         n13a0zFxzzU5r+3Hd7DeDxxwE+HWRa/sKFc7418DpNh9OZHxolN03umGkhON9hrVWqYA
         +uDfSq+Cn5mDbf7jZZy0mJZ+FGeAlJzMEMtKKkTv/rKsrCDeWqXd2XvmtEq4IZIV/YKw
         uuhIXUr6QDT33zXNiE/kcaO7uR5ogan5I8XXEggDJPHFeYtzqgqFkCVbfrf7xeynU85P
         6NKVpBUQIG1fO52z9N4+Q3IpXRXswMddtddLajAWtpRZCj8+cmNtZwPjJnm5NROFFb0d
         z1ng==
X-Gm-Message-State: AOAM532JFj38vqu05fgDN1NzH3LBypBLMHTdTnZ2d/mHuWabEUc12RDW
        FVoNUy3EPM54//otHMIqchg=
X-Google-Smtp-Source: ABdhPJy/LNUURTIsklfBLhxR9xY5FvVFrL0Wj6ekw3Pq5dsxgTTmb6Z8dxgk0VkRW/doSJ2BjpeAvg==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr16321943wrm.75.1623062323319;
        Mon, 07 Jun 2021 03:38:43 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.232.1])
        by smtp.gmail.com with ESMTPSA id j12sm7292888wrt.69.2021.06.07.03.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:38:43 -0700 (PDT)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <YL1ad7+I30xnCto8@zeniv-ca.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <eb4dd349-0416-3654-c856-7672b0bfef15@gmail.com>
Date:   Mon, 7 Jun 2021 11:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL1ad7+I30xnCto8@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/21 12:29 AM, Al Viro wrote:
> On Sun, Jun 06, 2021 at 03:05:49PM -0700, Linus Torvalds wrote:
[...]
> 
> 	BTW, speaking of initializers...  Pavel, could you check if
> the following breaks anything?  Unless I'm misreading __io_import_fixed(),
> looks like that's what it's trying to do...

It's a version of iov_iter_advance() that assumes all bvecs are
single-paged and all possibly besides first/last are page
aligned/sized.
Looks and works well, will try the full set later.

btw, as that assumption is not true in general, I'd suggest to add
a comment. Don't like the idea of it being misused...


> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f46acbbeed57..9bd2da9a4c3d 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2773,57 +2773,14 @@ static int __io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter
>  {
>  	size_t len = req->rw.len;
>  	u64 buf_end, buf_addr = req->rw.addr;
> -	size_t offset;
>  
>  	if (unlikely(check_add_overflow(buf_addr, (u64)len, &buf_end)))
>  		return -EFAULT;
>  	/* not inside the mapped region */
>  	if (unlikely(buf_addr < imu->ubuf || buf_end > imu->ubuf_end))
>  		return -EFAULT;
> -
> -	/*
> -	 * May not be a start of buffer, set size appropriately
> -	 * and advance us to the beginning.
> -	 */
> -	offset = buf_addr - imu->ubuf;
> -	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
> -
> -	if (offset) {
> -		/*
> -		 * Don't use iov_iter_advance() here, as it's really slow for
> -		 * using the latter parts of a big fixed buffer - it iterates
> -		 * over each segment manually. We can cheat a bit here, because
> -		 * we know that:
> -		 *
> -		 * 1) it's a BVEC iter, we set it up
> -		 * 2) all bvecs are PAGE_SIZE in size, except potentially the
> -		 *    first and last bvec
> -		 *
> -		 * So just find our index, and adjust the iterator afterwards.
> -		 * If the offset is within the first bvec (or the whole first
> -		 * bvec, just use iov_iter_advance(). This makes it easier
> -		 * since we can just skip the first segment, which may not
> -		 * be PAGE_SIZE aligned.
> -		 */
> -		const struct bio_vec *bvec = imu->bvec;
> -
> -		if (offset <= bvec->bv_len) {
> -			iov_iter_advance(iter, offset);
> -		} else {
> -			unsigned long seg_skip;
> -
> -			/* skip first vec */
> -			offset -= bvec->bv_len;
> -			seg_skip = 1 + (offset >> PAGE_SHIFT);
> -
> -			iter->bvec = bvec + seg_skip;
> -			iter->nr_segs -= seg_skip;
> -			iter->count -= bvec->bv_len + offset;
> -			iter->iov_offset = offset & ~PAGE_MASK;
> -		}
> -	}
> -
> -	return 0;
> +	return import_pagevec(rw, buf_addr, len, imu->ubuf,
> +			      imu->nr_bvecs, imu->bvec, iter);
>  }
>  
>  static int io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter)
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index fd88d9911dad..f6291e981d07 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -299,5 +299,8 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
>  		 struct iov_iter *i, bool compat);
>  int import_single_range(int type, void __user *buf, size_t len,
>  		 struct iovec *iov, struct iov_iter *i);
> +int import_pagevec(int rw, unsigned long from, size_t len,
> +		unsigned long base, unsigned nr_pages,
> +		struct bio_vec *bvec, struct iov_iter *i);
>  
>  #endif
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 11b39bd1d1ab..4a771fcb529b 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1982,3 +1982,21 @@ int import_single_range(int rw, void __user *buf, size_t len,
>  	return 0;
>  }
>  EXPORT_SYMBOL(import_single_range);
> +
> +int import_pagevec(int rw, unsigned long from, size_t len,
> +		unsigned long base, unsigned nr_pages,
> +		struct bio_vec *bvec, struct iov_iter *i)
> +
> +{
> +	unsigned long skip_pages = (from >> PAGE_SHIFT) - (base >> PAGE_SHIFT);
> +
> +	*i = (struct iov_iter){
> +		.iter_type = ITER_BVEC,
> +		.data_source = rw,
> +		.bvec = bvec + skip_pages,
> +		.nr_segs = nr_pages - skip_pages,
> +		.iov_offset = skip_pages ? from & ~PAGE_MASK : from - base,
> +		.count = len
> +	};
> +	return 0;
> +}
> 

-- 
Pavel Begunkov
