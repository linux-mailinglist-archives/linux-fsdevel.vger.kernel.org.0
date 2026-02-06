Return-Path: <linux-fsdevel+bounces-76509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI/pNaRAhWme+gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:15:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35851F8E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4344301AA53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7B239570;
	Fri,  6 Feb 2026 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ABe+Ds0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5019C54E;
	Fri,  6 Feb 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340505; cv=none; b=ppXUMM97sFWJ+GhbCK31EZ7WhPgHd/OiuJlFMuY6kUWNLujrMiAYSp+Xo0arDWwLqqNoFLtzVFwNQ9iiPlWQNX3PP5kxkzzuvNkCMLZNT4Kv27slAjVOxSY7z7nfQz8a+/eNr1dZTMmAwcFc/J/0NvZo31/dsNuqSa9xZ9HZwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340505; c=relaxed/simple;
	bh=A0AjAjUsGSSu5NFAHmcb2Nj/utizFM0hGfJTsGlv1dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iepVUqLBHb14bQSyXkmKSZJuVdQW+Pji+LtBuRyhYBbWuxv5igAIDCQbZLXlCEtsr2IlsI3VT5naz7QGrr3JSmFCZRm1TlyZkqRw8Ip/bx2anEp50IDe9j4S437LzEOipVryfcK9Iw9X1gyVFcc08dJ066YSgCOsWOj5Je3cXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ABe+Ds0i; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sQ8ZYm9EKNt348xD3uEYD5yQpwEtVLoM1aN86AiBAxA=;
	b=ABe+Ds0imj040vkRYzyHi2HGsgfk8ivxdDHrk2ni3E2N5oZ6RqptAnbPbEEa5nKltWfji+o4k
	DLHNPBECZNmrcniAuMCydPM3S7G/edovD+Q50oahr3K3l+AZTRMKM2Yagvc4xVKlNbflpQ+4V8l
	uEiISooKC6KVpxiZjkbctPc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f6bc948Cdz1prKt;
	Fri,  6 Feb 2026 09:10:17 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 40F5E4036C;
	Fri,  6 Feb 2026 09:14:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 09:14:53 +0800
Message-ID: <6b3fddd2-047b-4639-b54f-554b16a0ef36@huawei.com>
Date: Fri, 6 Feb 2026 09:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <ojaswin@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hch@infradead.org>, <djwong@kernel.org>, Zhang Yi
	<yi.zhang@huawei.com>, <yizhang089@gmail.com>, <yangerkun@huawei.com>,
	<yukuai@fnnas.com>, <libaokun9@gmail.com>, <libaokun9@gmail.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <9b7e93da-65dd-4574-be7f-4ec88bce4da7@huawei.com>
 <s434ifpengcthkmohmc6vvmvppx4o2k2ctk2p3it55ncgce3je@irbt7xpdnnzu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <s434ifpengcthkmohmc6vvmvppx4o2k2ctk2p3it55ncgce3je@irbt7xpdnnzu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
	TAGGED_FROM(0.00)[bounces-76509-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 35851F8E75
X-Rspamd-Action: no action

On 2026-02-05 22:07, Jan Kara wrote:
> On Thu 05-02-26 11:27:09, Baokun Li wrote:
>> On 2026-02-04 22:18, Jan Kara wrote:
>>> Hi Zhang!
>>>
>>> On Wed 04-02-26 14:42:46, Zhang Yi wrote:
>>>> On 2/3/2026 5:59 PM, Jan Kara wrote:
>>>>> On Tue 03-02-26 14:25:03, Zhang Yi wrote:
>>>>>> Currently, __ext4_block_zero_page_range() is called in the following
>>>>>> four cases to zero out the data in partial blocks:
>>>>>>
>>>>>> 1. Truncate down.
>>>>>> 2. Truncate up.
>>>>>> 3. Perform block allocation (e.g., fallocate) or append writes across a
>>>>>>    range extending beyond the end of the file (EOF).
>>>>>> 4. Partial block punch hole.
>>>>>>
>>>>>> If the default ordered data mode is used, __ext4_block_zero_page_range()
>>>>>> will write back the zeroed data to the disk through the order mode after
>>>>>> zeroing out.
>>>>>>
>>>>>> Among the cases 1,2 and 3 described above, only case 1 actually requires
>>>>>> this ordered write. Assuming no one intentionally bypasses the file
>>>>>> system to write directly to the disk. When performing a truncate down
>>>>>> operation, ensuring that the data beyond the EOF is zeroed out before
>>>>>> updating i_disksize is sufficient to prevent old data from being exposed
>>>>>> when the file is later extended. In other words, as long as the on-disk
>>>>>> data in case 1 can be properly zeroed out, only the data in memory needs
>>>>>> to be zeroed out in cases 2 and 3, without requiring ordered data.
>>>>> Hum, I'm not sure this is correct. The tail block of the file is not
>>>>> necessarily zeroed out beyond EOF (as mmap writes can race with page
>>>>> writeback and modify the tail block contents beyond EOF before we really
>>>>> submit it to the device). Thus after this commit if you truncate up, just
>>>>> zero out the newly exposed contents in the page cache and dirty it, then
>>>>> the transaction with the i_disksize update commits (I see nothing
>>>>> preventing it) and then you crash, you can observe file with the new size
>>>>> but non-zero content in the newly exposed area. Am I missing something?
>>>>>
>>>> Well, I think you are right! I missed the mmap write race condition that
>>>> happens during the writeback submitting I/O. Thank you a lot for pointing
>>>> this out. I thought of two possible solutions:
>>>>
>>>> 1. We also add explicit writeback operations to the truncate-up and
>>>>    post-EOF append writes. This solution is the most straightforward but
>>>>    may cause some performance overhead. However, since at most only one
>>>>    block is written, the impact is likely limited. Additionally, I
>>>>    observed that the implementation of the XFS file system also adopts a
>>>>    similar approach in its truncate up and down operation. (But it is
>>>>    somewhat strange that XFS also appears to have the same issue with
>>>>    post-EOF append writes; it only zero out the partial block in
>>>>    xfs_file_write_checks(), but it neither explicitly writeback zeroed
>>>>    data nor employs any other mechanism to ensure that the zero data
>>>>    writebacks before the metadata is written to disk.)
>>>>
>>>> 2. Resolve this race condition, ensure that there are no non-zero data
>>>>    in the post-EOF partial blocks on the disk. I observed that after the
>>>>    writeback holds the folio lock and calls folio_clear_dirty_for_io(),
>>>>    mmap writes will re-trigger the page fault. Perhaps we can filter out
>>>>    the EOF folio based on i_size in ext4_page_mkwrite(),
>>>>    block_page_mkwrite() and iomap_page_mkwrite(), and then call
>>>>    folio_wait_writeback() to wait for this partial folio writeback to
>>>>    complete. This seems can break the race condition without introducing
>>>>    too much overhead (no?).
>>>>
>>>> What do you think? Any other suggestions are also welcome.
>>> Hum, I like the option 2 because IMO non-zero data beyond EOF is a
>>> corner-case quirk which unnecessarily complicates rather common paths. But
>>> I'm not sure we can easily get rid of it. It can happen for example when
>>> you do appending write inside a block. The page is written back but before
>>> the transaction with i_disksize update commits we crash. Then again we have
>>> a non-zero content inside the block beyond EOF.
>>>
>>> So the only realistic option I see is to ensure tail of the block gets
>>> zeroed on disk before the transaction with i_disksize update commits in the
>>> cases of truncate up or write beyond EOF. data=ordered mode machinery is an
>>> asynchronous way how to achieve this. We could also just synchronously
>>> writeback the block where needed but the latency hit of such operation is
>>> going to be significant so I'm quite sure some workload somewhere will
>>> notice although the truncate up / write beyond EOF operations triggering this
>>> are not too common. So why do you need to get rid of these data=ordered
>>> mode usages? I guess because with iomap keeping our transaction handle ->
>>> folio lock ordering is complicated? Last time I looked it seemed still
>>> possible to keep it though.
>>>
>>> Another possibility would be to just *submit* the write synchronously and
>>> use data=ordered mode machinery only to wait for IO to complete before the
>>> transaction commits. That way it should be safe to start a transaction
>>> while holding folio lock and thus the iomap conversion would be easier.
>>>
>>> 								Honza
>> Can we treat EOF blocks as metadata and update them in the same
>> transaction as i_disksize? Although this would introduce some
>> management and journaling overhead, it could avoid the deadlock
>> of "writeback -> start handle -> trigger writeback".
> No, IMHO that would get too difficult. Just look at the hoops data=journal
> mode has to jump through to make page cache handling work with the
> journalling machinery. And you'd now have that for all the inodes. So I
> think some form of data=ordered machinery is much simpler to reason about.
>
> 								Honza

Indeed, this is a bit tricky.


Regards,
Baokun


