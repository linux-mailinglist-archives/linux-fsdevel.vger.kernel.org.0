Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F325F237
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 06:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGDE6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 00:58:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46017 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfGDE6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:58:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id j133so854213ybj.12;
        Wed, 03 Jul 2019 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QGtOHWS78HCd3ElILLJ/msaLQDeU8myY6kcuvyKKwI=;
        b=MZdli9xDflXurcB+DwPHcz48yVuhT9wmP/2oqIC7JOy+5MzgwjsI1b5DVbHWUMAr/k
         dswvJNxMMGQwJ8qqJIxSoWVdb1bDd3ZoYaHmKIChtvUEAzpqWJ727tcNydTx9acoOht+
         +VYiFDaOyT70oV/zQfz8Q7Dqg/FMAlMMj4XPbBusfHTMUUu1r0gdxgfYGxaiCU+ivuBK
         wGc5k6FtSkNF6b6gBDFAyKymrvyLFOv/bIVAxPX1ApB+/suszey3GKkWG2MhTDN4zAYC
         ZhJwYDgYxDgj4PHz9JtaVvSEwn83+XeR8JY4Fbmcgc0eH6tFjinI6m0ptvGt1AmW0kl5
         RWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QGtOHWS78HCd3ElILLJ/msaLQDeU8myY6kcuvyKKwI=;
        b=SMELXZBwdf7yY/ExI59Kp2QbpxD+uKi1s0Z2IIQnVuKew23k1ejsAfEPO0Fc1zfaZX
         hEpk46FyXRIIROKaFKkePCiHAvJX6WpMErC98w4cofkYIiRO/FESW4isGz4oVrUSvYOp
         gcElGPRK6GzU8SKkQlYnbMlTRweUVj2D4sp1B4R7FzKHGt1PFuOM8QOMzN/e73A2yx8p
         Ou05v0rx0KtVZPO2chCplWr/PIVlp6Kd5hfrXgJ6iF13DYCVsZcu+yUARlSaFUnpjL+o
         aQxsFjgVFOkqLXU6ZiNI7byj/ApSFPC7/oIsUTtHWtj1gupo32Jfb6q0GqyrFDTBhKDr
         /jxg==
X-Gm-Message-State: APjAAAU6IOpjC0q0lxRu7Jh00drxQ0sWq7ZjN3bP0RcAiih6BH3tlnHB
        DLMv1X67Y5fWmbHtDVI1jHXsibzfFLP4BkyrVJ0=
X-Google-Smtp-Source: APXvYqxcPHYj0tDOeZsDgDQP9kAFPeJdCOXZ+YOHWQXvHm4K8tmAtFfWZLAdEgRkb8bryq9lMF4yT5uXmmFg7VEs4XY=
X-Received: by 2002:a25:f202:: with SMTP id i2mr2304848ybe.462.1562216288646;
 Wed, 03 Jul 2019 21:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000665152058c0d7ed9@google.com> <20190702060030.GD27702@sol.localdomain>
 <CAPV7t-2jOgUs-LxiQYxqp_h8RH7X-CxxMcLL2SzOk1kEyc55Ug@mail.gmail.com>
In-Reply-To: <CAPV7t-2jOgUs-LxiQYxqp_h8RH7X-CxxMcLL2SzOk1kEyc55Ug@mail.gmail.com>
From:   JackieLiu <jackieliu2113@gmail.com>
Date:   Thu, 4 Jul 2019 12:57:57 +0800
Message-ID: <CAPV7t-2fyfDoShSQPnHr4FCcVKnJ1i_r4uW9dWK9Ja3wPgw-sA@mail.gmail.com>
Subject: Re: INFO: task hung in io_uring_release
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+94324416c485d422fe15@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test program like that:

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms)
{
        usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
        struct timespec ts;
        if (clock_gettime(CLOCK_MONOTONIC, &ts))
                exit(1);
        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char *file, const char *what, ...)
{
        char buf[1024];
        va_list args;
        va_start(args, what);
        vsnprintf(buf, sizeof(buf), what, args);
        va_end(args);
        buf[sizeof(buf) - 1] =3D 0;
        int len =3D strlen(buf);
        int fd =3D open(file, O_WRONLY | O_CLOEXEC);
        if (fd =3D=3D -1)
                return false;
        if (write(fd, buf, len) !=3D len)
        {
                int err =3D errno;
                close(fd);
                errno =3D err;
                return false;
        }
        close(fd);
        return true;
}

