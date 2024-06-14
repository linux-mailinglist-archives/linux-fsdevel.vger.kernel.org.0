Return-Path: <linux-fsdevel+bounces-21703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B49089A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D78028CC6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67C19308F;
	Fri, 14 Jun 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="SvRd4NEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5B193067
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360495; cv=none; b=CV55MKj+af5mH/tZy9p+o/FzT9KxSPArpGRF9SHj3pGIZgJ35dkGMiHmx2j8D97dMMn+kVmrjRGAXIqGbhe4IeP0ZAX5q5ywDPXplxg/YU/JqhL3u6J0jQxxBIIMUMkb9qsdNPcshWsyN9J/kwMJACG4KKoP28cUYwWxnLSplBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360495; c=relaxed/simple;
	bh=EZZEwE35hbC8/l4i2UPY/1M7/8tlEjrdpG/D/jypXRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTzpWYBoBySE/WQ1jMh36ib0C/3jJi8sNEGtMB3b+t/edeehg1c13HYEvqKO+mFLB/EOl8mzdoAen/1fwmZlf/JaNQ5QiWaLSQuXY1YcEf/JjqgMvCNCu16GnjisvNI/MsSOIAoz7C+hLzMmtrlddPKWSEEIjLorC68W9KEzEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=SvRd4NEx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40BE16000B;
	Fri, 14 Jun 2024 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1718360486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpcjwEZIHNFU5D94FMi7pIStPsDrEGl0hbTEiz2Z9LY=;
	b=SvRd4NExxDwA0YczYp+ajo7cwtM4pJEUU7pyyJdCf8HEJnjlZjEYUoYBFBHwb8vJF5qcXI
	dEttT4vtdSOiKIzMqIShv6uDNEr/SSkiYLBvYit3MbVpoe/g6QY+n6t/NlF8/ERhC/IMXI
	gKIAUqbIa3e+ENHdENLIbZ5aZt/3C1AiQ3Duj6x2RffzS7NI5XvJ1pbMd7j+rcsowrAo9G
	G35dTC6I+7tmZEQy9uWK4XBr+muOx7jkBo35iZde9aIRLULXvypevykT3Rha4RDwe9j3B7
	P3af2IDpfXDvpTLH8ZuH57zJu+cOCRGtKskXLVThoi7Qvvl23+gTWT0JwT8D2g==
Message-ID: <c8814c0f-7f03-435c-ac5b-084bd0ad8fe6@yoseli.org>
Date: Fri, 14 Jun 2024 12:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with JFFS2 and a_ops->dirty_folio
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, willy@infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-m68k@lists.linux-m68k.org
References: <0b657056-3a7f-46ba-8e99-a8fe2203901f@yoseli.org>
 <ZmrV9vLwj0uFj5Dn@infradead.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <ZmrV9vLwj0uFj5Dn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi there,

On 13/06/2024 13:20, Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 09:05:17AM +0200, Jean-Michel Hautbois wrote:
>> Hi everyone !
>>
>> I am currently working on a Coldfire (MPC54418) and quite everything goes
>> well, except that I can only execute one command from user space before
>> getting a segmentation fault on the do_exit() syscall.
> 
> Looks like jffs2 is simply missing a dirty_folio implementation.  The
> simple filemap_dirty_folio should do the job, please try the patch
> below:
> 
> 
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 62ea76da7fdf23..7124cbad6c35ae 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -19,6 +19,7 @@
>   #include <linux/highmem.h>
>   #include <linux/crc32.h>
>   #include <linux/jffs2.h>
> +#include <linux/writeback.h>
>   #include "nodelist.h"
>   
>   static int jffs2_write_end(struct file *filp, struct address_space *mapping,
> @@ -75,6 +76,7 @@ const struct address_space_operations jffs2_file_address_operations =
>   	.read_folio =	jffs2_read_folio,
>   	.write_begin =	jffs2_write_begin,
>   	.write_end =	jffs2_write_end,
> +	.dirty_folio =	filemap_dirty_folio,
>   };
>   
>   static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)

