Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB936E8E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfGSQjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 12:39:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727577AbfGSQjj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D338AF9C;
        Fri, 19 Jul 2019 16:39:37 +0000 (UTC)
Date:   Fri, 19 Jul 2019 18:39:31 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        Peter Zijlstra <peterz@infradead.org>, mhocko@kernel.org,
        Ingo Molnar <mingo@redhat.com>, keescook@chromium.org,
        mcgrof@kernel.org, linux-mm@kvack.org,
        Hillf Danton <hdanton@sina.com>, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] numa: append per-node execution time in
 cpu.numa_stat
Message-ID: <20190719163930.GA854@blackbody.suse.cz>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
 <6973a1bf-88f2-b54e-726d-8b7d95d80197@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6973a1bf-88f2-b54e-726d-8b7d95d80197@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:40:35AM +0800, 王贇  <yun.wang@linux.alibaba.com> wrote:
> By doing 'cat /sys/fs/cgroup/cpu/CGROUP_PATH/cpu.numa_stat', we see new
> output line heading with 'exectime', like:
> 
>   exectime 311900 407166
What you present are times aggregated over CPUs in the NUMA nodes, this
seems a bit lossy interface. 

Despite you the aggregated information is sufficient for your
monitoring, I think it's worth providing the information with the
original granularity.

Note that cpuacct v1 controller used to report such percpu runtime
stats. The v2 implementation would rather build upon the rstat API.

Michal

