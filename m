Return-Path: <linux-fsdevel+bounces-7656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DC828D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930AE1C238B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBE3D0B4;
	Tue,  9 Jan 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdpB4K1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406A3B790;
	Tue,  9 Jan 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e4d64a3fbso13846545e9.2;
        Tue, 09 Jan 2024 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704826838; x=1705431638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx8GBTVs5mswmeyt0b01/3VTHzKEFdOZt0/R1S9sOsc=;
        b=YdpB4K1Bnatot7ane9Y4QgYQlL4JL+KlMV6qAV5xxdVgAz/aN2okrsZuHS0iDbhku0
         zZDlcwt63CiaLVxZm+tXWHgJWQ/o+7w3Y4nzw9WePej9+T6r1hUBdw44hoBkGV8i5ej6
         kdXT6mByAq/vEPEk6VEAxghumfyqSE9IO5AMY2/2LB039HzPuzQB3oOX7X9TkFCVfjCz
         pj4rlchegJe/prqCQlOnrHEqp4DkJbvzlWPvISU5pzE40tSBB7gTKtJ7jD6x73+iye1O
         IDd6P7dKjyC8BuCjlGhJdTqhbqETF/mJSCPLEALk0hrjbVNWBka66Yre7VJTQ8vhqCph
         GFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704826838; x=1705431638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx8GBTVs5mswmeyt0b01/3VTHzKEFdOZt0/R1S9sOsc=;
        b=lvsKfqAp6mLiHkX2S13xSZyu3RUGiQuM3vEhQUghyLiy+fpSGOszuJmL4HWMey6xS7
         mY3bpDs04c0AbtFn0gWgP/R3qGtoYrTqvuLQUS+28dLK1DKdeM48+szb+Oyi4CO0b6cZ
         CsPoz46XYzTTKIFxP5xh4E3Nachayo/0JlqFUzTDS8Ut1+R2S1wlYPeOTUf/txtAFJ/h
         jJPwjU/x6mHUEt2ag29gQ1wAllePrUOr0wqVREoSzkaFhYByyeCMMjOinmJ//qgoq709
         5k2aJpr9sMw9WxguqjbCHgDMxBY+pIkhR1zA0STxSAllslx+GVKbSy57TW2lUd9uWOCq
         qFLA==
X-Gm-Message-State: AOJu0YzasYzAUd2G1+piHc/6kCjqvDD0SvSWSyl8v8m3KrvVlNXT7sw2
	9KH3nL8IzCKGKwvM50Cdk1FHNFsvaYnX3/FT3CA=
X-Google-Smtp-Source: AGHT+IGlKRwFTJTKWnKOmeFZHbdmYT+lhILIqb3O0nrxrEju86bGrfKnIT0ssfQHh0/lKWfbxWlyVeBdnElSPPYCaT8=
X-Received: by 2002:a05:600c:1da7:b0:40e:5316:217b with SMTP id
 p39-20020a05600c1da700b0040e5316217bmr283413wms.44.1704826838033; Tue, 09 Jan
 2024 11:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner> <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner>
