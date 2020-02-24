Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC60A169C8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 04:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBXDN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 22:13:58 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51963 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgBXDN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:13:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TqhetfV_1582514031;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TqhetfV_1582514031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Feb 2020 11:13:53 +0800
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
 <20200217141616.GB3420@suse.de>
 <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
 <20200221142010.GT3420@suse.de>
 <20200221154706.GI18400@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <9b3fc96e-d705-1b30-da3d-e85ad5549da3@linux.alibaba.com>
Date:   Mon, 24 Feb 2020 11:13:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221154706.GI18400@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/21 下午11:47, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 02:20:10PM +0000, Mel Gorman wrote:
>> I fully acknowledge that this may have value for sysadmins and may be a
>> good enough reason to merge it for environments that typically build and
>> configure their own kernels. I doubt that general distributions would
>> enable it but that's a guess.
> 
> OTOH, many sysadmins seem to 'rely' on BPF scripts and other such fancy
> things these days.
> 
>  ( of course, we have the open question on what happens when we break
>    one of those BPF 'important' scripts ... )
> 
> My main reservation with this patch is that it exposes, to userspace, an
> ABI that is very hard to interpret and subject to implementation
> details.
> 
> So while it can be disabled; people who have it enabled might suddenly
> complain when we change the meaning/interpretation/whatever of these
> magic numbers.
> 
> Michael; you seem to have ignored the tracepoint / BPF angle earlier in
> this discussion; that is not something that could/would work for you?

At very beginning I think these fancy stuff may consume too much resources
them selves, so just as you said, ignored the possibility :-P

But now I understand there is a big gap here, which require a much more general
way to evaluate the NUMA platform, I'll try to follow this way see if there
are any practical approach instead~

Regards,
Michael Wang

> 
