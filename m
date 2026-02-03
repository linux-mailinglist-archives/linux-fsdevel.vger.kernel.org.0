Return-Path: <linux-fsdevel+bounces-76173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJnII569gWm7JAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:19:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA9D6B6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E020C305EF52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7A396D1B;
	Tue,  3 Feb 2026 09:18:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC730CD95;
	Tue,  3 Feb 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110300; cv=none; b=kWv2PS/L01OUJedw6pCVGyv3ubrlO0JokDRt9CO9z/LYAPwrWkk+X71ZLGBVYvApXc++mTppgQRrN7e99P8hvO0Ax3VzY0wWs1pOxfhxilW22wFm+lLzcdWscJrLaJmm5d9pzJ+wUqozbp2Ui8snnlvFNtmDnwmBJgL/3v3OZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110300; c=relaxed/simple;
	bh=fVkwbUOOKlSgxGlwFPz9wKQ0vaYDWfgpQZ1O84RdCKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih4MCI7NJgZJ3KHqm72h6B5fRbmZDLrPUc7XFJKU2nwWdv1SX5QJu4FYDqnXzPVQNz85yOK0qTOSo8Q0q/W7Ks7TrDIXV7afBej8GLdX7XvOu/uFBWVxYl0fqHQProz3uBOVAqC200naXZ6RPXIcZBNRcA3OXFNyf0KWAmP7p5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4yZ70T8JzKHMjx;
	Tue,  3 Feb 2026 17:17:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8BBCA40539;
	Tue,  3 Feb 2026 17:18:12 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_dSvYFpxWVpGA--.22248S3;
	Tue, 03 Feb 2026 17:18:12 +0800 (CST)
Message-ID: <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
Date: Tue, 3 Feb 2026 17:18:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ojaswin@linux.ibm.com, ritesh.list@gmail.com,
 djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yi.zhang@huaweicloud.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aYGZB_hugPRXCiSI@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHZ_dSvYFpxWVpGA--.22248S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW3Aw4kXw45tr4kKrWfXwb_yoW7ZF1kpF
	Z8KFyftrn2gryjk3Z7Aa1Iqr40k3yrJFy3Gr1rKrs7urZ0gF1FyFWqqw1YgFyUGr1xCry2
	vw4YvryIkFykZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbmsjUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-76173-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 38CA9D6B6B
X-Rspamd-Action: no action

Hi, Christoph!

On 2/3/2026 2:43 PM, Christoph Hellwig wrote:
>> Original Cover (Updated):
> 
> This really should always be first.  The updates are rather minor
> compared to the overview that the cover letter provides.
> 
>> Key notes on the iomap implementations in this series.
>>  - Don't use ordered data mode to prevent exposing stale data when
>>    performing append write and truncating down.
> 
> I can't parse this.

Thank you for looking into this series, and sorry for the lack of
clarity. The reasons of these key notes have been described in
detail in patch 12-13.

This means that the ordered journal mode is no longer in ext4 used
under the iomap infrastructure.  The main reason is that iomap
processes each folio one by one during writeback. It first holds the
folio lock and then starts a transaction to create the block mapping.
If we still use the ordered mode, we need to perform writeback in
the logging process, which may require initiating a new transaction,
potentially leading to deadlock issues. In addition, ordered journal
mode indeed has many synchronization dependencies, which increase
the risk of deadlocks, and I believe this is one of the reasons why
ext4_do_writepages() is implemented in such a complicated manner.
Therefore, I think we need to give up using the ordered data mode.

Currently, there are three scenarios where the ordered mode is used:
1) append write,
2) partial block truncate down, and
3) online defragmentation.

For append write, we can always allocate unwritten blocks to avoid
using the ordered journal mode. For partial block truncate down, we
can explicitly perform a write-back. The third case is the only one
that will be somewhat more complex. It needs to use the ordered mode
to ensure the atomicity of data copying and extents exchange when
exchanging extents and copying data between two files, preventing
data loss. Considering performance, we cannot explicitly perform a
writeback for each extent exchange. I have not yet thought of a
simple way to handle this. This will require consideration of other
solutions when supporting online defragmentation in the future.

