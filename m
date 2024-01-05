Return-Path: <linux-fsdevel+bounces-7497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8DF825C88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 23:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E044BB23467
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033836091;
	Fri,  5 Jan 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPGryJ/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE6358B7;
	Fri,  5 Jan 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so58855f8f.1;
        Fri, 05 Jan 2024 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704493675; x=1705098475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INJlDxxMmwnEVeghNo4tVwU1FXS69DXew60SU5MDjaI=;
        b=fPGryJ/J10d/vCq7lJ51s5ZFWaWNKz+mnYG1BsA43AiMLskFCMDPirBIk20Ye3e/PP
         kdRmNya0buy1/+212tCHkB/nej7sDDO8gRDLCIdF0VROCD4RP13aVqcnZtIZS9RpkBBp
         XF6fFGxL3d+8KgVIksz21wPiiDZF5WDh//gPRPHxuMmmZ3EkNuZRMEmLsw3U+ZiO40CW
         lpvX3qpWpf/suaFcnWmBgx9sCmB2KshiD5uP/Or3xI23TBLUgHwmELtFdpHPIW6fJQby
         msk/KngB7inioprTvdqdIT28XapEWRmSvnvA8hPkQWHferBJCm0c/ufhSA+PL0Wz5oi6
         A4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493675; x=1705098475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INJlDxxMmwnEVeghNo4tVwU1FXS69DXew60SU5MDjaI=;
        b=p6XeiAVADgF9X6A64lyWnH5wJyWJxCLXhTSJaVzpieUqfidotv7nN8U0aJ2uJWywDv
         GV8fl1katt1LbWaCKc/P6kjhIvvZtQkcqJs8fSrJwIAS2vY7apaRoSzMJbHW4lJmT/N1
         M2eiAPdmjUBZ44onG1f7JfP2kfV9AyDu7vhKTEFlBCr/dgxvJcjSsMBYrrFm9ln1kx4O
         /La30vNLA259AvEjf5BqdUVuWOd+V1LfPUqOJo0uK+SmXBsVGbNxijcEQnC492a5ZvzO
         jNS4LDrxEWwCtTHQGedQTCf8S7SCUedUjVbXJWjvHi1i/t+Yi1aUyoP7uc7/jVWKyx19
         QhEA==
X-Gm-Message-State: AOJu0Ywq1E5sLukL6/kpx0+R/aSGdklt61XN/l0g+/HGVpZkUsou56I8
	SRiQ8XzcuXZ2jaetFYUA6lPh6Vm8C3zhPJhJ4pE=
X-Google-Smtp-Source: AGHT+IEis9JsVQd5cr9sPWdTjZxbcDKo7CvWWhF8O4sYE10CPOA5muBQlzUjZ3yqTVjRjVLCRhayPqeXzrvbYgbWBMc=
X-Received: by 2002:adf:ef89:0:b0:336:6519:86be with SMTP id
 d9-20020adfef89000000b00336651986bemr28583wro.283.1704493674840; Fri, 05 Jan
 2024 14:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com> <CAEf4Bzab84niHTdyAEkMKncNK2kXBPc7dUNpYHuXxubSM-2D4Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzab84niHTdyAEkMKncNK2kXBPc7dUNpYHuXxubSM-2D4Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jan 2024 14:27:43 -0800
Message-ID: <CAADnVQ+QP_ZfY6gqEUtW2mYgO5usX+cK9w+X5kaRt1ovf-q1Cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 5, 2024 at 12:26=E2=80=AFPM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > I'm still looking through the patches, but in the early parts I do
> > note this oddity:
> >
> > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > +struct bpf_token {
> > > +       struct work_struct work;
> > > +       atomic64_t refcnt;
> > > +       struct user_namespace *userns;
> > > +       u64 allowed_cmds;
> > > +};
> >
> > Ok, not huge, and makes sense, although I wonder if that
> >
> >         atomic64_t refcnt;
> >
> > should just be 'atomic_long_t' since presumably on 32-bit
> > architectures you can't create enough references for a 64-bit atomic
> > to make much sense.
> >
> > Or are there references to tokens that might not use any memory?
> >
> > Not a big deal, but 'atomic64_t' is very expensive on 32-bit
> > architectures, and doesn't seem to make much sense unless you really
> > specifically need 64 bits for some reason.
>
> I used atomic64_t for consistency with other BPF objects (program,
> etc) and not to have to worry even about hypothetical overflows.
> 32-bit atomic performance doesn't seem to be a big concern as a token
> is passed into a pretty heavy-weight operations that create new BPF
> object (map, program, BTF object), no matter how slow refcounting is
> it will be lost in the noise for those operations.

To add a bit more context here...

Back in 2016 Jann managed to overflow 32-bit prog/map counters:
"
On a system with >32Gbyte of physical memory,
the malicious application may overflow 32-bit bpf program refcnt.
It's also possible to overflow map refcnt on 1Tb system.
"
We mitigated that with fixed limits:
-       atomic_inc(&map->refcnt);
+       if (atomic_inc_return(&map->refcnt) > BPF_MAX_REFCNT) {
+               atomic_dec(&map->refcnt);
+               return ERR_PTR(-EBUSY);
+       }
but it created quite a lot of error handling pain throughout
the code, so eventually in 2019 we switched to atomic64_t refcnt
and never looked back.
I suspect Jann will be able to overflow 32-bit token refcnt,
so atomic64 was chosen for simplicity.
atomic_long_t might work too, but the effort to think it through
is not worth it at this point, since performance of
inc/dec doesn't matter here.

Eventually we can do a follow up and consistently update
all such counters to atomic_long_t.

