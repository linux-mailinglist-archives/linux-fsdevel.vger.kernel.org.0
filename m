Return-Path: <linux-fsdevel+bounces-76362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH5fEfMIhGnhxAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 04:05:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E5EE316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 04:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8BEF301AA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4D2BE05F;
	Thu,  5 Feb 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xlu5bugQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496E23A562;
	Thu,  5 Feb 2026 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260676; cv=none; b=JjGw9OowTzWcOJlZts43JusjalXe9cglvDwPwPZtVoYm9fSlOOUBU79HpH5AtD7zMiFOla1FIKa+Gyty/CGibzcoyEUnKrkIOsy5Vj24MD++FxXCgkYDlLPF71V4AJDz8/lLOFdBvMYamLHsAH9aWc6jWapYSu9CMOLLrJRoPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260676; c=relaxed/simple;
	bh=k2wLbywEx+S52de5UDVGpjSdRJirETzNr/1i/QcWsvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gwsiSUklWFgQV9oQmwE2Gdq+UhM04XL70XZEr3BzJbBLM/3qhsZ/erJfJxSkn5vN76eN+hbhr61zPs8bUqjULAKxr9U8XGxVplNPzeZ03716pMGgyXy6I0fN7zXPLKsBWsL2p4jd4bCOo89zopCJ14Tc+XjlFYtneoveqcYzbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xlu5bugQ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JtxLQoJ4LLngf0WmQA8UpG/3jJyziGv622foUct3asc=;
	b=xlu5bugQGEaFhk9LxQGXGf/f0wSm5wY0Kjf9DvSI/Da+OEeM9Jc3CDvILCNF4uEEqEgm+9SIG
	O7B5FKU4nlyGF/CxdPHuD4gAyNMuv5MG6rapPv75XMX/sO8ztU5yBQ4OGwsNKn9a27FOP9wam33
	DPb4977IKNIrmLbqolk1x+Y=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f625548h3z1K96Z;
	Thu,  5 Feb 2026 10:59:53 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C8FD440565;
	Thu,  5 Feb 2026 11:04:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 11:04:24 +0800
Message-ID: <4efb3689-c7e0-4f7f-b557-aead4c628851@huawei.com>
Date: Thu, 5 Feb 2026 11:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, Jan Kara <jack@suse.cz>
CC: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	<linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <djwong@kernel.org>, Zhang
 Yi <yi.zhang@huawei.com>, <yizhang089@gmail.com>, <yangerkun@huawei.com>,
	<yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	<libaokun9@gmail.com>, Baokun Li <libaokun1@huawei.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
 <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
 <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76362-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,infradead.org,vger.kernel.org,dilger.ca,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun1@huawei.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 931E5EE316
X-Rspamd-Action: no action

