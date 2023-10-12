Return-Path: <linux-fsdevel+bounces-233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE97C7AA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 01:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A521C210FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC412C851;
	Thu, 12 Oct 2023 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSGOKFSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EFEA6;
	Thu, 12 Oct 2023 23:52:05 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304ACCC;
	Thu, 12 Oct 2023 16:52:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so2669859a12.0;
        Thu, 12 Oct 2023 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697154721; x=1697759521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrpCiUJ4JqBu9o+NEI2JRUxMkcVvZpog0cH6f0L59+c=;
        b=VSGOKFSi5tN+WR7suNkiWWvvE+jvzG92pk+5TmRSl4mUTSrJrNJ5W7TiiwrPO2KMW7
         PrqXtE7A2py5kycEMPzhk3RZkSp+9OzvH28owz7UYn2zxWRDCLX+/ICzBx1w88aAAB4l
         11Fesi8s53HS9sCDiy48VBJxU9K6ZNbkzEy3+67WHYTZR+BIqjC/W6BeBoPzAgjffx6H
         yyqBLFlsTDl6kw4Y4lUHfJ9AfA8uIcVXpf7VYt0gqwVOhCkbo4tVWgAjbA3GtFPgJpir
         lifrbVfzgHw1fzqD8rO+0RV1PlTuafz0Hqe5t7iU24/2y1ukn8elEZ6gCF8mT8mBWcI/
         yeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154721; x=1697759521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrpCiUJ4JqBu9o+NEI2JRUxMkcVvZpog0cH6f0L59+c=;
        b=Zbb99Pip9zWedtUD2BcRY6TyoZRaGtntIV1GsY0DkR38CqtGz71+/c0Ubv1mMclHEQ
         /6WEeYRhY5uI0Jr40rdLVVocsP1ABc0Gy1J8/+Kl4J1OM/Cmtj+KVeBczqAZbCNruHre
         VXKBPUlHanAdEhXaOdfPEiosYU7Ovn6pQXTMRdp3HCKlA3+uKLQ1vERWAZ68Xgp6ClQe
         1rjCVmTjWy3QrIF9jUJE3WQ3dnTp1n2mHxQcZixY5r/6Pgzm1TaaXxUqyESKhDll/HKo
         F4EzKZL4+43qz/w7iF6HXV74oXk/MubnZ4ORoYCes4jqGK78tED4GldYc6209IYppqYn
         TlVg==
X-Gm-Message-State: AOJu0YxiOBEaBRIqe8/4XRE4ZVSrffRqbv+AcLBbZHOSlPtHNyBqA7+a
	X8irqbpmY9f+jixSE4KXi7ammgRwuCXfK2ntP3s=
X-Google-Smtp-Source: AGHT+IHv3VDK3DVm3XB3NfwJ0Jfb2RMkvo5rJNSsJXlbOXLNihpGlJ//0wCQcAkxKT+WnoCJ7Haihua4z6j4WqE2jwA=
X-Received: by 2002:aa7:da84:0:b0:536:2b33:83ed with SMTP id
 q4-20020aa7da84000000b005362b3383edmr25843419eds.24.1697154721408; Thu, 12
 Oct 2023 16:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
 <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com>
 <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com> <CAHC9VhQuoPUwctgUFNEkXZmutweEpGMVBAx5NmE7PvbE7oeR=g@mail.gmail.com>
