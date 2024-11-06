Return-Path: <linux-fsdevel+bounces-33738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEAE9BE4E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238101F249F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461BC1DE3D5;
	Wed,  6 Nov 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="V0/ot55U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA81DA622;
	Wed,  6 Nov 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890537; cv=none; b=WzPGCdw0+8OhxIlYuNhf4JCnH7IMnBCtkgBLfMPsn+dm0VwTEtBkmroWtHlYg/HA1utSYXlXBuCKIjynmFp0yyNU4fmi9FNiJybJO943HhMibdKlZizEcHJpDWB6DZ62OhDoTCIBYf2OAVuF0Pc9WUMkimaOjIZOLSGU1C8N8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890537; c=relaxed/simple;
	bh=xw7CUVocxa1S1q1z7hb2kHdcroA/d47oFWadAt6lk1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsUR5l0dF7xUd+ygW686I/h8gVVop9ICdHSZz1kfH4X9FsDk/nhSqt2FFWRRitzBZDsjzbWDQYFK538FUIzxtWBQuTdy7wVdt+RJjU1G5Z+muJ31VkEw2Q7fGglA4HB8+FH4w4amBw/4WPqqgJKOWz+BEW4txSYh+Bio8vbYEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=V0/ot55U; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id ECEC7445A0;
	Wed,  6 Nov 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1730890524;
	bh=xw7CUVocxa1S1q1z7hb2kHdcroA/d47oFWadAt6lk1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V0/ot55Uy1XtX5DEiRS3KMP18/l1oK47Aqg9ZfXySZuMOtOlMCPjoUdJWnbXOL9KN
	 /BBiMB7eGe+sKdwA48mux6IAXlfbf20N8RqQfnYRAHIoFB7JeHfzjhZ4ZSvL6B3X2M
	 M4D31UOk/6rohmDcDLdqjA4OEc33Mh7LwC64jU/hdHXMemeg3ThagBt0UJzKfy+Cnl
	 l24nTeDTkHVxBKjRHHvMK0fDmIeiw8F8F13gpvfVsQnnLJtj1hMf1TRIfEuzrkNRb3
	 5ksN1OdZhsAoqlsqUtFYo3ScHALgxx01WL1kkExm8SfEZ/uMxjRjDuTWlbD5Er9d5A
	 4XgM4uV7ERchA==
Message-ID: <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
Date: Wed, 6 Nov 2024 19:55:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Sergio Lopez Pascual
 <slp@redhat.com>, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <ZylHyD7Z+ApaiS5g@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/24 7:16 AM, Dave Chinner wrote:
> On Tue, Nov 05, 2024 at 12:31:22AM +0900, Asahi Lina wrote:
>>
>>
>> On 11/4/24 7:57 PM, Jan Kara wrote:
>>> On Fri 01-11-24 21:22:31, Asahi Lina wrote:
>>>> For virtio-dax, the file/FS blocksize is irrelevant. FUSE always uses
>>>> large DAX blocks (2MiB), which will work with all host page sizes. Since
>>>> we are mapping files into the DAX window on the host, the underlying
>>>> block size of the filesystem and its block device (if any) are
>>>> meaningless.
>>>>
>>>> For real devices with DAX, the only requirement should be that the FS
>>>> block size is *at least* as large as PAGE_SIZE, to ensure that at least
>>>> whole pages can be mapped out of the device contiguously.
>>>>
>>>> Fixes warning when using virtio-dax on a 4K guest with a 16K host,
>>>> backed by tmpfs (which sets blksz == PAGE_SIZE on the host).
>>>>
>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>> ---
>>>>  fs/dax.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Well, I don't quite understand how just relaxing the check is enough. I
>>> guess it may work with virtiofs (I don't know enough about virtiofs to
>>> really tell either way) but for ordinary DAX filesystem it would be
>>> seriously wrong if DAX was used with blocksize > pagesize as multiple
>>> mapping entries could be pointing to the same PFN which is going to have
>>> weird results.
>>
>> Isn't that generally possible by just mapping the same file multiple
>> times? Why would that be an issue?
> 
> I think what Jan is talking about having multiple inode->i_mapping
> entries point to the same pfn, not multiple vm mapped regions
> pointing at the same file offset....
> 
>> Of course having a block size smaller than the page size is never going
>> to work because you would not be able to map single blocks out of files
>> directly. But I don't see why a larger block size would cause any
>> issues. You'd just use several pages to map a single filesystem block.
> 
> If only it were that simple.....
> 
>> For example, if the block size is 16K and the page size is 4K, then a
>> single file block would be DAX mapped as four contiguous 4K pages in
>> both physical and virtual memory.
> 
> Up until 6.12, filesystems on linux did not support block size >
> page size. This was a constraint of the page cache implementation
> being based around the xarray indexing being tightly tied to
> PAGE_SIZE granularity indexing. Folios and large folio support
> provided the infrastructure to allow indexing to increase to order-N
> based index granularity. It's only taken 20 years to get a solution
> to this problem merged, but it's finally there now.

