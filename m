Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94631113AA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 04:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfLEDwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 22:52:47 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44924 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbfLEDwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:52:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Tk0Ttie_1575517957;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tk0Ttie_1575517957)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Dec 2019 11:52:38 +0800
Subject: Re: [PATCH v4 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <89416266-0a06-ce1c-1d78-11171f0c80b8@linux.alibaba.com>
 <fde5d43b-447d-1b54-1bad-3a5d67e6c1f2@infradead.org>
 <c757f282-e89c-78f6-71cd-1273d2624429@infradead.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <2b1fde95-9d50-b03b-1cd7-de7001f4fe56@linux.alibaba.com>
Date:   Thu, 5 Dec 2019 11:52:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c757f282-e89c-78f6-71cd-1273d2624429@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/12/5 上午11:29, Randy Dunlap wrote:
> On 12/4/19 7:28 PM, Randy Dunlap wrote:
>> Hi,
>>
>> It seems that you missed my previous comments...
>>
>>
>> On 12/3/19 11:59 PM, 王贇 wrote:
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 4d8d145c41d2..fb7182a0d017 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>>>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>>>  	  machine.
>>>
>>> +config CGROUP_NUMA_LOCALITY
>>> +	bool "The per-cgroup NUMA Locality"
>>
>> Drop "The"
>>
>>> +	default n
>>> +	depends on CGROUP_SCHED && NUMA_BALANCING
>>> +	help
>>> +	  This option enable the collection of per-cgroup NUMA locality info,
>>
>> 	              enables
>>
>>> +	  to tell whether NUMA Balancing is working well for a particular
>>> +	  workload, also imply the NUMA efficiency.
>>> +
>>>  menuconfig CGROUPS
>>>  	bool "Control Group support"
>>>  	select KERNFS
>>
>>
>> thanks.
>>
> 
> Ah, the changes are in patch 2/2/ for some reason.  OK, thanks.

My bad, let's move them to 1/2 then, also will apply the comments you sent
for 2/2 in next version ;-)

Regards,
Michael Wang

> 
