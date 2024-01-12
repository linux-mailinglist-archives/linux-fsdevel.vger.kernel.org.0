Return-Path: <linux-fsdevel+bounces-7884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D777482C576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D977D1C22520
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B9154B3;
	Fri, 12 Jan 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRFvabBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DC13FFE;
	Fri, 12 Jan 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so11686765e9.2;
        Fri, 12 Jan 2024 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705084337; x=1705689137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpqRB1614g5tUp1aYWmZo26QvKU2c2x1mRxbJyJjzvo=;
        b=jRFvabBxHNthKyJyRtETnK0ZI7rbD+3nQytdOR1IUGdjRZy10HvXxiF/8BPQRRcjxp
         2utjbjlkC8n7pu0QqAKyrzoDjNL4RxzyZfAt/zA/Q+mqVYOwKh2aRT5SRjvqjTy7LiZa
         b+PkbR31obesIgBSEfbGwdITK5kUGXnRpwtdY4xo/7ShCsHCmoYLVxWyX9OcMkIImzei
         QN8lepsVvzE7G3gxXrUGm109eWI0kLIh6v6yXRmb1Dr+fjrq1M1qZf/6GmSFKHfir+Go
         Cid15sFy+kuM0R97/vteEdu/AyIegovF3OMSUiqO0iCiacGgQIt1FRRjpJTvYjQ06t8q
         OuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084337; x=1705689137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpqRB1614g5tUp1aYWmZo26QvKU2c2x1mRxbJyJjzvo=;
        b=RKH93VP4pBCxiAbYOFjEOFQ71f2kzzbbiawM4nu9tcF+fgGiL4JeIO28tusdxTF5Gb
         sHTKvBLP3U5mXQkgTQg3wqjcgfz3pNvr++r8srf6leZVKt9HxkV3KPIrl3uM5m3eYnwa
         gWxQ7BkWWl92aZQ7XqEe9mWTIwVYSWezjnLYsYlmVuHZF3MeS6RwL332mC59F1c2nDss
         F0zn8B8LVqm1TIgFrYCEXFY/CtlihUpN7Dk3EZwz6yhLUnBThZzqt6zWfp6/nzdsbHyV
         Kt6WbjEEf3D8UTITpkRUJqV8zPsCLYl3JLGGX09w2+fR5oYi2cGTWjXLXueHc6tukPpB
         TPJQ==
X-Gm-Message-State: AOJu0YxUCZ5KH27D4fop8YKo3s/djcDqqA4FhfkdBy3cnhhu/e84g7ir
	H9WQJ8Y/d4L+wOa2TLulffE3VGSTzflQILyF1ZU=
X-Google-Smtp-Source: AGHT+IEDhuxRAnzPSdN608BtoR39g6RJ9qyf1xHFrz+8rRDF67p6wl+4OWxugNeOqGsZVxW7AJfOXGgL7HAfRPMKBS4=
X-Received: by 2002:a7b:c4cb:0:b0:40d:87b7:24c7 with SMTP id
 g11-20020a7bc4cb000000b0040d87b724c7mr1043025wmk.125.1705084336638; Fri, 12
 Jan 2024 10:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner> <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner> <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner> <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner> <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
 <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner>
In-Reply-To: <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jan 2024 10:32:03 -0800
Message-ID: <CAEf4Bza7UKjv1Hh_kcyBVJw22LDv4ZNA5uV7+WBdnhsM9O7uGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:58=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Jan 11, 2024 at 09:41:25AM -0800, Andrii Nakryiko wrote:
> > On Thu, Jan 11, 2024 at 2:38=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > > > The current check is inconsisent. It special-cases init_user_ns. =
The
> > > > > correct thing to do for what you're intending imho is:
> > > > >
> > > > > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > {
> > > > >         struct user_namespace *userns =3D &init_user_ns;
> > > > >
> > > > >         if (token)
> > > > >                 userns =3D token->userns;
> > > > >         if (ns_capable(userns, cap))
> > > > >                 return true;
> > > > >         return cap !=3D CAP_SYS_ADMIN && ns_capable(userns, CAP_S=
YS_ADMIN))
> > > > >
> > > > > }
> > > >
> > > > Unfortunately the above becomes significantly more hairy when LSM
> > > > (security_bpf_token_capable) gets involved, while preserving the ru=
le
> > > > "if token doesn't give rights, fall back to init userns checks".
> > >
> > > Why? Please explain your reasoning in detail.
> >
> > Why which part? About LSM interaction making this much hairier? Then se=
e below.
> >
> > But if your "why?" is about "pretend no token, if token doesn't give
> > rights", then that's what I tried to explain in my last email(s). It
> > significantly alters (for the worse) user-space integration story
> > (providing a token can be a regression, so now it's not safe to
> > opportunistically try to create and use BPF token; on the other hand,
> > automatically retrying inside libbpf makes for confusing user
> > experience and inefficiencies). Please let me know which parts are not
> > clear.
> >
> > >
> > > >
> > > > I'm happy to accommodate any implementation of bpf_token_capable() =
as
> > > > long as it behaves as discussed above and also satisfies Paul's
> > > > requirement that capability checks should happen before LSM checks.
> > > >
> > > > >
> > > > > Because any caller located in an ancestor user namespace of
> > > > > token->user_ns will be privileged wrt to the token's userns as lo=
ng as
> > > > > they have that capability in their user namespace.
> > > >
> > > > And with `current_user_ns() =3D=3D token->userns` check we won't be=
 using
