Return-Path: <linux-fsdevel+bounces-78216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aErgEngUnWkGMwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:01:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D571813AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BBB3142CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AA2749DF;
	Tue, 24 Feb 2026 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3ymAhxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64F277C81
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902020; cv=pass; b=QnVEkyHO3Z8heNE1vLOtB/vXi9o6UfOqvuvOAEZMCKPP9u9wG5svUaUSK48enTbFCdc1rZ0No0EYQ/BH6lEmqomlCmoCiAOwzj3CDxvQG2JirJHLDcW3nHIkUPhdD2IEA1A9MIEbEzXAZYOcmoIL8qj4pVnIzhskv4ofEDScrrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902020; c=relaxed/simple;
	bh=URG9p5PA0AV/5bQlXeYXvRn2vYf4zuMTvunUlPWBpFY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZMpDdLJ18MDmfWNEiqV+71oxPTfTdQpj5Tnh8aD3o8Dg1vgf6F7NQf+NBmO7G3i3gynokMhC3l2IPxYt9qFBAFcUf11jXE6KfUDDNzdVp4/A051nBqoNtl47SLVepz1dgkdSf/Z+0b0xN8cu732wM+z6JanlP1pL01ove9HHIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3ymAhxx; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fe086fb0bcso1153976137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 19:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902017; cv=none;
        d=google.com; s=arc-20240605;
        b=b3rPkJhA2sZ41UxTwEP39Dajq50jGUxAzuJSHPa/qeR0izcr8QO2WffcNfDpyCN664
         EQP3OywBSSn1wIzqeIx8vLRAlE+ZXXaV6UlhOOjIeTXPzK2n7m1p03VGMAhK35xk5eAx
         bQLmj8mzIUbRniL6vUecmg+486PVpxT6X4B3mb7F2BcEwtdlEMmdztYIAvSCPOAlhjgG
         Xk7rE9xvn+QHyZTQXt39yp3gSrgIZCUe35BaXYu9IHT/S3701l+05vLFhtUGhk2iJ9Zt
         ++aNIlx5S6qaolIjmcmnfpo0uke5fn2t/EFlljVGwXpy75Y53j2Q+yjpnn7EusFoFsp9
         cXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        fh=guT89QCBatGtmJeLKMs942Tk1M+fNd6lIVrW0H4Lvc8=;
        b=fOIfRyGxpnxQ4TGN1TMSGoNMpEO5tdWSlFk5zNzEn8XRVOQ2sCUj5rDhKIaDJtWchw
         wOE8QlWS+eS2oixzgNThhTkSAVjgz//KvQOsyCFVqcfVcW/9tllgT0F6KMVRQetNLbs9
         5vcyV0SygXCrp/Z0OTcga9TmYB2dq3m2ATXzAR2nXFS0bVM02/BYncnH2PLLFb3//2r4
         76H8qnOa7mJtA5QMdDsCi0IcVpUk8yc9auDUJ76Ans6w3nODgHDbUH20vKblwUUz/bgx
         bCdc4HaMvSnSVUNXet7BLwYhfwvYYg9TtJkFs/Sm5aEQAfxp0mw4KiTTOTx1eYrl1+bT
         5iYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771902017; x=1772506817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        b=B3ymAhxxWeoTfsl0KRnGRCZw0Cw7PoBJbPwy3MCpelHkkc67TCEWmEMkObdOJ7M63x
         aX2RR//RrqYDhs5WPF0G0EWfQ1CE6/aG+seMJBt31TstS8q18nx5tCnmFdQEah/GoF7P
         Ss079WND2GVySuBN8bDw9gDHvsG4NBE4TnNHOOQLGkWWYRR/7uYcWg4qgJCBNx4/UowJ
         gFnNLyjfvvBcOici+VtfIlJZQsW4j8pyEFjI3vOLDGpj2CqoWk/UuAdZblk8u+DoAL8Z
         f+bSQDDVDdQSw2aZ2YZimO2Ewz9wgcow+pdeYzKHDwLQFH/+mchjBx2p6Cbbm4VmA8lW
         GgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902017; x=1772506817;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFe8WdiYvRsGLyynpqXx4xXBoM9FyyzukwEjWl1pbts=;
        b=lO6RqFBCATaJC8DGydrQE7LQjEd3JeMUa/DLK01ZVh0gKGNrPmjtApItjVeUBe1kWd
         cltY1OX2kCkxKu/EqMCEsRieJ8Uvzi04m6k31ST/ASjcL3R8BSq+zth4xPLcep37BQ2x
         QsI5QzyQA6CqbApSQibzJseyzYkUwPG8OBffPomtvn3dndCK9U1YIVH3KGoFCBXATEeh
         rDG+Ym64O9/iJx+hxNX+2yXy3aLD4VDADm0HfJ/+laeZh+1I57GYXdXrdrz7cIHMRw7q
         Wi9AiaP205ewKEIVcx8iKRW8YfEdIVnHpJIUe314qhYt0JGs45HaEAgeb55wZ4Si1A9B
         sWmA==
X-Forwarded-Encrypted: i=1; AJvYcCXE1SMoNU62P4+BTUV0wSlPID7ZL+WirtmYr9PTb7SVl7HEpahrBye7eyrygggsMp+cNmza6vtLyrsOXYQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzNN33V5/yraCuj01VNp2omd0hyR2YeyC6EYDd5Lj/3iNfb17Oh
	2VC9B2iNyEVtMWFt9VTivCpzaS0Dfm0lOMEyAqxAl7bNM6astveB5qDvOWQUqyFQcw1l0vAZZZW
	xzZzsv39vL8VymKsVJfcwV/yH8e9PfoXdNbamRuxd
