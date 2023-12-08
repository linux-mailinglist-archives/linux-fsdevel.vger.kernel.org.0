Return-Path: <linux-fsdevel+bounces-5388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4D80AFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC30281B63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA955AB84;
	Fri,  8 Dec 2023 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD+JEL4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA910CA;
	Fri,  8 Dec 2023 14:42:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fa2714e828so335348066b.1;
        Fri, 08 Dec 2023 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702075360; x=1702680160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeRi2RzPavt7MiOm/u+S/euZwULbAuM0F2k9JFYP/T0=;
        b=YD+JEL4RBIqytoXy6eTlujXpC1PmKY+z8md8Re04D+DJBZHEfDi0h0BhRDZ9r2km75
         Ex7yeY3CZMmiLoirhgd9TL2OM7bKAj1WSjTTALS2saoCN/S7dGLu7zmBJgLbjc9ny30W
         +o6FzRUZRGnmhBY+51EeQivt7Ih70fkhY366Dh0e9Kfsot+Gfm8eMvzU0bVBcAMCaLW6
         i4xeE/yAQsw5GqSkp2pP3NPIH38s5Q3SukSQ/E5ZsSqVqSpLmAlavsA9EtVlfyrz/YRM
         r3ZAwGBSdu78vjd2Lv+WrRq4M5WJqAkzCYnchnGPZ6DKIuGouVkzCoh3m54g3UEu+IKf
         17OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075360; x=1702680160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeRi2RzPavt7MiOm/u+S/euZwULbAuM0F2k9JFYP/T0=;
        b=jOdNL3Og7jqPMwqPdbfMUfJCzznPnKBSHhYWxUeal4bkFP83sEwbJ36BT1viMR5vmQ
         Avl9mU2x/bHuPreq7YnKiSWjIiT8/oLsSzd/Q8gnaXRldTtXQJAkoMVB8DCZtj3Qf8zf
         mhgcGYI2z2a9HD/X5cHPTjB28ubuwzZ9BUiNtWuBqBxaj1oktoM7thD2+Ss/s4CI55N3
         0ic87ssJO2G0XDlKdegROct+jWTkT+9puud2BfrS9pk8IvW/O3xlBrHm3kA1rHJa53UU
         sAA3E3k6ojLfL6gSjnfvBEWGOXDI0DvWwaZI0X5yReWA2HTmt69fLMwAo+K9SB3SB9oR
         Yrqw==
X-Gm-Message-State: AOJu0Yx9nDJBHGLjOUbpMUS09w7U+alDytKhR3jPOd5Rx4viopJpULOR
	HaXiNpVn6A2pogzkfrgUQsrWwzAk4uWiskQTyCs=
X-Google-Smtp-Source: AGHT+IEgLjlBPvK/C3mhbmysRfyejLFP+XOCizODYZ06oxPi7vpNPQr7ZjkldJ0lsIXKQbkmnGvuZu1oi8yHImC1ov8=
X-Received: by 2002:a17:906:74cf:b0:a19:532c:7678 with SMTP id
 z15-20020a17090674cf00b00a19532c7678mr350197ejl.30.1702075360276; Fri, 08 Dec
 2023 14:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207185443.2297160-1-andrii@kernel.org> <20231207185443.2297160-2-andrii@kernel.org>
 <20231208-pocken-flugverbindung-0e4b956cd089@brauner>
In-Reply-To: <20231208-pocken-flugverbindung-0e4b956cd089@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:42:28 -0800
Message-ID: <CAEf4BzZh9FJAXEfR4F+e30xwSigPdgzmErVxgpeMFjHwoScx1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: fail BPF_TOKEN_CREATE if no delegation
 option was set on BPF FS
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 1:49=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Dec 07, 2023 at 10:54:36AM -0800, Andrii Nakryiko wrote:
> > It's quite confusing in practice when it's possible to successfully
> > create a BPF token from BPF FS that didn't have any of delegate_xxx
> > mount options set up. While it's not wrong, it's actually more
> > meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT=
)
> > to let user-space know that no token delegation is setup up.
> >
> > So, instead of creating empty BPF token that will be always ignored
> > because it doesn't have any of the allow_xxx bits set, reject it with
> > -ENOENT. If we ever need empty BPF token to be possible, we can support
> > that with extra flag passed into BPF_TOKEN_CREATE.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Might consider EOPNOTSUPP (or whatever the correct way of spelling this

I thought about that, but it felt wrong to return "unsupported" error
code, because BPF token is supported, it's just not setup/delegated on
that particular instance of BPF FS. So in that sense it felt like "BPF
token is not there" is more appropriate, which is why I went with
-ENOENT. And also I was worried that we might add -EOPNOTSUPP for some
unsupported combinations of flags or something, and then it will
become confusing to detect when some functionality is really not
supported, or if BPF token delegation isn't set on BPF FS. I hope that
makes sense and is not too contrived an argument.


> is). Otherwise,
> Acked-by: Christian Brauner <brauner@kernel.org>

