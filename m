Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1614B741BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjF1WeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjF1Wd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:33:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3726B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:33:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-676cc97ca74so9634b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687991638; x=1690583638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oW5BXhQovw4TV6zdZd424J+I/WFKk4cAc5zD1n255c=;
        b=c9gdujX9zi75jg4hmjr8oFrVx/hG1FqUKaICQS9v4vWmbwHtPoIvFmN2HPuH1nKOmH
         Pr1msq3OxLAmq2VcgBoES9iaK9Zc8z+b5ZQZd71b7s5lgDlgAHwyTujMIW1MRU8a4rr2
         p4/A8htbaVVzcTDo2KN3o+qS2x186ciX4lMjB8XYBjVnPZZh9ljhVdjpitMuL4FYAxBM
         qGV5qyKojK31W9x0w3Y5llYh7hoHMKOqibL5dsKzLQhJs5KSD1DmJqhmRHbLM5tbRk6E
         S9JurP+nkWdOKQDd9z/CfYnXAE2hhs8knpCXHLcZ978FdyBF8flULECq7F+jYV0tgouY
         dGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687991638; x=1690583638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oW5BXhQovw4TV6zdZd424J+I/WFKk4cAc5zD1n255c=;
        b=YYB+ZHeUvtO3O5VKGZvXPJrdl5onw1V+QVTma2OaFFI2ohLkVfljQorQUw0Rhmw47Y
         0x8ogAiXcEVrjBazbBNySTNHkroYreKbwHWZTtx9IyQWr0vqtNIdBYhHMXjMHHH85H3I
         FvqnXOxkDXDB8AM1kGcZcTfTPAeVfB1Q+3L2roN2e2uvxDh74556BDR/J6js4JSshXIW
         0LoIvLxJ1mkw4HK+xAq9QtJ3G7VaL5MJFVa/eyyi/nP47gdBfYnMEAA2MHikfui7XljP
         2hAIzOjui492mmbrRR44HTIPrPWQQ1Y8haWAWJE/2VZ4Ic0XbovrhWfg/ktM3ug3NCTt
         GxLw==
X-Gm-Message-State: AC+VfDze3EIqrXmZmz7aT7HUzt5/rQ18ahtzyWbFhPMMl1QXyCsngkmh
        iM5Sb3ZDtBLdx14Cr+Wd4ib6+A==
X-Google-Smtp-Source: ACHHUZ65sNYPaxFEj9KlTSH6RYDS3nDfKpKwX6XXCBSTl0TgMRiDzLaDCl/l714R9NkUA/tbNESVpw==
X-Received: by 2002:a05:6a20:8f04:b0:121:b5af:acbc with SMTP id b4-20020a056a208f0400b00121b5afacbcmr38497363pzk.3.1687991637811;
        Wed, 28 Jun 2023 15:33:57 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z6-20020aa791c6000000b0065434edd521sm1236833pfa.196.2023.06.28.15.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 15:33:56 -0700 (PDT)
