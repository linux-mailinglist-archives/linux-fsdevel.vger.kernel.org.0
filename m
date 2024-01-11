Return-Path: <linux-fsdevel+bounces-7808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1882B447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAED1C20D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D752F82;
	Thu, 11 Jan 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWTcBB+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BA51C4C;
	Thu, 11 Jan 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so9924119a12.0;
        Thu, 11 Jan 2024 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704994897; x=1705599697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuJEDEzgsrAlWEpcwu29d3X8FwhM96NJmWu9mpjiNXc=;
        b=eWTcBB+y9ICxnyTcYgvG4iB/1/cnj9t8CHfI+rS9fXZkODjUo2QrEqDKWi5aQYjySJ
         HAJEI8ff2Qt0759yyz4buRfXBKRK9ll67QABHyiqiVBHuNhRLTZAajOalTtiV+bw7IIT
         DL6zTiEiSiDNHj71EEegNqauuGlXdKhJfILs5adXh1lYA++ApWB7+arKbmAH0dWS+jiN
         P0L6twkxMki+jIK1CZL1H9o3QyzQecfVsN4Eenscc+rN/QuLka8BTZsR367qurNkKKJE
         6AI8TWWv/LC2n7g7ClAfCNOdq61CxWkVYu6ys7BF5+k3h2yLDyJ4//bQCYts3sarT+at
         2Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994897; x=1705599697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuJEDEzgsrAlWEpcwu29d3X8FwhM96NJmWu9mpjiNXc=;
        b=RIKgPOaZICZ1qSRw0b2RjrMIk2LAOa6A6+vKC4eOzKdxNLzDFYGmCWuy3uljzl51DM
         HzX9IjdVXkn3M3ZMpGlc8TqsHHyOwFy3+WwntVumX5MYu4qYWbbsQWZvpmKtonjKCo3t
         EpEx5CuH2V7NClCaEyBgpJCxqnjB9l9dTacgGld8sTdGnL2WENNKSElKzWgHmnPBY2Hi
         zd2wHNAJieuxV8PhCJI5hr+n2tCnhFe3pvkVVwbQE3mGlfiAbBjpqqTHfeUOxqIUNmQk
         aqeMOTP25brzokMiy7el1OEJHgZ1REHo8hP0jMnjGD0Mvc3xa23+wyCUFFNDwzzIK7PU
         wcEw==
X-Gm-Message-State: AOJu0Yx/CRUN8u98XQ/WjstPrz05qPX5QyLjQ4HmH72ZAEhvEdIbt0Rp
	lpQY6Q9y5I6oWXdlm+uJVHMuG9FSpShncdjI4YU=
X-Google-Smtp-Source: AGHT+IH8ewJTHtdgd/w1SUvdMSS/sACCnnMmuT/t/C9EGuj1sCMr8S+hOphcsCg3XXTz6hu+mKfCQ2Wtt2MEs/f8eJ4=
X-Received: by 2002:a50:ec82:0:b0:554:4bb2:9a6e with SMTP id
 e2-20020a50ec82000000b005544bb29a6emr205632edr.11.1704994897361; Thu, 11 Jan
 2024 09:41:37 -0800 (PST)
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
 <20240109-tausend-tropenhelm-2a9914326249@brauner> <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner> <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner>
In-Reply-To: <20240111-amten-stiefel-043027f9520f@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 11 Jan 2024 09:41:25 -0800
Message-ID: <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 2:38=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > > The current check is inconsisent. It special-cases init_user_ns. The
> > > correct thing to do for what you're intending imho is:
> > >
> > > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > {
> > >         struct user_namespace *userns =3D &init_user_ns;
> > >
> > >         if (token)
> > >                 userns =3D token->userns;
> > >         if (ns_capable(userns, cap))
> > >                 return true;
> > >         return cap !=3D CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_A=
DMIN))
> > >
> > > }
> >
> > Unfortunately the above becomes significantly more hairy when LSM
> > (security_bpf_token_capable) gets involved, while preserving the rule
> > "if token doesn't give rights, fall back to init userns checks".
>
> Why? Please explain your reasoning in detail.

Why which part? About LSM interaction making this much hairier? Then see be=
low.

But if your "why?" is about "pretend no token, if token doesn't give
rights", then that's what I tried to explain in my last email(s). It
significantly alters (for the worse) user-space integration story
(providing a token can be a regression, so now it's not safe to
opportunistically try to create and use BPF token; on the other hand,
automatically retrying inside libbpf makes for confusing user
experience and inefficiencies). Please let me know which parts are not
clear.

>
> >
> > I'm happy to accommodate any implementation of bpf_token_capable() as
> > long as it behaves as discussed above and also satisfies Paul's
> > requirement that capability checks should happen before LSM checks.
> >
> > >
> > > Because any caller located in an ancestor user namespace of
> > > token->user_ns will be privileged wrt to the token's userns as long a=
s
> > > they have that capability in their user namespace.
> >
> > And with `current_user_ns() =3D=3D token->userns` check we won't be usi=
ng
> > token->userns while the caller is in ancestor user namespace, we'll
> > use capable() check, which will succeed only in init user_ns, assuming
> > corresponding CAP_xxx is actually set.
>
> Why? This isn't how any of our ns_capable() logic works.
>
> This basically argues that anyone in an ancestor user namespace is not
> allowed to operate on any of their descendant child namespaces unless
> they are in the init_user_ns.
>
> But that's nonsense as I'm trying to tell you. Any process in an
> ancestor user namespace that is privileged over the child namespace can
> just setns() into it and then pass that bpf_token_capable() check by
> supplying the token.
>
> At this point just do it properly and allow callers that are privileged
> in the token user namespace to load bpf programs. It also means you get
> user namespace nesting done properly.