In-Reply-To: <20240109-tausend-tropenhelm-2a9914326249@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 11:00:24 -0800
Message-ID: <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:52=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Jan 08, 2024 at 03:58:47PM -0800, Andrii Nakryiko wrote:
> > On Mon, Jan 8, 2024 at 4:02=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Jan 05, 2024 at 02:18:40PM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Jan 5, 2024 at 1:45=E2=80=AFPM Linus Torvalds
> > > > <torvalds@linuxfoundation.org> wrote:
> > > > >
> > > > > Ok, I've gone through the whole series now, and I don't find anyt=
hing
> > > > > objectionable.
> > > >
> > > > That's great, thanks for reviewing!
> > > >
> > > > >
> > > > > Which may only mean that I didn't notice something, of course, bu=
t at
> > > > > least there's nothing I'd consider obvious.
> > > > >
> > > > > I keep coming back to this 03/29 patch, because it's kind of the =
heart
> > > > > of it, and I have one more small nit, but it's also purely stylis=
tic:
> > > > >
> > > > > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> =
wrote:
> > > > > >
> > > > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > > +{
> > > > > > +       /* BPF token allows ns_capable() level of capabilities,=
 but only if
> > > > > > +        * token's userns is *exactly* the same as current user=
's userns
> > > > > > +        */
> > > > > > +       if (token && current_user_ns() =3D=3D token->userns) {
> > > > > > +               if (ns_capable(token->userns, cap))
> > > > > > +                       return true;
> > > > > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token-=
>userns, CAP_SYS_ADMIN))
> > > > > > +                       return true;
> > > > > > +       }
> > > > > > +       /* otherwise fallback to capable() checks */
> > > > > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capab=
le(CAP_SYS_ADMIN));
> > > > > > +}
> > > > >
> > > > > This *feels* like it should be written as
> > > > >
> > > > >     bool bpf_token_capable(const struct bpf_token *token, int cap=
)
> > > > >     {
> > > > >         struct user_namespace *ns =3D &init_ns;
> > > > >
> > > > >         /* BPF token allows ns_capable() level of capabilities, b=
ut only if
> > > > >          * token's userns is *exactly* the same as current user's=
 userns
> > > > >          */
> > > > >         if (token && current_user_ns() =3D=3D token->userns)
> > > > >                 ns =3D token->userns;
> > > > >         return ns_capable(ns, cap) ||
> > > > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)=
);
> > > > >     }
> > > > >
> > > > > And yes, I realize that the function will end up later growing a
> > > > >
> > > > >         security_bpf_token_capable(token, cap)
> > > > >
> > > > > test inside that 'if (token ..)' statement, and this would change=
 the
> > > > > order of that test so that the LSM hook would now be done before =
the
> > > > > capability checks are done, but that all still seems just more of=
 an
> > > > > argument for the simplification.
> > > > >
> > > > > So the end result would be something like
> > > > >
> > > > >     bool bpf_token_capable(const struct bpf_token *token, int cap=
)
> > > > >     {
> > > > >         struct user_namespace *ns =3D &init_ns;
> > > > >
> > > > >         if (token && current_user_ns() =3D=3D token->userns) {
> > > > >                 if (security_bpf_token_capable(token, cap) < 0)
> > > > >                         return false;
> > > > >                 ns =3D token->userns;
> > > > >         }
> > > > >         return ns_capable(ns, cap) ||
> > > > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)=
);
> > > > >     }
> > > >
> > > > Yep, it makes sense to use ns_capable with init_ns. I'll change tho=
se
> > > > two patches to end up with something like what you suggested here.
> > > >
> > > > >
> > > > > although I feel that with that LSM hook, maybe this all should re=
turn
> > > > > the error code (zero or negative), not a bool for success?
> > > > >
> > > > > Also, should "current_user_ns() !=3D token->userns" perhaps be an=
 error
> > > > > condition, rather than a "fall back to init_ns" condition?
> > > > >
> > > > > Again, none of this is a big deal. I do think you're dropping the=
 LSM
> > > > > error code on the floor, and are duplicating the "ns_capable()" v=
s
> > > > > "capable()" logic as-is, but none of this is a deal breaker, just=
 more