Right, but I thought that was already enforced at the filesystem level.
I don't understand why the actual DAX infrastructure would care...

Some FSes do already support *smaller* block size than page size (e.g.
btrfs), but obviously that case is never going to work with DAX.
 > Unfortunately, the DAX infrastructure is independent of the page
> cache but is also tightly tied to PAGE_SIZE based inode->i_mapping
> index granularity. In a way, this is even more fundamental than the
> page cache issues we had to solve. That's because we don't have
> folios with their own locks and size tracking. In DAX, we use the
> inode->i_mapping xarray entry for a given file offset to -serialise
> access to the backing pfn- via lock bits held in the xarray entry.
> We also encode the size of the dax entry in bits held in the xarray
> entry.
> 
> The filesystem needs to track dirty state with filesystem block
> granularity. Operations on filesystem blocks (e.g. partial writes,
> page faults) need to be co-ordinated across the entire filesystem
> block. This means we have to be able to lock a single filesystem
> block whilst we are doing instantiation, sub-block zeroing, etc.

Ah, so it's about locking? I had a feeling that might be the case...

> Large folio support in the page cache provided this "single tracking
> object for a > PAGE_SIZE range" support needed to allow fsb >
> page_size in filesystems. The large folio spans the entire
> filesystem block, providing a single serialisation and state
> tracking for all the page cache operations needing to be done on
> that filesystem block.
> 
> The DAX infrastructure needs the same changes for fsb > page size
> support. We have a limited number bits we can use for DAX entry
> state:
> 
> /*
>  * DAX pagecache entries use XArray value entries so they can't be mistaken
>  * for pages.  We use one bit for locking, one bit for the entry size (PMD)
>  * and two more to tell us if the entry is a zero page or an empty entry that
>  * is just used for locking.  In total four special bits.
>  *
>  * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
>  * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
>  * block allocation.
>  */
> #define DAX_SHIFT       (4)
> #define DAX_LOCKED      (1UL << 0)
> #define DAX_PMD         (1UL << 1)
> #define DAX_ZERO_PAGE   (1UL << 2)
> #define DAX_EMPTY       (1UL << 3)
> 
> I *think* that we have at most PAGE_SHIFT worth of bits we can
> use because we only store the pfn part of the pfn_t in the dax
> entry. There are PAGE_SHIFT high bits in the pfn_t that hold
> pfn state that we mask out.
> 
> Hence I think we can easily steal another 3 bits for storing an
> order - orders 0-4 are needed (3 bits) for up to 64kB on 4kB
> PAGE_SIZE - so I think this is a solvable problem. There's a lot
> more to it than "just use several pages to map to a single
> filesystem block", though.....

Honestly, this is all quite over my head... my use case is virtiofs,
which I think is quite different to running a filesystem on bare-metal
DAX. It's starting to sound like we should perhaps just gate off the
check for virtiofs only?

