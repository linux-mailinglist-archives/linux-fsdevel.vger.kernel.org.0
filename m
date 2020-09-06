Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808E125EDB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIFMRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 08:17:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:40327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgIFMRp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 08:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599394583;
        bh=fQwrab/3EerbqYpxqZ04WJLrtDjl6Vf1m279QN3M5dY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=B+kMDvblQcck9rRUDTaTgdtvW4iQHy41+nPJXh4ycqmYmxHYApQJkpCoEngQW4/jg
         bdyTElk2mt64K0pLmjwWrJuiuxpdE/JMwI996osvzZbLkTVNH/CSqAHNiagkuo/WJz
         LlPVdmClYVftqYcWbfaI6Bplj3BDvm/Gq5YmSQ1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MvsEn-1kW10D2mP9-00sttf; Sun, 06 Sep 2020 14:16:22 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 0/9] Fork brute force attack mitigation (fbfam)
Date:   Sun,  6 Sep 2020 14:15:35 +0200
Message-Id: <20200906121544.4204-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AGT3UJ3W0iU8AA373PKnhI/b31jFD58Olo8G2LzHwLpYviT9FLx
 0RgaViNVNg4BteZYzjsXQMk3VBOPeIpDWRxF+1N2PIh3CCWUW59L5viHyRqePmpC5ZkpERs
 QmNXUZYIP2vtNsk5d64jtTxcb0SHQAT80pHVRFwBwJ0bcUBGJMMsxjVqwsddQS5nwQOuZEw
 0eD5AAsrhlvg9PIN0t1iw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBp4vi39wb8=:7s6s8X49DaOj2jSXkNjw0d
 9cmCDck8v33hk/6Pv4dylLZoIS5tHnZ2DyOFEL2cwaCCVKErOR5PWK3wYQWfe7j0tn5S9bs+C
 gG6TmD3aK1rLEX4KhMnXt+nXfMfnyevRclLf1b3YuKtHvyuaBzZG1Pb0Jbdwh8ncVQi4/DDhL
 rtH6DVQgxMFxoYtYXPmoITibSQwY1S2UvX+fqsOtx6jTynAOeAe5JjvY0zgm6ndxhI8VbWZjI
 jr5GnytI+tJSbrPpB1FyV9bzdikPt1Q6SlfRYReXpPn9c+NghXDd9vb0OHupNkABo+I+P9mAp
 pYTZ2EHtmMiNlaWWIyQkkpomsx5eYo03i/fH8+1MdFF24V6Ygn/44WVNzmKFvTfFyFqzCIlJ0
 HLTTp1pKdCH/l6n4HqapqzwK0zHT8pGp+je7n8VogTtmrRUF2aXTk+zl2rkvJ5S/FO8zdeICa
 1ypuBMiq36mqQ4MfIExuEvFg+X/9LwO6AVzxFP1MKm/KHpeuvLHIt+y8Y/1X+52BIXqeNOmOd
 J6npkyIV/O8gofrBhw6htAyj83BOGIHJQrN6IOoRW4Re/G/UXj107Y7j0BEL/EKt00e8LHPQW
 Knl2wrc8IB0K2GloDmIqWilHfr5KoNIYCy5F0mg5d06L4IHiVJiNFcSrdLwTLizoHw0crye1r
 DOXakKf0rJOLs4ETcPT9xQz4praSGLlLtFjx+57pheUdxabPOli0eTwgUnqyUiU3g5oNK8xNy
 s9Vz1ywxxRYIWYNnK1ACrzrU+Bda+2imqYNwim2Avm6O+LAAT443pgdNvQuY2k4PKfuGQbQhg
 p/e6yEBAwrv1jq3C4ArKkQn0PqEBRcL6BJTXO8j5ues194JP6AQXOxafLzQy5fwRJe6AP3tDH
 4nOJa2Ws9A8IgW4P3SSFKXzgyXwHn3NjgRREEqdLDsvh/hl+5Wsvd1HOtyr2b0iVqy9ZE8NFH
 mFSAnqU03JrlpwSUeh8hV+YtqgxKkFktVMYdSzYvVrqrq5PfpuFKjgbwgy4vrLE+yamO/s+H9
 7UVGl1oTBzRQh/9SIlJtwzSUxJN3x3hmDYGZp5pueUOwbB+SmBNMcNNhxul97U4J1E09TdIXT
 EEkPM4EaidwEtPbq3ZvAJzjbgEsRJzYcTeErLxCJld/JOT9489mnRmsecShbHMBbGfYnh3qjd
 q2WETQ8KKZ3wSXTeB3Nh/yVrJg1J//eZ1LuRLjbAhIGG7jZNv8iDbPURYZzZeMsQoCqg5abJJ
 TP1u+zt7+EdCyG8bE1pV01lprcry3KqdLyQ7ZNA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of this patch serie is to detect and mitigate a fork brute force
attack.

Attacks with the purpose to break ASLR or bypass canaries traditionaly use
some level of brute force with the help of the fork system call. This is
possible since when creating a new process using fork its memory contents
are the same as those of the parent process (the process that called the
fork system call). So, the attacker can test the memory infinite times to
find the correct memory values or the correct memory addresses without
worrying about crashing the application.

Based on the above scenario it would be nice to have this detected and
mitigated, and this is the goal of this implementation.

Other implementations
=2D--------------------

The public version of grsecurity, as a summary, is based on the idea of
delay the fork system call if a child died due to a fatal error. This has
some issues:

1.- Bad practices: Add delays to the kernel is, in general, a bad idea.

