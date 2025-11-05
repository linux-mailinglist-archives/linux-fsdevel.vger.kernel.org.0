Return-Path: <linux-fsdevel+bounces-67085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21076C34EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 395334FC59C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19C308F0F;
	Wed,  5 Nov 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xl4yr03g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F4302CCA;
	Wed,  5 Nov 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335877; cv=none; b=vCwuu3nxCTH6hnsq+QQtYbQkYY/xGsdz39LovbfDkkFJqE2kwGcST4jgB5KP/8DwWKcnGetuefkXH4xdP7AlHgVwKF+l9PuWchE/gzE405ZuMzy3N3GyqgMMPjKv7fBjylAeiRwt24HiM9BdH0ixMz79n4V9icjUoiHD/gRFpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335877; c=relaxed/simple;
	bh=h+qwVUZjthoiqyJjkeXnangp0W/CiVcIiWMmF/sC3DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=En7i3tWpX1QiKN5oEsW+yE8yPt5SgKi1D4GKfxvXr7QTpXqEIiXHj1/3BwQcjgvRMmLkxpqvj1kRKAbC50E3N4LnaOBnHeRkZXoD73VPFlB/9qyfgVMI3EEeMsunt33B8G1tkEWNKgSPL0j6WHeWLERCyoTXX7JXIdxbB+++7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xl4yr03g; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ULBjQjfTQ2PhD78f/wqD4u2pFSqPbYJY7fZ9PMrAk2g=;
	b=Xl4yr03g/f6ZMnj5GicYAb2bjUPpNqrsDwGaUvWjzZYt3z8PRrBWnK0IkFrfkeg8NaXIfqMw0
	2a5b3MBSA+BOdYGDHZvzQaLEFUUqjI+TLkwAnXhnAfK3K8mGxH0qimjxp0gfk6NGvDEac1aFfvf
	6apkBZlSE41pxIdeWt789mg=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d1gNd4sY5zLlSM;
	Wed,  5 Nov 2025 17:42:57 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 91B751402C3;
	Wed,  5 Nov 2025 17:44:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 17:44:31 +0800
Message-ID: <5280bbc0-be8b-4e46-8410-28719cb79ef0@huawei.com>
Date: Wed, 5 Nov 2025 17:44:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/25] ext4: support large block size in
 ext4_mb_get_buddy_page_lock()
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-13-libaokun@huaweicloud.com>
 <5kbyz6ilhj7zde4dtv7fhy33yks3bhs2g6xesdzwptdenrrfdg@ydurgdouhuwn>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <5kbyz6ilhj7zde4dtv7fhy33yks3bhs2g6xesdzwptdenrrfdg@ydurgdouhuwn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-05 17:13, Jan Kara wrote:
> On Sat 25-10-25 11:22:08, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Currently, ext4_mb_get_buddy_page_lock() uses blocks_per_page to calculate
>> folio index and offset. However, when blocksize is larger than PAGE_SIZE,
>> blocks_per_page becomes zero, leading to a potential division-by-zero bug.
>>
>> To support BS > PS, use bytes to compute folio index and offset within
>> folio to get rid of blocks_per_page.
>>
>> Also, since ext4_mb_get_buddy_page_lock() already fully supports folio,
>> rename it to ext4_mb_get_buddy_folio_lock().
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Looks good, just two typo fixes below. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 3494c6fe5bfb..d42d768a705a 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1510,50 +1510,52 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>>  }
>>  
> Let's fix some typos when updating the comment:

I’ll fix these typos in the next update.

Thank you for your review!


Regards,
Baokun

>
>>  /*
>> - * Lock the buddy and bitmap pages. This make sure other parallel init_group
>> - * on the same buddy page doesn't happen whild holding the buddy page lock.
>> - * Return locked buddy and bitmap pages on e4b struct. If buddy and bitmap
>> - * are on the same page e4b->bd_buddy_folio is NULL and return value is 0.
>> + * Lock the buddy and bitmap folios. This make sure other parallel init_group
> 					     ^^^ makes
>
>> + * on the same buddy folio doesn't happen whild holding the buddy folio lock.
> 					     ^^ while
>
>> + * Return locked buddy and bitmap folios on e4b struct. If buddy and bitmap
>> + * are on the same folio e4b->bd_buddy_folio is NULL and return value is 0.
>>   */
> 								Honza



