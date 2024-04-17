Return-Path: <linux-fsdevel+bounces-17095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8FC8A7A59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED341F222A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1534C8C;
	Wed, 17 Apr 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xuHAJxkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA2184F;
	Wed, 17 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319829; cv=none; b=Ci0UGnESgkLVbCfCiEg9qHX4hE6MKcKzX9KgwOcKAxKa7vkHvdBG03qN6z1fAjqg1g/2ghVpUTp2ZoX3mxFEBLVJT+mFbmRu1x0uA6liygrP/qKhizYz1hcaiNAjnayiWRtvPg3ARMiUfWyvivma5xipEHBtwYGyAdw334QviJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319829; c=relaxed/simple;
	bh=3CdtMLsVYPvE+QPBDfYFzHlrUviqieHd3T6YRtHWp5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0zOFYXstlnoSA8OfwYayw3PbETJQ5NJqyGSfJGZgXXDxG3j4uFzLYPpvERrCdh8wmreNCsFuB4jcnapmDr2W2gvbDYppTODICV3h7L8+YrvrrMNKZg1pmDdduD6T8I+RLz3AIgXHzOpalr0+byjBszxeiKeYrIoFYPB6qT5orE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xuHAJxkU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IQVqMjFZf7h0tzU201NRPSpyAfFLwp6EhBUnUvkXK40=; b=xuHAJxkUQXDVnUFTw9IwIrd/KJ
	3jyA2VD0BB1kerTJ1Y94EuW2WOaStdvNyLnkXe3SIfzpuIyO+MnXhh8ayJzbHvXPSXFbyAI78aZaM
	HKysz1F64vvpAzn4cE7vBJDdssHJ0aI0V1psvLxft2k7o1+o9tT4SvPFys7Zz6gq+6TuF45G//NqR
	Al8fGztEBM7yTKFxoRxCCher5oosvQrPQWSFn00nBCAB5+P+FH+sDm01HpGhQsBvYDQKld5q5zaWd
	Li4gQw2uKM+O+eHyuLPec1qWsNaFTj426FPEfpxbqVCbNjCFM1e+YAMUckKXVM/Z8eRc+Ct7bV/eq
	rUxUafZw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwukg-0000000ER6N-2WVI;
	Wed, 17 Apr 2024 02:10:25 +0000
Message-ID: <68f40ed0-ecf0-4152-b634-db8ed6d688be@infradead.org>
Date: Tue, 16 Apr 2024 19:10:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] buffer: Add kernel-doc for block_dirty_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-3-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> Turn the excellent documentation for this function into kernel-doc.
> Replace 'page' with 'folio' and make a few other minor updates.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/buffer.c | 55 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