> > > > > of my commentary on the patch and about the logic here.
> > > > >
> > > > > And yeah, I don't exactly love how you say "ok, if there's a toke=
n and
> > > > > it doesn't match, I'll not use it" rather than "if the token name=
space
> > > > > doesn't match, it's an error", but maybe there's some usability i=
ssue
> > > > > here?
> > > >
> > > > Yes, usability was the primary concern. The overall idea with BPF
> > >
> > > NAK on not restricting this to not erroring out on current_user_ns()
> > > !=3D token->user_ns. I've said this multiple times before.
> >
> > I do restrict token usage to *exact* userns in which the token was
> > created. See bpf_token_capable()'s
> >
> > if (token && current_user_ns() =3D=3D token->userns) { ... }
> >
> > and in bpf_token_allow_cmd():
> >
> > if (!token || current_user_ns() !=3D token->userns)
> >     return false;
> >
> > So I followed what you asked in [1] (just like I said I will in [2]),
> > unless I made some stupid mistake which I cannot even see.
> >
> >
> > What we are discussing here is a different question. It's the
> > difference between erroring out (that is, failing whatever BPF
> > operation was attempted with such token, i.e., program loading or map
> > creation) vs ignoring the token altogether and just using
> > init_ns-based capable() checks. And the latter is vastly more user
>
> Look at this:
>
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +       /* BPF token allows ns_capable() level of capabilities, but only =
if
> +        * token's userns is *exactly* the same as current user's userns
> +        */
> +       if (token && current_user_ns() =3D=3D token->userns) {
> +               if (ns_capable(token->userns, cap))
> +                       return true;
> +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, C=
AP_SYS_ADMIN))
> +                       return true;
> +       }
> +       /* otherwise fallback to capable() checks */
> +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS=
_ADMIN));
> +}
>
> How on earth is it possible that the calling task is in a user namespace
> aka current_user_ns() =3D=3D token->userns while at the same time being
> capable in the initial user namespace? When you enter an
> unprivileged user namespace you lose all capabilities against your
> ancestor user namespace and you can't reenter your ancestor user
> namespace.
>
> IOW, if current_user_ns() =3D=3D token->userns and token->userns !=3D
> init_user_ns, then current_user_ns() !=3D init_user_ns. And therefore tha=
t
> thing is essentially always false for all interesting cases, no?
>

Are you saying that this would be better?

   if (token && current_user_ns() =3D=3D token->userns) {
       if (ns_capable(token->userns, cap))
           return true;
       if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMI=
N))
           return true;
       if (token->userns !=3D &init_user_ns)
           return false;
   }
   /* otherwise fallback to capable() checks */
   return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)=
);


I.e., return false directly if token's userns is not initns (there
will be also LSM check before this condition later on)? Falling back
to capable() checks and letting it return false if we are not in
init_ns or don't have capabilities seemed fine to me, that's all.


> Aside from that it would be semantically completely unclean. The user
> has specified a token and permission checking should be based on that
> token and not magically fallback to a capable check in the inital user
> namespace even if that worked.

I tried to explain the higher-level integration setup in [0]. The
thing is that users most of the time won't be explicitly passing a
token, BPF library will be passing it, if /sys/fs/bpf happens to be
mounted with delegation options.

So I wanted to avoid potential regressions (unintended and avoidable
failures) from using BPF token, because it might be hard to tell if a
BPF token is "beneficial" and is granting required permissions
(especially if you take into account LSM interactions). So I
consistently treat BPF token as optional/add-on permissions, not the
replacement for capable() checks.

It's true that it's unlikely that BPF token will be set up in init_ns
(except for testing, perhaps), but is it a reason to return -EPERM
without doing the same checks that would be done if BPF token wasn't
provided?


  [0] https://lore.kernel.org/bpf/CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+=
6xigZtsTkA@mail.gmail.com/

>
> Because the only scenario where that is maybe useful is if an
> unprivileged container has dropped _both_ CAP_BPF and CAP_SYS_ADMIN from
> the user namespace of the container.
>
> First of, why? What thread model do you have then? Second, if you do
> stupid stuff like that then you don't get bpf in the container via bpf
> tokens. Period.
>
> Restrict the meaning and validity of a bpf token to the user namespace
> and do not include escape hatches such as this. Especially not in this
> initial version, please.

This decision fundamentally changes how BPF loader libraries like
libbpf will have to approach BPF token integration. It's not a small
thing and not something that will be easy to change later.

>
> I'm not trying to be difficult but it's clear that the implications of
> user namespaces aren't well understood here. And historicaly they are

I don't know why you are saying this. You haven't pointed out anything
that is actually broken in the existing implementation. Sure, you
might not be a fan of the approach, but is there anything
*technically* wrong with ignoring BPF token if it doesn't provide
necessary permissions for BPF operation and consistently using the
checks that would be performed with BPF token?

> exploit facilitators as much as exploit preventers.

