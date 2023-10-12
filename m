Return-Path: <linux-fsdevel+bounces-231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4F7C7A88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 01:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CB9282B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FD2B5F7;
	Thu, 12 Oct 2023 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bzmlk2KZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55B2B5E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 23:43:20 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47DBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d84c24a810dso1735990276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697154198; x=1697758998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=bzmlk2KZj4Jtu+hM3G+s6mJEtca8aDKDM5tuEVKxpZf2X7LbRC5bHehBOoc+rYLH0d
         aHbWdKG1ozG4SJpqCLWWekCZk/mAZgUtsab1UvcQweRMN4pFYe8qX/scLJ0KsyaHGKFu
         sadZPYf1UeQr8+tQpW1NTkVedIiYwZ8uv0R2BMDI3FlLwmzs80L57GzsK+X9bDJNhizZ
         GiV8I+ADDLVpV/H9JxJQbl3P3HRn0wao8U9l1HBDw3FHtF5RzS37l1fguWzIYBoJTrlF
         byBrhWilcQh/mmf6FXTbRir/LWHUxCNQIAr6KeNc34M+2XXP/Q9sB9kpGMt9xatQVYyr
         BDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154198; x=1697758998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=wcQ1KaVtWkludEgv3KtTBEf+5mpqmygM5t5i3jy3ujJFJMm/Lf5s0KPRls6w3Kv8v9
         HQAaSHheR1mjE/oHUxU9/2Y4Gsl7t+th2to43HzD1ubvzUafKx7nRxmZbKtld8TL7tTV
         EFskavOpFU2tUM6mVAoZWhdiM7s79YkGFsHYAcTBB+kaYW+/SYmvYhU5xBji7SO8nNwF
         E6fK70Jfy+zJhEw5S9yGwYZYdT9oqD03apg4tFozQvrRyqXYzvN3M5OzFGKXwZ/n3EIr
         ni6SRsydKNuv7tezjr0PjWt9UBC2SSHNoOKANQndX7TX+MS58IBGg3bbeWwIN1sisat5
         SwSw==
X-Gm-Message-State: AOJu0YyUJb7uG0BXEJ3XscGnkRd5GVjjsnvqRNkcGZjZ8Ufyl3ejRSSm
	YGPFiEU7S9GHaM/SpUg8Z6I3AhIu/1QrHtsybu+e
X-Google-Smtp-Source: AGHT+IFcGjYof8uqwKQYOb5HB7EJH671qYdyyUP/MYsADQEZKIOvJNUJNMPujVOol3jT7OajE1YEovrl2MC9mWZ3EfE=
X-Received: by 2002:a5b:708:0:b0:d9a:d2eb:7dcf with SMTP id
 g8-20020a5b0708000000b00d9ad2eb7dcfmr2908615ybq.41.1697154198040; Thu, 12 Oct
 2023 16:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
 <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com> <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
In-Reply-To: <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Oct 2023 19:43:07 -0400
Message-ID: <CAHC9VhQuoPUwctgUFNEkXZmutweEpGMVBAx5NmE7PvbE7oeR=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 5:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Oct 11, 2023 at 5:31=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > ok, so I guess I'll have to add all four variants:
> > security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?
> >
>
> Thinking a bit more about this, I think this is unnecessary. All these
> allow checks to control other BPF commands (BPF map creation, BPF
> program load, bpf() syscall command, etc). We have dedicated LSM hooks
> for each such operation, most importantly security_bpf_prog_load() and
> security_bpf_map_create(). I'm extending both of those to be
> token-aware, and struct bpf_token is one of the input arguments, so if
> LSM need to override BPF token allow_* checks, they can do in
> respective more specialized hooks.
>
> Adding so many token hooks, one for each different allow mask (or any
> other sort of "allow something" parameter) seems to be excessive. It
> will both add too many super-detailed LSM hooks and will unnecessarily
> tie BPF token implementation details to LSM hook implementations, IMO.
> I'll send v7 with just security_bpf_token_{create,free}(), please take
> a look and let me know if you are still not convinced.

I'm hoping my last email better explains why we only really need
security_bpf_token_cmd() and security_bpf_token_capable() as opposed
to the full list of security_bpf_token_XXX().  If not, please let me
know and I'll try to do a better job explaining my reasoning :)

One thing I didn't discuss in my last email was why there is value in
having both security_bpf_token_{cmd,capable}() as well as
security_bpf_prog_load(); I'll try to do that below.

As we talked about previously, the reason for having
security_bpf_prog_load() is to provide a token-aware version of
security_bpf().  Currently the LSMs enforce their access controls
around BPF commands using the security_bpf() hook which is
unfortunately well before we have access to the BPF token.  If we want
to be able to take the BPF token into account we need to have a hook
placed after the token is retrieved and validated, hence the
security_bpf_prog_load() hook.  In a kernel that provides BPF tokens,
I would expect that LSMs would use security_bpf() to control access to
BPF operations where a token is not a concern, and new token-aware
security_bpf_OPERATION() hooks when the LSM needs to consider the BPF
token.

With the understanding that security_bpf_prog_load() is essentially a
token-aware version of security_bpf(), I'm hopeful that you can begin
to understand that it  serves a different purpose than
security_bpf_token_{cmd,capable}().  The simple answer is that
security_bpf_token_cmd() applies to more than just BPF_PROG_LOAD, but
the better answer is that it has the ability to impact more than just
the LSM authorization decision.  Hooking the LSM into the
bpf_token_allow_cmd() function allows the LSM to authorize the
individual command overrides independent of the command specific LSM
hook, if one exists.  The security_bpf_token_cmd() hook can allow or
disallow the use of a token for all aspects of a specific BPF
operation including all of the token related logic outside of the LSM,
something the security_bpf_prog_load() hook could never do.

I'm hoping that makes sense :)

--=20
paul-moore.com

