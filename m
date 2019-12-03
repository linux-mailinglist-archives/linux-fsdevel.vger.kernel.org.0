Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86A110FF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLCNnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 08:43:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:52306 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCNnX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:43:23 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34620737;
        Tue,  3 Dec 2019 13:43:22 +0000 (UTC)
Date:   Tue, 3 Dec 2019 06:43:21 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 2/2] sched/numa: documentation for per-cgroup numa
 statistics
Message-ID: <20191203064321.56ad316f@lwn.net>
In-Reply-To: <d295141d-e1bf-10f5-a489-a7055ca6d509@linux.alibaba.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
        <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
        <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
        <d295141d-e1bf-10f5-a489-a7055ca6d509@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 3 Dec 2019 14:02:18 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> Add the description for 'numa_locality', also a new doc to explain
> the details on how to deal with the per-cgroup numa statistics.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  Documentation/admin-guide/cg-numa-stat.rst      | 176 ++++++++++++++++++++++++
>  Documentation/admin-guide/index.rst             |   1 +
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>  include/linux/sched.h                           |  10 +-
>  init/Kconfig                                    |   4 +-
>  kernel/sched/fair.c                             |   4 +-
>  7 files changed, 200 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
> 
> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
> new file mode 100644
> index 000000000000..49167db36f37
> --- /dev/null
> +++ b/Documentation/admin-guide/cg-numa-stat.rst
> @@ -0,0 +1,176 @@
> +===============================
> +Per-cgroup NUMA statistics
> +===============================

One small request: can we get an SPDX line at the beginning of that new
file?

Thanks,

jon
