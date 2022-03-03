Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F44CBC12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 12:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiCCLEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 06:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiCCLE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:04:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC2154D14
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 03:03:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so9776277eje.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=JP/5uSjkLq/yFEMifGx/fbtdRx9JBfu0ueprxmJ/NVU=;
        b=mr+93qGs2e1J7v5eo1ZL7pqBkSTXeakra9/8t/VnENhk3e7PONqHQ5F1CzP2JoHW9l
         zechgCx5MznFkPWFZCdqKXbr2ywGwU1Mw91dxPu/t0EymUYalWNjv1gvYkFjebHjTNzf
         B7vYFzTdi5kvC0yRUF1E9ZHldY+tycuFU1Vs3uEoPFgY2ZGgyT1jJ0GyE8xoFcZZNSpc
         /dMoLW1Zoe1U83Rh8o+sUY2t2PpbeFDGytrdKsCicjU6FFaukePKnnbJVrtcL3vdMf85
         F96ta0vA/KAbDE7aSOqvR8xv3/091BAYPOxstmHlnUEcnFflSC9h8x0SsCrd3R7hQdpa
         i5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JP/5uSjkLq/yFEMifGx/fbtdRx9JBfu0ueprxmJ/NVU=;
        b=skf67NmRKDLL7nv4dose5iIGeP17IFQTdBbLE2CuzGjbQm7+3mOpAl8froII8G+YYK
         FUfFajjNL9T+aRnGJENML7xNTbmuZG7+tYZkTl/GbzXjtrInoSm2rQL4Y4voLfprQHn9
         zUsmarKKDjB5dUxj8XPowtn4O14cepqdz/xOsESI/lbjfTMfECYftVT0ZMmO7t4pYaBm
         lYaRYqvIXONNlVVw2nWSFnZ6iAW/Fb8N/HlrZloaQKcj/A5c8tvV5Arl1rV0bGRF795v
         UTWsu0KvY6w7MoupgJRk/mizakcfuvMENJfH1KDh+InZSKWexk8olD7txU63RgvP7OCZ
         CQJQ==
X-Gm-Message-State: AOAM5318efAbHRR/ettNozRodjUqsibMVYOZlkc4dQC3F03edyxtFvpk
        1EYbjC9oWknz7UqijbhOXCjTPJkcXym7wJyKtHxTIrHLJ7l5YQ==
X-Google-Smtp-Source: ABdhPJyX5Mbaw77wPx9sQxNt0zvFy0mFwV8vSweSxQ6PvyeM76+wtGYHsRZEaHM86IGVAnuSfF90VDg9fsiTe4vB+H0=
X-Received: by 2002:a17:906:8299:b0:6cf:3847:284b with SMTP id
 h25-20020a170906829900b006cf3847284bmr26462228ejx.682.1646305421325; Thu, 03
 Mar 2022 03:03:41 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Black <daniel@mariadb.org>
Date:   Thu, 3 Mar 2022 22:03:30 +1100
Message-ID: <CABVffEO-29wjA=TKO66nA5JmA-ZnyyLi4VA7BU+B3VoxD8X9DA@mail.gmail.com>
Subject: ECANCELED returned from io_uring_wait_cqe
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While working on improving error handling for MariaDB, (and should
have been checking read sizes too apparently), I'm seeing ECANCELED
returned from io_uring_wait_cqe. The stack trace to me shows MariaDB
still running at this point, and not shutting down (signal handler
variable abort_loop not set, and we put a io_uring_prep_nop on
shutdown to know when all are finished).

The code is not using linked operations, timeouts or explicit
cancelling of queued items.

This has been observed in tmpfs (usually quicker to exhibit) and ext4.

$ uname -r
5.17.0-0.rc6.109.fc37.x86_64

To reproduce

$ mdir ~/here
$ podman run --workdir  /usr/share/mysql/mysql-test  --privileged  -v
$HOME/here:/test:Z  --rm
quay.io/danielgblack/mariadb-test:10.6-impish-sysbench
./mysql-test-run --vardir=/test --repeat 8 --parallel=8
encryption.innodb-checksum-algorithm{,,,,}{,,,,}

will eventually assert and core dump crash after 20-2000 tests.

While the core dumps from a container require fiddly extraction, what
it looks like is:

A user space stack trace looks like:

(gdb) bt full
#0  0x00007fa894db488c in __pthread_kill_implementation () from /lib64/libc.so.6
No symbol table info available.
#1  0x000055c908b5b0a8 in handle_fatal_signal (sig=<optimized out>) at
/home/dan/repos/mariadb-server-10.9/sql/signal_handler.cc:345
        curr_time = 1646302386
        tm = {tm_sec = 6, tm_min = 13, tm_hour = 21, tm_mday = 3,
tm_mon = 2, tm_year = 122, tm_wday = 4, tm_yday = 61, tm_isdst = 1,
tm_gmtoff = 39600, tm_zone = 0x55c90a3f2b70 "AEDT"}
        thd = 0x0
        print_invalid_query_pointer = false
