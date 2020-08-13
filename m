Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF7243369
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 06:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHMErk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 00:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHMErk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:47:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B33CC061757;
        Wed, 12 Aug 2020 21:47:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u63so3960184oie.5;
        Wed, 12 Aug 2020 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P5qGXqY4B6jxs45zEVwsoy58xzyNkr68QDhLB9YgyZY=;
        b=Y8LL+CRJ4cXTSKp/XCADQUXdcZb9KVdYxJ4iMgbDchHwjW+nYtivIH2ODZ1PYLIDeg
         HtL8+sB36igoD+Etu/8qf3/tbZpBIAyL7TJg9hlneZMe5c0FrgOBNhJicKzOyBIPV39d
         A1TLWoF8A9w5NySrqZlaDR2jKwrauk2ejRD0KkC8WEBE80Tl70MN8Rr/q4wYZu7ivx/H
         4t2EiPE/T3feJt4PPwLTDvX31ru2lCu7OtJbTHQaReR9x9ZB4uLMmOyd/yz30CmzRT2U
         Muqz/vFEuuNSoeuvIr/NQDvbPuwWtuj7kAv3ujFrXTzp//Zl8i1i6gcU28zkCLgJeuIl
         AtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5qGXqY4B6jxs45zEVwsoy58xzyNkr68QDhLB9YgyZY=;
        b=nb+qsxoGXxvBoJWsJ6xDRWLTWkA+YBnCUFm7ScPAh1c2TVbcJfGxNbG4qJDWjU4GTc
         fyD5v2x03CbzYGH2019QIGR3h/7KuaqAcmcNkr4O6UUFQA0KjK//SsmMnOOgnxQX7ytl
         90YqFy5vmuQuXka8eq/Y8Hd90qcGAyXvybLgXvyrPo/83kVw4q5Rg3Z/t98yX39SlKIA
         F0+dkWCjLUC0crCL3NazwC7/Ej4MZDzxxK1CXow1p9cdlsSSb3YPjwv4dag8gfbpyHjx
         H9UQF4WtS8p9RTXQkc588YgmKFszQPJCJflS0FG1UmJYT//xLajfVOwpEbAyDMrPgIJm
         itqw==
X-Gm-Message-State: AOAM5334ML2iFgu4vaLWoz/b03S+Semqg5+sVSAuPnm3StuM6Zzqhhgr
        jt9vLGdjm0nE3wZnecKkqGa9Tz0ZH+Y=
X-Google-Smtp-Source: ABdhPJx07O7Chz+nhvVjdMSTSv2nuLsJZgjaip302sCRH7Uo8XBe5jeAfF7CErYD8Wv5mFQ6F6hzTg==
X-Received: by 2002:aca:4b54:: with SMTP id y81mr2041475oia.54.1597294059320;
        Wed, 12 Aug 2020 21:47:39 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:282:803:7700:c1d8:5dca:975d:16e])
        by smtp.googlemail.com with ESMTPSA id f138sm977933oig.17.2020.08.12.21.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 21:47:38 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
To:     Andrei Vagin <avagin@gmail.com>,
        Eugene Lubarsky <elubarsky.linux@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
 <20200812075135.GA191218@gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <ffc908a7-c94b-56e6-8bb6-c47c52747d77@gmail.com>
Date:   Wed, 12 Aug 2020 22:47:32 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812075135.GA191218@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/20 1:51 AM, Andrei Vagin wrote:
> 
> I rebased the task_diag patches on top of v5.8:
> https://github.com/avagin/linux-task-diag/tree/v5.8-task-diag

Thanks for updating the patches.

> 
> /proc/pid files have three major limitations:
> * Requires at least three syscalls per process per file
>   open(), read(), close()
> * Variety of formats, mostly text based
>   The kernel spent time to encode binary data into a text format and
>   then tools like top and ps spent time to decode them back to a binary
>   format.
> * Sometimes slow due to extra attributes
>   For example, /proc/PID/smaps contains a lot of useful informations
>   about memory mappings and memory consumption for each of them. But
>   even if we don't need memory consumption fields, the kernel will
>   spend time to collect this information.

that's what I recall as well.

> 
> More details and numbers are in this article:
> https://avagin.github.io/how-fast-is-procfs
> 
> This new interface doesn't have only one of these limitations, but
> task_diag doesn't have all of them.
> 
> And I compared how fast each of these interfaces:
> 
> The test environment:
> CPU: Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
> RAM: 16GB
> kernel: v5.8 with task_diag and /proc/all patches.
> 100K processes:
> $ ps ax | wc -l
> 10228

100k processes but showing 10k here??

> 
> $ time cat /proc/all/status > /dev/null
> 
> real	0m0.577s
> user	0m0.017s
> sys	0m0.559s
> 
> task_proc_all is used to read /proc/pid/status for all tasks:
> https://github.com/avagin/linux-task-diag/blob/master/tools/testing/selftests/task_diag/task_proc_all.c
> 
> $ time ./task_proc_all status
> tasks: 100230
> 
> real	0m0.924s
> user	0m0.054s
> sys	0m0.858s
> 
> 
> /proc/all/status is about 40% faster than /proc/*/status.
> 
> Now let's take a look at the perf output:
> 
> $ time perf record -g cat /proc/all/status > /dev/null
> $ perf report
> -   98.08%     1.38%  cat      [kernel.vmlinux]  [k] entry_SYSCALL_64
>    - 96.70% entry_SYSCALL_64
>       - do_syscall_64
>          - 94.97% ksys_read
>             - 94.80% vfs_read
>                - 94.58% proc_reg_read
>                   - seq_read
>                      - 87.95% proc_pid_status
>                         + 13.10% seq_put_decimal_ull_width
>                         - 11.69% task_mem
>                            + 9.48% seq_put_decimal_ull_width
>                         + 10.63% seq_printf
>                         - 10.35% cpuset_task_status_allowed
>                            + seq_printf
>                         - 9.84% render_sigset_t
>                              1.61% seq_putc
>                            + 1.61% seq_puts
>                         + 4.99% proc_task_name
>                         + 4.11% seq_puts
>                         - 3.76% render_cap_t
>                              2.38% seq_put_hex_ll
>                            + 1.25% seq_puts
>                           2.64% __task_pid_nr_ns
>                         + 1.54% get_task_mm
>                         + 1.34% __lock_task_sighand
>                         + 0.70% from_kuid_munged
>                           0.61% get_task_cred
>                           0.56% seq_putc
>                           0.52% hugetlb_report_usage
>                           0.52% from_kgid_munged
>                      + 4.30% proc_all_next
>                      + 0.82% _copy_to_user 
> 
> We can see that the kernel spent more than 50% of the time to encode binary
> data into a text format.
> 
> Now let's see how fast task_diag:
> 
> $ time ./task_diag_all all -c -q
> 
> real	0m0.087s
> user	0m0.001s
> sys	0m0.082s
> 
> Maybe we need resurrect the task_diag series instead of inventing
> another less-effective interface...

I think the netlink message design is the better way to go. As system
sizes continue to increase (> 100 cpus is common now) you need to be
able to pass the right data to userspace as fast as possible to keep up
with what can be a very dynamic userspace and set of processes.

When you first proposed this idea I was working on systems with >= 1k
cpus and the netlink option was able to keep up with a 'make -j N' on
those systems. `perf record` walking /proc would never finish
initializing - I had to add a "done initializing" message to know when
to start a test. With the task_diag approach, perf could collect the
data in short order and move on to recording data.

