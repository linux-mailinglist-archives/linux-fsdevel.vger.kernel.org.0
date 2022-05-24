Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7E532C13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiEXOSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiEXOR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 10:17:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D0606CF;
        Tue, 24 May 2022 07:17:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m6so21088456ljb.2;
        Tue, 24 May 2022 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UhK0bDZ68ntUY+/oetRVvrLTufm7rmDLfHJAKjwa4f8=;
        b=a/88WIDtocGTu2X21EYVOqlJdr3HXJpDYYHoP4sDs58zILqna2nWtJlf8vGJWwvnyA
         EVusAnGhKyGselgdecIicU0VDrM5R6foYvvCP5QN6CjBolIpSZ9bcHVXUfmB0ogV9sq+
         +sC6EhbQe1IxQT2ZCFg8NrcI+qoXRCcj/whB/Y30+QDItWsy2S9+MqWXlRVOOlwuDXOO
         OxQMF0Hr8ImHZ0Hn3qurKBSSBGWxkW1wO1L2CkTKOKAA6LuWoRdgyAtBBnTpqwBdkyph
         5MnShONwRxtjoOdsm2qUR9EZLEEH23bNJnKmzYWoV1bdSrzrM/Gs0Fq0WSo4dbna81NU
         MQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhK0bDZ68ntUY+/oetRVvrLTufm7rmDLfHJAKjwa4f8=;
        b=rdfzSGs9skytP5NPxfooiKkyZgkh2/pWIcqh6LdeWSMc7BTBAZYFR+UH24M4KBAxRT
         I10DDqoOvXvyq/1Xj6ae6ENORY5hOOqxTdkXFMRPkFkg38uLrH/HkhRZEK9LbzaiT9lf
         EMaV0fUQfnn3y2uzx4oSYk8zBYE0orDIytA8oCPeAJ+sZSbslbEgxee2ePTxA/kkg1CO
         Zzq0orOvXXRXuZLVJm8VYFHd5Loilvmo7L9j1mFxr51U9MYw/W6qJnkjDoJZru8wGcfr
         vzm82R7+kzlgeKZzLJ1mO2wEMTLsCOsARRng+jwc57y6anwtz0SCfFERQv29qCFpDQUy
         rseg==
X-Gm-Message-State: AOAM533tu9D6d+D3gQ7oC2bWhrDkWFoxUVudej8U0z63053U4ILdKO0u
        HzR7kkBryJ8brvqqrwNsGOk=
X-Google-Smtp-Source: ABdhPJwdfhgKFgR4klzcsMZeNBRACEBzfGNe8lHnCE8OizzCUqsi7S/nfSBIUh/NvTN/thW9h2IRng==
X-Received: by 2002:a05:651c:1791:b0:24b:1797:53b1 with SMTP id bn17-20020a05651c179100b0024b179753b1mr16768545ljb.269.1653401876574;
        Tue, 24 May 2022 07:17:56 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id c8-20020a05651200c800b0047255d21102sm1599688lfp.49.2022.05.24.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:17:55 -0700 (PDT)
Date:   Tue, 24 May 2022 16:17:54 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Message-ID: <20220524141754.msmt6s4spm4istsb@quentin>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-2-kbusch@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The getting pages setup for zone append and normal IO are identical. Use
> common code for each.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> +
> +static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
> +		unsigned int len, unsigned int offset)
> +{
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +	bool same_page = false;
> +
> +	if (bio_add_hw_page(q, bio, page, len, offset,
> +			queue_max_zone_append_sectors(q), &same_page) != len)
> +		return -EINVAL;
> +	if (same_page)
> +		put_page(page);
> +	return 0;
> +}
> +
>  
> -static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> -{
> -	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> -	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> -	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> -	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
> -	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> -	struct page **pages = (struct page **)bv;
> -	ssize_t size, left;
> -	unsigned len, i;
> -	size_t offset;
> -	int ret = 0;
> -

> -	if (WARN_ON_ONCE(!max_append_sectors))
> -		return 0;
I don't see this check in the append path. Should it be added in
bio_iov_add_zone_append_page() function?
> -
> -	/*
> -	 * Move page array up in the allocated memory for the bio vecs as far as
> -	 * possible so that we can start filling biovecs from the beginning
> -	 * without overwriting the temporary page array.
> -	 */
> -	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> -	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> -
> -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> -	if (unlikely(size <= 0))

-- 
Pankaj Raghav