> 
>>> If virtiofs can actually map 4k subpages out of 16k page on
>>> host (and generally perform 4k granular tracking etc.), it would seem more
>>> appropriate if virtiofs actually exposed the filesystem 4k block size instead
>>> of 16k blocksize? Or am I missing something?
>>
>> virtiofs itself on the guest does 2MiB mappings into the SHM region, and
>> then the guest is free to map blocks out of those mappings. So as long
>> as the guest page size is less than 2MiB, it doesn't matter, since all
>> files will be aligned in physical memory to that block size. It behaves
>> as if the filesystem block size is 2MiB from the point of view of the
>> guest regardless of the actual block size. For example, if the host page
>> size is 16K, the guest will request a 2MiB mapping of a file, which the
>> VMM will satisfy by mmapping 128 16K pages from its page cache (at
>> arbitrary physical memory addresses) into guest "physical" memory as one
>> contiguous block. Then the guest will see the whole 2MiB mapping as
>> contiguous, even though it isn't in physical RAM, and it can use any
>> page granularity it wants (that is supported by the architecture) to map
>> it to a userland process.
> 
> Clearly I'm missing something important because, from this
> description, I honestly don't know which mapping is actually using
> DAX.
> 
> Can you draw out the virtofs stack from userspace in the guest down
> to storage in the host so dumb people like myself know exactly where
> what is being directly accessed and how?

I'm not familiar with all of the details, but essentially virtiofs is
FUSE backed by a virtio device instead of userspace, plus the extra DAX
mapping stuff. Since it's not a real filesystem backed by a block
device, it has no significant concept of block size itself. i_blkbits
comes from the st_blksize of the inode stat, which in our case is passed
through from the underlying filesystem backing the virtiofs in the host
(but it could be anything, nothing says virtiofs has to be backed by a
real kernel FS in the host).

So as a baseline, virtiofs is just FUSE and block size doesn't matter
since all the non-mmap filesystem APIs shouldn't care about block size
(other than for optimization reasons and issues with torn racy writes).
The guest should be able to pretend the block size is 4K for FS/VM
purposes even if it's 16K in the host, and track everything in the page
cache and DAX infrastructure in terms of 4K blocks. As far as I know
there is no operation in plain FUSE that actually cares about the block
size itself.

So then there's DAX/mmap. When DAX is enabled, FUSE can issue
FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING opcodes. These request that a
range of a file be mapped into the device memory region used by
virtiofs. When the VMM receives those, it will use mmap to map the
backing file into the guest's virtio device memory window, and then the
guest can use DAX to directly access those pages and allow userspace
processes to mmap them directly. This means that mmaps are coherent
between processes on the guest and the host (or in another guest), which
is the main reason we're doing this.

If you look at fs/fuse/dax.c, you'll see that FUSE_DAX_SHIFT is 21. This
means that the FUSE code only ever issues
FUSE_SETUPMAPPING/FUSE_REMOVEMAPPING opcodes with offsets/lengths at
2MiB granularity within files. So, regardless of the underlying
filesystem block size in the host (if there is one at all), the guest
will always see aligned 2MiB blocks of files available in its virtio
device region, similar to the hypothetical case of an actual
block-backed DAX filesystem with a 2MiB allocation block size.

We could cap st_blksize in the VMM to 4K, I guess? I don't know if that
would make more sense than removing the kernel check. On one hand, that
might result in less optimized I/O if userspace then does 4K writes. On
the other hand, if we report st_blksize as 16K to userspace then I guess
it could assume concurrent 16K writes cannot be torn, which is not the
case if the guest is using 4K pages and page cache blocks (at least not
until all the folio stuff is worked out for blocks > page size in both
the page cache and DAX layers).

This WARN still feels like the wrong thing, though. Right now it is the
only thing in DAX code complaining on a page size/block size mismatch
(at least for virtiofs). If this is so important, I feel like there
should be a higher level check elsewhere, like something happening at
mount time or on file open. It should actually cause the operations to
fail cleanly.

~~ Lina


