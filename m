Return-Path: <linux-fsdevel+bounces-6506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143F818CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BFD1C24A8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFC208C6;
	Tue, 19 Dec 2023 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADiazSuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6233208DB;
	Tue, 19 Dec 2023 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4558688f8f.0;
        Tue, 19 Dec 2023 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004181; x=1703608981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA8ma61c5VA1VLN+6Z4AkxkBS4nuZnIBD8TFM2qLcS8=;
        b=ADiazSuOH7pDHsB3Bt0jjGnktyU4zI4POvKe+lCRhCkVPumXvLHVgV6z30zrSIqzQx
         g+dDNUdBfxgkaaApFhOMRTmijB5/4At2cMXA5HU0yM5+kAM7pvIZX0WpnDh1pQZxwdUH
         kAqZ+2vlMrA18cuYA9qim0z3thdVcuTEZcDRLtHN97O8kUzIDCbpmkm02OkQ9/ZR5wX4
         TwB2l4jO/jZqmDzJ+tza7zl2FOGxwqRot5U/KomPit0ZMHvd0ZhtP+vpbIdkCx9Pe8h1
         8KZEl8iQ3vkzklIl2HyQ2drrcoWPQOGGGFqyHuFB6KrRgRZmb8Zla0UtTqsXr5lGc6b6
         RKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004181; x=1703608981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA8ma61c5VA1VLN+6Z4AkxkBS4nuZnIBD8TFM2qLcS8=;
        b=ohR2/r9Bpi0ltNO/q4oOolz/dxuswsgpBBF4GDBRC1nXWpX4f786rlf51TfFAb9Vw8
         V8dIDXB7feUSqSYb/fKZvO2F93w9OckL6qwE6nu7ndhoLQTgcHzrBydvoqoWXhRfpcDw
         Zer6oeWUIy0Spz+MfbcXsXNFzvuMzvx0NCzGOHdKoFV8vAR3qWObZI9u+Dab/ZfAZoUj
         aLIPLEuenG+E91KOamqyoLEKuwkpFWiBTeNMiRQCT1xwv26Bbr5iInSBdxTRb7VuHBpH
         JX4BiVMfS7SmtUI0zcTjrqyjDE6Hpbue7EW3524hZ+pepiGWgHxJQ9gqB94yqGvXLPa2
         lpcw==
X-Gm-Message-State: AOJu0YwVc3GilsqogLGRhMHOTeGET/efXHyaIQwCFoXUERIGThwFWayW
	7FUb7mXSLcgXettPh29I4DsLNnrfzUNxL6LDb9M=
X-Google-Smtp-Source: AGHT+IHoxHdXu6AAkWSmdVhZsBiQzZspQkAdqJsmilCPLpuh5lUDCK47plWdtltOyBCOY8Ps8bwSUTdVBYT/B71crT0=
X-Received: by 2002:a5d:490e:0:b0:336:62fb:7698 with SMTP id
 x14-20020a5d490e000000b0033662fb7698mr2615914wrq.141.1703004180726; Tue, 19
 Dec 2023 08:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com> <20231219-kinofilm-legen-305bd52c15db@brauner>
