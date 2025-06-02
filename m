Return-Path: <linux-fsdevel+bounces-50365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B7ACB5B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C060A19425A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFE23536A;
	Mon,  2 Jun 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="cyowkGU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E8227EBB;
	Mon,  2 Jun 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875777; cv=none; b=PrbgsQcudh5xYwjnAtRn8FsAaHcqltfAnIxA15Rj0l4oXWKZgCrgEPwWGONmbopXpMmje/F2Bzr4x8a1xrh7uUs1drs5GDd+wtPRbEtenXD181FuFrXsZrr41cQjwuDRZwiQMyhjOcs6YJisppjAvgYuvzIFTcHfGmmDWt1CYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875777; c=relaxed/simple;
	bh=hz/nI2AX/wZ/Iy+dp0YIupcxgFFbp2hwaHuODFzGROg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJAl9LyU9NGDs8dkb6G8t05n4CMpjuvqk/KK0AIBfy6ZBCkZFpPImYhKb0Gu0meiSe0XwRX6zqQYHHz5XxUhB9cBnuzqNen46DsG1V8zKLuD+ZYz080rN86ogY+llxWfL63TloCMy26YoxrfngET3vOV64b+WsH5x/RgrmF6Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=cyowkGU/; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b9xZF0qx8z9t80;
	Mon,  2 Jun 2025 16:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1748875765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMxYgHaXBKu5N5I1Lldy3oce7xmHsWSkGql2t4sYdgA=;
	b=cyowkGU/jVCS9cjdGBivQ1v6MXhSxYZMWG15qOXSfYS1STxVire6pY44QXTqFal0KqbXL8
	M6oked4PaUd774j5W2y/s6Z8VGHTWBe9LelzfQxvZU49wL+wvMzue0C6+FYEiqKuXo5oeb
	+Xmg05U3tsrYM25nw5oSCcoTL+/NsmjQ6/6iwlnxnnJVkFGcj58Tsq+qzKkkv0m98Ucn/i
	xawB2PG131q6qEIQotTLadXw09ZjMilew8Qgiyd27AN1n38Gg5X+N0PfzNlVPf8AcOmCIB
	ALHJdFYHkQGxhaesjHBhi8kftO67pMMXrx1l14eF148sUURqi8AzQIh5WV5GHg==
Message-ID: <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
Date: Mon, 2 Jun 2025 16:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <20250602050307.GC21716@lst.de>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250602050307.GC21716@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4b9xZF0qx8z9t80

On 6/2/25 07:03, Christoph Hellwig wrote:
> Should this say FOLIO instead of PAGE in the config option to match
> the symbol protected by it?
> 
I am still discussing how the final implementation should be with David. But I will
change the _PAGE to _FOLIO as that is what we would like to expose at the end.

--
Pankaj


