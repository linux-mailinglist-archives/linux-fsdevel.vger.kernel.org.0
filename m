Return-Path: <linux-fsdevel+bounces-6519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C328D818FD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A84B21705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404031739;
	Tue, 19 Dec 2023 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d75r+G0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A637D29;
	Tue, 19 Dec 2023 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso109746a12.1;
        Tue, 19 Dec 2023 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703010691; x=1703615491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGugHCK361sNlNDEPjXLzwYghYGU1Ph2hMHhF29FS4=;
        b=d75r+G0aLeuGu4aXRRpltmwiKj8UZkIT8cwF9GK6tGYhkqESVJzttleTHDuS/gEbgN
         wmvIi+woP4lJ7+koPOqVLLdjHCuo4drNUs413X64oU1rV0dfiVTjYHulONVF1X6noOR0
         AhiV9MnjNCVMbgAazW9Mv50fMDcEnEdnwGfBIoL1/kZdjoQAp9bu33hvsJ3hVhqXtNZq
         QTrZwngNpPZ1rcDo31LXk02Gj2cwQOTzZiyRtPUDeWWthZuIM0aj8Bb8uGAzpxXW569T
         6aGbFliudQUQK3h+kN3pjiG488rIgZXWJUjEyDhShrDT8+4IXdbH6F7Q2DXZunktZV5U
         HqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010691; x=1703615491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGugHCK361sNlNDEPjXLzwYghYGU1Ph2hMHhF29FS4=;
        b=BVXgYak4qK0Ro8FTY344cRQIcaTq7ge3Pn5rOdcWAB9e/AECkajGCOcjK3p4/n4bPP
         2Dxef5rqf3YtDfBPQdsqz0m2dn9NI8XGO6yvVJe8buqM1WmJTJOYNOi3KqQPadzkN4lH
         9LeQroSiS0oHhpOhkFOb5urvpk4kmfpt4cPVO2zI2Fb5YvqT/L8KDwgtXTDCq5EsOd5j
         oIjYUwrC8bHWig67Qb4YUHu20/ki4An1VXcrioetD2im0lHJpJnVmeN6+7meHb4Pj9VA
         nYOQOWZAgyWufYIHkDuZZJoTQ4mnVpO0JXZU/l0lcvReryhSzSSyThmOqy7VAJFMaGoq
         uDEQ==
X-Gm-Message-State: AOJu0YwWhOTvDFdpZehLOmsH32piXU08fMnwk8jFqb+p0Z1TU7z0vmhg
	xL1nqU7xrHISPc5E0GKYLj/KvtbzOamu4PU482M=
X-Google-Smtp-Source: AGHT+IE6wOUr1ZpMez2HtH2cj4yCTgZHbSPpmpNdet17jScwIGemQl/0sWDxSsogHmd2oyc7W+Fv24zBAtpVmJAJ4ZU=
X-Received: by 2002:a17:906:109a:b0:a26:8dc7:a5b0 with SMTP id
 u26-20020a170906109a00b00a268dc7a5b0mr14747eju.257.1703010690937; Tue, 19 Dec
 2023 10:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner> <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
