Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE253488A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbiEZCBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 22:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiEZCBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 22:01:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC5D5C
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530477; x=1685066477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kw/sAdj4ukNgcfd6qDl3p7FNW5+pO8XjZkjcbAYSL9s=;
  b=HkDmrUI0r4crN7A0ffjMn3z+aIxVnSvnJSSgt9QEIKWjSXsSLzIUxS0S
   bmvpZFQhGK8o1DKwZQRXsDHHGX4WTOvMCfUUAZnknrcqG3QA6RlKWkCUw
   KFYBF91UaK9Ra3fBC4gBwRU6n/oTaD3bIa5y80hen1M1VekwBW9O8BChF
   +FxH+tvpsaByJEkNClD9F3IjG4f1t5WRZeLGgJwpiZkT7svWXVdr6q2uP
   YgLp1wZyeGEdt+GqX4/ysKhyka7LL/axaTbEy3s4mXmJvL/dNVHs8oogO
   mMyg1kYE9QaEBpMgSqBQ3goHj8Yat+uES2bXgt+VGrJXFeIdH5kQ857cT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="206333494"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 10:01:16 +0800
IronPort-SDR: ldIuQAJ2+prVsqMZdDCBRbs9LeKks9pBxPMefSbi0EIzBBt4WfG9N7nxFoIu7a33UOFWEQh1al
 DnE9DggDiFr2s3UTfchC9xkvEJEH8XshNA5OyiE5n3q4uYLPyLaAP3jNi0Doi68rKN+8DogudS
 CL9iAfh8dg0W1gQ4WWxdslRKEO/8H1J6Gj1a9zk8fuIiKYLhhPkWJo93EiopV+VcX4TD6Mjc+M
 Dm+MwwASx0RK8QT9EhIzzSGnkfb8GD7ONQeNAW8mTbDsCj5n5JXfL/6k6ECSC18rpPFuWqyVt9
 F0Ir/xlmgcY/jTcgYWl/JMqc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:20:48 -0700
IronPort-SDR: JjM2UqNeAsJb7FI8M44zVuR8sVZCozq+sIM9KrtBOUURvaq3x4nnG2amBzby08FndePQSluB8e
 Yu31FlD1AhT6lzs6jcyZLc4QK/NnizdEKjiHYXux0RpxrmT3AYB9rvIW50T9Wg+qBefYNbsy7I
 5XZ2klOyz5KS0CeCabxMggkTxEo9NwcIAyXW1asmvBOPhThIZiVdggF2RAj5/vVKXkV0GtqQZK
 IDJPcTK8SZFqGIUccVxEX8w+3K9AmjIO43dXlgBMb+eLigMIRXpBrd76RkVnrrrGBxgzaOcVTa
 WZQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 19:01:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rl05X3sz1SVny
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:01:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530476; x=1656122477; bh=Kw/sAdj4ukNgcfd6qDl3p7FNW5+pO8XjZkj
        cbAYSL9s=; b=jq3vRWPnwiepq/pX6oKU2WgrkOJUAgKObTdal4/UG+61HQNDAZQ
        JidwA3GrtxABJIYsNg7Zv5nRGWOTtUllbXQmYiJTw8flc0ipS1345zsYbxZGeJdB
        GSg/ymOCjoQKKnnhhLNXM3HHnY4iulLiAJwQ+EaUuDpQHjXijPJsdzM/2fqtxnVg
        vbxMrYkwNcPhHzDbPB1wWUZNCnN4nGMN0jwWqFmGmqod6OTk4tPP0ArjUMgYfX8+
        E4dxSfXzrqHtB51vctLlBWCadKkd8dksW6c5YFmMIbDS9opeo8CERFSO27PjbyCu
        YnMW7EG2uc0phPBmMEA6n4uHnQqd0c3ox1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fdetB2gIUNix for <linux-fsdevel@vger.kernel.org>;
        Wed, 25 May 2022 19:01:16 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rky3k27z1Rvlc;
        Wed, 25 May 2022 19:01:14 -0700 (PDT)
Message-ID: <119d9df0-8c9d-4512-d5e8-d5013d2222e6@opensource.wdc.com>
Date:   Thu, 26 May 2022 11:01:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 9/9] fs: add support for dma aligned direct-io
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-10-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-10-kbusch@fb.com>
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
> Use the address alignment requirements from the hardware for direct io
> instead of requiring addresses be aligned to the block size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  fs/direct-io.c       | 11 +++++++----
>  fs/iomap/direct-io.c |  3 ++-
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 840752006f60..64cc176be60c 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1131,7 +1131,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	struct dio_submit sdio = { 0, };
>  	struct buffer_head map_bh = { 0, };
>  	struct blk_plug plug;
> -	unsigned long align = offset | iov_iter_alignment(iter);
> +	unsigned long align = iov_iter_alignment(iter);
>  
>  	/*
>  	 * Avoid references to bdev if not absolutely needed to give
> @@ -1165,11 +1165,14 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		goto fail_dio;
>  	}
>  
> -	if (align & blocksize_mask) {
> -		if (bdev)
> +	if ((offset | align) & blocksize_mask) {
> +		if (bdev) {
>  			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +			if (align & bdev_dma_alignment(bdev))
> +				goto fail_dio;
> +		}
>  		blocksize_mask = (1 << blkbits) - 1;
> -		if (align & blocksize_mask)
> +		if ((offset | count) & blocksize_mask)
>  			goto fail_dio;
>  	}
>  
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 80f9b047aa1b..0256d28baa8e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -244,7 +244,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length | align) & ((1 << blkbits) - 1))
> +	if ((pos | length) & ((1 << blkbits) - 1) ||
> +	    align & bdev_dma_alignment(iomap->bdev))
>  		return -EINVAL;
>  
>  	if (iomap->type == IOMAP_UNWRITTEN) {

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
