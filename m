Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB57511D177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfLLPwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 10:52:08 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36825 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbfLLPwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:52:08 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so2447197iln.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0rzD69sAvpYoYAXwifXkGJ/c3BEX7oHaXNnSu/7R1A=;
        b=SzI1DOGvsgQG/a8ar2Ti7v2aUdaaiCFJizyPBOlaQbK9xD7GDmASaAQWVmpK/PrJFH
         feNXUM8rq1SIkXPCAT3IdmpYkcCHLjZskV2782eYG/I+CAlzZRWzyAKaxSQivhOL22rx
         7TZY0ZwUivRozG48Xlnr1wKrP7wG5Fs9XrK1HM8yGvl2GX/ZcaIxFRgpGvJlo8QFa4Cx
         suElgOqZ7TUVlqGi7Sho7DskEt+8FWde9DkAZprvCODsA4rbSLFXhK9wSGJKw11FAP0g
         JbJMcIRGbqw/iezIhnauvM9V7jaDbpY7HX+dBxn9TMBnNe0ohevkevPACyP75fUBBlUF
         cJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0rzD69sAvpYoYAXwifXkGJ/c3BEX7oHaXNnSu/7R1A=;
        b=V+/DylpjVQenGeaIUQAJ40eWcf2QUAFZdmng0RdsmEKvtXJ0GJH0MyReewWdfRCGJq
         u3AqkOQtVl+II7vf3egCMbUz/pRLrnuw7rSmxZk3g/iNfowvbIc+mnpz3e0l87XvSZJP
         93dZQ5DTdSlVM06C4SR0qsT3qTaoeml4A+buW8GlSd9dnG+WL1KBjQ9H0dYH+gtfplT7
         VTrvgY4g3bsKCTNMpwBFiecxiuTByDVWLLwP2A9de4guaX5mh0Las7eAyg7dGW5RVziK
         7C02XKUXGddKIKZAoF+rbrWjc+thAW9RRrpb2+W+yyIhBCLV8t74VN7jGBRmo1Xs5cA+
         C6Lw==
X-Gm-Message-State: APjAAAWJhFhbUhmy7XP7TCtSEzfNtGPsvQFtYqwjKR6a2ObxVySXP6Qk
        OEB73WBEI1QgvF0zJIwhZUO08Q==
X-Google-Smtp-Source: APXvYqxS2dkp/Ovx5CvFCzb8EkwUApe8FaaO0vOhCgPE2dsCgSj49pRSoy3unKMrBzXFDk9H/Q4mAQ==
X-Received: by 2002:a92:5c4a:: with SMTP id q71mr9001087ilb.266.1576165926938;
        Thu, 12 Dec 2019 07:52:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u10sm1818820ilb.8.2019.12.12.07.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:52:06 -0800 (PST)
Subject: Re: [PATCHSET 0/5] Support for RWF_UNCACHED
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191212154752.GA3936@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <941edff1-76fb-41f8-cb81-15ea0970e949@kernel.dk>
Date:   Thu, 12 Dec 2019 08:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212154752.GA3936@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 8:47 AM, Christoph Hellwig wrote:
> On Tue, Dec 10, 2019 at 09:24:49AM -0700, Jens Axboe wrote:
>> Seems to me that we have an opportunity to provide something that sits
>> somewhere in between buffered and O_DIRECT, and this is where
>> RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
>> following behavior:
>>
>> - If the data is in cache, it remains in cache and the copy (in or out)
>>   is served to/from that.
>>
>> - If the data is NOT in cache, we add it while performing the IO. When
>>   the IO is done, we remove it again.
>>
>> With this, I can do 100% smooth buffered reads or writes without pushing
>> the kernel to the state where kswapd is sweating bullets. In fact it
>> doesn't even register.
>>
>> Comments appreciated! Patches are against current git (ish), and can
>> also be found here:
> 
> I can't say I particularly like the model, as it still has all the
> page cache overhead.  Direct I/O with bounce buffers for unaligned I/O
> sounds simpler and faster to me.

The current patchset read side does not, hopefully the same can be done
on the write side. No page cache usage for reads, because it did indeed
turn out to have too much overhead.

-- 
Jens Axboe

