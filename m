Return-Path: <linux-fsdevel+bounces-26461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0F9598BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CBB1F21414
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105D41EA3CC;
	Wed, 21 Aug 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="FHpuGTrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C51EA3BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232504; cv=none; b=VFRPvVknrRZEYI1CjB9gcGD+KXZUizf1OTPhzMbMR76eLGNNg0TfDTj4cSklMoTFPIPkcvmrL8cYtfrd/1Hg5Ll4vXiAt6JuCIxf+30uYtp1HHzWV/XiT3frgN+0V0JlTAZKiQHzBFt8zIbO8y8dFkEOD0WCOy0cAqfgd+d2FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232504; c=relaxed/simple;
	bh=1QQz6VkSRFxisVwqw2EV348f3q+JpY8aenPnbq4YKJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osmCKGgTOUjGZU/3+G/Lg/Oat4d+89SsGHaFT/JLLPUx9pdMKWRmztidb23JuUgtrSudQ0z3A7x0PLLLCvXPiYbYLGsk1yC3vYVnaowS/gaBPKeR2SDJoz91QOIPxrWYsaLsDN9+IRMymS+vypUdBeTDvwceWG6P8mJQV3UTgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=FHpuGTrD; arc=none smtp.client-ip=213.205.33.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from [192.168.178.50] ([79.20.196.116])
	by santino.mail.tiscali.it with 
	id 2ZT82D01L2X9Uhr01ZT9pH; Wed, 21 Aug 2024 09:27:10 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <d23f8a90-34e1-4c3a-8eaa-2b095e1bea32@tiscali.it>
Date: Wed, 21 Aug 2024 11:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v7 0/8] filtering and snapshots of a block devices
Content-Language: it
To: Sergei Shtepa <sergei.shtepa@linux.dev>, axboe@kernel.dk,
 hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
From: Fabio Fantoni <fantonifabio@tiscali.it>
Autocrypt: addr=fantonifabio@tiscali.it; keydata=
 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
In-Reply-To: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 240821-0, 21/8/2024), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1724232430; bh=7qU3MmG7h0G3VOUFuVbnsi9DKbw72im+wMZ4XEuCMTs=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
	b=FHpuGTrDVO8GVZ3X+nvHBCCC2T5OgYU0fnvlxmx8555Kn1vkplGgqHr035jBFSjfJ
	 Fj4Tk1gNbKDyvOHNkqM1ubq9RxYEHYi92RmQN3Mk6JQ3ttMfDeyKdQ1qoLBc39Kzee
	 qL8ykRHg9FUpfxQaHyVHaEY9qPLVoZB3e/au5FFw=

Il 09/02/2024 17:01, Sergei Shtepa ha scritto:
> Hi all.
>
> I am happy to offer an improved version of the block device filtering
> mechanism (blkfilter) and module for creating snapshots of block devices
> (blksnap).
>
> The filtering block device mechanism is implemented in the block layer.
> This allows to attach and detach block device filters. Filters extend the
> functionality of the block layer. See more in
> Documentation/block/blkfilter.rst.
>
> The main purpose of snapshots of block devices is to provide backups of
> them. See more in Documentation/block/blksnap.rst. The tool, library and
> tests for working with blksnap can be found on github.
> Link: https://github.com/veeam/blksnap/tree/stable-v2.0
> There is also documentation from which you can learn how to manage the
> module using the library and the console tool.
>
> Based on LK v6.8-rc3 with Christoph's patchset "clean up blk_mq_submit_bio".
> Link: https://lore.kernel.org/linux-block/50fbe76b-d77d-4a7e-bda4-3a3b754fbd7e@kernel.org/T/#t
>
> I express my appreciation and gratitude to Christoph. Thanks to his
> attention to the project, it was possible to raise the quality of the code.
> I probably wouldn't have made version 7 if it wasn't for his help.
> I am sure that the blksnap module will improve the quality of backup tools
> for Linux.
>
> v7 changes:
> - The location of the filtering of I/O units has been changed. This made it
>    possible to remove the additional call bio_queue_enter().
> - Remove configs BLKSNAP_DIFF_BLKDEV and BLKSNAP_CHUNK_DIFF_BIO_SYNC.
> - To process the ioctl, the switch statement is used instead of a table
>    with functions.
> - Instead of a file descriptor, the module gets a path on the file system.
>    This allows the kernel module to correctly open a file or block device
>    with exclusive access rights.
> - Fixed a bio leaking bugs.

Hi, looking 
https://lore.kernel.org/all/20240209160204.1471421-1-sergei.shtepa@linux.dev/ 
I don't see any response to this latest version of blksnap even though a 
lot of time has passed, and this seems strange to me.

 From what I see recipients were less to avoid being blocked by antispam 
