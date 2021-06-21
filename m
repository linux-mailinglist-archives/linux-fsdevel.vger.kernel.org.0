Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A653AF4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 20:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhFUSXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 14:23:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhFUSXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:23:15 -0400
Received: from [192.168.1.155] ([95.118.106.223]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6URd-1ltRf50Vq5-006z5z; Mon, 21 Jun 2021 20:20:30 +0200
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
To:     Shakeel Butt <shakeelb@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <20210615113222.edzkaqfvrris4nth@wittgenstein>
 <20210615124715.nzd5we5tl7xc2n2p@example.org>
 <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
 <87zgvpg4wt.fsf@disp2133>
 <CALvZod70DNiWF-jTUHp6pOVtVX9pzdvYXaQ1At3GHtdKD=iTwQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d1eb12ec-8e6a-11c1-ea0a-b36dcf354d16@metux.net>
Date:   Mon, 21 Jun 2021 20:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod70DNiWF-jTUHp6pOVtVX9pzdvYXaQ1At3GHtdKD=iTwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KY5lFpctxJysfXmhr3/0X4zPaX01gE0qcAW6kk87sRpyKEYXmIY
 +ioYSFHPqsL79BjDqd51LuP8noghOU0I9UrvywQknlRF+T8gQUcJA/9N83NxVwLnT5sVvPa
 30JyPuBrqYb+mmoKIv6LxCoRHdFreiuYJqn1pfZrZUksad7kcd2my/Uz+pzDMWLULmfuWXk
 xVp+EcUhYxfrvdhV1WeDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6Z7D6wns+k=:dLaF925qRKNlyiRknu3bK0
 HvCcCi7AixtiNj4exjyjcGLOHeCbSoibsN+zPViJ1fWok5J8zKwgogQkBy9zBZpmitM9UJA/p
 6GZ+YuBinrXPHIUmq3QAjoVJwIlHBmenMh9lbF1AWExg7cSuR09dxhZCc6TCLtDm+qEdCz46D
 SVxFrhxqAdR5wt5X3o85zt+ObpE5fYQhvZfy5fxUzt+MGOsbabAAeZzzJsmtO1N4j6Aw6B7LP
 hBIl+hFDQkfuQse7XzM2ujo0QipO51QzHPDLWngzbjv8aRZyvCKD8EEz56ob2uxHEwcjyiYDm
 MPFkFhmgejWCBfBocnAUGrDxk/hVpqUiAGAxLAMdqGCnTm4YNGTJu06osh81ePI+7br+HxYh6
 pqyhYsy0+vKNqNN8oRSInY+sYGDj5afnKpdM4UN0TRCAZtOU/bKzsGuUbyqX/5RjTlZzCfkuv
 AEwvjmNH2FveEOPw0VHnfrxOs3qRQDr7nWnR8yeMp7HMaWQ45ZBZJmMiwQW3Z+b9P8kIKKGFl
 sdoQfOQGu3fgPHuzGQfkg8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.06.21 01:38, Shakeel Butt wrote:

> Nowadays, I don't think MemAvailable giving "amount of memory that can
> be allocated without triggering swapping" is even roughly accurate.
> Actually IMO "without triggering swap" is not something an application
> should concern itself with where refaults from some swap types
> (zswap/swap-on-zram) are much faster than refaults from disk.

If we're talking about things like database workloads, there IMHO isn't
anything really better than doing measurements with the actual loads
and tuning incrementally.

But: what is the actual optimization goal, why an application might
want to know where swapping begins ? Computing performance ? Caching +
IO Latency or throughput ? Network traffic (e.g. w/ iscsi) ? Power
consumption ?

>> I do know that hiding the implementation details and providing userspace
>> with information it can directly use seems like the programming model
>> that needs to be explored.  Most programs should not care if they are in
>> a memory cgroup, etc.  Programs, load management systems, and even
>> balloon drivers have a legitimately interest in how much additional load
>> can be placed on a systems memory.

What kind of load exactly ? CPU ? disk IO ? network ?

> How much additional load can be placed on a system *until what*. I
> think we should focus more on the "until" part to make the problem
> more tractable.

ACK. The interesting question is what to do in that case.

An obvious move by an database system could be eg. filling only so much
caches as there's spare physical RAM, in order to avoid useless swapping
(since we'd potentiall produce more IO load when a cache is written
out to swap, instead of just discarding it)

But, this also depends ...

#1: the application doesn't know the actual performance of the swap
device, eg. the already mentioned zswap+friends, or some fast nvmem
for swap vs disk for storage.

#2: caches might also be implemented indirectly by mmap()ing the storage
file/device and so using the kernel's cache here. in that case, the
kernel would automatically discard the pages w/o going to swap. of
course that only works if the cache is nothing but copying pages from
storage into ram.

A completely different scenario would be load management on a cluster
like k8s. Here we usually care of cluster performance (dont care about
individual nodes so muck), but wanna prevent individual nodes from being
overloaded. Since we usually don't know much about the indivdual
workload, we probably don't have much other chance than contigous
monitoring and acting when a node is getting too busy - or trying to
balance when new workloads are started, on current system load (and
other metrics). In that case, I don't see where this new proc file
should be of much help.

> Second, is the reactive approach acceptable? Instead of an upfront
> number representing the room for growth, how about just grow and
> backoff when some event (oom or stall) which we want to avoid is about
> to happen? This is achievable today for oom and stall with PSI and
> memory.high and it avoids the hard problem of reliably estimating the
> reclaimable memory.

I tend to believe that for certain use cases it would be helpful if an
application gets notified if some of its pages are soon getting swapped
out due memory pressure. Then it could decide on its own which whether
it should drop certain caches in order to prevent swapping.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
