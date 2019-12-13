Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591B211EC05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLMUrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 15:47:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40881 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMUrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:47:39 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so992219iop.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6sB8y2iaNHCxNWX2heldJxu0UPqZdo++w30Yr9hAFf8=;
        b=ZHnQ8l1+CLl9GeJBhbz+xV21W7J0kQjB5/9uQjhe/OvyD8lBuZ1CNOzFMfo2nOB2Bc
         VEXVZA8Y+KHPRJyKE1r68eqEw1x322Src1DB5H2EAnwkNCrz9m1XsgviniW9jWnlEGoX
         j1nIwVrTqt4XaIMNZRjr4Rukbd4I01XB/19uSWfvvyJqk7f1KAi5EzGXMMmw5mr86eAn
         4GDaEjfj8+Lh23ArwqQ4XscnpU9uVyiYywAjJ6sVDNIhegAkvzf29fhYkxsPP/Ss7xGE
         GbBCKhgyY0RPAr4z9OWbvPS+6fIVg+OE7CTBMCunyTWegGnwnChoK2r1G5we5/H/8UZ5
         pdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sB8y2iaNHCxNWX2heldJxu0UPqZdo++w30Yr9hAFf8=;
        b=liCtga3230HEw6K8jBuWfPWpkEmFJRtduBmCJa2MQrkjiyiNzP74+lfheSx/6LInCy
         95lGehWBJTk5NkO2kOJhUOdKxzMWt7hwn3vCAdHSXBnV6hdnPA3kVb/RMzWDsBgQFaaU
         CJfXIfErjFhaCI0tn9sm5Hs3RGJnLe0xtVMCikQ1ZBfzZ9zpXv3aoFAVX49/u1X9/HtY
         6SROuuvWBYUQJAYf+kqorPUbBm8phD9sIBKGDaUzz/UiCAvTHvAP+KPZEAzG/HpNgV+F
         8ATuPXlbIg8rsKs4VnmZjZRdjnTb7iV/2wX8fm28QbSGKxih1aCjVlAeLZemESOwThgU
         5X0A==
X-Gm-Message-State: APjAAAWF5EALFDzjqPtoDYtPjT7MGFiZy7SOwHtYO4UADPpfz84sWkJW
        z0t2uXQwT66gmjok3X4TjnJE1w==
X-Google-Smtp-Source: APXvYqxtZDedWPUq8ULNgcbZ/UKPCJ/p44H78xxlx+Vcyu3li8+yxy6GUJEv149yD89bTP48e+HSkw==
X-Received: by 2002:a02:3e83:: with SMTP id s125mr1335024jas.104.1576270057981;
        Fri, 13 Dec 2019 12:47:37 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n3sm3093281ilm.74.2019.12.13.12.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 12:47:37 -0800 (PST)
Subject: Re: [PATCH 4/5] iomap: add struct iomap_data
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191212190133.18473-1-axboe@kernel.dk>
 <20191212190133.18473-5-axboe@kernel.dk> <20191213203242.GB99868@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90f26792-3751-c755-c0b9-a85b816e5340@kernel.dk>
Date:   Fri, 13 Dec 2019 13:47:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213203242.GB99868@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/19 1:32 PM, Darrick J. Wong wrote:
> On Thu, Dec 12, 2019 at 12:01:32PM -0700, Jens Axboe wrote:
>> We pass a lot of arguments to iomap_apply(), and subsequently to the
>> actors that it calls. In preparation for adding one more argument,
>> switch them to using a struct iomap_data instead. The actor gets a const
>> version of that, they are not supposed to change anything in it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Looks good, only a couple of questions...

Thanks!

>>  fs/dax.c               |  25 +++--
>>  fs/iomap/apply.c       |  26 +++---
>>  fs/iomap/buffered-io.c | 202 +++++++++++++++++++++++++----------------
>>  fs/iomap/direct-io.c   |  57 +++++++-----
>>  fs/iomap/fiemap.c      |  48 ++++++----
>>  fs/iomap/seek.c        |  64 ++++++++-----
>>  fs/iomap/swapfile.c    |  27 +++---
>>  include/linux/iomap.h  |  15 ++-
>>  8 files changed, 278 insertions(+), 186 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 1f1f0201cad1..d1c32dbbdf24 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1090,13 +1090,16 @@ int __dax_zero_page_range(struct block_device *bdev,
>>  EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>>  
>>  static loff_t
>> -dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>> -		struct iomap *iomap, struct iomap *srcmap)
>> +dax_iomap_actor(const struct iomap_data *data, struct iomap *iomap,
> 
> I wonder, is 'struct iomap_ctx' a better name for the context structure?

Yeah I think you are right, does seem like a better fit. I'll rename it
for the next version.

>> @@ -43,17 +44,18 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>>  	 * expose transient stale data. If the reserve fails, we can safely
>>  	 * back out at this point as there is nothing to undo.
>>  	 */
>> -	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>> +	ret = ops->iomap_begin(data->inode, data->pos, data->len, data->flags,
>> +				&iomap, &srcmap);
> 
> ...and second, what do people think about about passing "const struct
> iomap_ctx *ctx" to iomap_begin and iomap_end to reduce the argument
> counts there too?
> 
> (That's definitely a separate patch though, and I might just do that on
> my own if nobody beats me to it...)

To be honest, I just did what I needed, but I do think it's worth
pursuing in general. The argument clutter is real.

-- 
Jens Axboe

