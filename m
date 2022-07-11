Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E456D40F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiGKEs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 00:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGKEsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:48:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6AD640E
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657514892; x=1689050892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qZn7QroGikdNtn/glSqxQ9bThZH7umr4K5JDGZVXNdM=;
  b=jXUAV9FvWBJ1eaPC7VIGIBWh+MIz3frZkOw3FML/YL/qovI33zkLnpkS
   jQUlMDxlXnhfc6AA5qrnYnKbpNOQEBlD/k3ovA3REiR6odOOxTMraZAzg
   qowAxgH96gryGZH+nWKS+wEfar2MHDZ277oOiAu9/iQRlRiorSD3D6yWy
   9ERMNwNPJIq/Vi2/EB2Xd4MZs9fNrP0hvEYbCCezmItKzuPsl2IZqVj03
   pvPRyd1IUOWFxnyTaXg9yToKPtxs/o/G9lB1dvI/MVksAC9eSasLgwg6K
   91M0hK9L5+0/dIHazFVSlT15voSCr7Ii2H6yPV4IiCHfXTKd071/KwpuS
   g==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="317462894"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 12:48:11 +0800
IronPort-SDR: j0ppF8DSIbkigzMK/wHYfXoBn5LYjx1129Lw3iTASP3GRCderMo98+H28LUjwo3h/otcARdnEz
 wLm2cxRoHsh/HRokGPGdquJkri8ni+tBXCYmVu+/FeG8/RLx+pOgsrYZ/JgUWi9dkfJagD9fek
 p+ca0ZbQpd8+VMNvAWZCtDHw7hndgRiF9fs1qUQgUNaMkhEzGwHRf3TNSyENWxwg3JxCJXVaww
 wx/yUpDcdnbghcZxoBoKyGiSJAW53+qrs5DGu1bJ0Sa6yzriRGdG4l0cxks6vi9AcLXE/ABDMp
 15lGal9ArmXQrnE98FpxZhRX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 21:09:49 -0700
IronPort-SDR: WlIgCP33L/KnawkIK5OQjQWHZlAE0a8wFXejbWqCSDS7bJFyPnUbR4ORSnFyILLRnQL2gnsx6i
 QdzT/hQeP/XFXmwKetmhyqyohbAW9Nswwf7AOaqIt18JOyV7iSUHn/obWkroFxQsvBHPgrVhyP
 ThU6u86r32YKvlD9BlvlDxXoUt+CzPHzVJuvYCz4Zh7HEma1S2T5agkdm61lew0RibikR8Fz56
 7phmDCQBJCkBYw3DlyWHND9mUdh7bfl9sjjrzinTY1vgDh39Tm2GQCKy/oiaRiLT3mZNOzQSNL
 mMI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 21:48:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LhBGM05cJz1RwqM
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 21:48:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657514890; x=1660106891; bh=qZn7QroGikdNtn/glSqxQ9bThZH7umr4K5J
        DGZVXNdM=; b=qqlKxkpdZTVLycDgMmbrkklYGySIiBpLjhS/55loaQm4qxzselU
        hewMDOcM9lLB2YFLUSJh8CEtNn15NHIFT3H9k6phuFdwYi3VfpoKMusFXm7489cp
        2PHn3V1jDzYvJCpXuqd6dwT9er86HVtwLBVZrI+K/8ToVbtkhElH76LQkTzEVLmL
        bgTlfes4bXNWyRiorBpk3qHU74/lgHlEVmmAqc1jKszgfl5nthToJJcYAC3RtjUX
        Szfd+ISW3WWytyIGnCTcJ4BD6mj5Z9ree82m5GtAH/V5LaMRh7RSVrf16fSB1MbM
        uNqBWzUy3M7cvaV+YgV6vWyIuFvkH6K+P9g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HpKCoE-A6SAM for <linux-fsdevel@vger.kernel.org>;
        Sun, 10 Jul 2022 21:48:10 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LhBGK07lNz1RtVk;
        Sun, 10 Jul 2022 21:48:08 -0700 (PDT)
Message-ID: <ae8f3075-f13e-1ce6-4bdd-86926cf3ded2@opensource.wdc.com>
Date:   Mon, 11 Jul 2022 13:48:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] iomap: remove iomap_writepage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220711041459.1062583-1-hch@lst.de>
 <20220711041459.1062583-5-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220711041459.1062583-5-hch@lst.de>
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

On 7/11/22 13:14, Christoph Hellwig wrote:
> Unused now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 15 ---------------
>  include/linux/iomap.h  |  3 ---
>  2 files changed, 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d2a9f699e17ed..1bac8bda40d0c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1518,21 +1518,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	return 0;
>  }
>  
> -int
> -iomap_writepage(struct page *page, struct writeback_control *wbc,
> -		struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops)
> -{
> -	int ret;
> -
> -	wpc->ops = ops;
> -	ret = iomap_do_writepage(page, wbc, wpc);
> -	if (!wpc->ioend)
> -		return ret;
> -	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> -}
> -EXPORT_SYMBOL_GPL(iomap_writepage);
> -
>  int
>  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e552097c67e0b..911888560d3eb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -303,9 +303,6 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
> -int iomap_writepage(struct page *page, struct writeback_control *wbc,
> -		struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops);
>  int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
