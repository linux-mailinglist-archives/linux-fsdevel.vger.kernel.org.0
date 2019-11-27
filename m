Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9097E10AA6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 06:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0FyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 00:54:20 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42135 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfK0FyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:54:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TjCTZdE_1574834051;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjCTZdE_1574834051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Nov 2019 13:54:11 +0800
Subject: Re: [PATCH v2 3/3] sched/numa: documentation for per-cgroup numa stat
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <cc35a710-c2ec-6c61-e30e-ee707798c5e9@linux.alibaba.com>
 <9ce01935-84ba-e8b4-461b-8be388433950@infradead.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <7169fba4-220f-a4a7-d6e7-0f025a3cd308@linux.alibaba.com>
Date:   Wed, 27 Nov 2019 13:54:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9ce01935-84ba-e8b4-461b-8be388433950@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Randy

On 2019/11/27 下午12:58, Randy Dunlap wrote:
> On 11/26/19 5:50 PM, 王贇 wrote:
>> Since v1:
>>   * thanks to Iurii for the better sentence
>>   * thanks to Jonathan for the better format
>>
>> Add the description for 'cg_numa_stat', also a new doc to explain
>> the details on how to deal with the per-cgroup numa statistics.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Michal Koutný <mkoutny@suse.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Iurii Zaikin <yzaikin@google.com>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> Hi,
> I have a few comments/corrections. Please see below.

Thanks for the comments :-) will apply them all in next version.

> 
>> ---
>>  Documentation/admin-guide/cg-numa-stat.rst      | 163 
[snip]
>> +if you want to have the whole history.
>> +
>> +We have per-task migfailed counter to tell how many page migration has been
> 
> I can't find any occurrence of 'migfailed' in the entire kernel source tree.
> Maybe it is misspelled?

This one is added by the secondary patch:
  [PATCH v2 2/3] sched/numa: expose per-task pages-migration-failure

As suggested by Mel.

Regards,
Michael Wang

> 
>> +failed for a particular task, you will find it in /proc/PID/sched entry.
> 
> 
> HTH.
> 
