Return-Path: <linux-fsdevel+bounces-833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B67D1138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCAB1C20FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C461D525;
	Fri, 20 Oct 2023 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VksO8oT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD201CFA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 14:09:44 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3B19E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 07:09:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a82c2eb50cso9418837b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697810982; x=1698415782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6YP/teVQRQ13BPszkwW5RTXBLcu7j1b8Aesjq/guSY=;
        b=VksO8oT2J6sqKmYO9ne8VNu1X3q/nzWgCwF2+8PpQHbG2xynv1eTWtT3cgmq096SLK
         MGO0j9hYw9CbXxYcZyOkKSMicDHOrnQurf3F5exb3snrWYS1ZFiV+rBPHlkESusU52w3
         ANRap+US0bCpY/e1SeO/kzdzrUSyGsqkALJ+/cnmrdUmZOXDwji3pYBNAbSMja7HxXTc
         xsriOrkz5gf5oJO717Y5yHprZUcapccj3+ghGImfIrwnAO9q9NcSfW3AxHR2eq3RRPPw
         8XXRRrmeqfl9hIB2euWO4TIoLTU183Z29W8u1qSOHmp3kMgjx/mBoCuYwf/M7C2ExlnC
         va7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810982; x=1698415782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6YP/teVQRQ13BPszkwW5RTXBLcu7j1b8Aesjq/guSY=;
        b=CZWeZXYIIP6yT2etY+MpmSbfN/hq9SESFBuC21pfKHGofTV4RBv85zTU239SUjMR9y
         kPrE1LW22LiFJSDF9yRePFZUnshzqetaaAR4oOz5I42al91zFzGogFnGfLztYr5gUXHQ
         GEXhF+S3ZOLVa9Lv9OIImbL7c3xCPSaax0/z9kt6j8lGCKBYiWAfPQuD7a58FNdbzTgx
         letmjE7wiqfHuHjyMNbjLOnvwXcWLrneGlnsQ0N30DogNbMC/n3/IG5TIIUf3maUK+RJ
         g2qnqfcJCZjXe+3LC/5tvk/S2h0UnKbIiWNFstluQ10jyUouFeqEnm64K5Oq6THzRpVE
         L6Gw==
X-Gm-Message-State: AOJu0Yzo87DFROMadhAJYSEGn0ZtKtzqYTRtvm1VIrbK3Zwtn1N23Jhi
	0peuV6do3t3Xtp5UzkieZ76RS4as+4Ee9P1S4DhQuw==
X-Google-Smtp-Source: AGHT+IEMDIp10DzXlnGt6SASQtJ1tuQPgPeVTO1Ezg9HTj83cfJu2cTxYgtGWx3/7WTfDMYL6h6fGRi+BmSj1Io1CoY=
X-Received: by 2002:a0d:dd97:0:b0:5a8:2d2b:ca9c with SMTP id
 g145-20020a0ddd97000000b005a82d2bca9cmr2372237ywe.32.1697810981824; Fri, 20
 Oct 2023 07:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n> <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n> <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
In-Reply-To: <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Oct 2023 07:09:28 -0700
Message-ID: <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
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

