Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4452FFBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiEUWOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiEUWOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 18:14:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33745079
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 15:14:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w17-20020a17090a529100b001db302efed6so10528012pjh.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=z/8rB5FIqtxmcp3jhB1yi+D49jbUOOvCYqJH+Yf/SFA=;
        b=Ku41e7+1Dc3CJvqM5QD4JYfzpFWGBlw13PPdDA8S9bpz/ZALt16WO5PEZ6z4asMs4X
         TW/i0ve+c0rFSQCVSMqhfhMZJ3MQQBqDdXcPfIORprX37Pd+qvOXRYVNDgVxiIu96YWs
         xu87UXP9Ocnmh6EjMWQ0q1yY7yywbl4xeYYF/0HJScDTFisBqAGKfouPo51GK1S3J2II
         dB9ah9CeqvJtsJj6+tiMaUZpF30Pi8fNnxmOtgNF/gf2N2XuTelflNiMQGJ2AK8DWSzH
         QEjLSmAMNvE2VT50xRsnahbaVjrnampIm6+zJFCnxFHSuIIgSvekV37xXkvtBk2ncdO/
         6oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=z/8rB5FIqtxmcp3jhB1yi+D49jbUOOvCYqJH+Yf/SFA=;
        b=briZZPzWhl4TiLjzV+FEz91sL3tg0n8jfpV8YzXNo6fPxnXqRqqJ5CziR31cmx40Jm
         WOuOZwWJF/wj8yMZ1K1Gwu+18qPdk4Oq+0B6fQii20JDf/MEDTKR+t+k3dboAGd/tDOs
         iU0xNoAkLX7cLaWc29Qe6bWX4UdVeLZbBxU1HHiAtEZJ05dfdCjBsgOUmzADu/lj8lrn
         LBiAQRUQ0hsesgtleXuwnDRBAaznVRsZcN+gO90hlNPR4vbwxGoI1hd+XnYYJCjIjPkr
         xsLT6cA+YmNfNA+lsdcoXVpVBJxeicbout8Xy4h9mzgSPFOrY0Uz9bNx+kzUtiEgVL1q
         6n2A==
X-Gm-Message-State: AOAM533MKsoLVJN6wTLZqH0LgzgURo889UtFSpywkbEfH2vdwdVVCKB2
        PcOk3CcT+ACnG8s00MOqowHxpZZLJErJAw==
X-Google-Smtp-Source: ABdhPJxv2AtAFDDU4WzRln1Gml6rAtF32FNyBATc8i4s+IG9jkYQ3gKr/xajMSPoLfP/+z/gTGEIfg==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr15969465ple.19.1653171249436;
        Sat, 21 May 2022 15:14:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0015e8d4eb244sm1615428plg.142.2022.05.21.15.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 15:14:08 -0700 (PDT)
