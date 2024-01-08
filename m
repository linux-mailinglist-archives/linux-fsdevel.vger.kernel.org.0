Return-Path: <linux-fsdevel+bounces-7517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FE8267AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 06:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BB91C21872
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B94C6E;
	Mon,  8 Jan 2024 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a2AoyR6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51546BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uKg+nYTis4aP++VXgQU3nRPqNZ3JbRSk3d3G3KZ28uQ=; b=a2AoyR6Ki+7YcjWtviRop4dwP2
	HweCSUCBs1BVQranKTMYGivcPbGITVGrQTUIHsogLIIv5zDkAoIaZaTo9b4iZX8nvzhiOurRpcTaq
	zuEKZYPas4BGXhfuLDL2Ov4iy+k6eOhrSfDlMW+uxptAeMJgh+WTTfiKovmQYa3L3/I57UKhoivnb
	A/MyHg4KtxEP6DNWF4XH1+cNUEh+HwgVyUriG47N/g2MMadXLZnqArmA3DE8gXMFMOlpSM8b+kXlf
	6PZ6MPjzmiyrXLMes0qcFj5htDHGoik/UyVY7a8Lkga0Mv7/WK/wVHzDp3ezj1Xdttqv0XpqKmfLP
	5U0faUjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMhlv-006cdx-Je; Mon, 08 Jan 2024 05:01:59 +0000
Date: Mon, 8 Jan 2024 05:01:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: patchwork@huawei.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	ruanjinjie@huawei.com
Subject: Re: [PATCH -next] mm/filemap: avoid type conversion
Message-ID: <ZZuBx7qtF0l8+SiL@casper.infradead.org>
References: <20240108044815.3291487-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108044815.3291487-1-lihongbo22@huawei.com>

On Mon, Jan 08, 2024 at 12:48:15PM +0800, Hongbo Li wrote:
> The return type of function folio_test_hugetlb is bool type, there is no
> need to assign it to an integer type.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

