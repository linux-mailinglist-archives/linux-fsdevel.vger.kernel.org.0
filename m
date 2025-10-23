Return-Path: <linux-fsdevel+bounces-65298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66009C00A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00BA54F67C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E60303A3D;
	Thu, 23 Oct 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="nmWmhWK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5774307481;
	Thu, 23 Oct 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217839; cv=none; b=VQ3jIQREVNXqfcycDvOQzQag/ag8nkiVbuqFNmlNqa3YAWY0DHqln8Tt3TqAiPz1u4OrnQS5gdodFVKtuQ31VfPsiA2q3f5VzgN2jvyBjB/Ud6EcrP7xb4ZadH5kduPItR0rkAx6ff4YKQi3Fw3esuVu16zAi29CP1Cl1VlR1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217839; c=relaxed/simple;
	bh=o0c6exPywiZ6/nb9TIRG/xQseSArQ2GZ1/x3VYQDxSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJphTSm6tJhp11lrw15FZX+++2JvmwGNGxW0LMc6MX18ogKeGMO9SB1FdZMF0kBFnwhGT6doVpaUbZtOviHlhyeS+ffFi8vLfeRptb7sgB9m1M4lTQSBUBLVxsDwhn1l/o4P6A+ahtI++cvKiXzNhaAtNvUVGcrFFAKzZu3Hbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=nmWmhWK2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4csjxb4yYzz9tPF;
	Thu, 23 Oct 2025 13:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1761217827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYodpbyQD8BgZF0WGadbX6rC3JbxgU0ZmWtjqSGv5Aw=;
	b=nmWmhWK2I7Z6FVqbm3fmwSHWLaFv7Q1u8sKzHlojkBMqYpkvX0RIn6dB5ditpNeSnS3ZoM
	JezUagEeVhbKHlsh5wcSq/3Wm+4XTcjnyG7BsrSYPKmWe2nEqTY8AbYFrgVB1pni+zuZuR
	hVq26wI2hDJ2rtRurszzfgCxbJsWoFVOyzWorIyxf8RX3TKshZm4NmmHzKbMvirhWJlQ8X
	IzwL1nXSJCYMHuqm1Iyw7NSgYQAKU7cZtGs3AeiN/x/E5N6xSVyhH9zsKXrZiVGqI3ghuO
	0Z0VKsUxWS9qnzV2sieVZt5w/ZwcgKG6cjkVmwnvjePhq4IQpi9Ua3Rtr7rY0A==
Message-ID: <d0362c9d-67f9-4ea5-a5c1-792f960da70b@pankajraghav.com>
Date: Thu, 23 Oct 2025 13:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, david@redhat.com,
 jane.chu@oracle.com
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20251023030521.473097-1-ziy@nvidia.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251023030521.473097-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/23/25 05:05, Zi Yan wrote:
> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> after-split folios containing pages with PG_hwpoisoned flag if the folio is
> split to >0 order folios. Scan all pages in a to-be-split folio to
> determine which after-split folios need the flag.
> 
> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> avoid the scan and set it on all after-split folios, but resulting false
> positive has undesirable negative impact. To remove false positive, caller
> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
> do the scan. That might be causing a hassle for current and future callers
> and more costly than doing the scan in the split code. More details are
> discussed in [1].
> 
> This issue can be exposed via:
> 1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;

Is it easy to add a selftest in split_huge_page_test for this scenario?

> 2. truncating part of a has_hwpoisoned folio in
>    truncate_inode_partial_folio().
> 
--
Pankaj

