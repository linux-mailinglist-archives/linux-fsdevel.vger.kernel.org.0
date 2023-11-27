Return-Path: <linux-fsdevel+bounces-3871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B5A7F9765
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 03:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE1EB20B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C60139A;
	Mon, 27 Nov 2023 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed37FxdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3407111;
	Sun, 26 Nov 2023 18:09:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso1290155e9.0;
        Sun, 26 Nov 2023 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701050949; x=1701655749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp+jJgrzxsF5GIt+zmavYWarAYFX/wlGlTSYDEYR/Xw=;
        b=Ed37FxdZtfsuRpkfJrjSsBH7QIFkzdqNyDrukcQyYsoAcHrmVaDTp7Tk4HP71n6uAh
         YIyMxaCWUOsKdG97gBq6rTycUZPf4QuayiFXd0rLuQDyjjuidYDRWZ4NYM7Lu0TDyo2Q
         OCz9vZn3P7MbI9bhvjfMXH3XQxlPDIiR0vDdU12AwuIGq4YN5COMvMl3q6HQNdBSbWTr
         p9Ko26Ck2rNNQK6Im9ktuVqU4WAwAe+RR/qovsCm0Rgt9OxOqomgaWsnd53s1/BunRN8
         JjRcTNu8sILMowumVEez7iSm4UQiBD483lBHwvby6B6oWFHNVB+XQGcLZSAwfhhy6yFC
         reig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050949; x=1701655749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp+jJgrzxsF5GIt+zmavYWarAYFX/wlGlTSYDEYR/Xw=;
        b=oLMta8BZ4BsFv6eTmDRpKmIXU+Y+JVoM+tPbCmO8lhbvTqdwxTG59hJfkDqj/0Z2lR
         f9rFiuahayy+H7NbLT70uL0bKRLi9EB0i9WqCw9P9X5wKwnpK9bhT7lLg6y7JoQnriRK
         xiA5BfBCBbq+TA4B5D2U0rQ28ObfrBzSOmEY596g4G9O3VSpPQG2UqhR5EGdJdzYkDr2
         eCjug1S6v8k+S2jDRfWYzjEMINusCkkAWJXl6Nut8Cbn/ebtvw5Q7gx7nJF5FVZ3f54n
         G/ii1bk0WYjMvE0OcwLPihENP5R6eiPmMYzwy1K59DfsqewrEInW2wjOLN52gHpDStZu
         PAtg==
X-Gm-Message-State: AOJu0YwJBsKU7O+nwsYFhamum2baL7UvqTqndlCWTDXz8K3mz6BAVgA+
	M+lMaA4L6ogNrQCb+u/y+bFr4A/IdzBXZijXDhE=
X-Google-Smtp-Source: AGHT+IF+V8Dn2B1tQYO/Rk1PtkKfTrXFcS4SOKAbYP9DCz6k+PF4QmNnszGsyC4SI3u77CVNwk5ab+PikCOyNx1WOKE=
X-Received: by 2002:adf:ef82:0:b0:32d:b2cf:8ccd with SMTP id
 d2-20020adfef82000000b0032db2cf8ccdmr8050356wro.47.1701050949018; Sun, 26 Nov
 2023 18:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-6-song@kernel.org>
In-Reply-To: <20231123233936.3079687-6-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Nov 2023 18:08:57 -0800
Message-ID: <CAADnVQKHTdGiBFh_sVr+jdsA8di8i4HHivp98QCOnHZGoHAW5Q@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 5/6] selftests/bpf: Add tests for filesystem kfuncs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Amir Goldstein <amir73il@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> +static const char expected_value[] =3D "hello";
> +char value[32];
> +
> +SEC("lsm.s/file_open")
> +int BPF_PROG(test_file_open, struct file *f)
> +{
> +       struct bpf_dynptr value_ptr;
> +       __u32 pid;
> +       int ret;
> +
> +       pid =3D bpf_get_current_pid_tgid() >> 32;
> +       if (pid !=3D monitored_pid)
> +               return 0;
> +
> +       bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> +
> +       ret =3D bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
> +       if (ret !=3D sizeof(expected_value))
> +               return 0;
> +       if (bpf_strncmp(value, ret, expected_value))

Hmm. It doesn't work like:
if (bpf_strncmp(value, ret, "hello"))

?

