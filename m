Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E84B532D30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiEXPT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiEXPT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 11:19:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291CD19F87;
        Tue, 24 May 2022 08:19:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p4so29968727lfg.4;
        Tue, 24 May 2022 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PfBkeEIe7SnLZ5YxvF7Yu7ggG7hoYDnozcRlnP1XlkM=;
        b=MFQuhR8xgZf1+SgiQXaKoeCp3B57M0EgNLlR83nMJUX2SPZjU+O5mSDZV6ISvFWyjk
         R//FLYj++J3jPoptd4FPhgDII+TQAd24Gj2UIslJe2ICk8dpnJLviDM8WNMOeOtB5LX1
         gncM81eKMEsUMRt6p+oF82WrW4IN9Qygv8I//2bREjx11YsDg1rRACqTg2EOKKg0/va5
         pcVyw0G/rRmkh+EzIH5ic2Tmm0GMQxkueK7hQBktD1+lSkUQn4RqJq80NPzc3Pm7/2Mb
         HhFTOPKu/b5PFM7nOKznbhvOV63v0IBKNe4ywUp9og/iGSWOQ8of+tFF+vl53IY0sbpQ
         3ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PfBkeEIe7SnLZ5YxvF7Yu7ggG7hoYDnozcRlnP1XlkM=;
        b=JByLSnejvKn31x9e2eOCZe1jYJMhOx1K96yGWLrYkS9xMgLDAHNpRtyGuKB7IUu7aH
         Xo8wb+5rBDLaVoxV1XqZ7mSyn88NrPXzfqPTVewo1mOWY8GSeYU/nl8EKdn0WNVfe7bj
         l78V1DFDGhnCrsMnbvqPYERYLtVJWycsLWIYzkBdWSXt8kqCEZnUR8dnVpVXzR6O69my
         lXXgrvmK+DdLbIQ5BDRNn5vZPPd4cyVt38tiIAnWJyJwSaQ6IH8atcS0pCnFIHwqMMXF
         h4Sz9RrgIqlGRS5TDzqJCARMp0ZMk4kqLfCHY5HZ0OA6Wsx0pxPzPuvu8Ae2+BlGm3F6
         tAbA==
X-Gm-Message-State: AOAM530u1aCDC0C7Td0Z5Ximqa0n4rOrFSepad8OnG8WhxFFNqBRVplU
        H2+383eEJsdZj2ucQZXkweE=
X-Google-Smtp-Source: ABdhPJzhTr/RdxlKuqjBVY5tdK2ZfKA2s5U/DczQGJy970Ev+DiGYCWRYk8Q+PclJk/JBwMHvxXgUA==
X-Received: by 2002:a05:6512:39c1:b0:44a:e25d:47fd with SMTP id k1-20020a05651239c100b0044ae25d47fdmr19543149lfu.580.1653405594486;
        Tue, 24 May 2022 08:19:54 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id a23-20020a056512201700b0047255d210f2sm2584706lfb.33.2022.05.24.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:19:53 -0700 (PDT)
Date:   Tue, 24 May 2022 17:19:52 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv3 6/6] block: relax direct io memory alignment
Message-ID: <20220524151952.mcv6pqwwrd5bebli@quentin>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-7-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-7-kbusch@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:19PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> diff --git a/block/fops.c b/block/fops.c
> index b9b83030e0df..218e4a8b92aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -42,6 +42,16 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
>  	return op;
>  }
>  
> +static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
Minor nit as ALIGN* macros have been used in other places, this
alignment check can also be changed to using IS_ALIGNED macro:
if (!IS_ALIGNED(pos | iov_iter_count(iter), bdev_logical_block_size(bdev)))
> +		return -EINVAL;
> +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  #define DIO_INLINE_BIO_VECS 4
>  
>  static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
> @@ -54,9 +64,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	struct bio bio;
>  	ssize_t ret;
>  
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> -		return -EINVAL;
> +	ret = blkdev_dio_aligned(bdev, pos, iter);
> +	if (ret)
> +		return ret;
>  

-- 
Pankaj Raghav
