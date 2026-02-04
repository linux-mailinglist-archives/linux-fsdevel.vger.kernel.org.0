Return-Path: <linux-fsdevel+bounces-76237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L8PKUiogmk2XgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 03:00:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F076FE0A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC9930BCF78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28B28A72F;
	Wed,  4 Feb 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="U0G2I0M8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E228C2A1;
	Wed,  4 Feb 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170384; cv=none; b=l+Jbo8BJuSL/inZ3BplwEj5004MZKaKNWthMclh+MAmoCaQsC6aXgX5sbby+l9AtsLh1EhyyxK3eny61Za400q82h3yxcSQ5pqXIp8J+0g/v3NhP6IToKZinc/9raPcRGwq753CjbFDAaqdLcKuwXeudFB9z10oO08nRIDn5NdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170384; c=relaxed/simple;
	bh=PsRyV2wWbyELN+IvFuWAWyniaMu8Vl2ne80qTcdw/Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sx2KpQSNvdQ6R7fsBE/78dhyA63RFrbIR3lvw27SpFVdeVscEgIbKNAUdpIsCRydR86G0yprzMK+FHUKmQHP6Mbu8csOg1eWLqKZNUEwNQjSBfZ6WH5KTeqI3EaKGnb+tY/PDas1X5FJsNyqpqZrDMuAmTAZylVwqnY1WPqCb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=U0G2I0M8; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lKo48oRS4RRB7kRuo8sWFwiwvBzAObPAQA8IEHQPwuk=;
	b=U0G2I0M8RfNcJ2GFIU4+OHtZNUbqyqqe36I5AW7YRoB5+0huYihdnUeED/QkJCN9CrrH/cmRj
	aEjAxzxv08PTq2mdYhiO5XlwGV9diThcQDdEIMgWVDR5zwi2Ibllh8Cq71GQ01pNv+i2GXKnx+I
	jFt75kJllQwRcUWiL1ckIXI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f5NjD3tJPzpStc;
	Wed,  4 Feb 2026 09:55:28 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id A38DF40569;
	Wed,  4 Feb 2026 09:59:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 09:59:37 +0800
Message-ID: <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
Date: Wed, 4 Feb 2026 09:59:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
To: Theodore Tso <tytso@mit.edu>, Zhang Yi <yi.zhang@huaweicloud.com>
CC: Christoph Hellwig <hch@infradead.org>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <ojaswin@linux.ibm.com>,
	<ritesh.list@gmail.com>, <djwong@kernel.org>, Zhang Yi <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>,
	<yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	<libaokun9@gmail.com>, Baokun Li <libaokun1@huawei.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260203131407.GA27241@macsyma.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
	TAGGED_FROM(0.00)[bounces-76237-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,dilger.ca,suse.cz,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F076FE0A6A
X-Rspamd-Action: no action

On 2026-02-03 21:14, Theodore Tso wrote:
> On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
>> This means that the ordered journal mode is no longer in ext4 used
>> under the iomap infrastructure.  The main reason is that iomap
>> processes each folio one by one during writeback. It first holds the
>> folio lock and then starts a transaction to create the block mapping.
>> If we still use the ordered mode, we need to perform writeback in
>> the logging process, which may require initiating a new transaction,
>> potentially leading to deadlock issues. In addition, ordered journal
>> mode indeed has many synchronization dependencies, which increase
>> the risk of deadlocks, and I believe this is one of the reasons why
>> ext4_do_writepages() is implemented in such a complicated manner.
>> Therefore, I think we need to give up using the ordered data mode.
>>
>> Currently, there are three scenarios where the ordered mode is used:
>> 1) append write,
>> 2) partial block truncate down, and
>> 3) online defragmentation.
>>
>> For append write, we can always allocate unwritten blocks to avoid
>> using the ordered journal mode.
> This is going to be a pretty severe performance regression, since it
> means that we will be doubling the journal load for append writes.
> What we really need to do here is to first write out the data blocks,
> and then only start the transaction handle to modify the data blocks
> *after* the data blocks have been written (to heretofore, unused
> blocks that were just allocated).  It means inverting the order in
> which we write data blocks for the append write case, and in fact it
> will improve fsync() performance since we won't be gating writing the
> commit block on the date blocks getting written out in the append
> write case.

I have some local demo patches doing something similar, and I think this
work could be decoupled from Yi's patch set.

Since inode preallocation (PA) maintains physical block occupancy with a
logical-to-physical mapping, and ensures on-disk data consistency after
power failure, it is an excellent location for recording temporary
occupancy. Furthermore, since inode PA often allocates more blocks than
requested, it can also help reduce file fragmentation.

The specific approach is as follows:

1. Allocate only the PA during block allocation without inserting it into
   the extent status tree. Return the PA to the caller and increment its
   refcount to prevent it from being discarded.

2. Issue IOs to the blocks within the inode PA. If IO fails, release the
   refcount and return -EIO. If successful, proceed to the next step.

3. Start a handle upon successful IO completion to convert the inode PA to
   extents. Release the refcount and update the extent tree.

4. If a corresponding extent already exists, we’ll need to punch holes to
   release the old extent before inserting the new one.

This ensures data atomicity, while jbd2—being a COW-like implementation
itself—ensures metadata atomicity. By leveraging this "delay map"
mechanism, we can achieve several benefits:

 * Lightweight, high-performance COW.
 * High-performance software atomic writes (hardware-independent).
 * Replacing dio_readnolock, which might otherwise read unexpected zeros.
 * Replacing ordered data and data journal modes.
 * Reduced handle hold time, as it's only held during extent tree updates.
 * Paving the way for snapshot support.

Of course, COW itself can lead to severe file fragmentation, especially
in small-scale overwrite scenarios.

Perhaps I’ve overlooked something. What are your thoughts?


Regards,
Baokun


