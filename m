Return-Path: <linux-fsdevel+bounces-44831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15588A6CFBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82211684E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DA5103F;
	Sun, 23 Mar 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzuMR0Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B7DF60;
	Sun, 23 Mar 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739860; cv=none; b=ilLJGp9jcQBKVLXGqgiwuO8lO7/3SaH+ciiPMrOyOfvXf74p8IAR+pOYpcMfu+Fq+PJ58V4hB4gBkQqZFKXCO+QMgWLU1elz8ApXBpbEE9yB5PDmx6gYec22HrUQ059PoIP6ddKeqbJOx/E9P3XvawYYqrknF+S1PEaylJ4kvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739860; c=relaxed/simple;
	bh=SBYzxFD1hwFvuIV4C5YJU/aVEIiuuFHGYfxfHfLvkQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr6lWH2GawxnXKWG3QxGhHIhF6voz3nUf6M51QrFzRloqQ6tIWmfMIyvMqPNeCKDrHU1pDKdmyATVWtQrfXsvOc8t18l9PWTB5HXpAxF52Ylte8omW4Pwy4WrVJU7NJiS17AnKHmEv+obmhj28hxsD6KgVz9Dvfai05hiiiN0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzuMR0Ls; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=quM6B9G2VUOD40sCNsVXuMGBCuUlsByGgiKxIF63r7o=; b=RzuMR0LsCk0+xzbYpEFUG149Lw
	xXA5lIIX+nXb6B8yT0wLBeIJBYcx5SSeI8q+bx9SPJTV5U0/46QwRHw06eDpgk5Naqr0RkA6VQBbg
	H2snYOKQ6raJydR3xwh4TE84QOjIZ7y9nogjOuF5K57Lnpiz+mJjtjI9/aEayeGoVvBblP06t4/Ln
	9HEZwqbbeG/JH3Xr7hnh6u7ZtvU4o8vQY8kdDFHQPpCnr5SD5k9B+1KLGNn+U9mErXXAoGYRKOz50
	URN0kAVfTn6m5gd9+twXzB9oILtiSnCsctrhPE/rv1IpYz97fHVHmaLU6iopIftDOyMS0PldP7P7K
	1lAw3zqg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twMFG-00000006fyU-0Kjr;
	Sun, 23 Mar 2025 14:24:10 +0000
Date: Sun, 23 Mar 2025 14:24:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: corbet@lwn.net, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] docs: vfs: Update struct file_system_type
Message-ID: <Z-AZiYwkE9PsST90@casper.infradead.org>
References: <20250323034725.32329-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323034725.32329-1-richard120310@gmail.com>

On Sun, Mar 23, 2025 at 11:47:25AM +0800, I Hsin Cheng wrote:
> The structure definition now in the kernel adds macros defining the
> value of "fs_flags", and the value "FS_NO_DCACHE" no longer exists,
> update it to an existing flag value.

What value does it add to duplicate these flag definitions in the
documentation?  I would not do this.

> @@ -140,7 +148,7 @@ members are defined:
>  	"msdos" and so on
>  
>  ``fs_flags``
> -	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
> +	various flags (i.e. FS_REQUIRES_DEV, FS_BINARY_MOUNTDATA, etc.)

This should be "eg.", not "i.e."