static void kill_and_wait(int pid, int *status)
{
        kill(-pid, SIGKILL);
        kill(pid, SIGKILL);
        int i;
        for (i =3D 0; i < 100; i++)
        {
                if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
                        return;
                usleep(1000);
        }
        DIR *dir =3D opendir("/sys/fs/fuse/connections");
        if (dir)
        {
                for (;;)
                {
                        struct dirent *ent =3D readdir(dir);
                        if (!ent)
                                break;
                        if (strcmp(ent->d_name, ".") =3D=3D 0 ||
strcmp(ent->d_name, "..") =3D=3D 0)
                                continue;
                        char abort[300];
                        snprintf(abort, sizeof(abort),
"/sys/fs/fuse/connections/%s/abort",
                                 ent->d_name);
                        int fd =3D open(abort, O_WRONLY);
                        if (fd =3D=3D -1)
                        {
                                continue;
                        }
                        if (write(fd, abort, 1) < 0)
                        {
                        }
                        close(fd);
                }
                closedir(dir);
        }
        else
        {
        }
        while (waitpid(-1, status, __WALL) !=3D pid)
        {
        }
}

static void setup_test()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        setpgrp();
        write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
        int iter;
        for (iter =3D 0;; iter++)
        {
                int pid =3D fork();
                if (pid < 0)
                        exit(1);
                if (pid =3D=3D 0)
                {
                        setup_test();
                        execute_one();
                        exit(0);
                }
                int status =3D 0;
                uint64_t start =3D current_time_ms();
                for (;;)
                {
                        if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=
=3D pid)
                                break;
                        sleep_ms(1);
                        if (current_time_ms() - start < 5 * 1000)
                                continue;
                        kill_and_wait(pid, &status);
                        break;
                }
        }
}

#ifndef __NR_io_uring_setup
#define __NR_io_uring_setup 425
#endif

void execute_one(void)
{
        *(uint32_t *)0x20000080 =3D 0;
        *(uint32_t *)0x20000084 =3D 0;
        *(uint32_t *)0x20000088 =3D 3;
        *(uint32_t *)0x2000008c =3D 3;
        *(uint32_t *)0x20000090 =3D 0x175;
        *(uint32_t *)0x20000094 =3D 0;
        *(uint32_t *)0x20000098 =3D 0;
        *(uint32_t *)0x2000009c =3D 0;
        *(uint32_t *)0x200000a0 =3D 0;
        *(uint32_t *)0x200000a4 =3D 0;
        *(uint32_t *)0x200000a8 =3D 0;
        *(uint32_t *)0x200000ac =3D 0;
        *(uint32_t *)0x200000b0 =3D 0;
        *(uint32_t *)0x200000b4 =3D 0;
        *(uint32_t *)0x200000b8 =3D 0;
        *(uint32_t *)0x200000bc =3D 0;
        *(uint32_t *)0x200000c0 =3D 0;
        *(uint32_t *)0x200000c4 =3D 0;
        *(uint64_t *)0x200000c8 =3D 0;
        *(uint32_t *)0x200000d0 =3D 0;
        *(uint32_t *)0x200000d4 =3D 0;
        *(uint32_t *)0x200000d8 =3D 0;
        *(uint32_t *)0x200000dc =3D 0;
        *(uint32_t *)0x200000e0 =3D 0;
        *(uint32_t *)0x200000e4 =3D 0;
        *(uint32_t *)0x200000e8 =3D 0;
        *(uint32_t *)0x200000ec =3D 0;
        *(uint64_t *)0x200000f0 =3D 0;
        syscall(__NR_io_uring_setup, 0x983, 0x20000080);
}
int main(void)
{
        syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
        loop();
        return 0;
}

