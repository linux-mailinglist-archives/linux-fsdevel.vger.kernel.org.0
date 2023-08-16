Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06577E331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbjHPOEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbjHPOEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:04:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991CFE48
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:04:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbb7c3d0f5so10624035ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692194647; x=1692799447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rs92RPYr3KnM2w4Ysgthns1+cyWKjQmCAzXQwYFV5ZQ=;
        b=cGPaDuJbwi1387vSHvlIyl874azAHznW/wPryFS/MicBwWCcboix1N4kWbv1EtMzuQ
         BzGGIZnJoPgYWrgmASRVg2ms5OW1rKNbQGrCw0QQVppNys0ZkmKL5NuU/qqGuiopO/mZ
         RSeGc41/cZGYrX50/KuaZHf2Hob2PnhvaiBaQKsi0QS5Bt4MhQ6XjS455Hz/F1UrsO4N
         HC6zMwMXTyT9sNhJ4j1E9F5OoAJjGLCkffzHZGc8XQMjqVQZU165gxJ7uSh+zO26HcN1
         u/H0KRkhf6LdJWNVZkK+cHdqPP4sONc+496CaJQ6x/vdwTjEpDGOaFgoOoAg68r8X3SE
         W6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692194647; x=1692799447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs92RPYr3KnM2w4Ysgthns1+cyWKjQmCAzXQwYFV5ZQ=;
        b=hUlUiZ/Nw5+TQeVyG6Fr7vanLiVQcYrQTF0RsmgqjrBPxoOjX21y0wNkjNg5dBb/Yb
         KQrL79/vd9T9usXArojii9aiC6uCfYdeoFVXb2JgHqz4Y/ULsnMqd4VyIvnZ0+DDHizQ
         oNR8zR19j+/pJ9UtsIgzBwmPPbO2BKjoOuVm/1GUI1xONtNFNDKQfQ4ofJjkoMvlsq1T
         PZiQEn6rwG+ZJt3S99s72qf2UlCM3514ZYZ/mibvAj67SUKOA2iEbaUlquBRCq5lDOMh
         3nnAyBNp/riCu5//tmrYRVmzhmw8LWIisGJJFd7gWPMDNBWU4TvP2DvlqNg4cwiJzeW9
         tiPQ==
X-Gm-Message-State: AOJu0Yz6WcExEa9vqBxWityOEo2J6VFtVd1r8fkmYdAO4t6KM5+TcsR6
        YPbBBTGmr00XpbxS1fvb4YWNDg==
X-Google-Smtp-Source: AGHT+IETc1cPFefMflhAe6x6OWrqpsJIXnMTHSY1Ies9dOY5qneDaixOtWAnnQslYsEKXreu5xVhHQ==
X-Received: by 2002:a17:902:da91:b0:1bb:b832:4be9 with SMTP id j17-20020a170902da9100b001bbb8324be9mr2357596plx.1.1692194646939;
        Wed, 16 Aug 2023 07:04:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001b66e3a77easm13225700plb.50.2023.08.16.07.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:04:06 -0700 (PDT)
Message-ID: <45a712b3-a9c7-404b-960c-e2bac2a41007@kernel.dk>
Date:   Wed, 16 Aug 2023 08:04:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230815165721.821906-1-amir73il@gmail.com>
 <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
 <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
 <CAOQ4uxh4YYs2=mqqZMi-L=a19gmcgi7M+2F7iy2WDUf=iqZtxQ@mail.gmail.com>
 <264fbb0a-5fd1-447d-a373-389f74a12bcf@kernel.dk>
 <20230816-vergeben-stangen-bf5619e714e6@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230816-vergeben-stangen-bf5619e714e6@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/23 2:51 AM, Christian Brauner wrote:
> On Tue, Aug 15, 2023 at 03:16:15PM -0600, Jens Axboe wrote:
>> On 8/15/23 12:48 PM, Amir Goldstein wrote:
>>> On Tue, Aug 15, 2023 at 8:06?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/15/23 11:02 AM, Jens Axboe wrote:
>>>>> On 8/15/23 10:57 AM, Amir Goldstein wrote:
>>>>>> +/**
>>>>>> + * kiocb_start_write - get write access to a superblock for async file io
>>>>>> + * @iocb: the io context we want to submit the write with
>>>>>> + *
>>>>>> + * This is a variant of file_start_write() for async io submission.
>>>>>> + * Should be matched with a call to kiocb_end_write().
>>>>>> + */
>>>>>> +static inline void kiocb_start_write(struct kiocb *iocb)
>>>>>> +{
>>>>>> +    struct inode *inode = file_inode(iocb->ki_filp);
>>>>>> +
>>>>>> +    iocb->ki_flags |= IOCB_WRITE;
>>>>>> +    if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
>>>>>> +            return;
>>>>>> +    if (!S_ISREG(inode->i_mode))
>>>>>> +            return;
>>>>>> +    sb_start_write(inode->i_sb);
>>>>>> +    /*
>>>>>> +     * Fool lockdep by telling it the lock got released so that it
>>>>>> +     * doesn't complain about the held lock when we return to userspace.
>>>>>> +     */
>>>>>> +    __sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
>>>>>> +    iocb->ki_flags |= IOCB_WRITE_STARTED;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * kiocb_end_write - drop write access to a superblock after async file io
>>>>>> + * @iocb: the io context we sumbitted the write with
>>>>>> + *
>>>>>> + * Should be matched with a call to kiocb_start_write().
>>>>>> + */
>>>>>> +static inline void kiocb_end_write(struct kiocb *iocb)
>>>>>> +{
>>>>>> +    struct inode *inode = file_inode(iocb->ki_filp);
>>>>>> +
>>>>>> +    if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
>>>>>> +            return;
>>>>>> +    if (!S_ISREG(inode->i_mode))
>>>>>> +            return;
>>>>
>>>> And how would IOCB_WRITE_STARTED ever be set, if S_ISREG() isn't true?
>>>
>>> Good point.
>>> I will pass is_reg argument from callers of kiocb_start_write() and
>>> will only check IOCB_WRITE_STARTED in kiocb_end_write().
>>
>> Please don't pass in an argument that just makes the function do
>> nothing. Just gate calling the function on it instead.
> 
> Your commit about avoiding dipping into inodes unnecessarily when not
> all callers need it is for perf reasons or what's the worry?

Right, it's to avoid pulling in dependent loads for the cases where you
don't need to access it. Granted for this it's not super important as
most workloads using read/write would be a regular file to begin with,
and then we'd dip into the inode anyway for the lock dance. But it's
good practice in general, and if you were eg using pipes then it becomes
just wasted dependent loads.

> Fwiw, I don't mind if we force the callers to check for prerequisites
> instead of the helpers. I'm just curious what the thinking behind it is.
> 
> Otherwise I think a cleanup like this might be useful.

Agree, it's a useful cleanup.

-- 
Jens Axboe

