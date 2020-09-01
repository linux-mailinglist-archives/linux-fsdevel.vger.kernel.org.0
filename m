Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A642584EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 02:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAAvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 20:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIAAvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:51:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399DC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 17:51:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so6265281qtw.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 17:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecTic8xCx5ZlJt+qNs35mdG/oACbW/PKJVArWzWbx6E=;
        b=FqIqUeKzLJzWCvzToSq99WFEtvNdwKbzbIb4IRjlD7/nvvuB/U/URtZF/qyqI/Tu7B
         2IoWHLDm5XFE6X21QJeoAQBJRaT97NAIq1o8JpBnn5a+vU891CFSKxk/98QDcib2uZZe
         Kal8daApcuKpBCtDoAbZocBP+lcX/Q8Ht/d4xylybIaX/ayQ3eHlbMwIoeFDyEiCILtg
         OuDNtOhWc37eNPfmQzeRtDCivKro3swR6GIKb1CeaTTiR+dMjkwyrhhY2He7oRXISADP
         mUNKfjaVLrSIxxOEpRGq4GJoh00j951avZbX5vQF0TgMCQRsm+Jd7Tj+Nm1mEdjk0Rxi
         sfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecTic8xCx5ZlJt+qNs35mdG/oACbW/PKJVArWzWbx6E=;
        b=E8p5BvjEMj2EXoOnbyxVa81+rKgDwlRQ6DnFn72dFCO6BQbFTbOAE0GTXM4nacyBAS
         x1hO+26nQR5cKM2C07KuciB6Vm0I0y3UvOJitBD6UXAWm8CIpjMJyTW6N/lsTjd0Nizr
         GmnS9Hx12Hen1yh1CuTI5uJLCkGML3IMHLJgnH1AYQ1wBOkq9jnBf4oUtL7XC2jzwu8K
         SNE3ChxBOs+s4jOwq8aEbV2L60nznxpzD4z+pTQI4XEch1OWGib9pscah+UsxNhiTo7f
         uZgvAWAf9DJIkI003xUKGC7KaZprBuBAhUKk25XsbcgXXUTbyqsxVtQSsk7CXQV7fW/5
         BTLA==
X-Gm-Message-State: AOAM530XSofr1ZHm12zKx5f6SVNS41EyNhWI5OpXYmTuXkSmLkKGR8Mt
        xObjzem3+xjuHxeqD0jMnscUFw==
X-Google-Smtp-Source: ABdhPJw7XkqgueqCs2E6POZUxwZoAUVNOAhMW/zqtWm1BDxks7geK2TF+M7q2sMGSz/4dWayzBX/8Q==
X-Received: by 2002:ac8:454f:: with SMTP id z15mr3910122qtn.351.1598921498947;
        Mon, 31 Aug 2020 17:51:38 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h199sm11846779qke.112.2020.08.31.17.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:51:38 -0700 (PDT)
Date:   Mon, 31 Aug 2020 20:51:32 -0400
From:   Qian Cai <cai@lca.pw>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@canonical.com>, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901005131.GA3300@lca.pw>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> On 2020/08/07 21:27, Al Viro wrote:
> > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> >> with pipe->mutex held.
> >>
> >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> >> while for_each_bvec() cannot handle .bv_len == 0.
> > 
> > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > unless I'm misreading it...

I have been chasing something similar for a while as in,

https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/

In my case, it seems the endless loop happens in iterate_iovec() instead where
I put a debug patch here,

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -33,6 +33,7 @@
                if (unlikely(!__v.iov_len))             \
                        continue;                       \
                __v.iov_base = __p->iov_base;           \
+               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
                left = (STEP);                          \
                __v.iov_len -= left;                    \
                skip = __v.iov_len;                     \

and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
soft-lockups and a dead system,

[ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423

Thoughts?

> > 
> > Zero-length segments are not disallowed; it's not all that hard to filter them
> > out in iter_file_splice_write(), but the intent had always been to have
> > iterate_all_kinds() et.al. able to cope with those.
> > 
> > How are these pipe_buffers with ->len == 0 generated in that reproducer, BTW?
> > There might be something else fishy going on...
> > 
> 
> OK. Indeed writing to empty pipe which returns -EFAULT allows an empty
> page to be linked to pipe's array.
> 
> Now, I've just found a simple reproducer, and confirmed that this bug is
> a local lockup DoS by unprivileged user. Please fix.
> 
> ----------
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
>         static char buffer[4096];
>         const int fd = open("/tmp/testfile", O_WRONLY | O_CREAT, 0600);
>         int pipe_fd[2] = { EOF, EOF };
>         pipe(pipe_fd);
>         write(pipe_fd[1], NULL, 4096);
>         write(pipe_fd[1], buffer, 4096);
>         splice(pipe_fd[0], NULL, fd, NULL, 65536, 0);
>         return 0;
> }
> ----------
> 
> [  125.598898][    C0] rcu: INFO: rcu_sched self-detected stall on CPU
> [  125.601072][    C0] rcu: 	0-....: (20171 ticks this GP) idle=526/1/0x4000000000000000 softirq=7918/7918 fqs=5136 
> [  125.604874][    C0] 	(t=21006 jiffies g=9341 q=30)
> [  125.606512][    C0] NMI backtrace for cpu 0
> [  125.607931][    C0] CPU: 0 PID: 2792 Comm: a.out Not tainted 5.8.0+ #793
> [  125.610948][    C0] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> [  125.614938][    C0] Call Trace:
> [  125.616049][    C0]  <IRQ>
> [  125.617010][    C0]  dump_stack+0x5e/0x7a
> [  125.618370][    C0]  nmi_cpu_backtrace.cold.7+0x14/0x52
> [  125.620148][    C0]  ? lapic_can_unplug_cpu.cold.39+0x3a/0x3a
> [  125.622074][    C0]  nmi_trigger_cpumask_backtrace+0x92/0x9f
> [  125.624154][    C0]  arch_trigger_cpumask_backtrace+0x14/0x20
> [  125.626102][    C0]  rcu_dump_cpu_stacks+0xa0/0xd0
> [  125.627919][    C0]  rcu_sched_clock_irq.cold.95+0x121/0x39c
> [  125.629833][    C0]  ? acct_account_cputime+0x17/0x20
> [  125.631534][    C0]  ? account_system_index_time+0x8a/0xa0
> [  125.633422][    C0]  update_process_times+0x23/0x60
> [  125.635070][    C0]  tick_sched_handle.isra.22+0x20/0x60
> [  125.636870][    C0]  tick_sched_timer+0x68/0x80
> [  125.638403][    C0]  ? tick_sched_handle.isra.22+0x60/0x60
> [  125.640588][    C0]  __hrtimer_run_queues+0xf9/0x1a0
> [  125.642591][    C0]  hrtimer_interrupt+0xfc/0x210
> [  125.645033][    C0]  __sysvec_apic_timer_interrupt+0x4c/0x60
> [  125.647292][    C0]  asm_call_on_stack+0xf/0x20
> [  125.649192][    C0]  </IRQ>
> [  125.650501][    C0]  sysvec_apic_timer_interrupt+0x75/0x80
> [  125.652900][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  125.655487][    C0] RIP: 0010:iov_iter_copy_from_user_atomic+0x19b/0x350
> [  125.658124][    C0] Code: 89 45 d0 48 c1 e6 06 48 03 37 4d 8d 3c 09 4c 89 cf e8 d9 e5 ff ff 48 8b 45 d0 45 39 eb 0f 87 35 01 00 00 49 8b 4a 18 4d 89 f9 <45> 29 dd 45 01 d8 75 12 eb 19 41 83 c4 01 41 29 c0 74 10 44 89 e0
> [  125.666132][    C0] RSP: 0018:ffffa6cdc1237aa8 EFLAGS: 00000246
> [  125.668557][    C0] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffff945035a25100
> [  125.671576][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff945035a25100
> [  125.674851][    C0] RBP: ffffa6cdc1237ad8 R08: 0000000000000000 R09: ffff945028a80000
> [  125.677989][    C0] R10: ffffa6cdc1237de0 R11: 0000000000000000 R12: 0000000000000000
> [  125.680990][    C0] R13: 0000000000001000 R14: 0000000000001000 R15: 0000000000001000
> [  125.684006][    C0]  iomap_write_actor+0xbe/0x190
> [  125.685982][    C0]  ? iomap_write_begin+0x460/0x460
> [  125.688031][    C0]  iomap_apply+0xf4/0x1a0
> [  125.689810][    C0]  ? iomap_write_begin+0x460/0x460
> [  125.691826][    C0]  iomap_file_buffered_write+0x69/0x90
> [  125.698598][    C0]  ? iomap_write_begin+0x460/0x460
> [  125.705341][    C0]  xfs_file_buffered_aio_write+0xc2/0x2c0
> [  125.707780][    C0]  xfs_file_write_iter+0xa3/0xc0
> [  125.709802][    C0]  do_iter_readv_writev+0x15b/0x1c0
> [  125.712496][    C0]  do_iter_write+0x81/0x190
> [  125.715245][    C0]  vfs_iter_write+0x14/0x20
> [  125.717221][    C0]  iter_file_splice_write+0x288/0x3e0
> [  125.719340][    C0]  do_splice_from+0x1a/0x40
> [  125.721175][    C0]  do_splice+0x2e5/0x620
> [  125.722950][    C0]  __x64_sys_splice+0x97/0x100
> [  125.724937][    C0]  do_syscall_64+0x31/0x40
> [  125.726766][    C0]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  125.729388][    C0] RIP: 0033:0x7f7515dd91c3
> [  125.731246][    C0] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d fd dd 2c 00 00 75 13 49 89 ca b8 13 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 2b d4 00 00 48 89 04 24
> [  125.749632][    C0] RSP: 002b:00007ffd553cde18 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
> [  125.753713][    C0] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7515dd91c3
> [  125.756867][    C0] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000004
> [  125.759872][    C0] RBP: 0000000000000000 R08: 0000000000010000 R09: 0000000000000000
> [  125.763023][    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004005a6
> [  125.766225][    C0] R13: 00007ffd553cdf10 R14: 0000000000000000 R15: 0000000000000000
> 
