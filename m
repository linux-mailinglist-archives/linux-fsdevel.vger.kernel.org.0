Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8639E1550B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 03:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGCbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 21:31:20 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55564 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgBGCbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:31:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TpJAGI8_1581042674;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpJAGI8_1581042674)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Feb 2020 10:31:15 +0800
Subject: Re: [PATCH v8 0/2] sched/numa: introduce numa locality
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
 <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
 <a95a7e05-ad60-b9ee-ca39-f46c8e08887d@linux.alibaba.com>
 <b9249375-fe8c-034e-c3bd-cacfe4e89658@linux.alibaba.com>
 <3b2c5a07-4bc0-1feb-2daf-260e4d58c7b6@linux.alibaba.com>
 <20200206202504.7175c4a8@oasis.local.home>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <c721b898-4826-9073-e80e-0730dcc18ecf@linux.alibaba.com>
Date:   Fri, 7 Feb 2020 10:31:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206202504.7175c4a8@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/7 上午9:25, Steven Rostedt wrote:
> On Fri, 7 Feb 2020 09:10:33 +0800
> 王贇 <yun.wang@linux.alibaba.com> wrote:
> 
>> Hi, Peter, Ingo
>>
>> Could you give some comments please?
> 
> A little word of advice. When sending new versions of a patch. Don't
> send them as a reply to the previous version. Some developers (and I
> believe Peter is one of them), wont look for new patches in threads,
> and this may never be seen by him.
> 
> New versions of patches (v8 in this case) need to start a new thread
> and be at the top level. It's hard to manage patches when a thread
> series in embedded in another thread series.

Aha, I do believe that's the situation...

I'll resend the v8 with the Ack from Randy, thanks for the advice :-)

Regards,
Michael Wang

> 
> -- Steve
> 
