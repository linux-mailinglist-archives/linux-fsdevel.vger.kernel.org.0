Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438301E842B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Q5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:57:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2Q5q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2AA8DAC2C;
        Fri, 29 May 2020 16:57:44 +0000 (UTC)
Date:   Fri, 29 May 2020 17:57:39 +0100
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
Message-ID: <20200529165739.GD3070@suse.de>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <20200529160423.qsrbzxtcx2jslljk@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200529160423.qsrbzxtcx2jslljk@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > A lot of the uclamp functions appear to be inlined so it is not be
> > particularly obvious from a raw profile but it shows up in the annotated
> > profile in activate_task and dequeue_task for example. In the case of
> > dequeue_task, uclamp_rq_dec_id() is extremely expensive according to the
> > annotated profile.
> > 
> > I'm afraid I did not dig into this deeply once I knew I could just disable
> > it even within the distribution.
> 
> Could by any chance the vmlinux (with debug symbols hopefully) and perf.dat are
> still lying around to share?
> 

I didn't preserve the vmlinux files. I can recreate them if you have
problems reproducing this locally. The "perf archive" files and profile
data can be downloaded at
http://www.skynet.ie/~mel/postings/netperf-20200529/profile.tar.gz which
should be enough for an annotated profile to compare with a local run.

-- 
Mel Gorman
SUSE Labs
