Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4824C0191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiBVSp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiBVSp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:45:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4AF1AF7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 10:45:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u5so16434728ple.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=HeUz8L5U6F1urqd7EsfxYqvd/5i63zeMc5upIKGPqZI=;
        b=v9XEdWlUXPIOPoMddgKZWBNHZbi/JdecC2wMMGFmQRNTchZoB7YKKlRrvuV+jUfWrK
         4ksI0ZDSR1ERszX9wYfae+d5cVU7p5vUBS6tGjl1/p/t6bRVZxS9s4I731VIbJdPoJQ2
         hvLRNSAtyGCb0BKH9f5Yu2jFz7KqNhrKG0Quwgq92P8cI6XMHojOCR6R8xV2v9injEqs
         2QKvVMdEqcKkySmAzgYK7qIDKOV1n2naWn+chtetg1aIOSGwnTXapvhtzUu7b4JRRR0O
         +s7qJ1RDUr+5lf8KEe4ABRSzJbF/MbcV9uXn7bOufZSHCIiHjCu49VH7f8W/SIkz7Av3
         YSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=HeUz8L5U6F1urqd7EsfxYqvd/5i63zeMc5upIKGPqZI=;
        b=Sk6xrBn+Okc0ZAee1ryCIqYQyEgPn9oCyBDOSrfHZR6uTcllJiLYVS24C3MMrc5wvL
         HfJe+N2mmmLX9vwcr/hdtnrdxaulhpr8IAoafOV5VpT9l09LYZXkN3y288Q5j/A8dUlQ
         Tw9VKwjxSrL/aAOnf6JTdxKM3MSX5gdhxP4EpJPzaRUypqWbYDpqHvM6lHEtX9JuO79t
         ZKjySXZCSNIHXuw78UPzTsLYMAds4J9lFGLda6vHaX7LatGo8RBueP9SbOxLTS8UUH0g
         4xGGXH8Lf3sx9Rq+HRrs5RYzrKAdEEcoSZvaGoutH8YL6jvybi3apgD5ZlJKyCqOHcch
         zxlg==
X-Gm-Message-State: AOAM5333vQKdC90m59UpikvDrf6wDerw+Gblwu1qbV2ZBuq+8RmZiIBm
        qHxq5kE5YyE4LJnkoteMeiFBpw==
X-Google-Smtp-Source: ABdhPJw6jmU61mWl+8j7l4GNipTTegFKNrG5zN1E4vT2ygIjDr3ZXuSUw9ldm0HfKKqJcvKoiTPmiQ==
X-Received: by 2002:a17:902:ba8a:b0:14e:e8e6:7215 with SMTP id k10-20020a170902ba8a00b0014ee8e67215mr24518244pls.135.1645555503098;
        Tue, 22 Feb 2022 10:45:03 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t11sm23252703pgi.90.2022.02.22.10.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:45:02 -0800 (PST)
Message-ID: <8ef27a29-1efc-9060-51cb-f77a3641f002@kernel.dk>
Date:   Tue, 22 Feb 2022 11:45:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 0/2] io-uring: Make statx api stable
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Cc:     viro@zeniv.linux.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220215180328.2320199-1-shr@fb.com>
 <539953d3-bc83-0b6d-24b3-214f6cdaeb65@kernel.dk>
In-Reply-To: <539953d3-bc83-0b6d-24b3-214f6cdaeb65@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/22 9:15 AM, Jens Axboe wrote:
> On 2/15/22 11:03 AM, Stefan Roesch wrote:
>> One of the key architectual tenets of io-uring is to keep the
>> parameters for io-uring stable. After the call has been submitted,
>> its value can be changed.  Unfortunaltely this is not the case for
>> the current statx implementation.
>>
>> Patches:
>>  Patch 1: fs: replace const char* parameter in vfs_statx and do_statx with
>>           struct filename
>>    Create filename object outside of do_statx and vfs_statx, so io-uring
>>    can create the filename object during the prepare phase
>>
>>  Patch 2: io-uring: Copy path name during prepare stage for statx
>>    Create and store filename object during prepare phase
>>
>>
>> There is also a patch for the liburing libray to add a new test case. This
>> patch makes sure that the api is stable.
>>   "liburing: add test for stable statx api"
>>
>> The patch has been tested with the liburing test suite and fstests.
> 
> Al, are you happy with this version?

I have staged this one for 5.18, it's in for-5.18/io_uring-statx. It will
be sent separately from the general io_uring fixes/updates.

-- 
Jens Axboe

