Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C2505FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiDRWXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 18:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiDRWXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:23:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9229CB0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:20:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso569923pjv.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=QfJ6O6pJjSyzKNyVh3XW9W2RO0ENxvM0U1QwJbKrVT0=;
        b=1ll+QHmybrhWJ4738LKoxD4U6Rl6QEusQwAV+kkhjDvdgK419Gh4r3c7Xu8mn4xzbd
         B4WDJ+t65sc7L5cvswgG+jBqNJc9sGi9WWgep2FVbHC6uBS7svU4XJHdb9ZXKvcTU7FX
         YHyin7qGFTT8aFdJ5Sj66uyZZvtXU1krDSK+jxnR0aLk0d9GJzb0fI5IlHAVGMoyy5JC
         yIuQDXQm1MNHmSdM50CFEM76yxA8gWU9TcGxklNJsUOO9BxAwSmyDrym/Fc0r3hgbgy2
         9BRFR09B/0U/0+Sp4nR97RBi/ujHKVPb6PtXgAjmtep7jdk8VFc8LK1+NxxJRTgjp+W+
         Jc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=QfJ6O6pJjSyzKNyVh3XW9W2RO0ENxvM0U1QwJbKrVT0=;
        b=nqWbBxm84tE/16rONOVogtrzmIjGgWA9nNk+i5H6OhogdM6nTUkUaEEq6iM+G6oSrD
         K3b7gbEdPgRJ3b58QCmso8W0X9sWTuckydw35s1J8HQm9wC1VKPAh1TD2eGMgKznThx2
         8SW5eqqZFmtaXavJUPvmHVH2I0u7HxbLK71tXwm0SZjbqcAIYEflL+sZds9F3GsQOEma
         gy0N48u6zTwPYu+57gVody7AAawJaMlyw3HGRM0HLlOEWttcrBYUm4UprnrSZ1aTmm/K
         zyi3zPaB7XFVt57mkWoQwP1VC3mH7Avb6tpbMdWId88BEOxhQFe+ULnmHbHZ7vYIyruR
         0ZDA==
X-Gm-Message-State: AOAM533gLzn5MVAQoB62FKBQGxhtzuuWdj/2z0FYkmmioCp4pFJwvOYy
        tU57Yzbj9FajkCx2f2RIJ3SVOg==
X-Google-Smtp-Source: ABdhPJx51SQD/vUOWj0484tKVo3R3r4qdERpHZis3xgZUlmGPjPhzfzdnM3yLdtLaDKmVEtWCY+z4g==
X-Received: by 2002:a17:90b:3c12:b0:1cb:70ef:240a with SMTP id pb18-20020a17090b3c1200b001cb70ef240amr14875731pjb.217.1650320422358;
        Mon, 18 Apr 2022 15:20:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm13799887pgc.50.2022.04.18.15.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:20:21 -0700 (PDT)
Message-ID: <b0167ea3-55ae-5e4e-7022-4105844b0495@kernel.dk>
Date:   Mon, 18 Apr 2022 16:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_fs-writeback=3a_writeback=5fsb=5fino?=
 =?UTF-8?Q?des=ef=bc=9aRecalculate_=27wrote=27_according_skipped_pages?=
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
 <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
In-Reply-To: <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/22 4:12 PM, Jens Axboe wrote:
> On 4/18/22 4:01 PM, Linus Torvalds wrote:
>> On Mon, Apr 18, 2022 at 2:16 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> So as far as I can tell, we really have two options:
>>>
>>> 1) Don't preempt a task that has a plug active
>>> 2) Flush for any schedule out, not just going to sleep
>>>
>>> 1 may not be feasible if we're queueing lots of IO, which then leaves 2.
>>> Linus, do you remember what your original patch here was motivated by?
>>> I'm assuming it was an effiency thing, but do we really have a lot of
>>> cases of IO submissions being preempted a lot and hence making the plug
>>> less efficient than it should be at merging IO? Seems unlikely, but I
>>> could be wrong.
>>
>> No, it goes all the way back to 2011, my memory for those kinds of
>> details doesn't go that far back.
>>
>> That said, it clearly is about preemption, and I wonder if we had an
>> actual bug there.
>>
>> IOW, it might well not just in the "gather up more IO for bigger
>> requests" thing, but about "the IO plug is per-thread and doesn't have
>> locking because of that".
>>
>> So doing plug flushing from a preemptible kernel context might race
>> with it all being set up.
> 
> Hmm yes. But doesn't preemption imply a full barrier? As long as we
> assign the plug at the end, we should be fine. And just now looking that
> up, there's even already a comment to that effect in blk_start_plug().
> So barring any weirdness with that, maybe that's the solution.
> 
> Your comment did jog my memory a bit though, and I do in fact think it
> was something related to that that made is change it. I'll dig through
> some old emails and see if I can find it.

Here's the thread:

https://lore.kernel.org/all/1295659049-2688-6-git-send-email-jaxboe@fusionio.com/

I'll dig through it in a bit, but here's your reasoning for why it
should not flush on preemption:

https://lore.kernel.org/all/BANLkTikBEJa7bJJoLFU7NoiEgOjVHVG08A@mail.gmail.com/

-- 
Jens Axboe

