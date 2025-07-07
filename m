Return-Path: <linux-fsdevel+bounces-54044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3622AFAAB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF3217638A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CD2620FC;
	Mon,  7 Jul 2025 05:03:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A63594C;
	Mon,  7 Jul 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864589; cv=none; b=FS5yaYEJ5gjtznz6jTN1iiOvY0ScJcJuwOefCATIxHK5kXxt+iJHYzA6KylMzXOtS6cFJm9d1SKbQsvNtDnhj6y+fG2vrQwELWbqZHKUdasEyKKp55WNAbFW7KrcGXNDwY5GZTZjEQcuDUnFgfcDrLD1zmIvaUPHp7ndqXlmCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864589; c=relaxed/simple;
	bh=qau8kLo7RA0oR8tZ7uNWb49Vo54Zep7OP61bVD0/SQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6niKnSf0mQzoM0VmHw1C6A7xaVLIwklD7B0bM3Mnim62xXMIOh0/Rp0H+oS2cLAozvZMKuJEBarn1hsoVorD/UuXEivuCh9J+eVXr1QnTrDakcXl5aX6y2cC/i8e2iJrkLHlSUy2m1KTBEcKMQvcl789Jwc8RrRJuF6fIg09vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bbBvY2DRszYQvKW;
	Mon,  7 Jul 2025 13:03:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 242A11A019B;
	Mon,  7 Jul 2025 13:03:04 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgB3JSMHVWto_lGhAw--.4001S3;
	Mon, 07 Jul 2025 13:03:03 +0800 (CST)
Message-ID: <a5726ab3-99ed-430a-a883-d04e972b6e76@huaweicloud.com>
Date: Mon, 7 Jul 2025 13:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250626: WARNING fs jbd2 transaction.c start_this_handle
 with ARM64_64K_PAGES
To: Joseph Qi <jiangqi903@gmail.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
 <094a1420-9060-4dcf-9398-8873193f5f7b@huaweicloud.com>
 <5db1e0c2-a192-4883-9535-dd269efdff74@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <5db1e0c2-a192-4883-9535-dd269efdff74@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3JSMHVWto_lGhAw--.4001S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5CFWxuF1kKw4UXr4rGrg_yoW5tFy3pF
	y5JF1UAF47K348XF4Iqr40gw1UtanFqrWUWr98Gr1UCF4qyr18CF4SgF1UuFZ8K3yxZryD
	X3ykua4Iqr1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/7 9:43, Joseph Qi wrote:
> 
> 
> On 2025/7/5 15:10, Zhang Yi wrote:
>> On 2025/7/3 18:47, Joseph Qi wrote:
>>>
>>>
>>> On 2025/7/3 15:26, Naresh Kamboju wrote:
>>>> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>>>>
>>>>> Hi, Naresh!
>>>>>
>>>>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>>>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>>>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>>>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>>>>
>>>>>> Not reproducible with 4K page size.
>>>>>>
>>>>>> Test environments:
>>>>>> - Dragonboard-410c
>>>>>> - Juno-r2
>>>>>> - rk3399-rock-pi-4b
>>>>>> - qemu-arm64
>>>>>>
>>>>>> Regression Analysis:
>>>>>> - New regression? Yes
>>>>>> - Reproducibility? Yes
>>>>>>
>>>>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>>>>> transaction.c start_this_handle
>>>>>>
>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>
>>>>> Thank you for the report. The block size for this test is 1 KB, so I
>>>>> suspect this is the issue with insufficient journal credits that we
>>>>> are going to resolve.
>>>>
>>>> I have applied your patch set [1] and tested and the reported
>>>> regressions did not fix.
>>>> Am I missing anything ?
>>>>
>>>> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
>>>>
>>>
>>> I can also reproduce the similar warning with xfstests generic/730 under
>>> 64k page size + 4k block size.
>>>
>>
>> Hi, Joseph!
>>
>> I cannot reproduce this issue on my machine. Theoretically, the 'rsv_credits'
>> should be 113 under 64k page size + 4k block size, I don't think it would
>> exceed the max user trans buffers. Could you please give more details?
>> What is the configuration of your xfstests? and what does the specific error
>> log look like?
>>
> I'm testing on arm 64K ECS with xfstests local.config as follows:
> 
> export TEST_DEV=/dev/nvme1n1p1
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/nvme1n1p2
> export SCRATCH_MNT=/mnt/scratch
> > Each disk part is 250G and formated with 4k block size.
> 
> The dmesg shows the following warning:
> 
> [  137.174661] JBD2: kworker/u32:0 wants too many credits credits:32 rsv_credits:1577 max:2695
> ...
> [  137.175544] Call trace:
> [  137.175545]  start_this_handle+0x3bc/0x3d8 (P)
> [  137.175548]  jbd2__journal_start+0x10c/0x248
> [  137.175550]  __ext4_journal_start_sb+0xe4/0x1b0
> [  137.175553]  ext4_do_writepages+0x430/0x768
> [  137.175556]  ext4_writepages+0x8c/0x118
> [  137.175558]  do_writepages+0xac/0x180
> [  137.175561]  __writeback_single_inode+0x48/0x328
> [  137.175563]  writeback_sb_inodes+0x244/0x4a0
> [  137.175564]  wb_writeback+0xec/0x3a0
> [  137.175566]  wb_do_writeback+0xc0/0x250
> [  137.175568]  wb_workfn+0x70/0x1b0
> [  137.175570]  process_one_work+0x180/0x400
> [  137.175573]  worker_thread+0x254/0x2c8
> [  137.175575]  kthread+0x124/0x130
> [  137.175577]  ret_from_fork+0x10/0x20
> ...

OK, well. Since you did not specifically set MKFS_OPTIONS="-b 4096, the
generic/730 will use scsi_debug to create a file system image with a size of
256MB, a block size of 1KB, and a log size of 8MB. Consequently, the issue
did not actually occur in a 4KB block size environment, so the root cause
is the same as Naresh's report.

Thanks,
Yi.


