Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769F4C5F3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiB0V6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 16:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB0V6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:58:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D22E25E7
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 13:57:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id l19so9343065pfu.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CLKjOtFJJy2kdF/MZbdbOY3TGf+go0L7UkS+pL1ZdSs=;
        b=a+VXPxxtKf7qC6FgyozL/hPV3uHnQL2GjIZxJVqNNODJTAFsvyIgElZl+LG419S28x
         f9wL6FgvIwC9ty1lMG3XL46p/3F2EF8LlKBGEf2WnL+OFF47WIBBnMag1SuxI4I1gc/v
         kvDougQh2j0dcwW9fjZoO/H78Ew3KD9Lh5BztY4xA9GMQxAfd4saaLKbrl41vBkaDStf
         zx90qfA9HAVf6imn8s5KejRlYjPIOxdeQ60sPQdP9+31wC5xhSvPY5OR4ViMYfb9cZOf
         Wbw55PTgVU2bZq4HdpGHTuMoByn1oqlw14N226EPhezkVFwI6DpKW2ZypDzmmbywqdng
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CLKjOtFJJy2kdF/MZbdbOY3TGf+go0L7UkS+pL1ZdSs=;
        b=Lvcw3v4TKzlnr+NxHv8A1iJCvZ5X/UreqZnqkh4cqNaEFsatCxdpAPhGB/Kt0Z0QVv
         kq2hINK6sgPFWjhmOBFQEKovDUcff82wq8Op2tIuUlSOOsyUoBirSAnQGzM2zjrAFZ54
         mIecj8vzLjTkbT0EfZVWbUUqgnA/VNEQfaO8MmQ+HzChP2ZsYpC3OL9XWn9IcpqJoQSX
         YQIVsYLKhGbbgE3RU/HkDd49gk+7pQ3BFrub3vyBztnct9aRA7cwDlbkP3+zI0aAjMYj
         KRZhRuf1RShuwIW5IL0ST/2+Hy+2Z3b0TX7qY83P0hLXZ3ZzxuoyYyihItfkznrOiEic
         69Iw==
X-Gm-Message-State: AOAM530mT7uOLcDyJxSa8xPXFUDtA6GTu3Js6Jf9QPSaWt20AykSfkJ4
        siUoio2h0jXhnSLAFLVV9WegLQ==
X-Google-Smtp-Source: ABdhPJzIFa6TYJsLnCkUEIz+oCSZ+CKQlbxKYEKU/adzUzLJf7qo4n0bWIhWzBsHpTAnkOqmk8Ppug==
X-Received: by 2002:a63:cf01:0:b0:374:2979:8407 with SMTP id j1-20020a63cf01000000b0037429798407mr14430181pgg.521.1645999065747;
        Sun, 27 Feb 2022 13:57:45 -0800 (PST)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a00228900b004f3ba7d177csm10816506pfe.54.2022.02.27.13.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 13:57:45 -0800 (PST)
Message-ID: <06469550-a679-145f-b16e-2f1ffc0b07af@kernel.dk>
Date:   Sun, 27 Feb 2022 14:57:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/6] iov_iter: new iov_iter_pin_pages*(), for FOLL_PIN
 pages
Content-Language: en-US
To:     jhubbard.send.patches@gmail.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-3-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220227093434.2889464-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +ssize_t iov_iter_pin_pages(struct iov_iter *i,
> +		   struct page **pages, size_t maxsize, unsigned int maxpages,
> +		   size_t *start)
> +{
> +	size_t len;
> +	int n, res;
> +
> +	if (maxsize > i->count)
> +		maxsize = i->count;
> +	if (!maxsize)
> +		return 0;
> +
> +	WARN_ON_ONCE(!iter_is_iovec(i));
> +
> +	if (likely(iter_is_iovec(i))) {
> +		unsigned int gup_flags = 0;
> +		unsigned long addr;
> +
> +		if (iov_iter_rw(i) != WRITE)
> +			gup_flags |= FOLL_WRITE;
> +		if (i->nofault)
> +			gup_flags |= FOLL_NOFAULT;
> +
> +		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
> +		n = DIV_ROUND_UP(len, PAGE_SIZE);
> +		res = pin_user_pages_fast(addr, n, gup_flags, pages);
> +		if (unlikely(res <= 0))
> +			return res;
> +		return (res == n ? len : res * PAGE_SIZE) - *start;

Trying to be clever like that just makes the code a lot less readable. I
should not have to reason about a return value. Same in the other
function.

-- 
Jens Axboe

