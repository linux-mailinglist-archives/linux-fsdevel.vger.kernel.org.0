Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0B61E889
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 03:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKGCNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 21:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKGCNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:13:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55CDF4F
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Nov 2022 18:13:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d20so8762247plr.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Nov 2022 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNSZaDqkDmOKFIdw/uAhWINagc9alQJMfiOqpPFcM5o=;
        b=x8SfS9NWlXhZAv9nG4ReOG/x/cGNkiA45r5Dy8ti6SlSfg5L/qOA6hoeu7ik5K9a6e
         q8FU3QLdl56CKg3Sjvc+vyxGLdfWXqfXzMs89c41LnNaICN6VZqXutYZYIxXFFM+24i7
         5jBiIzBt3PvoIMQi06gTRjJi+jSaRH8aj9tUfRR3d05IzS0R+Oi3xJUcJGlcAmawjkyo
         VN0i7n1os7M3GrbV0vVSJw9KRslc9ASBiM8T8/2ufIfYHo5I6FpVF2FVDMmd+3fXyojk
         9sBfmqb8910F/x2c4zkX8HrCfwcNG8PfjbKxckh/AnMYXytceRS73SyvBDfVXqSPQwjx
         Tgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNSZaDqkDmOKFIdw/uAhWINagc9alQJMfiOqpPFcM5o=;
        b=M1FcybnwZXN45mL3DqnvAcGQwowCsj+H7wZaV93CwcKRe+h6APuN33ajyxH18ppXL3
         IruYx0Fqk9kCqcjoXTXMv+FmBmcMTIO80qRqFeZ0VOqgOo0wq2i0tsQ+G5wgl7JKqArK
         9dL1qVD+TR70OiV22KqfyWCLNHWHYe2LX52zmE2ASUssTMthwuBSYDNEo6H4xTBmxtvd
         +DjYN9O+Ebmf+2muuvC/+evh88u1xqBPOrrViBsY0dgPPj5Cvj5i3uauJUFFBnO7i5u9
         WAK0fD6SN1E3FUBqSkjiRWt5PrElh3OCFG+gW8VkYAKtxYFwDAnGGUjRLBPaZAyY+CCx
         J1BA==
X-Gm-Message-State: ACrzQf2KiIc1fUIoFe5FvRUXmy0769ZwjJb9uO7AjJsRSCXYpshhI6xb
        clTo0yStigq1Q+eQBlMZocsxhQ==
X-Google-Smtp-Source: AMsMyM6Hi8C+M7eiT/cl3dP1fyarzKAQu/h9fK+Jp7wca1jzBHskj70rB55zsUY+hevclt7iufaXJw==
X-Received: by 2002:a17:902:ce8a:b0:186:9d96:b93c with SMTP id f10-20020a170902ce8a00b001869d96b93cmr49654816plg.123.1667787186706;
        Sun, 06 Nov 2022 18:13:06 -0800 (PST)
Received: from [10.255.93.192] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e5c700b00174d9bbeda4sm3711005plf.197.2022.11.06.18.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 18:13:06 -0800 (PST)
Message-ID: <509df2a5-6d85-4a09-616a-59b83096c95a@bytedance.com>
Date:   Mon, 7 Nov 2022 10:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: xarray, fault injection and syzkaller
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
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
 <6e33dd02-99b0-0899-aed5-07f770340a74@bytedance.com>
 <be6a67b0-479f-db0a-fa69-764713135d70@bytedance.com>
 <CACT4Y+Zc21Aj+5KjeTEsvOysJGHRYDSKgu_+_xN1LUYfG_H0sg@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CACT4Y+Zc21Aj+5KjeTEsvOysJGHRYDSKgu_+_xN1LUYfG_H0sg@mail.gmail.com>
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



