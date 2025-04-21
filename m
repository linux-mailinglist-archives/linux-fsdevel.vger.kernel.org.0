Return-Path: <linux-fsdevel+bounces-46764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B35A94A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613B87A7E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D31EFFBB;
	Mon, 21 Apr 2025 01:35:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82C1EFF8E;
	Mon, 21 Apr 2025 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199327; cv=none; b=asnMn+ZoQbPFRYQa9bvICUtU1l7Au62aIXeuErCPjrBSYLFtWccy+2jWWSSsayVpq4PSkTETvGJaXtB+x2WkXDr3YDsuOC5/9MBy4TfMU4KvenheJHABdgQzyMUNMngUxAXdoe23tdMt9IHUCf/fx/DXeQyOWytpDNusnkktEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199327; c=relaxed/simple;
	bh=64NcBXuG1ACDiE1gxogo+R30+wlb9Vlge4RsPj6g6ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fN68T+KLbHD75Pqsqqx5x9jW3nCgolKCwlcaR12QvdhtM6A+tBrCq1Pbu1JyT5xFKpZs5PBnkCd80RgsG4UtbOokQUrM6mB0ZdCrxoF/443zS3AFRSQf5XvYJSkU+Y3fLDwh1n5jNDTLYmpkW0VvtBPxCrjKtbcSvlcC2JBlZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zgnv04p09z1R7XB;
	Mon, 21 Apr 2025 09:33:16 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 596A01400DD;
	Mon, 21 Apr 2025 09:35:15 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 09:35:14 +0800
Message-ID: <b5eca6ad-8974-4669-8ffa-0c6fd11fe06b@huawei.com>
Date: Mon, 21 Apr 2025 09:35:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] fs: Fix comment typos and grammatical errors
To: Jeff Layton <jlayton@kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <chuck.lever@oracle.com>,
	<alex.aring@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250419085554.1452319-1-lilingfeng3@huawei.com>
 <8c50079d7ca3dc0f47b913ebf82d6ab50605a044.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <8c50079d7ca3dc0f47b913ebf82d6ab50605a044.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/4/19 20:39, Jeff Layton 写道:
> On Sat, 2025-04-19 at 16:55 +0800, Li Lingfeng wrote:
>> This patch does minor comment cleanup:
>> - Fix spelling mistakes (e.g. "silibing" -> "sibling")
>> - Correct grammatical errors
>> No functional changes involved.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/locks.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 1619cddfa7a4..f06258216b31 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -12,7 +12,7 @@
>>    * If multiple threads attempt to lock the same byte (or flock the same file)
>>    * only one can be granted the lock, and other must wait their turn.
>>    * The first lock has been "applied" or "granted", the others are "waiting"
>> - * and are "blocked" by the "applied" lock..
>> + * and are "blocked" by the "applied" lock.
>>    *
>>    * Waiting and applied locks are all kept in trees whose properties are:
>>    *
>> @@ -43,7 +43,7 @@
>>    * waiting for the lock so it can continue handling as follows: if the
>>    * root of the tree applies, we do so (3).  If it doesn't, it must
>>    * conflict with some applied lock.  We remove (wake up) all of its children
>> - * (2), and add it is a new leaf to the tree rooted in the applied
>> + * (2), and add it as a new leaf to the tree rooted in the applied
>>    * lock (1).  We then repeat the process recursively with those
>>    * children.
>>    *
>> @@ -1327,7 +1327,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>   	 * replacing. If new lock(s) need to be inserted all modifications are
>>   	 * done below this, so it's safe yet to bail out.
>>   	 */
>> -	error = -ENOLCK; /* "no luck" */
>> +	error = -ENOLCK; /* "no lock" */
> FWIW, I think that the above is intended as a joke in English. "Lock"
> and "luck" sound similar, so this is telling you that you just got
> unlucky in this case and have no locking.
>
>>   	if (right && left == right && !new_fl2)
>>   		goto out;
>>   
>> @@ -2862,7 +2862,7 @@ static int locks_show(struct seq_file *f, void *v)
>>   		return 0;
>>   
>>   	/* View this crossed linked list as a binary tree, the first member of flc_blocked_requests
>> -	 * is the left child of current node, the next silibing in flc_blocked_member is the
>> +	 * is the left child of current node, the next sibling in flc_blocked_member is the
>>   	 * right child, we can alse get the parent of current node from flc_blocker, so this
>>   	 * question becomes traversal of a binary tree
>>   	 */
> Typically, we don't take cosmetic cleanup patches unless they are
> accompanied with substantive changes. If you're working in this area on
> real code changes and want to clean up a comment, then go for it, but
> otherwise this sort of change tends to make backporting more difficult
> later.
Hi Jeff,

Thank you for the feedback! I appreciate you taking the time to clarify
the policy around cosmetic changes. I wasn't fully aware of the
backporting implications, and I'll certainly keep this in mind for future
contributions. If I work on substantive changes in this area later, I'll
revisit the cleanup alongside those modifications.

Thanks again for the guidance!

Best regards,
Lingfeng

