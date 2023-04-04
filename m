Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F476D68E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjDDQa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjDDQal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:30:41 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8565588
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 09:30:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j19so673879ilq.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680625829; x=1683217829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOkwpry92hNrhdoYU8TTu3v6fSyQj7r//Y+P3UzI88A=;
        b=PU7If7fmWPJOvnSO/gB8yPyKaTXGsUKu08AtS8DCPgNtAikn6AQbEXhYQ/3BQ5642I
         RJS0x7oUPTRJa0rvvPHOfxGqFaOuwEPINFpOTukb7R5JszpZMNZcvwGG6RUn/+ls7nxi
         p33fk1XVDg4QOP9G2YJzuFCWjQGPlEwHMTF0vryCDgB55Mt4UXqncrPLsmYIRXS3Ou8W
         x47NCFroAxf4AiVh9SnXX2ku4qtI03XvxhmTcOTUHRSgDqgZ5o/s8Uqxm+1auA0UdjEy
         znD2cEwUdqhEXp0uanGTq5aJ/zO9P+C/oUyIr/MO2zxLifm/sXQneFY7RtQZAKNth/OQ
         Q1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625829; x=1683217829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOkwpry92hNrhdoYU8TTu3v6fSyQj7r//Y+P3UzI88A=;
        b=EAKsYZ7Yhb/Nr9Myy1x71XTiCLZzbBvAwO5yEA9TvTSUCiOGcXGh1fWQsruKdPYYf3
         a9O3IjrAAAM1JU/2PpqUGtQckyW4LKTmwRKtvWLBl7IEQzbuRjpvPqM1T1u1NnUNZxQx
         TMIEhG8cHBvl+9OSerwM+w7bxP2DlO4WYimluL/k9VHi2TcfkyrGssIGe0XqIPNAu8bJ
         N5ZKUyaSbA5LrXy0DBDbHvv1kYB38mWJWWCswL5IRNSmmsgXK2AQjrZa8Mnh6xwOFgCy
         uyIgQ02sZO+1PUxCQi1uNaaiZu7bat09vyQZf8JNg/luyI7sFUl1d2Jtb45aRcwumk/8
         GCsg==
X-Gm-Message-State: AAQBX9czEZFe5v+8xnJWDMGDufC7rOIivGMpW/sIl+m8OB7abTzCf1JN
        LjKLHRmzRWfq+xSgin+scI14cg==
X-Google-Smtp-Source: AKy350ZZVL9a/U8emrnKI2yjeUvuM6QC9ftB3e6FNNdToQF8GZaheJaFTnmRLJU5rPzYniAZ11uwbw==
X-Received: by 2002:a05:6e02:1a06:b0:326:1d0a:cce6 with SMTP id s6-20020a056e021a0600b003261d0acce6mr237300ild.0.1680625829614;
        Tue, 04 Apr 2023 09:30:29 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i10-20020a056638380a00b0040b2254447bsm2947197jav.56.2023.04.04.09.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:30:29 -0700 (PDT)
Message-ID: <ac855149-e5a8-fffc-4662-2bd0ab20e899@kernel.dk>
Date:   Tue, 4 Apr 2023 10:30:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: report related fsnotify events
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230322062519.409752-1-cccheng@synology.com>
 <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
 <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
 <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
 <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk>
 <20230404092109.evsvdcv6p2e5bvtf@quack3>
 <CAOQ4uxiCKRVe_hVM7e8t3UGcnbBNEBUiZPa5Jrmh02hCkAPq8w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxiCKRVe_hVM7e8t3UGcnbBNEBUiZPa5Jrmh02hCkAPq8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/23 7:45?AM, Amir Goldstein wrote:
> On Tue, Apr 4, 2023 at 12:21?PM Jan Kara <jack@suse.cz> wrote:
>>
>> On Mon 03-04-23 11:23:25, Jens Axboe wrote:
>>> On 4/3/23 11:15?AM, Amir Goldstein wrote:
>>>>> On 4/3/23 11:00?AM, Amir Goldstein wrote:
>>>>> io_uring does do it for non-polled IO, I don't think there's much point
>>>>> in adding it to IOPOLL however. Not really seeing any use cases where
>>>>> that would make sense.
>>>>>
>>>>
>>>> Users subscribe to fsnotify because they want to be notified of changes/
>>>> access to a file.
>>>> Why do you think that polled IO should be exempt?
>>>
>>> Because it's a drastically different use case. If you're doing high
>>> performance polled IO, then you'd never rely on something as slow as
>>> fsnotify to tell you of any changes that happened to a device or file.
>>> That would be counter productive.
>>
>> Well, I guess Amir wanted to say that the application using fsnotify is not
>> necessarily the one doing high performance polled IO. You could have e.g.
>> data mirroring application A tracking files that need mirroring to another
>> host using fsnotify and if some application B uses high performance polled
>> IO to modify a file, application A could miss the modified file.
>>
>> That being said if I look at exact details, currently I don't see a very
>> realistic usecase that would have problems (people don't depend on
>> FS_MODIFY or FS_ACCESS events too much, usually they just use FS_OPEN /
>> FS_CLOSE), which is likely why nobody reported these issues yet :).
>>
> 
> I guess so.
> Our monitoring application also does not rely on FS_MODIFY/FS_ACCESS
> as they could be too noisy.
> 
> The thing that I find missing is being able to tell if a file was *actually*
> accessed/modified in between open and close.
> This information could be provided with FS_CLOSE event

Agree, it's not a good fit for a lot of common use cases.

-- 
Jens Axboe

