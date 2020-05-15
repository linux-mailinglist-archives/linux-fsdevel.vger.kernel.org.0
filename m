Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED4B1D48EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEOI4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:56:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbgEOI4y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:56:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBAF970E520CAE57BCD2;
        Fri, 15 May 2020 16:56:51 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 16:56:44 +0800
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
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
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
 <202005150103.6DD6F07@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <b72e0721-d08a-0fef-f55d-eb854483d04f@huawei.com>
Date:   Fri, 15 May 2020 16:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005150103.6DD6F07@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/15 16:04, Kees Cook wrote:
> On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
>> Move hung_task sysctl interface to hung_task_sysctl.c.
>> Use register_sysctl() to register the sysctl interface to avoid
>> merge conflicts when different features modify sysctl.c at the same time.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   include/linux/sched/sysctl.h |  8 +----
>>   kernel/Makefile              |  4 ++-
>>   kernel/hung_task.c           |  6 ++--
>>   kernel/hung_task.h           | 21 ++++++++++++
>>   kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Why a separate file? That ends up needing changes to Makefile, the
> creation of a new header file, etc. Why not just put it all into
> hung_task.c directly?
> 
> -Kees
> 
But Luis Chamberlain's suggestion is to put the hung_task sysctl code in 
a separate file. Details are in https://lkml.org/lkml/2020/5/13/762.
I am a little confused, not sure which way is better.

Thanks
Xiaoming Ni




