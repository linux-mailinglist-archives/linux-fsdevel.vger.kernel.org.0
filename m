Return-Path: <linux-fsdevel+bounces-6508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AE818CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13D0B25261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B820B14;
	Tue, 19 Dec 2023 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki2VFMek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D420DCB;
	Tue, 19 Dec 2023 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3365424df34so3403952f8f.1;
        Tue, 19 Dec 2023 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004726; x=1703609526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GLvCstwna63ydpnr0GOl4Ke6mQGm0dr9s2ijUtUgXY=;
        b=Ki2VFMek/xsZ4XjfWkTHn7V4gV51hCFIHFIa4PfFdQ9Ak2BrO1drAF5wd+2rEGO0eU
         vqEIN35msn/WtZtOcL+DdSUrR8xP49WG/eRMiwRr4DJsB2VJ+KtrObPbhn85IlxgSfzC
         zn5ts1yE3K7jNmE9TCIjvwt8milVPChtzoLBVfqXwiEuPxeHVf8Ilmeepg6KZp7LED04
         95J0gMItverqqCREcP3xe2tlelbeVJtY9JlMsklGv1Ppu2mxNaCGvaKxNRbXmnuV5ngS
         culd6uwiT3/xvXolLKTd4yU+VbMaah8G15xyc2pQiXAZ/na8QEsl1dqjqMbCLvbUtf4x
         2ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004726; x=1703609526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GLvCstwna63ydpnr0GOl4Ke6mQGm0dr9s2ijUtUgXY=;
        b=KKsyFI3aR5zuBWg2YwXy4IoDeEhRjqiXZ0glblDKGP4eE3MKhaKtCbML3FqxtgcVOU
         8KUbS9n7k09G8NMvQmW44/i3LO4ucHOQvFbpBdY70sT+zpDxRZ0H+zD/hoSRcu+JcrNb
         QAfnUmbXvye6jBACTZiU5FsvP+8fr3nJauTLostux1hQaCXYPVIJ1rYaqWDGemkVgIS/
         qQONBpnwO9Vnrnl0PtUFyJ3Imdh6fagvxCgl1wrKazgIe3Elf89No2WZGGeGldfkgoyr
         KgAsrALhj8Kb5RRmv98mo8pjhk01ScQgKZCCBKPCpxeqbZH0lN0+CwBMDI2QHqjQNNcR
         ZbwA==
X-Gm-Message-State: AOJu0Ywrf3A0ARHjtlcgMBBlIXopIrgt1QZVVxyR9oMEnpa+UWxMZVtD
	wTM8u3BFYgClD5sHScP3OiGMk06Sfkq+l9QDDOo=
X-Google-Smtp-Source: AGHT+IFUdYhOFI+ztXVvJTHE2WZwlOBs2Rv9Z0oqAAqGwo0OS6EyKgi3w+3k3bX88MEGfPyxAfPz/mM4Tbe9vrmy45Q=
X-Received: by 2002:adf:e58c:0:b0:336:5d2c:ac5e with SMTP id
 l12-20020adfe58c000000b003365d2cac5emr3404881wrm.95.1703004726137; Tue, 19
 Dec 2023 08:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner> <ZYG/gR6Kl9+11Myl@casper.infradead.org>
In-Reply-To: <ZYG/gR6Kl9+11Myl@casper.infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 08:51:54 -0800
Message-ID: <CAADnVQ+CapO+5pAAe11CeAzFgjf6rizBDAtcXGh-n4sbUg4-cA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:06=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Dec 19, 2023 at 11:23:50AM +0100, Christian Brauner wrote:
> > Alexei, Andrii, this is a massive breach of trust and flatout
> > disrespectful. I barely reword mails and believe me I've reworded this
> > mail many times. I'm furious.
> >
> > Over the last couple of months since LSFMM in May 2023 until almost las=
t
> > week I've given you extensive design and review for this whole approach
> > to get this into even remotely sane shape from a VFS perspective.
>
> This isn't new behaviour from the BPF people.  They always go their own
> way on everything.  They refuse to collaborate with anyone in MM to make
> the memory allocators work with their constraints; instead they implement
> their own.  It feels like they're on a Mission From God to implement the
> BPF Operating System and dealing with everyone else is an inconvenience.
>
> https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gma=
il.com/

Matthew,
I thought I answered in that thread that it is not a memory allocator.
It's small free list of cached elements that bpf prog peeks from
when prog runs in unknown context =3D=3D tracing deep inside the kernel.
Do you want to design a memory allocator that is fully re-entrant ?
Meaning that kmalloc(GFP_REENTRANT) can be called from any context
deep inside slab, inside arch code, inside _any_ and all code of the kernel=
?
If the answer is yes, please go ahead.
We'll happily switch to your thing.
We used to preallocate all memory for such tracing use cases
which was wasteful. This thingy is preallocating a few elements instead
of preallocating them all. That's all there is.

