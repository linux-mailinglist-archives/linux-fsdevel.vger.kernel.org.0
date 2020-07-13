Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C14821D752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgGMNgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgGMNgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:36:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE84C061755;
        Mon, 13 Jul 2020 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9EMK+UYrL6jQjzlvQppNu91JO3Sh4jNLd4V1M4+eiGU=; b=dTUuatlg0KVwBCRqwtaZ2s9TzC
        1S/HjNyZfYj0F/RACCE/EfF8yeNRRyX3JpVsCeOkBljoXS5FXUnkL/FIjBK9E3s4X1QURF42QlC7p
        NGr+4XNrY5lYFQCUci4QxnnwIhzXqvMwNIVSXsERBSscAex+gjl2AKhs/ioLo6wxTZZW/kpW8Fgg5
        I6k9W19UFGSMyqxEGoaiRs2H4D/UEDYi79TrTIegUYGyJegtVlwPlSw4Np5fDb1jDyS++RYAiR1rm
        YGuXazd/Yx3LRTgX950c4nQkTEpXCb+BII+dwqc3+LOG1OMcOs5oIhIq1zBKP+yY+ZwMu2f7iuE/V
        c8ufUVgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juych-0002Nc-Oz; Mon, 13 Jul 2020 13:36:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8AD2D300F7A;
        Mon, 13 Jul 2020 15:35:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70EF820D27C6B; Mon, 13 Jul 2020 15:35:58 +0200 (CEST)
Date:   Mon, 13 Jul 2020 15:35:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200713133558.GK10769@hirez.programming.kicks-ass.net>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
 <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:12:46PM +0100, Qais Yousef wrote:
> On 07/13/20 13:21, Peter Zijlstra wrote:

> > It's monday, and I cannot get my brain working.. I cannot decipher the
> > comments you have with the smp_[rw]mb(), what actual ordering do they
> > enforce?
> 
> It was a  bit of a paranoia to ensure that readers on other cpus see the new
> value after this point.

IIUC that's not something any barrier can provide.

Barriers can only order between (at least) two memory operations:

	X = 1;		y = Y;
	smp_wmb();	smp_rmb();
	Y = 1;		x = X;

guarantees that if y == 1, then x must also be 1. Because the left hand
side orders the store of Y after the store of X, while the right hand
side order the load of X after the load of Y. Therefore, if the first
load observes the last store, the second load must observe the first
store.

Without a second variable, barriers can't guarantee _anything_. Which is
why any barrier comment should refer to at least two variables.

> > Also, your synchronize_rcu() relies on write_lock() beeing
> > non-preemptible, which isn't true on PREEMPT_RT.
> > 
> > The below seems simpler...

> Hmm maybe I am missing something obvious, but beside the race with fork; I was
> worried about another race and that's what the synchronize_rcu() is trying to
> handle.
> 
> It's the classic preemption in the middle of RMW operation race.
> 
> 		copy_process()			sysctl_uclamp
> 
> 		  sched_post_fork()
> 		    __uclamp_sync_rt()
> 		      // read sysctl
> 		      // PREEMPT
> 						  for_each_process_thread()
> 		      // RESUME
> 		      // write syctl to p
> 

> 	2. sysctl_uclamp happens *during* sched_post_fork()
> 
> There's the risk of the classic preemption in the middle of RMW where another
> CPU could have changed the shared variable after the current CPU has already
> read it, but before writing it back.

Aah.. I see.

> I protect this with rcu_read_lock() which as far as I know synchronize_rcu()
> will ensure if we do the update during this section; we'll wait for it to
> finish. New forkees entering the rcu_read_lock() section will be okay because
> they should see the new value.
> 
> spinlocks() and mutexes seemed inferior to this approach.

Well, didn't we just write in another patch that p->uclamp_* was
protected by both rq->lock and p->pi_lock?


