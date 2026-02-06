Return-Path: <linux-fsdevel+bounces-76515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBiuLPJOhWkS/wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:16:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318EF92CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C24130309A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EAC2505B2;
	Fri,  6 Feb 2026 02:15:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52041AF4D5;
	Fri,  6 Feb 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344156; cv=none; b=LSyeP5k+uLlsKxHKEXvAhslisl9YcrzIMeTnKHd7zRhbImT8XWvrFm1/tKwrYUhN2rF/5XXUJf35d3/WSKXkZAy7747XiAKbk2XOV+JNkjWiDIRl32zw7ye2IAG5FZplREe9gT5ZJZu4TPCL0ZGSXz5H9kakON0qjkQXm4tpQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344156; c=relaxed/simple;
	bh=Bs95TTNr/fWSIYYT0ShJqnyM4I3froWUPd/pbjAFM34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rClR7+qZsG2AeypYCXsWosxlC/4dJ6fMNkaiClBp7f2gJyapArZfDujijnzGPOZa3y9KkFzSONeMZE/eaeP5kzUno1KGBUyRcmPIb4ZWc9lr4Jcb/0uZhC3TMU/vWRgOmOcezXXeOYqFKyz1AMhqnvfDJH1hRIIkLh3i751H/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f6d3L61nVzKHMYh;
	Fri,  6 Feb 2026 10:15:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7EF5340576;
	Fri,  6 Feb 2026 10:15:52 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXxfXWToVpBmCtGQ--.62288S3;
	Fri, 06 Feb 2026 10:15:52 +0800 (CST)
Message-ID: <8729b45a-8052-41e3-b6eb-3d884097c670@huaweicloud.com>
Date: Fri, 6 Feb 2026 10:15:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
To: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>, Theodore Tso <tytso@mit.edu>,
 Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com,
 djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com,
 yangerkun@huawei.com,
 yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,
 libaokun9@gmail.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
 <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
 <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
 <zpjowfhezn5mr7sgmxdg5kghgskm4cip77qr4ok4j6oa5e36y7@5hdpftwo56ex>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <zpjowfhezn5mr7sgmxdg5kghgskm4cip77qr4ok4j6oa5e36y7@5hdpftwo56ex>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXxfXWToVpBmCtGQ--.62288S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr13urWUtry7AFWDGry3Jwb_yoW3XF1xpF
	W5Kas8tr4DJ34rCwn2vw1xXr4F9397JFW3Xr1Yqr47AF90gF1SqrWxtw4j9FyUCr1xJw1j
	qr4jq347uF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-76515-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,mit.edu,infradead.org,vger.kernel.org,dilger.ca,linux.ibm.com,gmail.com,kernel.org,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7318EF92CF
X-Rspamd-Action: no action

