Return-Path: <linux-fsdevel+bounces-18014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F48B4D30
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC58B2121F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31774262;
	Sun, 28 Apr 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W317A/ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04631A81;
	Sun, 28 Apr 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325206; cv=none; b=IpQwaHu/G6t6Ft5GekTNlGRdyCiL6bjRTWy+BNsk2ySsQGITq2n2SWdh95lK0elmzXWZCPDmib/GxFA2P1Z472oXiG65GhiLu5LAbZ5GQBYeoouo9XLZckza+hJJbgVYt+NBFvWT5RkvesLpc4BMBYs0k6FZhxfXOCm1PHY+xPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325206; c=relaxed/simple;
	bh=NZBB+ghwJcuayzIp9bDWsCN8O4KXLge43NacmZc8NQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di2SK5mcigO266KGbQc/jD2Z6pbLQzeUAHLQB2EiW5yFG43AbaGy8tZS4VowyVrllTLVzUwNIlovH6ZRRulL1JDWvqS6vDu2wUSO9omOuSu58amfAhaI5fLwQrTt1rEjB4cZ+s+R1u8GUV6X30jG6zDcsCfUkMU5kqrfKSepqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W317A/ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C07CC113CC;
	Sun, 28 Apr 2024 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714325206;
	bh=NZBB+ghwJcuayzIp9bDWsCN8O4KXLge43NacmZc8NQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W317A/hoX8B+KiUST+7/pu2WuTHJo52zMGPXrI7lYfc0FC8+TjED96YPfgydfYdWo
	 x1e+paLmPebdJCp3cnujaVvv446sPJmLGkD3wnqwH5ecX3Oy4/vdnk2XTVUCQDXk0b
	 I0GvuAQx7CdrTXftLMoiDPTsxg4XFC7eDhry1D1vIkoZ642PnBrRgrflOAovuIu7ek
	 CWT16uXtDdbetE0WqMVk0A48apjdLMhscN1YZlJxSx6b0JN35x5eWTLiaLhxlyRS4g
	 Pfe+UmQPPAXzR8h3NOzMhcwwyklvkKSHWZKJlOmC+MLBl+BePfnqsEtZwGd+oF7rhR
	 VvMR/fWeoq4Ow==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5196fe87775so4142722e87.3;
        Sun, 28 Apr 2024 10:26:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMpHKpPgUgnyuiWPK9QLn4BXRxmJtavy76KMG9rSzkTmGBAhbzDk/C3OWRz6VgOyNLuc3cj+CyKmFZjd0/fZ2PbyPCmHOOmAy/Tn/u1WgIBtkl+WbXS5cLowpProK/XTjdSVuiJ5HXAgEgTw==
X-Gm-Message-State: AOJu0YwIVS8CHdc0Lyah+aWZt0i4iIDb09bg8R6DPa/cR8pn5G7o9QxI
	kYpM1eysKSiq56In0pGKQ50io5t5LGWWqRDd1dmBcntDXBYthx9FjIxzFcUG7qGCZWxGhVN4VKY
	bJuhYo7SgIhB0pQ44AntwDwMyEw==
X-Google-Smtp-Source: AGHT+IFxQjAw2SnF0iRAXtnb8jTmrOY2NuODB+Cj3WvrPU2Ml05CysfJT5l2mppXdZWCM5syLOZelMTQm4+fIB0DT/8=
X-Received: by 2002:ac2:55a2:0:b0:51b:f78d:c189 with SMTP id
 y2-20020ac255a2000000b0051bf78dc189mr3486644lfg.14.1714325205084; Sun, 28 Apr
 2024 10:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zico_U_i5ZQu9a1N@casper.infradead.org> <87o79zsdku.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CANeU7Q=YYFWPBMHPPeOQDxO9=yAiQP8w90e2mO0U+hBuzCV1RQ@mail.gmail.com>
 <87bk5uqoem.fsf@yhuang6-desk2.ccr.corp.intel.com> <CANeU7QknjZrRXH71Uejs1BCKHsmFe5X=neK7D1d1fyos0sAb9Q@mail.gmail.com>
 <871q6qqiiy.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q6qqiiy.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 28 Apr 2024 10:26:33 -0700
X-Gmail-Original-Message-ID: <CANeU7QkTev=cyL37mcVJNUJT2-WccRvKJirkNQU8Av97ePB3Pg@mail.gmail.com>
Message-ID: <CANeU7QkTev=cyL37mcVJNUJT2-WccRvKJirkNQU8Av97ePB3Pg@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Kairui Song <kasong@tencent.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 8:23=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Sat, Apr 27, 2024 at 6:16=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> > Free the shadow swap entry will just set the pointer to NULL.
> > Are you concerned that the memory allocated for the pointer is not
> > free to the system after the shadow swap entry is free?
> >
> > It will be subject to fragmentation on the free swap entry.
> > In that regard, xarray is also subject to fragmentation. It will not
> > free the internal node if the node has one xa_index not freed. Even if
> > the xarray node is freed to slab, at slab level there is fragmentation
> > as well, the backing page might not free to the system.
>
> Sorry my words were confusing.  What I wanted to say is that the xarray
> node may be freed.

Somehow I get that is what you mean :-) My previous reply still
applies here. The xarray node freeing will be subject to the
fragmentation at slab level. The actual backing page might not release
to the kernel after the node freeing.

>
> >> And, in current design, only swap_map[] is allocated if the swap space
> >> isn't used.  That needs to be considered too.
> >
> > I am aware of that. I want to make the swap_map[] not static allocated
> > any more either.
>
> Yes.  That's possible.

Of course there will be a price to pay for that. The current swap_map
is only 1 byte per entry. That swap map count size per swap entry is
going to be hard to beat in the alternatives. Hopefully find the trade
off in other places.

>
> > The swap_map static allocation forces the rest of the swap data
> > structure to have other means to sparsely allocate their data
> > structure, repeating the fragmentation elsewhere, in different
> > ways.That is also the one major source of the pain point hacking on
> > the swap code. The data structure is spread into too many different
> > places.
>
> Look forward to more details to compare :-)

Sure. When I make more progress I will post it.

Chris

