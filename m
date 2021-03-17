Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926EC33FBFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 00:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQXs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 19:48:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:50215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQXs5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616024856;
        bh=spNDiO20yZruq9Ry/7bBVmP5vPypYcy1XJR8ldsqaqE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T/7gNUX1gi8wEhdyg1KhO34mrSTwhegdUSsZNUCGPfSqtE9H26bc6QHrzPn+aPeTK
         3V5HviZjt98BLdEtU2KMNGbus/a6vcmjfNLvAz3OO65mRU95uQu+TBWHuZm/KPDZkp
         8pjab6Y6JriPp0SCnXst+3BvjGm4yeOfXzuU7TpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1lpnOg0LZW-013bYQ; Thu, 18
 Mar 2021 00:47:36 +0100
Subject: Re: [PATCH v8 04/10] btrfs: fix check_data_csum() error message for
 direct I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1615922644.git.osandov@fb.com>
 <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
 <885fa39a-713f-f594-53ae-241d9cd7a113@gmx.com>
 <YFJLgDQvley7zPjM@relinquished.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d0b2d79f-586e-fc35-4d77-788a6965b155@gmx.com>
Date:   Thu, 18 Mar 2021 07:47:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFJLgDQvley7zPjM@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2eDAuUpnESHVzVyYQCXegVYFPyKXpqp29qKMnQYtDwCxLUCrIN
 mAaHLVr56KRDS1uKhQHaOs6e/PcX6hPnh3Lxeuj1wGgwrNVLaPcaaHqn5jMEGSnEdqgSYww
 RtSdMf/IesTVt8qdv3NMDxDelNhM5eHlKC6BdoU7I9ylzhF4TY8L+Q52+3PHcEOLRHgtCrK
 LqW1c9vUeHNKxx0hu7f0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bK6KGtvS++8=:Bv9nbctKCsMZCvqKbjnAu3
 e4ZFFCNWKH+NvyVLXiSl4DwHKcjCUb3ujdpTwQ+xyvcEkjxN31BBMvMAUbbacsCbz0o4aAmU7
 gdrxJy2+1Fj4vnYQrixnhRljg+xvYShDnMbNXs89RrxGTkmnPvoGLcdWOx025Unpo4e9+/lWU
 hO2Kp6DmxscPxpg81hV/LTKoszv0qOWRN9odGhnSOYGpcoUqT/tMa26eidczEypN7Zi23g8jZ
 /+feDbkxfxnIYk4c8OLAsAED1neaUlGyJ+Kj7Q4zqqO+btcTo2XuaZCXJYgvS8435rFXyE4eT
 hTDGTavl/A8mV/l932bOSLtGsLXKzwj71mueM4uyvztHhpQ6HiEqCPiWuB9R/poH3Ju7ACnoR
 BUItDSpcusIWPJgiM1MVT6UF9CnNv8P4ZRu6jb3mV9q7e40GN/GjZeA9HH/OUQqz2EMfTU+TJ
 uw83mgD2kAUf2tMilQAFoEwcOSpnfft0Rm14ZcRpHB4nZ4vd/ALLa/UDu7aTh0SsmkWlkuDeV
 UY4xaL3GITCYRjLEK1lsYNx6SwNCzey1PV9yRJs0PisVZBFD8cNzI70MRHTFA847p39iqwptt
 kGDYXYcBVFlz0dO1i+JczgD0GT+hcikYWRypiE2iM9IG8QH9Rf0K9TWRIORerstN1GlUcQU68
 OheYB3elsa5KIlMXVnD8BNtM19SACMCzjUYMyCawceFfe8PSahO/s/azmIqzwx7miCi3GcPIE
 z1ey58CpXHuCdX3BssSQ6Ymyq2DQLC3r69lbEY39SJXhuvXyF4/G26YfWR3m6SEwQ33Dxe8gK
 n345NyrreGnK38TZf+5yp0yYUezUpslMeROamsCO42ttxpBKs3XDWUNISCfU7LuYmyYmfUNII
 n8FurbL6UoGnoWBQzCEQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/3/18 =E4=B8=8A=E5=8D=882:33, Omar Sandoval wrote:
> On Wed, Mar 17, 2021 at 07:21:46PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/3/17 =E4=B8=8A=E5=8D=883:43, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
>>> check_data_csum()") replaced the start parameter to check_data_csum()
>>> with page_offset(), but page_offset() is not meaningful for direct I/O
>>> pages. Bring back the start parameter.
>>
>> So direct IO pages doesn't have page::index set at all?
>
> No, they don't. Usually you do direct I/O into an anonymous page, but I
> suppose you could even do direct I/O into a page mmap'd from another
> file or filesystem. In either case, the index isn't meaningful for the
> file you're doing direct I/O from.
>
>> Any reproducer? I'd like to try to reproduce it first.
>
> The easiest way to see this issue is to apply this patch:
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2a92211439e8..a962b3026573 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3114,6 +3114,9 @@ static int check_data_csum(struct inode *inode, st=
ruct btrfs_io_bio *io_bio,
>   	u8 *csum_expected;
>   	u8 csum[BTRFS_CSUM_SIZE];
>
> +	WARN_ONCE(page_offset(page) + pgoff !=3D start,
> +		  "page offset %llu !=3D start %llu\n",
> +		  page_offset(page) + pgoff, start);
>   	ASSERT(pgoff + len <=3D PAGE_SIZE);
>
>   	offset_sectors =3D bio_offset >> fs_info->sectorsize_bits;
>
> Run this simple test:
>
> $ dd if=3D/dev/zero of=3Dfoo bs=3D4k count=3D1024
> 1024+0 records in
> 1024+0 records out
> 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.00456495 s, 919 MB/s
> $ sync
> $ dd if=3Dfoo of=3D/dev/null iflag=3Ddirect bs=3D4k
> 1024+0 records in
> 1024+0 records out
> 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.163079 s, 25.7 MB/s
>
> And you'll get a warning like:
>
> [   84.896486] ------------[ cut here ]------------
> [   84.897370] page offset 94199157981184 !=3D start 0
> [   84.898128] WARNING: CPU: 1 PID: 459 at fs/btrfs/inode.c:3119 check_d=
ata_csum+0x189/0x260 [btrfs]
> [   84.899547] Modules linked in: btrfs blake2b_generic xor pata_acpi at=
a_piix libata scsi_mod raid6_pq virtio_net net_failover virtio_rng libcrc3=
2c rng_core failover
> [   84.901742] CPU: 1 PID: 459 Comm: kworker/u56:2 Not tainted 5.12.0-rc=
3-00060-ge0cd3910d8cb-dirty #139
> [   84.903205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   84.904875] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> [   84.905749] RIP: 0010:check_data_csum+0x189/0x260 [btrfs]
> [   84.906576] Code: 57 11 00 00 0f 85 03 ff ff ff 4c 89 ca 48 c7 c7 50 =
ba 35 c0 4c 89 44 24 10 48 89 44 24 08 c6 05 04 57 11 00 01 e8 22 e0 cf d4=
 <0f> 0b 4c 8b 44 24 10 48 8b 44 24 08 e9 d2 fe ff ff 41 8b 45 00 4d
> [   84.909288] RSP: 0018:ffffb6e9c164bb98 EFLAGS: 00010282
> [   84.910061] RAX: 0000000000000000 RBX: ffffe96b84a05f40 RCX: 00000000=
00000001
> [   84.911109] RDX: 0000000080000001 RSI: ffffffff9573d067 RDI: 00000000=
ffffffff
> [   84.912149] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000=
ffffdfff
> [   84.913197] R10: 0000000000000001 R11: ffffb6e9c164b9c0 R12: 00000000=
00000000
> [   84.914247] R13: ffff9d32a28c8dc0 R14: ffff9d32ac495e10 R15: 00000000=
00000004
> [   84.915304] FS:  0000000000000000(0000) GS:ffff9d399f640000(0000) knl=
GS:0000000000000000
> [   84.916478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   84.917340] CR2: 000055ad52f97120 CR3: 00000001292f4002 CR4: 00000000=
00370ee0
> [   84.918435] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [   84.919473] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [   84.920515] Call Trace:
> [   84.920884]  ? find_busiest_group+0x41/0x380
> [   84.921518]  ? load_balance+0x176/0xc10
> [   84.922082]  ? kvm_sched_clock_read+0x5/0x10
> [   84.922711]  ? sched_clock+0x5/0x10
> [   84.923236]  btrfs_end_dio_bio+0x2fb/0x310 [btrfs]
> [   84.923982]  end_workqueue_fn+0x29/0x40 [btrfs]
> [   84.924698]  btrfs_work_helper+0xc1/0x350 [btrfs]
> [   84.925435]  process_one_work+0x1c8/0x390
> [   84.926025]  ? process_one_work+0x390/0x390
> [   84.926650]  worker_thread+0x30/0x370
> [   84.927209]  ? process_one_work+0x390/0x390
> [   84.927875]  kthread+0x13d/0x160
> [   84.928466]  ? kthread_park+0x80/0x80
> [   84.929008]  ret_from_fork+0x22/0x30
> [   84.929543] ---[ end trace 4f87c4a13fa476d4 ]---
>
>>>
>>> Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_dat=
a_csum")
>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>> ---
>>>    fs/btrfs/inode.c | 14 +++++++++-----
>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index ef6cb7b620d0..d2ece8554416 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(stru=
ct page *page, u64 start,
>>>     * @bio_offset:	offset to the beginning of the bio (in bytes)
>>>     * @page:	page where is the data to be verified
>>>     * @pgoff:	offset inside the page
>>> + * @start:	logical offset in the file
>>
>> Please add some comment if only for direct IO we need that @start param=
eter.
>
> Won't that add more confusion? Someone might read that and assume that
> they don't need to pass start for a page cache page. In my opinion,
> having this change in the git log is enough.
>
That's fine.

Then this patch looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
