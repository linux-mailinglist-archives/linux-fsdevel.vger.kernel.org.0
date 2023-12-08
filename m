Return-Path: <linux-fsdevel+bounces-5387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369F80AFC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEBE1C20895
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC65A116;
	Fri,  8 Dec 2023 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX6UcXvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446AC3;
	Fri,  8 Dec 2023 14:40:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1da1017a09so311125366b.3;
        Fri, 08 Dec 2023 14:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702075208; x=1702680008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYNkiFjVXQKwdJFtKs4YwTgHxo/04KOB0mrqRod0x5w=;
        b=XX6UcXvxAxRtffKuxKTX8HsoN06x02cASaf5p7TqYFqGjlvuTIiSRDNKP9K7GsR6zU
         lSKOIIFJy4QADe/wr3t4RXdOpd0TpqcH0QhWpzcy8M7uTN4drGgM6/CX9n1qEhrE8tkB
         Cxu2iJqYJtWuSK4nrSHUjg741m10WXArswUIz4F8m9mbS/RiBcxasY/U3CR03vBCuRUJ
         8nxWs5evWKJW4MroDXK/GFSj9ZbvpBGUZzFCWFCZdHAMSJXdaClNMlTmIviCUVPyvRJD
         5ju/FlJvY77dhu2ZbSb06TeVSqFhVHzArab1+iK3yhq8g2DG+vxNm4eEeuY3u9hrEmBm
         F2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075208; x=1702680008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYNkiFjVXQKwdJFtKs4YwTgHxo/04KOB0mrqRod0x5w=;
        b=NQ2iYt0Ejjb99aKA00LSJ93TofzYnjK46bmXZKuY1Eq7exFz8r124AR5bPiW9TibWv
         ik9Un0oXz+mIxYSf5mqAhj60+jrWnEaiLaVEZzBXp+1aZYroTVJwqeA5e+dq0t/aii68
         QsaZIUBHgoRywtb/hWRJbv1z5Mse32aaxf89bMlmHz4PXLdW0PHLoHMzCya3uZUfeTAb
         E10vZPCpFKfjUmeIKa2X8IkHAKR3IP1EXQDWQkUwL8ajNyytPrT1ZeLGuVyg5jCz+VKA
         YQVp+DZ4VUWuVUKJroEie7i0tqyQCDrDT63nrzszJT2GQAeRM5hNYkmRs2Nra/Sj9k0e
         KhOw==
X-Gm-Message-State: AOJu0Yx4k8NaOyqaeGszT0oOhB4uT4NGHd6pr/HklHVjTixZjkRc2MaH
	X/Ycyg18YuHTGn3lsdp1tSF0LHVkY0SGowa1Dbg=
X-Google-Smtp-Source: AGHT+IHKjPU34+PthheSZ4vlLXX8zzmlKZvkxUxPxvkXiGlk9AaeBlroiLMo628HbNHn2jSnSul3yna1RU7fsbEm4ms=
X-Received: by 2002:a17:907:7206:b0:9fe:a881:81ab with SMTP id
 dr6-20020a170907720600b009fea88181abmr363065ejc.53.1702075208436; Fri, 08 Dec
 2023 14:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130185229.2688956-1-andrii@kernel.org> <20231130185229.2688956-4-andrii@kernel.org>
 <20231208-besessen-vibrieren-4e963e3ca3ba@brauner>
In-Reply-To: <20231208-besessen-vibrieren-4e963e3ca3ba@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:39:56 -0800
Message-ID: <CAEf4BzbRKxBCzKbOWg0sWMzWurF5RvF5OwizXi7tSC2vM4Zi_w@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 03/17] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:41=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Nov 30, 2023 at 10:52:15AM -0800, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while having a good amount of control over wh=
ich
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and als=
o
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> >
> > BPF token itself is just a derivative from BPF FS and can be created
> > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BP=
F
> > FS FD, which can be attained through open() API by opening BPF FS mount
> > point. Currently, BPF token "inherits" delegated command, map types,
> > prog type, and attach type bit sets from BPF FS as is. In the future,
> > having an BPF token as a separate object with its own FD, we can allow
> > to further restrict BPF token's allowable set of things either at the
> > creation time or after the fact, allowing the process to guard itself
> > further from unintentionally trying to load undesired kind of BPF
> > programs. But for now we keep things simple and just copy bit sets as i=
s.
> >
> > When BPF token is created from BPF FS mount, we take reference to the
> > BPF super block's owning user namespace, and then use that namespace fo=
r
> > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > capabilities that are normally only checked against init userns (using
> > capable()), but now we check them using ns_capable() instead (if BPF
> > token is provided). See bpf_token_capable() for details.
> >
> > Such setup means that BPF token in itself is not sufficient to grant BP=
F
> > functionality. User namespaced process has to *also* have necessary
> > combination of capabilities inside that user namespace. So while
> > previously CAP_BPF was useless when granted within user namespace, now
> > it gains a meaning and allows container managers and sys admins to have
> > a flexible control over which processes can and need to use BPF
> > functionality within the user namespace (i.e., container in practice).
> > And BPF FS delegation mount options and derived BPF tokens serve as
> > a per-container "flag" to grant overall ability to use bpf() (plus furt=
her
> > restrict on which parts of bpf() syscalls are treated as namespaced).
> >
> > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> > within the BPF FS owning user namespace, rounding up the ns_capable()
> > story of BPF token.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Same concerns as in the other mail. For the bpf_token_create() code,
> Acked-by: Christian Brauner <brauner@kernel.org>

This patch set has landed in bpf-next and there are a bunch of other
patches after it, so I presume it will be a bit problematic to add ack
after the fact. But thanks for taking another look and acking!

