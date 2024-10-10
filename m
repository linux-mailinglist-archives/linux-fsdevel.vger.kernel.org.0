Return-Path: <linux-fsdevel+bounces-31637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71599947E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E871C22276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85651E284E;
	Thu, 10 Oct 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g/FNjAR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7901BC077;
	Thu, 10 Oct 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596111; cv=none; b=jLgUIq92y4UuPvqNQl7f7fb5lVB2hKwACa9U/OYncKxFxBnzuN9ov7GUeec6/9VnBAEP4w1t/SwbRzoYm1WLTLskSSLCdxv84Oj8O1G4CqQj+K/j6QiMgRzP7nA76CLJqQM9VakX1HVuubYc9h4Bhlpp0DECrjxDqNyc/1e4q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596111; c=relaxed/simple;
	bh=zK7p5128U8C4qw9cUGDDbyNbtWkGbaBIkeYO7AqYWYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjK2Aq8phEa+xxSo9YXnpYo8dLEt13TNsZep7gPQJvhRxREkFCPLqLsJwUomgVKAdns+7lnU4nCp3YI+PdhE2ZjVVNJGVfOCU7Rc9B78VCuXnDXu4Bnziv4Mgvnj6ZEiEBt2IGXlELR6fyFi8ZaGjGt+1T8kpYFTOJrCGMxW8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g/FNjAR4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vMbQwUr7ywKb4MkZIOldfixyIkJJKRhdNS4esop9Ajo=; b=g/FNjAR4eBrtGpvrc8xR90CTEd
	fydpayj6JPE0SFXITu299amM1dGMSGvFQ/LSBjyhKfJQd3LliyrSWlvSh43zOJ1YwaGUOfj2RgyhV
	5BcXJjbsVss/z/sEIXY5UYEIqhn4nK8LRnyZSBnCaogLVHf/iRDgDCbeg8xuilhVx4jDlhE3j5v6P
	qIh3yPh/k9JjvqsaL7UCXkG0VDOksk0BpqlVgpeh97U8xEVV3UXfRWoB+t5b8mitrieaH9RKePHfe
	5nVWyBrmruKPLf2oZBhSANZzh3Q/K3vru0JitAYn5VjTCPM9pmkkWJ66EKTGPX/M3QnChqU1RyNVU
	khiOW9sw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sz0oG-00000005g2f-3tAb;
	Thu, 10 Oct 2024 21:35:01 +0000
Message-ID: <f7fba2fa-cac9-4ecd-98e1-adb2cac474ab@infradead.org>
Date: Thu, 10 Oct 2024 14:34:56 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] XArray: minor documentation improvements
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAJ-ks9khQo8o_7qUj_wMS+_LRpmhy7OQ62nhWZBwam59wid5hQ@mail.gmail.com>
 <20241010141309.52527-2-tamird@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241010141309.52527-2-tamird@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tamir,

On 10/10/24 7:12 AM, Tamir Duberstein wrote:
>  Normal API
>  ==========
> @@ -63,13 +64,14 @@ for statically allocated XArrays or xa_init() for dynamically
>  allocated ones.  A freshly-initialised XArray contains a ``NULL``
>  pointer at every index.
>  
> -You can then set entries using xa_store() and get entries
> -using xa_load().  xa_store will overwrite any entry with the
> -new entry and return the previous entry stored at that index.  You can
> -use xa_erase() instead of calling xa_store() with a
> +You can then set entries using xa_store() and get entries using
> +xa_load().  xa_store() will overwrite any entry with the new entry and
> +return the previous entry stored at that index.  You can unset entries
> +using xa_erase() or by setting the entry to ``NULL`` using xa_store().
>  ``NULL`` entry.  There is no difference between an entry that has never

Is the line above supposed to be here?
Confusing to me.
Thanks.

> -been stored to, one that has been erased and one that has most recently
> -had ``NULL`` stored to it.
> +been stored to and one that has been erased with xa_erase(); an entry
> +that has most recently had ``NULL`` stored to it is also equivalent
> +except if the XArray was initialized with ``XA_FLAGS_ALLOC``.

-- 
~Randy