Message-ID: <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
Date:   Wed, 28 Jun 2023 16:33:55 -0600
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
References: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 4:13?PM, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 03:17:43PM -0600, Jens Axboe wrote:
>> Case in point, just changed my reproducer to use aio instead of
>> io_uring. Here's the full script:
>>
>> #!/bin/bash
>>
>> DEV=/dev/nvme1n1
>> MNT=/data
>> ITER=0
>>
>> while true; do
>> 	echo loop $ITER
>> 	sudo mount $DEV $MNT
>> 	fio --name=test --ioengine=aio --iodepth=2 --filename=$MNT/foo --size=1g --buffered=1 --overwrite=0 --numjobs=12 --minimal --rw=randread --output=/dev/null &
>> 	Y=$(($RANDOM % 3))
>> 	X=$(($RANDOM % 10))
>> 	VAL="$Y.$X"
>> 	sleep $VAL
>> 	ps -e | grep fio > /dev/null 2>&1
>> 	while [ $? -eq 0 ]; do
>> 		killall -9 fio > /dev/null 2>&1
>> 		echo will wait
>> 		wait > /dev/null 2>&1
>> 		echo done waiting
>> 		ps -e | grep "fio " > /dev/null 2>&1
>> 	done
>> 	sudo umount /data
>> 	if [ $? -ne 0 ]; then
>> 		break
>> 	fi
>> 	((ITER++))
>> done
>>
>> and if I run that, fails on the first umount attempt in that loop:
>>
>> axboe@m1max-kvm ~> bash test2.sh
>> loop 0
>> will wait
>> done waiting
>> umount: /data: target is busy.
>>
>> So yeah, this is _nothing_ new. I really don't think trying to address
>> this in the kernel is the right approach, it'd be a lot saner to harden
>> the xfstest side to deal with the umount a bit more sanely. There are
>> obviously tons of other ways that a mount could get pinned, which isn't
>> too relevant here since the bdev and mount point are basically exclusive
>> to the test being run. But the kill and delayed fput is enough to make
>> that case imho.
> 
> Uh, count me very much not in favor of hacking around bugs elsewhere.
> 
> Al, do you know if this has been considered before? We've got fput()
> being called from aio completion, which often runs out of a worqueue (if
> not a workqueue, a bottom half of some sort - what happens then, I
> wonder) - so the effect is that it goes on the global list, not the task
> work list.
> 
> hence, kill -9ing a process doing aio (or io_uring io, for extra
> reasons) causes umount to fail with -EBUSY.
> 
> and since there's no mechanism for userspace to deal with this besides
> sleep and retry, this seems pretty gross.

But there is, as Christian outlined. I would not call it pretty or
intuitive, but you can in fact make it work just fine and not just for
the deferred fput() case but also in the presence of other kinds of
pins. Of which there are of course many.

> I'd be willing to tackle this for aio since I know that code...

But it's not aio (or io_uring or whatever), it's simply the fact that
doing an fput() from an exiting task (for example) will end up being
done async. And hence waiting for task exits is NOT enough to ensure
that all file references have been released.

Since there are a variety of other reasons why a mount may be pinned and
fail to umount, perhaps it's worth considering that changing this
behavior won't buy us that much. Especially since it's been around for
more than 10 years:

commit 4a9d4b024a3102fc083c925c242d98ac27b1c5f6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jun 24 09:56:45 2012 +0400

    switch fput to task_work_add

though that commit message goes on to read:

    We are guaranteed that __fput() will be done before we return
    to userland (or exit).  Note that for fput() from a kernel
    thread we get an async behaviour; it's almost always OK, but
    sometimes you might need to have __fput() completed before
    you do anything else.  There are two mechanisms for that -
    a general barrier (flush_delayed_fput()) and explicit
    __fput_sync().  Both should be used with care (as was the
    case for fput() from kernel threads all along).  See comments
    in fs/file_table.c for details.

where that first sentence isn't true if the task is indeed exiting. I
guess you can say that it is as it doesn't return to userland, but
splitting hairs. Though the commit in question doesn't seem to handle
that case, but assuming that came in with a later fixup.

It is true if the task_work gets added, as that will get run before
returning to userspace.

If a case were to be made that we also guarantee that fput has been done
by the time to task returns to userspace, or exits, then we'd probably
want to move that deferred fput list to the task_struct and ensure that
it gets run if the task exits rather than have a global deferred list.
Currently we have:

1) If kthread or in interrupt
	1a) add to global fput list
2) task_work_add if not. If that fails, goto 1a.

which would then become:

1) If kthread or in interrupt
	1a) add to global fput list
2) task_work_add if not. If that fails, we know task is existing. add to
   per-task defer list to be run at a convenient time before task has
   exited.

and seems a lot saner than hacking around this in umount specifically.

-- 
Jens Axboe

