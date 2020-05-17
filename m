Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A41D656C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgEQDCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 23:02:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbgEQDCB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 23:02:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DB29A34692D8E1137C3;
        Sun, 17 May 2020 11:01:59 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sun, 17 May 2020
 11:01:52 +0800
Subject: Re: [PATCH v2 3/4] hung_task: Move hung_task sysctl interface to
 hung_task.c
To:     Kees Cook <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <peterz@infradead.org>, <mingo@kernel.org>,
        <patrick.bellasi@arm.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <wangle6@huawei.com>,
        <akpm@linux-foundation.org>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-4-git-send-email-nixiaoming@huawei.com>
 <202005161942.682497BF@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <7ab9ac85-2b60-623f-e585-f6bb95500c38@huawei.com>
Date:   Sun, 17 May 2020 11:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005161942.682497BF@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/17 10:43, Kees Cook wrote:
> On Sat, May 16, 2020 at 04:55:14PM +0800, Xiaoming Ni wrote:
>> +/*
>> + * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
>> + * and hung_task_check_interval_secs
>> + */
>> +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
> 
> Please make this const. With that done, yes, looks great!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thank you for your guidance, I will fix it in v3

In addition, I am a bit confused about the patch submission, and hope to 
get everyone's answer.
   I made this patch based on the master branch. But as in conflict at 
https://lkml.org/lkml/2020/5/10/413, my patch will inevitably conflict. 
Should I modify to make patch based on "linux-next" branch to avoid 
conflict, or other branches?

Thanks
Xiaoming Ni

