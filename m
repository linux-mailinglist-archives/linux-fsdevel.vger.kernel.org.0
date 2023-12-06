Return-Path: <linux-fsdevel+bounces-5061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31A807B75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B76E1C21173
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB447F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaxyClUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D419D46
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 13:07:39 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1cdeab6b53so53995266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896857; x=1702501657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWiJVJee8Ae6eLRLe/k0sR+dOBFv9TJldm8F95K/pME=;
        b=uaxyClUHlKemjx5GKVDVhQFueN3Fw3o7aIlHFOcUCqUYaz/yq2pmPjNdHsRJJzGIlT
         LtH6vnzxT/MAYUZQs7IrMX1227uc2DJN2Ilm64y89uyKOkdrBiVj9LPx/VpXav4rZW3k
         B3CTwBfyv44QCuRL032WVdnKV74jSnVCyINsO1xO54uq6bmO5/0xACen+e3MvS+vFC7R
         5qETvK9BTCt2lU78i9rQl880PIyNHGVyjYyDH/OetrQbCYHhiV8ySQfmTcALbLGux+LP
         PaGyBzr+kovOd5lsBnuK2bnSTEAABo1apOET28gDhzam889qkFvy+8bRhtCYj+6ynI9H
         aAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896857; x=1702501657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWiJVJee8Ae6eLRLe/k0sR+dOBFv9TJldm8F95K/pME=;
        b=I+dbZ2/vy0N5ZgvJLHrC3k6HYnppRHJUuPAPYPAcV3PUOlx0LwADoMkP0NnOYRGSO5
         01/VoGqBt+wzKz+i2rmDZLDKVdBddIsI788Kjt+q1/jj3kaBf2a6GsdbyWxTKf/F221p
         ZmKBlz/iWgeVjIaKhR18vjj+oBwRRcBMMDDe4/BNED5U7vGMbFoxDZWsPE1X7dZIn6wE
         4M1vwoW/dQWalRIlqH7G+CGjOC0PIhuCSJD2yPHrgATr+emtJQVYcFEcDzdHtWw4AWEc
         oPOvXFM1dlxeDyuc380CUHzvHUwUzGiVMfhedkb0Yn4Mpp+cA09ToB8+UfGSg3x++VG6
         EClQ==
X-Gm-Message-State: AOJu0YyBH+MsjJiBQ0gx5tHDr28ajcY56ehOpz1OIQk9iIhlsCg2t2So
	aMggAHcKtL8qivQnCjC/zn/xJnbnfXJPncSagQ2ESnSIeUnnwn9EPYI=
X-Google-Smtp-Source: AGHT+IFQjAKqMvzci7bqRXKnmQiuPN2tBzZy5yeK5J2Q2g/TCKcGOpN0MrSz6JauubgQZ62nAWBZ0HCbCU0eSEHJpHE=
X-Received: by 2002:a17:906:185:b0:a1d:d900:271b with SMTP id
 5-20020a170906018500b00a1dd900271bmr1351024ejb.2.1701896857444; Wed, 06 Dec
 2023 13:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206204442.771430-1-willy@infradead.org>
In-Reply-To: <20231206204442.771430-1-willy@infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 6 Dec 2023 13:07:01 -0800
Message-ID: <CAJD7tkbJ7zL4pyvFuWB48Yj-p_aqAJji81+hk8nsmUdF2RYj3A@mail.gmail.com>
Subject: Re: [PATCH] mm: Support order-1 folios in the page cache
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> @@ -2836,7 +2844,12 @@ void deferred_split_folio(struct folio *folio)
>  #endif
>         unsigned long flags;
>
> -       VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
> +       /*
> +        * Order 1 folios have no space for a deferred list, but we also
> +        * won't waste much memory by not adding them to the deferred list.
> +        */
> +       if (folio_order(folio) <= 1)
> +               return;

Would it be clearer if we have a folio_has_deferred_list() helper that
has the check and the comment, instead of having this comment here and
commentless checks elsewhere (or repeating the comment)?

