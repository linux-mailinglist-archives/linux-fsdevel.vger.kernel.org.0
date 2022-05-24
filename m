Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5816532C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiEXOct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiEXOcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 10:32:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4C544E6;
        Tue, 24 May 2022 07:32:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w14so31097031lfl.13;
        Tue, 24 May 2022 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4j39NJc6sU41M/B8jcObsiWIvg/EWGFaCCygzdidZ7s=;
        b=TvsA2sgYm5FcpmwHRkqs7sSnhMfLjPPmcMRXKok5mjT2juwx1x8mTWhAc1Ge+Hd6xW
         8HAo5jJ3Gui4w/5aG8c3U6mGHZtKVMuc3krA0GEIDomezldTxlC8lIb8U+MlxS6PaiJ5
         CA7mOaNJKg4zsSEy8YcnkGE1O1qrOrkPQYROdnHjVmUOhQ2ylKIUM76wWcVtM/pQ2q/M
         so9cY+r3TKWxf0o5Dl1wMEcmkwI/+NYPISg480vbwjiQuQc75bRkOLIh/74fsxsuXRco
         O17F3Tl2q/ZS4eDttgebwwukbYNQGLnukQRBGGAvDBup02KcEninFSeC5z2qjVV+PFRb
         4+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4j39NJc6sU41M/B8jcObsiWIvg/EWGFaCCygzdidZ7s=;
        b=ZdXNy+5YrxmnalWCC+6YYfwuedEC9HTak3lmJFz4/xh83IycNjOw1mnzXuCfh7fWdA
         udojBJ8c8sQ2vbsC7No7/5xBI+CTrZ8DtD1Q0RYQEuXq9EeJ2+rIQADvlvzucMnhJYVE
         jISSKcIgcZSG1TLPG9TuxS8mevJpuo3tgiJlFupi0uqccpZ/fOm7vCOQlFqTvRghEOK9
         DRB+J2NOIQhqfS1ZaZUJRKJ6h1AR5NX+Cue+GsW6CQ3XkQAvgNbkLRmTz8Q4cikp7Woz
         VoI2v7ZBp91eZh6wGOfBG+Eodhnc6rnCW37PAA41/Dj1OmCV/XR8h/LdvY9z1hNyN6sg
         YRXQ==
X-Gm-Message-State: AOAM530EliY4VE6wtfaprOTE1BrMWt+/gT4jeyB7hdsltAbsTXi9q773
        7MvHpx1nKbx6HbyaqAeC5IA=
X-Google-Smtp-Source: ABdhPJw602Y4kbrtjezGEuz/h1G0EQTkgESbEJpilAdtsxM3Qysju7aQ0R1xKc+N1XK5tfOJ4eHc+A==
X-Received: by 2002:a05:6512:39c1:b0:473:be4f:726d with SMTP id k1-20020a05651239c100b00473be4f726dmr20308428lfu.259.1653402762625;
        Tue, 24 May 2022 07:32:42 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id l14-20020a2ea30e000000b0025099660220sm2526539lje.137.2022.05.24.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:32:42 -0700 (PDT)
Date:   Tue, 24 May 2022 16:32:40 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 5/6] block/bounce: count bytes instead of sectors
Message-ID: <20220524143240.rpnq3a5zbqy3n5ao@quentin>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-6-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-6-kbusch@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:18PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bounce.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..20a43c4dbdda 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -207,17 +207,18 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	struct bvec_iter iter;
>  	unsigned i = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors = 0, bytes = 0;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
bv.len is unsigned int. bytes variable should also unsigned int to be on
the safe side.

>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> 9;
>  	if (sectors < bio_sectors(*bio_orig)) {
>  		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
>  		bio_chain(bio, *bio_orig);
> -- 
> 2.30.2
> 

-- 
Pankaj Raghav
