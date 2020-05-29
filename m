Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118141E8319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgE2QGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:06:03 -0400
Received: from foss.arm.com ([217.140.110.172]:38738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgE2QGD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:06:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653E21063;
        Fri, 29 May 2020 09:06:02 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07923F718;
        Fri, 29 May 2020 09:05:59 -0700 (PDT)
Date:   Fri, 29 May 2020 17:05:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
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
Message-ID: <20200529160556.bessfi6wblvl572d@e107158-lin>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
 <20200529102125.GB3070@suse.de>
 <20200529151118.mnysa7jv4l3ntzsk@e107158-lin.cambridge.arm.com>
 <20200529160210.GC3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529160210.GC3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/29/20 17:02, Mel Gorman wrote:
> On Fri, May 29, 2020 at 04:11:18PM +0100, Qais Yousef wrote:
> > > Elsewhere in the thread, I showed some results based on 5.7 so uclamp
> > > task group existed but I had it disabled. The uclamp related parts of
> > > the kconfig were
> > > 
> > > # zgrep UCLAMP kconfig-5.7.0-rc7-with-clamp.txt.gz
> > > CONFIG_UCLAMP_TASK=y
> > > CONFIG_UCLAMP_BUCKETS_COUNT=5
> > > # CONFIG_UCLAMP_TASK_GROUP is not set
> > 
> > So you never had the TASK_GROUP part enabled when you noticed the regression?
> 
> Correct.
> 
> > Or is it the other way around, you just disabled CONFIG_UCLAMP_TASK_GROUP to
> > 'fix' it?
> > 
> 
> I disabled CONFIG_UCLAMP_TASK to "fix" it.

Okay. That eliminates one thing out at least.

Thanks

--
Qais Yousef
