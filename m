Return-Path: <linux-fsdevel+bounces-5613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6170E80E326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158E62828BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 04:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1754D2FF;
	Tue, 12 Dec 2023 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1lwv4he"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE31E94;
	Mon, 11 Dec 2023 20:01:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso18622a12.1;
        Mon, 11 Dec 2023 20:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702353678; x=1702958478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EidiZCNULSAajLAFQxtw/FmzbQlFlMFC8XdMcEUFUk=;
        b=W1lwv4heaJK9WGDs/u7clHsdkhkAYzH2NJWmkpkLBX3rR+kNqSabN+jAxu2WtEQ+MP
         WzOfY1jaO8154kbTtecre5XYH7C493tQOy2SnVYwEViLYZP36erP+67vIPsU/Sq+OJYm
         xHwJjdqDKY08THTclQ+bEBTLTJSjIe9IScPWBVsWAsXUxHVsBYN3DKmNEeG6bxO/QYqF
         I2XhbLweTV3DcOUPzo3DJEjaF2mSx7NdyQipDo9KH2FF6J2PL3Yy1gtCs1pbjTAFFj3q
         4ZpA933X2hGJL0bBnBnfXJNPQGLPnpdlrHIufq7NgwYIyXGd06UCO1mBass0Ed5kNlAs
         vvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702353678; x=1702958478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EidiZCNULSAajLAFQxtw/FmzbQlFlMFC8XdMcEUFUk=;
        b=FP0oLBq5PfmXlAyfGaoBVXnhmN1X9ymlWQ6KnFy2s4MEu4RR92nfmxTnpoou2NfKrU
         j2La0bHgYYFr1vwEdsEDZgV16NtvaHPSt4um91YQvMta0KXwsJ29rEaeULnaSH8knEJe
         PDrbh62Y4AlPxcfVMJISJNL72DkYjT4rIzvfNV/1fyxSPwI5jFA4z0AMLlR5Q9KNs6lx
         cw7EF1n6Mw9R7U7V7+ihnk5nacc8M+o4zrKcBbJPQYWWc+UIEpojsDh+ToVq72HyTQOD
         yfJR6H336rYuf3jsTNy36FKWwv3LLQwliyW0rHgJ097H/lqqLCk70M08Zspiil5vtrIo
         +2Tw==
X-Gm-Message-State: AOJu0YxKpOYmDMfui/nPIKIdsjhGHhLcnPKrEImchAPTYk0HZ8q1s9RJ
	TeKaoqW1c7uhGxdiREJyGzThHw1KtEIm14SBy3c=
X-Google-Smtp-Source: AGHT+IEvbseHAT2zVelMSrUH3n8lUBT+bpmTqv+366RIJDikfD+cb0zeuxNmtbf6QH82bANaA/r0gKN/5EkrSrTjYJ0=
X-Received: by 2002:a17:906:f848:b0:9bf:7ae7:fd6c with SMTP id
 ks8-20020a170906f84800b009bf7ae7fd6cmr2118954ejb.10.1702353678210; Mon, 11
 Dec 2023 20:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207222755.3920286-1-andrii@kernel.org> <20231207222755.3920286-2-andrii@kernel.org>
 <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com>
In-Reply-To: <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 20:01:06 -0800
Message-ID: <CAEf4BzYHHdQsaGBFXnY8omP4hv_tUjqxHWTNoEugi3acrE5q=A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 2:28=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > +#define __BPF_CMD_MAPPER(FN, ctx...)                                  =
 \
> > +       FN(BPF_MAP_CREATE, 0)                                          =
 \
> > +       FN(BPF_MAP_LOOKUP_ELEM, 1)                                     =
 \
> > +       FN(BPF_MAP_UPDATE_ELEM, 2)                                     =
 \
> > +       FN(BPF_MAP_DELETE_ELEM, 3)                                     =
 \
> > +       FN(BPF_MAP_GET_NEXT_KEY, 4)                                    =
 \
>
> So macro conversion across 4 main enums in uapi/bpf.h
> is just to do:
> +static const struct constant_table cmd_kvs[] =3D {
> +       __BPF_CMD_MAPPER(__BPF_KV_FN)
> +       {}
> +};
>
> on the kernel side,
> right?

Right.

>
> While in libbpf we already hard code name to value in arrays:
> prog_type_name[], map_type_name[]
>
> which probably will remain as-is, since libbpf needs to be
> built independently from the kernel.
> (unless we will say that tools/uapi/bpf.h is part of libbpf,
> which probably not a good way).

No, we can easily use this on the libbpf side as well. Libbpf syncs
the latest UAPI headers ([0]) and uses them during build time.

  [0] https://github.com/libbpf/libbpf/tree/master/include/uapi/linux

>
> There are more pros than cons in this enum uglification,
> but cons are definitely staring in the face.
>
> Have you considered other options?
> Like using vmlinix BTF for parsing bpffs delegation?
> [14083] ENUM 'bpf_cmd' encoding=3DUNSIGNED size=3D4 vlen=3D39
>         'BPF_MAP_CREATE' val=3D0
>         'BPF_MAP_LOOKUP_ELEM' val=3D1
>         'BPF_MAP_UPDATE_ELEM' val=3D2
>         'BPF_MAP_DELETE_ELEM' val=3D3
>         'BPF_MAP_GET_NEXT_KEY' val=3D4
>         'BPF_PROG_LOAD' val=3D5
>
> Names and values are available.
> btf_find_by_name_kind(vmlinux_btf, "bpd_cmd", BTF_KIND_ENUM);
> is fast enough.
>
> I suspect you'll argue that you don't want to tie in
> bpffs delegation parsing with BTF ;)
>

Yep, that's the reason I didn't go for it in the initial version, of
course. But it's fine.

> While I can preemptively answer that in the case vmlinux BTF
> is not available it's fine not to parse names and rely on hex.

It's fine, I can do optional BTF-based parsing, if that's what you prefer.

