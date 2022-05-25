Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E35346CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 00:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiEYWrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiEYWrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 18:47:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A77A5022;
        Wed, 25 May 2022 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zTHfoX9TSPcy2hmQdtAdnc6/MO7f3k11kecuaslvHFA=; b=ZIDrlEVBMsTaoENrr8G2TQTER7
        zwFtwyM8ZAB9HJK8yhV0lYljCxaBn7/iPV1/nd2ZUMjlRuJ3sSKDt2S25lddcOomvMwaXPjtPw617
        devPs6PIClnHRjMmqQqh3BMrYc504MxWPjVY+jdPiAEEva589KW9pHi1G4Q3NaqIxXKw3nTC6GUPG
        JvMeIqFGqjQ13sBsispsARvlR95v8hy7UzjxEJZateAswvdqk0tiAdRGpAzsU13Fl4bB6pyEFQMLl
        trppN22dgHjuSdzhCZMUfhIpvQGQeSJg3H5PTMY9W/VNuvxfW6imOKDyp5UlVdVTzLe9AYdsNKLqr
        oqOHc8yg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntzmU-00CuZc-58; Wed, 25 May 2022 22:47:06 +0000
Date:   Wed, 25 May 2022 15:47:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Ni <nizhen@uniontech.com>,
        Baisong Zhong <zhongbaisong@huawei.com>,
        tangmeng <tangmeng@uniontech.com>,
        sujiaxun <sujiaxun@uniontech.com>,
        zhanglianjie <zhanglianjie@uniontech.com>,
        Wei Xiao <xiaowei66@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yan Zhu <zhuyan34@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        liaohua <liaohua4@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vasily Averin <vvs@openvz.org>, yingelin <yingelin@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v5.19-rc1
Message-ID: <Yo6x6uatAbdsn0JJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

Nothing exciting at all here, nothing except more cleanup to the kernel/sysctl.c
kitchen sink. This all goes tested on linux-next for a while. Without 0-day
this would have been painful.

Thanks a lot to the Uniontech and Huawei folks for doing some of this
nasty work.

Let me know if how I list possible merge conflicts works well, or if
you might have another preferred way. I'm thinking about a possible way
to later isolate those and use an optional git resolver for addressing
merge conflicts automatically. Such tactics could use some of the
metadata somehow on these emails, but *how* should we express this in
a pull request? And would there be a way (perhaps b4?) to query for
possible merge conflicts on a pull request?

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-5.19-rc1

for you to fetch changes up to 494dcdf46e5cdee926c9f441d37e3ea1db57d1da:

  sched: Fix build warning without CONFIG_SYSCTL (2022-05-09 16:54:57 -0700)

----------------------------------------------------------------
sysctl changes for v5.19-rc1

For two kernel releases now kernel/sysctl.c has been being cleaned up
slowly, since the tables were grossly long, sprinkled with tons of #ifdefs and
all this caused merge conflicts with one susbystem or another.

This tree was put together to help try to avoid conflicts with these cleanups
going on different trees at time. So nothing exciting on this pull request,
just cleanups.

I actually had this sysctl-next tree up since v5.18 but I missed sending a
pull request for it on time during the last merge window. And so these changes
have been being soaking up on sysctl-next and so linux-next for a while.
The last change was merged May 4th.

Most of the compile issues were reported by 0day and fixed.

To help avoid a conflict with bpf folks at Daniel Borkmann's request
I merged bpf-next/pr/bpf-sysctl into sysctl-next to get the effor which
moves the BPF sysctls from kernel/sysctl.c to BPF core.

Possible merge conflicts and known resolutions as per linux-next:

bfp:
https://lkml.kernel.org/r/20220414112812.652190b5@canb.auug.org.au

rcu:
https://lkml.kernel.org/r/20220420153746.4790d532@canb.auug.org.au

powerpc:
https://lkml.kernel.org/r/20220520154055.7f964b76@canb.auug.org.au

