Return-Path: <linux-fsdevel+bounces-2587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6D7E6DFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB081C20A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C984208BC;
	Thu,  9 Nov 2023 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MP6ut27M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E3200C4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:47:52 +0000 (UTC)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038A358C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699544870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7iD0mry1TaOJ3BfGGYjkfYRYXQnVJFxaQEa8O7iA/A=;
	b=MP6ut27M891zQeBM8vCKXc9NomQMYkQGjceA99reGEoFrHsUxJ3YqumbnGY6qeDNZrkWAL
	xkFz7VRWmYTLEAkdwM7kg5O8W5njy0ONzc+1zJbKL53sJ5P9chzbdxEnyEAlQH9ksMmgc2
	e853j8MfB+P+IiWTDl91iUzST8FPcmw=
Date: Thu, 09 Nov 2023 15:47:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <a60cb31b7181a685c38ebfc8d7c721609c8dce0b@linux.dev>
TLS-Required: No
Subject: Re: [RFC][PATCH 4/4] mm/rmap: implement anonmap allocate post
 callback for page_owner
To: "Matthew Wilcox" <willy@infradead.org>
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 chensong_2000@189.cn, xiehuan09@gmail.com
In-Reply-To: <ZUzoanvY4eIc1xK0@casper.infradead.org>
References: <ZUzoanvY4eIc1xK0@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-5-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT

November 9, 2023 at 10:10 PM, "Matthew Wilcox" <willy@infradead.org> wrot=
e:


>=20
>=20On Thu, Nov 09, 2023 at 11:25:21AM +0800, Jeff Xie wrote:
>=20
>=20>=20
>=20> +static int anon_alloc_post_page_owner(struct folio *folio, struct =
task_struct *tsk,
> >  + void *data, char *kbuf, size_t count)
> >  +{
> >  + int ret;
> >  + unsigned long address =3D (unsigned long)data;
> >  +
> >  + ret =3D scnprintf(kbuf, count, "ANON_PAGE address 0x%lx\n", addres=
s);
> >=20
>=20
> ... completely ignoring that it might have been mremap() since ...
>=20
>=20I'm not an expert on anon memory. I'm sure someone can tell you how t=
o
> figure out the current address that a folio is mapped at.
>

I'm currently not sure if the address parameter is the mapped address, so=
 this is an RFC patchset ;-)

__
Jeff Xie

