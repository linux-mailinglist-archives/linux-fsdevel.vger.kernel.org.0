Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B282CBF2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 15:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLBOKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 09:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLBOKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:10:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25664C0613CF;
        Wed,  2 Dec 2020 06:09:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so7459003wmc.5;
        Wed, 02 Dec 2020 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NDiO2ZUtXk3y3/a6Dk/0pOzEdTkPQOGZm1WNp3qLocc=;
        b=YreIDD28QdYwmPJgkQ544U3rmm23mOKeHhddTPJTgky/pRfxwfdxpesQrIcooQmtnE
         /vYsQ8diHWpaZXce8zI7nnj2srjNZDZfIT8ZL2f9AYR9zbjnmPkElX3cc8bLVd0Y8PPj
         v7cUGt8hQwUSHr6PUFgmoSjUd4hirCt3m14luvw3Xu3Z3LJ0W518QjWJk1E+wcZ9MQaD
         bN02SYT3BHB2ajuLH567Fxaa7Pb+PPav9fTKAYpY5VMW1YUd+ZYwHEeNnoc3hQIE4d96
         y0pA7i0rrbYGbVGpKIuNjHvnCEh+F7RGu6VNnp7G43Xk63bJTZqUM3iEu46y6MGr7Uqh
         zN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NDiO2ZUtXk3y3/a6Dk/0pOzEdTkPQOGZm1WNp3qLocc=;
        b=U8ovvquHQQlfodFSww9lu/P06vVt1IusWTc1UeImFuSCXL9Ve+IvdD6QKz3j6pmzMO
         DbsM8c/nYVDvW8xR3y8j6od6B8nUv9z5UDIv0nioT+WnPkhb2I2Ab9UbTUybrke1TlOP
         zpdkr6vm+x1Pg9HVUtAcp85sfUZRX8BNAYCtuy57hF8r4qnDsKyqXPVpkK9QLGMwc7fv
         irffloI+Ah+foHKkzdKhFeKhv7KvwNE453gkDWIDimOIvdjwmOcGI1CVLMloPi+KOUo8
         ecTRPr9++erjfGPweAYgo9cThLVtrbtLIQsohq0KLUJDJ1Ky3tK1T//aGl0E4Um7L5BZ
         Nhnw==
X-Gm-Message-State: AOAM533w255Yvd0PdxYUPdiAPJCSNR1rWkv9Cja6UEFPDN5BzzLX3daa
        LOSX2UA4bfv6o2jLqanHEQeioLPCfWzwLg==
X-Google-Smtp-Source: ABdhPJws28PAvhwclNWWMrwh2quCqPyOo0q9PjW5ftfckEouDFUuMGoM3IDw1eTVtpIrp6NF4eGOGQ==
X-Received: by 2002:a1c:a749:: with SMTP id q70mr3316690wme.120.1606918196622;
        Wed, 02 Dec 2020 06:09:56 -0800 (PST)
Received: from [192.168.1.144] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id p4sm2279888wrm.51.2020.12.02.06.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 06:09:55 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <71e6e2d6-fc9a-cb4a-f547-9693410dff59@gmail.com>
Date:   Wed, 2 Dec 2020 14:06:41 +0000
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

Looks good to me. Except for using BIO_MAX_PAGES for number of vecs, it's
even cleaner because it adds pages constrained by number of vecs, not pages,
with all side effects like skipping __blkdev_direct_IO_simple() for many
page 1-segment bvecs.

One nit below.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> 
> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> real usage.
> 
> This patch is based on Mathew's post:
> 
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
[...]
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ecf67108f091..b985857ce9d1 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -10,6 +10,7 @@
[...]
>  
> +static inline int bio_iov_iter_nvecs(const struct iov_iter *i, int maxvecs)
> +{
> +	if (!iov_iter_count(i))
> +		return 0;
> +	if (iov_iter_is_bvec(i))
> +               return min_t(int, maxvecs, i->nr_segs);

spaces instead of tabs

> +	return iov_iter_npages(i, maxvecs);
> +}
> +
>  #endif /* __LINUX_BIO_H */
> 

-- 
Pavel Begunkov
