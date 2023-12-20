Return-Path: <linux-fsdevel+bounces-6601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438A81A732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 20:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31DE1F2374D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A374878B;
	Wed, 20 Dec 2023 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+/OCgIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82149482D7;
	Wed, 20 Dec 2023 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-553e22940a3so21468a12.1;
        Wed, 20 Dec 2023 11:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703099893; x=1703704693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiIIBYAEbCxtdKlbklrZiyiO5jRNDof7zkuXo0Z9wpI=;
        b=D+/OCgIK6lN8LzWgkjeFjZ8ngZQuV+DWMhaxoy92T9HQ8c40Qmk6IbB2w9faiIAxu3
         R+93ZdQHspjHR9hUrbGOfxcr7Mc3lU9bBr9imAqGGraLAMuE8BK/cmEK8ASHyiST5RSh
         Hy6Ccynd27qKggW05R/7mjbLJSuUyrAxerwWt0TZU8KlNjAp3ml1TqCH1xcgriYebwCD
         CT9/5h8HgJbIMLCOLceyP77KZDI59vzUEY9mjDxL4X0Da8ABNldOA7CRdVykmMsm7DkA
         51vLpM7NDK+N+v0TcciHwfl5uKDUTFfyyOyVd66mz3hktXiQwrALPbyHVVWBwzEKfu8H
         VacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703099893; x=1703704693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiIIBYAEbCxtdKlbklrZiyiO5jRNDof7zkuXo0Z9wpI=;
        b=kefU4uKafeP0Lv2/50zNqG1yEdlRBA2uU2ZsL4B1FLhZ2PmlOZhh+bpK7B+HWgHK8T
         CIh4dQq74iP8GLyc97Gnlkiu8prDCp1CTja5pTgETExWFX3lomzOFANK5Bule9whmlmz
         FjL2y7Bx3BwZuDNEYwVtOpA5sdNKzPUSDPPdYbkfcWRHDnSbVBIcefzRM1nwCMGVhgCH
         PiEB5el1znQZHweiT2wVZLcl7//empK2Jl/c+TMes48Dx5p4vzkjSk6uHjM8xn4yYdmw
         aZuVuSzr6gzk0a7AfYlwplqd/EOJRYB1n+XbiHUhxFPS3y4OKZURZL6+pkvBJ/mq39oN
         Odsg==
X-Gm-Message-State: AOJu0Yw6BBwokc6PmwKV61MCDKQsjYpSEG8oNzUOZiYi5WjWV1sVddm+
	p9tneNx2zisFjgHFsGSC/U2vlPYJUSavx2pUzPg=
X-Google-Smtp-Source: AGHT+IH1eaxx1A+Yj7Y+uJQm36oPvMTYAKSOTN7YRkYfdwibUIsdN3JAJf3UtYehh6fpskg6ibitWw77rHFE/2xhe3k=
X-Received: by 2002:a50:f61b:0:b0:553:dc27:39f5 with SMTP id
 c27-20020a50f61b000000b00553dc2739f5mr885885edn.71.1703099892412; Wed, 20 Dec
 2023 11:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner> <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
 <20231220-einfiel-narkose-72cf400ae7e6@brauner>
In-Reply-To: <20231220-einfiel-narkose-72cf400ae7e6@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Dec 2023 11:17:59 -0800
Message-ID: <CAEf4BzYMJ1DCnRCXv4q=M-QG29Bgm+jrnkEuXNivmGmHShjnPg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:18=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > The patch 4 that does:
> > if (attr->map_token_fd)
> > wasn't sneaked in in any way.
> > You were cc-ed on it just like linux-fsdevel@vger
> > during all 12 revisions of the token series over many months.
> >
> > So this accusation of breach of trust is baseless.
>
> I was expecting this reply and I'm still disappointed.
>
> Both of you were explicitly told in very clear words that special-casing
> fd 0 is not ok.
>
> Fast forward a few weeks, you chose to not just add patches that forbid
> fd 0 again, no, the heinous part is that you chose to not lose a single
> word about this: not in the cover letter, not in the relevant commit,
> not in all the discussions we had around this.
>
> You were absolutely aware how opposed we are to this. It cannot get any
> more sneaky than this. And it's frankly insulting that you choose to
> defend this by feigning ignorance. No one is buying this.

Christian, I'm sorry you feel this way, but I refuse to accept the
blame of malicious or heinous intent. There was neither intent nor
attempt to mislead you (or anyone else for that matter) or silently
sneak anything in.

Yes, we did continue to use the convention that FD=3D0 means "no FD is
specified", which was consistent throughout BPF UAPI. But only when it
comes to passing BPF objects around (program, BTF, map, link, and
token). You hate it, I get it. But user-space already deals with this,
because it is present in BPF UAPI in many commands, and it's never a
problem in practice.

This is *very different in implications* compared to passing VFS path
FDs, like it was during the BPF_OBJ_PIN/BPF_OBJ_GET patch set ([0]).
Back then I acknowledged the wrongness of treating FD=3D0 as AT_FDCWD
due to security implications and fixed that with a special flag. It
was a special case as far as BPF UAPI goes, and it was the first one
of that kind.

