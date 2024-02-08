Return-Path: <linux-fsdevel+bounces-10861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABD84EBCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15901C23DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E150254;
	Thu,  8 Feb 2024 22:41:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB144F5E5;
	Thu,  8 Feb 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432109; cv=none; b=e+QWq7rATGfutxCDyUHNXpQtx1o1RPvg7iyJMMUbeIv1pjbm2dSHnhOubLbEIkbxGfq1TR60oabh4ppQIZAH7ZLONNOfPqWQY9QDDea5tywGYb1fDWjItGuFF06hSR5uH5VRsFe4QGg7wbvckerm/hlqSrXYuuToptg5rL3mXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432109; c=relaxed/simple;
	bh=yCMKOQSRFlL36xIo+5kp+jQ/KjqiZ4BaQ18NTi5JwCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaVabe3gaB8nko3qX+T/qvPUG/kNl0x+fWvgvwbSWqySCt0woeiogthYtJGf7qj/pYQtKJTyJcyC+oQJKy8pk1Vn0H/t+inrpYDSULtLWpWdil/kW5joco0shEs22MO1veWfMXlhn66XVKvD8kaSQA81GhpXyyrpIYxKcqcbuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de3141f041so319716b3a.0;
        Thu, 08 Feb 2024 14:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432107; x=1708036907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1ZBXx3BlTXQZLrP3fmMsvzAZiR/YPMJrytP2Jg1d6I=;
        b=B9Lqcu4R3pTax7Cs3Yo7TYryIwMVxoD9L98zxNnu8K5nbWoQ45GcU/0e/9acFehO2G
         qu50gCRGxNx+WKNFhflMtqRjyk29m7J/Hw6A/O8wEY3P84K2+iRLa01GldCk+L356ajU
         pNkh1HH9HLu9OMoqdLiLasck6ooZRsOOcCQBa5PReKJCg9z4Gri6dakzwm7B73rC+sZC
         T5eHMhpIX5rDrWkGdPBWIEMg2UNTdLcnZMyE1xlRMeOzgvrg0jETtvDus4o03vvkVsNX
         oiEh+OEyI2K6Ze+m4FfdE8VEgtT9ZN9qxA8f7lv+Tros9lUr0GJcWG0RRxAWavssezHX
         xbvQ==
X-Gm-Message-State: AOJu0Yw+inKKI6iUU5kjdW6iUZVkyrc9Adtv03h63WdxMeIQFy5WeN9l
	0SAB1iXZq+XVHnOjkOZOpkmGth8w/3tzKiv4AkG+ZGZ0F2F0ttSg
X-Google-Smtp-Source: AGHT+IFuIOY4GK2WuU/2ZyivEXTfWq9rMMh9NLAC0r48cNsqwfbbwo9VAVRlGMIgz00R1ADE8Gskcw==
X-Received: by 2002:a05:6a20:a085:b0:19e:989e:1993 with SMTP id r5-20020a056a20a08500b0019e989e1993mr867256pzj.29.1707432106750;
        Thu, 08 Feb 2024 14:41:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzrosB9i00AxQ8wnGjhbMSxgofJX13Gbrv+UhIAxJA06DeSX6wbjGNA8R5ynYlRPs18QeqgYu2SxBLif0TVpLm0U23+zCr9nzjQBjTN/afvFNOjkMQk78/Zh1CxyixNyDE/MTfD3BUoeZ40o2Kb8p8X0D1n7w6Qqj/RfnGviP/eqTI7eN2irwgSK9kixtHMSnbqvkToGdqec1mXpjjNu2jBNQXCf+VWi4o7xD3up/izW0OZIoqYkZ62ekUGK06M3cD
