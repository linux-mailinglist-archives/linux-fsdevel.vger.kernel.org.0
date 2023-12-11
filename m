Return-Path: <linux-fsdevel+bounces-5550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6280D53C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D91F21A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D115103A;
	Mon, 11 Dec 2023 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHyipAmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FA8D0;
	Mon, 11 Dec 2023 10:21:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso6439119a12.3;
        Mon, 11 Dec 2023 10:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702318902; x=1702923702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8bLjO7K4G9LwVc+suoyv5eMJDKm4Mkz7jpCSdJ5wh8=;
        b=jHyipAmkY/kn5trO+saAyARj0i+BEJWziUqjmA9B+/mlxQ36evs8qe/DG+ecT7D9Pz
         5kqGQi1zzMbkY94YzYALeDfQAyrzXQDo0agm+0lFivrwxVRjh1e4CFVi4deBJyWy2DSJ
         GhZCN/NIwJWegsN85obQQwcbeidSAXEw/BulBTm21qtMlkafKPzAS32jNc0K7EJ4tb9X
         clPj3jD4hWFThwKzkidR/ylsADMd0a9xt8OPcDYt4HsJcekbW7fnutfU5BWbIpx2p094
         Ig113TOlR+xYUQNd52jtsc/Bt5iw7sLO1b2iMVrGJbihCi2ugfFLtG9crK3f30iQDdQt
         c9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318902; x=1702923702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8bLjO7K4G9LwVc+suoyv5eMJDKm4Mkz7jpCSdJ5wh8=;
        b=lA8MXM3drlh2iMnwXAe2k4lqYx607eRnAaDJ88Phs0BHokbhs/Ph/17F0hGqoW+XeQ
         sUZDRSKbz0ffkShzyfW+h2VPcdfKVjDeN/NVKaAIDPls5p44F3AoHHPGNzcsi5xs8+vU
         os77hsQNQxEboB75NBh7Ovo+SF7FrKwR42whCLiDYd+p7qkZoaJxqRd6QrG5a/bVJCgV
         ABZ3LE/YaSAwoZiGfdI9s2pmgBZ/RTjl2BaTwJhmFSKDECeiuWjQ2Iojp5aXghiuFkV+
         bTijYUQfWoz6cyRtElyqTZu9AOxU3RNoq3LZB2lZarU1xDyVUdGlWEZfGW8Yy6F1Y3xe
         YgBw==
X-Gm-Message-State: AOJu0YyGgm2p9tdgkJckRXFyBbygBlWHSZtgLhhrzToIWJtRyyBDHYZM
	dQBqd9oEngBkD5QzmQfHkKWVPbLoB9GXkWCTdRo=
X-Google-Smtp-Source: AGHT+IFFFWuVbwGAUmFUT+L86RPREMleBSyswysjsUAVTpMMIf6RbbNcDNlCO5wk1T7fwdwOJB8vkx4MCNW1c8ICSzE=
X-Received: by 2002:a17:906:5307:b0:a1f:9320:9fce with SMTP id
 h7-20020a170906530700b00a1f93209fcemr1347510ejo.83.1702318902502; Mon, 11 Dec
 2023 10:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207185443.2297160-1-andrii@kernel.org> <ce4bd46009b9b0b8fb2dbec83eaa3e4c476bb050.camel@gmail.com>
In-Reply-To: <ce4bd46009b9b0b8fb2dbec83eaa3e4c476bb050.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 10:21:30 -0800
Message-ID: <CAEf4BzbKJDkFbKo0UVGctZ8in9eD+abgncTXHFh2oZg1Gn21QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF token support in libbpf's BPF object
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 7:30=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-12-07 at 10:54 -0800, Andrii Nakryiko wrote:
> > Add fuller support for BPF token in high-level BPF object APIs. This is=
 the
> > most frequently used way to work with BPF using libbpf, so supporting B=
PF
> > token there is critical.
> >
> > Patch #1 is improving kernel-side BPF_TOKEN_CREATE behavior by rejectin=
g to
> > create "empty" BPF token with no delegation. This seems like saner beha=
vior
> > which also makes libbpf's caching better overall. If we ever want to cr=
eate
> > BPF token with no delegate_xxx options set on BPF FS, we can use a new =
flag to
> > enable that.
> >
> > Patches #2-#5 refactor libbpf internals, mostly feature detection code,=
 to
> > prepare it from BPF token FD.
> >
> > Patch #6 adds options to pass BPF token into BPF object open options. I=
t also
> > adds implicit BPF token creation logic to BPF object load step, even wi=
thout
> > any explicit involvement of the user. If the environment is setup prope=
rly,
> > BPF token will be created transparently and used implicitly. This allow=
s for
> > all existing application to gain BPF token support by just linking with
> > latest version of libbpf library. No source code modifications are requ=
ired.
> > All that under assumption that privileged container management agent pr=
operly
> > set up default BPF FS instance at /sys/bpf/fs to allow BPF token creati=
on.
> >
> > Patches #7-#8 adds more selftests, validating BPF object APIs work as e=
xpected
> > under unprivileged user namespaced conditions in the presence of BPF to=
ken.
>
> fwiw, I've read through this patch-set and have not noticed any issues,
> all seems good to me. Not sure if that worth much as I'm not terribly
> familiar with code base yet.

Every extra pair of eyes is worth it :) Not finding anything obviously
broken is still a good result, thanks!

>
> [...]

