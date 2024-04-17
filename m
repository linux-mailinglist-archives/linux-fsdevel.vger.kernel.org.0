Return-Path: <linux-fsdevel+bounces-17096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B88A7A5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC41C1F21E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443B4C99;
	Wed, 17 Apr 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5btZDoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E714685;
	Wed, 17 Apr 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319896; cv=none; b=umGtAm5TG9nn2SIGNhnvFBVYOairZc7ZPFeAkecgKhOGUblfQz8mDzTKV7cLIn6gna9N+mmHFqMb7cXWaJQ+7TRHEq371IK9Z1uBMHMeOMPRCTD9BoMnjCspXfg17DsJ0k/salsO/HaknPw/DDPwU68zo8FHTLAIIchSg8nnk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319896; c=relaxed/simple;
	bh=GwVsCiSUdLXumcKKbN7AYldBiBWjDGhweuv652m80ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ia3HL+zKI0Mu/ALZMq5It+k+50D6NOnOj/f+6T3QwBOnq20GZJodkjV7dyR6nBEZQjqDR03X7L5+rFvzJFgwzv80n6gcHHteCbcM4GZ7z4AER6xDgyBVcQpYWjDtByNxcgQN0Jaj4K+xO7X7tr5/L+Y6M3oVKKwa2QVIdJNT3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r5btZDoc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7xeMB6Ih9ijDiWGIJWbS1l+WLrt+sflLYoCnMcB5XbU=; b=r5btZDocKFY4oYCTrnksD5gVbu
	GaCDqnOzBlDBlfZm71Vj6yE37Bl3kz228Klor9YzZiwOEE4hB5o5H/r7Y7M/xttHrfa1CtDd0tiwI
	DnQI1S9NG/NirsvHKXh9Nl/Vv6t2O3Xmh5xtMaRa94N+Ft1sKeDH1tYNPfy0pSeEpaTu7sK3gvvKd
	3gi2DgKox8q+70Sm2qsk3aOyVPXhYgXH4hVtL97WHs/4Ofvg871RtJxwkv/GibPavUDZNV3janO2c
	VkOtte1NBSOi1CjgMCZpVNhmpxT/wfl2afFuiNFYFpfgdN/kskLAxvFepzSFUu4ZM8t2ZsUMAOHu7
	6/h0Z+0g==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwulq-0000000ERCu-1GNM;
	Wed, 17 Apr 2024 02:11:34 +0000
Message-ID: <856c73db-124d-4564-9c9e-e48ae6475b61@infradead.org>
Date: Tue, 16 Apr 2024 19:11:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] buffer: Add kernel-doc for try_to_free_buffers()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-4-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> The documentation for this function has become separated from it over
> time; move it to the right place and turn it into kernel-doc.  Mild
> editing of the content to make it more about what the function does, and
> less about how it does it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/buffer.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

