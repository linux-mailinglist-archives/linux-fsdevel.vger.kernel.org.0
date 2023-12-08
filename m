Return-Path: <linux-fsdevel+bounces-5306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E343580A129
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46D41C209D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CAE2905
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV4OzJpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35D171C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 00:40:04 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67adc37b797so10029966d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 00:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024804; x=1702629604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK/HPdf4M8bqr/qTPTACgWNrwU97E0y+Z7WK7uLQ+7o=;
        b=jV4OzJpdIkpZoSYD5mVwWkIJL5vN/zbsQriDrXmoz2nixdv9YFvrRwOQPfItpNZDx9
         I2+Gill9ZngOXRyFXcQElnWDz/DgPq36xvEGSYcGo6Q5iWxEhKCyj4lsEFOUNRFK2p/7
         ug0c7NOufVIjqMH6u5b/9ad8TxUNvBgSqOG4s79c6HMCSuOsA8tIKQw4iu3o+sGP5fmv
         EgSanWieH0OIW/lnJAb7rwdSRTWnLTjxUshu8Lgxr3WqEluEfKjLKJIkQEwISSn1AE+U
         RBphM4hwx8g1n8RU1WSLQlb/ikGiKfKR/30pHNwysFE2yuRF5P9NlRVnV4oqQm0Vh6V9
         fSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024804; x=1702629604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK/HPdf4M8bqr/qTPTACgWNrwU97E0y+Z7WK7uLQ+7o=;
        b=wiVby3jdNv2toc7UUDsg5nabnx7IXIJB5Q9XYenhaUJ+zjc8z8LGU6dQRDGglrY0m/
         mCE66zNLobSkOAUoIihXRZa3ImLq9JYSb8ny4qFHoJJLmmKGU8YcREsTCinq3jxz8KBr
         Nc/QVkV3YHwmrPFeraYMwlVSHahg0qeYYEgxIugkFjq2CjY5hRZ7gyycVhNGsAe7fjd1
         r08dURxiRdIaNfNUh2xyXCE5ZkaFryWWAE427czbe2gWpTqJnUeR22GWInLfgHBtyv3l
         v+DBW4+5ElK64T6PMgjZF1wF5Sb07br2L8Dlh+svq0kD8qR7MkXAuBz0GyuGNsHM4a65
         ULeA==
X-Gm-Message-State: AOJu0YxHKCAUDSv/fio/WEUoTx6UnmxvPIz1sO/mk42a20/qr7Lev8ky
	gkSBcJQ/3RvS98GjJFlmOjDG+PsfTgVtsYX7erspImtJrIM=
X-Google-Smtp-Source: AGHT+IHdnn/lbMKlawc3APKy7l5eaYl6s2Zm27uzZvv97d/PnFpFD3Hd0iRnOonDUGD7OITW8lRIZE+2VU5qshHGy8E=
X-Received: by 2002:a05:6214:16c7:b0:67a:ab36:a8c9 with SMTP id
 d7-20020a05621416c700b0067aab36a8c9mr4083712qvz.71.1702024803857; Fri, 08 Dec
 2023 00:40:03 -0800 (PST)
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
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
In-Reply-To: <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2023 10:39:52 +0200
Message-ID: <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:38=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/7/23 08:39, Amir Goldstein wrote:
> > On Thu, Dec 7, 2023 at 1:28=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 12/6/23 09:25, Amir Goldstein wrote:
> >>>>>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
> >>>>>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
> >>>>>> I guess not otherwise, the combination would have been tested.
> >>>>>
> >>>>> I'm not sure how many people are aware of these different flags/fea=
tures.
> >>>>> I had just finalized the backport of the related patches to RHEL8 o=
n
> >>>>> Friday, as we (or our customers) need both for different jobs.
> >>>>>
> >>>>>>
> >>>>>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
> >>>>>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
> >>>>>> for network fs. Right?
> >>>>>
> >>>>> We kind of have these use cases for our network file systems
> >>>>>
> >>>>> FOPEN_PARALLEL_DIRECT_WRITES:
> >>>>>       - Traditional HPC, large files, parallel IO
> >>>>>       - Large file used on local node as container for many small f=
iles
> >>>>>
> >>>>> FUSE_DIRECT_IO_ALLOW_MMAP:
> >>>>>       - compilation through gcc (not so important, just not nice wh=
en it
> >>>>> does not work)
> >>>>>       - rather recent: python libraries using mmap _reads_. As it i=
s read
> >>>>> only no issue of consistency.
> >>>>>
> >>>>>
> >>>>> These jobs do not intermix - no issue as in generic/095. If such
> >>>>> applications really exist, I have no issue with a serialization pen=
alty.
> >>>>> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
> >>>>> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
> >>>>>
> >>>>> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on =
plain
> >>>>> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this br=
anch
> >>>>> and post the next version
> >>>>> https://github.com/bsbernd/linux/commits/fuse-dio-v4
> >>>>>
> >>>>>
> >>>>> In the mean time I have another idea how to solve
> >>>>> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
> >>>>
> >>>> Please find attached what I had in my mind. With that generic/095 is=
 not
