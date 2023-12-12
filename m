Return-Path: <linux-fsdevel+bounces-5612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D280E1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 03:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0221F21C90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268E4419;
	Tue, 12 Dec 2023 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2caCGh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB311B5;
	Mon, 11 Dec 2023 18:40:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3334a701cbbso5292885f8f.0;
        Mon, 11 Dec 2023 18:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348824; x=1702953624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tJU7dleoX/RzMobRXQPiE84lMmtlC7OQ00WD17zQQk=;
        b=d2caCGh/dp+N1JKnSqqy8xjUj+fFFE03cPPUXmIVUsrX5LLqiz8aoaixKFsREpVwZO
         CC2SjHPXEp+aAcmVEV39FJ7Raw50NpF0ZzkNvjQiS/bKOcJmEKYIYwcDS6QjXq3cnq8n
         LlZLRqqhjLZ7Szq/DbG1Y52bnXvVdJCEOB7Yhyv77aAP9YIJbnwl0a+C5gN+KqOOeJNC
         7f1Ir4+Q9P5a+BCe+KSI/9R3ezBPczhteb1E0uuvtahyLHUHnE7IZAr8QRb3jUKeHrtU
         F3oSQixr1NWTyEX8D2UPcIYKIW32mEd5Xk0aUZlcRqZTbQwERQt5avImUbRLSdyUC2tc
         4s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348824; x=1702953624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tJU7dleoX/RzMobRXQPiE84lMmtlC7OQ00WD17zQQk=;
        b=gQB3YuCo6wL3+2oeddAYRUhvtQi4/gRcuCj7KUk95oSv72pI+DEjmuUpezRgU29PP5
         SgIhnXIAxb0ecyPuU2HNO/upR8RuM1ObKh7tUG2LcGNx7g9FbgMJwLc1srAY2jyE3Iva
         nONs1PuCCl1M+PeWJ/45lDSpPmYKk4e+aDZf36S8Ih/WUsYpiouyAnxfRLrrBVIEim6g
         SrBe15EGTmlLJ6OhbYNLOCkt4aJAi3lg+fBeg1Z2RoZtbZbh7yhjs7WxQtgi8siaA9GT
         3ssTARBe50ULg/kh+gnjEEW9ajKWQ7wewYvy1L84cK2rx7YAJpRCQZgXG7lThVXgkxBp
         9QHw==
X-Gm-Message-State: AOJu0Yy/F5M9PeHQZDRSPth3hBgKDzuj1VVwAFSDMsT7KSqaZgbvfxg4
	w7n11s+qOzJ/2ZzT9/e03R8Y0ErvF/HY4+2pVfw=
X-Google-Smtp-Source: AGHT+IFvRJVgChRAZzYA6qAem67U82vXa1WfuLDzy/N8IXtB46wlfBjkik2OPkgubs2ymAnoFznshTH6B1sgHwdG070=
X-Received: by 2002:a05:6000:892:b0:333:9103:63d2 with SMTP id
 cs18-20020a056000089200b00333910363d2mr1675530wrb.106.1702348823995; Mon, 11
 Dec 2023 18:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207222755.3920286-1-andrii@kernel.org> <20231207222755.3920286-2-andrii@kernel.org>
In-Reply-To: <20231207222755.3920286-2-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Dec 2023 18:40:12 -0800
Message-ID: <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:28=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> +#define __BPF_CMD_MAPPER(FN, ctx...)                                   \
> +       FN(BPF_MAP_CREATE, 0)                                           \
> +       FN(BPF_MAP_LOOKUP_ELEM, 1)                                      \
> +       FN(BPF_MAP_UPDATE_ELEM, 2)                                      \
> +       FN(BPF_MAP_DELETE_ELEM, 3)                                      \
> +       FN(BPF_MAP_GET_NEXT_KEY, 4)                                     \

So macro conversion across 4 main enums in uapi/bpf.h
is just to do:
+static const struct constant_table cmd_kvs[] =3D {
+       __BPF_CMD_MAPPER(__BPF_KV_FN)
+       {}
+};

on the kernel side,
right?

While in libbpf we already hard code name to value in arrays:
prog_type_name[], map_type_name[]

which probably will remain as-is, since libbpf needs to be
built independently from the kernel.
(unless we will say that tools/uapi/bpf.h is part of libbpf,
which probably not a good way).

There are more pros than cons in this enum uglification,
but cons are definitely staring in the face.

Have you considered other options?
Like using vmlinix BTF for parsing bpffs delegation?
[14083] ENUM 'bpf_cmd' encoding=3DUNSIGNED size=3D4 vlen=3D39
        'BPF_MAP_CREATE' val=3D0
        'BPF_MAP_LOOKUP_ELEM' val=3D1
        'BPF_MAP_UPDATE_ELEM' val=3D2
        'BPF_MAP_DELETE_ELEM' val=3D3
        'BPF_MAP_GET_NEXT_KEY' val=3D4
        'BPF_PROG_LOAD' val=3D5

Names and values are available.
btf_find_by_name_kind(vmlinux_btf, "bpd_cmd", BTF_KIND_ENUM);
is fast enough.

I suspect you'll argue that you don't want to tie in
bpffs delegation parsing with BTF ;)

While I can preemptively answer that in the case vmlinux BTF
is not available it's fine not to parse names and rely on hex.

