Return-Path: <linux-fsdevel+bounces-18901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B268BE447
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D1A1C210D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231BF16190C;
	Tue,  7 May 2024 13:30:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384015E217;
	Tue,  7 May 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088603; cv=none; b=KhhTg/KgArU7TUg/AWlI3/SMzCVIcujwbzumFEDAC7HOi8UXcZB40Q0oHHiDSzh7/dwHrFF/DQ8x89HrK3vFpQDku+/KU2Wp7SXPFuhR9EBcNwUd8BgCDPdC+YU09GXXrWYtyat1mpsyFVV1VJ0rM8m8w2pngOVLwrVt9/Y774I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088603; c=relaxed/simple;
	bh=Jgm/bo+Fzjg21Ca5wg4n5LmzEBDkW2Ag3DP2JDk/UkA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pnOvg3juZiAsR8D2pAzoEm1Lt36BEaw8GiEG5T5CPGypnnDuiz8DTax2JEkmJGmjd3/NR0vd424eSVfHZ5mwd7MOc41LFmWOIddYqpAxDXfgfEQABM0DXdI0MO3UUAcWfdVFx0IiSQQURHAfUdvyOqk2ZrCQKIAJeBCsQY17JZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VYfJs0HrYz4f3knh;
	Tue,  7 May 2024 21:29:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 488161A0572;
	Tue,  7 May 2024 21:29:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3FA7QLDpm9mwMMA--.12209S2;
	Tue, 07 May 2024 21:29:55 +0800 (CST)
Subject: Re: WARNING in fuse_request_end
To: lee bruce <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu
Cc: yue sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
Date: Tue, 7 May 2024 21:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3FA7QLDpm9mwMMA--.12209S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWxAr4DKw4xtF18tFy8Grg_yoWxXF1fpr
	WrJF45CrW8Jr18Ar17Ar1Yqry8trZ7A3WUJr97JF18Z3W5Gw1YvF1jqFWjgryDArZ7Zr47
	tF4DXw4Ivr1kWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 5/7/2024 10:52 AM, lee bruce wrote:
> Hello, I found a new bug titled "WARNING in fuse_request_end" and
> comfirmed in the lastest upstream.
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> kernel: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803(lastest)
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=7144b4fe7fbf5900
> with KASAN enabled
> compiler: gcc (GCC) 13.2.1 20231011
>
> TITLE: WARNING in fuse_request_end
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 8264 at fs/fuse/dev.c:300
> fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
> Modules linked in:
> CPU: 0 PID: 8264 Comm: ab2 Not tainted 6.9.0-rc7-00012-gdccb07f2914c #27
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-1.fc38 04/01/2014
> RIP: 0010:fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
> Code: ff 3c 03 0f 8f d6 fd ff ff 4c 89 ff e8 24 31 f9 fe e9 c9 fd ff
> ff e8 1a 8b 9c fe 90 0f 0b 90 e9 a9 fa ff ff e8 0c 8b 9c fe 90 <0f> 0b
> 90 e9 e6 fa ff ff 48 89 34 24 e8 fa 30 f9 fe 48 8b 34 24 e9
> RSP: 0018:ffffc9000eb17a60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880342cc008 RCX: ffffffff82f20b6a
> RDX: ffff88802fa79ec0 RSI: ffffffff82f21084 RDI: 0000000000000007
> RBP: ffff8880342cc038 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000100 R11: 0000000000000000 R12: ffff888029989000
> R13: ffff88802cc39740 R14: 0000000000000100 R15: ffff8880342cc038
> FS: 00007febdf6d96c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002200 CR3: 000000001fe6c000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> fuse_dev_do_read.constprop.0+0xd36/0x1dd0 fs/fuse/dev.c:1334
> fuse_dev_read+0x166/0x200 fs/fuse/dev.c:1367
> call_read_iter include/linux/fs.h:2104 [inline]
> new_sync_read fs/read_write.c:395 [inline]
> vfs_read+0x85b/0xba0 fs/read_write.c:476
> ksys_read+0x12f/0x260 fs/read_write.c:619
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xce/0x260 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x439ae9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007febdf6d91f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007febdf6d96c0 RCX: 0000000000439ae9
> RDX: 0000000000002020 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 00007febdf6d9220 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000213 R12: ffffffffffffffb0
> R13: 000000000000006e R14: 00007ffde3c37740 R15: 00007ffde3c37828
> </TASK>
>
> =* repro.c =*

