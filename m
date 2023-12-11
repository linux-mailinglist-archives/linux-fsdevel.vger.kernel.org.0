Return-Path: <linux-fsdevel+bounces-5588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF880DE91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1E3282602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767F5639B;
	Mon, 11 Dec 2023 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiM3KdWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93CB8;
	Mon, 11 Dec 2023 14:50:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso5136357a12.0;
        Mon, 11 Dec 2023 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335021; x=1702939821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2M/QtM4srk5RtLbPaKHdlp0MRAZCUQFxeHkHv+g5gA=;
        b=BiM3KdWYfmckd/UVNUdRdZJYUdL+2s2+pvVIdd6TbMMJ9SIamRQWqCWLfMcJQGmTpd
         VgvOu7mZvuKiRVPuteRc4RhQol3mGBxXtY6bvB5zkBHwl12RNvFHBzGrdmWbN7Cun8f+
         PRC/xn571c7NMe1opK3bxE1TlZKxNs977oU5r63B6zb4/htBG2kzcP9MI98AFtztyzZv
         68wuQ43KZSNYP+pLln+UWEj8impAsNfee6l6lt9LmOpAU8LcTOQQDUAEIrm3HLmB8ZVM
         MsiUXyfJ5pN/H75Kqh+7qS5/QXL5Z5KDXekRocLXgblwcFbyqwGOBFSwQFPsriUc9OJ3
         pJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335021; x=1702939821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2M/QtM4srk5RtLbPaKHdlp0MRAZCUQFxeHkHv+g5gA=;
        b=v/LFq/i7W8tBJ2C+ZSEjDpnbMJ1SDEO4xndC3In3HTsrkfzIN0GDpf72GbJjb/XPyq
         2AAEpLAXuGPRiQCCJQIOXLJX6/LuN6Hs7qHPnoi5YoBMZ6adWCkIE2oB/56sRM/0XTMT
         Tn25IcCbkIjjV7vYMpXgQ08NiSRCCsvXZznbbQgx47q+qit8noU09u5umiv2/kq/rj5A
         baHwB2gffT2eELovYuGqUhp3NwUCtyGb0MTHYgTHeOYbru7oxA0afz/FyG2nQriRyz2Q
         Uo636qV2D3V56TJEksbPXDqZaG+Eupj1QR4foTn19YC8L2bpKS5y+4vaFdKB50aCOZr9
         hZdg==
X-Gm-Message-State: AOJu0YwsefTaQoiwEMmATA/4XyLY49BoohiEXeOvBLtm7/hHTpeqqRwc
	mUTTFF3ywxhypiiobuLVJtnICkGOER3ZBCh6FsI=
X-Google-Smtp-Source: AGHT+IEl7LLXN0ptIhesaEPKAxJzCshfTvbMLJ0xi6Dkzcss2G7d2XM76ZzbLJvOATg2ZmA/J2KgZLy6deCMQm8GDk4=
X-Received: by 2002:a17:906:69d5:b0:a19:a19b:78a4 with SMTP id
 g21-20020a17090669d500b00a19a19b78a4mr2636059ejs.103.1702335020465; Mon, 11
 Dec 2023 14:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207185443.2297160-1-andrii@kernel.org> <20231207185443.2297160-4-andrii@kernel.org>
 <657781ec1712_edaa208f5@john.notmuch>
In-Reply-To: <657781ec1712_edaa208f5@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 14:50:08 -0800
Message-ID: <CAEf4BzYmZjBd5ps-iKjyxLvQ=iD3z092+M_deV5ze0eJXGoFsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] libbpf: further decouple feature checking
 logic from bpf_object
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:41=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > Add feat_supported() helper that accepts feature cache instead of
> > bpf_object. This allows low-level code in bpf.c to not know or care
> > about higher-level concept of bpf_object, yet it will be able to utiliz=
e
> > custom feature checking in cases where BPF token might influence the
> > outcome.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> ...
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a6b8d6f70918..af5e777efcbd 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -637,6 +637,7 @@ struct elf_state {
> >  };
> >
> >  struct usdt_manager;
> > +struct kern_feature_cache;
> >
> >  struct bpf_object {
> >       char name[BPF_OBJ_NAME_LEN];
> > @@ -5063,17 +5064,14 @@ static struct kern_feature_desc {
> >       },
> >  };
> >
> > -bool kernel_supports(const struct bpf_object *obj, enum kern_feature_i=
d feat_id)
> > +bool feat_supported(struct kern_feature_cache *cache, enum kern_featur=
e_id feat_id)
> >  {
> >       struct kern_feature_desc *feat =3D &feature_probes[feat_id];
> > -     struct kern_feature_cache *cache =3D &feature_cache;
> >       int ret;
> >
> > -     if (obj && obj->gen_loader)
> > -             /* To generate loader program assume the latest kernel
> > -              * to avoid doing extra prog_load, map_create syscalls.
> > -              */
> > -             return true;
> > +     /* assume global feature cache, unless custom one is provided */
> > +     if (!cache)
> > +             cache =3D &feature_cache;
>
> Why expose a custom cache at all? Where would that be used? I guess we ar=
e
> looking at libbpf_internal APIs so maybe not a big deal.

bpf_object with token_fd set will have to use a separate non-global
feature cache. Couple that with me moving this code into a separate
features.c file in one of the next patches, we need to have some
internal interface to make this happen.

Also, bpf.c is also using feature detectors, but today they all use
unprivileged program types, so I didn't add custom feature_cache there
just yet. But if in the future we have more complicated feature
detectors that will rely on privileged programs/maps, we'd need to
pass custom feature_cache from bpf.c as well.

>
> >
> >       if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
> >               ret =3D feat->probe();
> > @@ -5090,6 +5088,17 @@ bool kernel_supports(const struct bpf_object *ob=
j, enum kern_feature_id feat_id)
> >       return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
> >  }
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

