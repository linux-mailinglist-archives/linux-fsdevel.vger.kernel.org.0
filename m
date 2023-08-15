Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1777D4FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbjHOVQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjHOVQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:16:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6A1982
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 14:16:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6874a386ec7so1141610b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692134178; x=1692738978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEu4PLkfiVOa1dY72tvwJNIt3FbMPDLFKBz2++/psio=;
        b=wPVPYyfgYSnLertA1zuA37jfhDW5YUV7tpZ8H/63514WIGKHe2xES/HMooA+STRa6Q
         QfprMzg9MB5Ws+7VjkInztB5rg6BfYAHkiCG4Ivdk8Ps0tRG9ZSsHtT7rZscWCvzyt3W
         r9GlWS205F2Ze8r/Do0DzmqRVwu+gdlLha8S1P5R9hX1mrYk+wRCkEgrvZ6FGGcWNXHO
         py2i14FOQkgi95nIKyKY8E6R60ycC8jsm4RwWbz5IybVjItkV/mCTAlZDiCJE92M1XdJ
         dabaq7+tjnI1UxBNrdeAJJtLyefOGuA050EGJpOfx9aU4mWNfltJfmqkyL4K39CRjgH/
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134178; x=1692738978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEu4PLkfiVOa1dY72tvwJNIt3FbMPDLFKBz2++/psio=;
        b=ZlofPgmkvic1GOxeJlEDoyqLxwZtT0K6r/zeevcq2lT3jQwnMQ5QeSEOK2YA4MViGW
         BvPYD21E70XowgvH5n+56P3WW2nEXrMEJ9gHrOA440lPdtoL/FCev+MI2woVJTkO7/3C
         rqlwFnOiHUhRQDi5RPfCLISixa7PJ4wIQ7KjBXbsyiIadqzC0QHydwUfq0llPfhmofUr
         8tL4Nbbjownoe2bwPIoifO5/GSxZE9i3nR+emWliGgCql1HdVCvHuzf/IB3N2BU6+FNs
         9dhuwLxFdpIgyY9EZ+x8Vlrncy4V/mDuc5D+s7IONKt70TD7184SdGeIa0GvUqIfOc4h
         5j8w==
X-Gm-Message-State: AOJu0Ywk4zjCAstqi967fXfgxHqPDv78LyLHeLX5SP7ZUg2xlVi7Czqt
        GWlBEtpry2wjlFNqMJPRnn3Cmg==
X-Google-Smtp-Source: AGHT+IF0NZPLb5JXtX9AG4UgIbstmQE/6gX5vHYiQ1ZyKRBL8Qci3WZD3z4yXLe1R/+SKTTewBAV/A==
X-Received: by 2002:a05:6a00:4789:b0:687:874c:7ce0 with SMTP id dh9-20020a056a00478900b00687874c7ce0mr13953653pfb.1.1692134177735;
        Tue, 15 Aug 2023 14:16:17 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b00686940bfb77sm9749544pfm.71.2023.08.15.14.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:16:17 -0700 (PDT)
Message-ID: <264fbb0a-5fd1-447d-a373-389f74a12bcf@kernel.dk>
Date:   Tue, 15 Aug 2023 15:16:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230815165721.821906-1-amir73il@gmail.com>
 <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
 <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
 <CAOQ4uxh4YYs2=mqqZMi-L=a19gmcgi7M+2F7iy2WDUf=iqZtxQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxh4YYs2=mqqZMi-L=a19gmcgi7M+2F7iy2WDUf=iqZtxQ@mail.gmail.com>
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

On 8/15/23 12:48 PM, Amir Goldstein wrote:
> On Tue, Aug 15, 2023 at 8:06?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/15/23 11:02 AM, Jens Axboe wrote:
>>> On 8/15/23 10:57 AM, Amir Goldstein wrote:
>>>> +/**
>>>> + * kiocb_start_write - get write access to a superblock for async file io
>>>> + * @iocb: the io context we want to submit the write with
>>>> + *
>>>> + * This is a variant of file_start_write() for async io submission.
>>>> + * Should be matched with a call to kiocb_end_write().
>>>> + */
>>>> +static inline void kiocb_start_write(struct kiocb *iocb)
>>>> +{
>>>> +    struct inode *inode = file_inode(iocb->ki_filp);
>>>> +
>>>> +    iocb->ki_flags |= IOCB_WRITE;
>>>> +    if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
>>>> +            return;
>>>> +    if (!S_ISREG(inode->i_mode))
>>>> +            return;
>>>> +    sb_start_write(inode->i_sb);
>>>> +    /*
>>>> +     * Fool lockdep by telling it the lock got released so that it
>>>> +     * doesn't complain about the held lock when we return to userspace.
>>>> +     */
>>>> +    __sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
>>>> +    iocb->ki_flags |= IOCB_WRITE_STARTED;
>>>> +}
>>>> +
>>>> +/**
>>>> + * kiocb_end_write - drop write access to a superblock after async file io
>>>> + * @iocb: the io context we sumbitted the write with
>>>> + *
>>>> + * Should be matched with a call to kiocb_start_write().
>>>> + */
>>>> +static inline void kiocb_end_write(struct kiocb *iocb)
>>>> +{
>>>> +    struct inode *inode = file_inode(iocb->ki_filp);
>>>> +
>>>> +    if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
>>>> +            return;
>>>> +    if (!S_ISREG(inode->i_mode))
>>>> +            return;
>>
>> And how would IOCB_WRITE_STARTED ever be set, if S_ISREG() isn't true?
> 
> Good point.
> I will pass is_reg argument from callers of kiocb_start_write() and
> will only check IOCB_WRITE_STARTED in kiocb_end_write().

Please don't pass in an argument that just makes the function do
nothing. Just gate calling the function on it instead.

-- 
Jens Axboe

