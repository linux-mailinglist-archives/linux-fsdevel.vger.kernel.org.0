Return-Path: <linux-fsdevel+bounces-1121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265797D5B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 21:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573451C20D53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158503D3B8;
	Tue, 24 Oct 2023 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNnE1fsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E124A09;
	Tue, 24 Oct 2023 19:38:46 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8D12B;
	Tue, 24 Oct 2023 12:38:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so7912189a12.1;
        Tue, 24 Oct 2023 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698176323; x=1698781123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa1FCPOA2Jbm1K9NwOvyFQLbqNXLKlJRD2kfQ1W5URk=;
        b=PNnE1fskSX01E8C24OC7ibAFQ+3RUd0XVg5AOb+/DuQLeMznoKg8WyCB9AQBPetdDa
         5NlJR5/SF+A8iOjJburQToqFWbDRcp/AMh+LcbL/qAjGsH3YlPLnokL4eI1SVlqLBlil
         ChXLOdAwjEHex83RIsrbWPJVFGMTDE4cnj/B7VwSJC06D6MWcpwXkZ+lQNclm1SI0qKY
         EtoNmHT7uz9NnBfandVWe8cemx1vE92x4qmIiMXVmx4cun82SKAa4QejEwDYqEVDTMdY
         /46LpRi8r0qmvFIa4mEnNGAXEPMkJt9z5xGfENIGNuVfBWEw9F5RjmRLUeKFt7eBA4xG
         SVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176323; x=1698781123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa1FCPOA2Jbm1K9NwOvyFQLbqNXLKlJRD2kfQ1W5URk=;
        b=hEyYEPYMiPIvse/MvEwSgBzm99QsZAbjYVq9SwE3L+JoIsyFwUIHjGQllt/wDC+b8e
         MAyyUJ/i83uYmj0pRAGPSw8FQQ5cPeBVkNCu6odgyNyOiAvfS7JeXhidtxMzS5l/eDM8
         by8myfopL0LWc0UU7vCZZsKWqk4OhqmRJh8b/+sgYzZCOKp8KpiMnzDDhbUSVJNg7rD6
         yuQktmm6IMAAkru7gmJIOTt75OHesGcnYfVgbV7Ci8SuHtwqwstzDCCBky4WOpgQPhwi
         xoEBbd3IwmCng7lk6Tu6LEL3BqDpg4CVNKOgcNMVihPl89o6cw+IFqTfamfA2nJiFNr5
         DcgQ==
X-Gm-Message-State: AOJu0Yxrdtn6m75jnKCnRj0izqoyJ/dyioLbZOTdcPRMS8lBNdIpJNr7
	V4wTVt/movO7vqPT5voskY3LFrcyyD8EXpPQZiStPUOy
X-Google-Smtp-Source: AGHT+IHZCqbbrX9RbVTa0U9y52YE3qkfkGd/vZUXay19Wnnng0nFLVPN1xmb7Fm5oWaWK8ep3GCX05+V45OeHSMZiDM=
X-Received: by 2002:a50:cd03:0:b0:53e:7d91:611f with SMTP id
 z3-20020a50cd03000000b0053e7d91611fmr10199074edi.11.1698176323383; Tue, 24
 Oct 2023 12:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
 <CAHC9VhRxR3ygxskpfbukHeM5wmX0=SifvLny2eiezWvwAyB9tw@mail.gmail.com>
In-Reply-To: <CAHC9VhRxR3ygxskpfbukHeM5wmX0=SifvLny2eiezWvwAyB9tw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Oct 2023 12:38:31 -0700
Message-ID: <CAEf4BzbKn5Ee8TVMpph_E8JhKkv6KpgHZBEV0X4RwtMKum10Mg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 11:23=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Oct 24, 2023 at 1:52=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Oct 16, 2023 at 11:04=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
>
> ...
>
> > > v7->v8:
> > >   - add bpf_token_allow_cmd and bpf_token_capable hooks (Paul);
> > >   - inline bpf_token_alloc() into bpf_token_create() to prevent accid=
ental
> > >     divergence with security_bpf_token_create() hook (Paul);
> >
> > Hi Paul,
> >
> > I believe I addressed all the concerns you had in this revision. Can
> > you please take a look and confirm that all things look good to you
> > from LSM perspective? Thanks!
>
> Yes, thanks for that, this patchset is near the top of my list, there
> just happen to be a lot of things vying for my time at the moment.  My
> apologies on the delay.

No problem, thanks!

>
> --
> paul-moore.com

