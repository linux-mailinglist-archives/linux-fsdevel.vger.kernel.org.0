Return-Path: <linux-fsdevel+bounces-47687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B897DAA4050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 03:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F73E9228D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C0210FB;
	Wed, 30 Apr 2025 01:16:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71FBA27;
	Wed, 30 Apr 2025 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975812; cv=none; b=KT1RvzVt+RW0st4RGf6qAw1BjVRujvXBJlMakJ8jawvyStri5FxYA1Jj+lY8INjNAqu9p6V2N7I/F6oRvdjBwbkQxrRi/P4X1+E18zh/dniy2IC+7L51SAhJG/fTP75d3NzmkOnCQF/3UXm04pcEzDLK9iXnUjkbltqdCMm/mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975812; c=relaxed/simple;
	bh=lHrCbwIY1y+qfxY2LYrrUI87iVadOHjf9vcyKwsuWrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb4lEwFDLJLOdmsGFI2q8fsR0H0uF/M60XTfdVQjeHPmf+LYNWo4NvRgKU0MtS+BeTF9LhIci+HovgGQEJzkHXvmtQ9VNi4m3HSZnJH5BAjcZJS130dtc4etCLvBUoNMJ4n0KU9iLxu1vvK1r8O1VoiN9cq8CZgaEy3tBplABko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZnK5Q1kxYz4f3jtP;
	Wed, 30 Apr 2025 09:16:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2F9AE1A07BD;
	Wed, 30 Apr 2025 09:16:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_4eRFoLP_jKw--.7427S3;
	Wed, 30 Apr 2025 09:16:42 +0800 (CST)
Message-ID: <c86f5492-08e8-477d-a3a6-fe0fbb99139e@huaweicloud.com>
Date: Wed, 30 Apr 2025 09:16:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG in zero_user_segments
To: Liebes Wang <wanghaichi0403@gmail.com>
Cc: Jan Kara <jack@suse.cz>, ojaswin@linux.ibm.com,
 Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
 <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>
 <CADCV8spSjWbnr_cUTzcB=zn0M92s_AhRx-byz0A8zZZa4cZ=Lg@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CADCV8spSjWbnr_cUTzcB=zn0M92s_AhRx-byz0A8zZZa4cZ=Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_4eRFoLP_jKw--.7427S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw47KrW7Cry3Xw15JF1UWrg_yoWDGFWkpF
	97GFyUGrW8Wr18CF4xtF1UGryUtw4UAayUXr1xWr18JFZFkr1jgr1jgr4jg3WDJr48Ar1x
	Xrn8Jr1avw1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/4/29 16:17, Liebes Wang wrote:
> Hi Yi,
> 
> I’ve tested the patch on kernel version |9d7a0577c9db35c4cc52db90bc415ea248446472|, and it indeed resolves the issue. The crash no longer occurs.
> 

Thank you for the test. I will send out the fix after completing all tests.

Yi.

