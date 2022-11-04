Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA88961A4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDWt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 18:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKDWtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:49:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB086E47A
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 15:43:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gw22so5736069pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veoUvRC5EJSNAcK1/G1eN61eiFVZm/onnmWfrthyC5U=;
        b=LROsPj4aOiifHCFVRKHA3csUVmBaotq8qVFO++OZ/VUYyprBdpcWM2W5Du9zj9Nus/
         vhePJ+mxUy7MZXuOfGMLNPTMvUyT3YyeCKldC4MPfX1qVam2DilQXaiqHY7yA1XQPNGW
         xi8JAYkayBeTIOrjCA6mxGr2MyA+1LYqFIWB2v42attITOg7JZY8kXWJf5aXCc+/ndAo
         9XdCrI8SknZ64ufOASLp/CycRQyO6z0jv9uhqtLMH3F4vimRHvSe1O8FcfeZWAfcUVt3
         XgtVZ9ax8JE74xugUmDZ1IVmiUVJ53ZBO0SB03quNg4rHTLZuLcxhL6kFAe3XLsY0LIm
         sDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veoUvRC5EJSNAcK1/G1eN61eiFVZm/onnmWfrthyC5U=;
        b=SWA6V+/AS5/gHibJLJzhzwIW/hypRh9s9BA1Ple1ViJemnusvA9ZQ1NzKf++wdQilH
         igGi8sJl2+CBb/2jtw8KqE5m1k9isUxaf77R6zUZEnNqAOv7aahEhiWVYBrbXZaUKHhF
         GKbpXuKQbGO2IQMawkmoXD0yHKZFAvQnQRPgfWo+a3LHKcoonleO3j/+uoxhq8zG5R+J
         2ELrQYEA7inlCmJFVDLcdwBee1D08cTCz0CaG2Vcr2KvkgCt4qneCRqs3ZNqHpsGqO77
         KHihVbHmEZk/SjE/2HQg1nwP+HZOkpEJOmMFcwN80ppIVmwk4fs0kxZz6rhgIM3E9TyN
         vOfg==
X-Gm-Message-State: ACrzQf0nxdtl9e/2E1EGYniPeWmwOMG+7feu2KOSz6SIr+eRI7/Cxzey
        tvsdJmMWfHTTsJt/Vdp/NyfqFQ==
X-Google-Smtp-Source: AMsMyM45U4n3q8TYV7dp0cmPFY23u5impcXIKNkBJvT7zNfLJrxJufCngW3S1+r/AxmiM9Dd5ntq5w==
X-Received: by 2002:a17:902:bf45:b0:187:337c:b967 with SMTP id u5-20020a170902bf4500b00187337cb967mr22723317pls.4.1667601824218;
        Fri, 04 Nov 2022 15:43:44 -0700 (PDT)
Received: from [10.255.93.192] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b0017f7e0f4a4esm264995pll.35.2022.11.04.15.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 15:43:43 -0700 (PDT)
Message-ID: <6e33dd02-99b0-0899-aed5-07f770340a74@bytedance.com>
Date:   Sat, 5 Nov 2022 06:43:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: xarray, fault injection and syzkaller
To:     Dmitry Vyukov <dvyukov@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org> <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
 <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
 <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/5 02:21, Dmitry Vyukov wrote:
