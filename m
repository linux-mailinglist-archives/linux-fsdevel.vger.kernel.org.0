Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384845AA52C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 03:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiIBBjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 21:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIBBi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:38:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B8A831D
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662082737; x=1693618737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fkjhkfssw14V/+Vwqu+T+FisZXpvkRyRc6YH1qGQjpc=;
  b=pHRgaYJ/AdDHipl1MzFGGbF9z5hdysda5igteYwnGwqogILX+6guxXYd
   y2TeoQAwieoO9VIJR6PGnkJMV1bu21FT35DcTK6BQpFHIoZY07lHetXa/
   lYAbxIFU1qHd+nDL4rfxR3J7baXZN2Cx47l5hUsCME6lMg1APQjuTR4TU
   BHyMusi6jRGD7GM3L/gPphKpNdLagEtJeTau5lPpQu49H0QBtUhKafoJW
   qbPYdPm0iZeOfUQuuXQp/J3bM7tKNNCYaX5z+eHYJUMKtsn2bKjIBov6O
   C5DyepYIhV+Dv4X9q4dz7Rty/nNc1EsFvKBztPr0PT69r1ulXJdLbeSCq
   w==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="215449441"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 09:38:55 +0800
IronPort-SDR: 8lT3tVzwNuPK9swvZpvTO26NOi+wawr9mFmlZqakzAwurDjuq6Ab3ZDuPjS2uz9/sUX6E1nZV3
 AWc8DsmAFzWw2gipmMKcAvQhI1KVXBib8rES9XUHpdRxrSyhYfdRY6slPEg18fsQnxjSDDZG+y
 D0IqNOp1CZRz9R4NigAeXjDgFZRu2VKgtTbLGccWK/wkTKV1WeUFcJhf7QOBtZR+WGNK3q+0px
 1CU1ID9OxduPdzROokuU5x5tztbXPHVUKGJfb/Ybj1FiuoqHUBmp3KgsfflPtR8507vLZFUKMk
 zKWUvABxQGMVAYBcTGVgX61O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 17:59:24 -0700
IronPort-SDR: 0sw68Y+9rX+LWfsgvIzqljX6lqZcGorHyCZs0TK69A8f3uTBzegFWtpOZD/j7qVH0tcBTT8BOS
 L5oWxL0DRBKs+71lQgzoa2tD6iApicac0SOxghBE+H4PM6lmynDhaJM6exCjGi8XS+yZsHfAzb
 XzkViQwxtrE6qWm9vPW2hjRQxSMjdzlyx9eUg3B3UTZcbnhHweCy4z+WUsSDlea9K1oaIhkIAf
 uLfIuxNcc3akY5ueymLHPpCoykHLlpDgmcD2oFwYv0XS/LTKnfYjoL+o4AeDp5MThi9dMDn1tc
 sMM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:38:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJgYW2fdQz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:38:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662082734; x=1664674735; bh=fkjhkfssw14V/+Vwqu+T+FisZXpvkRyRc6Y
        H1qGQjpc=; b=oDNr1Rs28CmLnSi10thx8HyLuiOkOC/iTGVJ3LM6oIcTWTypKtk
        GEy3MdWhdq/z8QZCv0tXAk8htvcb9A4CF+zS+Di6l4SalNwMVbOHfXHk8k4mTy+a
        /2qWrw6FlpeQzKFf7JOaWqpHoRfpSNDWmvq0rh1Ri8Lq6Amtp1EnsQpXYC6b5wQj
        2VnvPgLhiCUz4cZ7EOU98fdXUgDpY3hvst6YiZhdbZpUl43gpId9mveZ4DDan7oY
        UUEYV212QWjTaL0yZ7HMvElMxJ9xwDNr5NOfGgmBxh/VRh7ZCKuMp7rjRS8F4Sed
        6U9Ir5GpDSYYUaxQTddOJsKnUsqcEB7KkLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fOxzb-_nUQp2 for <linux-fsdevel@vger.kernel.org>;
        Thu,  1 Sep 2022 18:38:54 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJgYS2ngTz1RvLy;
        Thu,  1 Sep 2022 18:38:52 -0700 (PDT)
Message-ID: <c2e15bee-cd4d-9699-621d-986029f337b6@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 10:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-18-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220901074216.1849941-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/22 16:42, Christoph Hellwig wrote:
> No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
> splits and converts them to REQ_OP_ZONE_APPEND internally.

Hu... I wanted to use that for zonefs for doing ZONE APPEND with AIOs...
Need to revisit that code anyway, so fine for now.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 10 ++--------
>  include/linux/iomap.h |  1 -
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4eb559a16c9ed..9e883a9f80388 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -217,16 +217,10 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> -	if (!(dio->flags & IOMAP_DIO_WRITE)) {
> -		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
> +	if (!(dio->flags & IOMAP_DIO_WRITE))
>  		return REQ_OP_READ;
> -	}
> -
> -	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> -		opflags |= REQ_OP_ZONE_APPEND;
> -	else
> -		opflags |= REQ_OP_WRITE;
>  
> +	opflags |= REQ_OP_WRITE;
>  	if (use_fua)
>  		opflags |= REQ_FUA;
>  	else
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17e..ee6d511ef29dd 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -55,7 +55,6 @@ struct vm_fault;
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> -#define IOMAP_F_ZONE_APPEND	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:

-- 
Damien Le Moal
Western Digital Research

