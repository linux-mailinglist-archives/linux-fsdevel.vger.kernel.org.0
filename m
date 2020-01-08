Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC0134FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 23:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgAHWxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 17:53:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53574 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAHWxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:53:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so251542pjc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uVvoJJ+mIeDE7bvokesEXDFwY4/SCp+SzK2tgiz95Co=;
        b=TDrPqLrtPUAjCui/vNKB1AXxNf7p1GHiB3X44lPCBXWbxllB87eBIduoZPTO57ihmw
         +QBogSBHdm8JKPrOX4doyotrND713KrkvmZedppgHvgBT8VU7u/WjCdYz8cyvFKjLTO6
         a/5UQlK8VifsgOzpKVaBfWSMbD0y4TVWO9bhLRgInPbfEhmWHQBPxF+0H9aZ48pJBqlr
         tDSnkAzmS8amkY4sRZLI3r/uY43YYZJLoZGUFsIY2EoHyqVh/YYJnurC2Tx15Nd6U9Gd
         k0BFNUDiaHoOJPlgafu9vpKd3iHYW3T9XieFdkcsD2ADLKCP7Apo3N1Ne73hui87bMtB
         8G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVvoJJ+mIeDE7bvokesEXDFwY4/SCp+SzK2tgiz95Co=;
        b=jkx9AIcmPiQf9ltg2Mo+xNH37rGOUZeeaa5DrC2iqrFuHTUHsLR2eriXA/os8nq8J6
         PE1sA70vagwTgvPePjCCcmAvXV6Xesr9j+HQ5ZU3tvSBGaTpoCOd+7WRcEtWzUzuUExo
         tJV6uWDMnxWmxjKoXsKjPdyC99XbsJGKsRFwcEc4CUifE0hipWWjn9qgFvkCGGn3aBIT
         Bk9vzLnkNEFNAaD6tq3+lrBq0bVKkVlYyDgp37T2Ew9todLyZuOhJn6OunA+LjaU63y1
         kBH/Ds5toz5d+Oa707D6hRJ8blO3RbZhkA4vsGPehzyJNm9vwOYZfExxEABdw6sPDZfR
         mEMg==
X-Gm-Message-State: APjAAAXCzCmHHib/ZuGb7gZj84EaQS0PGBhxcOSUvLg9iFOsvo24DcQz
        zn7c02znljw1T2/6Fi5vRhBChg==
X-Google-Smtp-Source: APXvYqxq4hnVD3T5b8lv60Ds5p+GCoWQCn+8smGauwcu6bT94whMbjApUL6WrTr79mBLH9zXMcdiBw==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr1206146pjo.84.1578523991497;
        Wed, 08 Jan 2020 14:53:11 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z30sm5089873pfq.154.2020.01.08.14.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 14:53:10 -0800 (PST)
Subject: Re: [PATCH 3/6] io_uring: add support for IORING_OP_OPENAT
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200107170034.16165-1-axboe@kernel.dk>
 <20200107170034.16165-4-axboe@kernel.dk>
 <82a015c4-f5b9-7c85-7d80-78964cb0d82e@samba.org>
 <4ccb935c-7ff9-592f-8c27-0af3d38326d7@kernel.dk>
 <2afdd5a5-0eb5-8fba-58d1-03001abbab7e@samba.org>
 <9672da37-bf6f-ce2d-403c-5e2692c67782@kernel.dk>
 <d0f0e726-8e6f-aa43-07b6-fdb3b49ce1bc@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5a5dc20-7e11-8489-b9d5-c2cf8a4bdf4b@kernel.dk>
Date:   Wed, 8 Jan 2020 15:53:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d0f0e726-8e6f-aa43-07b6-fdb3b49ce1bc@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 10:04 AM, Stefan Metzmacher wrote:
> Am 08.01.20 um 17:40 schrieb Jens Axboe:
>> On 1/8/20 9:32 AM, Stefan Metzmacher wrote:
>>> Am 08.01.20 um 17:20 schrieb Jens Axboe:
>>>> On 1/8/20 6:05 AM, Stefan Metzmacher wrote:
>>>>> Hi Jens,
>>>>>
>>>>>> This works just like openat(2), except it can be performed async. For
>>>>>> the normal case of a non-blocking path lookup this will complete
>>>>>> inline. If we have to do IO to perform the open, it'll be done from
>>>>>> async context.
>>>>>
>>>>> Did you already thought about the credentials being used for the async
>>>>> open? The application could call setuid() and similar calls to change
>>>>> the credentials of the userspace process/threads. In order for
>>>>> applications like samba to use this async openat, it would be required
>>>>> to specify the credentials for each open, as we have to multiplex
>>>>> requests from multiple user sessions in one process.
>>>>>
>>>>> This applies to non-fd based syscall. Also for an async connect
>>>>> to a unix domain socket.
>>>>>
>>>>> Do you have comments on this?
>>>>
>>>> The open works like any of the other commands, it inherits the
>>>> credentials that the ring was setup with. Same with the memory context,
>>>> file table, etc. There's currently no way to have multiple personalities
>>>> within a single ring.
>>>
>>> Ah, it's user = get_uid(current_user()); and ctx->user = user in
>>> io_uring_create(), right?
>>
>> That's just for the accounting, it's the:
>>
>> ctx->creds = get_current_cred();
> 
> Ok, I just looked at an old checkout.
> 
> In kernel-dk-block/for-5.6/io_uring-vfs I see this only used in
> the async processing. Does a non-blocking openat also use ctx->creds?

There's basically two sets here - one set is in the ring, and the other
is the identity that the async thread (briefly) assumes if we have to go
async. Right now they are the same thing, and hence we don't need to
play any tricks off the system call submitting SQEs to assume any other
identity than the one we have.

>>>> Sounds like you'd like an option for having multiple personalities
>>>> within a single ring?
>>>
>>> I'm not sure anymore, I wasn't aware of the above.
>>>
>>>> I think it would be better to have a ring per personality instead.
>>>
>>> We could do that. I guess we could use per user rings for path based
>>> operations and a single ring for fd based operations.
>>>
>>>> One thing we could do to make this more lightweight
>>>> is to have rings that are associated, so that we can share a lot of the
>>>> backend processing between them.
>>>
>>> My current idea is to use the ring fd and pass it to our main epoll loop.
>>>
>>> Can you be more specific about how an api for associated rings could
>>> look like?
>>
>> The API would be the exact same, there would just be some way to
>> associate rings when you create them. Probably a new field in struct
>> io_uring_params (and an associated flag), which would tell io_uring that
>> two separate rings are really the same "user". This would allow io_uring
>> to use the same io-wq workqueues, for example, etc.
> 
> Ok, this would be just for better performance / better usage of
> resources, right?

Exactly

>> This depends on the fact that you can setup the rings with the right
>> personalities, that they would be known upfront. From your description,
>> I'm not so sure that's the case? If not, then we would indeed need
>> something that can pass in the credentials on a per-command basis. Not
>> sure what that would look like.
> 
> We know the credentials and using a ring per user should be ok.

Sounds good!

-- 
Jens Axboe

