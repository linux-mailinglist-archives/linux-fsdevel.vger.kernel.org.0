Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF5534856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiEZBsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiEZBsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:48:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B7A0D04
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653529700; x=1685065700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FME4v/EvPahQmZZ4OvbyPPXbKI1vSzlssNTi3dekI9U=;
  b=qT1AkY2D1BodPv1x2lsIQ1vZvSe+Dy+5ui7uLpkotzXIRqMKh1h42Mn0
   xbIymH757HDIXM0ll1Ff3vBuFkAqtpGL0bBG8TC0CahwKpidrfofRHe1C
   R4CCLcLW9hNWfOMldyyu0w/wFyDNahZ8cAHKmoWScB5ZHdnX5Xhjkvej5
   zzpKfEnmhefhYOErvWXm/0Rm56NWO6Wa2XI/hD/MHFO1w+WCidU9ThTb1
   uq6EDovN3L3rhXz+/pCFwJ1QAEEuK1WOCAPMxSPjdVsz8oJEXQbQXHnu+
   htCiKDTS0u12qDJXRahyySOg8z7mg9RPoUcGrTBl/Gmhyoum4TGNob5p+
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305693465"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:48:17 +0800
IronPort-SDR: A6Ymaf5p4YWCLvloOmoWv4Pei8Wc+qWDvNO+5dNLPYPQwqk1endPfV9h7Wa20emAmlMmjw4C5N
 SKOHpkVKm2/3HHFV5RH133wimSHwLDyUsvFwjk4urtnd62Q+mVISyHcgGAwsdcH5yJ7dZZXNyJ
 3uK9E1wJkpuDdTGDhTmycFf9oeq1IcMFa4qjxIrQpsfi02jmFfNIrJUY7DmYOmLF48c3TNxq1b
 Y5dQ4hjaI/J05OYjL74h3fRALGWK1Z/iaaFiHGKZLD6qtebOxkKniREnchRL6Awb8vxVxPAe2p
 vsP4s6zn6psNfiCDU0k34+GU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:12:11 -0700
IronPort-SDR: 5cKSb35WdGxsGg4XS13U5kyumcBW2KxeoODyrlak3/0NpdDFJpfjB/D8Hm1ObV/T7IO7ns0PCT
 l+M4BRoTFIIX7D0oDwqBiXeIBmhsB0e8FolRBCDR9cVgbriwLCWEjN9k1lzhyzNPZNLJtbqNns
 pJqGUEiTrABfNkE8d61BXP6c5ClLFvgoCBmNPbMrsvUFrSl+EfGn7R0XskSqSdafPRS3zNs7SO
 CUb4JWq7SsgsZN7gXmDakFEKhybf/zI7Y5/Hz7CxkdxRjOPTuliDjCw/w1mlYJZtAO3P5hB1PL
 DHs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:48:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rS009S6z1SVp1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:48:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653529695; x=1656121696; bh=FME4v/EvPahQmZZ4OvbyPPXbKI1vSzlssNT
        i3dekI9U=; b=Fx0wKIHJ+JDiE1SD2WiE4srfh71/huzJ3xospp7ZZaUzHD7ihGk
        RQHUhJsRjvtR6YeYvOPp5jIPH0hjuJAND3dEGFfww7Lcw/sx3Lvbri0zlM/WZ2Zw
        KnMQHfTxQS+ZtJ6PY1lHBDazZg04KnXIYvL5UuMSip6PLOX9YcGMmSAiFFXUj3un
        9xYPgc8IWHI0f03PFXqa9H1u6zfE9BowxTwDd6G3VUGPS1PSLa/Lp6YGgv/kn6GT
        xES39eNzj/Iz92JsAAQMeLCbaHsxKO/YUvPW7Oq7/cUOoUNcVVdAno7R1FeQYaDH
        2VFVfmssDJFjNcmnk3X9tBinhyRPc5JbVkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TP8O5fplGTYZ for <linux-fsdevel@vger.kernel.org>;
        Wed, 25 May 2022 18:48:15 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rRx5hf6z1Rvlc;
        Wed, 25 May 2022 18:48:13 -0700 (PDT)
Message-ID: <e87bd23a-1316-0396-0bb0-658c6105eaab@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:48:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 1/9] block: fix infiniate loop for invalid zone append
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-2-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-2-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/26 10:06, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 

s/infiniate/infinite in the patch title.

> Returning 0 early from __bio_iov_append_get_pages() for the
> max_append_sectors warning just creates an infinite loop since 0 means
> success, and the bio will never fill from the unadvancing iov_iter. We
> could turn the return into an error value, but it will already be turned
> into an error value later on, so just remove the warning. Clearly no one
> ever hit it anyway.
> 
> Fixes: 0512a75b98f84 ("block: Introduce REQ_OP_ZONE_APPEND")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a3893d80dccc..e249f6414fd5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1228,9 +1228,6 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  	size_t offset;
>  	int ret = 0;
>  
> -	if (WARN_ON_ONCE(!max_append_sectors))
> -		return 0;
> -
>  	/*
>  	 * Move page array up in the allocated memory for the bio vecs as far as
>  	 * possible so that we can start filling biovecs from the beginning

Otherwise looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