2.- Weak points: This protection can be bypassed using two different
    methods since it acts only when the fork is called after a child has
    crashed.

    2.1.- Bypass 1: So, it would still be possible for an attacker to fork
	  a big amount of children (in the order of thousands), then probe
	  all of them, and finally wait the protection time before repeat
	  the steps.

    2.2.- Bypass 2: This method is based on the idea that the protection
	  doesn't act if the parent crashes. So, it would still be possible
	  for an attacker to fork a process and probe itself. Then, fork
	  the child process and probe itself again. This way, these steps
	  can be repeated infinite times without any mitigation.


This implementation
=2D------------------

The main idea behind this implementation is to improve the existing ones
focusing on the weak points annotated before. So, the solution for the
first bypass method is to detect a fast crash rate instead of only one
simple crash. For the second bypass method the solution is to detect both
the crash of parent and child processes. Moreover, as a mitigation method
it is better to kill all the offending tasks involve in the attack instead
of use delays.

So, the solution to the two bypass methods previously commented is to use
some statistical data shared across all the processes that can have the
same memory contents. Or in other words, a statistical data shared between
all the processes that fork the task 0, and all the processes that fork
after an execve system call.

These statistics hold the timestamp for the first fork (case of a fork of
task zero) or the timestamp for the execve system call (the other case).
Also, hold the number of faults of all the tasks that share the same
statistical data since the commented timestamp.

With this information it is possible to detect a brute force attack when a
task die in a fatal way computing the crashing rate. This rate shows the
milliseconds per fault and when it goes under a certain threshold there is
a clear signal that something malicious is happening.

Once detected, the mitigation only kills the processes that share the same
statistical data and so, all the tasks that can have the same memory
contents. This way, an attack is rejected.

The fbfam feature can be enabled, disabled and tuned as follows:

1.- Per system enabling: This feature can be enabled in build time using
    the config application under:

    Security options  --->  Fork brute force attack mitigation

2.- Per process enabling/disabling: To allow that specific applications ca=
n
    turn off or turn on the detection and mitigation of a fork brute force
    attack when required, there are two new prctls.

    prctl(PR_FBFAM_ENABLE, 0, 0, 0, 0)  -> To enable the feature
    prctl(PR_FBFAM_DISABLE, 0, 0, 0, 0) -> To disable the feature

    Both functions return zero on success and -EFAULT if the current task
    doesn't have statistical data.

3.- Fine tuning: To customize the detection's sensibility there is a new
    sysctl that allows to set the crashing rate threshold. It is accessibl=
e
    through the file:

    /proc/sys/kernel/fbfam/crashing_rate_threshold

    The units are in milliseconds per fault and the attack's mitigation is
    triggered if the crashing rate of an application goes under this
    threshold. So, the higher this value, the faster an attack will be
    detected.

So, knowing all this information I will explain now the different patches:

The 1/9 patch adds a new config for the fbfam feature.

The 2/9 and 3/9 patches add and use the api to manage the statistical data
necessary to compute the crashing rate of an application.

The 4/9 patch adds a new sysctl to fine tuning the detection's sensibility=
.

The 5/9 patch detects a fork brute force attack calculating the crashing
rate.

The 6/9 patch mitigates the attack killing all the offending tasks.

The 7/9 patch adds two new prctls to allow per task enabling/disabling.

The 8/9 patch adds general documentation.

The 9/9 patch adds an entry to the maintainers list.

This patch series is a task of the KSPP [1] and it is worth to mention
that there is a previous attempt without any continuation [2].

[1] https://github.com/KSPP/linux/issues/39
[2] https://lore.kernel.org/linux-fsdevel/1419457167-15042-1-git-send-emai=
l-richard@nod.at/

Any constructive comments are welcome.

Note: During the compilation these warnings were shown:

kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x18: unreachable =
instruction
arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x123: unrea=
chable instruction
arch/x86/kernel/smpboot.o: warning: objtool: native_play_dead()+0x122: unr=
eachable instruction
net/core/skbuff.o: warning: objtool: skb_push.cold()+0x14: unreachable ins=
truction

John Wood (9):
  security/fbfam: Add a Kconfig to enable the fbfam feature
  security/fbfam: Add the api to manage statistics
  security/fbfam: Use the api to manage statistics
  security/fbfam: Add a new sysctl to control the crashing rate
    threshold
  security/fbfam: Detect a fork brute force attack
  security/fbfam: Mitigate a fork brute force attack
  security/fbfam: Add two new prctls to enable and disable the fbfam
    feature
  Documentation/security: Add documentation for the fbfam feature
  MAINTAINERS: Add a new entry for the fbfam feature

 Documentation/security/fbfam.rst | 111 +++++++++++
 Documentation/security/index.rst |   1 +
 MAINTAINERS                      |   7 +
 fs/coredump.c                    |   2 +
 fs/exec.c                        |   2 +
 include/fbfam/fbfam.h            |  29 +++
 include/linux/sched.h            |   4 +
 include/uapi/linux/prctl.h       |   4 +
 kernel/exit.c                    |   2 +
 kernel/fork.c                    |   4 +
 kernel/sys.c                     |   8 +
 kernel/sysctl.c                  |   9 +
 security/Kconfig                 |   1 +
 security/Makefile                |   4 +
 security/fbfam/Kconfig           |  10 +
 security/fbfam/Makefile          |   3 +
 security/fbfam/fbfam.c           | 329 +++++++++++++++++++++++++++++++
 security/fbfam/sysctl.c          |  20 ++
 18 files changed, 550 insertions(+)
 create mode 100644 Documentation/security/fbfam.rst
 create mode 100644 include/fbfam/fbfam.h
 create mode 100644 security/fbfam/Kconfig
 create mode 100644 security/fbfam/Makefile
 create mode 100644 security/fbfam/fbfam.c
 create mode 100644 security/fbfam/sysctl.c

=2D-
2.25.1

