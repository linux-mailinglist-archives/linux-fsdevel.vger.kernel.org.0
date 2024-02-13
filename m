Return-Path: <linux-fsdevel+bounces-11361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246185308B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA628B5A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7142079;
	Tue, 13 Feb 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="CSuaviJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D613BB3A;
	Tue, 13 Feb 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827466; cv=none; b=t3WlcQshQG9R3QAqW4DwQOEGUAhjFWmV38n59ba1I4EaqEeoE2ViDY2T/wzACkR7xhHiVNN4rkRKiXJUtR4Pm6x0NUbOZurOEGWQCmPFrNJlzDmONS9qVJK3gk9y5FNFAmFojH9Fakm9WPz7G9NPZyHULVuzxdClUonQEGINZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827466; c=relaxed/simple;
	bh=HFtJQftRt81qsj3WKtpyVLXu2ijNvznvMiSPy4K+l70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owY+KZWUUZbk3bLZxpoaO3ZP7zB12XaEULV8EOPT7J7CjNM8lCHNkp/aG5SSinJaKEBiHtpk7g+sDWFJ+ldDigywxZKOUVwwKgBHcvGeQbs73BZ+9dtJLq02jNMCUfLPvDbWkBKyRQBDinuXnrhMiDkIg8HyBRF1ryn3JogAlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=CSuaviJj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TZ0zh3xD5z9sn6;
	Tue, 13 Feb 2024 13:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707827456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIg66RdJU9OwFIwtt981TU+bUHnJVsypvaGrWF5aizw=;
	b=CSuaviJj+ifluOeWtUWWsQGTD3QjgppzGm9qLW8AykSBIRq6Dfao2ZGDO5Yl37FzE74c+v
	FDz19HU4mjMDeXcn7Musbnf7H/WZC7q3Zsf26mYStBJoz8Ae90lLr25c0SuMrQaxCgEe2r
	w3efZBlHdAUamsHtzqeCYkmg/Vf+QJdj1gSBuo4m5XN1XlPkb3nAhHpMCmWAOXKvi4+AgF
	jXJIO9pnnrA/VeIwuYGSOARj/YFsGs6ODUwqy1TseNW3BhAORIQWILJUfZ8CpcZCTm2tK6
	2o4pCdpqfbdbWtE/aVDtWC97iPMIjXayFEyu5bq8aqQtX6jh50neal+phvb/fg==
Date: Tue, 13 Feb 2024 13:30:51 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Zach O'Keefe <zokeefe@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Message-ID: <qzbcjn4gcyxla4gwuj6smlnwknz2wvo5wrjctin6eengjfqjei@lzkxv3iy6bol>
References: <20230403201839.4097845-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403201839.4097845-1-zi.yan@sent.com>

Hi Zi yan,

> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> File folio supports any order and people would like to support flexible orders
> for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
> page to order-0 pages, but splitting to orders higher than 0 is also useful.
> This patchset adds support for splitting a huge page to any lower order pages
> and uses it during file folio truncate operations.
> 

I recently posted patches to enable block size > page size(Large Block
Sizes) in XFS[1].
The main idea of LBS is to have a notion of minimum order in the 
page cache that corresponds to the filesystem block size.

Ability to split a folio based on a given order is something that would
definitely optimize the LBS implementation.

The current implementation refuses to split a large folio if it has a
minimum order set in the page cache [2]. What we would like to have instead
is to split it based on the minimum order. The main use is of course being
able to free some folios during partial truncate operation.

Your patch was also suggested by willy during our LPC talk[3].

I tried rebasing your patch and there were a lot of non-trivial conflicts.
Is there any plans on sending a new version?


[1] https://lore.kernel.org/linux-xfs/20240213093713.1753368-1-kernel@pankajraghav.com/
[2] https://lore.kernel.org/linux-xfs/20240213093713.1753368-9-kernel@pankajraghav.com/
[3] https://youtu.be/ar72r5Xf7x4?si=XDb-g7SSIgS-5TkP&t=1457

--
Pankaj