On Fri, Oct 20, 2023 at 3:02=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.10.23 21:53, Peter Xu wrote:
> > On Thu, Oct 19, 2023 at 05:41:01PM +0200, David Hildenbrand wrote:
> >> That's not my main point. It can easily become a maintenance burden wi=
thout
> >> any real use cases yet that we are willing to support.
> >
> > That's why I requested a few times that we can discuss the complexity o=
f
> > cross-mm support already here, and I'm all ears if I missed something o=
n
> > the "maintenance burden" part..
> >
> > I started by listing what I think might be different, and we can easily
> > speedup single-mm with things like "if (ctx->mm !=3D mm)" checks with
> > e.g. memcg, just like what this patch already did with pgtable depositi=
ons.
> >
> > We keep saying "maintenance burden" but we refuse to discuss what is th=
at..
>
> Let's recap
>
> (1) We have person A up-streaming code written by person B, whereby B is
> not involved in the discussions nor seems to be active to maintain that
> code.
>
> Worse, the code that is getting up-streamed was originally based on a
> different kernel version that has significant differences in some key
> areas -- for example, page pinning, exclusive vs. shared.
>
> I claim that nobody here fully understands the code at hand (just look
> at the previous discussions), and reviewers have to sort out the mess
> that was created by the very way this stuff is getting upstreamed here.
>
> We're already struggling to get the single-mm case working correctly.
>
>
> (2) Cross-mm was not even announced anywhere nor mentioned which use it
> would have; I had to stumble over this while digging through the code.
> Further, is it even *tested*? AFAIKS in patch #3 no. Why do we have to
> make the life of reviewers harder by forcing them to review code that
> currently *nobody* on this earth needs?
>
>
> (3) You said "What else we can benefit from single mm?  One less mmap
> read lock, but probably that's all we can get;" and I presented two
> non-obvious issues. I did not even look any further because I really
> have better things to do than review complicated code without real use
> cases at hand. As I said "maybe that works as expected, I
> don't know and I have no time to spare on reviewing features with no
> real use cases)"; apparently I was right by just guessing that memcg
> handling is missing.
>
>
> The sub-feature in question (cross-mm) has no solid use cases; at this
> point I am not even convinced the use case you raised requires
> *userfaultfd*; for the purpose of moving a whole VMA worth of pages
> between two processes; I don't see the immediate need to get userfaultfd
> involved and move individual pages under page lock etc.

You make a compelling case against cross-mm support.
While I can't force Andrea to participate in upstreaming nor do I have
his background, keeping it simple, as you requested, is doable. That's
what I plan on doing by splitting the patch and I think we all agreed
to that. I'll also see if I can easily add a separate patch to test
cross-mm support.
I do apologize for the extra effort required from reviewers to cover
for the gaps in my patches. I'm doing my best to minimize that and I
really appreciate your time.

>
> >
> > I'll leave that to Suren and Lokesh to decide.  For me the worst case i=
s
> > one more flag which might be confusing, which is not the end of the wor=
ld..
> > Suren, you may need to work more thoroughly to remove cross-mm implicat=
ions
> > if so, just like when renaming REMAP to MOVE.
>
> I'm asking myself why you are pushing so hard to include complexity
> "just because we can"; doesn't make any sense to me, honestly.
>
> Maybe you have some other real use cases that ultimately require
> userfaultfd for cross-mm that you cannot share?
>
> Will the world end when we have to use a separate flag so we can open
> this pandora's box when really required?
>
>
> Again, moving anon pages within a process is a known thing; we do that
> already via mremap; the only difference here really is, that we have to
> get the rmap right because we don't adjust VMAs. It's a shame we don't
> try to combine both code paths, maybe it's not easily possible like we
> did with mprotect vs. uffd-wp.

That's a good point. With cross-mm support baked in, the overlap was
not obvious to me. I'll see how much we can reuse from the mremap
path.

>
> Moving anon pages between process is currently only done via COW, where
> all things (page pinning, memcg, ...) have been figured out and are
> simply working as expected. Making uffd special by coding-up their own
> thing does not sound compelling to me.
>
>
> I am clearly against any unwarranted features+complexity. Again, I will
> stop arguing further, the whole thing of "include it just because we
> can" to avoid a flag (that we might never even see) doesn't make any
> sense to me and likely never will.
>
> The whole way this feature is getting upstreamed is just messed up IMHO
> and I the reasoning used in this thread to stick
> as-close-as-possible to some code person B wrote some years ago (e.g.,
> naming, sub-features) is far out of my comprehension.

I don't think staying as-close-as-possible to the original version was
the way I was driving this so far. At least that was not my conscious
intention. I'm open to further suggestions whenever it makes sense to
deviate from it.
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>