On 2026-02-05 10:06, Zhang Yi wrote:
> On 2/4/2026 10:23 PM, Jan Kara wrote:
>> On Wed 04-02-26 09:59:36, Baokun Li wrote:
>>> On 2026-02-03 21:14, Theodore Tso wrote:
>>>> On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
>>>>> This means that the ordered journal mode is no longer in ext4 used
>>>>> under the iomap infrastructure.  The main reason is that iomap
>>>>> processes each folio one by one during writeback. It first holds the
>>>>> folio lock and then starts a transaction to create the block mapping.
>>>>> If we still use the ordered mode, we need to perform writeback in
>>>>> the logging process, which may require initiating a new transaction,
>>>>> potentially leading to deadlock issues. In addition, ordered journal
>>>>> mode indeed has many synchronization dependencies, which increase
>>>>> the risk of deadlocks, and I believe this is one of the reasons why
>>>>> ext4_do_writepages() is implemented in such a complicated manner.
>>>>> Therefore, I think we need to give up using the ordered data mode.
>>>>>
>>>>> Currently, there are three scenarios where the ordered mode is used:
>>>>> 1) append write,
>>>>> 2) partial block truncate down, and
>>>>> 3) online defragmentation.
>>>>>
>>>>> For append write, we can always allocate unwritten blocks to avoid
>>>>> using the ordered journal mode.
>>>> This is going to be a pretty severe performance regression, since it
>>>> means that we will be doubling the journal load for append writes.
>>>> What we really need to do here is to first write out the data blocks,
>>>> and then only start the transaction handle to modify the data blocks
>>>> *after* the data blocks have been written (to heretofore, unused
>>>> blocks that were just allocated).  It means inverting the order in
>>>> which we write data blocks for the append write case, and in fact it
>>>> will improve fsync() performance since we won't be gating writing the
>>>> commit block on the date blocks getting written out in the append
>>>> write case.
>>> I have some local demo patches doing something similar, and I think this
>>> work could be decoupled from Yi's patch set.
>>>
>>> Since inode preallocation (PA) maintains physical block occupancy with a
>>> logical-to-physical mapping, and ensures on-disk data consistency after
>>> power failure, it is an excellent location for recording temporary
>>> occupancy. Furthermore, since inode PA often allocates more blocks than
>>> requested, it can also help reduce file fragmentation.
>>>
>>> The specific approach is as follows:
>>>
>>> 1. Allocate only the PA during block allocation without inserting it into
>>>    the extent status tree. Return the PA to the caller and increment its
>>>    refcount to prevent it from being discarded.
>>>
>>> 2. Issue IOs to the blocks within the inode PA. If IO fails, release the
>>>    refcount and return -EIO. If successful, proceed to the next step.
>>>
>>> 3. Start a handle upon successful IO completion to convert the inode PA to
>>>    extents. Release the refcount and update the extent tree.
>>>
>>> 4. If a corresponding extent already exists, we’ll need to punch holes to
>>>    release the old extent before inserting the new one.
>> Sounds good. Just if I understand correctly case 4 would happen only if you
>> really try to do something like COW with this? Normally you'd just use the
>> already present blocks and write contents into them?
>>
>>> This ensures data atomicity, while jbd2—being a COW-like implementation
>>> itself—ensures metadata atomicity. By leveraging this "delay map"
>>> mechanism, we can achieve several benefits:
>>>
>>>  * Lightweight, high-performance COW.
>>>  * High-performance software atomic writes (hardware-independent).
>>>  * Replacing dio_readnolock, which might otherwise read unexpected zeros.
>>>  * Replacing ordered data and data journal modes.
>>>  * Reduced handle hold time, as it's only held during extent tree updates.
>>>  * Paving the way for snapshot support.
>>>
>>> Of course, COW itself can lead to severe file fragmentation, especially
>>> in small-scale overwrite scenarios.
>> I agree the feature can provide very interesting benefits and we were
>> pondering about something like that for a long time, just never got to
>> implementing it. I'd say the immediate benefits are you can completely get
>> rid of dioread_nolock as well as the legacy dioread_lock modes so overall
>> code complexity should not increase much. We could also mostly get rid of
>> data=ordered mode use (although not completely - see my discussion with
>> Zhang over patch 3) which would be also welcome simplification. These
> I suppose this feature can also be used to get rid of the data=ordered mode
> use in online defragmentation. With this feature, perhaps we can develop a
> new method of online defragmentation that eliminates the need to pre-allocate
> a donor file.  Instead, we can attempt to allocate as many contiguous blocks
> as possible through PA. If the allocated length is longer than the original
> extent, we can perform the swap and copy the data. Once the copy is complete,
> we can atomically construct a new extent, then releases the original blocks
> synchronously or asynchronously, similar to a regular copy-on-write (COW)
> operation. What does this sounds?
>
> Regards,
> Yi.

Good idea! This is much more efficient than allocating files first and
then swapping them. While COW can exacerbate fragmentation, it can also
be leveraged for defragmentation.

We could monitor the average extent length of files within the kernel and
add those that fall below a certain threshold to a "pending defrag" list.
Defragmentation could then be triggered at an appropriate time. To ensure
the effectiveness of the defrag process, we could also set a minimum
length requirement for inode PAs.


Cheers,
Baokun

>> benefits alone are IMO a good enough reason to have the functionality :).
>> Even without COW, atomic writes and other fancy stuff.
>>
>> I don't see how you want to get rid of data=journal mode - perhaps that's
>> related to the COW functionality?
>>
>> 								Honza



