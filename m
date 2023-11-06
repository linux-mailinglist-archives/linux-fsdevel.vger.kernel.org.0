Return-Path: <linux-fsdevel+bounces-2034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B87E197F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3381C20A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 05:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D205247;
	Mon,  6 Nov 2023 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZI/2Wj/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B5635
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 05:01:24 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D21E1
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:01:21 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0ceba445so22742106d6.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246881; x=1699851681; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=je4RrCBnaPDZma+LQbI7lYeKbBZd/hlyMFpI14/dzZw=;
        b=ZI/2Wj/BbtzrlWZAtg6sTSnd4qlCae67Aa0dwgT4D+vAy+gIKRHjkYAlUiVrmG+Bmd
         ZYmvAxEXf0XFr5MHzA4XQdw8+bMdqAte/NlMxJND/XXJ5rm7ozA3rIQGWX/LErxxkLjs
         EZs6pqryZupzQQLdhPIxJfD4ooLhkRNKhCCENWUbhGyE0XbYw1XH7+LMrSliSnA5tZg5
         vtdVhM5Az7h3tEFII+Pz5JErapHHz5+9Uz44wzqg4LqbxpONn0tPEis0LbYwqLlMEPiq
         IMbnEeAPKFQUXLQLnYwLS/Yni++1/bqQGlfEDnc9LHVSmiN6Vg9rpLlA+OYv6P+hCBGy
         +yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246881; x=1699851681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je4RrCBnaPDZma+LQbI7lYeKbBZd/hlyMFpI14/dzZw=;
        b=hNG33N2ArwVfl/FiZmFJ8RuaDeXHB9BlDutSQutUknJ5QKVKK17ViTLU6w1pHQxlbE
         WO1KPEPHpjZw6Afet+T8UETeXu/xA0bAqqkNJUBhw8zLm4MTQdQt5ukM7g4Ciezzizhx
         k6WGPxhuBWEsmJmT0GQJfDWTVrMVgszQa4nOI+UtwVmJ6uCjM0j8Ri7NrhHdbdBwBEou
         gBQfTFTs6LwYNdJl8831m1yi4h2FWEBUKT4/9f1drUS7XlB+wCtIyIbybUCP6RqbiY/6
         0wQ+j+LGP/qnRwVnPmG2GtfOPSTY4V/qAW5fyy/MSdy3EqYghGFANIuJc74+RhcfgPo/
         CQGQ==
X-Gm-Message-State: AOJu0YysysQGqzAk4GnWx7FoOWIKKzb8xUT/+Khg19wswmrzVQst0ZzG
	/duWXU9f0k9wZ9mj2EUfDRyP
X-Google-Smtp-Source: AGHT+IEb3ptzoQZtoCEsn5a3d9x4YOVwl6lJKdcIkRv0zs7pCgsbuNwO3+dvv5v/cl+r6OhlXjIqSA==
X-Received: by 2002:ad4:5961:0:b0:66d:19b5:9a9 with SMTP id eq1-20020ad45961000000b0066d19b509a9mr28419071qvb.65.1699246880776;
        Sun, 05 Nov 2023 21:01:20 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f2-20020a0ccc82000000b0066d04196c3dsm3121705qvl.49.2023.11.05.21.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:20 -0800 (PST)
