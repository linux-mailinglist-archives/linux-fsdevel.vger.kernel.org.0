Return-Path: <linux-fsdevel+bounces-71659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17FCCBAB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7CC7300288A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D83254BB;
	Thu, 18 Dec 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LBe6fnZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E44320A1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058356; cv=none; b=Vt+Wy5V2oM6obGo4kEzsT0j37OKJtv3kZB2lrDs7+IZPOecSbfP9tuFKtIJLh3pIp6OznEwM0r6zDcnOwcCqFrW7j4UdlKTFTZOOq9Ma7xxaCdzuhINDJ3in408zYqj0AsNS1VmYOM7WVUpNEmilGoLbi9KdLcFWsN+1M/MI9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058356; c=relaxed/simple;
	bh=DXjTrVKoz19d67GpqOT6nYFq9G9ZE/5Pisi4kCVofNg=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=rNxpHmxMJ68ennay038uOK/L7D/OX8Hhq4b+oRxGVmyFAYpD9WPN6wQblIcAuT20U0VVRpRPecfx0KPaF6aLKaJUmeyNk+Ko6cGhEcDK2+Bl/skkpaktMWpDCVXYu9dQwKZlSAFmOLgUZNM//todv0XZOP+jRWGTTa4DXTWqW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LBe6fnZv; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CpAStHn7JZSnDr8vJLXdNCUTlpmuEqTzxHxKyFF1tCo=;
	b=LBe6fnZvbVt0X3DqGRT4dUeMi5GPkdtPtZLX8TvdUonQrPNnZgIISDWKF/NzJ/G+vu10JhM5w
	7urW6XcnuX5fKJYeTa51kCfrJkjg/cT0KyDMuQUn5sttONECh18wF8pIaEAuXIGf9A2PZn6f+rt
	Hmt8uwzFhRlNrk2/n1keAd4=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dX8125TyNzRhRm;
	Thu, 18 Dec 2025 19:42:46 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E39D14027D;
	Thu, 18 Dec 2025 19:45:50 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 19:45:49 +0800
Message-ID: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
Date: Thu, 18 Dec 2025 19:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jinjiang Tu <tujinjiang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <baolin.wang@linux.alibaba.com>,
	<Liam.Howlett@oracle.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: [bug report] memory leak of xa_node in collapse_file() when rollbacks
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, <tujinjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)

I encountered a memory leak issue caused by xas_create_range().

collapse_file() calls xas_create_range() to pre-create all slots needed.
If collapse_file() finally fails, these pre-created slots are empty nodes
and aren't destroyed.

I can reproduce it with following steps.
1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, and then mmap the file
2) memset for the first 2MB
3) madvise(MADV_COLLAPSE) for the second 2MB
4) unlink the file

in 3), collapse_file() calls xas_create_range() to expand xarray depth, and fails to collapse
due to the whole 2M region is empty, the code is as following:

collapse_file()
	for (index = start; index < end;) {
		xas_set(&xas, index);
		folio = xas_load(&xas);

		VM_BUG_ON(index != xas.xa_index);
		if (is_shmem) {
			if (!folio) {
				/*
				 * Stop if extent has been truncated or
				 * hole-punched, and is now completely
				 * empty.
				 */
				if (index == start) {
					if (!xas_next_entry(&xas, end - 1)) {
						result = SCAN_TRUNCATED;
						goto xa_locked;
					}
				}
				...
			}


collapse_file() rollback path doesn't destroy the pre-created empty nodes.

When the file is deleted, shmem_evict_inode()->shmem_truncate_range() traverses
all entries and calls xas_store(xas, NULL) to delete, if the leaf xa_node that
stores deleted entry becomes emtry, xas_store() will automatically delete the empty
node and delete it's  parent is empty too, until parent node isn't empty. shmem_evict_inode()
won't traverse the empty nodes created by xas_create_range() due to these nodes doesn't store
any entries. As a result, these empty nodes are leaked.

At first, I tried to destory the empty nodes when collapse_file() goes to rollback path. However,
collapse_file() only holds xarray lock and may release the lock, so we couldn't prevent concurrent
call of collapse_file(), so the deleted empty nodes may be needed by other collapse_file() calls.

IIUC, xas_create_range() is used to guarantee the xas_store(&xas, new_folio); succeeds. Could we
remove xas_create_range() call and just rollback when we fail to xas_store?



