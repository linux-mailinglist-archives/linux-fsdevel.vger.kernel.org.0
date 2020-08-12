Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD024264C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgHLHvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgHLHvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:51:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F168C06174A;
        Wed, 12 Aug 2020 00:51:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so621863pgb.2;
        Wed, 12 Aug 2020 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9NU0scmr3kWjlrmAUXZmqrzEF6gKrvc9pr3irQHvDyo=;
        b=DrRU/KTccW1jA5hOI0+sRPOrj574fhAzVO6xqnfsnV8Nt2qeqOTWwTQj0pS81VV0B9
         2YWfO+VddNETI+OYzPZZFliZ5NCYpom1p6s4CPYkfxNrHa3OAFimubcRzwC2WhmqGAlQ
         2KdwHkFrPt4VYQaMtar8ejkOyc6BDOqm/qbuDcJ71cDgO75hdvlhsAi+lOG83RE6cUYY
         5H71EDoeriq6eAw7E9nHMnxEp5w5tIwuqUQlY+4gvU6Wp9p+qa4PTpALAtNoViDWXmKr
         DI+rJ8uCmzC21c8pqiprGr2bG5JwyCsMuKcu0848UbT86kCh8SEqqwuhPzTYxgJ4nwGT
         /SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NU0scmr3kWjlrmAUXZmqrzEF6gKrvc9pr3irQHvDyo=;
        b=SzEahXG/1doNO0dUb+GNoplZ+VhrqVWTpU/891BRbKEj9+e8FR1zWyxjfN6I3elIjp
         M2ZcjPn5acPW5v35P4O5VA4gC3mIDIHH/hzZZhm0WqXGWFZiA0YiG3XrHm/j9tfdUE66
         o6yK2urpurB0e6u35P017aT3idDxT4F8/bQTPKxqwDoHBZhQF5tpIHfSCWJcpiWZxn4x
         JbT6C1ogx2L4s/uLk1pXZzYxyOSQIFxKFoAuFX6DhUJyN4SAcCeSvJl2gmCZg1DcKnQf
         O3hAgh5BrV3uWsGL3KhK862lWo2f2VCAR4oNPlH3A9z8As1bfdf4mxNMqZHHW3NpBUwn
         pnFQ==
X-Gm-Message-State: AOAM531HN1jLgbsNS+4Qp1WUz1GwCDoB80XUCtTs5PsMRWH4a3w5782A
        uCD5DiLoiJLvDAt04/RoVeE=
X-Google-Smtp-Source: ABdhPJyd+8rRKbNVEr9rvE2gMzKoZ+dOoB7/Yr+hiINwFC/k7O/ULtSNio+3YZcUQpQ6BMBNBr/GNg==
X-Received: by 2002:a63:d250:: with SMTP id t16mr4014531pgi.51.1597218697914;
        Wed, 12 Aug 2020 00:51:37 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id t10sm1379108pgp.15.2020.08.12.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:51:36 -0700 (PDT)
