Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0197205649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgFWPtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 11:49:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55208 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732942AbgFWPtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:49:00 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnlAP-0004f7-D1; Tue, 23 Jun 2020 15:48:57 +0000
Date:   Tue, 23 Jun 2020 17:48:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, lxc-devel@lists.linuxcontainers.org,
        cgroups@vger.kernel.org
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Virtual Linux Plumbers 2020 (24-28 August): Containers and
 Checkpoint/Restore microconference CFP Open until 20 July
Message-ID: <20200623154856.cjuhrh3f4uel7ek2@wittgenstein>
References: <20200604220637.d4ccmcsswi2ppniw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604220637.d4ccmcsswi2ppniw@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:06:39AM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> We're happy to announce that the Container and Checkpoint/Restore
> microconference (MC) has been accepted as part of Linux Plumber's again!
> The Containers and Checkpoint/Restore MC at Linux Plumbers is the opportunity
> for kernel developers, runtime maintainers, and generally everyone working on
> containers and related technologies to talk about what they are up to and agree
> on the next major changes to kernel and userspace.

I'm happy to announce that the dates for virtual LPC will be Monday, 24
August to Friday, 28 August! Once I have the final registration details
I will resend this mail with all info included.

Don't forget to hand in your proposals!

Thanks!
Christian

> 
> As we have already done the last years, the micro-conference also covers topic
> of the Checkpoint-Restore micro-conference.
> 
> Please note that LPC 2020 was originally set to be held in Halifax, Nova
> Scotia, Canada but has been moved to a virtual event in light of recent events.
> Please see our organizing comittee's blog on the Plumber's website [1]
> for more information.
> 
> We expect to time limit presentations/demos to 15 minutes including questions.
> More open ended discussion topics will get up to 30 minutes allocated.
> 
> In the spirit of a Plumber's microconference we especially appreciate topics
> pitching new ideas and features people have been thinking about. This is also
> the time to talk about your favorite kernel- or userspace problems. If you have
> a proposal how to solve them or if you just want to gather input and ideas from
> other developers this is the right place.
> 
> Here are some ideas for topics:
> 
> System call filtering and interception
> Hardware enforced container isolation
> New seccomp features
> New cgroup features
> Handling cgroup v1 on cgroup v2 only hosts and vica versa
> Performance improvement for containers (following Spectre/Meltdown mitigation)
> Time namespacing
> CGroupV2 developments
> LSM, IMA, EVM, keyrings inside containers
> UID shifting filesystem (shiftfs)
> New mount API
> New pidfd API
> New clone3 syscall
> CRIU integration with container engines and orchestration frameworks
> (In)stability of less commonly used kernel ABIs
> Checkpoint/Restore performance improvements
> Improving the state of userfaultfd and its adoption in container runtimes
> Speeding up container live migration
> Extending and virtualizing procfs
> Restricting path resolution
> Android containers and containers on Android
> Container Auditing and Monitoring
> Cgroups and Containers with Real-Time Scheduling
> 
> Some of those are ideas in search of an acceptable solution, some are problems
> likely to affect all container runtimes some are coverage of very recent
> kernel work and how that can be used by userspace, and some are proposed kernel
> patches that need in-person discussion. This list is not meant to be
> exhaustive. If you have other ideas or work to discuss, please apply! Keep in
> mind both kernel- and userspace topics are acceptable!
> 
> Please make your proposals on the Linux Plumber's website selecting the
> Containers and Checkpoint/Restore MC as the Track you're submitting at:
> 
> https://linuxplumbersconf.org/event/7/abstracts/
> 
> We’ll accept proposals for this micro-conference until the 20 of July 2020.
> 
> This year’s edition of the micro-conference is organized and run by:
> 
> Christian Brauner (Canonical Ltd.)
> Stéphane Graber (Canonical Ltd.)
> Mike Rapoport (IBM)
> 
> [1]: https://www.linuxplumbersconf.org/blog/2020/linux-plumbers-conference-2020-goes-virtual/
> 
