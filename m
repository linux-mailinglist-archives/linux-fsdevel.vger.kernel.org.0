Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1E1D5E12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEPDGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:06:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbgEPDGG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:06:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C817AA0CD6132F8330D;
        Sat, 16 May 2020 11:06:04 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 11:05:54 +0800
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
To:     Kees Cook <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
 <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
 <202005150904.743BB3E52@keescook>
 <ab5f75d4-4d69-7b95-e6bd-ba8fd9792d94@huawei.com>
 <202005151946.C6335E92@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <2656ae51-5348-0b37-d76d-1460b8eb3f10@huawei.com>
Date:   Sat, 16 May 2020 11:05:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005151946.C6335E92@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/16 10:47, Kees Cook wrote:
> On Sat, May 16, 2020 at 10:32:19AM +0800, Xiaoming Ni wrote:
>> On 2020/5/16 0:05, Kees Cook wrote:
>>> On Fri, May 15, 2020 at 05:06:28PM +0800, Xiaoming Ni wrote:
>>>> On 2020/5/15 16:06, Kees Cook wrote:
>>>>> On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
>>>>>> Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
>>>>>> used in both sysctl_writes_strict and hung_task_warnings.
>>>>>>
>>>>>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>>>>>> ---
>>>>>>     fs/proc/proc_sysctl.c     | 2 +-
>>>>>>     include/linux/sysctl.h    | 1 +
>>>>>>     kernel/hung_task_sysctl.c | 3 +--
>>>>>>     kernel/sysctl.c           | 3 +--
>>>>>
>>>>> How about doing this refactoring in advance of the extraction patch?
>>>> Before  advance of the extraction patch, neg_one is only used in one file,
>>>> does it seem to have no value for refactoring?
>>>
>>> I guess it doesn't matter much, but I think it's easier to review in the
>>> sense that neg_one is first extracted and then later everything else is
>>> moved.
>>>
>> Later, when more features sysctl interface is moved to the code file, there
>> will be more variables that need to be extracted.
>> So should I only extract the neg_one variable here, or should I extract all
>> the variables used by multiple features?
> 
> Hmm -- if you're going to do a consolidation pass, then nevermind, I
> don't think order will matter then.
> 
> Thank you for the cleanup! Sorry we're giving you back-and-forth advice!
> 
> -Kees
> 

Sorry, I don't fully understand.
Does this mean that there is no need to adjust the patch order or the 
order of variables in sysctl_vals?
Should I extract only SYSCTL_NEG_ONE or should I extract all variables?

Thanks
Xiaoming Ni

