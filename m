Return-Path: <linux-fsdevel+bounces-71282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4BCBC573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED7E300C29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136929D297;
	Mon, 15 Dec 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QrXdkt8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153F28EA56;
	Mon, 15 Dec 2025 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770153; cv=none; b=BYXbdt9DDx7Ht4QUWqRyDfv25B0zUAVgnq5Fg7vLtbeROBtNGMAdqy6JBuGh7342wAe2/MgJcn9Vb2hWtw9lazeElHet4L8p4mRlP2Q5B9oDH143F1s3WfyGHfPTER6o716yRzebvXOaEj4jCoe/d3115bbqGR6SfftPRn/leMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770153; c=relaxed/simple;
	bh=5qgXJr5KAX0ZZRphUl/JuF35O9sLdWYMS5Ca1018yu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=te3yk1BnKVQV51gPhwJSpHR9KI8r+E+SlXZEfo8Ez2vMgL23OsV0MB0vlzPFlVaTUxeMw5FuxGtLehOxPDi45ELvw38jWx+w/JNmVILQXmWNBfyZauR01qwVZTYBMZtMaovCWYc07+VfNL04QqomV4ULjFPQ3cC0hKZa7TcpOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QrXdkt8w; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3QQAN60cdddSSldQIQPQz11+trQiMjxdlqc/hEj6Yfg=;
	b=QrXdkt8w6pPuZ4/WwMhbvSZeCFVKo9LVhCa2tyfo7V8P0FMcddJEzgoZTB9N+1AkB8MNlO7pK
	X7r80BpTvMe+3Hik4kEoXY8nYlLLICTDVqOHap0jk3zRXS/ReMuZhgU6CLyo0f1r/wcR+3gT1IZ
	Zmt2E3J7YkwMN+k18SZOi7o=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dV5Rm5hggz1prPH;
	Mon, 15 Dec 2025 11:40:20 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 72E58180478;
	Mon, 15 Dec 2025 11:42:21 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 11:42:20 +0800
Message-ID: <164b53af-f4b2-49bf-ac4c-c7b10c080159@huawei.com>
Date: Mon, 15 Dec 2025 11:42:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
From: Jinjiang Tu <tujinjiang@huawei.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dev.jain@arm.com>, <david@kernel.org>, <shardulsb08@gmail.com>,
	<janak@mpiricsoftware.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
 <89b96a9f-1d03-440a-93cd-2b9876be3122@huawei.com>
In-Reply-To: <89b96a9f-1d03-440a-93cd-2b9876be3122@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2025/12/15 10:19, Jinjiang Tu 写道:
>
>
> 在 2025/12/4 22:26, Shardul Bankar 写道:
>> xas_create_range() is typically called in a retry loop that uses
>> xas_nomem() to handle -ENOMEM errors. xas_nomem() may allocate a spare
>> xa_node and store it in xas->xa_alloc for use in the retry.
>>
>> If the lock is dropped after xas_nomem(), another thread can expand the
>> xarray tree in the meantime. On the next retry, xas_create_range() can
>> then succeed without consuming the spare node stored in xas->xa_alloc.
>> If the function returns without freeing this spare node, it leaks.
>>
>> xas_create_range() calls xas_create() multiple times in a loop for
>> different index ranges. A spare node that isn't needed for one range
>> iteration might be needed for the next, so we cannot free it after each
>> xas_create() call. We can only safely free it after xas_create_range()
>> completes.
>>
>> Fix this by calling xas_destroy() at the end of xas_create_range() to
>> free any unused spare node. This makes the API safer by default and
>> prevents callers from needing to remember cleanup.
>>
>> This fixes a memory leak in mm/khugepaged.c and potentially other
>> callers that use xas_nomem() with xas_create_range().
> I encountered another memory leak issue in xas_create_range().
>
> collapse_file() calls xas_create_range() to pre-create all slots needed.
> If collapse_file() finally fails, these pre-created slots are empty nodes.
> When the file is deleted, shmem_evict_inode()->shmem_truncate_range()->shmem_undo_range()
> calls xas_store(&xas, NULL) for each entries to delete nodes, but leaving those pre-created
> empty nodes leaked.
>
> I can reproduce it with following steps.
> 1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, and then mmap the file
> 2) memset for the first 2MB
> 3) madvise(MADV_COLLAPSE) for the second 2MB.
> 4) unlink the file
>
> in 3), collapse_file() calls xas_create_range() to expand xarray depth, and fails to collapse
> due to the whole 2M region is empty, leading to the new created empty nodes leaked.
>
> To fix it, maybe we should add a new function xas_delete_range() to revert what xas_create_range()
> does when xas_create_range() runs into rollback path?