Ok, I see. This `current_user_ns() =3D=3D token->userns` check prevents
this part of cap_capable() to ever be exercised:

 if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))
    return 0;

Got it. I'm all for not adding any unnecessary restrictions.

>
> >
> > >
> > > For example, if the caller is in the init_user_ns and permissions
> > > for CAP_WHATEVER is checked for in token->user_ns and the caller has
> > > CAP_WHATEVER in init_user_ns then they also have it in all
> > > descendant user namespaces.
> >
> > Right, so if they didn't use a token they would still pass
> > capable(CAP_WHATEVER), right?
>
> Yes, I'm trying to accomodate your request but making it work
> consistently.
>
> >
> > >
> > > The original intention had been to align with what we require during
> > > token creation meaning that once a token has been created interacting
> > > with this token is specifically confined to caller's located in the
> > > token's user namespace.
> > >
> > > If that's not the case then it doesn't make sense to not allow
> > > permission checking based on regular capability semantics. IOW, why
> > > special case init_user_ns if you're breaking the confinement restrict=
ion
> > > anyway.
> >
> > I'm sorry, perhaps I'm dense, but with `current_user_ns() =3D=3D
> > token->userns` check I think we do fulfill the intention to not allow
> > using a token in a userns different from the one in which it was
> > created. If that condition isn't satisfied, the token is immediately
>
> My request originally was about never being able to interact with a
> token outside of that userns. This is different as you provide an escape
> hatch to init_user_ns. But if you need that and ignore the token then
> please do it properly. That's what I'm trying to tell you. See below.

Yes, I do need that. Thanks for providing the full code implementation
(including LSM), it's much easier this way to converge. Let's see
below.

>
> > ignored. So you can't use a token from another userns for anything,
> > it's just not there, effectively.
> >
> > And as I tried to explain above, I do think that ignoring the token
> > instead of erroring out early is what we want to provide good
> > user-space ecosystem integration of BPF token.
>
> There is no erroring out early in. It's:
>
> (1) Has a token been provided and is the caller capable wrt to the
>     namespace of the token? Any caller in an ancestor user namespace
>     that has the capability in that user namespace is capable wrt to
>     that token. That __includes__ a callers in the init_user_ns. IOW,
>     you don't need to fallback to any special checking for init_user_ns.
>     It is literally covered in the if (token) branch with the added
>     consistency that a process in an ancestor user namespace is
>     privileged wrt to that token as well.
>
> (2) No token has been provided. Then do what we always did and perform
>     the capability checks based on the initial user namespace.
>
> The only thing that you then still need is add that token_capable() hook
> in there:
>
> bool bpf_token_capable(const struct bpf_token *token, int cap)
> {
>         bool has_cap;
>         struct user_namespace *userns =3D &init_user_ns;
>
>         if (token)
>                 userns =3D token->userns;
>         if (ns_capable(userns, cap))

Here, we still need to check security_bpf_token_capable(token, cap)
result (and only if token !=3D NULL). And if LSM returns < 0, then drop
the token and do the original init userns check.

And I just realized that my original implementation has the same
problem. In my current implementation if we have a token we will
terminate at LSM call, regardless if LSM allows or disallows the
token. But that's inconsistent behavior and shouldn't be like that.

I will add new tests that validate LSM interactions in the next revision.

>                 return true;
>         if (cap !=3D CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))
>                 return token ? security_bpf_token_capable(token, cap) =3D=
=3D 0 : true;

here as well, even if we have a token which passes ns_capable() check,
but LSM rejects this token, we still need to forget about the token
and do capable() checks in init userns.

>         return false;
> }
>
> Or write it however you like. I think this is way more consistent and
> gives you a more flexible permission model.

Yes, I like it, thanks. Taking into account fixed LSM interactions,
here's what I came up with. Yell if you can spot anything wrong (or
just hate the style). I did have a version without extra function,
just setting the token to NULL and "goto again" approach, but I think
it's way less readable and harder to follow. So this is my version
right now:

static bool bpf_ns_capable(struct user_namespace *ns, int cap)
{
        return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN &&
ns_capable(ns, CAP_SYS_ADMIN));
}

static bool token_capable(const struct bpf_token *token, int cap)
{
        struct user_namespace *userns;

        userns =3D token ? token->userns : &init_user_ns;
        if (!bpf_ns_capable(userns, cap))
                return false;
        if (token && security_bpf_token_capable(token, cap) < 0)
                return false;
        return true;
}

bool bpf_token_capable(const struct bpf_token *token, int cap)
{
        /* BPF token allows ns_capable() level of capabilities, but if it
         * doesn't grant required capabilities, ignore token and fallback t=
o
         * init userns-based checks
         */
        if (token && token_capable(token, cap))
                return true;
        return token_capable(NULL, cap);
}

