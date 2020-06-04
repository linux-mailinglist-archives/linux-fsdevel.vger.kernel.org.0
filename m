Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82A1EEDA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFDWGn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 4 Jun 2020 18:06:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDWGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:06:43 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgy0U-0001Oq-MK; Thu, 04 Jun 2020 22:06:38 +0000
Date:   Fri, 5 Jun 2020 00:06:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, lxc-devel@lists.linuxcontainers.org,
        cgroups@vger.kernel.org
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Virtual Linux Plumbers 2020: Containers and Checkpoint/Restore
 microconference CFP Open until 20 July
Message-ID: <20200604220637.d4ccmcsswi2ppniw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

We're happy to announce that the Container and Checkpoint/Restore
microconference (MC) has been accepted as part of Linux Plumber's again!
The Containers and Checkpoint/Restore MC at Linux Plumbers is the opportunity
for kernel developers, runtime maintainers, and generally everyone working on
containers and related technologies to talk about what they are up to and agree
on the next major changes to kernel and userspace.

As we have already done the last years, the micro-conference also covers topic
of the Checkpoint-Restore micro-conference.

Please note that LPC 2020 was originally set to be held in Halifax, Nova
Scotia, Canada but has been moved to a virtual event in light of recent events.
Please see our organizing comittee's blog on the Plumber's website [1]
for more information.

We expect to time limit presentations/demos to 15 minutes including questions.
More open ended discussion topics will get up to 30 minutes allocated.

In the spirit of a Plumber's microconference we especially appreciate topics
pitching new ideas and features people have been thinking about. This is also
the time to talk about your favorite kernel- or userspace problems. If you have
a proposal how to solve them or if you just want to gather input and ideas from
other developers this is the right place.

Here are some ideas for topics:

System call filtering and interception
Hardware enforced container isolation
New seccomp features
New cgroup features
Handling cgroup v1 on cgroup v2 only hosts and vica versa
Performance improvement for containers (following Spectre/Meltdown mitigation)
Time namespacing
CGroupV2 developments
LSM, IMA, EVM, keyrings inside containers
UID shifting filesystem (shiftfs)
New mount API
New pidfd API
New clone3 syscall
CRIU integration with container engines and orchestration frameworks
(In)stability of less commonly used kernel ABIs
Checkpoint/Restore performance improvements
Improving the state of userfaultfd and its adoption in container runtimes
Speeding up container live migration
Extending and virtualizing procfs
Restricting path resolution
Android containers and containers on Android
Container Auditing and Monitoring
Cgroups and Containers with Real-Time Scheduling

Some of those are ideas in search of an acceptable solution, some are problems
likely to affect all container runtimes some are coverage of very recent
kernel work and how that can be used by userspace, and some are proposed kernel
patches that need in-person discussion. This list is not meant to be
exhaustive. If you have other ideas or work to discuss, please apply! Keep in
mind both kernel- and userspace topics are acceptable!

Please make your proposals on the Linux Plumber's website selecting the
Containers and Checkpoint/Restore MC as the Track you're submitting at:

https://linuxplumbersconf.org/event/7/abstracts/

We’ll accept proposals for this micro-conference until the 20 of July 2020.

This year’s edition of the micro-conference is organized and run by:

Christian Brauner (Canonical Ltd.)
Stéphane Graber (Canonical Ltd.)
Mike Rapoport (IBM)

[1]: https://www.linuxplumbersconf.org/blog/2020/linux-plumbers-conference-2020-goes-virtual/

