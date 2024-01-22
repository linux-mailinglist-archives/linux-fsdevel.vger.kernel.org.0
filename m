Return-Path: <linux-fsdevel+bounces-8474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B983737D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FDC1F2BC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7840BFC;
	Mon, 22 Jan 2024 20:05:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F93FE44;
	Mon, 22 Jan 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953935; cv=none; b=TQQQbhSnlzC8Qxu4Ho6OUOFHAoiT5/o2QXm3lblXh5iPTccIb0FaHGAikNAK3RadzQ6TZnSE0Y3x+OOOadKQ6UUridiPPj3hTLZZXigYfYn3aVKjunCdbtvQvnItxBOSQsESm57M8IoyWwx5BQhDIejUOfAwaeHnIOFqmxK+/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953935; c=relaxed/simple;
	bh=KMfU13pO7wk9k2zkFFATZWe6HE92w9S7kkDhkNwNj54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjqzztfcUawwzpMGcWTeqaQWOZ9kaJ8J9eNjNJ9jyrFYAbBaFTitg2YN+aKjkJq+yLympfVi9Iw/bbj2IrqNVwdcQmtqUPuoV9L+KY69ZgUfhpTB700SEMYkE70qvT7cljd+tL4ATKr8tejCg6DDtEmOzjGA/sNm2vv4eji1ilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dc1f02090fso289505b3a.0;
        Mon, 22 Jan 2024 12:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705953934; x=1706558734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cr8LQYTS4LuxX0VHDB0eUkP92CbPkoPBe/FNUquwuo=;
        b=FHW3Gwo0meqGrS6U/25lKmmhufVoZkSMDNLO8d5PebK2K6aOjDFF49+ECvhfX7iJ1v
         t2719Owc+nc8owFNiENSiTbo0Hz4z91v4mfKyh5a+wbZrq6xiVJRGVwjs1IGWQnj1bgN
         rNBQlKK+YhVgJh0JRLPvdtrFQgJ3GkbLoSaRfeoX6ajPdNPJ/xqugFYl4Tv8SdzYbsy1
         GuOpXr8hF3J5ADmZEqccBreuwOMX6REg3MTXWhZivp6XxQUQj3R6zU5+Cnd5Jps4JH+r
         xZP6jis1GOHViV8JF+qLrPReO2dYdqOqYlzMclmgzOviedf0wc4ztiB/QRVs2KYb1HHN
         8amw==
X-Gm-Message-State: AOJu0YyBDySozoDFCP13vlJZUOB1D788QagKTNIEJ0f+WxDrecwgJWWC
	Jri4330ydef3mT4cW3yQ+KfnHBlncvQmpN5SVXsl65/LPkWTEYoa
X-Google-Smtp-Source: AGHT+IHRZRBlwmWgNMZkoqfrroa/veYvawWaRVXjvClre7ZjcoKSdytGOqY+fiSJXTyRqSGOKx/X8w==
X-Received: by 2002:a05:6a20:d90f:b0:19a:6d4c:a71c with SMTP id jd15-20020a056a20d90f00b0019a6d4ca71cmr5574107pzb.37.1705953933652;
        Mon, 22 Jan 2024 12:05:33 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id k4-20020aa78204000000b006d0a29ad0aasm9987906pfi.5.2024.01.22.12.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:05:32 -0800 (PST)
Message-ID: <bbaf780c-2807-44df-93b4-f3c9f6c43fad@acm.org>
Date: Mon, 22 Jan 2024 12:05:30 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <CGME20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6@epcas5p2.samsung.com>
 <20231219000815.2739120-6-bvanassche@acm.org>
 <23354a9b-dd1e-5eed-f537-6a2de9185d7a@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <23354a9b-dd1e-5eed-f537-6a2de9185d7a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 01:23, Kanchan Joshi wrote:
> On 12/19/2023 5:37 AM, Bart Van Assche wrote:
> 
>> diff --git a/block/fops.c b/block/fops.c
>> index 0abaac705daf..787ce52bc2c6 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>>    		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
>>    	}
>>    	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>> +	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>>    	bio.bi_ioprio = iocb->ki_ioprio;
>>    
>>    	ret = bio_iov_iter_get_pages(&bio, iter);
>> @@ -203,6 +204,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>    
>>    	for (;;) {
>>    		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>> +		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>>    		bio->bi_private = dio;
>>    		bio->bi_end_io = blkdev_bio_end_io;
>>    		bio->bi_ioprio = iocb->ki_ioprio;
>> @@ -321,6 +323,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>>    	dio->flags = 0;
>>    	dio->iocb = iocb;
>>    	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>> +	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
> 
> This (and two more places above) should rather be changed to:
> 
> bio.bi_write_hint = bdev_file_inode(iocb->ki_filp)->i_write_hint;
> 
> Note that at other places too (e.g., blkdev_fallocate, blkdev_mmap,
> blkdev_lseek) bdev inode is used and not file inode.

Why should this code be changed? The above code has been tested and
works fine.

Thanks,

Bart.