The test steps are as follows:

1. gcc test.c -o test
2. ./test &
3. ps aux | grep test
again and agin, we need wait print that.
root@localhost:~# ps aux | grep test
root     23718  0.0  0.0      0     0 ttyS0    D    01:23   0:00 [test]
root       934  0.3  0.0  20760  1260 ttyS0    S    01:09   0:22 ./test
root     23766  0.0  0.0  11460  1060 ttyS0    S+   03:01   0:00 grep
--color=3Dauto test

4. kill -9 934
5.
root@localhost:~# cat /proc/23718/task/23718/stack
[<0>] io_sq_thread_stop+0x3e/0x53
[<0>] io_finish_async+0x14/0x4c
[<0>] io_ring_ctx_free+0x14/0x12d
[<0>] io_ring_ctx_wait_and_kill+0x6e/0x74
[<0>] io_uring_release+0x39/0x43
[<0>] __fput+0xb1/0x220
[<0>] task_work_run+0x79/0xa0
[<0>] do_exit+0x2c1/0xb10
[<0>] do_group_exit+0x35/0xa0
[<0>] __x64_sys_exit_group+0xf/0x10
[<0>] do_syscall_64+0x43/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

6. process 23718 can't stop now.

JackieLiu <jackieliu2113@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Eric Biggers
>
> I have reproduced this problem and are looking for a solution. maybe
> just use kthread_unpark to replace kthread_stop in io_uring_release
> function.
>
> ---
> Jackie Liu
>
> Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Jens, any idea about this?
> >
> > On Mon, Jun 24, 2019 at 01:21:06AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.ker=
nel.o..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1418bf0aa=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D28ec3437a=
5394ee0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D94324416c48=
5d422fe15
> > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+94324416c485d422fe15@syzkaller.appspotmail.com
> > >
> > > INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
> > >       Not tainted 5.2.0-rc5+ #3
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > syz-executor.5  D25632  8634   8224 0x00004004
> > > Call Trace:
> > >  context_switch kernel/sched/core.c:2818 [inline]
> > >  __schedule+0x658/0x9e0 kernel/sched/core.c:3445
> > >  schedule+0x131/0x1d0 kernel/sched/core.c:3509
> > >  schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
> > >  do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
> > >  __wait_for_common kernel/sched/completion.c:104 [inline]
> > >  wait_for_common kernel/sched/completion.c:115 [inline]
> > >  wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
> > >  kthread_stop+0xb4/0x150 kernel/kthread.c:559
> > >  io_sq_thread_stop fs/io_uring.c:2252 [inline]
> > >  io_finish_async fs/io_uring.c:2259 [inline]
> > >  io_ring_ctx_free fs/io_uring.c:2770 [inline]
> > >  io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
> > >  io_uring_release+0x5d/0x70 fs/io_uring.c:2842
> > >  __fput+0x2e4/0x740 fs/file_table.c:280
> > >  ____fput+0x15/0x20 fs/file_table.c:313
> > >  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
> > >  tracehook_notify_resume include/linux/tracehook.h:185 [inline]
> > >  exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
> > >  prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
> > >  syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
> > >  do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
> > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x412fb1
> > > Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b =
05 cf
> > > a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4=
c 0f 45
> > > c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
> > > RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 000000000000000=
3
> > > RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
> > > RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
> > > RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
> > > R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
> > > R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c
> > >
> > > Showing all locks held in the system:
> > > 1 lock held by khungtaskd/1043:
> > >  #0: 00000000ec789630 (rcu_read_lock){....}, at: rcu_lock_acquire+0x4=
/0x30
> > > include/linux/rcupdate.h:207
> > > 1 lock held by rsyslogd/8054:
> > >  #0: 00000000a1730567 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x243/0=
x2e0
> > > fs/file.c:801
> > > 2 locks held by getty/8167:
> > >  #0: 000000000d85b796 (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 000000006ecd2335 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8168:
> > >  #0: 000000005c58bd1f (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 00000000158ead38 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8169:
> > >  #0: 000000003d373884 (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 0000000026014169 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8170:
> > >  #0: 00000000ba3eabbd (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 0000000003284ce2 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8171:
> > >  #0: 000000009fcb2c0e (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 00000000ac5d0da7 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8172:
> > >  #0: 000000003f4e772c (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 000000000c930b31 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > > 2 locks held by getty/8173:
> > >  #0: 000000002a3615cf (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
> > >  #1: 00000000dd5c3618 (&ldata->atomic_read_lock){+.+.}, at:
> > > n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > NMI backtrace for cpu 0
> > > CPU: 0 PID: 1043 Comm: khungtaskd Not tainted 5.2.0-rc5+ #3
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS
> > > Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
> > >  nmi_cpu_backtrace+0x89/0x160 lib/nmi_backtrace.c:101
> > >  nmi_trigger_cpumask_backtrace+0x125/0x230 lib/nmi_backtrace.c:62
> > >  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi=
.c:38
> > >  trigger_all_cpu_backtrace+0x17/0x20 include/linux/nmi.h:146
> > >  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
> > >  watchdog+0xbb9/0xbd0 kernel/hung_task.c:289
> > >  kthread+0x325/0x350 kernel/kthread.c:255
> > >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > > Sending NMI from CPU 0 to CPUs 1:
> > > NMI backtrace for cpu 1
> > > CPU: 1 PID: 2546 Comm: kworker/u4:4 Not tainted 5.2.0-rc5+ #3
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS
> > > Google 01/01/2011
> > > Workqueue: bat_events batadv_nc_worker
> > > RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> > > RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
> > > RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [i=
nline]
> > > RIP: 0010:rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:292 [inline]
> > > RIP: 0010:rcu_is_watching+0x62/0xa0 kernel/rcu/tree.c:872
> > > Code: 4c 89 f7 e8 70 50 4c 00 48 c7 c3 b8 5f 03 00 49 03 1e 48 89 df =
be 04
> > > 00 00 00 e8 89 25 4c 00 48 89 d8 48 c1 e8 03 42 8a 04 38 <84> c0 75 1=
e 8b 03
> > > 65 ff 0d 5d 72 9f 7e 74 0c 83 e0 02 d1 e8 5b 41
> > > RSP: 0018:ffff8880a10ffbe8 EFLAGS: 00000a02
> > > RAX: 1ffff11015d66b00 RBX: ffff8880aeb35fb8 RCX: ffffffff81628ad7
> > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880aeb35fb8
> > > RBP: ffff8880a10ffc00 R08: dffffc0000000000 R09: ffffed1015d66bf8
> > > R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: dffffc0000000000
> > > R13: ffff8880a93c9b00 R14: ffffffff8881f258 R15: dffffc0000000000
> > > FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000c434bbb720 CR3: 000000008e6fa000 CR4: 00000000001406e0
> > > Call Trace:
> > >  rcu_read_lock include/linux/rcupdate.h:594 [inline]
> > >  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:407 [inlin=
e]
> > >  batadv_nc_worker+0x115/0x600 net/batman-adv/network-coding.c:718
> > >  process_one_work+0x814/0x1130 kernel/workqueue.c:2269
> > >  worker_thread+0xc01/0x1640 kernel/workqueue.c:2415
> > >  kthread+0x325/0x350 kernel/kthread.c:255
> > >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
