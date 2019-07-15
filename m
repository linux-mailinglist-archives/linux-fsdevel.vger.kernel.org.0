Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A520A6889D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfGOMKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 08:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729827AbfGOMKb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:10:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D765AF0B;
        Mon, 15 Jul 2019 12:10:30 +0000 (UTC)
Date:   Mon, 15 Jul 2019 14:10:25 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com, mcgrof@kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, riel@surriel.com,
        Mel Gorman <mgorman@suse.de>, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
Message-ID: <20190715121025.GN9035@blackbody.suse.cz>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
 <20190712094214.GR3402@hirez.programming.kicks-ass.net>
 <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Yun.

On Fri, Jul 12, 2019 at 06:10:24PM +0800, 王贇  <yun.wang@linux.alibaba.com> wrote:
> Forgive me but I have no idea on how to combined this
> with memory cgroup's locality hierarchical update...
> parent memory cgroup do not have influence on mems_allowed
> to it's children, correct?
I'd recommend to look at the v2 of the cpuset controller that implements
the hierarchical behavior among configured memory node sets.

(My comment would better fit to 
    [PATCH 3/4] numa: introduce numa group per task group
IIUC, you could use cpuset controller to constraint memory nodes.)

For the second part (accessing numa statistics, i.e. this patch), I
wonder wheter this information wouldn't be better presented under the
cpuset controller too.

HTH,
Michal
