Return-Path: <linux-fsdevel+bounces-7859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0682BC22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 08:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D831F22D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC925D8F4;
	Fri, 12 Jan 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0yYy0kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF4812;
	Fri, 12 Jan 2024 07:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B75C43394;
	Fri, 12 Jan 2024 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705046317;
	bh=Uglla99ShZFkkZxMOw+1oo+SNUsVn5iSreLOyPhroTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0yYy0kr0A76VaCGj7yqY7nDzqXvfaO9Co/TJkUAVvHyLlocSL0r/TTZk7ji/vnnM
	 qXvxBG+CkVOTSf6B5x9Y2wwyiPGNo3zbjlTRA3bE/rxQ4SPgdDudOo0mOnne8a8DIu
	 UTsDGOExHq067/44ew38TbIcX1bSgkzDhW/HNnWaZDBieo1n0L1HOi6PXebyJcGHNf
	 fSfWhniFb0+jiLWAnW+x6pTmEDJhQgj5CGyZILbSduuWg7oyrn8g9XRIQ2qaHTe5oV
	 YdT3si4gAzQ1sOqDJ+eJa2T8G0ItogB2EHdH2ZBElSD6sdb5VyEBBsa17Hwp+X0d/V
	 0g054ct6biFYQ==
Date: Fri, 12 Jan 2024 08:58:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner>
References: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
 <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner>
 <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner>
 <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner>
 <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>