Date: Mon, 06 Nov 2023 00:01:19 -0500
Message-ID: <7ff273d368f3f7dd383444928ca478ef.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 9/17] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM  hooks
References: <20231103190523.6353-10-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Based on upstream discussion ([0]), rework existing
> bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and instead
> of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
> program struct. Also, we pass bpf_attr union with all the user-provided
> arguments for BPF_PROG_LOAD command.  This will give LSMs as much
> information as we can basically provide.
> 
> The hook is also BPF token-aware now, and optional bpf_token struct is
> passed as a third argument. bpf_prog_load LSM hook is called after
> a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux were
> allocated and filled out, but right before performing full-fledged BPF
> verification step.
> 
> bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
> consistency. SELinux code is adjusted to all new names, types, and
> signatures.
> 
> Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can be
> used by some LSMs to allocate extra security blob, but also by other
> LSMs to reject BPF program loading, we need to make sure that
> bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc one
> *even* if the hook itself returned error. If we don't do that, we run
> the risk of leaking memory. This seems to be possible today when
> combining SELinux and BPF LSM, as one example, depending on their
> relative ordering.
> 
> Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
> sleepable LSM hooks list, as they are both executed in sleepable
> context. Also drop bpf_prog_load hook from untrusted, as there is no
> issue with refcount or anything else anymore, that originally forced us
> to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certain LSM
> hook arguments as trusted"). We now trigger this hook much later and it
> should not be an issue anymore.

See my comment below, but it isn't clear to me if this means it is okay
to have `BTF_ID(func, bpf_lsm_bpf_prog_free)` called twice.  It probably
would be a good idea to get KP, BPF LSM maintainer, to review this change
as well to make sure this looks good to him.

>   [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++--
>  include/linux/security.h      | 12 +++++++-----
>  kernel/bpf/bpf_lsm.c          |  5 +++--
>  kernel/bpf/syscall.c          | 25 +++++++++++++------------
>  security/security.c           | 25 +++++++++++++++----------
>  security/selinux/hooks.c      | 15 ++++++++-------
>  6 files changed, 49 insertions(+), 38 deletions(-)

...

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index e14c822f8911..3e956f6302f3 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
>  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
>  BTF_ID(func, bpf_lsm_bpf_map_free_security)
>  BTF_ID(func, bpf_lsm_bpf_prog)
> +BTF_ID(func, bpf_lsm_bpf_prog_load)
> +BTF_ID(func, bpf_lsm_bpf_prog_free)
>  BTF_ID(func, bpf_lsm_bprm_check_security)
>  BTF_ID(func, bpf_lsm_bprm_committed_creds)
>  BTF_ID(func, bpf_lsm_bprm_committing_creds)
> @@ -346,8 +348,7 @@ BTF_SET_END(sleepable_lsm_hooks)
>  
>  BTF_SET_START(untrusted_lsm_hooks)
>  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> -BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
> -BTF_ID(func, bpf_lsm_bpf_prog_free_security)
> +BTF_ID(func, bpf_lsm_bpf_prog_free)
>  BTF_ID(func, bpf_lsm_file_alloc_security)
>  BTF_ID(func, bpf_lsm_file_free_security)
>  #ifdef CONFIG_SECURITY_NETWORK

It looks like you're calling the BTF_ID() macro on bpf_lsm_bpf_prog_free
twice?  I would have expected a only one macro call for each bpf_prog_load
and bpf_prog_free, is that a bad assuption?

> diff --git a/security/security.c b/security/security.c
> index dcb3e7014f9b..5773d446210e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
>  }
>  
>  /**
> - * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
> - * @aux: bpf program aux info struct
> + * security_bpf_prog_load() - Check if loading of BPF program is allowed
> + * @prog: BPF program object
> + * @attr: BPF syscall attributes used to create BPF program
> + * @token: BPF token used to grant user access to BPF subsystem
>   *
> - * Initialize the security field inside bpf program.
> + * Do a check when the kernel allocates BPF program object and is about to
> + * pass it to BPF verifier for additional correctness checks. This is also the
> + * point where LSM blob is allocated for LSMs that need them.

This is pretty nitpicky, but I'm guessing you may need to make another
revision to this patchset, if you do please drop the BPF verifier remark
from the comment above.

Example: "Perform an access control check when the kernel loads a BPF
program and allocates the associated BPF program object.  This hook is
also responsibile for allocating any required LSM state for the BPF
program."

>   * Return: Returns 0 on success, error on failure.
>   */
> -int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
> +int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
> +			   struct bpf_token *token)
>  {
> -	return call_int_hook(bpf_prog_alloc_security, 0, aux);
> +	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
>  }

--
paul-moore.com

