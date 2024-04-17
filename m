Return-Path: <linux-fsdevel+bounces-17098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C318A7A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBA1C212C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52270AD58;
	Wed, 17 Apr 2024 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4PaA2k4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26C8F4A;
	Wed, 17 Apr 2024 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319993; cv=none; b=nYIT2rv9pFsr4MClfvhFE9WdaLYXvN8FdAh6N1KQFfglG2+Xe8Z1SheBApMooEnyPrHw2IaCmt8suD9Wd4MEkT/jTm7pMY2I3Nb1yB83toL5TBBTEvhCgb2BzWY4WA+nbeO56Yh7YA+SwIACLTNe17EfXCWsoj/bbBKAT6veI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319993; c=relaxed/simple;
	bh=KeWG7pN6LogReu/Y9KtGX/X94PL1DBVFJWS4C5svYeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJDpRu+xh4Flz7/DoO+4pStHDsmAjLXV9vsfwGeHUlCsaI33DjvEn+9qV168xKo7u6GaMBBpxOKVn2ee8PFnRT4Ltas1RSjzCums7ljTmIbc1SOm+ItTyztDhrzwfj2ZR9s9HlmTKoiMVJBxbPDYJjexc5FIcsmajFDbZq4q+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I4PaA2k4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HBolKlcWFAseiVSMWAtRFglVbNj+tBTq5sgBXg3UjEw=; b=I4PaA2k4iTYJn8TyjHeTJNpQ+u
	7fmtc1lek3U5EN8jLf9dakxI6E8TvSkNK7VFUn/HXWeh2vqlwi5VBzUEwMmnqh+fRCoO+1wZRg5VQ
	yItNwcM5dAQYlYUS0AfnkWafhsbJuaxb1eQfzGIAjxOnTIiLaLc20xA4TYRqaMGV0QYTB+dfMXSjR
	k8slRoxeX33fPkQxhnagB74RJI4zDknZasFCx4/0fObZ+frt+yn0dDr0q9SyJREF+++WyBBslXp/5
	JKG3P6PUpLHkTClthTobvuehad2jDCAV0LnMFgFriIG6Nk0kwksdMNp40XeKGH4MuM2bHyKGTC6bq
	Ojnwtbww==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwunP-0000000EROD-29MU;
	Wed, 17 Apr 2024 02:13:11 +0000
Message-ID: <8ba38f50-43e9-4fd7-9947-210655a6f81a@infradead.org>
Date: Tue, 16 Apr 2024 19:13:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] buffer: Add kernel-doc for brelse() and __brelse()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-6-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> Move the documentation for __brelse() to brelse(), format it as
> kernel-doc and update it from talking about pages to folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/buffer.c                 | 17 ++++++++---------
>  include/linux/buffer_head.h | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

