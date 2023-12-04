Return-Path: <linux-fsdevel+bounces-4758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E68030AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5901CB208C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2310224C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pFrVUxd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC0E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 01:27:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1975fe7befso433845366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 01:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701682069; x=1702286869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2qv39s5RRJEkUP7C0zzlAFDM4UHIkuaXpLAfGpxkQ=;
        b=pFrVUxd6TQB4AktIdnArNacxI00l9WWhMIn/rU6Y9gDFYK1xPlS63iwo46fAh5K3oU
         N5FS7a99sPTAvmvXy99xYNcm7//nsgYpLs21OmEZD1Gdys6BkHR1ql0tw/c2ZMflIdMA
         oQYzilMGS/oRmf3BXB8fa8BHURcFUZhFTNue8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682069; x=1702286869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF2qv39s5RRJEkUP7C0zzlAFDM4UHIkuaXpLAfGpxkQ=;
        b=goTVaBMCVR/8xxf3yhVf32MHyGzch80rpE1ARfADmpWR9J2gwFQnAP3xV+RD7fr7Ub
         ukRlsOvDpwF5B2naE1PSRMXhFZLUK7MO6XJbkUS3999yeqfxQeTjY64DAnCktz7Y+BjK
         PabkrWle97C23x5Udg4YM3Y2U9eviA//2JYe1DBOzP0jilFhD7Qch60q4RR2ReunMdte
         ztgI+/YyeY4ou5ZukJVZJeHOThrMZbPXULjX4dBg/zScH9WiTtnmLVyjkLkB/ExEE7XL
         8w7WL2uzCVB3MYhrZre7fJOFAmUpT9mwBqwnkquA6OZnU2Xos46Y8Lnrg7OPxsT1V6l2
         yehA==
X-Gm-Message-State: AOJu0Yz9JUBj45ggpSYHn1FCAxH6Cz1565v/4OzMA53hR2aHH9+kaN70
	k8Ev9B1qUjbeATB4HFplLe6FggOsHtTJDf2teAcMoQ==
X-Google-Smtp-Source: AGHT+IGNQe9tcsU5syMghMBlz0s539VxcjRKbwiBS0PdAVW7DkuYCosk3seitooNKDKVt42NSZ9ZmeFPY/60rqbgMGU=
X-Received: by 2002:a17:907:9016:b0:a19:a19a:ea96 with SMTP id
 ay22-20020a170907901600b00a19a19aea96mr2584119ejc.79.1701682068787; Mon, 04
 Dec 2023 01:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm> <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Dec 2023 10:27:37 +0100
Message-ID: <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Dec 2023 at 07:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 1:00=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Amir,
> >
> > On 12/3/23 12:20, Amir Goldstein wrote:
> > > On Sat, Dec 2, 2023 at 5:06=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >>
> > >> On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Bernd Schubert
> > >> <bernd.schubert@fastmail.fm> wrote:
> > >>>
> > >>> Hi Miklos,
> > >>>
> > >>> On 9/20/23 10:15, Miklos Szeredi wrote:
> > >>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com>=
 wrote:
> > >>>>>
> > >>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the p=
urpose
> > >>>>> of allowing shared mmap of files opened/created with DIRECT_IO en=
abled.
> > >>>>> However, it leaves open the possibility of further relaxing the
> > >>>>> DIRECT_IO restrictions (and in-effect, the cache coherency guaran=
tees of
> > >>>>> DIRECT_IO) in the future.
> > >>>>>
> > >>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose.=
 It
> > >>>>> only serves to allow shared mmap of DIRECT_IO files, while still
> > >>>>> bypassing the cache on regular reads and writes. The shared mmap =
is the
> > >>>>> only loosening of the cache policy that can take place with the f=
lag.
> > >>>>> This removes some ambiguity and introduces a more stable flag to =
be used
> > >>>>> in FUSE_INIT. Furthermore, we can document that to allow shared m=
map'ing
> > >>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> > >>>>>
> > >>>>> Tyler Fanelli (2):
> > >>>>>     fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
> > >>>>>     docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> > >>>>
> > >>>> Looks good.
> > >>>>
> > >>>> Applied, thanks.  Will send the PR during this merge window, since=
 the
> > >>>> rename could break stuff if already released.
> > >>>
> > >>> I'm just porting back this feature to our internal fuse module and =
it
> > >>> looks these rename patches have been forgotten?
> > >>>
> > >>>
> > >>
> > >> Hi Miklos, Bernd,
> > >>
> > >> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
> > >> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct wri=
te in
> > >> direct_io_relax mode") and I was wondering - isn't dirty pages write=
back
> > >> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
> > >> direct_io_allow_mmap case?
> > >>
> > >> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
> > >> for munmap of files also in direct-io mode [1], so I was considering=
 installing
> > >> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
> > >> and regardless of direct_io_allow_mmap.
> > >>
> > >> I was asking myself if there was a good reason why fuse_page_mkwrite=
()/
> > >> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
> > >> should NOT be called for the FOPEN_DIRECT_IO case regardless of
> > >> direct_io_allow_mmap?
> > >>
> > >
> > > Before trying to make changes to fuse_file_mmap() I tried to test
> > > DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
> > > passthrough_hp --direct-io.
> > >
> > > The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio, mma=
p, splice)
> > > on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
> > > fuse_set_nowrite()
> > >
> > > I am wondering how this code was tested?
> > >
> > > I could not figure out the problem and how to fix it.
> > > Please suggest a fix and let me know which adjustments are needed
> > > if I want to use fuse_file_vm_ops for all mmap modes.
> >
> > So fuse_set_nowrite() tests for inode_is_locked(), but that also
> > succeeds for a shared lock. It gets late here (and I might miss
> > something), but I think we have an issue with
> > FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT an=
d
> > mmap, the same issue might triggered? Hmm, well, so far plain O_DIRECT
> > does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for tha=
t
> > are still pending.
> >
>
> Your analysis seems to be correct.
>
> Attached patch fixes the problem and should be backported to 6.6.y.
>
> Miklos,
>
> I prepared the patch on top of master and not on top of the rename to
> FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
> 6.6.y, although if you are planning send the flag rename to v6.7 as a fix=
,
> you may prefer to apply the fix after the rename and request to backport
> the flag rename along with the fix to 6.6.y.

I've done that.   Thanks for the fix and testing.

Miklos

