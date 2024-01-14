Return-Path: <linux-fsdevel+bounces-7910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BF82CF7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 03:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FD91C20E24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363F1851;
	Sun, 14 Jan 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibhJtwSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B5EC5;
	Sun, 14 Jan 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-558ac3407eeso3253754a12.0;
        Sat, 13 Jan 2024 18:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705199386; x=1705804186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3fARAzcnsKw1zp+nPDE2Vm6kb/M9mvQuBFNlLqeo4I=;
        b=ibhJtwSvmV43kkGWJ4ow4iV1WC4KATxkpa4nWXd0I5cXn5KlN+pkNuZyE3Wi5CAnMr
         TRaz9W1xg5WPYFw+EYLpvkv+sYf3r6ANATLh8JT5cRteYGIw98aYKnfwLu9MDxM9J7UE
         SRvW4tOFPq4vwVpyUfoaxtcrz2CpQOlf+CuJpaBQ2gk+X//5EFSLMowVQvmH3j+9ky43
         ZUfJDoS/5zfwt5U94C1JnhOcQzlmsibEArIRmZkKTIUjLmdF+DFkLIFcFh+IotGRcm2S
         v0QoQ2qCTm7+/vZSid7y7LK4t0MsaGyZLSdiuYjZVHH32bEnmHOonSv06xGLFomavisI
         oqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705199386; x=1705804186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3fARAzcnsKw1zp+nPDE2Vm6kb/M9mvQuBFNlLqeo4I=;
        b=pXYZXePBBx+XdMUKvOZl+aFCcpSMrHknw5Q4ktuoJyvhxvP/BGx8L4yAkGQig1juTV
         h43yRHPmp6KWTxLJjQiYFdUFeWW8KGV3OgoRC2AOK3Nh8TLa56XuIwvz0kHd6lzaf7aE
         1cF5isYaVFZIwe3HvKnyKp4/DowMROyP0gB0iavg+0McB3wlfyTJCbJuF5LBQgzdziVj
         Tgo4coZTf3cXJF/PB7She8+ZegehRlF+elrYTnoYPqvbJeaqleV3Tckv9f+S6B001c6Q
         FptNbGLhyrbuMbvVrlQ64y4vFaiwn1UCoezsJWbl48dJwxlJgb8DQkL1WvKBK7a/7ZIO
         QOTA==
X-Gm-Message-State: AOJu0Yzq/R6pq5bH3hkqWI6W507DvIN1uopLTACbROKqfYPdNA2NSlr8
	ifHLCz/QAdFK+zCjVBS4B+G9BuhXAdbogi2MN/k=
X-Google-Smtp-Source: AGHT+IFCDIfvD0HN4wikAJNiO2vqoISd72Bbbprs1WrY6i2Ofc9cafxJ7YNh9sieOjT0eNnHtgcpprpcGuqHyTq/uiI=
X-Received: by 2002:a05:6402:c84:b0:558:ab9:b8f8 with SMTP id
 cm4-20020a0564020c8400b005580ab9b8f8mr1608768edb.71.1705199385619; Sat, 13
 Jan 2024 18:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
 <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner> <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner> <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner> <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
 <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner> <CAEf4Bza7UKjv1Hh_kcyBVJw22LDv4ZNA5uV7+WBdnhsM9O7uGQ@mail.gmail.com>
 <20240112-hetzt-gepard-5110cf759a34@brauner>