On Thu, Jan 11, 2024 at 09:41:25AM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 11, 2024 at 2:38 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > > The current check is inconsisent. It special-cases init_user_ns. The
> > > > correct thing to do for what you're intending imho is:
> > > >
> > > > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > {
> > > >         struct user_namespace *userns = &init_user_ns;
> > > >
> > > >         if (token)
> > > >                 userns = token->userns;
> > > >         if (ns_capable(userns, cap))
> > > >                 return true;
> > > >         return cap != CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))
> > > >
> > > > }
> > >
> > > Unfortunately the above becomes significantly more hairy when LSM
> > > (security_bpf_token_capable) gets involved, while preserving the rule
> > > "if token doesn't give rights, fall back to init userns checks".
> >
> > Why? Please explain your reasoning in detail.
> 
> Why which part? About LSM interaction making this much hairier? Then see below.
> 
> But if your "why?" is about "pretend no token, if token doesn't give
> rights", then that's what I tried to explain in my last email(s). It
> significantly alters (for the worse) user-space integration story
> (providing a token can be a regression, so now it's not safe to
> opportunistically try to create and use BPF token; on the other hand,
> automatically retrying inside libbpf makes for confusing user
> experience and inefficiencies). Please let me know which parts are not
> clear.
> 
> >
> > >
> > > I'm happy to accommodate any implementation of bpf_token_capable() as
> > > long as it behaves as discussed above and also satisfies Paul's
> > > requirement that capability checks should happen before LSM checks.
> > >
> > > >
> > > > Because any caller located in an ancestor user namespace of
> > > > token->user_ns will be privileged wrt to the token's userns as long as
> > > > they have that capability in their user namespace.
> > >
> > > And with `current_user_ns() == token->userns` check we won't be using
> > > token->userns while the caller is in ancestor user namespace, we'll
> > > use capable() check, which will succeed only in init user_ns, assuming
> > > corresponding CAP_xxx is actually set.
> >
> > Why? This isn't how any of our ns_capable() logic works.
> >
> > This basically argues that anyone in an ancestor user namespace is not
> > allowed to operate on any of their descendant child namespaces unless
> > they are in the init_user_ns.
> >
> > But that's nonsense as I'm trying to tell you. Any process in an
> > ancestor user namespace that is privileged over the child namespace can
> > just setns() into it and then pass that bpf_token_capable() check by
> > supplying the token.
> >
> > At this point just do it properly and allow callers that are privileged
> > in the token user namespace to load bpf programs. It also means you get
> > user namespace nesting done properly.
> 
> Ok, I see. This `current_user_ns() == token->userns` check prevents
> this part of cap_capable() to ever be exercised:
> 
>  if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
>     return 0;
> 
> Got it. I'm all for not adding any unnecessary restrictions.
> 
> >
> > >
> > > >
> > > > For example, if the caller is in the init_user_ns and permissions
> > > > for CAP_WHATEVER is checked for in token->user_ns and the caller has
> > > > CAP_WHATEVER in init_user_ns then they also have it in all
> > > > descendant user namespaces.
> > >
> > > Right, so if they didn't use a token they would still pass
> > > capable(CAP_WHATEVER), right?
> >
> > Yes, I'm trying to accomodate your request but making it work
> > consistently.
> >
> > >
> > > >
> > > > The original intention had been to align with what we require during
> > > > token creation meaning that once a token has been created interacting
> > > > with this token is specifically confined to caller's located in the
> > > > token's user namespace.
> > > >
> > > > If that's not the case then it doesn't make sense to not allow
> > > > permission checking based on regular capability semantics. IOW, why
> > > > special case init_user_ns if you're breaking the confinement restriction
> > > > anyway.
> > >
> > > I'm sorry, perhaps I'm dense, but with `current_user_ns() ==
> > > token->userns` check I think we do fulfill the intention to not allow
> > > using a token in a userns different from the one in which it was
> > > created. If that condition isn't satisfied, the token is immediately
> >
> > My request originally was about never being able to interact with a
> > token outside of that userns. This is different as you provide an escape
> > hatch to init_user_ns. But if you need that and ignore the token then
> > please do it properly. That's what I'm trying to tell you. See below.
> 
> Yes, I do need that. Thanks for providing the full code implementation
> (including LSM), it's much easier this way to converge. Let's see
> below.
> 
> >
> > > ignored. So you can't use a token from another userns for anything,
> > > it's just not there, effectively.
> > >
> > > And as I tried to explain above, I do think that ignoring the token
> > > instead of erroring out early is what we want to provide good
> > > user-space ecosystem integration of BPF token.
> >
> > There is no erroring out early in. It's:
> >
> > (1) Has a token been provided and is the caller capable wrt to the
> >     namespace of the token? Any caller in an ancestor user namespace
> >     that has the capability in that user namespace is capable wrt to
> >     that token. That __includes__ a callers in the init_user_ns. IOW,
> >     you don't need to fallback to any special checking for init_user_ns.
> >     It is literally covered in the if (token) branch with the added
> >     consistency that a process in an ancestor user namespace is
> >     privileged wrt to that token as well.
> >
> > (2) No token has been provided. Then do what we always did and perform
> >     the capability checks based on the initial user namespace.
> >
> > The only thing that you then still need is add that token_capable() hook
> > in there:
> >
> > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > {
> >         bool has_cap;
> >         struct user_namespace *userns = &init_user_ns;
> >
> >         if (token)
> >                 userns = token->userns;
> >         if (ns_capable(userns, cap))
> 
> Here, we still need to check security_bpf_token_capable(token, cap)
> result (and only if token != NULL). And if LSM returns < 0, then drop
> the token and do the original init userns check.
> 
> And I just realized that my original implementation has the same
> problem. In my current implementation if we have a token we will
> terminate at LSM call, regardless if LSM allows or disallows the
> token. But that's inconsistent behavior and shouldn't be like that.
> 
> I will add new tests that validate LSM interactions in the next revision.
> 
> >                 return true;
> >         if (cap != CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))
> >                 return token ? security_bpf_token_capable(token, cap) == 0 : true;
> 
> here as well, even if we have a token which passes ns_capable() check,
> but LSM rejects this token, we still need to forget about the token
> and do capable() checks in init userns.
> 
> >         return false;
> > }
> >
> > Or write it however you like. I think this is way more consistent and
> > gives you a more flexible permission model.
> 
> Yes, I like it, thanks. Taking into account fixed LSM interactions,
> here's what I came up with. Yell if you can spot anything wrong (or
> just hate the style). I did have a version without extra function,
> just setting the token to NULL and "goto again" approach, but I think
> it's way less readable and harder to follow. So this is my version
> right now:
> 
> static bool bpf_ns_capable(struct user_namespace *ns, int cap)
> {
>         return ns_capable(ns, cap) || (cap != CAP_SYS_ADMIN &&
> ns_capable(ns, CAP_SYS_ADMIN));
> }
> 
> static bool token_capable(const struct bpf_token *token, int cap)
> {
>         struct user_namespace *userns;
> 
>         userns = token ? token->userns : &init_user_ns;
>         if (!bpf_ns_capable(userns, cap))
>                 return false;
>         if (token && security_bpf_token_capable(token, cap) < 0)
>                 return false;
>         return true;
> }
> 
> bool bpf_token_capable(const struct bpf_token *token, int cap)
> {
>         /* BPF token allows ns_capable() level of capabilities, but if it
>          * doesn't grant required capabilities, ignore token and fallback to
>          * init userns-based checks
>          */
>         if (token && token_capable(token, cap))
>                 return true;
>         return token_capable(NULL, cap);
> }

My point is that the capable logic will walk upwards the user namespace
hierarchy from the token->userns until the user namespace of the caller
and terminate when it reached the init_user_ns.

A caller is located in some namespace at the point where they call this
function. They provided a token. The caller isn't capable in the
namespace of the token so the function falls back to init_user_ns. Two
interesting cases:

(1) The caller wasn't in an ancestor userns of the token. If that's the
    case then it follows that the caller also wasn't in the init_user_ns
    because the init_user_ns is a descendant of all other user
    namespaces. So falling back will fail.

(2) The caller was in the same or an ancestor user namespace of the
    token but didn't have the capability in that user namespace:
    
     (i) They were in a non-init_user_ns. Therefore they can't be
         privileged in init_user_ns.
    (ii) They were in init_user_ns. Therefore, they lacked privileges in
         the init_user_ns.
    
In both cases your fallback will do nothing iiuc.

