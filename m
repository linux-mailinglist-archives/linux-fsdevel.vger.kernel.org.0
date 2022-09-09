Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3485B2CFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 05:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIIDhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 23:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIIDhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:37:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A7E291E;
        Thu,  8 Sep 2022 20:37:43 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP1n84tHNzmVM4;
        Fri,  9 Sep 2022 11:34:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 11:37:42 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 11:37:41 +0800
Message-ID: <d99630ed-0753-da9e-ab03-848b66bc3c63@huawei.com>
Date:   Fri, 9 Sep 2022 11:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
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
In-Reply-To: <679d8f0c-f8cc-d43e-5467-c32a78bcb850@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022/9/9 9:46, Kefeng Wang wrote:
>
> On 2022/9/9 8:06, Luis Chamberlain wrote:
>> On Thu, Sep 08, 2022 at 03:25:31PM +0800, Kefeng Wang wrote:
>>> The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
>>> are part of sched, move them to its own file.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> There is quite a bit of random cleanup on each kernel release
>> for sysctls to do things like what you just did. Because of this it 
>> has its
>> own tree to help avoid conflicts. Can you base your patches on the
>> sysctl-testing branch here and re-submit:
>
> Found this when reading memory tiering code，sure to re-submit based 
> your branch,
>
> thanks.
>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing 
>>
Hi Luis，the numa_balancing_promote_rate_limit_MBps from commit 1db91dd846e0
“memory tiering: rate limit NUMA migration throughput”only on 
linux-next（from mm repo），

1）only send sysctl_numa_balancing changes based on your branch
or

2）queued this patch from mm repo if no objection， Cc'ed Andrew

Which one do your like, or other options, thanks.

>>
>> If testing goes fine, then I'd move this to sysctl-next which linux-next
>> picks up for yet more testing.
>>
>> Are scheduling folks OK with this patch and me picking it up on the
>> sysctl-next tree if all tests are a go?
>>
>>    Luis
>> .