> > > > token->userns while the caller is in ancestor user namespace, we'll
> > > > use capable() check, which will succeed only in init user_ns, assum=
ing
> > > > corresponding CAP_xxx is actually set.
> > >
> > > Why? This isn't how any of our ns_capable() logic works.
> > >
> > > This basically argues that anyone in an ancestor user namespace is no=
t
> > > allowed to operate on any of their descendant child namespaces unless
> > > they are in the init_user_ns.
> > >
> > > But that's nonsense as I'm trying to tell you. Any process in an
> > > ancestor user namespace that is privileged over the child namespace c=
an
> > > just setns() into it and then pass that bpf_token_capable() check by
> > > supplying the token.
> > >
> > > At this point just do it properly and allow callers that are privileg=
ed
> > > in the token user namespace to load bpf programs. It also means you g=
et
> > > user namespace nesting done properly.
> >
> > Ok, I see. This `current_user_ns() =3D=3D token->userns` check prevents
> > this part of cap_capable() to ever be exercised:
> >
> >  if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid)=
)
> >     return 0;
> >
> > Got it. I'm all for not adding any unnecessary restrictions.
> >
> > >
> > > >
> > > > >
> > > > > For example, if the caller is in the init_user_ns and permissions
> > > > > for CAP_WHATEVER is checked for in token->user_ns and the caller =
has
> > > > > CAP_WHATEVER in init_user_ns then they also have it in all
> > > > > descendant user namespaces.
> > > >
> > > > Right, so if they didn't use a token they would still pass
> > > > capable(CAP_WHATEVER), right?
> > >
> > > Yes, I'm trying to accomodate your request but making it work
> > > consistently.
> > >
> > > >
> > > > >
> > > > > The original intention had been to align with what we require dur=
ing
> > > > > token creation meaning that once a token has been created interac=
ting
> > > > > with this token is specifically confined to caller's located in t=
he
> > > > > token's user namespace.
> > > > >
> > > > > If that's not the case then it doesn't make sense to not allow
> > > > > permission checking based on regular capability semantics. IOW, w=
hy
> > > > > special case init_user_ns if you're breaking the confinement rest=
riction
> > > > > anyway.
> > > >
> > > > I'm sorry, perhaps I'm dense, but with `current_user_ns() =3D=3D
> > > > token->userns` check I think we do fulfill the intention to not all=
ow
> > > > using a token in a userns different from the one in which it was
> > > > created. If that condition isn't satisfied, the token is immediatel=
y
> > >
> > > My request originally was about never being able to interact with a
> > > token outside of that userns. This is different as you provide an esc=
ape
> > > hatch to init_user_ns. But if you need that and ignore the token then
> > > please do it properly. That's what I'm trying to tell you. See below.
> >
> > Yes, I do need that. Thanks for providing the full code implementation
> > (including LSM), it's much easier this way to converge. Let's see
> > below.
> >
> > >
> > > > ignored. So you can't use a token from another userns for anything,
> > > > it's just not there, effectively.
> > > >
> > > > And as I tried to explain above, I do think that ignoring the token
> > > > instead of erroring out early is what we want to provide good
> > > > user-space ecosystem integration of BPF token.
> > >
> > > There is no erroring out early in. It's:
> > >
> > > (1) Has a token been provided and is the caller capable wrt to the
> > >     namespace of the token? Any caller in an ancestor user namespace
> > >     that has the capability in that user namespace is capable wrt to
> > >     that token. That __includes__ a callers in the init_user_ns. IOW,
> > >     you don't need to fallback to any special checking for init_user_=
ns.
> > >     It is literally covered in the if (token) branch with the added
> > >     consistency that a process in an ancestor user namespace is
> > >     privileged wrt to that token as well.
> > >
> > > (2) No token has been provided. Then do what we always did and perfor=
m
> > >     the capability checks based on the initial user namespace.
> > >
> > > The only thing that you then still need is add that token_capable() h=
ook
> > > in there:
> > >
> > > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > {
> > >         bool has_cap;
> > >         struct user_namespace *userns =3D &init_user_ns;
> > >
> > >         if (token)
> > >                 userns =3D token->userns;
> > >         if (ns_capable(userns, cap))
> >
> > Here, we still need to check security_bpf_token_capable(token, cap)
> > result (and only if token !=3D NULL). And if LSM returns < 0, then drop
> > the token and do the original init userns check.
> >
> > And I just realized that my original implementation has the same
> > problem. In my current implementation if we have a token we will
> > terminate at LSM call, regardless if LSM allows or disallows the
> > token. But that's inconsistent behavior and shouldn't be like that.
> >
> > I will add new tests that validate LSM interactions in the next revisio=
n.
> >
> > >                 return true;
> > >         if (cap !=3D CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMI=
N))
> > >                 return token ? security_bpf_token_capable(token, cap)=
 =3D=3D 0 : true;