In my mind, path FDs (and any other FD that points to a file or other
objects that didn't originate in bpf() syscall) and BPF FDs are two
completely different classes of cases. And that's why I didn't give it
too much thought when adding bpf_token_fd with default (for bpf()
syscall) semantics of treating FD=3D0 as "no FD was provided". It *is* a
*quirk* of the BPF UAPI that users have to take into account (and
libbpf does take into account and never returns FD=3D0 to users, so in
practice it is never a problem), but we are not defining any new
semantics here. We do say "dup your FD=3D0, if you happen to want to
pass it to BPF UAPI", a quirk that libbpf (and I presume other BPF
libraries) hides and doesn't even mention in API.

I'm elaborating on this so much just to explain *the thought process*
(and not to make excuses) and why this was done the way it was done.
This discussion made it very clear that this BPF FD special treatment
won't be tolerated. OK, ack. We are going to add new flags whenever
any FD field is added to BPF UAPI from now on.

Back in [0] I didn't remember such a strong "we forbid fd 0 again"
wording, tbh. At least before the discussion devolved into an
unfortunate "let's prevent kernel from returning fd<3" discussion.
Quoting [0] a bit:

 > If it was discussed then great but if not then I would like to make it
 > very clear that if in the future you decide to introduce custom
 > semantics for vfs provided infrastructure - especially when exposed to
 > userspace - that you please Cc us.

And I did CC you.

 > I personally find this extremely weird to treat fd 0 as anything other
 > than a random fd number as it goes against any userspace assumptions and
 > drastically deviates from basically every file descriptor interface we
 > have. I mean, you're not just saying fd 0 is invalid you're even saying
 > it means AT_FDCWD.

Yes, the AT_FDCWD thing was completely wrong. You did express general
dissatisfaction with BPF UAPI's choice to treat optional FD fields as
"no FD" if FD=3D0, and we can't fix it without breaking user-space.
Still, the way I read it was that your main concern was, justifiably,
AT_FDCWD treatment.

 > For every other interface, including those that pass fds in structs
 > whose extensibility is premised on unknown fields being set to zero,
 > have ways to make fd 0 work just fine. You could've done that to without
 > inventing custom fd semantics.

You did explicitly ask this, but still, not in a "I forbid" fashion.
Especially, taking this into account:

 > This is not a rant I'm really just trying to make sure that we agree on
 > common ground when it comes to touching each others code or semantic
 > assumptions.

I didn't feel like bpf() syscall UAPI was "touching each others code".
But I'll be honest, I'm not sure how widely I should have treated
"custom semantics for vfs provided infrastructure" and "inventing
custom fd semantics", and so I chose UAPI consistency relegating FD=3D0
convention as a BPF UAPI quirk. Are the BPF kernel objects the VFS
infrastructure? Or that was about path FDs, and other "standard" FS
files? It's a bit of a moot point now, though, as we agreed to do it
for any FD field going forward, but still, clarity would be helpful.

Again, there was no bad faith in my actions and everything was done in
the open, with plenty of opportunities and time to raise concerns.

  [0] https://lore.kernel.org/all/20230517-allabendlich-umgekehrt-8cc81f831=
3ac@brauner/

>
> But let's assume for a second that both you and Andrii somehow managed
> to forget the very clear and heated discussion on-list last time, the
> resulting LWN article written about it and the in-person discussion
> around this we had in November at LPC.

As far as I can remember LPC, we never touched on passing the BPF
token FD aspect at all during discussions. We did talk about
BPF_OBJ_PIN and how wrong it was to assume AT_FDCWD, which, again, is
objectively wrong due to potential security attacks. It seems like in
your mind AT_FDCWD and generally passing BPF object FDs is exactly the
same problem, which I disagree with, but I think that's where your
accusations come from. You can say both cases are problems, but they
are different problems (security vs deviation of API from the rest of
kernel APIs).

>
> You still would have put a major deviation from file descriptor
> semantics in the bpf specific parts of the patches yet failed to lose a
> single word on this anywhere. Yet we explicitly requested in the last
> thread that if bpf does deviate from core fs semantics you clearly
> communicate this.

FD 0 is still a valid file descriptor, in general. No one claims
otherwise, there is no change in semantics. BPF syscall won't see FD=3D0
for some optional fields, and that's a deviation from other APIs, yes,
but with no security implications.

And it might be hard to believe, but it's been like that for so long
and is just such an ingrained default behavior, that yes, out of habit
I didn't even think to highlight that in commit messages or cover
letters. My bad, certainly, but hardly a heinous act.

>
> But shame on me as well. I should've caught this during review. I
> trusted you both enough that I only focussed on the parts that matter
> for the VFS which were the two patches I ACKed. I didn't think it
> necessary to wade through the completely uninteresting BPF bits that I
> couldn't care less about. That won't happen again.
>
> What I want for the future is for bpf to clearly, openly, and explicitly
> communicate any decisions that affect core fs semantics. It's the exact
> same request I put forward last time. This is a path forward.

Of course, and you'll be CC'ed on all the BPF token patches I will
resend after the holidays.

And just to be clear for the future, by "core fs semantics" you also
mean any BPF UAPI FD field, right?

