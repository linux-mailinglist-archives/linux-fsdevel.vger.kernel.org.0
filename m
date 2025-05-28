Return-Path: <linux-fsdevel+bounces-49980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E680AC6CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09F24A789C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC028C2BD;
	Wed, 28 May 2025 15:38:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C92882DE;
	Wed, 28 May 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446730; cv=none; b=XliDntFfVVFcLEc4Yyxk2Czmgndc8V3Yh23ieQ5jwcm7w22j39heKd7d2oZwMP/Rx/J1TN/mQV/Hje5CaiIE0BJwINl2qnKyZTgAgUrnrIo414o2hOcrkaMvaW0IX3EG/D1qCRqpbe6RHZUZsyLkeFJjnx9CxVvmOHLqtrj6Ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446730; c=relaxed/simple;
	bh=E0udk8x6hmQLluBrqj/L2WShsMerQkW5sI1ubHcdhyc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=cj3lYSUT+7Ptw9331QILH/Qa+tifFRvp6nwDKTy4DxIEpfehPuOKV+7ZlnP2FQH82+m7X0pPKxRD1e/42aJOayGqRkqP2ctWD2ZZJWI5MQV1efIfw9mUA5ZMxFj+Us1dqNHo+hkji1v9dHDOKnfmaMX0M0dCZy5/ZjiCsfLby20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b6tvF3M8Lz4x6Cq;
	Wed, 28 May 2025 23:38:33 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 54SFcS4N089038;
	Wed, 28 May 2025 23:38:28 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 28 May 2025 23:38:32 +0800 (CST)
Date: Wed, 28 May 2025 23:38:32 +0800 (CST)
X-Zmail-TransId: 2afc68372df8ffffffffcb3-045c5
X-Mailer: Zmail v1.0
Message-ID: <20250528233832445zSfRddcejioi-qwhWuUBJ@zte.com.cn>
In-Reply-To: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
References: cover.1747844463.git.lorenzo.stoakes@oracle.com,6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <lorenzo.stoakes@oracle.com>
Cc: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <jack@suse.cz>, <Liam.Howlett@oracle.com>,
        <vbabka@suse.cz>, <jannh@google.com>, <pfalcato@suse.de>,
        <david@redhat.com>, <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>, <wang.yaxin@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzRdIG1tOiBwcmV2ZW50IEtTTSBmcm9tIGNvbXBsZXRlbHkgYnJlYWtpbmcgVk1BIG1lcmdpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54SFcS4N089038
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68372DF9.001/4b6tvF3M8Lz4x6Cq

> +static void update_ksm_flags(struct mmap_state *map)
> +{
> +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> +}
> +
> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + *
> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> + *
> + * If this is not the case, then we set the flag after considering mergeability,
> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> + * preventing any merge.
> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/* shmem is safe. */

Excuse me, why it's safe here? Does KSM support shmem?

> +	if (shmem_file(file))
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags.
> +	 */

Recommend expanding the comments here with slightly more verbose explanations to improve
code comprehension. Consider adding the following note (even though your commit log is
already sufficiently clear.   :)
/*
* If .mmap_prepare() is specified, then the driver will have already
* manipulated state prior to updating KSM flags. So no need to worry
* about mmap callbacks modifying vm_flags after the KSM flag has been
* updated here, which could otherwise affect KSM eligibility.
*/


> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	return false;
> +}
> +

