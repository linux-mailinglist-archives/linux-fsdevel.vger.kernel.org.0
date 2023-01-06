Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4333466093E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 23:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjAFWGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbjAFWGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:06:13 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5617669B5;
        Fri,  6 Jan 2023 14:06:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2476E604F1;
        Fri,  6 Jan 2023 23:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673042769; bh=aOSv1VwE8jYAZvixIsXoNfXWXt8Ldo4v00UbJtBBAGI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g/OkW7j8sA2bfxySM4nXfiMh0cDGRAN6dwOUHgopdXHG+4mksCM0lK3DNNb8CiNHT
         aIbJglP7YjAvggWsOZ/7tpELDitfG1i7UGGwAjMM00fSki2Es5l9O/skrZofCuTGaY
         7kJcfOerBb3J2+h8HXs187sEdl4dA33zQ5Krs2mtZD8YKqOD3M05oKJmUeaxelAnTk
         UnvMQ0B63906TI6hucRsvsIafw88GXxFL2yuer7jFheSJCKzUWV+p4NtJlbBTNrfRk
         OphFo93QHDHTROug4TQkXbXRDmZqmUgMILy1ZlFthee6L9//AOi57PABk3e/ZeRv2e
         LoZuksVxVGalA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PczCTCKkFZZR; Fri,  6 Jan 2023 23:06:06 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id C5A17604F0;
        Fri,  6 Jan 2023 23:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673042766; bh=aOSv1VwE8jYAZvixIsXoNfXWXt8Ldo4v00UbJtBBAGI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g9HkP0dckee4G95vx+Q8N5lQZqbYjcb8Zk9vf1pgMTyDe47kGJKnB/mTA/yjjBYdf
         jKNtOvALhYYUM5soG2S1VUOt45rCEotvK1T3nplEfKqQeSBd0/KxViXP7nmAN5T1pk
         LnU4x4axUET+iXGq8M54OUYyh4l8O/Wq1DnMAtmB8zXsKImyLF3/ZJjOszHx3tTurb
         L6V3dqdOjIS69U6EWTqRMzQcy5f5eRnabLEgrOzO1xstKaDpuzv8ADwqnkV/RCsYOz
         ARai4kmaVoXrrPiga53wcenla9p2adMWSS/VXwlS9fKgaC4rSnX5f63cE0amj+/Xiy
         9+tSGFIplmy4w==
Message-ID: <19767de3-51c5-6d41-66c1-30b594850504@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 23:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: assert spuriously fails in selftest/proc/proc-uptime-001.c
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
 <Y7h2xvzKLg36DSq8@p183> <d600f5c4-290b-d575-19a0-9cc83f77caaa@alu.unizg.hr>
In-Reply-To: <d600f5c4-290b-d575-19a0-9cc83f77caaa@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06. 01. 2023. 22:18, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> In the same environment as the previous bug report (Lenovo Ideapad 3 15ITL6 laptop
> running Ubuntu 22.10 kinetic kudu and 6.2-rc2 vanilla Torvalds tree kernel), the
> next test in the ...selftest/proc/* sequence spuriously fails in assert (i1 <= i0).
> 
> Please note that the compiler is the novelty GCC 12.2.0-3ubuntu1.
> 
> This was previously hidden by premature hang in the `make kselftest` run due to
> proc-empty-vm an proc-pid-vm problems that are now fixed.
> 
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
> Aborted (core dumped)
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
> 
> It happens about half of the times the program is called.
> 
> The source seems OK, I can't tell why the idle counter doesn't look monotonic to
> the program.
> 
> Hope this helps.
> 
> BTW, good news: this time I have checked independently, and this is the last test from the .../selftest/proc
> group that doesn't have clean exit code 0.

UPDATE:

The same behavior independently occurred with GCC 10.4.0, 9.5.0, 8.5.0 and 6.5.0.

Apparently this happens in 30% to 50% of attempts. Perhaps that's why it wasn't discovered yet:

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# make CC=gcc-10
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   fd-001-lookup.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/fd-001-lookup
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   fd-002-posix-eq.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/fd-002-posix-eq
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   fd-003-kthread.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/fd-003-kthread
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-loadavg-001.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-loadavg-001
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-empty-vm.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-empty-vm
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-pid-vm.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-pid-vm
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-self-map-files-001.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-self-map-files-001
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-self-map-files-002.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-self-map-files-002
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-self-syscall.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-self-syscall
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-self-wchan.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-self-wchan
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-subset-pid.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-subset-pid
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-tid0.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-tid0
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-uptime-001.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-uptime-001
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-uptime-002.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-uptime-002
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   read.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/read
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   self.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/self
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   setns-dcache.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/setns-dcache
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   setns-sysvipc.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/setns-sysvipc
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   thread-self.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/thread-self
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-multiple-procfs.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-multiple-procfs
gcc-10 -Wall -O2 -Wno-unused-function -D_GNU_SOURCE   -pthread   proc-fsconfig-hidepid.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc/proc-fsconfig-hidepid
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# for exe in `ls -l | grep -e -x | 
awk '{ print $9 }'`; do echo -n ${exe}':'; ./$exe ; echo "exit=$?" ; done
fd-001-lookup:exit=0
fd-002-posix-eq:exit=0
fd-003-kthread:exit=0
proc-empty-vm:exit=0
proc-fsconfig-hidepid:exit=0
proc-loadavg-001:exit=0
proc-multiple-procfs:exit=0
proc-pid-vm:exit=0
proc-self-map-files-001:exit=0
proc-self-map-files-002:exit=0
proc-self-syscall:exit=0
proc-self-wchan:exit=0
proc-subset-pid:exit=0
proc-tid0:exit=0
proc-uptime-001:exit=0
proc-uptime-002:exit=0
read:exit=0
self:exit=0
setns-dcache:exit=0
setns-sysvipc:exit=0
thread-self:exit=0
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001

The conclusion (to state the obvious) is that the GCC 12.2.0 optimisations are
not the culprit this time :-/

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