Date:   Wed, 12 Aug 2020 00:51:35 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Eugene Lubarsky <elubarsky.linux@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200812075135.GA191218@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:58:47AM +1000, Eugene Lubarsky wrote:
> This is an idea for substantially reducing the number of syscalls needed
> by monitoring tools whilst mostly re-using the existing API.
> 
> The proposed files in this proof-of-concept patch set are:
> 
> * /proc/all/stat
>       A stat line for each process in the existing format.
> 
> * /proc/all/statm
>       statm lines but starting with a PID column.
> 
> * /proc/all/status
>       status info for all processes in the existing format.
> 
> * /proc/all/io
>       The existing /proc/pid/io data but formatted as a single line for
>       each process, similarly to stat/statm, with a PID column added.
> 
> * /proc/all/statx
>       Gathers info from stat, statm and io; the purpose is actually
>       not so much to reduce syscalls but to help userspace be more
>       efficient by not having to store data in e.g. hashtables in order
>       to gather it from separate /proc/all/ files.
> 
>       The format proposed here starts with the unchanged stat line
>       and begins the other info with a few characters, repeating for
>       each process:
> 
>       ...
>       25 (cat) R 1 1 0 0 -1 4194304 185 0 16 0 2 0 0 0 20 ...
>       m 662 188 167 5 0 112 0
>       io 4292 0 12 0 0 0 0
>       ...
> 
> 
> There has been a proposal with some overlapping goals: /proc/task-diag
> (https://github.com/avagin/linux-task-diag), but I'm not sure about
> its current status.

I rebased the task_diag patches on top of v5.8:
https://github.com/avagin/linux-task-diag/tree/v5.8-task-diag

/proc/pid files have three major limitations:
* Requires at least three syscalls per process per file
  open(), read(), close()
* Variety of formats, mostly text based
  The kernel spent time to encode binary data into a text format and
  then tools like top and ps spent time to decode them back to a binary
  format.
* Sometimes slow due to extra attributes
  For example, /proc/PID/smaps contains a lot of useful informations
  about memory mappings and memory consumption for each of them. But
  even if we don't need memory consumption fields, the kernel will
  spend time to collect this information.

More details and numbers are in this article:
https://avagin.github.io/how-fast-is-procfs

This new interface doesn't have only one of these limitations, but
task_diag doesn't have all of them.

And I compared how fast each of these interfaces:

The test environment:
CPU: Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
RAM: 16GB
kernel: v5.8 with task_diag and /proc/all patches.
100K processes:
$ ps ax | wc -l
10228

$ time cat /proc/all/status > /dev/null

real	0m0.577s
user	0m0.017s
sys	0m0.559s

task_proc_all is used to read /proc/pid/status for all tasks:
https://github.com/avagin/linux-task-diag/blob/master/tools/testing/selftests/task_diag/task_proc_all.c

$ time ./task_proc_all status
tasks: 100230

real	0m0.924s
user	0m0.054s
sys	0m0.858s


/proc/all/status is about 40% faster than /proc/*/status.

Now let's take a look at the perf output:

$ time perf record -g cat /proc/all/status > /dev/null
$ perf report
-   98.08%     1.38%  cat      [kernel.vmlinux]  [k] entry_SYSCALL_64
   - 96.70% entry_SYSCALL_64
      - do_syscall_64
         - 94.97% ksys_read
            - 94.80% vfs_read
               - 94.58% proc_reg_read
                  - seq_read
                     - 87.95% proc_pid_status
                        + 13.10% seq_put_decimal_ull_width
                        - 11.69% task_mem
                           + 9.48% seq_put_decimal_ull_width
                        + 10.63% seq_printf
                        - 10.35% cpuset_task_status_allowed
                           + seq_printf
                        - 9.84% render_sigset_t
                             1.61% seq_putc
                           + 1.61% seq_puts
                        + 4.99% proc_task_name
                        + 4.11% seq_puts
                        - 3.76% render_cap_t
                             2.38% seq_put_hex_ll
                           + 1.25% seq_puts
                          2.64% __task_pid_nr_ns
                        + 1.54% get_task_mm
                        + 1.34% __lock_task_sighand
                        + 0.70% from_kuid_munged
                          0.61% get_task_cred
                          0.56% seq_putc
                          0.52% hugetlb_report_usage
                          0.52% from_kgid_munged
                     + 4.30% proc_all_next
                     + 0.82% _copy_to_user 

We can see that the kernel spent more than 50% of the time to encode binary
data into a text format.

Now let's see how fast task_diag:

$ time ./task_diag_all all -c -q

real	0m0.087s
user	0m0.001s
sys	0m0.082s

Maybe we need resurrect the task_diag series instead of inventing
another less-effective interface...

Thanks,
Andrei

> 
> 
> 
> Best Wishes,
> 
> Eugene
> 
> 
> Eugene Lubarsky (5):
>   fs/proc: Introduce /proc/all/stat
>   fs/proc: Introduce /proc/all/statm
>   fs/proc: Introduce /proc/all/status
>   fs/proc: Introduce /proc/all/io
>   fs/proc: Introduce /proc/all/statx
> 
>  fs/proc/base.c     | 215 +++++++++++++++++++++++++++++++++++++++++++--
>  fs/proc/internal.h |   1 +
>  fs/proc/root.c     |   1 +
>  3 files changed, 210 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1
> 