> >>>> crashing for me anymore. I just finished the initial coding - it sti=
ll
> >>>> needs a bit cleanup and maybe a few comments.
> >>>>
> >>>
> >>> Nice. I like the FUSE_I_CACHE_WRITES state.
> >>> For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
> >>> in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
> >>> of the last open file of the inode.
> >>>
> >>> I did not understand some of the complexity here:
> >>>
> >>>>          /* The inode ever got page writes and we do not know for su=
re
> >>>>           * in the DIO path if these are pending - shared lock not p=
ossible */
> >>>>          spin_lock(&fi->lock);
> >>>>          if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
> >>>>                  if (!(*cnt_increased)) {
> >>>
> >>> How can *cnt_increased be true here?
> >>
> >> I think you missed the 2nd entry into this function, when the shared
> >> lock was already taken?
> >
> > Yeh, I did.
> >
> >> I have changed the code now to have all
> >> complexity in this function (test, lock, retest with lock, release,
> >> wakeup). I hope that will make it easier to see the intention of the
> >> code. Will post the new patches in the morning.
> >>
> >
> > Sounds good. Current version was a bit hard to follow.
> >
> >>
> >>>
> >>>>                          fi->shared_lock_direct_io_ctr++;
> >>>>                          *cnt_increased =3D true;
> >>>>                  }
> >>>>                  excl_lock =3D false;
> >>>
> >>> Seems like in every outcome of this function
> >>> *cnt_increased =3D !excl_lock
> >>> so there is not need for out arg cnt_increased
> >>
> >> If excl_lock would be used as input - yeah, would have worked as well.
> >> Or a parameter like "retest-under-lock". Code is changed now to avoid
> >> going in and out.
> >>
> >>>
> >>>>          }
> >>>>          spin_unlock(&fi->lock);
> >>>>
> >>>> out:
> >>>>          if (excl_lock && *cnt_increased) {
> >>>>                  bool wake =3D false;
> >>>>                  spin_lock(&fi->lock);
> >>>>                  if (--fi->shared_lock_direct_io_ctr =3D=3D 0)
> >>>>                          wake =3D true;
> >>>>                  spin_unlock(&fi->lock);
> >>>>                  if (wake)
> >>>>                          wake_up(&fi->direct_io_waitq);
> >>>>          }
> >>>
> >>> I don't see how this wake_up code is reachable.
> >>>
> >>> TBH, I don't fully understand the expected result.
> >>> Surely, the behavior of dio mixed with mmap is undefined. Right?
> >>> IIUC, your patch does not prevent dirtying page cache while dio is in
> >>> flight. It only prevents writeback while dio is in flight, which is t=
he same
> >>> behavior as with exclusive inode lock. Right?
> >>
> >> Yeah, thanks. I will add it in the patch description.
> >>
> >> And there was actually an issue with the patch, as cache flushing need=
s
> >> to be initiated before doing the lock decision, fixed now.
> >>
> >
> > I thought there was, because of the wait in fuse_send_writepage()
> > but wasn't sure if I was following the flow correctly.
> >
> >>>
> >>> Maybe this interaction is spelled out somewhere else, but if not
> >>> better spell it out for people like me that are new to this code.
> >>
> >> Sure, thanks a lot for your helpful comments!
> >>
> >
> > Just to be clear, this patch looks like a good improvement and
> > is mostly independent of the "inode caching mode" and
> > FOPEN_CACHE_MMAP idea that I suggested.
> >
> > The only thing that my idea changes is replacing the
> > FUSE_I_CACHE_WRITES state with a FUSE_I_CACHE_IO_MODE
> > state, which is set earlier than FUSE_I_CACHE_WRITES
> > on caching file open or first direct_io mmap and unlike
> > FUSE_I_CACHE_WRITES, it is cleared on the last file close.
> >
> > FUSE_I_CACHE_WRITES means that caching writes happened.
> > FUSE_I_CACHE_IO_MODE means the caching writes and reads
> > may happen.
> >
> > FOPEN_PARALLEL_DIRECT_WRITES obviously shouldn't care
> > about "caching reads may happen", but IMO that is a small trade off
> > to make for maintaining the same state for
> > "do not allow parallel dio" and "do not allow passthrough open".
>
> I think the attached patches should do, it now also unsets