On 2/5/2026 8:58 PM, Jan Kara wrote:
> On Thu 05-02-26 10:06:11, Zhang Yi wrote:
>> On 2/4/2026 10:23 PM, Jan Kara wrote:
>>> On Wed 04-02-26 09:59:36, Baokun Li wrote:
>>>> On 2026-02-03 21:14, Theodore Tso wrote:
>>>>> On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
>>>>>> This means that the ordered journal mode is no longer in ext4 used
>>>>>> under the iomap infrastructure.  The main reason is that iomap
>>>>>> processes each folio one by one during writeback. It first holds the
>>>>>> folio lock and then starts a transaction to create the block mapping.
>>>>>> If we still use the ordered mode, we need to perform writeback in
>>>>>> the logging process, which may require initiating a new transaction,
>>>>>> potentially leading to deadlock issues. In addition, ordered journal
>>>>>> mode indeed has many synchronization dependencies, which increase
>>>>>> the risk of deadlocks, and I believe this is one of the reasons why
>>>>>> ext4_do_writepages() is implemented in such a complicated manner.
>>>>>> Therefore, I think we need to give up using the ordered data mode.
>>>>>>
>>>>>> Currently, there are three scenarios where the ordered mode is used:
>>>>>> 1) append write,
>>>>>> 2) partial block truncate down, and
>>>>>> 3) online defragmentation.
>>>>>>
>>>>>> For append write, we can always allocate unwritten blocks to avoid
>>>>>> using the ordered journal mode.
>>>>> This is going to be a pretty severe performance regression, since it
>>>>> means that we will be doubling the journal load for append writes.
>>>>> What we really need to do here is to first write out the data blocks,
>>>>> and then only start the transaction handle to modify the data blocks
>>>>> *after* the data blocks have been written (to heretofore, unused
>>>>> blocks that were just allocated).  It means inverting the order in
>>>>> which we write data blocks for the append write case, and in fact it
>>>>> will improve fsync() performance since we won't be gating writing the
>>>>> commit block on the date blocks getting written out in the append
>>>>> write case.
>>>>
>>>> I have some local demo patches doing something similar, and I think this
>>>> work could be decoupled from Yi's patch set.
>>>>
>>>> Since inode preallocation (PA) maintains physical block occupancy with a
>>>> logical-to-physical mapping, and ensures on-disk data consistency after
>>>> power failure, it is an excellent location for recording temporary
>>>> occupancy. Furthermore, since inode PA often allocates more blocks than
>>>> requested, it can also help reduce file fragmentation.
>>>>
>>>> The specific approach is as follows:
>>>>
>>>> 1. Allocate only the PA during block allocation without inserting it into
>>>>    the extent status tree. Return the PA to the caller and increment its
>>>>    refcount to prevent it from being discarded.
>>>>
>>>> 2. Issue IOs to the blocks within the inode PA. If IO fails, release the
>>>>    refcount and return -EIO. If successful, proceed to the next step.
>>>>
>>>> 3. Start a handle upon successful IO completion to convert the inode PA to
>>>>    extents. Release the refcount and update the extent tree.
>>>>
>>>> 4. If a corresponding extent already exists, we’ll need to punch holes to
>>>>    release the old extent before inserting the new one.
>>>
>>> Sounds good. Just if I understand correctly case 4 would happen only if you
>>> really try to do something like COW with this? Normally you'd just use the
>>> already present blocks and write contents into them?
>>>
>>>> This ensures data atomicity, while jbd2—being a COW-like implementation
>>>> itself—ensures metadata atomicity. By leveraging this "delay map"
>>>> mechanism, we can achieve several benefits:
>>>>
>>>>  * Lightweight, high-performance COW.
>>>>  * High-performance software atomic writes (hardware-independent).
>>>>  * Replacing dio_readnolock, which might otherwise read unexpected zeros.
>>>>  * Replacing ordered data and data journal modes.
>>>>  * Reduced handle hold time, as it's only held during extent tree updates.
>>>>  * Paving the way for snapshot support.
>>>>
>>>> Of course, COW itself can lead to severe file fragmentation, especially
>>>> in small-scale overwrite scenarios.
>>>
>>> I agree the feature can provide very interesting benefits and we were
>>> pondering about something like that for a long time, just never got to
>>> implementing it. I'd say the immediate benefits are you can completely get
>>> rid of dioread_nolock as well as the legacy dioread_lock modes so overall
>>> code complexity should not increase much. We could also mostly get rid of
>>> data=ordered mode use (although not completely - see my discussion with
>>> Zhang over patch 3) which would be also welcome simplification. These
>>
>> I suppose this feature can also be used to get rid of the data=ordered mode
>> use in online defragmentation. With this feature, perhaps we can develop a
>> new method of online defragmentation that eliminates the need to pre-allocate
>> a donor file.  Instead, we can attempt to allocate as many contiguous blocks
>> as possible through PA. If the allocated length is longer than the original
>> extent, we can perform the swap and copy the data. Once the copy is complete,
>> we can atomically construct a new extent, then releases the original blocks
>> synchronously or asynchronously, similar to a regular copy-on-write (COW)
>> operation. What does this sounds?
> 
> Well, the reason why defragmentation uses the donor file is that there can
> be a lot of policy in where and how the file is exactly placed (e.g. you
> might want to place multiple files together). It was decided it is too
> complex to implement these policies in the kernel so we've offloaded the
> decision where the file is placed to userspace. Back at those times we were
> also considering adding interface to guide allocation of blocks for a file
> so the userspace defragmenter could prepare donor file with desired blocks.

Indeed, it is easier to implement different strategies through donor files.

> But then the interest in defragmentation dropped (particularly due to
> advances in flash storage) and so these ideas never materialized.

As I understand it, defragmentation offers two primary benefits:

1. It improves the contiguity of file blocks, thereby enhancing read/write
   performance;
2. It reduces the overhead on the block allocator and the management of
   metadata.

As for the first point, indeed, this role has gradually diminished with the
development of flash memory devices. However, I believe the second point is
still very useful. For example, some of our customers have scenarios
involving large-capacity storage, where data is continuously written in a
cyclic manner. This results in the disk space usage remaining at a high level
for a long time, with a large number of both big and small files. Over time,
as fragmentation increases, the CPU usage of the mb_allocater will
significantly rise. Although this issue can be alleviated to some extent
through optimizations of the mb_allocater algorithm and the use of other
pre-allocation techniques, we still find online defragmentation to be very
necessary.

> 
> We might rethink the online defragmentation interface but at this point
> I'm not sure we are ready to completely replace the idea of guiding the
> block placement using a donor file...
> 
> 								Honza

Yeah, we can rethink it when supporting online defragmentation for the iomap
path.

Cheers,
Yi.


