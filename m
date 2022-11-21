Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C256318CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 04:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKUDJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 22:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:09:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248411163;
        Sun, 20 Nov 2022 19:09:31 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFshb75ldzqSYY;
        Mon, 21 Nov 2022 11:05:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:09:28 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:09:28 +0800
Message-ID: <c97d4819-a1aa-b8ad-523a-d60cf3a149fb@huawei.com>
Date:   Mon, 21 Nov 2022 11:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
 <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
 <679d8f0c-f8cc-d43e-5467-c32a78bcb850@huawei.com>
 <d99630ed-0753-da9e-ab03-848b66bc3c63@huawei.com>
 <YxuXqF63RIMstdEN@bombadil.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YxuXqF63RIMstdEN@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis and Andrew，

As the c6833e10008f （"memory tiering: rate limit NUMA migration 
throughput"),

has been merged into linux v6.1-rc1, there is no conflict about this 
patch, could

anyone help to pick it up, thanks.

On 2022/9/10 3:44, Luis Chamberlain wrote:
> On Fri, Sep 09, 2022 at 11:37:41AM +0800, Kefeng Wang wrote:
>> On 2022/9/9 9:46, Kefeng Wang wrote:
>>> On 2022/9/9 8:06, Luis Chamberlain wrote:
>>>> On Thu, Sep 08, 2022 at 03:25:31PM +0800, Kefeng Wang wrote:
>>>>> The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
>>>>> are part of sched, move them to its own file.
>>>>>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> There is quite a bit of random cleanup on each kernel release
>>>> for sysctls to do things like what you just did. Because of this it
>>>> has its
>>>> own tree to help avoid conflicts. Can you base your patches on the
>>>> sysctl-testing branch here and re-submit:
>>> Found this when reading memory tiering code，sure to re-submit based
>>> your branch,
>>>
>>> thanks.
>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing
>>>>
>> Hi Luis，the numa_balancing_promote_rate_limit_MBps from commit 1db91dd846e0
>> “memory tiering: rate limit NUMA migration throughput”only on
>> linux-next（from mm repo），
>>
>> 1）only send sysctl_numa_balancing changes based on your branch
>> or
>>
>> 2）queued this patch from mm repo if no objection， Cc'ed Andrew
>>
>> Which one do your like, or other options, thanks.
> 2) as that would give more testing to the new code as well. We can deal
> with merge conflicts on my tree later.
>    Luis
> .
