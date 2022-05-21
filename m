Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714352FEE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiEUTDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiEUTDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 15:03:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A22EA3D
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 12:03:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so6433483plj.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ddca2x2VqZFDm3mzI1zmuRj3Y8AtQzGYBPXkPJUcG/c=;
        b=lEkilcaMt6aNZV2HyGp0jQCDQMkZ4huc3IFP68WArv913oERIoZck83w8iHzPwVc/2
         XoSZ4yc1pBrmEo6UgZ/QN/Q0VcezPcCXx1fv5elJicmFEFRePR/9raV+OMZHSInUEwwk
         XlM8nv1IR9ZbyiPcwKNk7T8yfAHsopGe5lbAp7vHK8vEeiuulhX0mDruU5N6uSRQ4q1n
         uk0E6peSya/53aSoCd1x28XTB406XxLt6QOk2OaTdTG85r90lcBkA0o8dDKIpAIfh6OO
         NGRAv+/omp6pFSBWb6HSg0on24InasAlkf2b+xN4cm4x8XsSYgk4AGfK88ZdVyD9moVY
         1zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ddca2x2VqZFDm3mzI1zmuRj3Y8AtQzGYBPXkPJUcG/c=;
        b=74DqRadmCsTm1U5Li/H71/JZGhLccg/cNah3LxuX9oTC7NSgWYh5Hhex0b2XoEUEK7
         JxXePs0n98+av1KdzGwNWgpKF1+j2FDK1KzIwXoGMDaD1iTXqlj8nQrvyDlKtFcZd94t
         rB1ugGKs9lrb/3tpdKGqVu3l05UOeWJ8zCvJdxUHY2UZH3vUuh5w86xrczb9RjEWUFH/
         eVl+Rz9J6hXKlUEhGlJAcdcIt5dqL6O3oEreSJCCtIIsKOGNYduwm4WUz73pjO0kdPI3
         xjLXFRSjOu6tUdGY7Yl/gK4iweFqWC3PG9KwiWC4Yk3jlUnGlefyu3H7RsAOuYWHbIUs
         6mYA==
X-Gm-Message-State: AOAM533pphfshFG+4jN+xzAxmX8X3a9J4PvctT6haTFKRdG76CJL2jGF
        QDI2DQHnF7k8UKuF5PjjYcouqkP9a9JTtA==
X-Google-Smtp-Source: ABdhPJwfVgavY74dRPUYA8FLVTBh71IMj0YUX+aU0Jcu54EVRcKd/EiNaJ3FdNVK2jnXSCP+daunRA==
X-Received: by 2002:a17:90a:a393:b0:1d0:e448:811d with SMTP id x19-20020a17090aa39300b001d0e448811dmr18342751pjp.97.1653159826941;
        Sat, 21 May 2022 12:03:46 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016173113c50sm1938946pli.92.2022.05.21.12.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 12:03:46 -0700 (PDT)
Message-ID: <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
Date:   Sat, 21 May 2022 13:03:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
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

On 5/21/22 11:48 AM, Al Viro wrote:
> [resurrecting an old thread]
> 
> On Mon, Jun 21, 2021 at 04:35:01PM +0200, Christoph Hellwig wrote:
>> On Mon, Jun 21, 2021 at 02:32:46PM +0000, Al Viro wrote:
>>> 	I'd rather have a single helper for those checks, rather than
>>> open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...
>>
>> Yes, I think something like:
>>
>> static inline bool iocb_is_sync(struct kiocb *iocb)
>> {
>> 	return (iocb->ki_flags & IOCB_DSYNC) ||
>> 		S_SYNC(iocb->ki_filp->f_mapping->host);
>> }
>>
>> should do the job.
> 
> There's a problem with that variant.  Take a look at btrfs_direct_write():
>         const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
> 	...
>         /*
> 	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
> 	 * calls generic_write_sync() (through iomap_dio_complete()), because
> 	 * that results in calling fsync (btrfs_sync_file()) which will try to
> 	 * lock the inode in exclusive/write mode.
> 	 */
> 	if (is_sync_write)
> 		iocb->ki_flags &= ~IOCB_DSYNC;
> 	...
> 
> 	/*
> 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do  
> 	 * the fsync (call generic_write_sync()).
> 	 */
> 	if (is_sync_write)
> 		iocb->ki_flags |= IOCB_DSYNC;
> 
> will run into trouble.  How about this (completely untested):
> 
> Precalculate iocb_flags()
> 
> Store the value in file->f_i_flags; calculate at open time (do_dentry_open()
> for opens, alloc_file() for pipe(2)/socket(2)/etc.), update at FCNTL_SETFL
> time.
> 
> IOCB_DSYNC is... special in that respect; replace checks for it with
> an inlined helper (iocb_is_dsync()), leave the checks of underlying fs
> mounted with -o sync and/or inode being marked sync until then.
> To avoid breaking btrfs deadlock avoidance, add an explicit "no dsync" flag
> that would suppress IOCB_DSYNC; that way btrfs_direct_write() can set it
> for the duration of work where it wants to avoid generic_write_sync()
> triggering.
> 
> That ought to reduce the overhead of new_sync_{read,write}() quite a bit.
> 
> NEEDS TESTING; NOT FOR MERGE IN THAT FORM.

Definitely generates better code here, unsurprisingly. Unfortunately it
doesn't seem to help a whole lot for a direct comparison, though it does
nudge us in the right direction.

The main issue here, using urandom and 4k reads (iter reads done,
non-iter writes), the main difference seems to be that with the non-iter
reads, here's our copy overhead:

+    1.80%  dd  [kernel.kallsyms]  [k] __arch_copy_to_user
+    0.74%  dd  [kernel.kallsyms]  [k] _copy_to_user

and with the iter variant, for the same workload, it looks like this:

+    4.13%  dd  [kernel.kallsyms]  [k] _copy_to_iter
+    0.88%  dd  [kernel.kallsyms]  [k] __arch_copy_to_user
+    0.72%  dd  [kernel.kallsyms]  [k] copyout

and about 1% just doing the iov_iter advance. Since this test case is a
single iovec read, ran a quick test where we simply use this helper:

static size_t random_copy(void *src, int size, struct iov_iter *to)
{
	const struct iovec *iov = to->iov;
	size_t to_copy = min_t(size_t, size, iov->iov_len);

	if (copy_to_user(iov->iov_base, src, to_copy))
		return 0;

	to->count -= to_copy;
	return to_copy;
}

rather than copy_to_iter(). That brings us within 0.8% of the non-iter
read performance:

non-iter:	408MB/sec
iter:		395MB/sec	-3.2%
iter+al+hack	406MB/sec	-0.8%

for 32-byte reads:

non-iter	73.1MB/sec
iter:		72.1MB/sec	-1.4%
iter+al+hack	72.5MB/sec	-0.8%

which as mentioned in my initial email is closer than the 4k, but still
sees a nice reduction in overhead.

-- 
Jens Axboe

