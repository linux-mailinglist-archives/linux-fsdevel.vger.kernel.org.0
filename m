Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E97534883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiEZB7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345864AbiEZB7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:59:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F6BCE82
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530339; x=1685066339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jfax4/+o7wWRlUxJ58mTLPx93F9LIro2F7EUGaGjyaQ=;
  b=Q4sq/ydDqkarzWJBxBzV72NzYgjRUuwmOC4szxNTKKp009jS8TY9Etdq
   mX8rMNJ2LIoLyC/k++gum4ErpAocXmlTzvH+5dK1LBexmTQFlURn+YQv4
   OngRTWDjJMu2Ve34tIv353CWEUh8rs8vHkKSxMGHxhQAx5pYUgbTJkqbt
   u9rYLlhepien+Xly0aRPVl9r2GqQaqRLGUsaOHR3+15kPPokENqcuKSy0
   2qzcwVQ4ViXxBm3Kk+/4+uGAcNLpYZ2Fn3x7+fnHFFzVpVftj7sWKz2GO
   DYh1G8aavA+ZRqmu2Wrd1NZB/l8Q7aYAzsRKxp0H8tR0Nk4AasayW7hSb
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="313462387"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:58:59 +0800
IronPort-SDR: /mjHVgReQJBoUHWA0KEySd5O+YK4NVGT+vCnc929lrGSTuww84iY5nbQz5JV/MRWEBHexA+uhs
 i42x3gjavcrd1Ki9Wv8jYlBHbcB4VWeQzFQgCv0rKg9YubClwx2O1d2OakpwwkKc6Df9OQHdeq
 nhZG1gTOHfE0ZTp+lAVyUpq/xTrUi19gVTcl398EMYOn7TO8Ej2uIo7wW7rO8+72spJx4Fq2bg
 BfL7jP8qV350WPFrVj6PVtovJrqd15oU1XGZ2eXmOga5Kl1FA2vikcReMHS75vmXFJ5zoLXodh
 MCBKevQvPKFPs88gKQ63dYf5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:22:54 -0700
IronPort-SDR: lWaHQ/SGTzsCT2tlImO7vp3riqo7zWHBovbEMesVVxBHQdYrcsLOohV4OxCmeRcL0VR4Ukif0H
 /L/pk9+HFLZtduvO17d7vVxW4UCYK5pqdW22C3eEeGeR5xve8K/1GSFTGQ2slWW14hmarQnb3h
 C1eAXTtVTtVsk0aDBalWJiOJJ1dwx/2+zOtHZGzdStUA2ue+RwMwwe093U0h0mm3eWCXsHpOkU
 jSWr1pit6W26Nnj9zVowhJTvpJxnl3b+uy0iB1C5ElZqZNLfNbMXZ0U5y+j0ZQsp+iHsivCBms
 9oI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:59:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rhL5y6Wz1SVp0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:58:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530338; x=1656122339; bh=Jfax4/+o7wWRlUxJ58mTLPx93F9LIro2F7E
        UGaGjyaQ=; b=je4cUUhXcPquMpIdPRIPnEHSDzZ06F6IEND2ihyiFFwAi1inVXq
        YSl/oJgivbNBK15zDtuoli7n9u/nbew9lfAuFmXrvaxKaUw9p9KfLKywGsh3aPfQ
        4MIpQr5vMTEcLN8A1tKFduNDJ4OIUDhujXDYWc34jxD8fRygY2peBNGIhLeesFXg
        iYnIkzx1fqoMBSi93aFwDfCiMgqRtTIiYU0KK9v7Mw86+8kFM9agbTRJcuQgNKV9
        1V8fMANNSmsxzLcXtk6lAAf4iKI7N07v1DksW35JUAiWMVKhEcy2wxScD/EnQ9Bx
        JC0fy0+2zk6aMm4lpS2sxvtItTpwZmXIsXQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wet7FQEkRWgD for <linux-fsdevel@vger.kernel.org>;
        Wed, 25 May 2022 18:58:58 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rhJ4wFBz1Rvlc;
        Wed, 25 May 2022 18:58:56 -0700 (PDT)
Message-ID: <2c3c98de-e9de-eebb-87b6-fa59cd2784c4@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:58:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 7/9] block/bounce: count bytes instead of sectors
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-8-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-8-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/26 10:06, Keith Busch wrote:
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

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