> 
>>  - Override dioread_nolock mount option, always allocate unwritten
>>    extents for new blocks.
> 
> Why do you override it?

There are two reasons:

The first one is the previously mentioned reason of not using
ordered journal mode. To prevent exposing stale data during a power
failure that occurs while performing append writes, unwritten
extents are always requested for newly allocated blocks.

The second one is to consider performance during writeback. When
doing writeback, we should allocate blocks as long as possible when
first calling ->writeback_range() based on the writeback length,
rather than mapping each folio individually. Therefore, to avoid the
situation where more blocks are allocated than actually written
(which could cause fsck to complain), we cannot directly allocate
written blocks before performing writeback.

> 
>>  - When performing write back, don't use reserved journal handle and
>>    postponing updating i_disksize until I/O is done.
> 
> Again missing the why and the implications.

The reserved journal handle is used to solve deadlock issues in
transaction dependencies when writeback occurs in ordered journal
mode. This mechanism is no longer necessary if the ordered mode is
not used.

> 
>>  buffered write
>>  ==============
>>
>>   buffer_head:
>>   bs      write cache    uncached write
>>   1k       423  MiB/s      36.3 MiB/s
>>   4k       1067 MiB/s      58.4 MiB/s
>>   64k      4321 MiB/s      869  MiB/s
>>   1M       4640 MiB/s      3158 MiB/s
>>   
>>   iomap:
>>   bs      write cache    uncached write
>>   1k       403  MiB/s      57   MiB/s
>>   4k       1093 MiB/s      61   MiB/s
>>   64k      6488 MiB/s      1206 MiB/s
>>   1M       7378 MiB/s      4818 MiB/s
> 
> This would read better if you actually compated buffered_head
> vs iomap side by side.
> 
> What is the bs?  The read unit size?  I guess not the file system
> block size as some of the values are too large for that.

The 'bs' is the read/write unit size, and the fs block size is the
default 4KB.

> 
> Looks like iomap is faster, often much faster except for the
> 1k cached case, where it is slightly slower.  Do you have
> any idea why?

I observed the on-cpu flame graph. I think the main reason is the
buffer_head loop path detects the folio and buffer_head status.
It saves the uptodate flag in the buffer_head structure when the
first 1KB write for each 4KB folio, it doesn't need to get blocks
for the remaining three writes.  However, the iomap infrastructure
always call ->iomap_begin() to acquire the mapping info for each
1KB write.  Although the first call to ->iomap_begin() has already
allocated the block extent, there are still some overheads due to
synchronization operations such as locking when subsequent calls
are made. The smaller the unit size, the greater the impact, and
this will also have a greater impact on pure cache writes than on
uncached writes.

> 
>>  buffered read
>>  =============
>>
>>   buffer_head:
>>   bs      read hole   read cache      read data
>>   1k       635  MiB/s    661  MiB/s    605  MiB/s
>>   4k       1987 MiB/s    2128 MiB/s    1761 MiB/s
>>   64k      6068 MiB/s    9472 MiB/s    4475 MiB/s
>>   1M       5471 MiB/s    8657 MiB/s    4405 MiB/s
>>
>>   iomap:
>>   bs      read hole   read cache       read data
>>   1k       643  MiB/s    653  MiB/s    602  MiB/s
>>   4k       2075 MiB/s    2159 MiB/s    1716 MiB/s
>>   64k      6267 MiB/s    9545MiB/s     4451 MiB/s
>>   1M       6072 MiB/s    9191MiB/s     4467 MiB/s
> 
> What is read cache vs read data here?
> 

The 'read cache' means that preread is set to 1 during fio tests,
causing it to read cached data. In contrast, the 'read data'
preread is set to 0, so it always reads data directly from the
disk.

Thanks,
Yi.


> Otherwise same comments as for the write case.
> 


