Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CB1D8CF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 03:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESBNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 21:13:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgESBNz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 21:13:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4B96CBE31790CD136B6;
        Tue, 19 May 2020 09:13:48 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 09:13:42 +0800
Subject: Re: [PATCH v3 0/4] cleaning up the sysctls table (hung_task watchdog)
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <patrick.bellasi@arm.com>,
        <mingo@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <wangle6@huawei.com>,
        <alex.huangjianhui@huawei.com>
References: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
 <20200518171602.GK11244@42.do-not-panic.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <de355f61-4076-98db-b62b-77ac9e990a4b@huawei.com>
Date:   Tue, 19 May 2020 09:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200518171602.GK11244@42.do-not-panic.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/19 1:16, Luis Chamberlain wrote:
> On Mon, May 18, 2020 at 11:59:53AM +0800, Xiaoming Ni wrote:
>> Kernel/sysctl.c contains more than 190 interface files, and there are a
>> large number of config macro controls. When modifying the sysctl
>> interface directly in kernel/sysctl.c, conflicts are very easy to occur.
>> E.g: https://lkml.org/lkml/2020/5/10/413.
> 
> FWIW un the future please avoid using lkmk.org and instead use
> https://lkml.kernel.org/r/<MESSAGE-ID> for references.
> 
>> Use register_sysctl() to register the sysctl interface to avoid
>> merge conflicts when different features modify sysctl.c at the same time.
>>
>> So consider cleaning up the sysctls table, details are in:
>> 	https://kernelnewbies.org/KernelProjects/proc
>> 	https://lkml.org/lkml/2020/5/13/990
>>
>> The current patch set extracts register_sysctl_init and some sysctl_vals
>> variables, and clears the interface of hung_task and watchdog in sysctl.c.
>>
>> The current patch set is based on commit b9bbe6ed63b2b9 ("Linux 5.7-rc6"),
>> which conflicts with the latest branch of linux-next:
>> 	9b4caf6941fc41d ("kernel / hung_task.c: introduce sysctl to print
>> all traces when a hung task is detected")
>>
>> Should I modify to make patch based on the "linux-next" branch to avoid
>> conflicts, or other branches?
> 
> If you can do that, that would be appreciated. I have a sysctl fs cleanup
> stuff, so I can take your patches, and put my work ont op of yours and
> then send this to Andrew once done.
> 
>    Luis
> 
Ok, I will redo the v4 version based on the linux-next branch as soon as 
possible

I want to continue to participate in the subsequent sysctl cleanup, how 
to push the subsequent cleanup patch to your series, and minimize conflict

Thanks
Xiaoming Ni


