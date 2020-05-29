Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25C1E7A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2KWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:22:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgE2KVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:21:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 569FFB117;
        Fri, 29 May 2020 10:21:31 +0000 (UTC)
Date:   Fri, 29 May 2020 11:21:25 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200529102125.GB3070@suse.de>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:
> > Indeed, that one. The fact that regular distros cannot enable this
> > feature due to performance overhead is unfortunate. It means there is a
> > lot less potential for this stuff.
> 
> I had a humble try to catch the overhead but wasn't successful. The observation
> wasn't missed by us too then.
> 

As with all things, it's perfectly possible I was looking at a workload
where the cost is more obvious but given that the functions are inlined,
it's not trivial to spot. I just happened to spot it because I was paying
close attention to try_to_wake_up() at the time.

> On my Ubuntu 18.04 machine uclamp is enabled by default by the way. 5.3 kernel
> though, so uclamp task group stuff not there yet. Should check how their server
> distro looks like.
> 

Elsewhere in the thread, I showed some results based on 5.7 so uclamp
task group existed but I had it disabled. The uclamp related parts of
the kconfig were

# zgrep UCLAMP kconfig-5.7.0-rc7-with-clamp.txt.gz
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# CONFIG_UCLAMP_TASK_GROUP is not set

-- 
Mel Gorman
SUSE Labs
