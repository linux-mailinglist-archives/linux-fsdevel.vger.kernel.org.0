Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2611217A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDCiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 21:38:19 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47670 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfLDCiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:38:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TjrTZNw_1575427089;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjrTZNw_1575427089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Dec 2019 10:38:13 +0800
Subject: Re: [PATCH v3 1/2] sched/numa: introduce per-cgroup NUMA locality
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
 <2398e8a4-a3ad-3660-3aba-298730d209b2@linux.alibaba.com>
 <d5f109b8-be26-c025-1d6d-ec3b3354c4b1@infradead.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <fa116746-cc1f-4e32-fc4c-b64bddce26c2@linux.alibaba.com>
Date:   Wed, 4 Dec 2019 10:38:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d5f109b8-be26-c025-1d6d-ec3b3354c4b1@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/12/4 上午10:33, Randy Dunlap wrote:
> On 12/2/19 10:00 PM, 王贇 wrote:
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 4d8d145c41d2..9c086f716a6d 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>>  	  machine.
>>
>> +config CGROUP_NUMA_LOCALITY
>> +	bool "The per-cgroup NUMA Locality"
> 
> I would drop "The".
> 
>> +	default n
>> +	depends on CGROUP_SCHED && NUMA_BALANCING
>> +	help
>> +	  This option enable the collection of per-cgroup NUMA locality info,
> 
> 	              enables

Will fix them in next version too~

Regards,
Michael Wang


> 
>> +	  to tell whether NUMA Balancing is working well for a particular
>> +	  workload.
>> +
>>  menuconfig CGROUPS
>>  	bool "Control Group support"
>>  	select KERNFS
> 
> 