SNIP

>  case 4:
>    *(uint32_t*)0x20002200 = 0x28;
>    *(uint32_t*)0x20002204 = 7;
>    *(uint64_t*)0x20002208 = 0;
>    *(uint64_t*)0x20002210 = 0;
>    *(uint64_t*)0x20002218 = 0;
>    *(uint64_t*)0x20002220 = 0;
>    syscall(__NR_write, /*fd=*/r[1], /*arg=*/0x20002200ul, /*len=*/0x28ul);

Thanks for the report and the reproducer program.  It seems that the
warning is due to the FUSE_NOTIFY_RESEND notify send by the write()
syscall above and it happens as follows:

(1) the reproducer calls fuse_dev_read() to read the INIT request.
The read succeeds. During the read, bit FR_SENT will be set on req->flags.
(2) the reproducer calls fuse_dev_write() to write a FUSE_NOTIFY_RESEND
to resend all requests.
(3) the INIT request is moved from processing list to pending list again
(4) the reproducer calls fuse_dev_read() with an invalid output address
fuse_dev_read() will try to copy the INIT request to the output address,
but it fails,so the INIT request is ended and triggers the warning in
fuse_request_end().

A straightforward fix is to clear the FR_SENT bit in as show below:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff5..840cefdf24e26 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1814,6 +1814,7 @@ static void fuse_resend(struct fuse_conn *fc)

        list_for_each_entry_safe(req, next, &to_queue, list) {
                __set_bit(FR_PENDING, &req->flags);
+               clear_bit(FR_SENT, &req->flags);
                /* mark the request as resend request */
                req->in.h.unique |= FUSE_UNIQUE_RESEND;
        }

But I think more code checking and tests are needed before posting it as
a formal patch.

>    break;
>  case 5:
>    syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x3000ul, /*prot=*/0ul,
>            /*flags=*/0x12ul, /*fd=*/r[0], /*offset=*/0ul);
>    break;
>  case 6:
>    syscall(__NR_read, /*fd=*/r[1], /*buf=*/0x20000140ul, /*len=*/0x2020ul);
>    break;
>  }
> }
> int main(void)
> {
>  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  loop();
>  return 0;
> }
>
>
> =* repro.txt =*
> r0 = openat$cgroup_ro(0xffffffffffffff9c,
> &(0x7f0000001cc0)='memory.events\x00', 0x275a, 0x0)
> r1 = openat$fuse(0xffffffffffffff9c, &(0x7f0000000100), 0x2, 0x0)
> syz_mount_image$fuse(&(0x7f0000000080),
> &(0x7f00000000c0)='./file1\x00', 0x0, &(0x7f0000006380)={{'fd', 0x3d,
> r1}, 0x2c, {'rootmode', 0x3d, 0x4000}}, 0x0, 0x0, 0x0)
> read$FUSE(r1, &(0x7f0000000140)={0x2020}, 0x2020)
> write$FUSE_NOTIFY_INVAL_INODE(r1, &(0x7f0000002200)={0x28, 0x7}, 0x28)
> mmap(&(0x7f0000000000/0x3000)=nil, 0x3000, 0x0, 0x12, r0, 0x0)
> read$FUSE(r1, &(0x7f0000000140)={0x2020}, 0x2020)
>
>
> Please also see:
> https://gist.github.com/xrivendell7/346cb2c74cf5da4cad54cbdc8d1f0ded
>
> I hope it helps.
> Best regards.
> xingwei Lee
>
> .


