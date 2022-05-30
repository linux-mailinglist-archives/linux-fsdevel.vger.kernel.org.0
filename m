Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301353855B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiE3PtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiE3PtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 11:49:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC026E4;
        Mon, 30 May 2022 08:08:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so17139757lfe.12;
        Mon, 30 May 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1sc3SgN3N3ykWArYqFUHd/HD6dgspu5E5KUhFXFFjg=;
        b=o6AGIOjOnwajx65qfESsnit6rWY4fglvYKRG8NWk+5/69fzaHC6BgSnsFN+OnTurgY
         BdaQqi1zvZAJpA89C/sYRmHEN8wxx/01Mg2k4I5K1yz9gq4MT3QMW8r1Rl+wOSf4/f4R
         zeY31kRUNECx0aTVRNmRGA8CHlm1vyuRWqNxOw/JXtq5YX4rvF24NVaaOTjri5VSGbBB
         cHoJfKegM8EIcgBqDAwUDqEG+LzETilgZCRBui4wjoLnNx0m9+m1pH3++LaOsYAHngVq
         mDT4PX85xVw5pnXXc9gsjfmWqT5wf6zCkVB52CJFuEtu7d6AHbC09E4X0OKdNkJhAo7e
         hMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1sc3SgN3N3ykWArYqFUHd/HD6dgspu5E5KUhFXFFjg=;
        b=pIWdwq1zfb1IG9iwOc4iiRcnP88gP6Ts4Xs7C82BPhN9QcCBeNNXECQy/cbk8JuHdK
         mu0bYtTzKTL+9D9TY4uAvNvxiPJlshPv6rcURaw+3JhP9O6FGiervSLVirVY9zl+nhxP
         YnN8jcRiE8jE0fITV8tQ6tGHsRdnAZ+0PkcDY7X6MCTx1nBNZNcey58LP9Ws0k131ksJ
         ed34ZVqH4m5gYCQ3xYU6DrIfI8iMO4N5+GpRw4W6C3EBjSLyMykPYaLuQ2/2ZtwyEZhY
         XZfzFxaCdRp74oEtS33qI8lEmUbdnEX2u3AJo7ijyY+ImJ7clPxD4vmsIOKSlIpvKxm+
         3NhA==
X-Gm-Message-State: AOAM533ex3mGo0fTOWKdN8Y2SP5VpnLG8IPOkd0+7AbUEzvRczC//1Ci
        KnS7U7tGYy6nCMeu5zstUGI=
X-Google-Smtp-Source: ABdhPJykyfU4vxRB5yEcqCTO5WgROZp2XyL5zwb77xA4VwjAJoRJEdFI5Zpa+r4u4gXUG5yF756U3A==
X-Received: by 2002:a05:6512:23a9:b0:478:5595:33cb with SMTP id c41-20020a05651223a900b00478559533cbmr35442611lfv.439.1653923284186;
        Mon, 30 May 2022 08:08:04 -0700 (PDT)
Received: from localhost (87-49-44-105-mobile.dk.customer.tdc.net. [87.49.44.105])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e5346000000b0024f3d1daea5sm1476141ljd.45.2022.05.30.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:08:03 -0700 (PDT)
Date:   Mon, 30 May 2022 17:08:02 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 7/9] block/bounce: count bytes instead of sectors
Message-ID: <20220530150802.wqusaezaw2mefwms@quentin>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-8-kbusch@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 06:06:11PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v3->v4:
> 
>   Use sector shift
> 
>   Add comment explaing the ALIGN_DOWN
> 
>   Use unsigned int type for counting bytes
> 
>  block/bounce.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..f6ae21ec2a70 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,25 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	int rw = bio_data_dir(*bio_orig);
>  	struct bio_vec *to, from;
>  	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	/*
> +	 * If the original has more than BIO_MAX_VECS biovecs, the total bytes
> +	 * may not be block size aligned. Align down to ensure both sides of
> +	 * the split bio are appropriately sized.
> +	 */
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> SECTOR_SHIFT;
>  	if (sectors < bio_sectors(*bio_orig)) {
>  		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
>  		bio_chain(bio, *bio_orig);
> -- 
> 2.30.2
> 

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
-- 
Pankaj Raghav
