Return-Path: <linux-fsdevel+bounces-7561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D68275A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68A1B223CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A353E3E;
	Mon,  8 Jan 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O/oflqmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1E53E17
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1247221276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704732329; x=1705337129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVuIgnahugRDwfdeFuBbzBR3KYIVwzwbEm3l+2cHWHs=;
        b=O/oflqmmVGXi/gsBbl5n3jgKfJd7Ucyqf314VgRuqyaxh4WTNEDGyR6bMRATLr61ws
         ObR534bSwrget/UfQHk4a5y/efFa8lgdETOGSiuV1g4Dl3htj9uWvmN7jsvRCGTPh9+E
         B0V5NJwkGvmMsMeyChZWtT7pO/eHCH6f5SogLhWNfXPdegvxCwkQa24Un+DgKVuVQ8Ag
         rJTtKXDOT+9b8+2nxWvTS+OsHdCKzLb5qeSb68d5z09Tvt8MMHpUDJhWjZWYTTuDT6VY
         a9d9zHIkRZOEM8zlon1whQim2fTEageFYWGsDleI5IUxew8H74HB/HcECD1h3LJndpr2
         0vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704732329; x=1705337129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVuIgnahugRDwfdeFuBbzBR3KYIVwzwbEm3l+2cHWHs=;
        b=s735WhqLOIPg269RvlH9iXfA0KmWsNXf3e9jYuK7LVMVOMgfX9vY01p7Zp1KjkSf0o
         kdP5aGtqFPJTxHqPqi62+Oe9tuHrwgMsgzOWlY8RuA5fa9AN6DW4t3hh9jMb3tgRGoUi
         pwUkKuByph/mGsCRjnzitThExjydd44se2tEGmn6H05vP54lOH0DSNmvuWAj0+KNqKNC
         uRMTbz5uZPShjO0l3u2kElAATckORx60LuBs2mKWWsfcgEl+jKbk8titahvhWS2FHfjt
         6gs0DmEHWgTCLMEyuUjJ7yAY16HWv5evKEVqkR+9bn5LQ8HlEqIEFv2lNHANyYatLQxE
         9vFw==
X-Gm-Message-State: AOJu0YwF13W9LNMNqAwvWFcHJ9+WzrxI+OuuDIC0NbEIvT/wIpwIf30a
	vb+TqTZkLyEMPTwOllQdv1T7T7GawhQixiv5cU+YT4IRf3bt
X-Google-Smtp-Source: AGHT+IFw22iEGTnFRWzmYXtloBMr6VnOd6CaxkdRy6faH/1+2adk2GdZEx6ti0o3TaY8BDjCpQlMpNb3yTSntSVs0DQ=
X-Received: by 2002:a05:6902:2747:b0:dbe:346b:b97 with SMTP id
 ea7-20020a056902274700b00dbe346b0b97mr921467ybb.23.1704732328906; Mon, 08 Jan
 2024 08:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
In-Reply-To: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jan 2024 11:45:17 -0500
Message-ID: <CAHC9VhQg7mYnQw-o1TYon_bdtk_CMzJaf6u5FTPosniG-UXK1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 4:45=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
> On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > +{
> > +       /* BPF token allows ns_capable() level of capabilities, but onl=
y if
> > +        * token's userns is *exactly* the same as current user's usern=
s
> > +        */
> > +       if (token && current_user_ns() =3D=3D token->userns) {
> > +               if (ns_capable(token->userns, cap))
> > +                       return true;
> > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns,=
 CAP_SYS_ADMIN))
> > +                       return true;
> > +       }
> > +       /* otherwise fallback to capable() checks */
> > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_S=
YS_ADMIN));
> > +}
>
> This *feels* like it should be written as
>
>     bool bpf_token_capable(const struct bpf_token *token, int cap)
>     {
>         struct user_namespace *ns =3D &init_ns;
>
>         /* BPF token allows ns_capable() level of capabilities, but only =
if
>          * token's userns is *exactly* the same as current user's userns
>          */
>         if (token && current_user_ns() =3D=3D token->userns)
>                 ns =3D token->userns;
>         return ns_capable(ns, cap) ||
>                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
>     }
>
> And yes, I realize that the function will end up later growing a
>
>         security_bpf_token_capable(token, cap)
>
> test inside that 'if (token ..)' statement, and this would change the
> order of that test so that the LSM hook would now be done before the
> capability checks are done, but that all still seems just more of an
> argument for the simplification.

I have no problem with rewriting things, my only ask is that we stick
with the idea of doing the capability checks before the LSM hook.  The
DAC-before-MAC (capability-before-LSM) pattern is one we try to stick
to most everywhere in the kernel and deviating from it here could
potentially result in some odd/unexpected behavior from a user
perspective.

--=20
paul-moore.com

