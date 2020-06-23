Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3131E20563E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgFWPoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 11:44:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733016AbgFWPoI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:44:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82AD1F1;
        Tue, 23 Jun 2020 08:44:07 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E8153F6CF;
        Tue, 23 Jun 2020 08:44:05 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:44:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200623154402.jfv5yhhrsbx7toes@e107158-lin.cambridge.arm.com>
References: <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
 <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
 <CAKfTPtCKS-2RoaMHhKGigjzc7dhXhx0z3dYNQLD3Q9aRC_tCnw@mail.gmail.com>
 <20200611102407.vhy3zjexrhorx753@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnWuBOJxJP7ahX4Kzu+8jvPjAcE6XErMtG1SCJMdZZ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDnWuBOJxJP7ahX4Kzu+8jvPjAcE6XErMtG1SCJMdZZ-w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vincent

On 06/11/20 14:01, Vincent Guittot wrote:
> On Thu, 11 Jun 2020 at 12:24, Qais Yousef <qais.yousef@arm.com> wrote:

[...]

> > > Strange because I have been able to trace them.
> >
> > On your arm platform? I can certainly see them on x86.
> 
> yes on my arm platform

Sorry for not getting back to you earlier but I have tried several things and
shared my results, which you were CCed into all of them.

I have posted a patch that protects uclamp with a static key, mind trying it on
your platform to see if it helps you too?

https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/

Thanks

--
Qais Yousef
