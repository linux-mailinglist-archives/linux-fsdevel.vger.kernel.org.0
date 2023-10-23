Return-Path: <linux-fsdevel+bounces-944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154C7D3DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC48A28169D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02221210F3;
	Mon, 23 Oct 2023 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oicsvCGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2719BCB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:33:57 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5AAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:33:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a90d6ab962so25082447b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698082434; x=1698687234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd2yjNaoQ2yfBc07aAbwU+MnAPablZLDgfD6SYP0lAY=;
        b=oicsvCGmIBChkMYiu1IsCgFdLy95Mw2W4nn05UtI1lPw/Jl9JjreOTKe/DixFTSqlu
         bJ82I0CTktajVEx9ASvwEh4kgttZ268Yq7N4XIwmTPAPl3MfAgkvXONG09XqJGr1rauy
         ib9BIWOGiqsNmwvz1KewESasZ5mxRECu7PyVhs8AO8Zr+sE1gqHhrdZQin3nLFUm3RV1
         Is3dBY6bKwJgkA83b0fYqq9E3tQtq6q8mOnd+1WfxS5BnAEYt471atT7DCv0DtbFDDR4
         XcMs8CqdNlNjsMs2z7AuMuTihS2SaOqy6BNrzCo6WYueejwuHWgZQqm8PlJEc66SXcRP
         kkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082434; x=1698687234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd2yjNaoQ2yfBc07aAbwU+MnAPablZLDgfD6SYP0lAY=;
        b=u75Z38qlLHknrDRaEHELWOD4GAjdJT25zB8xWqy0fyKWkMDoSqPcxVutykO/sNY6yk
         VpZ/5yOa37k1f3C6yjvrBa6MiJxcJj6pybtC4Z5D4d/jBqYEUA/veCPU25njHRsgDrlP
         MWidbFwSJ5RkntV3Q7CBKXp0zKpaRLKxh+AwQU+8gKxVJ2X/L0EGInea0xWov84sGYz4
         +cKTrZw2A93zakRKW9PPWhyJ43AZN/9lfHSqYmHZEIKGUfuHMGGLHa5YgCoY42gk2NhA
         l93hk+59XEdeiH9j7I18dmulgo64zhHURnkrovgXZAAgfcTqFv4df4poM84CEXiAcXcp
         NLbA==
X-Gm-Message-State: AOJu0Yz9vKbaoeIWmNmYHxUH3Ojy8Nv6AnIpiMtbcTKyMXhkJInVD05o
	GY+lupImCP76Z000QG+pgN1dZ/8LBOD+VzAqWyxYEg==
X-Google-Smtp-Source: AGHT+IG+jQOlcjwF2YFFeRq9/LDUOmjHQCMNtQEttsid1pQGTmO6b4NBzjnjTdGq6JLSzjV0w9Ypj8Tb0eqN1ffJMmM=
X-Received: by 2002:a0d:d943:0:b0:5a7:bcbb:b948 with SMTP id
 b64-20020a0dd943000000b005a7bcbbb948mr11236411ywe.15.1698082433789; Mon, 23
 Oct 2023 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n> <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n> <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
 <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
 <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com> <ZTVD18RgBfITsQC4@x1n>
 <1156ad46-1952-4892-8092-bfbb8588c3f3@redhat.com> <96899aa6-700b-41b9-ab11-2cae48d75549@redhat.com>
In-Reply-To: <96899aa6-700b-41b9-ab11-2cae48d75549@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Oct 2023 10:33:40 -0700
Message-ID: <CAJuCfpF+ADAG=vn4y0EKo29j5zUx-TG=puF7Bq8oSp1_7T+OSw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 9:36=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.10.23 14:03, David Hildenbrand wrote:
> > On 22.10.23 17:46, Peter Xu wrote:
> >> On Fri, Oct 20, 2023 at 07:16:19PM +0200, David Hildenbrand wrote:
> >>> These are rather the vibes I'm getting from Peter. "Why rename it, co=
uld
> >>> confuse people because the original patches are old", "Why exclude it=
 if it
> >>> has been included in the original patches". Not the kind of reasoning=
 I can
> >>> relate to when it comes to upstreaming some patches.
> >>
> >> You can't blame anyone if you misunderstood and biased the question.
> >>
> >> The first question is definitely valid, even until now.  You guys stil=
l
> >> prefer to rename it, which I'm totally fine with.
> >>
> >> The 2nd question is wrong from your interpretation.  That's not my poi=
nt,
> >> at least not starting from a few replies already.  What I was asking f=
or is
> >> why such page movement between mm is dangerous.  I don't think I get s=
olid
> >> answers even until now.
> >>
> >> Noticing "memcg is missing" is not an argument for "cross-mm is danger=
ous",
> >> it's a review comment.  Suren can address that.
> >>
> >> You'll propose a new feature that may tag an mm is not an argument eit=
her,
> >> if it's not merged yet.  We can also address that depending on what it=
 is,
> >> also on which lands earlier.
> >>
> >> It'll be good to discuss these details even in a single-mm support.  A=
nyone
> >> would like to add that can already refer to discussion in this thread.
> >>
> >> I hope I'm clear.
> >>
> >
> > I said everything I had to say, go read what I wrote.
>
> Re-read your message after flying over first couple of paragraphs
> previously a bit quick too quickly (can easily happen when I'm told that
> I misunderstand questions and read them in a "biased" way).
>
> I'll happy to discuss cross-mm support once we actually need it. I just
> don't see the need to spend any energy on that right now, without any
> users on the horizon.
>
> [(a) I didn't blame anybody, I said that I don't understand the
> reasoning. (b) I hope I made it clear that this is added complexity (and
> not just currently dangerous) and so far I haven't heard a compelling
> argument why we should do any of that or even spend our time discussing
> that. (c) I never used "memcg is missing" as an argument for "cross-mm
> is dangerous", all about added complexity without actual users. (d) "it
> easily shows that there are cases  where this will require extra work --
> without any current benefits" -- is IMHO a perfectly fine argument
> against complexity that currently nobody needs]

Thanks for the discussion, folks!
I think posting the single-mm first and then following up with
cross-mm and its test would help us move forward. That will provide
functionality that is needed today quickly without unnecessary
distractions and will give us more time to discuss cross-mm support.
Also we will be able to test single-mm in isolation and make it more
solid before moving onto cross-mm.
I'll try to post the next version sometime this week.
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>

