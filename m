Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA610741DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjF2B3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 21:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjF2B3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:29:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629392701
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:29:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7f42e1dbaso301415ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688002176; x=1690594176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8kLyZ1+w+5+PCjKyBOmPVGH/ZOinGE085j6jsL1WTU=;
        b=OZRopHdDUGPBQex3VPOlm/NmRjnCf90aWLNF9FSzQgprXQqF2vLpUGtXSyS6juF1EX
         8GdGGkQzy5f6kZFKCRW3XFREFplpsOpIG7rBEv7p+uYbxd/mgAa81jyFHRszAa5ZPTwy
         IDX53XBLApVkMACsjBJ2wWanBrwM8gmTYc6tmXA9S7ASqTr8J/NE9XpER6JAcqZdK6SI
         1DklFSNWshW8L4+baZzhVriukVMVrSWXSi10WBjf6/OFPWKAEfr4J3gXVbyrdY2jH+zL
         oXh80huBzrcQequtrlXlTsRGosL+TYZTo/XH4cFNpSGZn1xk5n+3vcZAe9bl7nYfGAoE
         L9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002176; x=1690594176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8kLyZ1+w+5+PCjKyBOmPVGH/ZOinGE085j6jsL1WTU=;
        b=jGS46oKJOQVCqEJMb0x36jyq0rAHL5Afzoexb/sPF8XfHUNF1OyfGtLMdZGd7gWop6
         Hd3PbC06J/UA4Sxequ038uEoAR6t4aQh4YbwJPQYhCsHCU4gqd9jyyAZ9No3pCeL8brm
         2BzF17tDYaVJICMNtZB2K76/t5QT4law5zw0q6JJUkIo+CMayFxYekApvKMCO4ll7VJO
         7+QOitjHcMiEMVWOo3wdGzZny+K1Hlq8cwDojTQ9oH1E2tgr4I8ydwg3Q9vykAdo+BOr
         jGMZuwxbvhvNxLRQDXw/JoHYTw906qWdfytkQcsl7EiJZNQ3hUUgEjFdvbkPup3W6dT4
         mCJw==
X-Gm-Message-State: AC+VfDz3YBac1wWkdt1WPi7vYw8IVr5ZWIvd1rz8bUhWG8hxsxt8ib+r
        8EzUkOfu2FEEIZ85XwDD4GUiqQ==
X-Google-Smtp-Source: ACHHUZ6oFMjkpGg3Z5py2n5uUKP5KNrDCFUep2PGo7Un6nXElba8/gyK8xLnukJMUwQI01pTfuwuxA==
X-Received: by 2002:a17:903:3303:b0:1b8:1591:9f81 with SMTP id jk3-20020a170903330300b001b815919f81mr7969622plb.4.1688002175762;
        Wed, 28 Jun 2023 18:29:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a6d4ea7301sm8211541pll.251.2023.06.28.18.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 18:29:34 -0700 (PDT)
Message-ID: <a06a92ed-2b22-94a4-f1df-743303da2f3a@kernel.dk>
Date:   Wed, 28 Jun 2023 19:29:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 5:50?PM, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
>> On 6/28/23 4:55?PM, Kent Overstreet wrote:
>>>> But it's not aio (or io_uring or whatever), it's simply the fact that
>>>> doing an fput() from an exiting task (for example) will end up being
>>>> done async. And hence waiting for task exits is NOT enough to ensure
>>>> that all file references have been released.
>>>>
>>>> Since there are a variety of other reasons why a mount may be pinned and
>>>> fail to umount, perhaps it's worth considering that changing this
>>>> behavior won't buy us that much. Especially since it's been around for
>>>> more than 10 years:
>>>
>>> Because it seems that before io_uring the race was quite a bit harder to
>>> hit - I only started seeing it when things started switching over to
>>> io_uring. generic/388 used to pass reliably for me (pre backpointers),
>>> now it doesn't.
>>
>> I literally just pasted a script that hits it in one second with aio. So
>> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
>> hit with aio. As demonstrated. The io_uring is not hard to bring into
>> parity on that front, here's one I posted earlier today for 6.5:
>>
>> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
>>
>> Doesn't change the fact that you can easily hit this with io_uring or
>> aio, and probably more things too (didn't look any further). Is it a
>> realistic thing outside of funky tests? Probably not really, or at least
>> if those guys hit it they'd probably have the work-around hack in place
>> in their script already.
>>
>> But the fact is that it's been around for a decade. It's somehow a lot
>> easier to hit with bcachefs than XFS, which may just be because the
>> former has a bunch of workers and this may be deferring the delayed fput
>> work more. Just hand waving.
> 
> Not sure what you're arguing here...?
> 
> We've had a long standing bug, it's recently become much easier to hit
> (for multiple reasons); we seem to be in agreement on all that. All I'm
> saying is that the existence of that bug previously is not reason to fix
> it now.

Not really arguing, just stating that it's not a huge problem as it's
not something that real world would tend to do and probably why we saw
it in a test case instead.

>>>> then we'd probably want to move that deferred fput list to the
>>>> task_struct and ensure that it gets run if the task exits rather than
>>>> have a global deferred list. Currently we have:
>>>>
>>>>
>>>> 1) If kthread or in interrupt
>>>> 	1a) add to global fput list
>>>> 2) task_work_add if not. If that fails, goto 1a.
>>>>
>>>> which would then become:
>>>>
>>>> 1) If kthread or in interrupt
>>>> 	1a) add to global fput list
>>>> 2) task_work_add if not. If that fails, we know task is existing. add to
>>>>    per-task defer list to be run at a convenient time before task has
>>>>    exited.
>>>
>>> no, it becomes:
>>>  if we're running in a user task, or if we're doing an operation on
>>>  behalf of a user task, add to the user task's deferred list: otherwise
>>>  add to global deferred list.
>>
>> And how would the "on behalf of a user task" work in terms of being
>> in_interrupt()?
> 
> I don't see any relation to in_interrupt?

Just saying that you'd now need the task passed in.

> We'd have to add a version of fput() that takes an additional
> task_struct argument, and plumb that through the aio code - kioctx
> lifetime is tied to mm_struct, not task_struct, so we'd have to add a
> ref to the task_struct to kiocb.
> 
> Which would probably be a good thing tbh, it'd let us e.g. account cpu
> time back to the original task when kiocb completion has to run out of a
> workqueue.

Might also introduce some funky dependencies. Probably not an issue it
tied to the aio_kiocb. If you go ahead with that, just make sure you
keep the task referencing out of the fput variant for users that don't
need that.

-- 
Jens Axboe

