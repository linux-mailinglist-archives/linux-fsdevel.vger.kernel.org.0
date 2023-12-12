Return-Path: <linux-fsdevel+bounces-5614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80380E332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82B2B20E82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 04:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB82D310;
	Tue, 12 Dec 2023 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhKRQZId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3DA9;
	Mon, 11 Dec 2023 20:06:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-336221efdceso1317750f8f.3;
        Mon, 11 Dec 2023 20:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354017; x=1702958817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4PDLpNqN8G4f2/fc3zgmjB7jzBthMeahHykX9V98V8=;
        b=EhKRQZIdoelgxFTs02vho57+hzLu1ccqPLsGp832Y9k1aapu9c82UYfr5LHUw+Baob
         vXPKlIRAxwWhky7UeWjE4x0LpRb/txyaBQwlb/FvHLpPpljAtvlaXFxAK3GcbPPiAn2q
         9Gq8/CAm++KQXgRbsUIL4wR4PkUj98NFSt3oN4sQE69+gHsTyD7995L8ni50WQhL9ZGl
         tnHEPwnt4lwJDUsYq7zNGQ4EaUwp9I5RzKouoypB6wbSL9baiuBIfRA0XNu0qWKqs9LZ
         WxUA/owD0x59LlOFW12eQg/UAyvg/z+w9GKrsnC7R4IaaLM3UMFKwgLtnnlZb4HWhClT
         5JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354017; x=1702958817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4PDLpNqN8G4f2/fc3zgmjB7jzBthMeahHykX9V98V8=;
        b=gRPzgTB+gP80ivl+Bua0dYgsY5j04zFsvkheel6E58LAQTmu4ZzJ18PZxo6FrWH4IK
         9fagOVmIfYgHc6AxxwVqy80OPmwE8K1Y90pfUCpU1AfcMW5USkDpIvof8kxXiV4f6tOf
         44+iqUEmcj8E17/DddA4yz57gI3DizqYtjMSB8pd2P7+D19XdaK65af9IjL4AjXLkYWm
         0L6E+eDQJRmG9r8+IbcBM3XHQP8bMYEyiz1hQCD8NT6VtjpKfwfzsU3JoPQiuEawe/FW
         5igZ3E+8HZTPdySEj4gm9boH3gknLLplvaWF0oFJgHnUNvHMhqNqkFbfnSYznJVHjT/Q
         Y29Q==
X-Gm-Message-State: AOJu0YzA0UGTvYize1fGXxyIJJFo5JtPA6nzSmKRBeeMNlcDb4wJiXZo
	G3Z+MGZdzXCfaS6z9vG450JY/k4v4wT/H6V++dE=
X-Google-Smtp-Source: AGHT+IFQhZdmo9N4ED+3NGyeIU27RgYMOj1Rl3ycSm/vsY8qxg1+4c/86vvUA3CzsHfhNwJ+QYv42b5r52ZXNvk5VvY=
X-Received: by 2002:a5d:69cb:0:b0:334:75fc:4430 with SMTP id
 s11-20020a5d69cb000000b0033475fc4430mr1226525wrw.176.1702354016999; Mon, 11
 Dec 2023 20:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207222755.3920286-1-andrii@kernel.org> <20231207222755.3920286-2-andrii@kernel.org>
 <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com> <CAEf4BzYHHdQsaGBFXnY8omP4hv_tUjqxHWTNoEugi3acrE5q=A@mail.gmail.com>
In-Reply-To: <CAEf4BzYHHdQsaGBFXnY8omP4hv_tUjqxHWTNoEugi3acrE5q=A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Dec 2023 20:06:45 -0800
Message-ID: <CAADnVQLoZpugU6gexuD4ru6VCZ8iQMoLWLByjHA6hush5hUwug@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:01=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> > While I can preemptively answer that in the case vmlinux BTF
> > is not available it's fine not to parse names and rely on hex.
>
> It's fine, I can do optional BTF-based parsing, if that's what you prefer=
.

I prefer to keep uapi/bpf.h as-is and use BTF.
But I'd like to hear what Daniel's and Martin's preferences are.

