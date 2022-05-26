Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94B53488E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 04:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiEZCDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 22:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiEZCDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 22:03:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A7DFF1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530586; x=1685066586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zcrg/QhV5GW8SoEcaw+X6440aJiiM0leZ6G0NBDddhI=;
  b=TsqOtm5CdGYEsMYzWMLfZ6jAa5f+RFtreobVBhcOGnClvjkvYgTPwxa5
   i/G2RBZFAJ5xIXNbrI1cEkXR6GOBq1qYVKweAgQubJPGzdW1+xh2nLREU
   9QdlpwF0QqRFlxHV1M5F0vYdO1AFwaVoV9LqjzbIlkMToZXxOUoIam8lg
   bMK6sIJ+EC4G7Ko7K/zGiYED8Gbkl6bC7EWX7k537iUsCQoRVmxyYCRG7
   iPWqPIMzfHWNEYaFdcb4S/HtP3D48dxIL9fhmoIS2tM85EQ3uCjkZLJOF
   vgkFOZZWjspJ2skr+Uk30LzFdYQ7fpG8UPmbapU27ojdRA2l0AbPvf5it
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="313462942"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 10:03:04 +0800
IronPort-SDR: +Lsokgk5SrmVSmEeAUdI8efOC2itb5rFtipRn9TLtE2egXGxAXorpMzSFsHXcdprn7wUbMueZ5
 5BNRCL6LW8WD+rcl36Li3PTsLRdi1YhmRW8BKeFN2/4j43iF6pJvx6L4z24B37F9K1UCVRXiXy
 4eEz2/FH0PHpNCOXrRwqNUvMb/i+QNh7JAikvMfOPkYdSiV1STSV//2Fm8E+toRu8IJngw2mvo
 upx3vKegOFOCLZn/rcGL98L09MOR1gkY9cQZrarPKOKDw/UcSHO5T3pce7YrR5CPfk+tuBjGwv
 EICWXBsazq7RnAMlLGBWfBiq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:27:00 -0700
IronPort-SDR: l0sjCoFNjpSKsA9tvgRP4IJVGwMil6kA1ybjWCnZCeA0xitk7uUYm5041XNwxvBE04gQdrnnvq
 dIHpn+C6IOMuN2yVDKBLryx2qsUBTB+4uLCppDNNOO+on0OKZm3Nd3b0u7m6vN29XN2gb4WO+3
 9+7dVGcuNdbueuCbRc3iVz3xgJvQxMkQtS7qmcfm2T9eMuKvi+iYs7nnzv+eEX8/xKvkvsCM2D
 3/frl6/mWWRARJh20xk6dKhzclGlih2ufx6ym8icXAzlEcrRweB86UELGe8RpbV4WT9/lMidm6
 s7U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 19:03:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rn42gx7z1SVp4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:03:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530583; x=1656122584; bh=Zcrg/QhV5GW8SoEcaw+X6440aJiiM0leZ6G
        0NBDddhI=; b=XLL7pmh8/fzwXFBjpVYDWfjYs8ApJEc6Ei6BlgSCYj93Tv1qTtV
        /wK6E45IuRPZZgeVSH5FJNdB1VY0y4Fev1TLjAFOLB4dbcc12UWjJayS7sx01ZbD
        sHkkqYZ+VGGBTidPm8CytvRor5MCiFLRq58Vqm5omNW/IkRlk9DbQfK63B++BFzQ
        0YMQLanH4V4sW6BWTQlgIHxl+WZS/fQrNnimGVVl4OavccBzF/4s7ImD6Wtp4e0K
        Pe3UZbhVOthfxKVE+CiODlVO+7ZXnY8v/BJHDR9lAb/wnj/+ZTLZJkp2YCxfZwjG
        4Re9Gzy8gFjSX1acfYMRyknrnRTyXmox/jA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EjF9hh1gXkDE for <linux-fsdevel@vger.kernel.org>;
        Wed, 25 May 2022 19:03:03 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rn15vhWz1Rvlc;
        Wed, 25 May 2022 19:03:01 -0700 (PDT)
Message-ID: <732d8a92-bd4a-bc0e-f33c-1485a71e4084@opensource.wdc.com>
Date:   Thu, 26 May 2022 11:03:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-9-kbusch@fb.com>
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
> Use the address alignment requirements from the hardware for direct io
> instead of requiring addresses be aligned to the block size. User space
> can discover the alignment requirements from the dma_alignment queue
> attribute.
> 
> User space can specify any hardware compatible DMA offset for each
> segment, but every segment length is still required to be a multiple of
> the block size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c  | 12 ++++++++++++
>  block/fops.c | 14 +++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 55d2a9c4e312..c492881959d1 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1219,7 +1219,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> +	/*
> +	 * Each segment in the iov is required to be a block size multiple.
> +	 * However, we may not be able to get the entire segment if it spans
> +	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
> +	 * result to ensure the bio's total size is correct. The remainder of
> +	 * the iov data will be picked up in the next bio iteration.
> +	 *
> +	 * If the result is ever 0, that indicates the iov fails the segment
> +	 * size requirement and is an error.
> +	 */
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	if (size > 0)
> +		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  
> diff --git a/block/fops.c b/block/fops.c
> index bd6c2e13a4e3..6ecbccc552b9 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -45,10 +45,10 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
>  static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
>  			      struct iov_iter *iter)
>  {
> -	if ((pos | iov_iter_alignment(iter)) &
> -	    (bdev_logical_block_size(bdev) - 1))
> +	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> +		return -EINVAL;
> +	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
>  		return -EINVAL;
> -
>  	return 0;
>  }
>  
> @@ -88,6 +88,10 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	bio.bi_ioprio = iocb->ki_ioprio;
>  
>  	ret = bio_iov_iter_get_pages(&bio, iter);
> +
> +	/* check if iov is not aligned */
> +	if (unlikely(!ret && iov_iter_count(iter)))
> +		ret = -EINVAL;
>  	if (unlikely(ret))
>  		goto out;
>  	ret = bio.bi_iter.bi_size;
> @@ -333,6 +337,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  		bio_iov_bvec_set(bio, iter);
>  	} else {
>  		ret = bio_iov_iter_get_pages(bio, iter);
> +
> +		/* check if iov is not aligned */
> +		if (unlikely(!ret && iov_iter_count(iter)))
> +			ret = -EINVAL;
>  		if (unlikely(ret)) {
>  			bio_put(bio);
>  			return ret;

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