In-Reply-To: <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 10:31:17 -0800
Message-ID: <CAEf4BzZvvFyRCJcWibv_n+aeusGvFQuvyfOux0-3RUT3R35Qwg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:43=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 19, 2023 at 2:23=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Mon, Dec 18, 2023 at 05:11:23PM -0800, Linus Torvalds wrote:
> > > On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > 2) Introduce BPF token object, from Andrii Nakryiko.
> > >
> > > I assume this is why I and some other unusual recipients are cc'd,
> > > because the networking people feel like they can't judge this and
> > > shouldn't merge non-networking code like this.
> > >
> > > Honestly, I was told - and expected - that this part would come in a
> > > branch of its own, so that it would be sanely reviewable.
> > >
> > > Now it's mixed in with everything else.
> > >
> > > This is *literally* why we have branches in git, so that people can
> > > make more independent changes and judgements, and so that we don't
> > > have to be in a situation where "look, here's ten different things,
> > > pull it all or nothing".
> > >
> > > Many of the changes *look* like they are in branches, but they've bee=
n
> > > the "fake branches" that are just done as "patch series in a branch,
> > > with the cover letter as the merge message".
> > >
> > > Which is great for maintaining that cover letter information and a
> > > certain amount of historical clarity, but not helpful AT ALL for the
> > > "independent changes" thing when it is all mixed up in history, where
> > > independent things are mostly serialized and not actually independent
> > > in history at all.
> > >
> > > So now it appears to be one big mess, and exactly that "all or
> > > nothing" thing that isn't great, since the whole point was that the
> > > networking people weren't comfortable with the reviewing filesystem
> > > side.
> > >
> > > And honestly, the bpf side *still* seems to be absolutely conbfused
> > > and complkete crap when it comes to file descriptors.
> > >
> > > I took a quick look, and I *still* see new code being introduced ther=
e
> > > that thinks that file descriptor zero is special, and we tols you a
> > > *year* ago that that wasn't true, and that you need to fix this.
> > >
> > > I literally see complete garbage like tghis:
> > >
> > >         ..
> > >         __u32 btf_token_fd;
> > >         ...
> > >         if (attr->btf_token_fd) {
> > >                 token =3D bpf_token_get_from_fd(attr->btf_token_fd);
> > >
> > > and this is all *new* code that makes that same bogus sh*t-for-brains
> > > mistake that was wrong the first time.
> > >
> > > So now I'm saying NAK. Enough is enough.  No more of this crazy "I
> > > don't understand even the _basics_ of file descriptors, and yet I'm
> > > introducing new random interfaces".
> > >
> > > I know you thought fd zero was something invalid. You were told
> > > otherwise. Apparently you just ignored being wrong, and have decided
> > > to double down on being wrong.
> > >
> > > We don't take this kind of flat-Earther crap.
> > >
> > > File descriptors don't start at 1. Deal with reality. Stop making the
> > > same mistake over and over. If you ant to have a "no file descriptor"
> > > flag, you use a signed type, and a signed value for that, because fil=
e
> > > descriptor zero is perfectly valid, and I don't want to hear any more
> > > uninformed denialism.
> > >
> > > Stop polluting the kernel with incorrect assumptions.
> > >
> > > So yes, I will keep NAK'ing this until this kind of fundamental
> > > mistake is fixed. This is not rocket science, and this is not
> > > something that wasn't discussed before. Your ignorance has now turned
> > > from "I didn't know" to "I didn 't care", and at that point I really
> > > don't want to see new code any more.
> >
> > Alexei, Andrii, this is a massive breach of trust and flatout
> > disrespectful. I barely reword mails and believe me I've reworded this
> > mail many times. I'm furious.
> >
> > Over the last couple of months since LSFMM in May 2023 until almost las=
t
> > week I've given you extensive design and review for this whole approach
> > to get this into even remotely sane shape from a VFS perspective.

Yes, and I appreciate your reviews and feedback a lot. There was never
an intent to clandestinely land anything bad or outlandish, so I'm
sorry you feel this way. I've cc'ed you and fsdevel mailing list, just
like LSM folks, on every relevant patch set, each and every patch in
them, and incorporated all the feedback I got over the last multiple
months.

> >
> > The VFS maintainers including Linus have explicitly NAKed this "zero is
> > not a valid fd nonsense" and told you to stop doing that. We told you
> > that such fundamental VFS semantics are not yours to decide.

It's on me to have interpreted FD=3D0 as AT_CWD in my original patch set
for BPF_OBJ_PIN/BPF_OBJ_GET ([0]). It was totally my fault not
thinking through all the negative consequences of defaulting to
AT_CWD, and I acknowledged that and fixed it.

It's also my bad that I kept using the "fd=3D0 means no FD was
specified" approach which has been a consistent approach within bpf()
syscall API without really thinking twice about this and how much it
might irritate kernel people. I sent a fix ([1]) and going forward
I'll remember to always add a flag for any new FD-based field in BPF
UAPI.

  [0] https://lore.kernel.org/all/20230516001348.286414-1-andrii@kernel.org=
/
  [1] https://patchwork.kernel.org/project/netdevbpf/patch/20231219053150.3=
36991-1-andrii@kernel.org/

> >
> > And yet you put a patch into a series that did exactly that and then ha=
d
> > the unbelievable audacity to repeatedly ask me to put my ACK under this
> > - both in person and on list.

I did ask for a review and an ack as a sign that it looks good to you.
Precisely to make sure that *everything* looks good overall from the
POV of people outside of the BPF subsystem. I didn't ask for rubber
stamping anything, if that's what is implied here.

> >
> > I'm glad I only gave my ACK to the two patches that I extensivly
> > reviewed and never to the whole series.
>
> fwiw to three patches:
> https://lore.kernel.org/bpf/20231208-besessen-vibrieren-4e963e3ca3ba@brau=
ner/
> which are all the main bits of it.
>
> The patch 4 that does:
> if (attr->map_token_fd)
> wasn't sneaked in in any way.
> You were cc-ed on it just like linux-fsdevel@vger
> during all 12 revisions of the token series over many months.
>
> So this accusation of breach of trust is baseless.
>
> Indeed we didn't internalize that you guys hate fd=3D0 so much.
> In the past you made it clear fd=3D0 shouldn't be an alias to AT_FDCWD.

Right, and AT_FDCWD interpretation for fd=3D0 had security implications
which was a clear and a bad bug.

> We got that part. Meaning of fd=3D0 here wasn't a special new thing.
> We made this mistake in the past and assumed it's ok-ish to continue
> in similar situations.
> As I said. Point taken. We'll use flag+fd approach as Linus suggested.

Yes, I second the above.