On 2022/11/7 01:36, Dmitry Vyukov wrote:
> On Sat, 5 Nov 2022 at 05:16, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> On 2022/11/5 02:21, Dmitry Vyukov wrote:
>>>> On Fri, 4 Nov 2022 at 11:03, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>
>>>>> On Fri, Nov 04, 2022 at 10:47:17AM -0700, Dmitry Vyukov wrote:
>>>>>>>> Do we know how common/useful such an allocation pattern is?
>>>>>>>
>>>>>>> I have coded something like this a few times, in my cases it is
>>>>>>> usually something like: try to allocate a big chunk of memory hoping
>>>>>>> for a huge page, then fall back to a smaller allocation
>>>>>>>
>>>>>>> Most likely the key consideration is that the callsites are using
>>>>>>> GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
>>>>>>> NOWARN case assuming that another allocation attempt will closely
>>>>>>> follow?
>>>>>>
>>>>>> GFP_NOWARN is also extensively used for allocations with
>>>>>> user-controlled size, e.g.:
>>>>>> https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451
>>>>>>
>>>>>> That's different and these allocations are usually not repeated.
>>>>>> So looking at GFP_NOWARN does not look like the right thing to do.
>>>>>
>>>>> This may be the best option then, arguably perhaps even more
>>>>> "realistic" than normal fail_nth as in a real system if this stuff
>>>>> starts failing there is a good chance things from then on will fail
>>>>> too during the error cleanup.
>>>>>
>>>>>>> However, this would also have to fix the obnoxious behavior of fail
>>>>>>> nth where it fails its own copy_from_user on its write system call -
>>>>>>> meaning there would be no way to turn it off.
>>>>>>
>>>>>> Oh, interesting. We added failing of copy_from/to_user later and did
>>>>>> not consider such interaction.
>>>>>> Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.
>>>>>
>>>>> Oh, I will tell you the other two bugish things I noticed
>>>>>
>>>>> __should_failslab() has this:
>>>>>
>>>>>           if (gfpflags & __GFP_NOWARN)
>>>>>                   failslab.attr.no_warn = true;
>>>>>
>>>>>           return should_fail(&failslab.attr, s->object_size);
>>>>>
>>>>> Which always permanently turns off no_warn for slab during early
>>>>> boot. This is why syzkaller reports are so confusing. They trigger a
>>>>> slab fault injection, which in all other cases gives a notification
>>>>> backtrace, but in slab cases there is no hint about the fault
>>>>> injection in the log.
>>>>
>>>> Ouch, this looks like a bug in:
>>>>
>>>> commit 3f913fc5f9745613088d3c569778c9813ab9c129
>>>> Author: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Date:   Thu May 19 14:08:55 2022 -0700
>>>>        mm: fix missing handler for __GFP_NOWARN
>>>>
>>>> +Qi could you please fix it?
>>>>
>>>> At the very least the local gfpflags should not alter the global
>>>> failslab.attr that is persistent and shared by all tasks.
>>>
>>> Oh, It indeed shouldn't alter the global failslab.attr, I'll fix it.
>>
>> How about the following changes? If it's ok, I will send this fix patch.
>> Thanks. :)
> 
> I think the interface design question is mostly to Akinobu as fault
> injection maintainer.
> 
>> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
>> index 9f6e25467844..b61a3fb7a2a3 100644
>> --- a/include/linux/fault-inject.h
>> +++ b/include/linux/fault-inject.h
>> @@ -20,7 +20,6 @@ struct fault_attr {
>>           atomic_t space;
>>           unsigned long verbose;
>>           bool task_filter;
>> -       bool no_warn;
>>           unsigned long stacktrace_depth;
>>           unsigned long require_start;
>>           unsigned long require_end;
>> @@ -40,12 +39,12 @@ struct fault_attr {
>>                   .ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,       \
>>                   .verbose = 2,                                           \
>>                   .dname = NULL,                                          \
>> -               .no_warn = false,                                       \
>>           }
>>
>>    #define DECLARE_FAULT_ATTR(name) struct fault_attr name =
>> FAULT_ATTR_INITIALIZER
>>    int setup_fault_attr(struct fault_attr *attr, char *str);
>>    bool should_fail(struct fault_attr *attr, ssize_t size);
>> +bool should_fail_gfp(struct fault_attr *attr, ssize_t size, gfp_t
>> gfpflags);
>>
>>    #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>>
>> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
>> index 4b8fafce415c..95af50832770 100644
>> --- a/lib/fault-inject.c
>> +++ b/lib/fault-inject.c
>> @@ -41,9 +41,6 @@ EXPORT_SYMBOL_GPL(setup_fault_attr);
>>
>>    static void fail_dump(struct fault_attr *attr)
>>    {
>> -       if (attr->no_warn)
>> -               return;
>> -
>>           if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
>>                   printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
>>                          "name %pd, interval %lu, probability %lu, "
>> @@ -98,12 +95,7 @@ static inline bool fail_stacktrace(struct fault_attr
>> *attr)
>>
>>    #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
>>
>> -/*
>> - * This code is stolen from failmalloc-1.0
>> - * http://www.nongnu.org/failmalloc/
>> - */
>> -
>> -bool should_fail(struct fault_attr *attr, ssize_t size)
>> +bool should_fail_check(struct fault_attr *attr, ssize_t size)
>>    {
>>           bool stack_checked = false;
>>
>> @@ -118,7 +110,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>>                           fail_nth--;
>>                           WRITE_ONCE(current->fail_nth, fail_nth);
>>                           if (!fail_nth)
>> -                               goto fail;
>> +                               return true;
>>
>>                           return false;
>>                   }
>> @@ -151,7 +143,19 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>>           if (attr->probability <= get_random_u32_below(100))
>>                   return false;
>>
>> -fail:
>> +       return true;
>> +}
>> +
>> +/*
>> + * This code is stolen from failmalloc-1.0
>> + * http://www.nongnu.org/failmalloc/
>> + */
>> +
>> +bool should_fail(struct fault_attr *attr, ssize_t size)
>> +{
>> +       if (!should_fail_check(attr, size))
>> +               return false;
>> +
>>           fail_dump(attr);
>>
>>           if (atomic_read(&attr->times) != -1)
>> @@ -161,6 +165,21 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>>    }
>>    EXPORT_SYMBOL_GPL(should_fail);
>>
>> +bool should_fail_gfp(struct fault_attr *attr, ssize_t size, gfp_t gfpflags)
>> +{
>> +       if (!should_fail_check(attr, size))
>> +               return false;
>> +
>> +       if (!(gfpflags & __GFP_NOWARN))
>> +               fail_dump(attr);
>> +
>> +       if (atomic_read(&attr->times) != -1)
>> +               atomic_dec_not_zero(&attr->times);
>> +
>> +       return true;
>> +}
>> +EXPORT_SYMBOL_GPL(should_fail_gfp);
> 
> should_fail/should_fail_gfp duplicate some code + gfp is slab-specific
> (while clumsy to use for other fault injection types + we won't be
> able to pass any runtime flags that are not present in gfp). So I
> would go either with:
> 
> bool should_fail(struct fault_attr *attr, ssize_t size, bool nowarn);
> 
> or even more extensible interface would be:
> 
> enum fault_flags {
>    fault_nowarn = 1 << 0,
> };
> 
> bool should_fail(struct fault_attr *attr, ssize_t size, fault_flags flags);
> 
> And if we don't want to change all callers to avoid code duplication:
> 
> bool should_fail_ex(struct fault_attr *attr, ssize_t size, fault_flags flags);
> bool should_fail(struct fault_attr *attr, ssize_t size) {
>    return should_fail_ex(attr, size, 0);
> }

This looks better to me, I will revise and resend this fix patch later.

Thanks,
Qi

> 
> 
> 
>>    #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>>
>>    static int debugfs_ul_set(void *data, u64 val)
>> diff --git a/mm/failslab.c b/mm/failslab.c
>> index 58df9789f1d2..21338b256791 100644
>> --- a/mm/failslab.c
>> +++ b/mm/failslab.c
>> @@ -30,10 +30,7 @@ bool __should_failslab(struct kmem_cache *s, gfp_t
>> gfpflags)
>>           if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
>>                   return false;
>>
>> -       if (gfpflags & __GFP_NOWARN)
>> -               failslab.attr.no_warn = true;
>> -
>> -       return should_fail(&failslab.attr, s->object_size);
>> +       return should_fail_gfp(&failslab.attr, s->object_size, gfpflags);
>>    }
>>
>>    static int __init setup_failslab(char *str)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7192ded44ad0..4e70b5599ada 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3912,10 +3912,7 @@ static bool __should_fail_alloc_page(gfp_t
>> gfp_mask, unsigned int order)
>>                           (gfp_mask & __GFP_DIRECT_RECLAIM))
>>                   return false;
>>
>> -       if (gfp_mask & __GFP_NOWARN)
>> -               fail_page_alloc.attr.no_warn = true;
>> -
>> -       return should_fail(&fail_page_alloc.attr, 1 << order);
>> +       return should_fail_gfp(&fail_page_alloc.attr, 1 << order, gfp_mask);
>>    }
>>
>>    #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>>
>>>
>>> But a warning should not be printed for callers that currently specify
>>> __GFP_NOWARN, because that could lead to deadlocks, such as the deadlock
>>> case mentioned in commit 6b9dbedbe349 ("tty: fix deadlock caused by
>>> calling printk() under tty_port->lock").
>>>
>>> Thanks,
>>> Qi
>>>
>>>>
>>>> But I am not sure if we really don't want to issue the fault injection
>>>> stack in this case. It's not a WARNING, it's merely an information
>>>> message. It looks useful in all cases, even with GFP_NOWARN. Why
>>>> should it be suppressed?
>>>>
>>>>
>>>>> Once that is fixed we can quickly explain why the socketpair() example
>>>>> in the docs shows success ret codes in the middle of the sweep when
>>>>> run on syzkaller kernels
>>>>>
>>>>> fail_nth interacts badly with other kernel features typically enabled
>>>>> in syzkaller kernels. Eg it fails in hidden kmemleak instrumentation:
>>>>>
>>>>> [   18.499559] FAULT_INJECTION: forcing a failure.
>>>>> [   18.499559] name failslab, interval 1, probability 0, space 0,
>>>>> times 0
>>>>> [   18.499720] CPU: 10 PID: 386 Comm: iommufd_fail_nt Not tainted
>>>>> 6.1.0-rc3+ #34
>>>>> [   18.499826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>>>>> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>>>> [   18.499971] Call Trace:
>>>>> [   18.500010]  <TASK>
>>>>> [   18.500048]  show_stack+0x3d/0x3f
>>>>> [   18.500114]  dump_stack_lvl+0x92/0xbd
>>>>> [   18.500171]  dump_stack+0x15/0x17
>>>>> [   18.500232]  should_fail.cold+0x5/0xa
>>>>> [   18.500291]  __should_failslab+0xb6/0x100
>>>>> [   18.500349]  should_failslab+0x9/0x20
>>>>> [   18.500416]  kmem_cache_alloc+0x64/0x4e0
>>>>> [   18.500477]  ? __create_object+0x40/0xc50
>>>>> [   18.500539]  __create_object+0x40/0xc50
>>>>> [   18.500620]  ? kasan_poison+0x3a/0x50
>>>>> [   18.500690]  ? kasan_unpoison+0x28/0x50
>>>>> [***18.500753]  kmemleak_alloc+0x24/0x30
>>>>> [   18.500816]  __kmem_cache_alloc_node+0x1de/0x400
>>>>> [   18.500900]  ? iopt_alloc_area_pages+0x95/0x560 [iommufd]
>>>>> [   18.500993]  kmalloc_trace+0x26/0x110
>>>>> [   18.501059]  iopt_alloc_area_pages+0x95/0x560 [iommufd]
>>>>>
>>>>> Which has the consequence of syzkaller wasting half its fail_nth
>>>>> effort because it is triggering failures in hidden instrumentation
>>>>> that has no impact on the main code path.
>>>>>
>>>>> Maybe a kmem_cache_alloc_no_fault_inject() would be helpful for a few
>>>>> cases.
>>>>>
>>>>> Jason
>>>
>>
>> --
>> Thanks,
>> Qi
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/be6a67b0-479f-db0a-fa69-764713135d70%40bytedance.com.

-- 
Thanks,
Qi
