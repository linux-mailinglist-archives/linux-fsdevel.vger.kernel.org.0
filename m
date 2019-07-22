Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603B96F739
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfGVCgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 22:36:51 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60214 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728559AbfGVCgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:36:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TXSIFIJ_1563763005;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TXSIFIJ_1563763005)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jul 2019 10:36:46 +0800
Subject: Re: [PATCH v2 2/4] numa: append per-node execution time in
 cpu.numa_stat
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        Peter Zijlstra <peterz@infradead.org>, mhocko@kernel.org,
        Ingo Molnar <mingo@redhat.com>, keescook@chromium.org,
        mcgrof@kernel.org, linux-mm@kvack.org,
        Hillf Danton <hdanton@sina.com>, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
 <6973a1bf-88f2-b54e-726d-8b7d95d80197@linux.alibaba.com>
 <20190719163930.GA854@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <08280b56-edc1-288a-d38d-1c8bf8b988a7@linux.alibaba.com>
Date:   Mon, 22 Jul 2019 10:36:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719163930.GA854@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/20 上午12:39, Michal Koutný wrote:
> On Tue, Jul 16, 2019 at 11:40:35AM +0800, 王贇  <yun.wang@linux.alibaba.com> wrote:
>> By doing 'cat /sys/fs/cgroup/cpu/CGROUP_PATH/cpu.numa_stat', we see new
>> output line heading with 'exectime', like:
>>
>>   exectime 311900 407166
> What you present are times aggregated over CPUs in the NUMA nodes, this
> seems a bit lossy interface. 
> 
> Despite you the aggregated information is sufficient for your
> monitoring, I think it's worth providing the information with the
> original granularity.

As Peter suggested previously, kernel do not report jiffies to user anymore
and 'ms' could be better, I guess usually we care about how much the percentage
is on a particular node?

> 
> Note that cpuacct v1 controller used to report such percpu runtime
> stats. The v2 implementation would rather build upon the rstat API.

Support cgroup v2 is on the plan :-) let's mark this as todo currently,
i suppose they may not share the same piece of code.

Regards,
Michael Wang

> 
> Michal
> 