In-Reply-To: <20240112-hetzt-gepard-5110cf759a34@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 13 Jan 2024 18:29:33 -0800
Message-ID: <CAEf4BzYNRNbaNNGRSUCaY3OQrzXPAdR6gGB0PmXhwsn8rUAs0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:17=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > > My point is that the capable logic will walk upwards the user namespa=
ce
> > > hierarchy from the token->userns until the user namespace of the call=
er
> > > and terminate when it reached the init_user_ns.
> > >
> > > A caller is located in some namespace at the point where they call th=
is
> > > function. They provided a token. The caller isn't capable in the
> > > namespace of the token so the function falls back to init_user_ns. Tw=
o
> > > interesting cases:
> > >
> > > (1) The caller wasn't in an ancestor userns of the token. If that's t=
he
> > >     case then it follows that the caller also wasn't in the init_user=
_ns
> > >     because the init_user_ns is a descendant of all other user
> > >     namespaces. So falling back will fail.
> >
> > agreed
> >
> > >
> > > (2) The caller was in the same or an ancestor user namespace of the
> > >     token but didn't have the capability in that user namespace:
> > >
> > >      (i) They were in a non-init_user_ns. Therefore they can't be
> > >          privileged in init_user_ns.
> > >     (ii) They were in init_user_ns. Therefore, they lacked privileges=
 in
> > >          the init_user_ns.
> > >
> > > In both cases your fallback will do nothing iiuc.
> >
> > agreed as well
> >
> > And I agree in general that there isn't a *practically useful* case
> > where this would matter much. But there is still (at least one) case
> > where there could be a regression: if token is created in
> > init_user_ns, caller has CAP_BPF in init_user_ns, caller passes that
> > token to BPF_PROG_LOAD, and LSM policy rejects that token in
> > security_bpf_token_capable(). Without the above implementation such
> > operation will be rejected, even though if there was no token passed
> > it would succeed. With my implementation above it will succeed as
> > expected.
>
> If that's the case then prevent the creation of tokens in the
> init_user_ns and be done with it. If you fallback anyway then this is
> the correct solution.
>
> Make this change, please. I'm not willing to support this weird fallback
> stuff which is even hard to reason about.

Alright, added an extra check. Ok, so in summary I have the changes
below compared to v1 (plus a few extra LSM-related test cases added):

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index a86fccd57e2d..7d04378560fd 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -9,18 +9,22 @@
 #include <linux/user_namespace.h>
 #include <linux/security.h>

+static bool bpf_ns_capable(struct user_namespace *ns, int cap)
+{
+       return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN &&
ns_capable(ns, CAP_SYS_ADMIN));
+}
+
 bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
-       /* BPF token allows ns_capable() level of capabilities, but only if
-        * token's userns is *exactly* the same as current user's userns
-        */
-       if (token && current_user_ns() =3D=3D token->userns) {
-               if (ns_capable(token->userns, cap) ||
-                   (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns,
CAP_SYS_ADMIN)))
-                       return security_bpf_token_capable(token, cap) =3D=
=3D 0;
-       }
-       /* otherwise fallback to capable() checks */
-       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_A=
DMIN));
+       struct user_namespace *userns;
+
+       /* BPF token allows ns_capable() level of capabilities */
+       userns =3D token ? token->userns : &init_user_ns;
+       if (!bpf_ns_capable(userns, cap))
+               return false;
+       if (token && security_bpf_token_capable(token, cap) < 0)
+               return false;
+       return true;
 }

 void bpf_token_inc(struct bpf_token *token)
@@ -32,7 +36,7 @@ static void bpf_token_free(struct bpf_token *token)
 {
        security_bpf_token_free(token);
        put_user_ns(token->userns);
-       kvfree(token);
+       kfree(token);
 }

 static void bpf_token_put_deferred(struct work_struct *work)
@@ -152,6 +156,12 @@ int bpf_token_create(union bpf_attr *attr)
                goto out_path;
        }

+       /* Creating BPF token in init_user_ns doesn't make much sense. */
+       if (current_user_ns() =3D=3D &init_user_ns) {
+               err =3D -EOPNOTSUPP;
+               goto out_path;
+       }
+
        mnt_opts =3D path.dentry->d_sb->s_fs_info;
        if (mnt_opts->delegate_cmds =3D=3D 0 &&
            mnt_opts->delegate_maps =3D=3D 0 &&
@@ -179,7 +189,7 @@ int bpf_token_create(union bpf_attr *attr)
                goto out_path;
        }

-       token =3D kvzalloc(sizeof(*token), GFP_USER);
+       token =3D kzalloc(sizeof(*token), GFP_USER);
        if (!token) {
                err =3D -ENOMEM;
                goto out_file;

