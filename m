Return-Path: <linux-fsdevel+bounces-5041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786F8077D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967D7282158
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507126EB57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbCuwLR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC3D5A;
	Wed,  6 Dec 2023 10:24:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1c890f9b55so4327466b.1;
        Wed, 06 Dec 2023 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701887085; x=1702491885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hymZLMkFf6s/DnyiwuB/acMDQ7OLJSqS0MPYzZqPxYU=;
        b=LbCuwLR1dwKLrzm7G7GtdqbbF7O9cyTl3R3x1Bva3K5xj/GMUfJ+LIUn01YQk1uw89
         gX6W7tF3VriWg1uhiOnx/G662ELDjCeWUhdSXM5hG1CM02lJDF53NfZgdXm46gzeENjI
         tlJHJXVNml3ckXrKLxLJcHWIGCgIAf5/hg2by7OPzuw9nOcjutcBpXVZWxMOZe2smLqI
         2FbJ7XJVUlXy9kBKXHruX6qydsfUK56PDUZbwKy9SxLfBcVxpQwCl0v3ny956sMWykyK
         ZOz3xCuWeKqRd66K48W2fO76BFXEKEXZQy1VoBKYxMgZo/YYxai0uvl2yFcuRG8v+oZL
         J+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887085; x=1702491885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hymZLMkFf6s/DnyiwuB/acMDQ7OLJSqS0MPYzZqPxYU=;
        b=cQQC5iLhJUxMvaAM+d4/NWYMs8l5rE7oyd2rf29PEoFg3cJiDlN9v+aLNDmcdp2UHm
         tqvuHURplVSlovA9DS2leYetSzEDPXvuE6m5m0C0ugna3v2O61+ZRS1h/YjS+X8uUdwo
         0xtUaKqUB/JmMSkYsJ2DCGBrN8o1b5lZSX3XHRTFFRWcdSLKrNWDXwIyukHlQTAxic3S
         90Nz4BF863zuOrANBfShSNAakx5qeh259Ri2IT++7RguHvTeKBpTI1kd5Cwc4NDfOTwj
         54yzn0kltJX9jpPlLy2xY89Piknyd+WbMfdQtrcUwOjBycAtxKrYBTofqE9WrO2xnEDT
         MGpA==
X-Gm-Message-State: AOJu0YzDdz1iNICdaT8z3jSJP3jFfrxkjUwIAuV81AENCUHnm5KtcW1z
	sJgGowb29JEfqOokktRhaj5dUd+wVutbp4io8cg=
X-Google-Smtp-Source: AGHT+IFPE3koNKI8CODmosSCzDtPb4+ESL3iSMDpxZwrBRth36OVE778kw3mUhrhm9xFDCGyOHWVI4hz+v4hUNF0ZtI=
X-Received: by 2002:a17:906:7f08:b0:9fc:93e1:c6bc with SMTP id
 d8-20020a1709067f0800b009fc93e1c6bcmr1013736ejr.33.1701887085179; Wed, 06 Dec
 2023 10:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130185229.2688956-1-andrii@kernel.org> <20231130185229.2688956-4-andrii@kernel.org>
 <CAADnVQLbxWPM1njsE141dQjw2+USd8Ggv80QgY+PgsGRd6FoVA@mail.gmail.com>
In-Reply-To: <CAADnVQLbxWPM1njsE141dQjw2+USd8Ggv80QgY+PgsGRd6FoVA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 10:24:33 -0800
Message-ID: <CAEf4BzYNU=zSAm4JpwVAJ-krfRdC+xnA_GF=wxhv8HL-VOp2Sw@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 03/17] bpf: introduce BPF token object
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Kernel Team <kernel-team@meta.com>, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 10:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 30, 2023 at 10:57=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >   *
> > @@ -901,6 +931,8 @@ enum bpf_cmd {
> >         BPF_ITER_CREATE,
> >         BPF_LINK_DETACH,
> >         BPF_PROG_BIND_MAP,
> > +       BPF_TOKEN_CREATE,
> > +       __MAX_BPF_CMD,
> >  };
>
> Not an issue with this commit. I just noticed that
> commit f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf=
_link")
> added MAX_BPF_LINK_TYPE to enum bpf_link_type.
> While this commit is correctly adding __MAX_BPF_CMD that
> is consistent with old __MAX_BPF_ATTACH_TYPE (added in 2016)
> and __MAX_BPF_REG (added in 2014).
> I think it would be good to follow up with adding two underscores
> to MAX_BPF_LINK_TYPE just to keep things consistent in bpf.h.

I'll send a small patch adjusting this