> >
> > here as well, even if we have a token which passes ns_capable() check,
> > but LSM rejects this token, we still need to forget about the token
> > and do capable() checks in init userns.
> >
> > >         return false;
> > > }
> > >
> > > Or write it however you like. I think this is way more consistent and
> > > gives you a more flexible permission model.
> >
> > Yes, I like it, thanks. Taking into account fixed LSM interactions,
> > here's what I came up with. Yell if you can spot anything wrong (or
> > just hate the style). I did have a version without extra function,
> > just setting the token to NULL and "goto again" approach, but I think
> > it's way less readable and harder to follow. So this is my version
> > right now:
> >
> > static bool bpf_ns_capable(struct user_namespace *ns, int cap)
> > {
> >         return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN &&
> > ns_capable(ns, CAP_SYS_ADMIN));
> > }
> >
> > static bool token_capable(const struct bpf_token *token, int cap)
> > {
> >         struct user_namespace *userns;
> >
> >         userns =3D token ? token->userns : &init_user_ns;
> >         if (!bpf_ns_capable(userns, cap))
> >                 return false;
> >         if (token && security_bpf_token_capable(token, cap) < 0)
> >                 return false;
> >         return true;
> > }
> >
> > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > {
> >         /* BPF token allows ns_capable() level of capabilities, but if =
it
> >          * doesn't grant required capabilities, ignore token and fallba=
ck to
> >          * init userns-based checks
> >          */
> >         if (token && token_capable(token, cap))
> >                 return true;
> >         return token_capable(NULL, cap);
> > }
>
> My point is that the capable logic will walk upwards the user namespace
> hierarchy from the token->userns until the user namespace of the caller
> and terminate when it reached the init_user_ns.
>
> A caller is located in some namespace at the point where they call this
> function. They provided a token. The caller isn't capable in the
> namespace of the token so the function falls back to init_user_ns. Two
> interesting cases:
>
> (1) The caller wasn't in an ancestor userns of the token. If that's the
>     case then it follows that the caller also wasn't in the init_user_ns
>     because the init_user_ns is a descendant of all other user
>     namespaces. So falling back will fail.

agreed

>
> (2) The caller was in the same or an ancestor user namespace of the
>     token but didn't have the capability in that user namespace:
>
>      (i) They were in a non-init_user_ns. Therefore they can't be
>          privileged in init_user_ns.
>     (ii) They were in init_user_ns. Therefore, they lacked privileges in
>          the init_user_ns.
>
> In both cases your fallback will do nothing iiuc.

agreed as well

And I agree in general that there isn't a *practically useful* case
where this would matter much. But there is still (at least one) case
where there could be a regression: if token is created in
init_user_ns, caller has CAP_BPF in init_user_ns, caller passes that
token to BPF_PROG_LOAD, and LSM policy rejects that token in
security_bpf_token_capable(). Without the above implementation such
operation will be rejected, even though if there was no token passed
it would succeed. With my implementation above it will succeed as
expected.

Again, I get that those are unlikely corner cases. But this is kernel
API and it should behave consistently. I'd like to avoid having an
asterisk listing exceptional cases where behavior might not be logical
(however unlikely) and stuff like that. The promise is simple:
"providing a token can never regress permissions an application would
have without a token". And libraries like libbpf then can take that as
a contract to work with.

I like this latest implementation above as it is straightforward to
follow and satisfies that contract "by construction":

bool bpf_token_capable(const struct bpf_token *token, int cap)
{
       if (token && token_capable(token, cap))
            return true;
       return token_capable(NULL, cap);
}

So in summary, assuming we are converging and the above
bpf_token_capable() implementation doesn't have any more hidden
issues, I only have s/kvzalloc/kzalloc/, s/kvfree/kfree/ change that
Linus asked for on the kernel side. I'm planning to roll those into
corresponding existing patches. Besides that I'm adding a few new
tests to validate LSM interactions, which I'll add as a separate patch
to the series.

I'm thinking of sending the bpf/bpf-next patch set for v2, just like I
did with v1. But if PR directly to Linus is more preferable, please
someone do let me know, thank you!