In-Reply-To: <20231219-kinofilm-legen-305bd52c15db@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 08:42:48 -0800
Message-ID: <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Dec 18, 2023 at 05:11:23PM -0800, Linus Torvalds wrote:
> > On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > 2) Introduce BPF token object, from Andrii Nakryiko.
> >
> > I assume this is why I and some other unusual recipients are cc'd,
> > because the networking people feel like they can't judge this and
> > shouldn't merge non-networking code like this.
> >
> > Honestly, I was told - and expected - that this part would come in a
> > branch of its own, so that it would be sanely reviewable.
> >
> > Now it's mixed in with everything else.
> >
> > This is *literally* why we have branches in git, so that people can
> > make more independent changes and judgements, and so that we don't
> > have to be in a situation where "look, here's ten different things,
> > pull it all or nothing".
> >
> > Many of the changes *look* like they are in branches, but they've been
> > the "fake branches" that are just done as "patch series in a branch,
> > with the cover letter as the merge message".
> >
> > Which is great for maintaining that cover letter information and a
> > certain amount of historical clarity, but not helpful AT ALL for the
> > "independent changes" thing when it is all mixed up in history, where
> > independent things are mostly serialized and not actually independent
> > in history at all.
> >
> > So now it appears to be one big mess, and exactly that "all or
> > nothing" thing that isn't great, since the whole point was that the
> > networking people weren't comfortable with the reviewing filesystem
> > side.
> >
> > And honestly, the bpf side *still* seems to be absolutely conbfused
> > and complkete crap when it comes to file descriptors.
> >
> > I took a quick look, and I *still* see new code being introduced there
> > that thinks that file descriptor zero is special, and we tols you a
> > *year* ago that that wasn't true, and that you need to fix this.
> >
> > I literally see complete garbage like tghis:
> >
> >         ..
> >         __u32 btf_token_fd;
> >         ...
> >         if (attr->btf_token_fd) {
> >                 token =3D bpf_token_get_from_fd(attr->btf_token_fd);
> >
> > and this is all *new* code that makes that same bogus sh*t-for-brains
> > mistake that was wrong the first time.
> >
> > So now I'm saying NAK. Enough is enough.  No more of this crazy "I
> > don't understand even the _basics_ of file descriptors, and yet I'm
> > introducing new random interfaces".
> >
> > I know you thought fd zero was something invalid. You were told
> > otherwise. Apparently you just ignored being wrong, and have decided
> > to double down on being wrong.
> >
> > We don't take this kind of flat-Earther crap.
> >
> > File descriptors don't start at 1. Deal with reality. Stop making the
> > same mistake over and over. If you ant to have a "no file descriptor"
> > flag, you use a signed type, and a signed value for that, because file
> > descriptor zero is perfectly valid, and I don't want to hear any more
> > uninformed denialism.
> >
> > Stop polluting the kernel with incorrect assumptions.
> >
> > So yes, I will keep NAK'ing this until this kind of fundamental
> > mistake is fixed. This is not rocket science, and this is not
> > something that wasn't discussed before. Your ignorance has now turned
> > from "I didn't know" to "I didn 't care", and at that point I really
> > don't want to see new code any more.
>
> Alexei, Andrii, this is a massive breach of trust and flatout
> disrespectful. I barely reword mails and believe me I've reworded this
> mail many times. I'm furious.
>
> Over the last couple of months since LSFMM in May 2023 until almost last
> week I've given you extensive design and review for this whole approach
> to get this into even remotely sane shape from a VFS perspective.
>
> The VFS maintainers including Linus have explicitly NAKed this "zero is
> not a valid fd nonsense" and told you to stop doing that. We told you
> that such fundamental VFS semantics are not yours to decide.
>
> And yet you put a patch into a series that did exactly that and then had
> the unbelievable audacity to repeatedly ask me to put my ACK under this
> - both in person and on list.
>
> I'm glad I only gave my ACK to the two patches that I extensivly
> reviewed and never to the whole series.

fwiw to three patches:
https://lore.kernel.org/bpf/20231208-besessen-vibrieren-4e963e3ca3ba@braune=
r/
which are all the main bits of it.

The patch 4 that does:
if (attr->map_token_fd)
wasn't sneaked in in any way.
You were cc-ed on it just like linux-fsdevel@vger
during all 12 revisions of the token series over many months.

So this accusation of breach of trust is baseless.

Indeed we didn't internalize that you guys hate fd=3D0 so much.
In the past you made it clear fd=3D0 shouldn't be an alias to AT_FDCWD.
We got that part. Meaning of fd=3D0 here wasn't a special new thing.
We made this mistake in the past and assumed it's ok-ish to continue
in similar situations.
As I said. Point taken. We'll use flag+fd approach as Linus suggested.