and double shipments like previous versions, and there was an error in 
subjects from patch 3/8 to patch 8/8, where I think it should be 
"blksnap:" or "block/blksnap:" instead of "block:" at the beginning of 
the subjects.

However, the error in the subjects does not seem serious to me to avoid 
possible replies, or am I wrong?

Isn't there anyone who wants to comment or review?

I want to thank Sergei Shtepa for all his work and others people that 
helped with previous versions review and advices, especially Christoph 
Hellwig who helped so much, and I hope the project can proceed.

>
> v6 changes:
> - The difference storage has been changed.
>    In the previous version, the file was created only to reserve sector
>    ranges on a block device. The data was stored directly to the block
>    device in these sector ranges. Now saving and reading data is done using
>    'VFS' using vfs_iter_write() and vfs_iter_read() functions. This allows
>    not to depend on the filesystem and use, for example, tmpfs. Using an
>    unnamed temporary file allows hiding it from other processes and
>    automatically release it when the snapshot is closed.
>    However, now the module does not allow adding a block device to the
>    snapshot on which the difference storage is located. There is no way to
>    ensure the immutability of file metadata when writing data to a file.
>    This means that the metadata of the filesystem may change, which may
>    cause damage to the snapshot.
> - _IOW and _IOR were mixed up - fixed.
> - Protection against the use of the snapshots for block devices with
>    hardware inline encryption and data integrity was implemented.
>    Compatibility with them was not planned and has not been tested at the
>    moment.
>
> v5 changes:
> - Rebase for "kernel/git/axboe/linux-block.git" branch "for-6.5/block".
>    Link: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.5/block
>
> v4 changes:
> - Structures for describing the state of chunks are allocated dynamically.
>    This reduces memory consumption, since the struct chunk is allocated only
>    for those blocks for which the snapshot image state differs from the
>    original block device.
> - The algorithm for calculating the chunk size depending on the size of the
>    block device has been changed. For large block devices, it is now
>    possible to allocate a larger number of chunks, and their size is smaller.
> - For block devices, a 'filter' file has been added to /sys/block/<device>.
>    It displays the name of the filter that is attached to the block device.
> - Fixed a problem with the lack of protection against re-adding a block
>    device to a snapshot.
> - Fixed a bug in the algorithm of allocating the next bio for a chunk.
>    This problem was occurred on large disks, for which a chunk consists of
>    at least two bio.
> - The ownership mechanism of the diff_area structure has been changed.
>    This fixed the error of prematurely releasing the diff_area structure
>    when destroying the snapshot.
> - Documentation corrected.
> - The Sparse analyzer is passed.
> - Use __u64 type instead pointers in UAPI.
>
> v3 changes:
> - New block device I/O controls BLKFILTER_ATTACH and BLKFILTER_DETACH allow
>    to attach and detach filters.
> - New block device I/O control BLKFILTER_CTL allow sending command to
>    attached block device filter.
> - The copy-on-write algorithm for processing I/O units has been optimized
>    and has become asynchronous.
> - The snapshot image reading algorithm has been optimized and has become
>    asynchronous.
> - Optimized the finite state machine for processing chunks.
> - Fixed a tracking block size calculation bug.
>
> v2 changes:
> - Added documentation for Block Device Filtering Mechanism.
> - Added documentation for Block Devices Snapshots Module (blksnap).
> - The MAINTAINERS file has been updated.
> - Optimized queue code for snapshot images.
> - Fixed comments, log messages and code for better readability.
>
> v1 changes:
> - Forgotten "static" declarations have been added.
> - The text of the comments has been corrected.
> - It is possible to connect only one filter, since there are no others in
>    upstream.
> - Do not have additional locks for attach/detach filter.
> - blksnap.h moved to include/uapi/.
> - #pragma once and commented code removed.
> - uuid_t removed from user API.
> - Removed default values for module parameters from the configuration file.
> - The debugging code for tracking memory leaks has been removed.
> - Simplified Makefile.
> - Optimized work with large memory buffers, CBT tables are now in virtual
>    memory.
> - The allocation code of minor numbers has been optimized.
> - The implementation of the snapshot image block device has been
>    simplified, now it is a bio-based block device.
> - Removed initialization of global variables with null values.
> - only one bio is used to copy one chunk.
> - Checked on ppc64le.
>
> Sergei Shtepa (8):
>    documentation: filtering and snapshots of a block devices
>    block: filtering of a block devices
>    block: header file of the blksnap module interface
>    block: module management interface functions
>    block: handling and tracking I/O units
>    block: difference storage implementation
>    block: snapshot and snapshot image block device
>    block: Kconfig, Makefile and MAINTAINERS files
>
>   Documentation/block/blkfilter.rst             |  66 ++
>   Documentation/block/blksnap.rst               | 351 ++++++++++
>   Documentation/block/index.rst                 |   2 +
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   MAINTAINERS                                   |  17 +
>   block/Makefile                                |   3 +-
>   block/bdev.c                                  |   2 +
>   block/blk-core.c                              |  26 +-
>   block/blk-filter.c                            | 257 +++++++
>   block/blk-mq.c                                |   7 +-
>   block/blk-mq.h                                |   2 +-
>   block/blk.h                                   |  11 +
>   block/genhd.c                                 |  10 +
>   block/ioctl.c                                 |   7 +
>   block/partitions/core.c                       |   9 +
>   drivers/block/Kconfig                         |   2 +
>   drivers/block/Makefile                        |   2 +
>   drivers/block/blksnap/Kconfig                 |  12 +
>   drivers/block/blksnap/Makefile                |  15 +
>   drivers/block/blksnap/cbt_map.c               | 225 +++++++
>   drivers/block/blksnap/cbt_map.h               |  90 +++
>   drivers/block/blksnap/chunk.c                 | 631 ++++++++++++++++++
>   drivers/block/blksnap/chunk.h                 | 134 ++++
>   drivers/block/blksnap/diff_area.c             | 577 ++++++++++++++++
>   drivers/block/blksnap/diff_area.h             | 175 +++++
>   drivers/block/blksnap/diff_buffer.c           | 114 ++++
>   drivers/block/blksnap/diff_buffer.h           |  37 +
>   drivers/block/blksnap/diff_storage.c          | 290 ++++++++
>   drivers/block/blksnap/diff_storage.h          | 103 +++
>   drivers/block/blksnap/event_queue.c           |  81 +++
>   drivers/block/blksnap/event_queue.h           |  64 ++
>   drivers/block/blksnap/main.c                  | 481 +++++++++++++
>   drivers/block/blksnap/params.h                |  16 +
>   drivers/block/blksnap/snapimage.c             | 135 ++++
>   drivers/block/blksnap/snapimage.h             |  10 +
>   drivers/block/blksnap/snapshot.c              | 462 +++++++++++++
>   drivers/block/blksnap/snapshot.h              |  65 ++
>   drivers/block/blksnap/tracker.c               | 369 ++++++++++
>   drivers/block/blksnap/tracker.h               |  78 +++
>   include/linux/blk-filter.h                    |  72 ++
>   include/linux/blk_types.h                     |   1 +
>   include/linux/sched.h                         |   1 +
>   include/uapi/linux/blk-filter.h               |  35 +
>   include/uapi/linux/blksnap.h                  | 384 +++++++++++
>   include/uapi/linux/fs.h                       |   3 +
>   45 files changed, 5430 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/block/blkfilter.rst
>   create mode 100644 Documentation/block/blksnap.rst
>   create mode 100644 block/blk-filter.c
>   create mode 100644 drivers/block/blksnap/Kconfig
>   create mode 100644 drivers/block/blksnap/Makefile
>   create mode 100644 drivers/block/blksnap/cbt_map.c
>   create mode 100644 drivers/block/blksnap/cbt_map.h
>   create mode 100644 drivers/block/blksnap/chunk.c
>   create mode 100644 drivers/block/blksnap/chunk.h
>   create mode 100644 drivers/block/blksnap/diff_area.c
>   create mode 100644 drivers/block/blksnap/diff_area.h
>   create mode 100644 drivers/block/blksnap/diff_buffer.c
>   create mode 100644 drivers/block/blksnap/diff_buffer.h
>   create mode 100644 drivers/block/blksnap/diff_storage.c
>   create mode 100644 drivers/block/blksnap/diff_storage.h
>   create mode 100644 drivers/block/blksnap/event_queue.c
>   create mode 100644 drivers/block/blksnap/event_queue.h
>   create mode 100644 drivers/block/blksnap/main.c
>   create mode 100644 drivers/block/blksnap/params.h
>   create mode 100644 drivers/block/blksnap/snapimage.c
>   create mode 100644 drivers/block/blksnap/snapimage.h
>   create mode 100644 drivers/block/blksnap/snapshot.c
>   create mode 100644 drivers/block/blksnap/snapshot.h
>   create mode 100644 drivers/block/blksnap/tracker.c
>   create mode 100644 drivers/block/blksnap/tracker.h
>   create mode 100644 include/linux/blk-filter.h
>   create mode 100644 include/uapi/linux/blk-filter.h
>   create mode 100644 include/uapi/linux/blksnap.h
>


