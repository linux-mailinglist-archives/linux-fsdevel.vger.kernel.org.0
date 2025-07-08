Return-Path: <linux-fsdevel+bounces-54207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE300AFC08F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800AE189F850
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8BC21C9E7;
	Tue,  8 Jul 2025 02:11:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48636217F34;
	Tue,  8 Jul 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940694; cv=none; b=q5/AYbB/Qwn6BJRvDkE1bh8gNDXCx61tFuIxg2ToPF/WuOMBa6RQhhFTMkJY3C7RTGJmSCD2vcb82PJz4sGFSWZdo1o3iLNswy3XuoZapQuJT2k0dg5T/GJV7d4i9o9CS/3xRUJj/vaK4v2HscCKc07hWMUpsJ9satSI/hvotmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940694; c=relaxed/simple;
	bh=/ZaA0gW2tRVZAnlXgh8+Tgwg9uThks4N84qAFsHXznk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkA/ac/fDBuRZXwImpKVHHrm9JMa4Qpj4bPAQeVkCZZTtc6Qjk9oO8tsgQYx0bIsaBOwo/xYUwGzJVrRP4YDl8LAzI/e2JebP2Gqc6V+NescBxBpelRo4UJaKgzZLG1udNCk2oBP11B9jcGHvEtBcTnsl+n/+KuJ3ZoeY9wnr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bbl350MKbzYQv0c;
	Tue,  8 Jul 2025 10:11:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D5C591A0F85;
	Tue,  8 Jul 2025 10:11:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgA3mSZJfmxoAK0BBA--.64195S3;
	Tue, 08 Jul 2025 10:11:23 +0800 (CST)
Message-ID: <683b8d88-0ded-476f-9ed0-bd76a0c3128f@huaweicloud.com>
Date: Tue, 8 Jul 2025 10:11:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250626: WARNING fs jbd2 transaction.c start_this_handle
 with ARM64_64K_PAGES
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Joseph Qi <jiangqi903@gmail.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3mSZJfmxoAK0BBA--.64195S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw43Zry5uF17XrWkJFyUAwb_yoWxZFWxpa
	43tF1UKr40vr1xJrW0q3WFqryUtr1qyFykJrnFqr18GFnFvF18JFWIgryrKF9rJ348u34x
	Ar4qk3srKr4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/3 15:26, Naresh Kamboju wrote:
> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> Hi, Naresh!
>>
>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>
>>> Not reproducible with 4K page size.
>>>
>>> Test environments:
>>> - Dragonboard-410c
>>> - Juno-r2
>>> - rk3399-rock-pi-4b
>>> - qemu-arm64
>>>
>>> Regression Analysis:
>>> - New regression? Yes
>>> - Reproducibility? Yes
>>>
>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>> transaction.c start_this_handle
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Thank you for the report. The block size for this test is 1 KB, so I
>> suspect this is the issue with insufficient journal credits that we
>> are going to resolve.
> 
> I have applied your patch set [1] and tested and the reported
> regressions did not fix.
> Am I missing anything ?
> 
> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
> 

Hi, Naresh and Joseph!

Thanks to Jan's assistance, I've fixed this issue in my latest series
and both tests passed on my machine. Could you please give it a try?

https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.


