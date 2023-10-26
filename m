Return-Path: <linux-fsdevel+bounces-1270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE977D8B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 00:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E345282135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D783E48E;
	Thu, 26 Oct 2023 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Val7qQja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF064426
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 22:10:12 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC5AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:10:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1caad0bcc95so11505945ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698358210; x=1698963010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYNchWqO1LpWgbbwQzsguSm5v00pTMPwkgvHmviTiDE=;
        b=Val7qQjaB1mTS9qOOyngAF0jRGgr1RjZmQSQUSKd4kbrucUWIT+yVzwhzatZwCYJb0
         Z2cjF03FAJn2uba41ctbZmo+C49pofODAHAGrhMImEs6qxFDi9EByaWR+b+iLSTm86ep
         IrBdowgkSMfGT+BUN5vESTzSG88iY8gLZeBXbLR6J+2Gi7zRQbdEb+rifPyYHVDMXGyF
         3bKVmdgMMRulX/vyYAOjaNdEAGoWtaeM0UuwxKOVY+h9IyZCoJQCAwjN3+lxEeMz3pKd
         qeVNiQ3m98I2PdOiUcZ3bB8vhTj895y3GYqX/G2oPYczhaaVywB2vu40H0cakbsMgyHG
         pdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358210; x=1698963010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYNchWqO1LpWgbbwQzsguSm5v00pTMPwkgvHmviTiDE=;
        b=Yhtg3hf606XWCrthUvQfPBWM5Wq1x7zyKY6mJ5aYn1wyAN6iyrfXAVo3dQK+O0romC
         uoWhGTu143wfbrJ15csxiP6194LnoP+J0hDzqP0r+ouhX/WVzwA/Lu5sjDt54Yv448BM
         oWy+GXz9EDlA7bJhSv1qQegxSWgExDrXzXkDNLKTNuW7U73NLrYKWQ5S7iMs3oSTQP++
         Ej7B0N5K6O62X9FN005xClUgqtiKDVSb6KXzgzypGNbwTCpZklANlq/TLErLrELXqYcW
         9j2/f3CAIi2Z1FcyY6Ui/ug9UNM+mc7vsGgbG0amDk9jWlvW4vk275Zi/IRhonBPOrJd
         i7qg==
X-Gm-Message-State: AOJu0Yxb1jqslqejxTYWWYSBAlozPbd55bzTiyPZzdMqnao8t27qhUqu
	9m75M1lqUqGy2Mq84aI/KVugAA==
X-Google-Smtp-Source: AGHT+IF1e1I0bfxfleEljjMhedmjgyA0ZOFLEduA9gluTfD6lKtTmCe5Tie2PlpojZL//GvjCQPTZw==
X-Received: by 2002:a17:902:d1c3:b0:1c9:c91d:3fd6 with SMTP id g3-20020a170902d1c300b001c9c91d3fd6mr766630plb.5.1698358210490;
        Thu, 26 Oct 2023 15:10:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001c72f4334afsm181745pla.20.2023.10.26.15.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:10:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qw8YJ-004M35-0p;
	Fri, 27 Oct 2023 09:10:07 +1100
Date: Fri, 27 Oct 2023 09:10:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, djwong@kernel.org, mcgrof@kernel.org,
	hch@lst.de, da.gomez@samsung.com, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Message-ID: <ZTrjv11yeQPaC6hO@dread.disaster.area>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140832.1089824-1-kernel@pankajraghav.com>

On Thu, Oct 26, 2023 at 04:08:32PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size (Large block sizes)[1], this will send the
> contents of the page next to zero page(as len > PAGE_SIZE) to the
> underlying block device, causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> [1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
> ---
> I had initially planned on sending this as a part of LBS patches but I                                                                                                                                                                                                                                                  
> think this can go as a standalone patch as it is a generic fix to iomap.                                                                                                                                                                                                                                                
>                                                                                                                                                                                                                                                                                                                         
> @Dave chinner This fixes the corruption issue you were seeing in                                                                                                                                                                                                                                                        
> generic/091 for bs=64k in [2]                                                                                                                                                                                                                                                                                           
>                                                                                                                                                                                                                                                                                                                         
> [2] https://lore.kernel.org/lkml/ZQfbHloBUpDh+zCg@dread.disaster.area/
> 
>  fs/iomap/direct-io.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..04f6c5548136 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	struct page *page = ZERO_PAGE(0);
>  	struct bio *bio;
>  
> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));

How can that happen here? Max fsb size will be 64kB for the
foreseeable future, the bio can hold 256 pages so it will have a
minimum size capability of 1MB.

FWIW, as a general observation, I think this is the wrong place to
be checking that a filesystem block is larger than can be fit in a
single bio. There's going to be problems all over the place if we
can't do fsb sized IO in a single bio. i.e. I think this sort of
validation should be performed during filesystem mount, not
sporadically checked with WARN_ON() checks in random places in the
IO path...

> +
> +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
> +
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, page, len, 0);
> +	while (len) {
> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> +
> +		__bio_add_page(bio, page, io_len, 0);
> +		len -= io_len;
> +	}
>  	iomap_dio_submit_bio(iter, dio, bio, pos);

/me wonders if we should have a set of ZERO_FOLIO()s that contain a
folio of each possible size. Then we just pull the ZERO_FOLIO of the
correct size and use __bio_add_folio(). i.e. no need for
looping over the bio to repeatedly add the ZERO_PAGE, etc, and the
code is then identical for all cases of page size vs FSB size.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

