Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32AB534865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiEZByK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiEZByJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:54:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228DA7769
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530048; x=1685066048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qa0mv9ufLHh489tJlVzb/NGzKYn3PLjyhz6ZhYOeDvk=;
  b=j6nfVmWchS9dm2idrhj7sSuwAXqCpG8KtMlULwfN+x4uHgojM+PyFLAP
   C7bZUz/5lbpUt/JS6RsXCsVCNKQlJEms01gdP1tDwPzEaIWT/pvxkLiAJ
   PAZ+W/0Vd7o2XqeQ8Yl2bUCLn3WeKRrF7Lf2Y6jx5sQVO4EbowMvDJkgw
   mAFuZBgRSWRz1Un8M5JrvmxT/d6dBSh7O7+c+dqbxEmaRAYIZNrblZvsV
   Hois9aeCr422V5WYPkeKF6S6YtXRDfw3ttBwDqiBGPjqzgJdNaIZccZcu
   /Npez2Mn2dkPQIW3iQimFTEWB7QtMrTBqWX7VWUQ2SHoaMCfPRcUHI2OJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="202293828"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:54:06 +0800
IronPort-SDR: f83yWlCHrlpuhIuAumtuadN4yd26id6r8i+NbG9SGVFWzKC17MD+PEr+QbiAO/yV/KMxm7VKeR
 sfc26xFoYHD6Ap4KHAYVwmvHvB4qqph6VaAeOM5woBNgzwGSxBq7jQYxbgnNezdawb9ErnxxpM
 V7VRhF2QLRMWl7e9jsV0vPUbN2f12pNPp3IUrp6A3d3mwVdXatoY/3L+pWRSEat9Vrwn+yhs0b
 V+OMx1F6FYQ70K5LBwR2QWPvV8JG2031KN1m7Cfm9W/K0QbiXiI1Eg27QLBSh1kTpHabf5jnup
 u/Q+yxzuT+pSnoWYHRyRN4Pd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:18:01 -0700
IronPort-SDR: Jr/Na5RLSLUmLPJrrIiHrjzoEXkR28Vkawz8IDIhGn3Dp3fzUUE4dPm7Cucz27BvS1fS+Q4e9J
 WFhmsTPjWMEbZfHvHNThkhlD2JD7MlP1WV5pkmFLvPYNbnZaZYQE2SGwmbugev/VU4qgt4yXU+
 arDZE1vA/6vYKZPCqodLL3JNw6SfRv4HBBQ4kveulpFMS2EzBhHBQYuUyeOkv5eF6+V3cGbw/7
 aQ5E48nA1SZtvhaVM04uc7uSBq/YMYVUR+QI3yf3BlNCPNxIb6cA3luWYHgy79SbfEwNPpLSAK
 dbM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:54:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rZk0B9Lz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:54:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530045; x=1656122046; bh=Qa0mv9ufLHh489tJlVzb/NGzKYn3PLjyhz6
        ZhYOeDvk=; b=EfbjCeRfnLgZRanafvHmXWqoSMC+CvaDJ8Pxpi29vgYK9HczVKa
        kr/yRyZvHNMnIBlGjytf1co0WtjvSn5udcsTwgm2k67E5sQL0kewftemJRaj//E4
        aqT2zvgySklufGUteq3UN3IKwElxlYVJRG1A+S/U02oomjYaJ9DrNsNcFFlua/7P
        8rr134tcWxAY82Fx7ue+Ik84rJNmmZnq7AYSoCGa3pFNKtVL/Sz/JUuI2afN2c+k
        ggSH6hYUyOucA5bCM0uQ0oJfFsLCIAZT/RM0MHTKr6lpOjnoOwhueiEkIHkZ1cWt
        HDn93ofzC8vSRdJ4TTvz451J0y1R2hMgjYQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yZynVifyyQ7h for <linux-fsdevel@vger.kernel.org>;
        Wed, 25 May 2022 18:54:05 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rZg4Fr8z1Rvlc;
        Wed, 25 May 2022 18:54:03 -0700 (PDT)
Message-ID: <fb8bd4ec-10bf-3a8a-dbb9-cdd4aeec7ebe@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:54:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 5/9] block: add a helper function for dio alignment
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-6-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-6-kbusch@fb.com>
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
> This will make it easier to add more complex acceptable alignment
> criteria in the future.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/fops.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index b9b83030e0df..bd6c2e13a4e3 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -42,6 +42,16 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
>  	return op;
>  }
>  
> +static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	if ((pos | iov_iter_alignment(iter)) &
> +	    (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +
> +	return 0;
> +}

Nit: The name of this helper really suggest a bool return, which would be a more
flexible interface I think:

	if (!blkdev_dio_aligned(bdev, pos, iter))
		return -EINVAL; <-- or whatever error code the caller wants.

And that will allow you to get rid of the ret variable in a least
__blkdev_direct_IO_async.

> +
>  #define DIO_INLINE_BIO_VECS 4
>  
>  static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
> @@ -54,9 +64,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	struct bio bio;
>  	ssize_t ret;
>  
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> -		return -EINVAL;
> +	ret = blkdev_dio_aligned(bdev, pos, iter);
> +	if (ret)
> +		return ret;
>  
>  	if (nr_pages <= DIO_INLINE_BIO_VECS)
>  		vecs = inline_vecs;
> @@ -171,11 +181,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>  	unsigned int opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
>  	loff_t pos = iocb->ki_pos;
> -	int ret = 0;
> +	int ret;
>  
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> -		return -EINVAL;
> +	ret = blkdev_dio_aligned(bdev, pos, iter);
> +	if (ret)
> +		return ret;
>  
>  	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
>  		opf |= REQ_ALLOC_CACHE;
> @@ -296,11 +306,11 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  	struct blkdev_dio *dio;
>  	struct bio *bio;
>  	loff_t pos = iocb->ki_pos;
> -	int ret = 0;
> +	int ret;
>  
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> -		return -EINVAL;
> +	ret = blkdev_dio_aligned(bdev, pos, iter);
> +	if (ret)
> +		return ret;
>  
>  	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
>  		opf |= REQ_ALLOC_CACHE;


-- 
Damien Le Moal
Western Digital Research
