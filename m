Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F33206A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBTSaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 13:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBTSaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:30:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F3C061786
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 10:29:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so5180035plg.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lD1HcC1ElSe3/B3EukUgF8uLAM755FrCoJcF7E1w+VI=;
        b=OerchFwb+SiCsbkWSYvotE2x7oT7AA/otmhLaADzu8OSe8CjWrpFJGFHSC1ibVH543
         uzLtl1jvaoGW7UNZyHgVtpCS56yHv2wG9i9egultmIEIemmRxJcZhuFiennkEDUGL4gH
         HK0ScbpeX6AUM1hFtHEHFWc4CfI+ueLDiJGF+lNNwtii8xzqj7L9zqc0PSxSqY4ZuC6N
         uVBjG2VPfFGEo8Qo7R23saPe1d6V1ZN6ItUbpq9ntQRvglTpVN2S1CjOP4kx9Le5meN6
         cqpRBTLAENvOvggfgQBAH4Ui5IBzOwIFJtHQ0I2EolBXa68HTOz5HLK8Jm68b1VkplkS
         Sn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lD1HcC1ElSe3/B3EukUgF8uLAM755FrCoJcF7E1w+VI=;
        b=SDBQdtM88WexCu7og+1+D7J9e8lSmsaAQtiujJs5NHQpHPbIg9kcxCHyuxLqeSJqZq
         6vTwUX0PufbFNvcy1VTEPFW0yMLMkuO9vmQYieBq9w+BUex1fXcsXPEWMXJRbSKAUReZ
         pmVjKH9HG/m6lDPcecEr2uZTfFqK3s11unAUH4NluU4iCGGi+nbdOCy3tboZNxXLnJAq
         r/APIm0zUhbT1ZGGERgVAeRmwGbSwM/fS8tBPgVCotkOU656deBXFhQ4nVsY02BJjHMC
         PYud+FiO3etpfZizu0C3hCZQ2FjSlGPOzHwTduZp4XpfiScgspfyzfhA7qCVp9Dz5KQ+
         mqQg==
X-Gm-Message-State: AOAM533ivX1Rx54ubwJk0ovA9Dajw9Z9NTh1Si66cKTQ58hIR/eccQF6
        naEsyNzk54HJ4jKbsdPgkn6iiQ==
X-Google-Smtp-Source: ABdhPJwVnim2uCKbKCJk6JPDLfV4tc8Tq9A6zl04OR+pwO7ToZva6g5nMf4BHjY+pXDSgXMAjQGECQ==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr14537620pjb.24.1613845764688;
        Sat, 20 Feb 2021 10:29:24 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gk17sm12425342pjb.4.2021.02.20.10.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 10:29:24 -0800 (PST)
Subject: Re: [PATCH v3 0/2] io_uring: add support for IORING_OP_GETDENTS
To:     David Laight <David.Laight@ACULAB.COM>,
        'Lennert Buytenhek' <buytenh@wantstofly.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>
References: <20210218122640.GA334506@wantstofly.org>
 <247d154f2ba549b88a77daf29ec1791f@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <28a71bb1-0aac-c166-ade7-93665811d441@kernel.dk>
Date:   Sat, 20 Feb 2021 11:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <247d154f2ba549b88a77daf29ec1791f@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/20/21 10:44 AM, David Laight wrote:
> From: Lennert Buytenhek
>> Sent: 18 February 2021 12:27
>>
>> These patches add support for IORING_OP_GETDENTS, which is a new io_uring
>> opcode that more or less does an lseek(sqe->fd, sqe->off, SEEK_SET)
>> followed by a getdents64(sqe->fd, (void *)sqe->addr, sqe->len).
>>
>> A dumb test program for IORING_OP_GETDENTS is available here:
>>
>> 	https://krautbox.wantstofly.org/~buytenh/uringfind-v2.c
>>
>> This test program does something along the lines of what find(1) does:
>> it scans recursively through a directory tree and prints the names of
>> all directories and files it encounters along the way -- but then using
>> io_uring.  (The io_uring version prints the names of encountered files and
>> directories in an order that's determined by SQE completion order, which
>> is somewhat nondeterministic and likely to differ between runs.)
>>
>> On a directory tree with 14-odd million files in it that's on a
>> six-drive (spinning disk) btrfs raid, find(1) takes:
>>
>> 	# echo 3 > /proc/sys/vm/drop_caches
>> 	# time find /mnt/repo > /dev/null
>>
>> 	real    24m7.815s
>> 	user    0m15.015s
>> 	sys     0m48.340s
>> 	#
>>
>> And the io_uring version takes:
>>
>> 	# echo 3 > /proc/sys/vm/drop_caches
>> 	# time ./uringfind /mnt/repo > /dev/null
>>
>> 	real    10m29.064s
>> 	user    0m4.347s
>> 	sys     0m1.677s
>> 	#
> 
> While there may be uses for IORING_OP_GETDENTS are you sure your
> test is comparing like with like?
> The underlying work has to be done in either case, so you are
> swapping system calls for code complexity.

What complexity?

> I suspect that find is actually doing a stat() call on every
> directory entry and that your io_uring example is just believing
> the 'directory' flag returned in the directory entry for most
> modern filesystems.

While that may be true (find doing stat as well), the runtime is
clearly dominated by IO. Adding a stat on top would be an extra
copy, but no extra IO.

> If you write a program that does openat(), readdir(), close()
> for each directory and with a long enough buffer (mostly) do
> one readdir() per directory you'll get a much better comparison.
> 
> You could even write a program with 2 threads, one does all the
> open/readdir/close system calls and the other does the printing
> and generating the list of directories to process.
> That should get the equivalent overlapping that io_uring gives
> without much of the complexity.

But this is what take the most offense to - it's _trivial_ to
write that program with io_uring, especially compared to managing
threads. Threads are certainly a more known paradigm at this point,
but an io_uring submit + reap loop is definitely not "much of the
complexity". If you're referring to the kernel change itself, that's
trivial, as the diffstat shows.

-- 
Jens Axboe

