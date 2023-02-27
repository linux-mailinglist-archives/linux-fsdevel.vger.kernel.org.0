Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4F6A3F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 11:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjB0KTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjB0KTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:19:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9B1F5D2;
        Mon, 27 Feb 2023 02:19:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b2T-1pPC4c270H-00802Z; Mon, 27
 Feb 2023 11:18:52 +0100
Message-ID: <19732428-010d-582c-0aed-9dd09b11d403@gmx.com>
Date:   Mon, 27 Feb 2023 18:18:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JbM6s3z0l4ewyElw/gqcSOTOrzWaq+K0jdbbtjIdkQOdF4cbDhZ
 8pdh5Vw30A4+GJOdIAful6AbCkj+8iONvUbXBFlsbomvkbKiIdLUdyiDM4ztKT87dBWIyqH
 wAlL8AYm9qCq/xOwbNRSJEz0H3jM31raJ3x3IEci/hX8tIN7t41s6C0GmAT6EioyMlTEMaq
 OUbnEZ9a+ljqFXpwPqWsQ==
UI-OutboundReport: notjunk:1;M01:P0:35d9LmNg8yU=;/CUK1h2oJFUqC6BOq7G6cYiFCbH
 WAzjtIZzvRGiTpS15eyWlmmQ2vlWTFotzDVOFyviVB6aDcdJ/xUmKkRx9cfcyh7TSGhkVLmOT
 wmQAWjrVRG62gu2rgYNiIKOVgtfmD74N/AVrU2OovMToLIgz9BxJ7WuhqlZINN0LTFffUyuv1
 TCw3IFrjjPlYqjGfTW+c0DqhialaeZtNktvN29tctWjyv2sMzAXyu5VGdapZj/k840AMKo81O
 PsYMuC9yyN+0vVW2gWfbZywNeHVOhY1ZQImDHBEU0bm+e9GNrMbA8vjCVbb3yVlxij9KzyQbV
 zTFgIPN9FbXzw8XmobXTGbseMfyCXkdYrRKcw57nTJLqSdjumEE52KmNwihD1MFeTiorNjr+t
 CAEB/DnLZnGIB10Np/oPU/LNq2SwPMUBvdFyl9WsQw7VdSiu6K+Hp9fi+lAnDwJ/Dv9neX4vK
 LaSNwegP9F7amyaVYf9zMbPHBGyctcQzN7+Dee5tqCxGYynS0oQGNrEdzjkXKqwMd6RcsMvuZ
 YBX0NcMITKPWKN1kTWMZ7jzqjImY2cluMtzkuwMgO+CZFdPsRoMbCZpZjl2JS+GPJvvC/ttPM
 hyt3nD2OWSKAwZaVfCqf7tx54M85MLJhLdfUDYuQMm0JOfCqEGhNRf+iI+X8U+1SITFhbBtEv
 +9DZ8vJWH0tzYrNn2EByOQWp9tOHhsHwxfiIeswi5lwwjiQxNymiFHtwbSsifyd17hdKL+gof
 3Y+8bmBHj9VPn+haNgfFOED6TqvJ1MJoDhx+NRrpQ9DfeVi6aWTVvw2XqybBDsANsxo5XqI9t
 DlwAk7CpzIMTM1c+S+wsIysEt08R/P7+e7PM+pQgZEbrSujAfvYJLE4oAREwnuFuyMTgpqoxF
 r/SKFazJ8S/3oOckCR1cC06RTAR6LxZFKF6m75NGXHcf+sELv1xNzprKUFoEKXcaEEuGA2lwQ
 ao45ROriAG36+Fyl1ZwB3oeASV4=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/27 00:02, Ammar Faizi wrote:
> Hi,
> 
> This is an RFC patchset that introduces the `wq_cpu_set` mount option.
> This option lets the user specify a CPU set that the Btrfs workqueues
> will use.
> 
> Btrfs workqueues can slow sensitive user tasks down because they can use
> any online CPU to perform heavy workloads on an SMP system. Add a mount
> option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
> to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.

I'm not sure if pinning the wq is really the best way to your problem.

Yes, I understand you want to limit the CPU usage of btrfs workqueues, 
but have you tried "thread_pool=" mount option?

That mount option should limit the max amount of in-flight work items, 
thus at least limit the CPU usage.

For the wq CPU pinning part, I'm not sure if it's really needed, 
although it's known CPU pinning can affect some performance characteristics.

Thanks,
Qu

> 
> This option is similar to the taskset bitmask except that the comma
> separator is replaced with a dot. The reason for this is that the mount
> option parser uses commas to separate mount options.
> 
> Figure (the CPU usage when `wq_cpu_set` is used VS when it is not):
> https://gist.githubusercontent.com/ammarfaizi2/a10f8073e58d1712c1ed49af83ae4ad1/raw/a4f7cbc4eb163db792a669d570ff542495e8c704/wq_cpu_set.png
> 
> A simple stress testing:
> 
> 1. Open htop.
> 2. Open a new terminal.
> 3. Mount and perform a heavy workload on the mounted Btrfs filesystem.
> 
> ## Test without wq_cpu_set
> sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500 /dev/sda2 hdd/a;
> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
> sync; # See the CPU usage in htop.
> sudo umount hdd/a;
> 
> ## Test wq_cpu_set
> sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500,wq_cpu_set=0.4.1.5 /dev/sda2 hdd/a;
> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
> sync; # See the CPU usage in htop.
> sudo umount hdd/a;
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> 
> Ammar Faizi (6):
>    workqueue: Add set_workqueue_cpumask() helper function
>    btrfs: Change `mount_opt` type in `struct btrfs_fs_info` to `u64`
>    btrfs: Create btrfs CPU set struct and helpers
>    btrfs: Add wq_cpu_set=%s mount option
>    btrfs: Adjust the default thread pool size when `wq_cpu_set` option is used
>    btrfs: Add `BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE` macro
> 
>   fs/btrfs/async-thread.c   | 51 ++++++++++++++++++++
>   fs/btrfs/async-thread.h   |  3 ++
>   fs/btrfs/disk-io.c        |  6 ++-
>   fs/btrfs/fs.c             | 97 +++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/fs.h             | 12 ++++-
>   fs/btrfs/super.c          | 83 +++++++++++++++++++++++++++++++++
>   include/linux/workqueue.h |  3 ++
>   kernel/workqueue.c        | 19 ++++++++
>   8 files changed, 271 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
