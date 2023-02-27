Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86B6A411E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB0LqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0LqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:46:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E576B6;
        Mon, 27 Feb 2023 03:46:17 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1ovMG41lSD-00boWg; Mon, 27
 Feb 2023 12:46:06 +0100
Message-ID: <ff610f19-7303-f583-4e22-e526f314aaa9@gmx.com>
Date:   Mon, 27 Feb 2023 19:46:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ylM7Vq/tUQMEC9teZ0ZtMQ9tPfkXKjI1Zrlu3amPUB7fYSlo5lV
 mnenh8LcRgV+ooSpQ5/3XWqmut0L5OfCkr0ImE/I6QfDWlWOqnBv9bISk/5yczvt0KxXlbe
 jSXwFsnMNgK9LbBuV/8SLrLpAWtI9jcDcKyyMGLTcNE6/7RKUAqItl4PEQIB++LC8soyyVR
 G81j4PNHvIn71g92pd6Wg==
UI-OutboundReport: notjunk:1;M01:P0:IpCkYFm37EY=;LxTxiti411uv1rJCByqzDnm2iax
 QJjjKb5jYi3WNCY6p/O4Zh6OEpFlWl5diNnVBMq81GXJJH8wwe8simxFR1Xv7pGbs2DPdqisp
 NssczCr3OiBObKC233rV0GAKmgZxGSm9+SN1YPCnHqBb30taEJ4Etj8oYZRxY21IhSYJ/MDr9
 2vZ8IKI/SlD9DLBW8w6PVXwZjlhybYEYPZFMa9xgtbrvvMk6tUTWPfx7HJxbz0/OJoUA5jR5B
 6QhMdlIFKIHdJ8FFD2LtItk0JuyOXcb2Nk53TBtP9XXc6k6MREW0A4aGX2mBbcA7vuJl7eT1r
 egAUF1VAbpvd1oCPDJ1DQQ9YAroo/kBa3zH3K+VQkKzlveonqQ996d7lgV37/jkOJUb1G08UR
 bu103z6+Ud6eAhsoZDUE7MlpQiWCSEBfIJXTH8Ne/wxaziBNIXeCQHoZXD6wo8RzaedV5odXl
 fWjOInk09dXnsthu1sj/GXqYf5sCiXgZC9OfC50Zwkv89hlgQ1sS9l9zulakOebN3LMbusuX3
 fQO8AzbpsM46WETvWCG62CqhLmr2WxSCIfMi+347Xtq0lqzOib8XOFx1g5H+LLRobu07T9lKg
 HdzsWd6X2/g5PhfRxdWne7YVex+tKeMbhid5zY2FfXm8MbA0t7Q/IadlyM8QhFmyhx5ioRLb7
 tCOKBKBHS2a/W4Tvxvs73/DLmQwQxOuRp9M8Bgd0GClDvWsqsDJWRC0pE2OQiPsYIjQemAnwT
 +s8/iAOIgNY/A3uFYrK149sV/qvxRmY/fgpzlst+iioaNff4HEyfxqm4jkq5dtiS6DigqzfPQ
 CoCaYAXjr/8PZdAuaeVL6Sb73aiHNo7eZZax9T4ocJbgfERSDS2mza+F+BwCOtwJG7tfpO/XM
 o5nqWnvyMxO3Jh4D9OWT/uZfa5w8rZ4V7cWt8sSWOsINsnmDb+3DwpSHDeGdb7ly9PX9xqdUB
 hiU+DKdM4GnzDyLcJdUWemiqiEc=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/27 19:02, Filipe Manana wrote:
> On Sun, Feb 26, 2023 at 4:31 PM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>>
>> Hi,
>>
>> This is an RFC patchset that introduces the `wq_cpu_set` mount option.
>> This option lets the user specify a CPU set that the Btrfs workqueues
>> will use.
>>
>> Btrfs workqueues can slow sensitive user tasks down because they can use
>> any online CPU to perform heavy workloads on an SMP system. Add a mount
>> option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
>> to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.
>>
>> This option is similar to the taskset bitmask except that the comma
>> separator is replaced with a dot. The reason for this is that the mount
>> option parser uses commas to separate mount options.
>>
>> Figure (the CPU usage when `wq_cpu_set` is used VS when it is not):
>> https://gist.githubusercontent.com/ammarfaizi2/a10f8073e58d1712c1ed49af83ae4ad1/raw/a4f7cbc4eb163db792a669d570ff542495e8c704/wq_cpu_set.png
> 
> I haven't read the patchset.
> 
> It's great that it reduces CPU usage.
> But does it also provide other performance benefits, like lower
> latency or higher throughput for some workloads? Or using less CPU
> also affects negatively in those other aspects?

So far it looks like to just set CPU masks for each workqueue.

Thus if it's reducing CPU usage, it also takes longer time to finish the 
workload (compression,csum calculation etc).

Thanks,
Qu
> 
> Thanks.
> 
>>
>> A simple stress testing:
>>
>> 1. Open htop.
>> 2. Open a new terminal.
>> 3. Mount and perform a heavy workload on the mounted Btrfs filesystem.
>>
>> ## Test without wq_cpu_set
>> sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500 /dev/sda2 hdd/a;
>> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
>> sync; # See the CPU usage in htop.
>> sudo umount hdd/a;
>>
>> ## Test wq_cpu_set
>> sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500,wq_cpu_set=0.4.1.5 /dev/sda2 hdd/a;
>> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
>> sync; # See the CPU usage in htop.
>> sudo umount hdd/a;
>>
>> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>> ---
>>
>> Ammar Faizi (6):
>>    workqueue: Add set_workqueue_cpumask() helper function
>>    btrfs: Change `mount_opt` type in `struct btrfs_fs_info` to `u64`
>>    btrfs: Create btrfs CPU set struct and helpers
>>    btrfs: Add wq_cpu_set=%s mount option
>>    btrfs: Adjust the default thread pool size when `wq_cpu_set` option is used
>>    btrfs: Add `BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE` macro
>>
>>   fs/btrfs/async-thread.c   | 51 ++++++++++++++++++++
>>   fs/btrfs/async-thread.h   |  3 ++
>>   fs/btrfs/disk-io.c        |  6 ++-
>>   fs/btrfs/fs.c             | 97 +++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/fs.h             | 12 ++++-
>>   fs/btrfs/super.c          | 83 +++++++++++++++++++++++++++++++++
>>   include/linux/workqueue.h |  3 ++
>>   kernel/workqueue.c        | 19 ++++++++
>>   8 files changed, 271 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
>> --
>> Ammar Faizi
>>
