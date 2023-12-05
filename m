Return-Path: <linux-fsdevel+bounces-4852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F5804CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A15A1C20BEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773343D98D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDAMk48m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55611F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 23:01:00 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-464a36f23ddso250290137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 23:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701759659; x=1702364459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhVwW+Sk/euH4YX7azfGYKSuFaYIEbCPfeedGB474as=;
        b=SDAMk48mp+cVh5h2exG+n3AMI7C3l9h380DfRQ4p6cYEHncGAQWFWI/NVe7a6Ir3Vo
         iPRTQjaPfQuXWWXjCrzo4o84Jj9cKSapzWSeTIz8ApCVMLXiPt0gu1CIQjzyhZSRrAb0
         ohcMX/jSOWflotcBVw+0p47AcZSgDpgoagdIuVdySTr7YvgfKq3ZEaVURulF95NseTEE
         EvvY3qfW2C2AVBKz2rAIKWh4UveCooqeqPyRnaT4rQwGgU87wbbq6dFEFscm88KyaPPs
         Lr8i5zu0KFoupllLLyGTG1z0rUC7qMK1LkT2ZZS8+9BFNNnWrUsLOHQ/gL6IFc6asLCD
         ZD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701759659; x=1702364459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhVwW+Sk/euH4YX7azfGYKSuFaYIEbCPfeedGB474as=;
        b=AZ6vHZZ7F+OopXs/VuhVvFl9BtWzrlLI4A0dwjq6qPfpyNLrsCvHkjFHfi3GgLCa+S
         yUGxYNAxE//wQmsMUX7joEF08q1XZyCLPrY6X4SsEgxxHlLJvZhQbjhGzESXDf2JqKHS
         G4s3u8QWa5Qx6sZbRJiumAMWH7NRQRaUj/ayARqjmafoZAc+AoGjpcaS02oGQRPVr0kL
         6aBL9HvlVmHgnm7feMrcPr+o/d7hjuloSYTivU0XzUUVfQ87VvqhUVloajYLiiEcfRu3
         gRe8WgaZaGlqn2iTQrV00yJxdaoHUJ2V/lZst5Kmn/TslI1c47kUpLK/nZdW//SejVgA
         QmCA==
X-Gm-Message-State: AOJu0Yywtexbs0fCIQz5Z0xfygb11Fpjtlr7p3h5q0SeOypN66r0e5nH
	vPKvuUzslbo1wLIl5C5tWiKkAqPi/D7aLyuj7nE=
