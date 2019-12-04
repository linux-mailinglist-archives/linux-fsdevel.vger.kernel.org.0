Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21C112169
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLDC1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 21:27:16 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51553 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfLDC1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:27:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TjrT8lt_1575426430;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjrT8lt_1575426430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Dec 2019 10:27:10 +0800
Subject: Re: [PATCH v3 2/2] sched/numa: documentation for per-cgroup numa
 statistics
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
        Randy Dunlap <rdunlap@infradead.org>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <d295141d-e1bf-10f5-a489-a7055ca6d509@linux.alibaba.com>
 <20191203064321.56ad316f@lwn.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <44fa7e1f-906a-4b19-c194-52dee92e7d83@linux.alibaba.com>
Date:   Wed, 4 Dec 2019 10:27:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203064321.56ad316f@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/12/3 下午9:43, Jonathan Corbet wrote:
> On Tue, 3 Dec 2019 14:02:18 +0800
[snip]
>> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
>> new file mode 100644
>> index 000000000000..49167db36f37
>> --- /dev/null
>> +++ b/Documentation/admin-guide/cg-numa-stat.rst
>> @@ -0,0 +1,176 @@
>> +===============================
>> +Per-cgroup NUMA statistics
>> +===============================
> 
> One small request: can we get an SPDX line at the beginning of that new
> file?

Certainly, will be in next version :-)

Regards,
Michael Wang

> 
> Thanks,
> 
> jon
> 