> Best regards,
> Liebes
> 
> 
> Zhang Yi <yi.zhang@huawei.com <mailto:yi.zhang@huawei.com>> 于2025年4月29日周二 15:55写道：
> 
>     On 2025/4/28 16:14, Jan Kara wrote:
>     > On Fri 25-04-25 15:29:41, Liebes Wang wrote:
>     >> Dear Linux maintainers and reviewers:
>     >> We are reporting a Linux kernel bug titled **kernel BUG in
>     >> zero_user_segments**, discovered using a modified version of Syzkaller.
>     >>
>     >> This bug seems to be duplicated as
>     >> https://syzkaller.appspot.com/bug?extid=78eeb671facb19832e95 <https://syzkaller.appspot.com/bug?extid=78eeb671facb19832e95>, but the test
>     >> case is much smaller, which may be helpful for analyzing the bug.
>     >>
>     >> Linux version: 9d7a0577c9db35c4cc52db90bc415ea248446472
>     >>
>     >> The bisection log shows the first introduced commit is
>     >> 982bf37da09d078570650b691d9084f43805a5de
>     >> commit 982bf37da09d078570650b691d9084f43805a5de
>     >> Author: Zhang Yi <yi.zhang@huawei.com <mailto:yi.zhang@huawei.com>>
>     >> Date:   Fri Dec 20 09:16:31 2024 +0800
>     >>
>     >>     ext4: refactor ext4_punch_hole()
>     >>
>     >>     The current implementation of ext4_punch_hole() contains complex
>     >>     position calculations and stale error tags. To improve the code's
>     >>     clarity and maintainability, it is essential to clean up the code and
>     >>     improve its readability, this can be achieved by: a) simplifying and
>     >>     renaming variables; b) eliminating unnecessary position calculations;
>     >>     c) writing back all data in data=journal mode, and drop page cache from
>     >>     the original offset to the end, rather than using aligned blocks,
>     >>     d) renaming the stale error tags.
>     >>
>     >>     Signed-off-by: Zhang Yi <yi.zhang@huawei.com <mailto:yi.zhang@huawei.com>>
>     >>     Reviewed-by: Jan Kara <jack@suse.cz <mailto:jack@suse.cz>>
>     >>     Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com <mailto:ojaswin@linux.ibm.com>>
>     >>     Link:
>     >> https://patch.msgid.link/20241220011637.1157197-5-yi.zhang@huaweicloud.com <https://patch.msgid.link/20241220011637.1157197-5-yi.zhang@huaweicloud.com>
>     >>     Signed-off-by: Theodore Ts'o <tytso@mit.edu <mailto:tytso@mit.edu>>
>     >
>     > So there's something suspicious about this report. The stacktrace shows
>     > we've crashed in punch hole code (call from ioctl_preallocate()) but the
>     > reproducer actually never calls this. Anyway, the reported stack trace ends
>     > with truncate_inode_partial_folio() -> folio_zero_range() ->
>     > zero_user_segments(). The assertion that's failing is:
>     >
>     > BUG_ON(end1 > page_size(page) || end2 > page_size(page));
> 
>     After debugging, I found that this problem is caused by punching a hole
>     with an offset variable larger than max_end on a corrupted ext4 inode,
>     whose i_size is larger than maxbyte. It will result in a negative length
>     in the truncate_inode_partial_folio(), which will trigger this problem.
> 
>     Hi, Liebes!
> 
>     Thank you for the report. Could you please try the patch below? I have
>     tested it, and it resolves this issue on my machine.
> 
>     diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>     index 94c7d2d828a6..4ec4a80b6879 100644
>     --- a/fs/ext4/inode.c
>     +++ b/fs/ext4/inode.c
>     @@ -4016,7 +4016,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>             WARN_ON_ONCE(!inode_is_locked(inode));
> 
>             /* No need to punch hole beyond i_size */
>     -       if (offset >= inode->i_size)
>     +       if (offset >= inode->i_size || offset >= max_end)
>                     return 0;
> 
>             /*
> 
>     BTW, I also found that the calculation of the max_end variable in
>     ext4_punch_hole() is wrong for extent inodes. It should be
>     inode->i_sb->s_maxbytes - sb->s_blocksize instead of
>     s_bitmap_maxbytes - sb->s_blocksize. I will fix it together.
> 
>     Thanks,
>     Yi.
> 
>     >
>     > Now it seems that this assertion can indeed easily trigger when we have
>     > a large folio because truncate_inode_partial_folio() is called to zero out
>     > tail of the whole folio which can certainly be more than a page. Matthew,
>     > am I missing something (I guess I am because otherwise I'd expect we'd be
>     > crashing left and right) or is the folio conversion on this path indeed
>     > broken?
>     >
>     >                                                               Honza
>     >
>     >>
>     >> The test case, kernel config and full bisection log are attached.
>     >>
>     >> The report is (The full report is attached):
>     >> EXT4-fs (loop7): mounted filesystem 00000000-0000-0000-0000-000000000000
>     >> r/w without journal. Quota mode: writeback.
>     >> EXT4-fs warning (device loop7): ext4_block_to_path:105: block 2147483648 >
>     >> max in inode 15
>     >> ------------[ cut here ]------------
>     >> kernel BUG at ./include/linux/highmem.h:275!
>     >> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>     >> CPU: 0 UID: 0 PID: 6795 Comm: syz.7.479 Not tainted
>     >> 6.15.0-rc3-g9d7a0577c9db #1 PREEMPT(voluntary)
>     >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>     >> 1.13.0-1ubuntu1.1 04/01/2014
>     >> RIP: 0010:zero_user_segments.constprop.0+0x10c/0x290
>     >> include/linux/highmem.h:275
>     >> Code: 0f b6 4b 40 ba 00 10 00 00 48 d3 e2 49 89 d7 e8 ba d5 e2 ff 4c 89 fe
>     >> 4c 89 ef e8 3f d0 e2 ff 4d 39 fd 76 08 e8 a5 d5 e2 ff 90 <0f> 0b e8 9d d5
>     >> e2 ff be 08 00 00 00 48 89 df e8 a0 9c 1d 00 48 89
>     >> RSP: 0018:ffff8881235ff678 EFLAGS: 00010216
>     >> RAX: 000000000000025d RBX: ffffea00056071c0 RCX: ffffc90002e0b000
>     >> RDX: 0000000000080000 RSI: ffffffff818f7b0b RDI: 0000000000000006
>     >> RBP: 000000000040b000 R08: 0000000000000000 R09: fffff94000ac0e38
>     >> R10: 0000000000001000 R11: 0000000000000000 R12: 0000000000000005
>     >> R13: 000000000040b000 R14: 0000000000000000 R15: 0000000000001000
>     >> FS:  00007fecef19d700(0000) GS:ffff888543948000(0000) knlGS:0000000000000000
>     >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     >> CR2: 00007f5e38b40008 CR3: 000000013ebaa001 CR4: 0000000000770ef0
>     >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     >> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>     >> PKRU: 80000000
>     >> Call Trace:
>     >>  <TASK>
>     >>  folio_zero_range include/linux/highmem.h:647 [inline]
>     >>  truncate_inode_partial_folio+0x6da/0xbd0 mm/truncate.c:219
>     >>  truncate_inode_pages_range+0x3fc/0xcc0 mm/truncate.c:387
>     >>  ext4_truncate_page_cache_block_range+0xb3/0x5c0 fs/ext4/inode.c:3974
>     >>  ext4_punch_hole+0x2cd/0xec0 fs/ext4/inode.c:4049
>     >>  ext4_fallocate+0x128d/0x32c0 fs/ext4/extents.c:4766
>     >>  vfs_fallocate+0x3ed/0xd70 fs/open.c:338
>     >>  ioctl_preallocate+0x190/0x200 fs/ioctl.c:290
>     >>  file_ioctl fs/ioctl.c:333 [inline]
>     >>  do_vfs_ioctl+0x149c/0x1850 fs/ioctl.c:885
>     >>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>     >>  __se_sys_ioctl fs/ioctl.c:892 [inline]
>     >>  __x64_sys_ioctl+0x11f/0x200 fs/ioctl.c:892
>     >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     >>  do_syscall_64+0xc1/0x1d0 arch/x86/entry/syscall_64.c:94
>     >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     >
>     >> syz_mount_image$ext4(&(0x7f0000000400)='ext4\x00', &(0x7f00000001c0)='./file0\x00', 0x0, &(0x7f0000000280)={[{@journal_ioprio}, {@mb_optimize_scan}, {@data_err_ignore}, {@grpquota}, {@barrier}]}, 0x1, 0x3cb, &(0x7f00000026c0)="$eJzs3M9rHFUcAPDvTH61aXUjeBC9LAgaELPZpFoFRQUFD55sLx48LLtpLW4aabZgSw4VPHnVf0AE79V/QBDFmzdvgmBFKRRJe/K0Mrsz6ZrsxsTduEn6+cBj35uZzXvfndnhO5OdF8ADqxwRr0bEREQsRUQpX57mJW50S7bdvc2NelaSaLfP/ZlEEhF3Nzfqxd9K8tdTeWM+jUg/jnjixs5+169df7/WbK5cyduV1uoHlfVr15+9tFq7uHJx5XL1hRefX1o+Wz1zdmSx3vz53PKv377+w1e/PfXTj+2Xv8jGezpf1xvHqJSjvPWZbPfcqDsbs+lxDwAAgD1J89x/spP/l2KiU+sqRWVjrIMDAAAARqL9Sv4KAAAAHGOJa38AAAA45orfAdzd3KgXZYw/R/jf3XktIua68RfPN3fXTMaJfJupA3y+tRwRJ95uvJOVOKDnkAEAen2T5T+L/fK/NB7r2W4my1Mi4uSI+y9va+/Mf9LbI+7yH7L876WeuW3u9cSfm5vIWw91UsWp5MKl5spiRDwcEfMxNZO1q7v0cWvmk5lB63rzv6xk/Re5YD6O25Pb3t2otWrDxNzrzkcRj0/2iz/Zyn+TiJgdoo8v/7p5ddC6f4//YLU/j3i67/6/P3NPsvv8RJXO8VApjoqdbq3+8u6g/scdf7b/Z3ePfy7pna9pff99/L54frVT6XPy+K/
>     H/3RyvlMvrss+rLVaV6oR08lbO5cv3X9v0S62z+Kff7L/9784/yX5nFan83PAfn339XufDlp3GPZ/Y1/7f/+VN978fojvf7b/z3Rq8/mSvZz/9jrAYT47AAAAOCrSzn2NJF3YqqfpwkL3fsejMZs219Zbz1xYu3q50b3/MRdTaXGnq9RzP7Ta/Tf6VntpW3s5Ih6JiM9KJzvthfpaszHu4AEAAOABcWrA9X/mj9K4RwcAAACMzNy4BwAAAAAcONf/AAAAcKwNM6+fymGv1ONQDEPlCFbGfWYCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA42v4OAAD///tZxK0=")
>     >> quotactl_fd$Q_SETINFO(0xffffffffffffffff, 0x2, 0x0, &(0x7f0000000080)={0x80000000000002, 0x80000000005, 0x1, 0x6})
>     >> r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0x42, 0x1ff)
>     >> ioctl$EXT4_IOC_CHECKPOINT(r0, 0x40305829, &(0x7f0000000080)=0x5)
>     >> r1 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0x42, 0x1ff)
>     >> ioctl$EXT4_IOC_CHECKPOINT(r1, 0x40305829, &(0x7f0000000080)=0x5)
>     >
>     >
>     >
>     >
>     >
> 