Message-ID: <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
Date:   Sat, 21 May 2022 16:14:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
In-Reply-To: <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/21/22 1:03 PM, Jens Axboe wrote:
> On 5/21/22 11:48 AM, Al Viro wrote:
>> [resurrecting an old thread]
>>
>> On Mon, Jun 21, 2021 at 04:35:01PM +0200, Christoph Hellwig wrote:
>>> On Mon, Jun 21, 2021 at 02:32:46PM +0000, Al Viro wrote:
>>>> 	I'd rather have a single helper for those checks, rather than
>>>> open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...
>>>
>>> Yes, I think something like:
>>>
>>> static inline bool iocb_is_sync(struct kiocb *iocb)
>>> {
>>> 	return (iocb->ki_flags & IOCB_DSYNC) ||
>>> 		S_SYNC(iocb->ki_filp->f_mapping->host);
>>> }
>>>
>>> should do the job.
>>
>> There's a problem with that variant.  Take a look at btrfs_direct_write():
>>         const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
>> 	...
>>         /*
>> 	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
>> 	 * calls generic_write_sync() (through iomap_dio_complete()), because
>> 	 * that results in calling fsync (btrfs_sync_file()) which will try to
>> 	 * lock the inode in exclusive/write mode.
>> 	 */
>> 	if (is_sync_write)
>> 		iocb->ki_flags &= ~IOCB_DSYNC;
>> 	...
>>
>> 	/*
>> 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do  
>> 	 * the fsync (call generic_write_sync()).
>> 	 */
>> 	if (is_sync_write)
>> 		iocb->ki_flags |= IOCB_DSYNC;
>>
>> will run into trouble.  How about this (completely untested):
>>
>> Precalculate iocb_flags()
>>
>> Store the value in file->f_i_flags; calculate at open time (do_dentry_open()
>> for opens, alloc_file() for pipe(2)/socket(2)/etc.), update at FCNTL_SETFL
>> time.
>>
>> IOCB_DSYNC is... special in that respect; replace checks for it with
>> an inlined helper (iocb_is_dsync()), leave the checks of underlying fs
>> mounted with -o sync and/or inode being marked sync until then.
>> To avoid breaking btrfs deadlock avoidance, add an explicit "no dsync" flag
>> that would suppress IOCB_DSYNC; that way btrfs_direct_write() can set it
>> for the duration of work where it wants to avoid generic_write_sync()
>> triggering.
>>
>> That ought to reduce the overhead of new_sync_{read,write}() quite a bit.
>>
>> NEEDS TESTING; NOT FOR MERGE IN THAT FORM.
> 
> Definitely generates better code here, unsurprisingly. Unfortunately it
> doesn't seem to help a whole lot for a direct comparison, though it does
> nudge us in the right direction.
> 
> The main issue here, using urandom and 4k reads (iter reads done,
> non-iter writes), the main difference seems to be that with the non-iter
> reads, here's our copy overhead:
> 
> +    1.80%  dd  [kernel.kallsyms]  [k] __arch_copy_to_user
> +    0.74%  dd  [kernel.kallsyms]  [k] _copy_to_user
> 
> and with the iter variant, for the same workload, it looks like this:
> 
> +    4.13%  dd  [kernel.kallsyms]  [k] _copy_to_iter
> +    0.88%  dd  [kernel.kallsyms]  [k] __arch_copy_to_user
> +    0.72%  dd  [kernel.kallsyms]  [k] copyout
> 
> and about 1% just doing the iov_iter advance. Since this test case is a
> single iovec read, ran a quick test where we simply use this helper:
> 
> static size_t random_copy(void *src, int size, struct iov_iter *to)
> {
> 	const struct iovec *iov = to->iov;
> 	size_t to_copy = min_t(size_t, size, iov->iov_len);
> 
> 	if (copy_to_user(iov->iov_base, src, to_copy))
> 		return 0;
> 
> 	to->count -= to_copy;
> 	return to_copy;
> }
> 
> rather than copy_to_iter(). That brings us within 0.8% of the non-iter
> read performance:
> 
> non-iter:	408MB/sec
> iter:		395MB/sec	-3.2%
> iter+al+hack	406MB/sec	-0.8%
> 
> for 32-byte reads:
> 
> non-iter	73.1MB/sec
> iter:		72.1MB/sec	-1.4%
> iter+al+hack	72.5MB/sec	-0.8%
> 
> which as mentioned in my initial email is closer than the 4k, but still
> sees a nice reduction in overhead.

Experimented a bit more - if we special case nr_segs == 1 && is_iovec in
_copy_to_iter():

_copy_to_iter()
{
...
	if (iter_is_iovec(i)) {
		might_fault();
		if (i->nr_segs == 1) {
			/* copy */
			iov_iter_advance(i, copied);
			return copied;
		}
	}
	iterate_and_advance(i, bytes, base, len, off, ...
	return bytes;
}

Then we're almost on par, and it looks like we just need to special case
iov_iter_advance() for the nr_segs == 1 as well to be on par. This is on
top of your patch as well, fwiw.

It might make sense to special case the single segment cases, for both
setup, iteration, and advancing. With that, I think we'll be where we
want to be, and there will be no discernable difference between the iter
paths and the old style paths.

-- 
Jens Axboe