----------------------------------------------------------------
Baisong Zhong (1):
      sched/rt: fix build error when CONFIG_SYSCTL is disable

Luis Chamberlain (4):
      Merge remote-tracking branch 'bpf-next/pr/bpf-sysctl' into sysctl-next
      ftrace: fix building with SYSCTL=n but DYNAMIC_FTRACE=y
      mm: fix unused variable kernel warning when SYSCTL=n
      ftrace: fix building with SYSCTL=y but DYNAMIC_FTRACE=n

Meng Tang (1):
      fs/proc: Introduce list_for_each_table_entry for proc sysctl

Vasily Averin (1):
      sysctl: minor cleanup in new_dir()

Wei Xiao (1):
      ftrace: move sysctl_ftrace_enabled to ftrace.c

Yan Zhu (1):
      bpf: Move BPF sysctls from kernel/sysctl.c to BPF core

YueHaibing (3):
      ftrace: Fix build warning
      reboot: Fix build warning without CONFIG_SYSCTL
      sched: Fix build warning without CONFIG_SYSCTL

Zhen Ni (8):
      sched: Move child_runs_first sysctls to fair.c
      sched: Move schedstats sysctls to core.c
      sched: Move rt_period/runtime sysctls to rt.c
      sched: Move deadline_period sysctls to deadline.c
      sched: Move rr_timeslice sysctls to rt.c
      sched: Move uclamp_util sysctls to core.c
      sched: Move cfs_bandwidth_slice sysctls to fair.c
      sched: Move energy_aware sysctls to topology.c

liaohua (1):
      latencytop: move sysctl to its own file

sujiaxun (1):
      mm: move oom_kill sysctls to their own file

tangmeng (6):
      kernel/reboot: move reboot sysctls to its own file
      kernel/lockdep: move lockdep sysctls to its own file
      kernel/panic: move panic sysctls to its own file
      kernel/acct: move acct sysctls to its own file
      kernel/delayacct: move delayacct sysctls to its own file
      kernel/do_mount_initrd: move real_root_dev sysctls to its own file

yingelin (1):
      kernel/kexec_core: move kexec_core sysctls into its own file

zhanglianjie (1):
      mm: move page-writeback sysctls to their own file

 fs/proc/proc_sysctl.c        |  89 +++++-----
 include/linux/acct.h         |   1 -
 include/linux/delayacct.h    |   3 -
 include/linux/ftrace.h       |   3 -
 include/linux/initrd.h       |   2 -
 include/linux/latencytop.h   |   3 -
 include/linux/lockdep.h      |   4 -
 include/linux/oom.h          |   4 -
 include/linux/panic.h        |   6 -
 include/linux/reboot.h       |   4 -
 include/linux/sched/sysctl.h |  41 -----
 include/linux/writeback.h    |  15 --
 init/do_mounts_initrd.c      |  22 ++-
 kernel/acct.c                |  22 ++-
 kernel/bpf/syscall.c         |  87 ++++++++++
 kernel/delayacct.c           |  22 ++-
 kernel/kexec_core.c          |  22 +++
 kernel/latencytop.c          |  41 +++--
 kernel/locking/lockdep.c     |  35 +++-
 kernel/panic.c               |  26 ++-
 kernel/rcu/rcu.h             |   2 +
 kernel/reboot.c              |  34 +++-
 kernel/sched/core.c          | 130 ++++++++++-----
 kernel/sched/deadline.c      |  42 ++++-
 kernel/sched/fair.c          |  32 +++-
 kernel/sched/rt.c            |  63 ++++++-
 kernel/sched/sched.h         |   7 +
 kernel/sched/topology.c      |  25 ++-
 kernel/sysctl.c              | 379 -------------------------------------------
 kernel/trace/ftrace.c        | 101 +++++++-----
 mm/oom_kill.c                |  38 ++++-
 mm/page-writeback.c          | 104 ++++++++++--
 32 files changed, 774 insertions(+), 635 deletions(-)
