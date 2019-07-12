Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852DB66AC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfGLKKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 06:10:33 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34277 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfGLKKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:10:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWhPUDd_1562926224;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWhPUDd_1562926224)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 18:10:25 +0800
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
 <20190712094214.GR3402@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
Date:   Fri, 12 Jul 2019 18:10:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712094214.GR3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/12 下午5:42, Peter Zijlstra wrote:
> On Fri, Jul 12, 2019 at 05:11:25PM +0800, 王贇 wrote:
>>
>>
>> On 2019/7/12 下午3:58, Peter Zijlstra wrote:
>> [snip]
>>>>>
>>>>> Then our task t1 should be accounted to B (as you do), but also to A and
>>>>> R.
>>>>
>>>> I get the point but not quite sure about this...
>>>>
>>>> Not like pages there are no hierarchical limitation on locality, also tasks
>>>
>>> You can use cpusets to affect that.
>>
>> Could you please give more detail on this?
> 
> Documentation/cgroup-v1/cpusets.txt
> 
> Look for mems_allowed.

This is the attribute belong to cpuset cgroup isn't it?

Forgive me but I have no idea on how to combined this
with memory cgroup's locality hierarchical update...
parent memory cgroup do not have influence on mems_allowed
to it's children, correct?

What about we just account the locality status of child
memory group into it's ancestors?

Regards,
Michael Wang

> 
