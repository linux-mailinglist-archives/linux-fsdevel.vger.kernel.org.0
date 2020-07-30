Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7851C233490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgG3OhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:37:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45166 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3OhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:37:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k19gF-003nnq-GV; Thu, 30 Jul 2020 08:37:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k19gE-0001gQ-FG; Thu, 30 Jul 2020 08:37:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
Date:   Thu, 30 Jul 2020 09:34:01 -0500
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
        (Kirill Tkhai's message of "Thu, 30 Jul 2020 14:59:20 +0300")
Message-ID: <87k0yl5axy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k19gE-0001gQ-FG;;;mid=<87k0yl5axy.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188Ng0JHQbtMeUDccLOcHjnG7hC3w0b/NA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 671 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 11 (1.6%), parse: 1.63
        (0.2%), extract_message_metadata: 22 (3.2%), get_uri_detail_list: 6
        (0.9%), tests_pri_-1000: 17 (2.6%), tests_pri_-950: 1.65 (0.2%),
        tests_pri_-900: 1.38 (0.2%), tests_pri_-90: 107 (15.9%), check_bayes:
        105 (15.6%), b_tokenize: 17 (2.5%), b_tok_get_all: 10 (1.6%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 69 (10.3%), b_finish: 1.01
        (0.1%), tests_pri_0: 494 (73.6%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to expose namespaces lineary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> Currently, there is no a way to list or iterate all or subset of namespaces
> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> but some also may be as open files, which are not attached to a process.
> When a namespace open fd is sent over unix socket and then closed, it is
> impossible to know whether the namespace exists or not.
>
> Also, even if namespace is exposed as attached to a process or as open file,
> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> this multiplies at tasks and fds number.

I am very dubious about this.

I have been avoiding exactly this kind of interface because it can
create rather fundamental problems with checkpoint restart.

You do have some filtering and the filtering is not based on current.
Which is good.

A view that is relative to a user namespace might be ok.    It almost
certainly does better as it's own little filesystem than as an extension
to proc though.

The big thing we want to ensure is that if you migrate you can restore
everything.  I don't see how you will be able to restore these files
after migration.  Anything like this without having a complete
checkpoint/restore story is a non-starter.

Further by not going through the processes it looks like you are
bypassing the existing permission checks.  Which has the potential
to allow someone to use a namespace who would not be able to otherwise.

So I think this goes one step too far but I am willing to be persuaded
otherwise.

Eric




> This patchset introduces a new /proc/namespaces/ directory, which exposes
> subset of permitted namespaces in linear view:
>
> # ls /proc/namespaces/ -l
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'
>
> Namespace ns is exposed, in case of its user_ns is permitted from /proc's pid_ns.
> I.e., /proc is related to pid_ns, so in /proc/namespace we show only a ns, which is
>
> 	in_userns(pid_ns->user_ns, ns->user_ns).
>
> In case of ns is a user_ns:
>
> 	in_userns(pid_ns->user_ns, ns).
>
> The patchset follows this steps:
>
> 1)A generic counter in ns_common is introduced instead of separate
>   counters for every ns type (net::count, uts_namespace::kref,
>   user_namespace::count, etc). Patches [1-8];
> 2)Patch [9] introduces IDR to link and iterate alive namespaces;
> 3)Patch [10] is refactoring;
> 4)Patch [11] actually adds /proc/namespace directory and fs methods;
> 5)Patches [12-23] make every namespace to use the added methods
>   and to appear in /proc/namespace directory.
>
> This may be usefull to write effective debug utils (say, fast build
> of networks topology) and checkpoint/restore software.
> ---
>
> Kirill Tkhai (23):
>       ns: Add common refcount into ns_common add use it as counter for net_ns
>       uts: Use generic ns_common::count
>       ipc: Use generic ns_common::count
>       pid: Use generic ns_common::count
>       user: Use generic ns_common::count
>       mnt: Use generic ns_common::count
>       cgroup: Use generic ns_common::count
>       time: Use generic ns_common::count
>       ns: Introduce ns_idr to be able to iterate all allocated namespaces in the system
>       fs: Rename fs/proc/namespaces.c into fs/proc/task_namespaces.c
>       fs: Add /proc/namespaces/ directory
>       user: Free user_ns one RCU grace period after final counter put
>       user: Add user namespaces into ns_idr
>       net: Add net namespaces into ns_idr
>       pid: Eextract child_reaper check from pidns_for_children_get()
>       proc_ns_operations: Add can_get method
>       pid: Add pid namespaces into ns_idr
>       uts: Free uts namespace one RCU grace period after final counter put
>       uts: Add uts namespaces into ns_idr
>       ipc: Add ipc namespaces into ns_idr
>       mnt: Add mount namespaces into ns_idr
>       cgroup: Add cgroup namespaces into ns_idr
>       time: Add time namespaces into ns_idr
>
>
>  fs/mount.h                     |    4 
>  fs/namespace.c                 |   14 +
>  fs/nsfs.c                      |   78 ++++++++
>  fs/proc/Makefile               |    1 
>  fs/proc/internal.h             |   18 +-
>  fs/proc/namespaces.c           |  382 +++++++++++++++++++++++++++-------------
>  fs/proc/root.c                 |   17 ++
>  fs/proc/task_namespaces.c      |  183 +++++++++++++++++++
>  include/linux/cgroup.h         |    6 -
>  include/linux/ipc_namespace.h  |    3 
>  include/linux/ns_common.h      |   11 +
>  include/linux/pid_namespace.h  |    4 
>  include/linux/proc_fs.h        |    1 
>  include/linux/proc_ns.h        |   12 +
>  include/linux/time_namespace.h |   10 +
>  include/linux/user_namespace.h |   10 +
>  include/linux/utsname.h        |   10 +
>  include/net/net_namespace.h    |   11 -
>  init/version.c                 |    2 
>  ipc/msgutil.c                  |    2 
>  ipc/namespace.c                |   17 +-
>  ipc/shm.c                      |    1 
>  kernel/cgroup/cgroup.c         |    2 
>  kernel/cgroup/namespace.c      |   25 ++-
>  kernel/pid.c                   |    2 
>  kernel/pid_namespace.c         |   46 +++--
>  kernel/time/namespace.c        |   20 +-
>  kernel/user.c                  |    2 
>  kernel/user_namespace.c        |   23 ++
>  kernel/utsname.c               |   23 ++
>  net/core/net-sysfs.c           |    6 -
>  net/core/net_namespace.c       |   18 +-
>  net/ipv4/inet_timewait_sock.c  |    4 
>  net/ipv4/tcp_metrics.c         |    2 
>  34 files changed, 746 insertions(+), 224 deletions(-)
>  create mode 100644 fs/proc/task_namespaces.c
>
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
