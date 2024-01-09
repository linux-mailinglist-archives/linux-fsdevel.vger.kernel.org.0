Return-Path: <linux-fsdevel+bounces-7579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4384B827BDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 01:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720D01C231C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 00:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007A20FB;
	Tue,  9 Jan 2024 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxAZKkcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A117C3;
	Tue,  9 Jan 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557c188f313so2012569a12.1;
        Mon, 08 Jan 2024 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704758858; x=1705363658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUySmjIsH1ToYk/DO1r1tgP06Oaww11ce8VZTbFo34Q=;
        b=JxAZKkcwILY3AJzl/3O74LqvYqcA3605+7i85FDgSdbHXDPX8Q7DGbMnEtsFygQr0W
         lhZd/OIKH180diPa38Adngf29bNKeP54hiRFMMItFcTqIC5CvXFaQCPJ21C63NeCUPDL
         i6NwOYR2z+im/IrN84IjGnja58XSGltMLAM8mXlOCBAQ5RjQUfgxE2CHMaKzTW2RfCch
         7570sgE8sSsJq2VJVoIxE5c4RXv+1YQpR/xTFOTj9NZRNxxe73WOfFAPq0XPTe3VCuMP
         2xgCMeCM/IuDtl9cg0Jt732znlswtrZtWBEQ+00MQZQ5rLkhVUgFHEimI78AiwWJ0YSZ
         mhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758858; x=1705363658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUySmjIsH1ToYk/DO1r1tgP06Oaww11ce8VZTbFo34Q=;
        b=h8p/FwGs9KNRieDqZkm0ZTzSdZDdMIuFD+Y3OEnwcr5ElFW4OH8VyTkl8CCOv0J/cg
         0SSY/YVZCTuBOyKMRrKf7etdL6zKWYT9Qc052AbDABMdwkeIw41dgVjkKFpuKk6kv071
         nn/jLuOoep6segcUi+5k0vNZGK+dvIpPHJvITw7lRZH5kubdwzf7ObMtQ2r9l4gsEDhk
         lP2glSMsW3QekoOK+1Sx3L1wUfnePlTyUx/yAhe4lSNNLlGFJ8SfT+4oGrV7ixiwZtc6
         b8ugdWchX4xf7256g9kRIfdkOjennCZpmy1i4WSqWCintNnWAA1kRMf4/CxH4ZXZd4Mi
         ONZQ==
X-Gm-Message-State: AOJu0YzKErUQdczPI6uDXTJ1xby8KBRPbMTQ01fQQIm+6d5b/CK8y6c2
	Yvma4lVrbbjzzKykP/S/KfDZdGfSYmxi10BTwX0=
X-Google-Smtp-Source: AGHT+IEhZMahxE6XL79rn3qxvkTP/cFMykC14+MaP32XhB7A8NjWjyqurv88RNsV1NJ2Mo9tkD/G+zsebjNktJlHXRw=
X-Received: by 2002:a50:a6dd:0:b0:557:e3f:2cec with SMTP id
 f29-20020a50a6dd000000b005570e3f2cecmr525326edc.13.1704758857611; Mon, 08 Jan
 2024 16:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com> <CAHC9VhQg7mYnQw-o1TYon_bdtk_CMzJaf6u5FTPosniG-UXK1w@mail.gmail.com>
In-Reply-To: <CAHC9VhQg7mYnQw-o1TYon_bdtk_CMzJaf6u5FTPosniG-UXK1w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 16:07:25 -0800
Message-ID: <CAEf4BzYMrvtTjkBUWOk1TKi8qiBbwv1xv=eJeF3j3QrY1M=h3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:45=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jan 5, 2024 at 4:45=E2=80=AFPM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > +{
> > > +       /* BPF token allows ns_capable() level of capabilities, but o=
nly if
> > > +        * token's userns is *exactly* the same as current user's use=
rns
> > > +        */
> > > +       if (token && current_user_ns() =3D=3D token->userns) {
> > > +               if (ns_capable(token->userns, cap))
> > > +                       return true;
> > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->usern=
s, CAP_SYS_ADMIN))
> > > +                       return true;
> > > +       }
> > > +       /* otherwise fallback to capable() checks */
> > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP=
_SYS_ADMIN));
> > > +}
> >
> > This *feels* like it should be written as
> >
> >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> >     {
> >         struct user_namespace *ns =3D &init_ns;
> >
> >         /* BPF token allows ns_capable() level of capabilities, but onl=
y if
> >          * token's userns is *exactly* the same as current user's usern=
s
> >          */
> >         if (token && current_user_ns() =3D=3D token->userns)
> >                 ns =3D token->userns;
> >         return ns_capable(ns, cap) ||
> >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> >     }
> >
> > And yes, I realize that the function will end up later growing a
> >
> >         security_bpf_token_capable(token, cap)
> >
> > test inside that 'if (token ..)' statement, and this would change the
> > order of that test so that the LSM hook would now be done before the
> > capability checks are done, but that all still seems just more of an
> > argument for the simplification.
>
> I have no problem with rewriting things, my only ask is that we stick
> with the idea of doing the capability checks before the LSM hook.  The
> DAC-before-MAC (capability-before-LSM) pattern is one we try to stick
> to most everywhere in the kernel and deviating from it here could
> potentially result in some odd/unexpected behavior from a user
> perspective.

Makes sense, Paul. With the suggested rewrite we'll get an LSM call
before we get to ns_capable() (which we avoid doing in BPF code base,
generally speaking, after someone called this out earlier). Hmm...

I guess it will be better to keep this logic as is then, I believe it
was more of a subjective stylistical nit from Linus, so it probably is
ok to keep existing code.

Alternatively we could do something like:

struct user_namespace *ns =3D &init_ns;

if (token && current_user_ns() =3D=3D token->userns)
    ns =3D token->user_ns;
else
    token =3D NULL;

if (ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN && ns_capable(ns,
CAP_SYS_ADMIN)) {
    if (token)
        return security_bpf_token_capable(token, cap) =3D=3D 0;
    return true;
}
return false;

Or something along those lines? I don't particularly care (though the
latter seems a bit more ceremonious), so please let me know the
preference, if any.


>
> --
> paul-moore.com

