Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CD327814
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 08:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhCAHLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 02:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhCAHLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:11:24 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C487C061756;
        Sun, 28 Feb 2021 23:10:44 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 81so12961668iou.11;
        Sun, 28 Feb 2021 23:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pJ2bOYGTqjA1D4tSVZNemtn8RAEIicy/4vrGmhbojKc=;
        b=g708mMtXhH+sO3r+disKYP4wyAUgIOyQyMBGmwHY7QqD/uYgbcttLCmd3rZIW/3Jb6
         /ZMYZ5RhaOrDSvOy7HX2+fbNlj9fKcExQLxWtvWu1rveRWdZuzhjFJNq1ruY5gSNlDmP
         H7ddzxrFdhJh8QSsV/NBXn5AK+GgUsZ+cPFS0Fml2jkgXNyPzeSxulf5sKuSgJnLRibH
         2oA+7fIyo1msDvgF9iSRTA5umOqHavhA0IB2gRy9F4oLx0wPytB/3YVG+c6xXib+QfLU
         t0DivE3OuGW9HQsLhXHuZRUDTi2V7ZS1E1wneZu1qmUhJ2B61NMFvw8xgbgzeWTpuzNL
         3/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pJ2bOYGTqjA1D4tSVZNemtn8RAEIicy/4vrGmhbojKc=;
        b=W41MNhlD5D6aBFjfv5tbjs3wJXJNLbPfIfmWsk2n90VOJLmCDkKrYZWGcHBgiV0cIx
         ugH/8ensno2ZRHlMQPOmLlvJAnev1Pmd1xobq/Ngasblk13Uq+APOHkdByZ0J0j+Jz9L
         mHyq8dXMf2g1lEk5bZ3N3PcVwtvA44f/YxPnBtjAfs92obGK55oIpq1+7kbQNvMv7fdv
         xmdFd6GmysuVxoIju6Tl0+CIPY2lS0QMQ2p1EnSwr3HBO1/aKMQyeQkpBe9NilqtwVNw
         oYQpBOxNnhk73UXuAk0fuEEKiz2Qn7eWlWgHh7lLPQmEnrmrYvNkaXX+I1/Bqo/ExfJn
         Yyag==
X-Gm-Message-State: AOAM532TeZI+5K82CUSR2EJLBvhvt2R0VZhjkutq1FDkbs9NT3v2D3pv
        PIhLLzGpc+gMJcHkEMqoeOv6pK/lpCW5JLfZLWA=
X-Google-Smtp-Source: ABdhPJzwGgYH2bW10VEzGajN4pCE0DaH6oE3BNYabcRdDmD0T8hkXoP/Dun9Qwy9RP/a7ypiczYZoKIdOkMyv7gokDs=
X-Received: by 2002:a02:4c8:: with SMTP id 191mr14332993jab.27.1614582643697;
 Sun, 28 Feb 2021 23:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20210301065837.0AB115D005DA@webmail.sinamail.sina.com.cn>
In-Reply-To: <20210301065837.0AB115D005DA@webmail.sinamail.sina.com.cn>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 1 Mar 2021 08:10:32 +0100
Message-ID: <CAKXUXMz1CqLAz8ZT4202+h9pNzJU=YTN7PExAbaAgpOfqzWXgg@mail.gmail.com>
Subject: Re: linux kernel bug???
To:     xiaofeng08519@sina.com
Cc:     syzkaller <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        78521586003w <78521586003w@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, Mar 1, 2021 at 7:58 AM <xiaofeng08519@sina.com> wrote:
>
> This is the first time for me to report something, so maybe the format is=
 not right. Please  correct me if I'm wrong. Thank you ~
> When using Syzkaller to fuzz Linux kernel 5.11.0, it reported one null-pt=
r-def bug in file.c. The information is as follows:
>
> The kernel's commit:   c03c21ba6
> The syzkaller commit: 52e3731913ab2677be27c29ed8142b04e8f28521
>

This looks like a valid kernel issue found with syzkaller.

Given that it is reproducible, I suggest you continue with the following st=
eps:

1. Check if it reproduces on v5.12-rc1. If not, there is already a fix
in v5.12-rc1. Try to identify the specific fix by bisection.

2. Check since when this issue occurs, e.g., does it appear on v5.10, v5.9 =
etc.

3. Bisect it to a specific commit.

4. Report back the results of your bisections.

Lukas

>
>
> The report:
> Syzkaller hit 'KASAN: null-ptr-deref Read in __fget_light' bug.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> audit: type=3D1400 audit(1614571961.594:8): avc:  denied  { execmem } for=
  pid=3D294 comm=3D"syz-executor894" scontext=3Dsystem_u:system_r:kernel_t:=
s0 tcontext=3Dsystem_u:system_r:kernel_t:s0 tclass=3Dprocess permissive=3D1
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instru=
mented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/asm-generic/atomic-inst=
rumented.h:27 [inline]
> BUG: KASAN: null-ptr-deref in __fget_light+0x4f/0x250 fs/file.c:930
> Read of size 4 at addr 0000000000000000 by task io_wqe_worker-0/296
>
> CPU: 1 PID: 296 Comm: io_wqe_worker-0 Not tainted 5.11.0+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0xaf/0xf2 lib/dump_stack.c:120
>  __kasan_report mm/kasan/report.c:400 [inline]
>  kasan_report.cold.9+0x10c/0x10e mm/kasan/report.c:413
>  check_memory_region_inline mm/kasan/generic.c:179 [inline]
>  check_memory_region+0x198/0x200 mm/kasan/generic.c:185
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
>  __fget_light+0x4f/0x250 fs/file.c:930
>  fdget_raw include/linux/file.h:70 [inline]
>  path_init+0x940/0x1290 fs/namei.c:2354
>  path_lookupat.isra.65+0x2c/0x4e0 fs/namei.c:2410
>  filename_lookup.part.80+0x17a/0x370 fs/namei.c:2453
>  filename_lookup fs/namei.c:2446 [inline]
>  user_path_at_empty+0x4b/0x80 fs/namei.c:2733
>  user_path_at include/linux/namei.h:60 [inline]
>  vfs_statx+0x108/0x310 fs/stat.c:195
>  do_statx+0xa9/0x120 fs/stat.c:590
>  io_statx fs/io_uring.c:4525 [inline]
>  io_issue_sqe+0x1c31/0x4a50 fs/io_uring.c:6343
>  io_wq_submit_work+0x2f7/0x8e0 fs/io_uring.c:6418
>  io_worker_handle_work+0xcdd/0x1900 fs/io-wq.c:561
>  io_wqe_worker+0xa15/0xeb0 fs/io-wq.c:603
>  kthread+0x32a/0x3f0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Syzkaller reproducer:
> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Slowdo=
wn:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:f=
alse NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFD=
s:false KCSAN:false DevlinkPCI:false USB:false VhciInjection:false Wifi:fal=
se Sysctl:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
> r0 =3D syz_io_uring_setup(0x1, &(0x7f0000000080)=3D{0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0}, &(0x7f00000a0000)=3Dnil, &(0x7f00000b0000)=3Dnil, &(0x7f0000=
000100)=3D<r1=3D>0x0, &(0x7f0000000140)=3D<r2=3D>0x0)
> syz_io_uring_submit(r1, r2, &(0x7f00000008c0)=3D@IORING_OP_STATX=3D{0x15,=
 0x0, 0x0, 0xffffffffffffffff, 0x0, &(0x7f00000003c0)=3D'./file1\x00', 0x20=
, 0x1000}, 0x3)
> io_uring_enter(r0, 0x1, 0x1, 0x1, 0x0, 0x0)
>
>
> C reproducer:
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #define SIZEOF_IO_URING_SQE 64
> #define SIZEOF_IO_URING_CQE 16
> #define SQ_HEAD_OFFSET 0
> #define SQ_TAIL_OFFSET 64
> #define SQ_RING_MASK_OFFSET 256
> #define SQ_RING_ENTRIES_OFFSET 264
> #define SQ_FLAGS_OFFSET 276
> #define SQ_DROPPED_OFFSET 272
> #define CQ_HEAD_OFFSET 128
> #define CQ_TAIL_OFFSET 192
> #define CQ_RING_MASK_OFFSET 260
> #define CQ_RING_ENTRIES_OFFSET 268
> #define CQ_RING_OVERFLOW_OFFSET 284
> #define CQ_FLAGS_OFFSET 280
> #define CQ_CQES_OFFSET 320
>
> struct io_sqring_offsets {
> uint32_t head;
> uint32_t tail;
> uint32_t ring_mask;
> uint32_t ring_entries;
> uint32_t flags;
> uint32_t dropped;
> uint32_t array;
> uint32_t resv1;
> uint64_t resv2;
> };
>
> struct io_cqring_offsets {
> uint32_t head;
> uint32_t tail;
> uint32_t ring_mask;
> uint32_t ring_entries;
> uint32_t overflow;
> uint32_t cqes;
> uint64_t resv[2];
> };
>
> struct io_uring_params {
> uint32_t sq_entries;
> uint32_t cq_entries;
> uint32_t flags;
> uint32_t sq_thread_cpu;
> uint32_t sq_thread_idle;
> uint32_t features;
> uint32_t resv[4];
> struct io_sqring_offsets sq_off;
> struct io_cqring_offsets cq_off;
> };
>
> #define IORING_OFF_SQ_RING 0
> #define IORING_OFF_SQES 0x10000000ULL
>
> #define sys_io_uring_setup 425
> static long syz_io_uring_setup(volatile long a0, volatile long a1, volati=
le long a2, volatile long a3, volatile long a4, volatile long a5)
> {
> uint32_t entries =3D (uint32_t)a0;
> struct io_uring_params* setup_params =3D (struct io_uring_params*)a1;
> void* vma1 =3D (void*)a2;
> void* vma2 =3D (void*)a3;
> void** ring_ptr_out =3D (void**)a4;
> void** sqes_ptr_out =3D (void**)a5;
> uint32_t fd_io_uring =3D syscall(sys_io_uring_setup, entries, setup_param=
s);
> uint32_t sq_ring_sz =3D setup_params->sq_off.array + setup_params->sq_ent=
ries * sizeof(uint32_t);
> uint32_t cq_ring_sz =3D setup_params->cq_off.cqes + setup_params->cq_entr=
ies * SIZEOF_IO_URING_CQE;
> uint32_t ring_sz =3D sq_ring_sz > cq_ring_sz ? sq_ring_sz : cq_ring_sz;
> *ring_ptr_out =3D mmap(vma1, ring_sz, PROT_READ | PROT_WRITE, MAP_SHARED =
| MAP_POPULATE | MAP_FIXED, fd_io_uring, IORING_OFF_SQ_RING);
> uint32_t sqes_sz =3D setup_params->sq_entries * SIZEOF_IO_URING_SQE;
> *sqes_ptr_out =3D mmap(vma2, sqes_sz, PROT_READ | PROT_WRITE, MAP_SHARED =
| MAP_POPULATE | MAP_FIXED, fd_io_uring, IORING_OFF_SQES);
> return fd_io_uring;
> }
>
> static long syz_io_uring_submit(volatile long a0, volatile long a1, volat=
ile long a2, volatile long a3)
> {
> char* ring_ptr =3D (char*)a0;
> char* sqes_ptr =3D (char*)a1;
> char* sqe =3D (char*)a2;
> uint32_t sqes_index =3D (uint32_t)a3;
> uint32_t sq_ring_entries =3D *(uint32_t*)(ring_ptr + SQ_RING_ENTRIES_OFFS=
ET);
> uint32_t cq_ring_entries =3D *(uint32_t*)(ring_ptr + CQ_RING_ENTRIES_OFFS=
ET);
> uint32_t sq_array_off =3D (CQ_CQES_OFFSET + cq_ring_entries * SIZEOF_IO_U=
RING_CQE + 63) & ~63;
> if (sq_ring_entries)
> sqes_index %=3D sq_ring_entries;
> char* sqe_dest =3D sqes_ptr + sqes_index * SIZEOF_IO_URING_SQE;
> memcpy(sqe_dest, sqe, SIZEOF_IO_URING_SQE);
> uint32_t sq_ring_mask =3D *(uint32_t*)(ring_ptr + SQ_RING_MASK_OFFSET);
> uint32_t* sq_tail_ptr =3D (uint32_t*)(ring_ptr + SQ_TAIL_OFFSET);
> uint32_t sq_tail =3D *sq_tail_ptr & sq_ring_mask;
> uint32_t sq_tail_next =3D *sq_tail_ptr + 1;
> uint32_t* sq_array =3D (uint32_t*)(ring_ptr + sq_array_off);
> *(sq_array + sq_tail) =3D sqes_index;
> __atomic_store_n(sq_tail_ptr, sq_tail_next, __ATOMIC_RELEASE);
> return 0;
> }
>
> #ifndef __NR_io_uring_enter
> #define __NR_io_uring_enter 426
> #endif
>
> uint64_t r[3] =3D {0xffffffffffffffff, 0x0, 0x0};
>
> int main(void)
> {
> syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
> syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> intptr_t res =3D 0;
> *(uint32_t*)0x20000084 =3D 0;
> *(uint32_t*)0x20000088 =3D 0;
> *(uint32_t*)0x2000008c =3D 0;
> *(uint32_t*)0x20000090 =3D 0;
> *(uint32_t*)0x20000098 =3D 0;
> *(uint32_t*)0x2000009c =3D 0;
> *(uint32_t*)0x200000a0 =3D 0;
> *(uint32_t*)0x200000a4 =3D 0;
> res =3D -1;
> res =3D syz_io_uring_setup(1, 0x20000080, 0x200a0000, 0x200b0000, 0x20000=
100, 0x20000140);
> if (res !=3D -1) {
> r[0] =3D res;
> r[1] =3D *(uint64_t*)0x20000100;
> r[2] =3D *(uint64_t*)0x20000140;
> }
> *(uint8_t*)0x200008c0 =3D 0x15;
> *(uint8_t*)0x200008c1 =3D 0;
> *(uint16_t*)0x200008c2 =3D 0;
> *(uint32_t*)0x200008c4 =3D -1;
> *(uint64_t*)0x200008c8 =3D 0;
> *(uint64_t*)0x200008d0 =3D 0x200003c0;
> memcpy((void*)0x200003c0, "./file1\000", 8);
> *(uint32_t*)0x200008d8 =3D 0x20;
> *(uint32_t*)0x200008dc =3D 0x1000;
> *(uint64_t*)0x200008e0 =3D 0;
> *(uint16_t*)0x200008e8 =3D 0;
> *(uint16_t*)0x200008ea =3D 0;
> *(uint8_t*)0x200008ec =3D 0;
> *(uint8_t*)0x200008ed =3D 0;
> *(uint8_t*)0x200008ee =3D 0;
> *(uint8_t*)0x200008ef =3D 0;
> *(uint8_t*)0x200008f0 =3D 0;
> *(uint8_t*)0x200008f1 =3D 0;
> *(uint8_t*)0x200008f2 =3D 0;
> *(uint8_t*)0x200008f3 =3D 0;
> *(uint8_t*)0x200008f4 =3D 0;
> *(uint8_t*)0x200008f5 =3D 0;
> *(uint8_t*)0x200008f6 =3D 0;
> *(uint8_t*)0x200008f7 =3D 0;
> *(uint8_t*)0x200008f8 =3D 0;
> *(uint8_t*)0x200008f9 =3D 0;
> *(uint8_t*)0x200008fa =3D 0;
> *(uint8_t*)0x200008fb =3D 0;
> *(uint8_t*)0x200008fc =3D 0;
> *(uint8_t*)0x200008fd =3D 0;
> *(uint8_t*)0x200008fe =3D 0;
> *(uint8_t*)0x200008ff =3D 0;
> syz_io_uring_submit(r[1], r[2], 0x200008c0, 3);
> syscall(__NR_io_uring_enter, r[0], 1, 1, 1ul, 0ul, 0ul);
> return 0;
> }
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/20210301065837.0AB115D005DA%40webmail.sinamail.sina.com.cn.