How about the following diff? I tried it, and the memory leak disappears. I'm new in xarray, so
I don't if this fix works properly.

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..972df5ceeb84 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,7 @@ void xas_destroy(struct xa_state *);
  void xas_pause(struct xa_state *);
  
  void xas_create_range(struct xa_state *);
+void xas_destroy_range(struct xa_state *xas, unsigned long start, unsigned long end);
  
  #ifdef CONFIG_XARRAY_MULTI
  int xa_get_order(struct xarray *, unsigned long index);
diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540c..ab15dc939962 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -752,6 +752,21 @@ void xas_create_range(struct xa_state *xas)
  }
  EXPORT_SYMBOL_GPL(xas_create_range);
  
+void xas_destroy_range(struct xa_state *xas, unsigned long start, unsigned long end)
+{
+    unsigned long index;
+    void *entry;
+
+    for (index = start; index < end; ++index) {
+        xas_set(xas, index);
+        entry = xas_load(xas);
+        if (entry)
+            continue;
+        else if (xas->xa_node && !xas->xa_node->count)
+            xas_delete_node(xas);
+    }
+}
+
  static void update_node(struct xa_state *xas, struct xa_node *node,
          int count, int values)
  {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..dd9d3f202c4b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2247,7 +2247,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
      goto out;
  
  rollback:
-    /* Something went wrong: roll back page cache changes */
+    /* Something went wrong: roll back empty xa_node created by
+     * xas_create_range() and page cache changes
+     */
+    xas_destroy_range(&xas, start, end);
+
      if (nr_none) {
          xas_lock_irq(&xas);
          mapping->nrpages -= nr_none;

>> Link:https://syzkaller.appspot.com/bug?id=a274d65fc733448ed518ad15481ed575669dd98c
>> Link:https://lore.kernel.org/all/20251201074540.3576327-1-shardul.b@mpiricsoftware.com/ ("v3")
>> Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
>> Signed-off-by: Shardul Bankar<shardul.b@mpiricsoftware.com>
>> ---
>>   v4:
>>   - Drop redundant `if (xa_alloc)` around xas_destroy(), as xas_destroy()
>>     already checks xa_alloc internally.
>>   v3:
>>   - Move fix from collapse_file() to xas_create_range() as suggested by Matthew Wilcox
>>   - Fix in library function makes API safer by default, preventing callers from needing
>>     to remember cleanup
>>   - Use shared cleanup label that both restore: and success: paths jump to
>>   - Clean up unused spare node on both success and error exit paths
>>   v2:
>>   - Call xas_destroy() on both success and failure
>>   - Explained retry semantics and xa_alloc / concurrency risk
>>   - Dropped cleanup_empty_nodes from previous proposal
>>
>>   lib/xarray.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 9a8b4916540c..f49ccfa5f57d 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -744,11 +744,16 @@ void xas_create_range(struct xa_state *xas)
>>   	xas->xa_shift = shift;
>>   	xas->xa_sibs = sibs;
>>   	xas->xa_index = index;
>> -	return;
>> +	goto cleanup;
>> +
>>   success:
>>   	xas->xa_index = index;
>>   	if (xas->xa_node)
>>   		xas_set_offset(xas);
>> +
>> +cleanup:
>> +	/* Free any unused spare node from xas_nomem() */
>> +	xas_destroy(xas);
>>   }
>>   EXPORT_SYMBOL_GPL(xas_create_range);
>>   

