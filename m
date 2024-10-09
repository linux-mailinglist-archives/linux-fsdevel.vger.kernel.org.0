Return-Path: <linux-fsdevel+bounces-31501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C032997868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB261C21276
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD21E32CB;
	Wed,  9 Oct 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIuRj7j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA916BE3A;
	Wed,  9 Oct 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512528; cv=none; b=W2ZXJjnwZtzIQ7pGTbhSVEOzy00dQKhEeiGAW6rmoFw/GM0K2lQe/nEFFy3QPoW/fOIgzInTpUcxCEEfxV1lMlFd3X6SIZSP0LhCFPakI1WsZiz7LnBdTiffvGgw5NPSi6HycLRHcLUUVeH0Oa2igZA4Ofj5JPd2swI29dt/4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512528; c=relaxed/simple;
	bh=t2grafQ4p5qcPLkHVLDhCLzP8cWU7FO81QJnhVWwcr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAIzHxIPP+CUQT9VltacadB1ixB7nKyz6kIehqgJV3/MzZDe6fnETe933EStEgA8XDgfFo4hyQbxzj6RxH7J6WA3MJyUsf9VRDKkNdu91MXkdA2sWW4VKijotOMfC6m1umUnfuUlu7ToIjcrEK5igW32Xk+ev9Ybe0e7/NJ0GtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mIuRj7j8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=EOYU8y4+qI/COMS/ju+DcVNRCAm1uZYZJBornpKVAuw=; b=mIuRj7j8eZEgpO5sH3Bj/L47OG
	S2IGXdvnH2o5Gk4BDASpjWkQs7AVXcwb32o0X1ofIMWJI+4ZVNTkD0m1CgUYf6bfVtFhbbRX14guT
	gyPry2F7ICdNe7oR9IK3mOSNM+A9UG6nEYbACHRPCRNN6kCAC97Nnnhk8xP+8bKWNvmKI9wlz9nkH
	SgNc2ZxzVNja9GlAYU9O56sINaztznj+//jwcc5KoIdQHrzBF2knYVq6Bu4Th8YzRlsxI0Riu19aa
	e7DxMuXPmcu1ttlbdOYDjS1/5PElfw3iMMfxQuruErtqhIM+33GD3Q6PjcFUQBgjvQIBbVIDfVwsY
	vqngR5Kg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syf4F-00000005xB0-40PE;
	Wed, 09 Oct 2024 22:22:05 +0000
Message-ID: <b4a4668d-1280-446e-b1a9-a01fd073fd8f@infradead.org>
Date: Wed, 9 Oct 2024 15:22:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] XArray: minor documentation improvements
To: Tamir Duberstein <tamird@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
 <20241009205237.48881-2-tamird@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241009205237.48881-2-tamird@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/24 1:52 PM, Tamir Duberstein wrote:
> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Use "erasing" rather than "storing `NULL`" when describing multi-index
>   entries. Split this into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> V1 -> V2: s/use/you/ (Darrick J. Wong)
> 
>  Documentation/core-api/xarray.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 77e0ece2b1d6..75c83b37e88f 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst

> @@ -52,8 +52,8 @@ An unusual feature of the XArray is the ability to create entries which
>  occupy a range of indices.  Once stored to, looking up any index in
>  the range will return the same entry as looking up any other index in
>  the range.  Storing to any index will store to all of them.  Multi-index
> -entries can be explicitly split into smaller entries, or storing ``NULL``

Is storing %NULL does by making a function call or just by doing
	*xa1 = NULL;

?

> -into any entry will cause the XArray to forget about the range.
> +entries can be explicitly split into smaller entries. Erasing any entry
> +will cause the XArray to forget about the range.

Clearing any entry by calling xa_erase() will cause the XArray to forget about the range.


>  
>  Normal API
>  ==========


-- 
~Randy