X-Google-Smtp-Source: AGHT+IFWxfnOECef4Q7weSFgipMTq6L2R4TEdXRiCc5Ds4dcCOEqytMVfZFhZbVXLHaV0pftSLeVe9cP0EIR/a1fnzE=
X-Received: by 2002:a05:6102:1958:b0:464:77f2:55f with SMTP id
 jl24-20020a056102195800b0046477f2055fmr2845479vsb.49.1701759659455; Mon, 04
 Dec 2023 23:00:59 -0800 (PST)
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
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
In-Reply-To: <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Dec 2023 09:00:47 +0200
Message-ID: <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:42=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/4/23 11:04, Bernd Schubert wrote:
> >
> >
> > On 12/4/23 10:27, Miklos Szeredi wrote:
> >> On Mon, 4 Dec 2023 at 07:50, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >>>
> >>> On Mon, Dec 4, 2023 at 1:00=E2=80=AFAM Bernd Schubert
> >>> <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> Hi Amir,
> >>>>
> >>>> On 12/3/23 12:20, Amir Goldstein wrote:
> >>>>> On Sat, Dec 2, 2023 at 5:06=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com>
> >>>>> wrote:
> >>>>>>
> >>>>>> On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Bernd Schubert
> >>>>>> <bernd.schubert@fastmail.fm> wrote:
> >>>>>>>
> >>>>>>> Hi Miklos,
> >>>>>>>
> >>>>>>> On 9/20/23 10:15, Miklos Szeredi wrote:
> >>>>>>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli
> >>>>>>>> <tfanelli@redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the
> >>>>>>>>> purpose
> >>>>>>>>> of allowing shared mmap of files opened/created with DIRECT_IO
> >>>>>>>>> enabled.
> >>>>>>>>> However, it leaves open the possibility of further relaxing the
> >>>>>>>>> DIRECT_IO restrictions (and in-effect, the cache coherency
> >>>>>>>>> guarantees of
> >>>>>>>>> DIRECT_IO) in the future.
> >>>>>>>>>
> >>>>>>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its
> >>>>>>>>> purpose. It
> >>>>>>>>> only serves to allow shared mmap of DIRECT_IO files, while stil=
l
> >>>>>>>>> bypassing the cache on regular reads and writes. The shared
> >>>>>>>>> mmap is the
> >>>>>>>>> only loosening of the cache policy that can take place with the
> >>>>>>>>> flag.
> >>>>>>>>> This removes some ambiguity and introduces a more stable flag
> >>>>>>>>> to be used
> >>>>>>>>> in FUSE_INIT. Furthermore, we can document that to allow shared
> >>>>>>>>> mmap'ing
> >>>>>>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> >>>>>>>>>
> >>>>>>>>> Tyler Fanelli (2):
> >>>>>>>>>      fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
> >>>>>>>>>      docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> >>>>>>>>
> >>>>>>>> Looks good.
> >>>>>>>>
> >>>>>>>> Applied, thanks.  Will send the PR during this merge window,
> >>>>>>>> since the
> >>>>>>>> rename could break stuff if already released.
> >>>>>>>
> >>>>>>> I'm just porting back this feature to our internal fuse module
> >>>>>>> and it
> >>>>>>> looks these rename patches have been forgotten?
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Hi Miklos, Bernd,
> >>>>>>
> >>>>>> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
> >>>>>> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct
> >>>>>> write in
> >>>>>> direct_io_relax mode") and I was wondering - isn't dirty pages
> >>>>>> writeback
> >>>>>> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
> >>>>>> direct_io_allow_mmap case?
> >>>>>>
> >>>>>> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
> >>>>>> for munmap of files also in direct-io mode [1], so I was
> >>>>>> considering installing
> >>>>>> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching cas=
e,
> >>>>>> and regardless of direct_io_allow_mmap.
> >>>>>>
> >>>>>> I was asking myself if there was a good reason why
> >>>>>> fuse_page_mkwrite()/
> >>>>>> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
> >>>>>> should NOT be called for the FOPEN_DIRECT_IO case regardless of
> >>>>>> direct_io_allow_mmap?
> >>>>>>
> >>>>>
> >>>>> Before trying to make changes to fuse_file_mmap() I tried to test
> >>>>> DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
> >>>>> passthrough_hp --direct-io.
> >>>>>
> >>>>> The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio,
> >>>>> mmap, splice)
> >>>>> on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
> >>>>> fuse_set_nowrite()
> >>>>>
> >>>>> I am wondering how this code was tested?
> >>>>>
> >>>>> I could not figure out the problem and how to fix it.
> >>>>> Please suggest a fix and let me know which adjustments are needed
> >>>>> if I want to use fuse_file_vm_ops for all mmap modes.
> >>>>
> >>>> So fuse_set_nowrite() tests for inode_is_locked(), but that also
> >>>> succeeds for a shared lock. It gets late here (and I might miss
> >>>> something), but I think we have an issue with
> >>>> FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT
> >>>> and
> >>>> mmap, the same issue might triggered? Hmm, well, so far plain O_DIRE=
CT
> >>>> does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for
> >>>> that
> >>>> are still pending.
> >>>>
> >>>
> >>> Your analysis seems to be correct.
> >>>
> >>> Attached patch fixes the problem and should be backported to 6.6.y.
> >>>
> >>> Miklos,
> >>>
> >>> I prepared the patch on top of master and not on top of the rename to
> >>> FUSE_DIRECT_IO_ALLOW_MMAP in for-next for ease of backport to
> >>> 6.6.y, although if you are planning send the flag rename to v6.7 as a
> >>> fix,
> >>> you may prefer to apply the fix after the rename and request to backp=
ort
> >>> the flag rename along with the fix to 6.6.y.
> >>
> >> I've done that.   Thanks for the fix and testing.
> >
> > Hi Amir, hi Miklos,
> >
> > could you please hold on a bit before sending the patch upstream?
> > I think we can just test for fuse_range_is_writeback in
> > fuse_direct_write_iter. I will have a patch in a few minutes.
>
> Hmm, that actually doesn't work as we would need to hold the inode lock
> in page write functions.
> Then tried to do it per inode and only when the inode gets cached writes
> or mmap - this triggers a lockdep lock order warning, because
> fuse_file_mmap is called with mm->mmap_lock and would take the inode
> lock. But through
> fuse_direct_io/iov_iter_get_pages2/__iov_iter_get_pages_alloc these
> locks are taken the other way around.
> So right now I don't see a way out - we need to go with Amirs patch first=
.
>
>

Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
(e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
I guess not otherwise, the combination would have been tested.

FOPEN_PARALLEL_DIRECT_WRITES is typically important for
network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
for network fs. Right?

FWIW, with FUSE_PASSTHROUGH, I plan that a shared mmap of an inode
in "passthrough mode" (i.e. has an open FOPEN_PASSTHROUGH file) will
be allowed (maps the backing file) regardless of fc->direct_io_allow_mmap.
FOPEN_PARALLEL_DIRECT_WRITES will also be allowed on an inode in
"passthrough mode", because an inode in "passthrough mode" cannot have
any pending page cache writes.

This makes me realize that I will also need to handle passthrough of
->direct_IO() on an FOPEN_PASSTHROUGH file.

Thanks,
Amir.

