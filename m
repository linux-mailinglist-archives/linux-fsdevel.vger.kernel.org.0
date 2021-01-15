Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921542F8837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAOWPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAOWPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:15:02 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD5C0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:14:22 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id h4so13274723qkk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VoLQECfseYAV/zUcv9S4Mgy+WEFb7zTo1bVUUery1Z8=;
        b=Yg2yiCGfNAK6YgdIgFk6mh0pTMeQShQX/J9/LROcIcjXYoyRrLhYz4M+Oz8IjKYm60
         Bx+s6QfXNti9+5qPhnNjIOS2T6mp9i5z8+QUb+BFwM51ahFWXzLLdSUka02XcCUKHXuf
         KVnb7l215wLTsBvXppTotCh0UR6veqdA4zw/7Pad0XadAx9BME1sNMzcAZe7Fgdiok1K
         7WlAIowRtK42eJ/sqNtfXUuZcXH3g9XVSlk5nBJ/2h/IAly36zv2cg4xtasv6uLY/YMc
         RvF3k7OBJ5Mz10vmV7liJ4AWw/JxYWHDRqUFZ3SA6gbbOTnnrA7DxW6m4R2U+31i60LA
         eCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VoLQECfseYAV/zUcv9S4Mgy+WEFb7zTo1bVUUery1Z8=;
        b=nn1sKcGCfqitwCPXO1+o1rVMsnLn1Ztq5cBPBUGdKPmDv+AYXdOt8FJDtnc44Fha0O
         zcVyglFP3HBKs4w7MrZO5hVja33dDgms2DpnQQnRTsYLMtUaQGbeDPJb13ZP+9eADhPt
         T/n4nkDRumyHGslrwc9q65cqZvz5BTkg3CKmYuf9810IW011UliCHIEmUuejrY7Q95no
         pvgzqCqKcgxOgB8HMVOQxG24U2+jfoobrFlQKdrObKOB9Kk9Ct1k3Wdcx4y6Y8SZV3cT
         6oxCF501SWDabRKxEnu6vLZC5qcdBMiprq/7Md1Y/igMqiDhuyT8Sp0DTFALgwXP9fd+
         p+qg==
X-Gm-Message-State: AOAM5330PhpHyssVtx1AXDJOXYLlv6PDeQGkXDXTikFYnPu0jPpXRF9T
        Kz5TT+vBujlBdlfzV78qmTPCnfs9A+uFv1yV
X-Google-Smtp-Source: ABdhPJxD29qDXH4yI1yUvfgjkrId1RBDkGZlKjxe3SH08PjiLclmD+6yWVyPABUPQK4CJ/NBEGT5TA==
X-Received: by 2002:a05:620a:2047:: with SMTP id d7mr14514210qka.255.1610748861214;
        Fri, 15 Jan 2021 14:14:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id r190sm6061510qka.54.2021.01.15.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:14:20 -0800 (PST)
Subject: Re: [PATCH v12 19/41] btrfs: extract page adding function
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <59940825e958cf3e4cf99813febae57beb86ddaf.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d460ac3e-91d2-4cea-2c12-6e7bc51e37e1@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:14:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <59940825e958cf3e4cf99813febae57beb86ddaf.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
> This commit extract page adding to bio part from submit_extent_page(). The
> page is added only when bio_flags are the same, contiguous and the added
> page fits in the same stripe as pages in the bio.
> 
> Condition checkings are reordered to allow early return to avoid possibly
> heavy btrfs_bio_fits_in_stripe() calling.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 57 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 129d571a5c1a..96f43b9121d6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3061,6 +3061,45 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
>   	return bio;
>   }
>   
> +/**
> + * btrfs_bio_add_page	-	attempt to add a page to bio
> + * @bio:	destination bio
> + * @page:	page to add to the bio
> + * @logical:	offset of the new bio or to check whether we are adding
> + *              a contiguous page to the previous one
> + * @pg_offset:	starting offset in the page
> + * @size:	portion of page that we want to write
> + * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
> + * @bio_flags:	flags of the current bio to see if we can merge them
> + * @return:	true if page was added, false otherwise
> + *
> + * Attempt to add a page to bio considering stripe alignment etc. Return
> + * true if successfully page added. Otherwise, return false.
> + */
> +static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
> +			       unsigned int size, unsigned int pg_offset,
> +			       unsigned long prev_bio_flags,
> +			       unsigned long bio_flags)
> +{
> +	sector_t sector = logical >> SECTOR_SHIFT;
> +	bool contig;
> +
> +	if (prev_bio_flags != bio_flags)
> +		return false;
> +
> +	if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
> +		contig = bio->bi_iter.bi_sector == sector;
> +	else
> +		contig = bio_end_sector(bio) == sector;
> +	if (!contig)
> +		return false;
> +
> +	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
> +		return false;
> +
> +	return bio_add_page(bio, page, size, pg_offset) == size;
> +}
> +
>   /*
>    * @opf:	bio REQ_OP_* and REQ_* flags as one value
>    * @wbc:	optional writeback control for io accounting
> @@ -3089,27 +3128,15 @@ static int submit_extent_page(unsigned int opf,
>   	int ret = 0;
>   	struct bio *bio;
>   	size_t io_size = min_t(size_t, size, PAGE_SIZE);
> -	sector_t sector = offset >> 9;

offset has been renamed to disk_bytenr in misc-next, you'll need to refresh 
these patches against misc-next as this doesn't apply cleanly.  Thanks,

Josef
