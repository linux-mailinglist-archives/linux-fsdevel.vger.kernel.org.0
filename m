Return-Path: <linux-fsdevel+bounces-6205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E045F814F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 19:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345E3284727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0763588B;
	Fri, 15 Dec 2023 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dluC6H4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526CC30112;
	Fri, 15 Dec 2023 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso11061305e9.2;
        Fri, 15 Dec 2023 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702663699; x=1703268499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJzjGTcIrONlR8W+k0d0BBT1pQzf5R27kgsHXzhdVcE=;
        b=dluC6H4zA96yZ3rhuDskew9H0hjBXp5XtYv2cwFmBSfxVG3MKJ1Q6DR2rHKT2ihjfJ
         ZY4guTXRbCwhHG1cEtbgahe4ZKgY79rBwA5NBPB3lVql7Z6X57fJcSwWQbJXwisOz2bu
         LTTA+0FDzguRu0z2g/QZpbiO7JqIEh5qAj0Cb+m+f2+oqsttqOzPnO1POpBj+1qikj2t
         qOrnkT2ZFQAU9y0/sH34pM1xIrjCQcMSuwgNvZvgunDmnelMQHz82Re6wLz7B0FsFNwS
         5XfZ6Mf9a2qw/LtMwJr1y+UIO1Hp7WGVAZuUwqhNTpe5qfhqeyUfdFFpxWb6nCAsoBUf
         kBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663699; x=1703268499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJzjGTcIrONlR8W+k0d0BBT1pQzf5R27kgsHXzhdVcE=;
        b=V9a8T9no8KSasZ1ulFZ4oZNJ/8BM9tjt4pCjnAdydxjnrIAm9nUWCYDfkWNT2qyx85
         Ih2Cb05ObHex+KR0J1N8HsZAFR+jp+WEgfV4yJ+na13vGQcSQsli8Mp3H8c23P1R49x4
         lqo6L7o1pCKoMUK9K8UOMSZvtff8dn39B1uM4MF5ktrdUtpyIJ7W06eTqJuT/UJs7FNs
         NFEL4TlEJPeUjeaOTzHNNxYv5Oy1A+Tah3vwBtjyJwWRLmIGPoAWDn9ryqWJoQal/hvI
         YQo+vGoUqln9jDpQeLg1WRFKRMukvhKUntFslBlxiS3ZhIMg6wMVYtdh1M1y/Umlds13
         0mBA==
X-Gm-Message-State: AOJu0YwRbXawXCzT2OnxbqW/+h6SbAndXwnMC43Bpa53vcAs56BGwN6O
	+fQ3rpgp4nPiGrI1x2fetQAAAfmgZdZtrW/4qzE=
X-Google-Smtp-Source: AGHT+IGvvnGfZGv5SJaUaOgnZ9sTbQP2OjQ1se/V40z8eE9Imf9WIhhxLL4a7njEkKaOHOTEtUIXrwxyOWPfMMBnKrA=
X-Received: by 2002:a05:600c:3d8b:b0:40b:5e4a:406b with SMTP id
 bi11-20020a05600c3d8b00b0040b5e4a406bmr5879590wmb.139.1702663699355; Fri, 15
 Dec 2023 10:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de> <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de> <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
In-Reply-To: <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Dec 2023 10:08:08 -0800
Message-ID: <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, gyroidos@aisec.fraunhofer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:15=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Wei=C3=9F wrote:
> > On 15.12.23 13:31, Christian Brauner wrote:
> > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Wei=C3=9F wrote:
> > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > >> namespace in cooperation of an attached cgroup device program. We
> > >> just need to implement the security_inode_mknod() hook for this.
> > >> In the hook, we check if the current task is guarded by a device
> > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > >>
> > >> Access decisions to those device nodes are then guarded by existing
> > >> device cgroups mechanism.
> > >>
> > >> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> > >> ---
> > >
> > > I think you misunderstood me... My point was that I believe you don't
> > > need an additional LSM at all and no additional LSM hook. But I might=
 be
> > > wrong. Only a POC would show.
> >
> > Yeah sorry, I got your point now.
>
> I think I might have had a misconception about how this works.
> A bpf LSM program can't easily alter a kernel object such as struct
> super_block I've been told.

Right. bpf cannot change arbitrary kernel objects,
but we can add a kfunc that will change a specific bit in a specific
data structure.
Adding a new lsm hook that does:
    rc =3D call_int_hook(sb_device_access, 0, sb);
    switch (rc) {
    case 0: do X
    case 1: do Y

is the same thing, but uglier, since return code will be used
to do this action.
The 'do X' can be one kfunc
and 'do Y' can be another.
If later we find out that 'do X' is not a good idea we can remove
that kfunc.

