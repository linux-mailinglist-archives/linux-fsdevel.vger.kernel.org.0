Return-Path: <linux-fsdevel+bounces-793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C47D0428
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 23:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BD0B213F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F653E008;
	Thu, 19 Oct 2023 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOVgIBJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444F3DFE5
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 21:45:37 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD49116
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:45:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c08b7744so1122307b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697751935; x=1698356735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP1bC7NbhmF2aawA3oJIPd9v1uWsSkcLhLCPtpX0r0A=;
        b=JOVgIBJYgBOQnyqidcLbqZwRWEUPo2TSOdoujEUzNCfro7kNRLaxe9u8zLpWt9Ilbz
         n7KhtSiw0keyt7PpNR1SZU4jJMhldEthl5lMPJNZyWFBEb5ylTNB2aeneuqySSfBLzY5
         wFZi5HvwLK85vlNp1GFHpVGQ1zmEgcKl7PHndWxMnynJMY4RGP5OsVNw713qLh18s5p8
         2rvThaFwgS/QyhPRXYU3F8Vg8hhPksBEvCRMU0vZKHbp5md8EQ9wpH6eVV7xvEIYsfqA
         hUaNiRt0/GN2RG/65LhT5TYyI7O30lY5GhuMwd4HdM8D2xI1K/7DcUzDT5nz4slpT2v6
         NOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751935; x=1698356735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IP1bC7NbhmF2aawA3oJIPd9v1uWsSkcLhLCPtpX0r0A=;
        b=t0mXYbzLWBuu4KGc9+IKjB24mhFGV58vRJrKzWePoAV9g//ehQwuFKgjR+J9J8Qb8D
         G6UmLIAx4vZMtm8Rf7LyTjHU9NpwPB8fbVVzIQUOx+dMkNJ7ev2ytUpzTcUbjG9Vs6Kv
         u13fjHK6SPaeE9zDp8BP5mN6m4YN+qb18/PPo/4jYfrfUFRTOKk6kWV1h0FY2gfMllG1
         2C9ku9zZGfIYcLmbAWh/Q3zNS2hbOCR86N/5iZ93BWN2I+NzwV16tYJ9ux0KaALO12BL
         BAe5tAnDLJMptS3NzNJAIFDkNNGIljRzEUXfkYxdZz7qMiYpHw+xes+wycRgxGQH3YZr
         3p2A==
X-Gm-Message-State: AOJu0YyKAl+9n8VjCgj6ev5EpmPitf+RZQezWurVEj3Aiqkki3MeTGwG
	e6d9MQacsChCEMBdZ22RfW2qqr7N3Vqd6XPp5ONpFQ==
X-Google-Smtp-Source: AGHT+IHQpr9/cMMwjS8gEZfULIlFEZn8lj2REtPfIGp2Kvw1E3AiUkFVt2rx8GUHTWRSFcl/VKr/jwON6+BOgeRudfE=
X-Received: by 2002:a0d:ccc6:0:b0:5a7:af7d:cee7 with SMTP id
 o189-20020a0dccc6000000b005a7af7dcee7mr164618ywd.6.1697751934417; Thu, 19 Oct
 2023 14:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com> <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com> <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com> <ZSlragGjFEw9QS1Y@x1n>
In-Reply-To: <ZSlragGjFEw9QS1Y@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Oct 2023 14:45:21 -0700
Message-ID: <CAJuCfpF2hM9MmUdv4K8a1meKdwsdWb5Q0fFihUtsngidehTPnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
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

On Fri, Oct 13, 2023 at 9:08=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 13, 2023 at 11:56:31AM +0200, David Hildenbrand wrote:
> > Hi Peter,
>
> Hi, David,
>
> >
> > > I used to have the same thought with David on whether we can simplify=
 the
> > > design to e.g. limit it to single mm.  Then I found that the trickies=
t is
> > > actually patch 1 together with the anon_vma manipulations, and the pr=
oblem
> > > is that's not avoidable even if we restrict the api to apply on singl=
e mm.
> > >
> > > What else we can benefit from single mm?  One less mmap read lock, bu=
t
> > > probably that's all we can get; IIUC we need to keep most of the rest=
 of
> > > the code, e.g. pgtable walks, double pgtable lockings, etc.
> >
> > No existing mechanisms move anon pages between unrelated processes, tha=
t
> > naturally makes me nervous if we're doing it "just because we can".
>
> IMHO that's also the potential, when guarded with userfaultfd descriptor
> being shared between two processes.
>
> See below with more comment on the raised concerns.
>
> >
> > >
> > > Actually, even though I have no solid clue, but I had a feeling that =
there
> > > can be some interesting way to leverage this across-mm movement, whil=
e
> > > keeping things all safe (by e.g. elaborately requiring other proc to =
create
> > > uffd and deliver to this proc).
> >
> > Okay, but no real use cases yet.
>
> I can provide a "not solid" example.  I didn't mention it because it's
> really something that just popped into my mind when thinking cross-mm, so=
 I
