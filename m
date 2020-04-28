Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A11BC6F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgD1Rnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgD1Rng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:43:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C66C03C1AB;
        Tue, 28 Apr 2020 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=E3tpxsfqlJ97OhshENU/bqkOyW+k00vUERJl57WfGXE=; b=naNiCbki4HJTsh6kFqJ+IsEM9p
        /uJSiyc/o80OXP4HiVcr+4nkUkieBrZoqwb3OJNOotj9nCfogjq9T5I9syeUCllx4L6ZkeIcKc1cc
        qxajHmi78bYbEIFQK1rOtZOShvijGVMr98kVlJevomZa623+sJt7Ir1zYjwdqVoG+jQoZOaAU3vnE
        /DIrZRn/UMt8YfR080vEGgPx2gB5zLrRAE29fLNsK0gckGHir21jNeXNQHBkD5nKXFX41S0zyvLtg
        DKLjM5mbV7nHglbVu6DJrDBLThyf1aR25AgqxJ+sfe2pgkr2LNJ601lURnn5qiIgklYuq5vzozs1D
        ZCMFlpTA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTUGY-0002fJ-QK; Tue, 28 Apr 2020 17:43:30 +0000
Subject: Re: [PATCH v3 2/2] Documentation/sysctl: Document uclamp sysctl knobs
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200428164134.5588-1-qais.yousef@arm.com>
 <20200428164134.5588-2-qais.yousef@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e16e222b-f61b-a54a-38b2-5a63a9537333@infradead.org>
Date:   Tue, 28 Apr 2020 10:43:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428164134.5588-2-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

I have a few corrections for you below:

On 4/28/20 9:41 AM, Qais Yousef wrote:
> Uclamp exposes 3 sysctl knobs:
> 
> 	* sched_util_clamp_min
> 	* sched_util_clamp_max
> 	* sched_util_clamp_min_rt_default
> 
> Document them in sysctl/kernel.rst.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Kees Cook <keescook@chromium.org>
> CC: Iurii Zaikin <yzaikin@google.com>
> CC: Quentin Perret <qperret@google.com>
> CC: Valentin Schneider <valentin.schneider@arm.com>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> CC: Pavan Kondeti <pkondeti@codeaurora.org>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 48 +++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 0d427fd10941..e7255f71493c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -940,6 +940,54 @@ Enables/disables scheduler statistics. Enabling this feature
>  incurs a small amount of overhead in the scheduler but is
>  useful for debugging and performance tuning.
>  
> +sched_util_clamp_min:
> +=====================
> +
> +Max allowed *minimum* utilization.
> +
> +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
> +value.
> +
> +It means that any requested uclamp.min value cannot be greater than
> +sched_util_clamp_min, ie: it is restricted to the range

                         i.e., it is

> +[0:sched_util_clamp_min].
> +
> +sched_util_clamp_max:
> +=====================
> +
> +Max allowed *maximum* utilization.
> +
> +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
> +value.
> +
> +It means that any requested uclamp.max value cannot be greater than
> +sched_util_clamp_max, ie: it is restricted to the range

                         i.e., it is

> +[0:sched_util_clamp_max].
> +
> +sched_util_clamp_min_rt_default:
> +================================
> +
> +By default Linux is tuned for performance. Which means that RT tasks always run
> +at the highest frequency and most capable (highest capacity) CPU (in
> +heterogeneous systems).
> +
> +Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
> +SCHED_CAPACITY_SCALE (1024) by default. Which effectively boosts the tasks to

                               by default, which

> +run at the highest frequency and bias them to run on the biggest CPU.

                                    biases them

> +
> +This knob allows admins to change the default behavior when uclamp is being
> +used. In battery powered devices particularly, running at the maximum
> +capacity and frequency will increase energy consumption and shorten the battery
> +life.
> +
> +This knob is only effective for RT tasks which the user hasn't modified their
> +requested uclamp.min value via sched_setattr() syscall.
> +
> +This knob will not escape the constraint imposed by sched_util_clamp_min
> +defined above.
> +
> +Any modification is applied lazily on the next opportunity the scheduler needs
> +to calculate the effective value of uclamp.min of the task.
>  
>  seccomp
>  =======
> 

thanks.
-- 
~Randy

