Return-Path: <linux-fsdevel+bounces-3872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F27F977A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 03:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4A3B20A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6201379;
	Mon, 27 Nov 2023 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lnMulVAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758A110
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 18:24:02 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701051839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03AItCkX6f50QX8qGn4DUIQ3gtnorhO0EzC7fFvxu9o=;
	b=lnMulVAX7aD60/QM35jBh7ZD89gHMGRie9iLFBXGgAYwkXlhTa2WU+wgrbbnBBWmlSoeY2
	M/GqI0Bi/DBMzVVS5np01XjGifqrhUffNOFUmQc3C8NygbgPOqM/FUoHRlVM+plt73/yi3
	opuAaP465b96xqDi8wzVUPkouPQIFpw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] fs/Kconfig: Make hugetlbfs a menuconfig
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231124151902.1075697-1-peterx@redhat.com>
Date: Mon, 27 Nov 2023 10:23:15 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Muchun Song <songmuchun@bytedance.com>,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F55FA767-9951-4CBB-B4C2-DFD37B33EF91@linux.dev>
References: <20231124151902.1075697-1-peterx@redhat.com>
To: Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Nov 24, 2023, at 23:19, Peter Xu <peterx@redhat.com> wrote:
> 
> Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
> is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
> itself, under "Pesudo filesystems".
> 
> Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
> into a menuconfig.  When moving it, fix a typo 'v' spot by Randy.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


