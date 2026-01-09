Return-Path: <linux-fsdevel+bounces-72978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9AD06DE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9403D3011477
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9CA318149;
	Fri,  9 Jan 2026 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="niFsaSMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3322301;
	Fri,  9 Jan 2026 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926342; cv=none; b=c6Uf/VH9EYw3Pjrcs/eTYoqsrWkpOwHcxVaRtLW7xJftFAbT6n3+t2uDrKLZejifBoMYFki8QruUiGLqyyMzl12yP7JpBJ57BTK22DoEFIgY9v0ejqfRv3CSO0r6MEv+9CrA45JltCEpbAXOG9h7j+7wDK3JADRWhGiMa/bDzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926342; c=relaxed/simple;
	bh=04fGF1+ghZ6RvkVd/ESe315VeZjZo+rMloGVOsdXvUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HweExbFCJfG4jVpvRSR+tV+uDWTcxOyCxD3vOAaUlbmgjsJtYki8dJfOpXn8eowRc9hNs0aJJgGniZ+YpVmSz8bhbtOoThTRzRPNJBbJwRAk0PjJkpzoGVp/HnY90VMML7GmapacNhhzGHOEBpv2L4fhMN0Yx2k0CSUyhn59BrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=niFsaSMf; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v45CaW74gtQbABT87KH/GpFA7JPcXe3bMuQi3Z8F9+4=;
	b=niFsaSMfPHZrrWm/z2+l+e1Af6eprepq6NfTKboYQnPFm7S0oP1ViMCJVzIsplIcb8hoI6ICO
	iyeTB+f5SMDRjs6+lXLKUCAuppyYtNisUe6ZTsMMzws4f7B7PaMONtZbDK64HKVjm2bBcijvdUR
	JnhJO/uebHJFRlAIBgGKMsk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dnQqc61qkzRj1J;
	Fri,  9 Jan 2026 10:35:40 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A5DE40538;
	Fri,  9 Jan 2026 10:38:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 10:38:56 +0800
Message-ID: <e9a0aa3e-c4a6-40b3-a35a-aa017f94126e@huawei.com>
Date: Fri, 9 Jan 2026 10:38:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ext4: fix e4b bitmap inconsistency reports
Content-Language: en-GB
To: <sunyongjian1@huawei.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.cz>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <chengzhihao1@huawei.com>
References: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-06 17:08, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
>
> A bitmap inconsistency issue was observed during stress tests under
> mixed huge-page workloads. Ext4 reported multiple e4b bitmap check
> failures like:
>
> ext4_mb_complex_scan_group:2508: group 350, 8179 free clusters as
> per group info. But got 8192 blocks
>
> Analysis and experimentation confirmed that the issue is caused by a
> race condition between page migration and bitmap modification. Although
> this timing window is extremely narrow, it is still hit in practice:
>
> folio_lock                        ext4_mb_load_buddy
> __migrate_folio
>   check ref count
>   folio_mc_copy                     __filemap_get_folio
>                                       folio_try_get(folio)
>                                   ......
>                                   mb_mark_used
>                                   ext4_mb_unload_buddy
>   __folio_migrate_mapping
>     folio_ref_freeze
> folio_unlock
>
> The root cause of this issue is that the fast path of load_buddy only
> increments the folio's reference count, which is insufficient to prevent
> concurrent folio migration. We observed that the folio migration process
> acquires the folio lock. Therefore, we can determine whether to take the
> fast path in load_buddy by checking the lock status. If the folio is
> locked, we opt for the slow path (which acquires the lock) to close this
> concurrency window.
>
> Additionally, this change addresses the following issues:
>
> When the DOUBLE_CHECK macro is enabled to inspect bitmap-related
> issues, the following error may be triggered:
>
> corruption in group 324 at byte 784(6272): f in copy != ff on
> disk/prealloc
>
> Analysis reveals that this is a false positive. There is a specific race
> window where the bitmap and the group descriptor become momentarily
> inconsistent, leading to this error report:
>
> ext4_mb_load_buddy                   ext4_mb_load_buddy
>   __filemap_get_folio(create|lock)
>     folio_lock
>   ext4_mb_init_cache
>     folio_mark_uptodate
>                                      __filemap_get_folio(no lock)
>                                      ......
>                                      mb_mark_used
>                                        mb_mark_used_double
>   mb_cmp_bitmaps
>                                        mb_set_bits(e4b->bd_bitmap)
>   folio_unlock
>
> The original logic assumed that since mb_cmp_bitmaps is called when the
> bitmap is newly loaded from disk, the folio lock would be sufficient to
> prevent concurrent access. However, this overlooks a specific race
> condition: if another process attempts to load buddy and finds the folio
> is already in an uptodate state, it will immediately begin using it without
> holding folio lock.
>
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/mballoc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..de4cacb740b3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1706,16 +1706,17 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* Avoid locking the folio in the fast path ... */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
> +		/*
> +		 * folio_test_locked is employed to detect ongoing folio
> +		 * migrations, since concurrent migrations can lead to
> +		 * bitmap inconsistency. And if we are not uptodate that
> +		 * implies somebody just created the folio but is yet to
> +		 * initialize it. We can drop the folio reference and
> +		 * try to get the folio with lock in both cases to avoid
> +		 * concurrency.
> +		 */
>  		if (!IS_ERR(folio))
> -			/*
> -			 * drop the folio reference and try
> -			 * to get the folio with lock. If we
> -			 * are not uptodate that implies
> -			 * somebody just created the folio but
> -			 * is yet to initialize it. So
> -			 * wait for it to initialize.
> -			 */
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,
>  				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> @@ -1764,7 +1765,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* we need another folio for the buddy */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
>  		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,



