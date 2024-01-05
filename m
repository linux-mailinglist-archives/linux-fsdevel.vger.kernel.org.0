Return-Path: <linux-fsdevel+bounces-7495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BEE825C73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4927B285B31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88747358B3;
	Fri,  5 Jan 2024 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8dPLBfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E72E855;
	Fri,  5 Jan 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so133071fa.2;
        Fri, 05 Jan 2024 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704493132; x=1705097932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkPTh46pRsjNQCsVTiCDEUWk5jfBj4ByCJ4W9yBlF4M=;
        b=i8dPLBfOGO/0OoXzhuvKvw8xvRpD54ydr5UWp/tJPjVlunzCdM48x957kkQ3FGOqSC
         +QFPvoNgUe3piPeou7D4GkC70UDM3JaBgDjRvDf0IjHPMuO/oGpNze35/Iz2bJiuJa6W
         Dlf809LpJ3Emi8o9l6JPciIrzuUd1q0csg6NYjFzLIjdex8+NEf1PSpaSQ2De+SSgmmC
         yaSJl9tRufuo0j3cFlY4OOxdfy39T15sXpmITWI7cCxzF7gqzWPqsNkrsiiNUyCAuf+T
         k2534IkDfN6clk3T63hKBszlHh2jFRqmGGmNt0HHHKlJSWor5ZRa8AlsQhUgPdJ/fWCa
         U1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493132; x=1705097932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkPTh46pRsjNQCsVTiCDEUWk5jfBj4ByCJ4W9yBlF4M=;
        b=Vb6kVNFNDIpFff1HWcC0/koeB3/kwjoj9DKL7U/xDAkjA8jLn8Xwd6+QfLsZssT2gC
         PqFC1W2WMFBk9N2Q4WLelDSQKE6Sf0lNhjUQnhsO16/JpuaVx66NUpD3N3J/HUTp68I/
         6fkcNVhWD0a6a9z3qJtEU/b60qj6IQ6seZNtBNBjdw6Jb7avGAmIQRfjtOl1/I0G2sfw
         fW047/rmwMJK5sbJPlfw8Rtch7KkOUZTs17S7CxUDBvdChKqfQkOw5ZyI9kXv8lX35Q0
         Wb+ccTv31Ms+nFBkxrE+m8RWPXldtFznbCMXGcz2hrfdHD6ugCTzBdz4f89jQsNS4BH8
         1H/A==
X-Gm-Message-State: AOJu0YyCIZYy8N2bE/UvpwpGalMq/xen5ZKsP25ZkFYpgxEp4uF6RX6Q
	0hbS/kq8cWS3QHJi0hVvlQcq/Pj5B5JcV+av4Lw=
X-Google-Smtp-Source: AGHT+IHTF9qLfrk+MfstI1+n/BLRASDQfOsfErxjCd02+nlXXqLZJO0oLB90qi8DJcVBrkW4L+1WLmrp2pIO2ThPye8=
X-Received: by 2002:a2e:8e97:0:b0:2cd:1de9:dfe9 with SMTP id
 z23-20020a2e8e97000000b002cd1de9dfe9mr12020ljk.65.1704493131990; Fri, 05 Jan
 2024 14:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
In-Reply-To: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Jan 2024 14:18:40 -0800
Message-ID: <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:45=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Ok, I've gone through the whole series now, and I don't find anything
> objectionable.

That's great, thanks for reviewing!

>
> Which may only mean that I didn't notice something, of course, but at
> least there's nothing I'd consider obvious.
>
> I keep coming back to this 03/29 patch, because it's kind of the heart
> of it, and I have one more small nit, but it's also purely stylistic:
>
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
>
> So the end result would be something like
>
>     bool bpf_token_capable(const struct bpf_token *token, int cap)
>     {
>         struct user_namespace *ns =3D &init_ns;
>
>         if (token && current_user_ns() =3D=3D token->userns) {
>                 if (security_bpf_token_capable(token, cap) < 0)
>                         return false;
>                 ns =3D token->userns;
>         }
>         return ns_capable(ns, cap) ||
>                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
>     }

Yep, it makes sense to use ns_capable with init_ns. I'll change those
two patches to end up with something like what you suggested here.

>
> although I feel that with that LSM hook, maybe this all should return
> the error code (zero or negative), not a bool for success?
>
> Also, should "current_user_ns() !=3D token->userns" perhaps be an error
> condition, rather than a "fall back to init_ns" condition?
>
> Again, none of this is a big deal. I do think you're dropping the LSM
> error code on the floor, and are duplicating the "ns_capable()" vs
> "capable()" logic as-is, but none of this is a deal breaker, just more
> of my commentary on the patch and about the logic here.
>
> And yeah, I don't exactly love how you say "ok, if there's a token and
> it doesn't match, I'll not use it" rather than "if the token namespace
> doesn't match, it's an error", but maybe there's some usability issue
> here?

Yes, usability was the primary concern. The overall idea with BPF
token is to make most BPF applications not care or even potentially
know about its existence, and mostly leave it up to administrators
and/or container managers to set up an environment with BPF token
delegation. To make that all possible, libbpf will opportunistically
try to create BPF token from BPF FS in the container (typically
/sys/fs/bpf, but it can be tuned, of course). And so if BPF token can
actually prevent, say, BPF program loading, because it didn't allow
particular program type to be loaded or whatnot, that would be a
regression of behavior relative to if BPF token was never even used.

So I consciously wanted a behavior in which BPF token can be used as a
sort of potential/additional rights, but otherwise just fallback to
current behavior based on capable(CAP_BPF) and other caps we use.

The alternative to the above would be creating a few more APIs to
proactively check if a given BPF token instance would allow whatever
operation libbpf needs to perform, and if not, not using it. Which
would be used to achieve the exact same behavior but in a more round
about way.

And the last piece of thinking was that if the user actually would
want to fail bpf() operation if the BPF token doesn't grant such
permissions, we can add a flag that would force this behavior. Some
sort of BPF_F_TOKEN_STRICT that can be optionally specified. But I
wanted to wait for an actual production use case that would want that
(I'm not aware of any right now).

>
>               Linus

