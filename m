Return-Path: <linux-fsdevel+bounces-5717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9080F1EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA452818D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D5477658;
	Tue, 12 Dec 2023 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk6w5nIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D99D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 08:10:38 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so5123020b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702397438; x=1703002238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4um+BIY3lX0aXVqH08jbmcx4JW7rb7WnNCx2unJlEg=;
        b=Nk6w5nIGxtlTzXevoycGHQLnEGnmoD+q3fGDc6QTyuZokA+9ny26/hB+NtVHsUy1+4
         KlFyLycjeRCW8WygaiuGpViOx8PdCg0OxOOCXyA3UJCwjsweR4c/CJ7L/6JBNAyrjC9U
         vichjgGp9ON/7anDeC0wrKW4eAA8hCv1X69HN+LQDT6Ixf0GlJjlrPXsUrE+0jI9maAG
         JVb4bU+7uBu1UUdwqGVczYZhg6KcRaab0L+oEJE+6Oxz8yq7KjBRwMr/o+MlZYc3Kiva
         et9xyP/z3zEvn7TV9eUpYrqsmiOWmcbCaWnlhu6a5uxID52SIlit8bid+lbqGHdY88Lm
         JViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397438; x=1703002238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4um+BIY3lX0aXVqH08jbmcx4JW7rb7WnNCx2unJlEg=;
        b=ZNeXQjhIMbQ3ejLNlvCkpeCrW5vyGepznZQ5b6LX1PXehhXl5/+hGrsUPiuSZuINRu
         4S/qPNo/vitmTI9VCPVyyH4HufnorTGXkAEDn+qm9Jdq5I6wY4Q4QgFmW2qjVP1biFpu
         dtwbDoxpDydgdRlcbq/ccPvSlrQ/aln52nBgc3waFAcmLMNA6ElLRdep+7d+fQEivhDC
         +pxaAcHn9OYYR/uuXr/xxh59KujcTr0tyu0CUP9hjqcTgmeMwOECa78A7P9r5pPNNljI
         XQWLbujZZEvSU27Hr7vdjw12ZW0bhdJADcRDw3uHr3+L0FmLZ20uwi7lBApsW7SHMvAd
         VGuw==
X-Gm-Message-State: AOJu0YwWaNHBE8CH310agkxuRMVu4/AiaX4h0V5iWQzGjAwHQfbmNArz
	6qk5OFNFH83fVbR/T16swSvrftfBcSzVvmrqK2g=
X-Google-Smtp-Source: AGHT+IHWptAQCKC5247tnTXBeOAoF8XV6VDEPdoCWbEfuzUmyhf/2TQUYApSoajl2pm15wZo9U7pDOU0X6ZGq+dxs8Q=
X-Received: by 2002:a05:6a00:1d86:b0:6ce:448b:b8 with SMTP id
 z6-20020a056a001d8600b006ce448b00b8mr6215766pfw.65.1702397437800; Tue, 12 Dec
 2023 08:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207234701.566133-1-sanpeqf@gmail.com> <ZXe9Gd+qHm4dt1Ss@casper.infradead.org>
In-Reply-To: <ZXe9Gd+qHm4dt1Ss@casper.infradead.org>
From: Fredrik Anderson <sanpeqf@gmail.com>
Date: Wed, 13 Dec 2023 00:10:26 +0800
Message-ID: <CADi8-=rm=6TF3qqjHhGEUdotWtTf6mZm5ZLi7Auf-BYh2aydTA@mail.gmail.com>
Subject: Re: [PATCH] exfat/balloc: using ffs instead of internal logic
To: Matthew Wilcox <willy@infradead.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, Wataru.Aoyama@sony.com, 
	cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 07:47:01AM +0800, John Sanpe wrote:
>       WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> -     ent_idx =3D CLUSTER_TO_BITMAP_ENT(clu);
> -     clu_base =3D BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK))=
;
> +     ent_idx =3D ALIGN_DOWN(CLUSTER_TO_BITMAP_ENT(clu), BITS_PER_LONG);

Thanks a lot for this question, the clusters are aligned here,
so the final calculated "map_b" is word-aligned.

On Tue, Dec 12, 2023 at 9:53=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Dec 08, 2023 at 07:47:01AM +0800, John Sanpe wrote:
> >       WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> > -     ent_idx =3D CLUSTER_TO_BITMAP_ENT(clu);
> > -     clu_base =3D BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK=
));
> > +     ent_idx =3D ALIGN_DOWN(CLUSTER_TO_BITMAP_ENT(clu), BITS_PER_LONG)=
;
> > +     clu_base =3D BITMAP_ENT_TO_CLUSTER(ent_idx);
> >       clu_mask =3D IGNORED_BITS_REMAINED(clu, clu_base);
> >
> >       map_i =3D BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
> >       map_b =3D BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent_idx);
> >
> >       for (i =3D EXFAT_FIRST_CLUSTER; i < sbi->num_clusters;
> > -          i +=3D BITS_PER_BYTE) {
> > -             k =3D *(sbi->vol_amap[map_i]->b_data + map_b);
> > +          i +=3D BITS_PER_LONG) {
> > +             bitval =3D *(__le_long *)(sbi->vol_amap[map_i]->b_data + =
map_b);
>
> Is this guaranteed to be word-aligned, or might we end up doing
> misaligned loads here?
>

