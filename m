Return-Path: <linux-fsdevel+bounces-5987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E943811AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E2F2829C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6656B9D;
	Wed, 13 Dec 2023 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJS5ypMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB68EA;
	Wed, 13 Dec 2023 09:26:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5522bfba795so949933a12.2;
        Wed, 13 Dec 2023 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488401; x=1703093201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld0B1jUksqKbXhxjO1khXY1xboG0f1gEIjrhs47Odww=;
        b=AJS5ypMOACfR4rCU2mIwsYA9weMkiRJNDHDZ2agym4gKmtL7qjOOAAceCWYnSgrjWq
         dJpl69dR5ueH4Ts/PXfAyJe1eWf1oKs3SI2zIFwPKlAvNaHoJAB07EkOOtm4kXxd15DZ
         s7vLz3Gr3qfm9s9U+H9UOIyVUCTLzDNHFTQ/9j5NVuRR8+La5VG+BKLoAwdO3ZG0eV8B
         BnRZHPmkWdcVcqyi2FkxgDW83XE4Znt2STctg/p7Ic+heCRECjVL7td+HOWi4keQHDIb
         B8l+fUL2rz3suoDXEJaUsg43AOSOVmPuhfLuLnAn5ztxW/zv4ZbhBFXPF1RwoOJvKm/3
         9DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488401; x=1703093201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld0B1jUksqKbXhxjO1khXY1xboG0f1gEIjrhs47Odww=;
        b=MCEqX0VJXsrn0cCZeEzBMcfvmKOI+QJ8r8H8m1D8xcO/yPIGH7fFSBpf+sWlbfoj/T
         JxUZH3ucT54MnRqEanyU2CfVeBh+BqiLZWKZWk6VPRQIhdSn2rzorMpAL5BXgTF9xDm3
         +2Jp0JK9SH0yi1ccoCkw/F+/XghYn1zKBPybZnke8a9biXDyjcysAgtWURt+T5gb1065
         O9RVRFXOhh1hFdeMgxbPffFZj9kv5uPcrwHL7VM9GxoHExKciv/fviKb1RvQFCIkQy82
         1FI2w13FnQ6PBRK8c041O1h+s36RQbENDxQI7sqhf+T7kBi4NI+v6libOozCQ/exXlez
         Eykg==
X-Gm-Message-State: AOJu0YwgoUPP2yqBDWrJPiFnAe4zW+ydVQYxLbQfU83s+yATSlZNkVxO
	IK6VTzZvUDOPv0WPbBT3Wuy7I2UAWMpyG4JshbA=
X-Google-Smtp-Source: AGHT+IGq3M67HTy5rdu/IY9FndPLLuQSSg3Da+u605aRWD46UDNw8xTFi6K5KvxhiaDW/EPwyxFOBFO3ccwL+SRBrZo=
X-Received: by 2002:a17:906:9d12:b0:9e5:2c72:9409 with SMTP id
 fn18-20020a1709069d1200b009e52c729409mr3534316ejc.43.1702488401076; Wed, 13
 Dec 2023 09:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207222755.3920286-1-andrii@kernel.org> <20231207222755.3920286-2-andrii@kernel.org>
 <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com>
 <CAEf4BzYHHdQsaGBFXnY8omP4hv_tUjqxHWTNoEugi3acrE5q=A@mail.gmail.com>
 <CAADnVQLoZpugU6gexuD4ru6VCZ8iQMoLWLByjHA6hush5hUwug@mail.gmail.com> <b683d150-5fa0-4bec-af07-c709ee4781d6@linux.dev>
In-Reply-To: <b683d150-5fa0-4bec-af07-c709ee4781d6@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 09:26:28 -0800
Message-ID: <CAEf4BzZyOCmo1CFMGQG5TRWetMqWNbwsgB0CNNpeB_6aB9jxzA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:37=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/11/23 8:06 PM, Alexei Starovoitov wrote:
> > On Mon, Dec 11, 2023 at 8:01=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >>
> >>> While I can preemptively answer that in the case vmlinux BTF
> >>> is not available it's fine not to parse names and rely on hex.
> >>
> >> It's fine, I can do optional BTF-based parsing, if that's what you pre=
fer.
> >
> > I prefer to keep uapi/bpf.h as-is and use BTF.
> > But I'd like to hear what Daniel's and Martin's preferences are.
>
> I think user will find it useful to have a more readable uapi header file=
. It

I'd say having numeric values make it more readable, but that's a
separate discussion. I purposefully kept full BPF_-prefixed names
intact for readability, as opposed to what we do for enum bpf_func_id.

> would be nice to keep the current uapi/bpf.h form if there is another sol=
ution.

Ok, I'll use BTF, no problem.

