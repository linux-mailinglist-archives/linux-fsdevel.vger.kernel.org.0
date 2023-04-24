Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C36EC676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjDXGpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXGpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:45:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E13AAE;
        Sun, 23 Apr 2023 23:45:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q4bHP1fyXz4f3tNf;
        Mon, 24 Apr 2023 14:45:37 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgCnmuiNJUZkr9fFHw--.41710S2;
        Mon, 24 Apr 2023 14:45:34 +0800 (CST)
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] bpf iterator for file-system
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, Nhat Pham <nphamcs@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>
References: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
 <CAOQ4uxggt_je51t0MWSfRS0o7UFSYj7GDHSJd026kMfF9TvLiA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <a1e5d6e0-4772-f42a-96b8-eccefdb6127e@huaweicloud.com>
Date:   Mon, 24 Apr 2023 14:45:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxggt_je51t0MWSfRS0o7UFSYj7GDHSJd026kMfF9TvLiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgCnmuiNJUZkr9fFHw--.41710S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUZrW7WFyUZF4kKF17KFg_yoW5KFW7pF
        WruF4rKr4kJw48Aw4vyayxXay0v34fuF47X3s5XrW5urWUZFna9wn7Kr15ZFyDCrs8CF1a
        vF4qk3s5tF98XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 4/16/2023 3:55 PM, Amir Goldstein wrote:
> On Tue, Feb 28, 2023 at 5:47 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From time to time, new syscalls have been proposed to gain more observability
>> for file-system:
>>
>> (1) getvalues() [0]. It uses a hierarchical namespace API to gather and return
>> multiple values in single syscall.
>> (2) cachestat() [1].  It returns the cache status (e.g., number of dirty pages)
>> of a given file in a scalable way.
>>
>> All these proposals requires adding a new syscall. Here I would like to propose
>> another solution for file system observability: bpf iterator for file system
>> object. The initial idea came when I was trying to implement a filefrag-like
>> page cache tool with support for multi-order folio, so that we can know the
>> number of multi-order folios and the orders of those folios in page cache. After
>> developing a demo for it, I realized that we could use it to provide more
>> observability for file system objects. e.g., dumping the per-cpu iostat for a
>> super block [2],  iterating all inodes in a super-block to dump info for
>> specific inodes (e.g., unlinked but pinned inode), or displaying the flags of a
>> specific mount.
>>
>> The BPF iterator was introduced in v5.8 [3] to support flexible content dumping
>> for kernel objects. It works by creating bpf iterator file [4], which is a
>> seq-like read-only file, and the content of the bpf iterator file is determined
>> by a previously loaded bpf program, so userspace can read the bpf iterator file
>> to get the information it needs. However there are some unresolved issues:
>> (1) The privilege.
>> Loading the bpf program requires CAP_ADMIN or CAP_BPF. This means that the
>> observability will be available to the privileged process. Maybe we can load the
>> bpf program through a privileged process and make the bpf iterator file being
>> readable for normal users.
>> (2) Prevent pinning the super-block
>> In the current naive implementation, the bpf iterator simply pins the
>> super-block of the passed fd and prevents the super-block from being destroyed.
>> Perhaps fs-pin is a better choice, so the bpf iterator can be deactivated after
>> the filesystem is umounted.
>>
>> I hope to send out an RFC soon before LSF/MM/BPF for further discussion.
> Hi Hou,
>
> IIUC, there is not much value in making this a cross track session.
> Seems like an FS track session that has not much to do with BPF
> development.
>
> Am I understanding correctly or are there any cross subsystem
> interactions that need to be discussed?
Yes. Although the patchset for file-system iterator is still not ready, but I
think the BPF mechanisms for file-system iterator is ready, so a cross track
session maybe unnecessary.
>
> Perhaps we can join you as co-speaker for Miklos' traditional
> "fsinfo" session?
Thanks. I am glad to be a co-speaker for fsinfo session.
>
> Thanks,
> Amir.
>
>> [0]:
>> https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com/
>> [1]: https://lore.kernel.org/linux-mm/20230219073318.366189-1-nphamcs@gmail.com/
>> [2]:
>> https://lore.kernel.org/linux-fsdevel/CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com/
>> [3]: https://lore.kernel.org/bpf/20200509175859.2474608-1-yhs@fb.com/
>> [4]: https://docs.kernel.org/bpf/bpf_iterators.html
>>
>> _______________________________________________
>> Lsf-pc mailing list
>> Lsf-pc@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc

