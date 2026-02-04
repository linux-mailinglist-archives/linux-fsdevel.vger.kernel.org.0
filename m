Return-Path: <linux-fsdevel+bounces-76236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHkNKf+hgmlpXAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 02:33:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24417E0750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 02:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3CFE30B963B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871F27702D;
	Wed,  4 Feb 2026 01:33:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EE256C6D;
	Wed,  4 Feb 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168820; cv=none; b=Nc8RKJnHqskU611u1IPCbul7vF4NLC9qWfpJDMc0JHS1P4uk4LlykF5lqDQP50/Z0P5eDdQFioVaBkyZOkTilI+sG6ziy2hFOFZ8CKEwp4AS2n3suD7RrYda7C60rZWGfQrGXELb1ZdUqeKOwkhml5priKWd0T8XGpIThGsNXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168820; c=relaxed/simple;
	bh=POlzIyQZ8kgR4oDmj1fN0UGS1V8WDk0nGfpKufZlAGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F340Vm8IADLNkhNJ7jAB7A3Sm2a0UCCq7WVOW+b1K09coBGeQcP05IzowqIyvLBm0kRxwxdDYqckQQJ60DQlhRWeik61MiZs+WtcvHjYKmHnzeoUUv4l56XvIEcO+D2JIzjn/tneg+w35qjNbNe9cyDcOpq3/GiBG3d0P73umHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f5NBv3yndzYQtvW;
	Wed,  4 Feb 2026 09:32:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEE9240575;
	Wed,  4 Feb 2026 09:33:27 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgCX+PjaoYJp4HW6GA--.44560S3;
	Wed, 04 Feb 2026 09:33:16 +0800 (CST)
Message-ID: <7b8eb418-f741-46eb-b2ff-7d27ec1d2b4b@huaweicloud.com>
Date: Wed, 4 Feb 2026 09:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
 ritesh.list@gmail.com, djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260203131407.GA27241@macsyma.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCX+PjaoYJp4HW6GA--.44560S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrykXryruFW8Jr1UCw13XFb_yoW5XF1kpa
	yUKrn5tr4kX34UZ3Z7Zay8JF409w1rJry3Jryjgwn2k398JF1IyFZ2qrWjqa429r1Ig3Wj
	qr4YvFy7uFn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76236-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,dilger.ca,suse.cz,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 24417E0750
X-Rspamd-Action: no action

Hi, Ted.

On 2/3/2026 9:14 PM, Theodore Tso wrote:
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
> 
> This is going to be a pretty severe performance regression, since it
> means that we will be doubling the journal load for append writes.

Although this will double the journal load compared to directly
allocating written blocks, I think it will not result in significant
performance regression compared to the current append write process, as
this is consistent with the behavior after dioread_nolock is enabled by
default now.

> What we really need to do here is to first write out the data blocks,
> and then only start the transaction handle to modify the data blocks
> *after* the data blocks have been written (to heretofore, unused
> blocks that were just allocated).  It means inverting the order in
> which we write data blocks for the append write case, and in fact it
> will improve fsync() performance since we won't be gating writing the
> commit block on the date blocks getting written out in the append
> write case.
> 

Yeah, thank you for the suggestion. I agree with you. We are planning to
implement this next. Baokun is currently working to develop a POC. Our
current idea is to use inode PA (The benefit of using PA is that it can
avoid changes to disk metadata, and the pre-allocation operation can be
closed within the mb-allocater) to pre-allocate blocks before doing
writeback, and then map the actual written type extents after the data is
written, which would avoid this journal overhead of unwritten
allocations. At the same time, this could also lay the foundation for
future support of COW writes for reflinks.

> Cheers,
> 
> 					- Ted

Thanks,
Yi.