#2  <signal handler called>
No symbol table info available.
#3  0x00007fa894db488c in __pthread_kill_implementation () from /lib64/libc.so.6
No symbol table info available.
#4  0x00007fa894d676a6 in raise () from /lib64/libc.so.6
No symbol table info available.
#5  0x00007fa894d517d3 in abort () from /lib64/libc.so.6
No symbol table info available.
#6  0x000055c9087e7214 in ut_dbg_assertion_failed
(expr=expr@entry=0x55c90923843b "cb->m_err == DB_SUCCESS",
file=file@entry=0x55c909237c50
"/home/dan/repos/mariadb-server-10.9/storage/innobase/os/os0file.cc",
line=line@entry=3557) at
/home/dan/repos/mariadb-server-10.9/storage/innobase/ut/ut0dbg.cc:60
No locals.
#7  0x000055c9087d0869 in io_callback (cb=<optimized out>) at
/home/dan/repos/mariadb-server-10.9/storage/innobase/os/os0file.cc:3557
        request = <optimized out>
        req = <optimized out>
#8  0x000055c908f9108e in tpool::task_group::execute
(this=0x55c90a62b1e0, t=0x55c90a639808) at
/home/dan/repos/mariadb-server-10.9/tpool/task_group.cc:55
        lk = {_M_device = <optimized out>, _M_owns = false}
#9  0x000055c908f8ffcf in tpool::thread_pool_generic::worker_main
(this=0x55c90a5d3f80, thread_var=0x55c90a5e37a0) at
/home/dan/repos/mariadb-server-10.9/tpool/tpool_generic.cc:549
        task = 0x55c90a639808
#10 0x00007fa8950ff5c4 in execute_native_thread_routine () from
/lib64/libstdc++.so.6
No symbol table info available.
#11 0x00007fa894db2b1a in start_thread () from /lib64/libc.so.6
No symbol table info available.
#12 0x00007fa894e37650 in clone3 () from /lib64/libc.so.6
No symbol table info available.
(gdb) up
#1  0x000055c908b5b0a8 in handle_fatal_signal (sig=<optimized out>) at
/home/dan/repos/mariadb-server-10.9/sql/signal_handler.cc:345
345        my_write_core(sig);
(gdb)
#2  <signal handler called>
(gdb)
#3  0x00007fa894db488c in __pthread_kill_implementation () from /lib64/libc.so.6
(gdb)
#4  0x00007fa894d676a6 in raise () from /lib64/libc.so.6
(gdb)
#5  0x00007fa894d517d3 in abort () from /lib64/libc.so.6
(gdb)
#6  0x000055c9087e7214 in ut_dbg_assertion_failed
(expr=expr@entry=0x55c90923843b "cb->m_err == DB_SUCCESS",
file=file@entry=0x55c909237c50
"/home/dan/repos/mariadb-server-10.9/storage/innobase/os/os0file.cc",
line=line@entry=3557) at
/home/dan/repos/mariadb-server-10.9/storage/innobase/ut/ut0dbg.cc:60
60        abort();
(gdb)
#7  0x000055c9087d0869 in io_callback (cb=<optimized out>) at
/home/dan/repos/mariadb-server-10.9/storage/innobase/os/os0file.cc:3557
3557      ut_a(cb->m_err == DB_SUCCESS);
(gdb)
#8  0x000055c908f9108e in tpool::task_group::execute
(this=0x55c90a62b1e0, t=0x55c90a639808) at
/home/dan/repos/mariadb-server-10.9/tpool/task_group.cc:55
55            t->m_func(t->m_arg);
(gdb) p *((tpool::aiocb *) t->m_arg)
$1 = {<iovec> = {iov_base = 0x7fa889124000, iov_len = 40960}, m_fh =
11, m_opcode = tpool::aio_opcode::AIO_PWRITE, m_offset = 1048576,
m_buffer = 0x7fa889124000, m_len = 40960, m_callback = 0x55c908e48130
<io_callback(tpool::aiocb*)>, m_group = 0x55c90a62b1e0, m_ret_len = 0,
m_err = 125, m_internal = 0x0, m_internal_task = {_vptr.task =
0x55c9097a8038 <vtable for tpool::task+16>, m_func = 0x55c908e48130
<io_callback(tpool::aiocb*)>, m_arg = 0x55c90a6397b0, m_group =
0x55c90a62b1e0}, m_userdata = '\000' <repeats 16 times>,
"\250\257j\n\311U\000\000\031\000\000\000\000\000\000"}

So the error 125 is corresponding to a write, explicitly a io_uring_prep_writev

$ git grep io_uring_prep tpool/
tpool/aio_liburing.cc:      io_uring_prep_nop(sqe);
tpool/aio_liburing.cc:      io_uring_prep_readv(sqe, cb->m_fh,
static_cast<struct iovec *>(cb), 1,
tpool/aio_liburing.cc:      io_uring_prep_writev(sqe, cb->m_fh,
static_cast<struct iovec *>(cb), 1,

The error codes
https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html
document seems to indicate that when you get ECANCELED it should be
expected.

Should I expect it? Is it possible to tell why?



ref: https://jira.mariadb.org/browse/MDEV-27593
