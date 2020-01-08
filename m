Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205E4133E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 10:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgAHJvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 04:51:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHJvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:51:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so2577101wrj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYIX5lCn201jIdgFI8cXaaFqyTSNVacx0tO+JKzdFG8=;
        b=wFe4jLFlUg6FK/9/5dItkW8JnJTzFY6w0imwJZ4kbornDo9YbT0RTpZrEXYpRk3f2+
         LbZP1U3K/1Lxn/KAIeCt9oa6+rXtwlLJqhrhfukloDcA4lwxBCaoUawe2cJnb+XvkI0s
         MsvlKQuetVXhoYv9leB4T/Ue6x3fCj4Y6ayzOo8x2ikfD7GhXK0OjdkR2PVp8RWqF6Mx
         ncaY+Spy4k/ppc6qECRxF3IKEUsaZEh9onRO5Wv99KmxM79jC+rfAkkKbPNf+EtVzlK2
         7gJ+PwLkSl+PYgIqgq+DOvQL6kh3W2L6cspPM5q43ZQiUis1/byKsxDf/j9lkw5im1Ki
         hX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYIX5lCn201jIdgFI8cXaaFqyTSNVacx0tO+JKzdFG8=;
        b=GN6963YeEvMgWsfTj4e68t8slk0v44amNEasF0tVPmCncFrMwtFuDIzd/VKbIOdaq7
         BSfsC9MSIDyN2pXQvWrzPUkchhO09zlN/ZxSg+UitqsYKXg8+XIv4KzPVinZHC3WlDUo
         jzoDwSxTM1hLoA6MZntpSkjmU09IxsyzY2vf1lw703EhvROS6NIisPmf99KIU+QUO+8k
         eVV0K6BSd1a1IzbtErCI9I3cQQfudDUm5I1lkchamZN6qlkFMkhoed7iHn6lR3jmmW9Y
         v+1oInsB8AXNmfmhMcYTvmrO65hTCGIq239Ks6UGv2XI5fz66aKM5Gbf+Lp4CbTSdmLs
         hgeg==
X-Gm-Message-State: APjAAAX8rv6eXP2g//jsK4VF6wuqtxmGC+KUhGooaSgOGcjZq3vDVICb
        c5FH7XL3GhXHLErekNZWj9YG4g==
X-Google-Smtp-Source: APXvYqwpJ/qkuF9mN7qO3XblBcRL45/iYNNTuD+IaCRUy2rP1dYfdG9lOJlJx+LEbkSUEDmE7Q8jWA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr3557559wrm.241.1578477072161;
        Wed, 08 Jan 2020 01:51:12 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id z83sm3276181wmg.2.2020.01.08.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:51:11 -0800 (PST)
Date:   Wed, 8 Jan 2020 09:51:08 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200108095108.GA153171@google.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200107134234.GA158998@google.com>
 <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 07 Jan 2020 at 20:30:36 (+0100), Dietmar Eggemann wrote:
> On 07/01/2020 14:42, Quentin Perret wrote:
> > Hi Qais,
> > 
> > On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> 
> [...]
> 
> >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >> index e591d40fd645..19572dfc175b 100644
> >> --- a/kernel/sched/rt.c
> >> +++ b/kernel/sched/rt.c
> >> @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
> >>   */
> >>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
> >>  {
> >> +	/*
> >> +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> >> +	 * we apply any new value on the next wakeup, which is here.
> >> +	 */
> >> +	uclamp_rt_sync_default_util_min(p);
> > 
> > The task has already been enqueued and sugov has been called by then I
> > think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?
> 
> That's probably better.
> Just to be sure ...we want this feature (an existing rt task gets its
> UCLAMP_MIN value set when the sysctl changes) because there could be rt
> tasks running before the sysctl is set?

Yeah, I was wondering the same thing, but I'd expect sysadmin to want
this. We could change the min clamp of existing RT tasks in userspace
instead, but given how simple Qais' lazy update code is, the in-kernel
looks reasonable to me. No strong opinion, though.

Thanks,
Quentin
