Return-Path: <linux-fsdevel+bounces-66366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7BC1D0F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C99F407BA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86433C52F;
	Wed, 29 Oct 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IaH0WiB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340363596EB;
	Wed, 29 Oct 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767425; cv=none; b=lq160BUIh/Od9M8cmFk+KFq0uwQn1lkmNawbLcue/W429MOX4TLm6uIHQcBWW4G3dhDQnu3u9vkfL/zpD5saAnLX4D1pLEb5T0McWsSkqjO58vkB8A/3kZtJk3hrXdf/lhUIwZngybpFqgfZu8+OWhWR+Y6PwYZ6PVsMD9O0+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767425; c=relaxed/simple;
	bh=x2OAfwS5H+/pyr4WR+Khtf97dsVmyBOZ4UxVwpJdZjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgwpfCKlA51ewHVnqTVmsk1UFWfsG1+Zk91lKZN7CTh5/nmU1sx2QpbB/suqQcYvXHopnniD4WVRQ/d4TLjE8jeJlvyk9xwlwY6zuFTNfqMs0QMA5a7N46+dRm47+xwpxNHlDggNjVJmi9iFOS3KCz8/97EQBD9Fe7rKI+G2WN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IaH0WiB+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ywMRa9td/qLYvz0QLFt/dHlJeUkQz4iWrYlNlCayuSE=; b=IaH0WiB+Bb8bae/n25tIQisGQE
	EwhH0nUvAY0WF68tV+bqAjeM5vt1+TFM+p9SWhDN7SSKHd71InQaX+spzoIsKsfRnYzLiPymBfv8b
	G0YUSVRmmHR72tbVjz7S1JCp1h94cR+krcxjkfnjWvoj0qzTCwutfhbayHRtPzVCrp4DBQP6QMP7E
	/5l7sL8Z4TbLmfGLBzrYSVUcbZopibwGw10l95Xv2hyvw2OljCjZDfVaA7JzI0kxcTG+eF758lStl
	ZwIQstpTPU88RRMUCb5P0e0hsxC1roRLf9JTHYYZ9gSRvYXs7n8ZIZ62F6HWHDjILexzwXgNL7cbg
	SLWmox1g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vECBX-00000002fGY-0vOJ;
	Wed, 29 Oct 2025 19:50:19 +0000
Message-ID: <6c273611-e815-4a4a-822d-f6e55cec3810@infradead.org>
Date: Wed, 29 Oct 2025 12:50:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Andrei Vagin <avagin@gmail.com>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/25 9:50 AM, Lorenzo Stoakes wrote:

> diff --git a/mm/memory.c b/mm/memory.c
> index 4c3a7e09a159..a2c79ee43d68 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  	if (src_vma->anon_vma)
>  		return true;
>  
> +	/* Guard regions have momdified page tables that require copying. */

	                      modified

> +	if (src_vma->vm_flags & VM_MAYBE_GUARD)
> +		return true;
> +
>  	/*
>  	 * Don't copy ptes where a page fault will fill them correctly.  Fork
>  	 * becomes much lighter when there are big shared or private readonly
-- 
~Randy