I managed to modify my rootfs and I am using ubifs. It is far more 
complete and indeed an error occurs in the ubifs_dirty_folio() call. I 
don't know if there is any interest there, but the volume is mounted 
read-only on purpose:

[    4.490000] ubi0: attaching mtd5
[    4.500000] ubi0: MTD device 5 is write-protected, attach in 
read-only mode
[    4.890000] ubi0: scanning is finished
[    4.940000] ubi0 warning: autoresize: skip auto-resize because of R/O 
mode
[    4.950000] ubi0: attached mtd5 (name "root2", size 64 MiB)
[    4.960000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 
bytes
[    4.960000] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    4.970000] ubi0: VID header offset: 2048 (aligned 2048), data 
offset: 4096
[    4.980000] ubi0: good PEBs: 512, bad PEBs: 0, corrupted PEBs: 0
[    4.980000] ubi0: user volume: 1, internal volumes: 1, max. volumes 
count: 128
[    4.990000] ubi0: max/mean erase counter: 0/0, WL threshold: 4096, 
image sequence number: 1619801263
[    5.000000] ubi0: available PEBs: 215, total reserved PEBs: 297, PEBs 
reserved for bad PEB handling: 80
[    5.010000] ubi0: background thread "ubi_bgt0d" started, PID 25
[    5.020000] UBIFS (ubi0:0): read-only UBI device
[    5.030000] UBIFS (ubi0:0): Mounting in unauthenticated mode
[    5.130000] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, 
name "root2", R/O mode
[    5.140000] UBIFS (ubi0:0): LEB size: 126976 bytes (124 KiB), 
min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    5.150000] UBIFS (ubi0:0): FS size: 25649152 bytes (24 MiB, 202 
LEBs), max 2048 LEBs, journal size 9023488 bytes (8 MiB, 72 LEBs)
[    5.160000] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
[    5.160000] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0), 
UUID 43E9BD53-C843-4AEE-897E-5684A795D2C8, small LPT model
[    5.180000] VFS: Mounted root (ubifs filesystem) readonly on device 0:13.

And when I execute a command:

bash-5.2# ls
bin       etc       lib32     mnt       root      sys 
12.560000] UBIFS error (ubi0:0 pid 26): ubifs_assert_failed: UBIFS 
assert failed: ret == false, in fs/ubifs/file.c:1477
4mus[   12.570000] UBIFS warning (ubi0:0 pid 26): ubifs_ro_mode: 
switched to read-only mode, error -22
r  12.580000] CPU: 0 PID: 26 Comm: ls Not tainted 
6.10.0-rc3stmark2-001-00024-gc73f39277b30-dirty #455
[   12.580000] Stack from 42937dac:
[   12.580000]         42937dac 414a3f4c 414a3f4c 4fed4a01 41dda000 
420885cc 413e2b20 414a3f4c
[   12.580000]         41115112 41dda000 ffffffea 414b3c43 000005c5 
4fed4a98 6015e000 4105e058
[   12.580000]         420885cc 4fed4a98 415ed419 42937f12 4107ae8a 
4fed4a98 00000000 ffffffff
[   12.580000]         fffffffe 42937e96 60162000 00000001 413c03ce 
4107aa9e 4107ea74 00000001
[   12.580000]         42909034 ffffffff 42940600 60162000 42940600 
428c0450 42936000 428c048c
[   12.580000]         00000000 00000000 00000000 00000000 42937f54 
4107b19c 42937f12 42909034
[   12.580000] Call Trace: [<413e2b20>] dump_stack+0xc/0x10
[   12.580000]  [<41115112>] ubifs_dirty_folio+0x3e/0x4a
[   12.580000]  [<4105e058>] folio_mark_dirty+0x6e/0x82
[   12.580000]  [<4107ae8a>] unmap_page_range+0x3ec/0x68a
[   12.580000]  [<413c03ce>] mas_find+0x0/0xfa
[   12.580000]  [<4107aa9e>] unmap_page_range+0x0/0x68a
[   12.580000]  [<4107ea74>] vma_next+0x0/0x14
[   12.580000]  [<4107b19c>] unmap_vmas+0x74/0x98
[   12.580000]  [<4102cc68>] up_read+0x0/0x2a
[   12.580000]  [<41080c14>] exit_mmap+0xd4/0x1d2
[   12.580000]  [<410098ff>] will_become_orphaned_pgrp+0x27/0x7c
[   12.580000]  [<413e6eb4>] _raw_spin_unlock_irq+0x0/0x14
[   12.580000]  [<41006db0>] __mmput+0x2e/0xa0
[   12.580000]  [<4100a7ae>] do_exit+0x264/0x764
[   12.580000]  [<413e6ec4>] _raw_spin_unlock_irq+0x10/0x14
[   12.580000]  [<4100adfe>] do_group_exit+0x26/0x78
[   12.580000]  [<4100ae50>] sys_exit_group+0x0/0x14
[   12.580000]  [<4100ae64>] pid_child_should_wake+0x0/0x56
[   12.580000]  [<41005918>] system_call+0x54/0xa8
[   12.580000]
[   17.600000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:1016
[   17.610000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: !c->ro_media && !c->ro_mount, in fs/ubifs/journal.c:108
[   17.620000] UBIFS error (ubi0:0 pid 24): make_reservation: cannot 
reserve 4144 bytes in jhead 2, error -30
[   17.630000] UBIFS error (ubi0:0 pid 24): do_writepage: cannot write 
folio 150 of inode 156, error -30
[   17.640000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:944
[   17.650000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: c->bi.dd_growth >= 0, in fs/ubifs/budget.c:550
[   26.440000] UBIFS error (ubi0:0 pid 27): ubifs_assert_failed: UBIFS 
assert failed: ret == false, in fs/ubifs/file.c:1477
[   26.450000] UBIFS error (ubi0:0 pid 27): ubifs_assert_failed: UBIFS 
assert failed: ret == false, in fs/ubifs/file.c:1477
[   26.460000] UBIFS error (ubi0:0 pid 27): ubifs_assert_failed: UBIFS 
assert failed: ret == false, in fs/ubifs/file.c:1477
[   31.520000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:1016
[   31.530000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: !c->ro_media && !c->ro_mount, in fs/ubifs/journal.c:108
[   31.540000] UBIFS error (ubi0:0 pid 24): make_reservation: cannot 
reserve 4144 bytes in jhead 2, error -30
[   31.550000] UBIFS error (ubi0:0 pid 24): do_writepage: cannot write 
folio 101 of inode 81, error -30
[   31.560000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:944
[   31.570000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: c->bi.dd_growth >= 0, in fs/ubifs/budget.c:550
[   36.640000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:1016
[   36.650000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: !c->ro_media && !c->ro_mount, in fs/ubifs/journal.c:108
[   36.660000] UBIFS error (ubi0:0 pid 24): make_reservation: cannot 
reserve 4144 bytes in jhead 2, error -30
[   36.670000] UBIFS error (ubi0:0 pid 24): do_writepage: cannot write 
folio 102 of inode 81, error -30
[   36.680000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:944
[   36.690000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: c->bi.dd_growth >= 0, in fs/ubifs/budget.c:550
[   36.700000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:1016
[   36.710000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: !c->ro_media && !c->ro_mount, in fs/ubifs/journal.c:108
[   36.720000] UBIFS error (ubi0:0 pid 24): make_reservation: cannot 
reserve 4144 bytes in jhead 2, error -30
[   36.730000] UBIFS error (ubi0:0 pid 24): do_writepage: cannot write 
folio 150 of inode 156, error -30
[   36.740000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: folio->private != NULL, in fs/ubifs/file.c:944
[   36.750000] UBIFS error (ubi0:0 pid 24): ubifs_assert_failed: UBIFS 
assert failed: c->bi.dd_growth >= 0, in fs/ubifs/budget.c:550

 From now on, nothing happens anymore.
What can cause this ? I see in the file.c:
"An attempt to dirty a page without budgeting for it - should not happen."

So, why can it happen :-) ?

Thanks a lot !
BR,
JM