>>>
>>> ## Test log
>>> <6>[   89.498969] loop0: detected capacity change from 0 to 614400
>>> <3>[   89.609561] operation not supported error, dev loop0, sector
>>> 20352 op 0x9:(WRITE_ZEROES) flags 0x20000800 phys_seg 0 prio class 0
>>> <6>[   89.707795] EXT4-fs (loop0): mounted filesystem
>>> 6786a191-5e0d-472b-8bce-4714e1a4fb44 r/w with ordered data mode. Quota
>>> mode: none.
>>> <3>[   90.023985] JBD2: kworker/u8:2 wants too many credits
>>> credits:416 rsv_credits:21 max:334
>>> <4>[   90.024973] ------------[ cut here ]------------
>>> <4>[ 90.025062] WARNING: fs/jbd2/transaction.c:334 at
>>> start_this_handle+0x4c0/0x4e0, CPU#0: 2/42
>>> <4>[   90.026661] Modules linked in: btrfs blake2b_generic xor
>>> xor_neon raid6_pq zstd_compress sm3_ce sha3_ce fuse drm backlight
>>> ip_tables x_tables
>>> <4>[   90.027952] CPU: 0 UID: 0 PID: 42 Comm: kworker/u8:2 Not tainted
>>> 6.16.0-rc3-next-20250626 #1 PREEMPT
>>> <4>[   90.029043] Hardware name: linux,dummy-virt (DT)
>>> <4>[   90.029524] Workqueue: writeback wb_workfn (flush-7:0)
>>> <4>[   90.030050] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
>>> -SSBS BTYPE=--)
>>> <4>[ 90.030311] pc : start_this_handle (fs/jbd2/transaction.c:334
>>> (discriminator 1))
>>> <4>[ 90.030481] lr : start_this_handle (fs/jbd2/transaction.c:334
>>> (discriminator 1))
>>> <4>[   90.030656] sp : ffffc000805cb650
>>> <4>[   90.030785] x29: ffffc000805cb690 x28: fff00000dd1f5000 x27:
>>> ffffde2ec0272000
>>> <4>[   90.031097] x26: 00000000000001a0 x25: 0000000000000015 x24:
>>> 0000000000000002
>>> <4>[   90.031360] x23: 0000000000000015 x22: 0000000000000c40 x21:
>>> 0000000000000008
>>> <4>[   90.031618] x20: fff00000c231da78 x19: fff00000c231da78 x18:
>>> 0000000000000000
>>> <4>[   90.031875] x17: 0000000000000000 x16: 0000000000000000 x15:
>>> 0000000000000000
>>> <4>[   90.032859] x14: 0000000000000000 x13: 00000000ffffffff x12:
>>> 0000000000000000
>>> <4>[   90.033225] x11: 0000000000000000 x10: ffffde2ebfba8bd0 x9 :
>>> ffffde2ebd34e944
>>> <4>[   90.033607] x8 : ffffc000805cb278 x7 : 0000000000000000 x6 :
>>> 0000000000000001
>>> <4>[   90.033971] x5 : ffffde2ebfb29000 x4 : ffffde2ebfb293d0 x3 :
>>> 0000000000000000
>>> <4>[   90.034294] x2 : 0000000000000000 x1 : fff00000c04dc080 x0 :
>>> 000000000000004c
>>> <4>[   90.034772] Call trace:
>>> <4>[ 90.035068] start_this_handle (fs/jbd2/transaction.c:334
>>> (discriminator 1)) (P)
>>> <4>[ 90.035366] jbd2__journal_start (fs/jbd2/transaction.c:501)
>>> <4>[ 90.035586] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
>>> <4>[ 90.035807] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242
>>> fs/ext4/inode.c:2846)
>>> <4>[ 90.036004] ext4_writepages (fs/ext4/inode.c:2953)
>>> <4>[ 90.036233] do_writepages (mm/page-writeback.c:2636)
>>> <4>[ 90.036406] __writeback_single_inode (fs/fs-writeback.c:1680)
>>> <4>[ 90.036616] writeback_sb_inodes (fs/fs-writeback.c:1978)
>>> <4>[ 90.036891] wb_writeback (fs/fs-writeback.c:2156)
>>> <4>[ 90.037122] wb_workfn (fs/fs-writeback.c:2303 (discriminator 1)
>>> fs/fs-writeback.c:2343 (discriminator 1))
>>> <4>[ 90.037318] process_one_work (kernel/workqueue.c:3244)
>>> <4>[ 90.037517] worker_thread (kernel/workqueue.c:3316 (discriminator
>>> 2) kernel/workqueue.c:3403 (discriminator 2))
>>> <4>[ 90.037752] kthread (kernel/kthread.c:463)
>>> <4>[ 90.037903] ret_from_fork (arch/arm64/kernel/entry.S:863)
>>> <4>[   90.038217] ---[ end trace 0000000000000000 ]---
>>> <2>[   90.039950] EXT4-fs (loop0): ext4_do_writepages: jbd2_start:
>>> 9223372036854775807 pages, ino 14; err -28
>>> <3>[   90.040291] JBD2: kworker/u8:2 wants too many credits
>>> credits:416 rsv_credits:21 max:334
>>> <4>[   90.040374] ------------[ cut here ]------------
>>> <4>[ 90.040386] WARNING: fs/jbd2/transaction.c:334 at
>>> start_this_handle+0x4c0/0x4e0, CPU#1: 2/42
>>>
>>>
>>> ## Source
>>> * Kernel version: 6.16.0-rc3-next-20250626
>>> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
>>> * Git sha: ecb259c4f70dd5c83907809f45bf4dc6869961d7
>>> * Git describe: 6.16.0-rc3-next-20250626
>>> * Project details:
>>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250626/
>>> * Architectures: arm64
>>> * Toolchains: gcc-13
>>> * Kconfigs: gcc-13-lkftconfig-64k_page_size
>>>
>>> ## Build arm64
>>> * Test log: https://qa-reports.linaro.org/api/testruns/28894530/log_file/
>>> * Test LAVA log 1:
>>> https://lkft.validation.linaro.org/scheduler/job/8331353#L6841
>>> * Test LAVA log 2:
>>> https://lkft.validation.linaro.org/scheduler/job/8331352#L8854
>>> * Test details:
>>> https://regressions.linaro.org/lkft/linux-next-master/next-20250626/log-parser-test/exception-warning-fsjbd2transaction-at-start_this_handle/
>>> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/
>>> * Kernel config:
>>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2z2V7LhiJecGzINkU7ObVQTwoR1/config
>>>
>>> --
>>> Linaro LKFT
>>> https://lkft.linaro.org
>>>
>>
> 
> 