X-Gm-Gg: ATEYQzw8iOdRfIWI3oedOk8i4Zy4GnbENEkjuPhWydyQR9GcwUTqpd30dQLnb1wEJT7
	MvMxMxMdby9NadI2Q6qlM2VOOJsOBZkUCqBF2lOzE6da3demCwgc8ZxOd1MnuPFJdttbRDK7mQK
	Ynp/H6S/pi5PdqQVBJR57Uvp7wY5XiaoP2RRQHZAl93q94YwdBmcgT1KrjAydulXi1EyUbolMEF
	4lwLO7VlbNkb/Q1VhgwCjx22YxBhQolV183Vh+QKg77kbC69FYAHJlBmgcVxIBmqVN71+l2R2wC
	Qd4VwRYerhLY8VWtSHSja7fSRJ0z0hri9hbZAi4EPveVsNrJINFPoRNBUwIc0QPaZg==
X-Received: by 2002:a05:6102:3048:b0:5f8:e2cb:d245 with SMTP id
 ada2fe7eead31-5feb2c23567mr4062890137.0.1771902016820; Mon, 23 Feb 2026
 19:00:16 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 19:00:16 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 19:00:16 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com> <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 19:00:16 -0800
X-Gm-Features: AaiRm52vebMvqU0lH0n0vOtDAX6OI7Y7um56VSKnaZ96AOmxaI9gmZymUaqHfu0
Message-ID: <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
To: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-78216-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jagalactic.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,groves.net:email]
X-Rspamd-Queue-Id: D9D571813AE
X-Rspamd-Action: no action

John Groves <john@jagalactic.com> writes:

> From: John Groves <John@Groves.net>
>
> Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
> fsdev_clear_folio_state() (the latter coming in the next commit after this
> one) contain nearly identical code to reset a compound DAX folio back to
> order-0 pages. Factor this out into a shared helper function.
>
> The new dax_folio_reset_order() function:
> - Clears the folio's mapping and share count
> - Resets compound folio state via folio_reset_order()
> - Clears PageHead and compound_head for each sub-page
> - Restores the pgmap pointer for each resulting order-0 folio
> - Returns the original folio order (for callers that need to advance by
>   that many pages)
>
> This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
> maintaining the same functionality in both call sites.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/dax.c | 60 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 289e6254aa30..7d7bbfb32c41 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,45 @@ static void dax_folio_make_shared(struct folio *folio)
>  	folio->share = 1;
>  }
>
> +/**
> + * dax_folio_reset_order - Reset a compound DAX folio to order-0 pages
> + * @folio: The folio to reset
> + *
> + * Splits a compound folio back into individual order-0 pages,
> + * clearing compound state and restoring pgmap pointers.
> + *
> + * Returns: the original folio order (0 if already order-0)
> + */
> +int dax_folio_reset_order(struct folio *folio)
> +{
> +	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> +	int order = folio_order(folio);
> +	int i;
> +
> +	folio->mapping = NULL;
> +	folio->share = 0;
> +
> +	if (!order) {
> +		folio->pgmap = pgmap;
> +		return 0;
> +	}
> +
> +	folio_reset_order(folio);
> +
> +	for (i = 0; i < (1UL << order); i++) {
> +		struct page *page = folio_page(folio, i);
> +		struct folio *f = (struct folio *)page;
> +
> +		ClearPageHead(page);
> +		clear_compound_head(page);
> +		f->mapping = NULL;
> +		f->share = 0;
> +		f->pgmap = pgmap;
> +	}
> +
> +	return order;
> +}
> +

I'm implementing something similar for guest_memfd and was going to
reuse __split_folio_to_order(). Would you consider using the
__split_folio_to_order() function?

I see that dax_folio_reset_order() needs to set f->share to 0 though,
which is a union with index, and __split_folio_to_order() sets non-0
indices.

Also, __split_folio_to_order() doesn't handle f->pgmap (or f->lru).

Could these two steps be added to a separate loop after
__split_folio_to_order()?

Does dax_folio_reset_order() need to handle any of the folio flags that
__split_folio_to_order() handles?

>  static inline unsigned long dax_folio_put(struct folio *folio)
>  {
>  	unsigned long ref;
> @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>  	if (ref)
>  		return ref;
>
> -	folio->mapping = NULL;
> -	order = folio_order(folio);
> -	if (!order)
> -		return 0;
> -	folio_reset_order(folio);
> +	order = dax_folio_reset_order(folio);
>
> +	/* Debug check: verify refcounts are zero for all sub-folios */
>  	for (i = 0; i < (1UL << order); i++) {
> -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>  		struct page *page = folio_page(folio, i);
> -		struct folio *new_folio = (struct folio *)page;
>
> -		ClearPageHead(page);
> -		clear_compound_head(page);
> -
> -		new_folio->mapping = NULL;
> -		/*
> -		 * Reset pgmap which was over-written by
> -		 * prep_compound_page().
> -		 */

Actually, where's the call to prep_compound_page()? Was that in
dax_folio_init()? Is this comment still valid and does pgmap have to be
reset?

> -		new_folio->pgmap = pgmap;
> -		new_folio->share = 0;
> -		WARN_ON_ONCE(folio_ref_count(new_folio));
> +		WARN_ON_ONCE(folio_ref_count((struct folio *)page));
>  	}
>
>  	return ref;
> --
> 2.52.0