Received: from ?IPV6:2620:0:1000:8411:9d77:6767:98c9:caf2? ([2620:0:1000:8411:9d77:6767:98c9:caf2])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006e07f1829b0sm272276pfb.219.2024.02.08.14.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 14:41:45 -0800 (PST)
Message-ID: <e71501ce-6fb9-42bc-89aa-fcf5d0384c9b@acm.org>
Date: Thu, 8 Feb 2024 14:41:43 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 14:14, Jens Axboe wrote:
> On 2/8/24 2:55 PM, Bart Van Assche wrote:
>> -static int ffs_aio_cancel(struct kiocb *kiocb)
>> +static void ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
>>   {
>>   	struct ffs_io_data *io_data = kiocb->private;
>>   	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
>>   	unsigned long flags;
>> -	int value;
>>   
>>   	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
>> -
>>   	if (io_data && io_data->ep && io_data->req)
>> -		value = usb_ep_dequeue(io_data->ep, io_data->req);
>> -	else
>> -		value = -EINVAL;
>> -
>> +		usb_ep_dequeue(io_data->ep, io_data->req);
>>   	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
>> -
>> -	return value;
>>   }
> 
> I'm assuming the NULL checks can go because it's just the async parts
> now?

Probably. I will look into this.

>> +static void aio_cancel_and_del(struct aio_kiocb *req);
>> +
> 
> Just move the function higher up? It doesn't have any dependencies.

aio_cancel_and_del() calls aio_poll_cancel(). aio_poll_cancel() calls
poll_iocb_lock_wq(). poll_iocb_lock_wq() is defined below the first call of
aio_cancel_and_del(). It's probably possible to get rid of that function
declaration but a nontrivial amount of code would have to be moved.

>> @@ -1552,6 +1538,24 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
>>   	return __import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter, compat);
>>   }
>>   
>> +static void aio_add_rw_to_active_reqs(struct kiocb *req)
>> +{
>> +	struct aio_kiocb *aio = container_of(req, struct aio_kiocb, rw);
>> +	struct kioctx *ctx = aio->ki_ctx;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * If the .cancel_kiocb() callback has been set, add the request
>> +	 * to the list of active requests.
>> +	 */
>> +	if (!req->ki_filp->f_op->cancel_kiocb)
>> +		return;
>> +
>> +	spin_lock_irqsave(&ctx->ctx_lock, flags);
>> +	list_add_tail(&aio->ki_list, &ctx->active_reqs);
>> +	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
>> +}
> 
> This can use spin_lock_irq(), always called from process context.

I will make this change.

>> +{
>> +	void (*cancel_kiocb)(struct kiocb *) =
>> +		req->rw.ki_filp->f_op->cancel_kiocb;
>> +	struct kioctx *ctx = req->ki_ctx;
>> +
>> +	lockdep_assert_held(&ctx->ctx_lock);
>> +
>> +	switch (req->ki_opcode) {
>> +	case IOCB_CMD_PREAD:
>> +	case IOCB_CMD_PWRITE:
>> +	case IOCB_CMD_PREADV:
>> +	case IOCB_CMD_PWRITEV:
>> +		if (cancel_kiocb)
>> +			cancel_kiocb(&req->rw);
>> +		break;
>> +	case IOCB_CMD_FSYNC:
>> +	case IOCB_CMD_FDSYNC:
>> +		break;
>> +	case IOCB_CMD_POLL:
>> +		aio_poll_cancel(req);
>> +		break;
>> +	default:
>> +		WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
>> +	}
>> +
>> +	list_del_init(&req->ki_list);
>> +}
> 
> Why don't you just keep ki_cancel() and just change it to a void return
> that takes an aio_kiocb? Then you don't need this odd switch, or adding
> an opcode field just for this. That seems cleaner.

Keeping .ki_cancel() means that it must be set before I/O starts and only
if the I/O is submitted by libaio. That would require an approach to
recognize whether or not a struct kiocb is embedded in struct aio_kiocb,
e.g. the patch that you posted as a reply on version one of this patch.
Does anyone else want to comment on this?

Thanks,

Bart.

