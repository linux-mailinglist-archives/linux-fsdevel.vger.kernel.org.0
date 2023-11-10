Return-Path: <linux-fsdevel+bounces-2735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A71A7E7F4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7474D1C20F6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E293A276;
	Fri, 10 Nov 2023 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RchLAhug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535B1D539;
	Fri, 10 Nov 2023 17:51:48 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6307EF1B;
	Fri, 10 Nov 2023 09:50:57 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso3270734e87.2;
        Fri, 10 Nov 2023 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638645; x=1700243445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=RchLAhugfPDLTttMoM9iU7CaELFRHfsc1MeBkqQnU4S8Sbxr2ZJy4ZWpjyrrkal7Gk
         4OwmgvzlNMJTHRDdJZQStKZDY7f40Ty/P1ybkyS79lFKp/CZD5QxYx/b9YkJnA6IzgcY
         m6MPqxEIt6q2LQiNtg989SMINKPa/nmYh+SZgOM3yUnmZyjCu/xcQY7B8zq6XzuXzMtv
         P3bNsKcl4dnyXS4v734dU+o+ik1z2zDSd4tbpyic/gpKMLoO7EtMhF5TfyRSiglDIDkk
         zsiRjXfc3NEyCLhwZjrbRXpjQ+vm7JTWTrRGi/C4SpNKeHHmUujmAQAVWC6bjvRHpVLI
         uNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638645; x=1700243445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=gDWWqbfXEONQyd1XqKDisL6W47NBzZNCf0oGaihB0Yx2uDVeEnK9DNs3gPrKZTpnjk
         UNF9URH7CoINqw0ISgX5dQLQgIXuJXvOVEsGZbm9af7z+1vKDF88lTF+d9CC+kS6mdvr
         cYMxQ0IRnLsKRvCm0fOjrGzIb7vRnx4c74/XcD60bkBSavRNljOZ4Xfr+ikzaEhhgSEM
         JO7VpuzhJsoY6LSob0ljBaKwZNHe4kqwX2edJuAPYf07n0C9F3bf8B0jysOzd5F9Gg3O
         yZ/LjkUBVnXonotpL59q/E3g0c9mEwl/jNq8cEAkOHuG+H85z3dYyYlR/Avo2sDdjYzN
         WJ/w==
X-Gm-Message-State: AOJu0Yxlc9LZCGnovfAh8LkJPQ3A/CQDnzJVpyg18f1WeXPObY30vatp
	sv38J9Y2Fzw33/z8Ve432CeIGxILMliRJsnaUaVBBBF09wnSzw==
X-Google-Smtp-Source: AGHT+IFh8ABulKL4lvR+Y27vT3gC7Y6r+A/cUSNaE107DZZDGksZhMpoVeGCNcPb4JO3asUj1EER8G3o9QliCpYHcLY=
X-Received: by 2002:ac2:55a3:0:b0:507:a12c:558c with SMTP id
 y3-20020ac255a3000000b00507a12c558cmr4208700lfg.46.1699638645020; Fri, 10 Nov
 2023 09:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com> <ZU5jx2QeujE+868t@casper.infradead.org>
In-Reply-To: <ZU5jx2QeujE+868t@casper.infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 10 Nov 2023 18:50:33 +0100
Message-ID: <CAHpGcMK5ODLzONNJiVAzLwxF9BKnFo=h+dP=TEtUXxDc+u+gkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 10. Nov. 2023 um 18:09 Uhr schrieb Matthew Wilcox <willy@infradead.=
org>:
> On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
> > On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > +static inline void folio_fill_tail(struct folio *folio, size_t offse=
t,
> > > +               const char *from, size_t len)
> > > +{
> > > +       char *to =3D kmap_local_folio(folio, offset);
> > > +
> > > +       VM_BUG_ON(offset + len > folio_size(folio));
> > > +
> > > +       if (folio_test_highmem(folio)) {
> > > +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> > > +
> > > +               while (len > max) {
> > > +                       memcpy(to, from, max);
> > > +                       kunmap_local(to);
> > > +                       len -=3D max;
> > > +                       from +=3D max;
> > > +                       offset +=3D max;
> > > +                       max =3D PAGE_SIZE;
> > > +                       to =3D kmap_local_folio(folio, offset);
> > > +               }
> > > +       }
> > > +
> > > +       memcpy(to, from, len);
> > > +       to =3D folio_zero_tail(folio, offset, to);
> >
> > This needs to be:
> >
> > to =3D folio_zero_tail(folio, offset  + len, to + len);
>
> Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
> which doesn't exercise this code, not gfs2 or erofs.  Thanks for
> fixing this up.
>
> I was wondering about adding the assertion:
>
>         VM_BUG_ON((kaddr - offset) % PAGE_SIZE);
>
> to catch the possible mistake of calling kmap_local_folio(folio, 0)
> instead of kmap_local_folio(folio, offset).  But maybe that's
> sufficiently unlikely a mistake to bother adding a runtime check for.

folio_zero_tail() is a bit of an obscure function, so I'm not sure if
there will be additional callers. The parameters are described as:

 * @offset: The byte offset in the folio to start zeroing at.
 * @kaddr: The address the folio is currently mapped to.

What about changing the @kaddr description to 'the (mapped) address
within the folio to start zeroing at' or similar?

Andreas