> On Fri, 4 Nov 2022 at 11:03, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Fri, Nov 04, 2022 at 10:47:17AM -0700, Dmitry Vyukov wrote:
>>>>> Do we know how common/useful such an allocation pattern is?
>>>>
>>>> I have coded something like this a few times, in my cases it is
>>>> usually something like: try to allocate a big chunk of memory hoping
>>>> for a huge page, then fall back to a smaller allocation
>>>>
>>>> Most likely the key consideration is that the callsites are using
>>>> GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
>>>> NOWARN case assuming that another allocation attempt will closely
>>>> follow?
>>>
>>> GFP_NOWARN is also extensively used for allocations with
>>> user-controlled size, e.g.:
>>> https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451
>>>
>>> That's different and these allocations are usually not repeated.
>>> So looking at GFP_NOWARN does not look like the right thing to do.
>>
>> This may be the best option then, arguably perhaps even more
>> "realistic" than normal fail_nth as in a real system if this stuff
>> starts failing there is a good chance things from then on will fail
>> too during the error cleanup.
>>
>>>> However, this would also have to fix the obnoxious behavior of fail
>>>> nth where it fails its own copy_from_user on its write system call -
>>>> meaning there would be no way to turn it off.
>>>
>>> Oh, interesting. We added failing of copy_from/to_user later and did
>>> not consider such interaction.
>>> Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.
>>
>> Oh, I will tell you the other two bugish things I noticed
>>
>> __should_failslab() has this:
>>
>>          if (gfpflags & __GFP_NOWARN)
>>                  failslab.attr.no_warn = true;
>>
>>          return should_fail(&failslab.attr, s->object_size);
>>
>> Which always permanently turns off no_warn for slab during early
>> boot. This is why syzkaller reports are so confusing. They trigger a
>> slab fault injection, which in all other cases gives a notification
>> backtrace, but in slab cases there is no hint about the fault
>> injection in the log.
> 
> Ouch, this looks like a bug in:
> 
> commit 3f913fc5f9745613088d3c569778c9813ab9c129
> Author: Qi Zheng <zhengqi.arch@bytedance.com>
> Date:   Thu May 19 14:08:55 2022 -0700
>       mm: fix missing handler for __GFP_NOWARN
> 
> +Qi could you please fix it?
> 
> At the very least the local gfpflags should not alter the global
> failslab.attr that is persistent and shared by all tasks.

Oh, It indeed shouldn't alter the global failslab.attr, I'll fix it.

But a warning should not be printed for callers that currently specify
__GFP_NOWARN, because that could lead to deadlocks, such as the deadlock
case mentioned in commit 6b9dbedbe349 ("tty: fix deadlock caused by 
calling printk() under tty_port->lock").

Thanks,
Qi

> 
> But I am not sure if we really don't want to issue the fault injection
> stack in this case. It's not a WARNING, it's merely an information
> message. It looks useful in all cases, even with GFP_NOWARN. Why
> should it be suppressed?
> 
> 
>> Once that is fixed we can quickly explain why the socketpair() example
>> in the docs shows success ret codes in the middle of the sweep when
>> run on syzkaller kernels
>>
>> fail_nth interacts badly with other kernel features typically enabled
>> in syzkaller kernels. Eg it fails in hidden kmemleak instrumentation:
>>
>> [   18.499559] FAULT_INJECTION: forcing a failure.
>> [   18.499559] name failslab, interval 1, probability 0, space 0, times 0
>> [   18.499720] CPU: 10 PID: 386 Comm: iommufd_fail_nt Not tainted 6.1.0-rc3+ #34
>> [   18.499826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> [   18.499971] Call Trace:
>> [   18.500010]  <TASK>
>> [   18.500048]  show_stack+0x3d/0x3f
>> [   18.500114]  dump_stack_lvl+0x92/0xbd
>> [   18.500171]  dump_stack+0x15/0x17
>> [   18.500232]  should_fail.cold+0x5/0xa
>> [   18.500291]  __should_failslab+0xb6/0x100
>> [   18.500349]  should_failslab+0x9/0x20
>> [   18.500416]  kmem_cache_alloc+0x64/0x4e0
>> [   18.500477]  ? __create_object+0x40/0xc50
>> [   18.500539]  __create_object+0x40/0xc50
>> [   18.500620]  ? kasan_poison+0x3a/0x50
>> [   18.500690]  ? kasan_unpoison+0x28/0x50
>> [***18.500753]  kmemleak_alloc+0x24/0x30
>> [   18.500816]  __kmem_cache_alloc_node+0x1de/0x400
>> [   18.500900]  ? iopt_alloc_area_pages+0x95/0x560 [iommufd]
>> [   18.500993]  kmalloc_trace+0x26/0x110
>> [   18.501059]  iopt_alloc_area_pages+0x95/0x560 [iommufd]
>>
>> Which has the consequence of syzkaller wasting half its fail_nth
>> effort because it is triggering failures in hidden instrumentation
>> that has no impact on the main code path.
>>
>> Maybe a kmem_cache_alloc_no_fault_inject() would be helpful for a few
>> cases.
>>
>> Jason

-- 
Thanks,
Qi