IMO, your patch is still more complicated than it should be.
There is no need for the complicated retest state machine.
If you split the helpers to:

bool exclusive_lock fuse_dio_wr_needs_exclusive_lock();
...
fuse_dio_lock_inode(iocb, &exclusive);
...
fuse_dio_unlock_inode(iocb, &exclusive);

Then you only need to test FUSE_I_CACHE_IO_MODE in
fuse_dio_wr_needs_exclusive_lock()
and you only need to increment shared_lock_direct_io_ctr
after taking shared lock and re-testing FUSE_I_CACHE_IO_MODE.

> FUSE_I_CACHE_IO_MODE. Setting the flag actually has to be done from
> fuse_file_mmap (and not from fuse_send_writepage) to avoid a dead stall,
> but that aligns with passthrough anyway?

Yes.

I see that shared_lock_direct_io_ctr is checked without lock or barriers
in and the wait_event() should be interruptible.
I am also not sure if it breaks any locking order for mmap because
the task that is going to wake it up is holding the shared inode lock...

While looking at this code, the invalidate_inode_pages2() looks suspicious.
If inode is already in FUSE_I_CACHE_IO_MODE when performing
another mmap, doesn't that have potential for data loss?
(even before your patch I mean)

> Amir, right now it only sets
> FUSE_I_CACHE_IO_MODE for VM_MAYWRITE. Maybe you could add a condition
> for passthrough there?
>

We could add a condition, but I don't think that we should.
I think we should refrain from different behavior when it is not justified.
I think it is not justified to allow parallel dio if any file is open in
caching mode on the inode and any mmap (private or shared)
exists on the inode.

That means that FUSE_I_CACHE_IO_MODE should be set on
any mmap, and already on open for non direct_io files.

Mixing caching and direct io on the same inode is hard as it is
already and there is no need to add complexity by allowing
parallel dio in that case. IMO it wins us nothing.

The FUSE_I_CACHE_IO_MODE could be cleared on last file
close (as your patch did) but it could be cleared earlier if
instead of tracking refcount of open file, we track refcount of
files open in caching mode or mmaped, which is what the
FOPEN_MMAP_CACHE flag I suggested is for.

Not sure this is a big win over refount of open files, which is simpler.
The use case is a db file which is open with concurrent dio writers
and some 3rd party app decides that it wants to mmap this file
for some other reason (indexer, virus scan, whatnot) and will taint
the inode with FUSE_I_CACHE_IO_MODE and degrade db performance
until db closes the file.

> @Miklos, could please tell me how to move forward? I definitely need to
> rebase to fuse-next, but my question is if this patch here should
> replace Amirs fix (and get back ported) or if we should apply it on top
> of Amirs patch and so let that simple fix get back ported? Given this is
> all features and new flags - I'm all for for the simple fix.
> If you agree on the general approach, I can put this on top of my dio
> consolidate branch and rebase the rest of the patches on top of it. That
> part will get a bit more complicated, as we will also need to handle
> plain O_DIRECT.
>

I was planning to post a patch for FUSE_I_CACHE_IO_MODE
myself, but feel free to work on your version and we could decide
which parts to take from which patch at the end.

Thanks,
Amir.