> never discussed with anyone yet nor shared it anywhere.
>
> Consider VM live upgrade in a generic form (e.g., no VFIO), we can do tha=
t
> very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can =
do
> extremely efficient postcopy live upgrade now with anonymous if with REMA=
P.
>
> Basically I see it a potential way of moving memory efficiently especiall=
y
> with thp.
>
> >
> > >
> > > Considering Andrea's original version already contains those bits and=
 all
> > > above, I'd vote that we go ahead with supporting two MMs.
> >
> > You can do nasty things with that, as it stands, on the upstream codeba=
se.
> >
> > If you pin the page in src_mm and move it to dst_mm, you successfully b=
roke
> > an invariant that "exclusive" means "no other references from other
> > processes". That page is marked exclusive but it is, in fact, not exclu=
sive.
>
> It is still exclusive to the dst mm?  I see your point, but I think you'r=
e
> taking exclusiveness altogether with pinning, and IMHO that may not be
> always necessary?
>
> >
> > Once you achieved that, you can easily have src_mm not have MMF_HAS_PIN=
NED,
>
> (I suppose you meant dst_mm here)
>
> > so you can just COW-share that page. Now you successfully broke the
> > invariant that COW-shared pages must not be pinned. And you can even tr=
igger
> > VM_BUG_ONs, like in sanity_check_pinned_pages().
>
> Yeah, that's really unfortunate.  But frankly, I don't think it's the fau=
lt
> of this new feature, but the rest.
>
> Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
> per-vma, which I don't see why we can't because it's simply a hint so far=
.
> Then if we apply the same rule here, UFFDIO_REMAP won't even work for
> single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
> be NACKed simply because of this..
>
> And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
> happen, or any further change to pinning solution that may affect this.  =
So
> far it just looks unsafe to remap a pin page to me.
>
> I don't have a good suggestion here if this is a risk.. I'd think it risk=
y
> then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
> means probably we just rule them out: folio_maybe_dma_pinned() may not ev=
en
> be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
> with proper write_protect_seq no matter cross-mm or single-mm?
>
> >
> > Can it all be fixed? Sure, with more complexity. For something without =
clear
> > motivation, I'll have to pass.
>
> I think what you raised is a valid concern, but IMHO it's better fixed no
> matter cross-mm or single-mm.  What do you think?
>
> In general, pinning lose its whole point here to me for an userspace eith=
er
> if it DONTNEEDs it or REMAP it.  What would be great to do here is we unp=
in
> it upon DONTNEED/REMAP/whatever drops the page, because it loses its
> coherency anyway, IMHO.
>
> >
> > Once there is real demand, we can revisit it and explore what else we w=
ould
> > have to take care of (I don't know how memcg behaves when moving betwee=
n
> > completely unrelated processes, maybe that works as expected, I don't k=
now
> > and I have no time to spare on reviewing features with no real use case=
s)
> > and announce it as a new feature.
>
> Good point.  memcg is probably needed..
>
> So you reminded me to do a more thorough review against zap/fault paths, =
I
> think what's missing are (besides page pinning):
>
>   - mem_cgroup_charge()/mem_cgroup_uncharge():

Good point. Will add in the next version.

>
>     (side note: I think folio_throttle_swaprate() is only for when
>      allocating new pages, so not needed here)
>
>   - check_stable_address_space() (under pgtable lock)

Ack.

>
>   - tlb flush
>
>     Hmm???????????????? I can't see anywhere we did tlb flush, batched or
>     not, either single-mm or cross-mm should need it.  Is this missing?

As Lokesh pointed out we do that but we don't batch them. I'll try to
add batching in the next version.

>
> >
> >
> > Note: that (with only reading the documentation) it also kept me wonder=
ing
> > how the MMs are even implied from
> >
> >        struct uffdio_move {
> >            __u64 dst;    /* Destination of move */
> >            __u64 src;    /* Source of move */
> >            __u64 len;    /* Number of bytes to move */
> >            __u64 mode;   /* Flags controlling behavior of move */
> >            __s64 move;   /* Number of bytes moved, or negated error */
> >        };
> >
> > That probably has to be documented as well, in which address space dst =
and
> > src reside.
>
> Agreed, some better documentation will never hurt.  Dst should be in the =
mm
> address space that was bound to the userfault descriptor.  Src should be =
in
> the current mm address space.

Ack. Will add. Thanks!

>
> Thanks,
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

