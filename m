Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9F1B0FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgDTPTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:19:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgDTPTr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:19:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E61B931B;
        Mon, 20 Apr 2020 08:19:46 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A373F73D;
        Mon, 20 Apr 2020 08:19:44 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:19:42 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200420151941.47ualxul5seqwdgh@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200414182152.GB20442@darkstar>
 <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/20/20 10:24, Dietmar Eggemann wrote:
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index ad5b88a53c5a..0272ae8c6147 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
> >>  		.mode		= 0644,
> >>  		.proc_handler	= sysctl_sched_uclamp_handler,
> >>  	},
> >> +	{
> >> +		.procname	= "sched_rt_default_util_clamp_min",
> 
> root@h960:~# find / -name "*util_clamp*"
> /proc/sys/kernel/sched_rt_default_util_clamp_min
> /proc/sys/kernel/sched_util_clamp_max
> /proc/sys/kernel/sched_util_clamp_min
> 
> IMHO, keeping the common 'sched_util_clamp_' would be helpful here, e.g.
> 
> /proc/sys/kernel/sched_util_clamp_rt_default_min

All RT related knobs are prefixed with 'sched_rt'. I kept the 'util_clamp_min'
coherent with the current sysctl (sched_util_clamp_min). Quentin suggested
adding 'default' to be more obvious, so I ended up with

	'sched_rt' + '_default' + '_util_clamp_min'.

I think this is the logical and most consistent form. Given that Patrick seems
to be okay with the 'default' now, does this look good to you too?

Thanks

--
Qais Yousef
