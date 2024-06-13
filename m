Return-Path: <linux-fsdevel+bounces-21641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A313D90730B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA2B23EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE1E142633;
	Thu, 13 Jun 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="HS2TOvkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54868142654
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283480; cv=none; b=FdBrkb9G3otBOrfXiIIGvBzQF989Y5TCpPoR62jMQU8wNZGTRuYle2RgRqerNtwYAIKm/Py0IhJEK8wB+8jqex4cUXk8+0E38Gfx+eJfpt1fB5UbSqU1zxhs1sG5l+QwwslTn04so8UT6eHlYvbP1DifjAMGAO87H+d/mmr929s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283480; c=relaxed/simple;
	bh=GaTesfPa9KfN379uX/kTNQ2N9B7b1rKEDZkn7BXqo3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR+6wNzWuR2b0kWDVjxL2n0c5j4iZND2yEYDAAxJyWyYVVZ/VNC4ev4i9UjfFXexFdRFek9KCOUQvbtFAaze6S7Zt7IhtqZJPx1jeCHFcDlBWJRwQC0fn7xwad1SWjfQf+33VhUfS+fi0GD8jyIV3QNBhSRhIVzjugeeYqAwlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=HS2TOvkZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF49EE000F;
	Thu, 13 Jun 2024 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1718283471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln17ZxRL+upVh68wnbTdi1KTA2jYfvXcMhNeLfk448s=;
	b=HS2TOvkZeG68w8F8vNWzKEgAX22dLWuSPHlDvOdcAPBycdM7mjvCte+RRtlAbl3VFoiZj/
	qPcNES9ddnnPHYkw/e8p/WKEf/zkC4Zxr4c8IVlFQx0SiX76phFUUJOW9DSAh1TTJsqPhx
	I2pKDrlruxBKZn2mTt15ASOW9pmAOVatGGVjIjboWTEiG6ebFdHH5p0J5lU89Exyg05WkH
	lbazXqjFMXfxCLx/I9Mj2kfhC0BPiYk4viK2Cqr5rzIx22blshbo71cjUkgxCfj2XlPhEq
	gLjvufC8BxaTKgwzy0DCeiIQsmaw3NWiV8L2srBMZ/90k578XQY2eQ21MsSyxQ==
Message-ID: <ba441a7c-28f8-49c0-95b9-71a586007e44@yoseli.org>
Date: Thu, 13 Jun 2024 14:57:50 +0200
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

Hello Christoph,

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


Thanks, I did implement this one, but now I have another weird issue, I 
don't know if this can be related...

When the bash command is launched (my init command is init=/bin/bash) I 
can launch a first command (say, ls for instance) and it works fine. But 
a second call to this same command or any other one juste returns as if 
nothing was done... And I can't even debug, strace fails too:

execve("/bin/ls", ["/bin/ls"], 0xbfb31ef0 /* 5 vars */) = 0
brk(NULL)                               = 0x2ab7c000
atomic_barrier()                        = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 
-1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib/libresolv.so.2", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, 
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\4\0\0\0\1\0\0\0\0\0\0\0004"..., 
512) = 512
statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, 
STATX_BASIC_STATS, 
{stx_mask=STATX_TYPE|STATX_MODE|STATX_NLINK|STATX_UID|STATX_GID|STATX_MTIME|STATX_CTIME|STATX_INO|STATX_SIZE|STATX_BLOCKS|STATX_
MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0755, stx_size=43120, ...}) = 0
mmap2(NULL, 59888, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) 
=[   15.830000] random: crng init done
  0x60022000
mmap2(0x6002c000, 16384, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0x6002c000
mmap2(0x60030000, 2544, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x60030000
close(3)                                = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, 
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\4\0\0\0\1\0\2\324\n\0\0\0004"..., 
512) = 512
statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, 
STATX_BASIC_STATS, 
{stx_mask=STATX_TYPE|STATX_MODE|STATX_NLINK|STATX_UID|STATX_GID|STATX_MTIME|STATX_CTIME|STATX_INO|STATX_SIZE|STATX_BLOCKS|STATX_
MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0755, stx_size=1257660, ...}) = 0
mmap2(NULL, 1290920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x60032000
mmap2(0x6015e000, 24576, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12c000) = 0x6015e000
mmap2(0x60164000, 37544, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x60164000
close(3)                                = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
atomic_barrier()                        = 0
mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x6016e000
set_thread_area(0x601759c0)             = 0
get_thread_area()                       = 0x601759c0
atomic_barrier()                        = 0
set_tid_address(0x6016e548)             = 28
set_robust_list(0x6016e54c, 12)         = 0
mprotect(0x6015e000, 8192, PROT_READ)   = 0
mprotect(0x6002c000, 8192, PROT_READ)   = 0
mprotect(0x2ab72000, 8192, PROT_READ)   = 0
mprotect(0x6001e000, 8192, PROT_READ)   = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0xc00815f4} ---
+++ killed by SIGSEGV +++

I suppose this can be related to the ELF_DT_DYN_BASE address, but I 
can't see what is going on yet.

Thanks,
JM

