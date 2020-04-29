Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050A31BE2F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgD2PlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 11:41:04 -0400
Received: from foss.arm.com ([217.140.110.172]:41282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgD2PlD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FFF1045;
        Wed, 29 Apr 2020 08:41:02 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3649F3F68F;
        Wed, 29 Apr 2020 08:41:00 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:40:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200429154056.bznhs6wc2iyxzevy@e107158-lin>
References: <20200428164134.5588-1-qais.yousef@arm.com>
 <20200429113255.GA19464@codeaurora.org>
 <20200429123056.otyedhljlugyf5we@e107158-lin>
 <20200429152106.GB19464@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429152106.GB19464@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/29/20 20:51, Pavan Kondeti wrote:
> As we are copying the sysctl_sched_uclamp_util_min_rt_default value into
> p->uclamp_req[UCLAMP_MIN], user gets it when sched_getattr() is called though
> sched_setattr() was not called before. I guess that is expected behavior with
> your definition of this new tunable. Thanks for answering the question in
> detail.

Yes. That's the original design without this patch actually. Though before it
was always set to 1024.

Thanks for having a look!

--
Qais Yousef