In-Reply-To: <CAHC9VhQuoPUwctgUFNEkXZmutweEpGMVBAx5NmE7PvbE7oeR=g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 16:51:49 -0700
Message-ID: <CAEf4BzZaOQ+pJw+WN7KrtCxzKHSjvvRJKOue_sfpNVccoBqh6Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Oct 12, 2023 at 5:48=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Oct 11, 2023 at 5:31=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > ok, so I guess I'll have to add all four variants:
> > > security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?
> > >
> >
> > Thinking a bit more about this, I think this is unnecessary. All these
> > allow checks to control other BPF commands (BPF map creation, BPF
> > program load, bpf() syscall command, etc). We have dedicated LSM hooks
> > for each such operation, most importantly security_bpf_prog_load() and
> > security_bpf_map_create(). I'm extending both of those to be
> > token-aware, and struct bpf_token is one of the input arguments, so if
> > LSM need to override BPF token allow_* checks, they can do in
> > respective more specialized hooks.
> >
> > Adding so many token hooks, one for each different allow mask (or any
> > other sort of "allow something" parameter) seems to be excessive. It
> > will both add too many super-detailed LSM hooks and will unnecessarily
> > tie BPF token implementation details to LSM hook implementations, IMO.
> > I'll send v7 with just security_bpf_token_{create,free}(), please take
> > a look and let me know if you are still not convinced.
>
> I'm hoping my last email better explains why we only really need
> security_bpf_token_cmd() and security_bpf_token_capable() as opposed
> to the full list of security_bpf_token_XXX().  If not, please let me
> know and I'll try to do a better job explaining my reasoning :)
>
> One thing I didn't discuss in my last email was why there is value in
> having both security_bpf_token_{cmd,capable}() as well as
> security_bpf_prog_load(); I'll try to do that below.
>
> As we talked about previously, the reason for having
> security_bpf_prog_load() is to provide a token-aware version of
> security_bpf().  Currently the LSMs enforce their access controls
> around BPF commands using the security_bpf() hook which is
> unfortunately well before we have access to the BPF token.  If we want
> to be able to take the BPF token into account we need to have a hook
> placed after the token is retrieved and validated, hence the
> security_bpf_prog_load() hook.  In a kernel that provides BPF tokens,
> I would expect that LSMs would use security_bpf() to control access to
> BPF operations where a token is not a concern, and new token-aware
> security_bpf_OPERATION() hooks when the LSM needs to consider the BPF
> token.
>
> With the understanding that security_bpf_prog_load() is essentially a
> token-aware version of security_bpf(), I'm hopeful that you can begin
> to understand that it  serves a different purpose than
> security_bpf_token_{cmd,capable}().  The simple answer is that
> security_bpf_token_cmd() applies to more than just BPF_PROG_LOAD, but
> the better answer is that it has the ability to impact more than just
> the LSM authorization decision.  Hooking the LSM into the
> bpf_token_allow_cmd() function allows the LSM to authorize the
> individual command overrides independent of the command specific LSM
> hook, if one exists.  The security_bpf_token_cmd() hook can allow or
> disallow the use of a token for all aspects of a specific BPF
> operation including all of the token related logic outside of the LSM,
> something the security_bpf_prog_load() hook could never do.
>
> I'm hoping that makes sense :)

Yes, I think I understand what you are trying to do, but I need to
clarify something about the bpf_token_allow_cmd() check. It's
meaningless for any command besides BPF_PROG_LOAD, BPF_MAP_CREATE, and
BPF_BTF_LOAD. For any other command you cannot even specify token_fd.
So even if you create a token allowing, say, BPF_MAP_LOOKUP_ELEM, it
has no effect, because BPF_MAP_LOOKUP_ELEM is doing its own checks
based on the provided BPF map FD.

So only if the command is token-aware itself, this allowed_cmd makes
any difference. And in such a case we'll most probably have and/or
want to have an LSM hook for that specific command that accepts struct
bpf_token as an argument. Which is what I did for
security_bpf_prog_load and security_bpf_map_create.

Granted, we don't have any LSM hooks for BPF_BTF_LOAD, mostly because
BTF is just a blob of type info data, and I guess no one bothered to
control the ability to load that. But we can add that easily, if you
think it's important.

So taking everything you said, I still think we don't want a
bpf_token_capable hook, and we'll just be getting targeted LSM hooks
if we need them for some new or existing BPF commands.

Basically, bpf_token's allow_cmd doesn't give you a bypass for
non-token checks we are already doing. So security_bpf() for
everything besides BPF_PROG_LOAD/BPF_MAP_CREATE/BPF_BTF_LOAD is a
completely valid way to restrict everything. You won't miss anything.

>
> --
> paul-moore.com

