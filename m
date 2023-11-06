Return-Path: <linux-fsdevel+bounces-2183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750967E2FD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9741B1C209D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738C2E648;
	Mon,  6 Nov 2023 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G83UFKDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56D2F503
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:29:58 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE20D6E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:29:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so5276333276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699309792; x=1699914592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E66zNXr7n8OxPZDJkTscd5st2Eb4+BXMECTd16p+KKY=;
        b=G83UFKDBjUJQE6sMUYdBidIfkN/wfUWmRDtYjYnkhSLN1C8k2MEEn33/k11YYx2YMf
         p9F/mm/TtKFI+Ya7L7FvJehN3IR6yqKhVQ3es09QRVRDNd2HL3l5SIpYN26rv9DrYIDb
         3HU2jmHyt38k/wym5asGupnYI0BTKKoV1F6fKU6WHdRPhuHfQtyzBaeW2bFzdfW5YX2j
         PBEcjTTsBtlmPbcmSWKPySkbEOoFtKw6ioyqUrH8igo5V/eeodflzl6HNY+liQ6M6bGA
         tr2v3NqxCab7w52MXOLAYJcY8pNzTsdbF0vjWCGpHRDk6AwhLlJnrAKZk0VNHkvHHe+/
         lNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309792; x=1699914592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E66zNXr7n8OxPZDJkTscd5st2Eb4+BXMECTd16p+KKY=;
        b=Ms4F618mvtPJbetu73WLkN0EOh1GwdJLUiU96ik22Nw5ZSdicytKqP7jxh/BABqUoT
         s4JKXMkqBT4fnvS8Dn5lJl3EcWe6C/ADSC1liqbeFpb76JItPMbyrJL/Ijiy0XHqghBp
         rjvu9GCn009xSCK5k3VKGvAW6sdFUEUyDWVCmNbwv4MwksOJ8qu7n/+889gWo13jn7E9
         tGrcDOOOvVnbmykX5H5royYUr3dWGJm6arWZTTTD/3SGjgaisqigloF1Kc97gzTdyepP
         Q6gTmTxecoBTeHjfn7v3IVmaJ/T0mfGHmVhqI0E2MLQq/Yqz2s8K0FaW/ZoVijzI7Vaf
         4T7g==
X-Gm-Message-State: AOJu0YxEnP+D5jxfGAVVgP+w1g8ZA+kM8yIgpcvrBPwA0G5076YD52fj
	bcqHraWD/AwhpI27wYqSQzYSjNQmDB6kSsYy4loz
X-Google-Smtp-Source: AGHT+IG/6jCSMEcXdJXql31+PqDrBfViRunNdEn77gAOSspcDIrEyjSr07LMpHwMDmW2rtjFP6aQdvIe1WXdR8rp5JI=
X-Received: by 2002:a25:5f4c:0:b0:da0:cea9:2b3b with SMTP id
 h12-20020a255f4c000000b00da0cea92b3bmr28568607ybm.62.1699309792021; Mon, 06
 Nov 2023 14:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-10-andrii@kernel.org> <7ff273d368f3f7dd383444928ca478ef.paul@paul-moore.com>
 <CAEf4Bzaxv4uHK=+_vwZuvgBgq8L6d4JwxTSGxZgU44LwWYhDug@mail.gmail.com>
In-Reply-To: <CAEf4Bzaxv4uHK=+_vwZuvgBgq8L6d4JwxTSGxZgU44LwWYhDug@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Nov 2023 17:29:40 -0500
Message-ID: <CAHC9VhRk8NHx2Sj222KdoyT-+mKyOHzCTOaPK0z-u=w8rFWDyw@mail.gmail.com>
Subject: Re: [PATCH v9 9/17] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free
 LSM hooks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Based on upstream discussion ([0]), rework existing
> > > bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and inst=
ead
> > > of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
> > > program struct. Also, we pass bpf_attr union with all the user-provid=
ed
> > > arguments for BPF_PROG_LOAD command.  This will give LSMs as much
> > > information as we can basically provide.
> > >
> > > The hook is also BPF token-aware now, and optional bpf_token struct i=
s
> > > passed as a third argument. bpf_prog_load LSM hook is called after
> > > a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux we=
re
> > > allocated and filled out, but right before performing full-fledged BP=
F
> > > verification step.
> > >
> > > bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
> > > consistency. SELinux code is adjusted to all new names, types, and
> > > signatures.
> > >
> > > Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can b=
e
> > > used by some LSMs to allocate extra security blob, but also by other
> > > LSMs to reject BPF program loading, we need to make sure that
> > > bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc o=
ne
> > > *even* if the hook itself returned error. If we don't do that, we run
> > > the risk of leaking memory. This seems to be possible today when
> > > combining SELinux and BPF LSM, as one example, depending on their
> > > relative ordering.
> > >
> > > Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
> > > sleepable LSM hooks list, as they are both executed in sleepable
> > > context. Also drop bpf_prog_load hook from untrusted, as there is no
> > > issue with refcount or anything else anymore, that originally forced =
us
> > > to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certai=
n LSM
> > > hook arguments as trusted"). We now trigger this hook much later and =
it
> > > should not be an issue anymore.
> >
> > See my comment below, but it isn't clear to me if this means it is okay
> > to have `BTF_ID(func, bpf_lsm_bpf_prog_free)` called twice.  It probabl=
y
> > would be a good idea to get KP, BPF LSM maintainer, to review this chan=
ge
> > as well to make sure this looks good to him.
> >
> > >   [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.pa=
ul@paul-moore.com/
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++--
> > >  include/linux/security.h      | 12 +++++++-----
> > >  kernel/bpf/bpf_lsm.c          |  5 +++--
> > >  kernel/bpf/syscall.c          | 25 +++++++++++++------------
> > >  security/security.c           | 25 +++++++++++++++----------
> > >  security/selinux/hooks.c      | 15 ++++++++-------
> > >  6 files changed, 49 insertions(+), 38 deletions(-)
> >
> > ...
> >
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index e14c822f8911..3e956f6302f3 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
> > >  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
> > >  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> > >  BTF_ID(func, bpf_lsm_bpf_prog)
> > > +BTF_ID(func, bpf_lsm_bpf_prog_load)
> > > +BTF_ID(func, bpf_lsm_bpf_prog_free)
> > >  BTF_ID(func, bpf_lsm_bprm_check_security)
> > >  BTF_ID(func, bpf_lsm_bprm_committed_creds)
> > >  BTF_ID(func, bpf_lsm_bprm_committing_creds)
> > > @@ -346,8 +348,7 @@ BTF_SET_END(sleepable_lsm_hooks)
> > >
> > >  BTF_SET_START(untrusted_lsm_hooks)
> > >  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> > > -BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
> > > -BTF_ID(func, bpf_lsm_bpf_prog_free_security)
> > > +BTF_ID(func, bpf_lsm_bpf_prog_free)
> > >  BTF_ID(func, bpf_lsm_file_alloc_security)
> > >  BTF_ID(func, bpf_lsm_file_free_security)
> > >  #ifdef CONFIG_SECURITY_NETWORK
> >
> > It looks like you're calling the BTF_ID() macro on bpf_lsm_bpf_prog_fre=
e
> > twice?  I would have expected a only one macro call for each bpf_prog_l=
oad
> > and bpf_prog_free, is that a bad assuption?
> >
>
> Yeah, there is no problem having multiple BTF_ID() invocations for the
> same function. BTF_ID() macro (conceptually) emits a relocation that
> will instruct resolve_btfids tool to put an actual BTF ID for the
> specified function in a designated 4-byte slot.
>
> In this case, we have two separate lists: sleepable_lsm_hooks and
> untrusted_lsm_hooks, so we need two separate BTF_ID() entries for the
> same function. It's expected to be duplicated.

Okay, thanks for the explanation.  It jumped out as a deviation from
the current code when I was looking at the changes and I was worried
that it was a typo, but it sounds like it's expected and the proper
thing to do.

> > > diff --git a/security/security.c b/security/security.c
> > > index dcb3e7014f9b..5773d446210e 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *ma=
p)
> > >  }
> > >
> > >  /**
> > > - * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
> > > - * @aux: bpf program aux info struct
> > > + * security_bpf_prog_load() - Check if loading of BPF program is all=
owed
> > > + * @prog: BPF program object
> > > + * @attr: BPF syscall attributes used to create BPF program
> > > + * @token: BPF token used to grant user access to BPF subsystem
> > >   *
> > > - * Initialize the security field inside bpf program.
> > > + * Do a check when the kernel allocates BPF program object and is ab=
out to
> > > + * pass it to BPF verifier for additional correctness checks. This i=
s also the
> > > + * point where LSM blob is allocated for LSMs that need them.
> >
> > This is pretty nitpicky, but I'm guessing you may need to make another
> > revision to this patchset, if you do please drop the BPF verifier remar=
k
> > from the comment above.
> >
> > Example: "Perform an access control check when the kernel loads a BPF
> > program and allocates the associated BPF program object.  This hook is
> > also responsibile for allocating any required LSM state for the BPF
> > program."
>
> Done, no problem.

With the comment change above, and the clarification of the BTF_ID()
calls, feel free to add my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

