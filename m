Return-Path: <linux-fsdevel+bounces-4020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143D7FB635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25B6B2172F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6D4AF60;
	Tue, 28 Nov 2023 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAdgwEYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EAFBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 01:46:27 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a3fabcee3so17228086d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701164786; x=1701769586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqMfvW9yMye55fCnhHm4Q3dsvtm4OebfO88CxghlEfY=;
        b=lAdgwEYkTHFcqKAluIQSI9aivuIKO7c7FRcusM7OmliC7ono0DvO4Eamg028VkQWMs
         SaRPo03sZ5KvWS3rLsqbHqL7Bc8ygPBdWNrj//9Y4oxbS1NMJOdpcijI+KhESe2jKYUz
         iOk6MgTzrc6PgeVRxZFToGQ6FVGI7qiIhaEsEcgkOYFdzsFpAKKfVHvSzq3MMhsm/hVP
         vUOf3e8fKXhHmiWZLxUH1K9Watk+zCfiK2yi4sk6pRna/SA3gGVSGRUU5WqeCcagjeQl
         TpH2QDHp+7g0COG1dGYdqllbilOwoWyJ5IFvBMrVmiqAyjdNjaJTYcX/ZeF1rJ+fBUbm
         rYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164786; x=1701769586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqMfvW9yMye55fCnhHm4Q3dsvtm4OebfO88CxghlEfY=;
        b=wSIU5ii5i7oGxwaWd6qi/KGJJn3wQfgWs5xVPiOE7xpxZk6LBFls/LZftd5GIEl4Es
         9dTYsFjZ3pdKEm+SEPcfBpeHlB4YumITm8pOF5/A2ZnejcCJnc8NQl5Z92sJ1MF6nUXr
         79em3qCJSEPl1nvreo1LEFEAVsr11ZZ2xFCro1j73k7e8Y0uMYE6UavWnjX5+2pQM0/x
         dpUVBB3XBtIPGROaF9uX2Fw3rSI8dLAQaAlK6CafDxma6qYqqm9tr2QvRRfuXFgX5pvD
         AOv9WIWj1PWwT/xRZ3EtiYairc37rB2vr2tzY8NVvK0G9yVFIuFO0S5ksVT92i+5H51K
         biSA==
X-Gm-Message-State: AOJu0Yzoqq2EeHV4iuUsFa0WUpuqMZ7+7B1rz3m7aBbhUAW90GQzvW0o
	UrQo5pJvyowbKgDzAfnXibAxgaieem5UPhK9qaBFfzs5g5A=
X-Google-Smtp-Source: AGHT+IF2FUOof6bgNeJgeEod/0nvs0iAau92PS/U9Uht734eSLR1ffvOaC593UhAAjV9xYkGQWH4OsIrZxkiSLEsz2o=
X-Received: by 2002:a05:6214:519:b0:66d:9945:5a93 with SMTP id
 px25-20020a056214051900b0066d99455a93mr24442439qvb.9.1701164785991; Tue, 28
 Nov 2023 01:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3> <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3> <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3> <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
 <20231127-bausatz-hausputz-9dbee07b9637@brauner> <CAOQ4uxihZ7fu0cGX4GTF9VrxPXZpMy2NKrpYfWMBDVFjhsyFeg@mail.gmail.com>
 <20231127-amtszeit-tattoo-e6c93811147e@brauner>
In-Reply-To: <20231127-amtszeit-tattoo-e6c93811147e@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Nov 2023 11:46:14 +0200
Message-ID: <CAOQ4uxhs50g9MLEdLqw6b9di5086Vs7+PSxX=bxc4DnY2dKB5w@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 4:57=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Nov 27, 2023 at 04:48:23PM +0200, Amir Goldstein wrote:
> > On Mon, Nov 27, 2023 at 3:56=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > > > On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > Hi Amir,
> > > > >
> > > > > sorry for a bit delayed reply, I did not get to "swapping in" HSM
> > > > > discussion during the Plumbers conference :)
> > > > >
> > > > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > > > On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <amir73i=
l@gmail.com> wrote:
> > > > > > > On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@suse.c=
z> wrote:
> > > > > > > > > Recap for new people joining this thread.
> > > > > > > > >
> > > > > > > > > The following deadlock is possible in upstream kernel
> > > > > > > > > if fanotify permission event handler tries to make
> > > > > > > > > modifications to the filesystem it is watching in the con=
text
> > > > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > > > >
> > > > > > > > > P1                             P2                      P3
> > > > > > > > > -----------                    ------------            --=
----------
> > > > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > > > -> sb_start_write(fs1.sb)
> > > > > > > > >   -> do_splice_direct()                         freeze_su=
per(fs1.sb)
> > > > > > > > >     -> rw_verify_area()                         -> sb_wai=
t_write(fs1.sb) ......
> > > > > > > > >       -> security_file_permission()
> > > > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > > > >                                  -> do_unlinkat(fs1.dfd, =
...)
> > > > > > > > >                                    -> sb_start_write(fs1.=
sb) ......
> > > > > > > > >
> > > > > > > > > start-write-safe patches [1] (not posted) are trying to s=
olve this
> > > > > > > > > deadlock and prepare the ground for a new set of permissi=
on events
> > > > > > > > > with cleaner/safer semantics.
> > > > > > > > >
> > > > > > > > > The cases described above of sendfile from a file in loop=
 mounted
> > > > > > > > > image over fs1 or overlayfs over fs1 into a file in fs1 c=
an still
> > > > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > > > >
> > > > > > > > Yep, nice summary.
> > > > > ...
> > > > > > > > > > As I wrote above I don't like the abuse of FMODE_NONOTI=
FY much.
> > > > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify=
 events when using
> > > > > > > > > > this fd. It says nothing about freeze handling or so. F=
urthermore as you
> > > > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace but p=
ractically all
> > > > > > > > > > current fanotify users need to also do IO on other file=
s in order to handle
> > > > > > > > > > fanotify event. So ideally we'd have a way to do IO to =
other files in a
> > > > > > > > > > manner safe wrt freezing. We could just update handling=
 of RWF_NOWAIT flag
> > > > > > > > > > to only trylock freeze protection - that actually makes=
 a lot of sense to
> > > > > > > > > > me. The question is whether this is enough or not.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because=
 writing
> > > > > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > > > > Eventually, event handler for lookup permission events sh=
ould be
> > > > > > > > > able to also create files without blocking on vfs level f=
reeze protection.
> > > > > > > >
> > > > > > > > So this is what I wanted to clarify. The lookup permission =
event never gets
> > > > > > > > called under a freeze protection so the deadlock doesn't ex=
ist there. In
> > > > > > > > principle the problem exists only for access and modify eve=
nts where we'd
> > > > > > > > be filling in file data and thus RWF_NOWAIT could be enough=
.
> > > > > > >
> > > > > > > Yes, you are right.
> > > > > > > It is possible that RWF_NOWAIT could be enough.
> > > > > > >
> > > > > > > But the discovery of the loop/ovl corner cases has shaken my
> > > > > > > confidence is the ability to guarantee that freeze protection=
 is not
> > > > > > > held somehow indirectly.
> > > > > > >
> > > > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > > > > > same ovl corner case, because with splice from ovl1 to fs1,
> > > > > > > fs1 freeze protection is held and:
> > > > > > >   ovl_splice_read(ovl1.file)
> > > > > > >     ovl_real_fdget()
> > > > > > >       ovl_open_realfile(fs1.file)
> > > > > > >          ... security_file_open(fs1.file)
> > > > > > >
> > > > > > > > That being
> > > > > > > > said I understand this may be assuming too much about the i=
mplementations
> > > > > > > > of HSM daemons and as you write, we might want to provide a=
 way to do IO
> > > > > > > > not blocking on freeze protection from any hook. But I want=
ed to point this
> > > > > > > > out explicitly so that it's a conscious decision.
> > > > > > > >
> > > > > >
> > > > > > I agree and I'd like to explain using an example, why RWF_NOWAI=
T is
> > > > > > not enough for HSM needs.
> > > > > >
> > > > > > The reason is that often, when HSM needs to handle filling cont=
ent
> > > > > > in FAN_PRE_ACCESS, it is not just about writing to the accessed=
 file.
> > > > > > HSM needs to be able to avoid blocking on freeze protection
> > > > > > for any operations on the filesystem, not just pwrite().
> > > > > >
> > > > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > > > from the lookup event and uses it in the handling of access eve=
nts to
> > > > > > update the metadata files that store which parts of the file we=
re already
> > > > > > filled (relying of fiemap is not always a valid option).
> > > > > >
> > > > > > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > > > > > is propagated from dirfd to an fd opened with openat(dirfd, ...=
), so
> > > > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> > > > > >
> > > > > > Another use case is that HSM may want to download content to a
> > > > > > temp file on the same filesystem, verify the downloaded content=
 and
> > > > > > then clone the data into the accessed file range.
> > > > > >
> > > > > > I think that a PF_ flag (see below) would work best for all tho=
se cases.
> > > > >
> > > > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon need n=
ot be
> > > > > enough for all sensible usecases to avoid deadlocks with freezing=
. However
> > > > > note that if we want to really properly handle all possible opera=
tions, we
> > > > > need to start handling error from all sb_start_write() and
> > > > > file_start_write() calls and there are quite a few of those.
> > > > >
> > > >
> > > > Darn, forgot about those.
> > > > I am starting to reconsider adding a freeze level.
> > > > I cannot shake the feeling that there is a simpler solution that es=
capes us...
> > > > Maybe fs anti-freeze (see blow).
> > > >
> > > > > > > > > In theory, I am not saying we should do it, but as a thou=
ght experiment:
> > > > > > > > > if the requirement from permission event handler is that =
is must use a
> > > > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event t=
o make
> > > > > > > > > any filesystem modifications, then instead of aiming for =
NOWAIT
> > > > > > > > > semantics using sb_start_write_trylock(), we could use a =
freeze level
> > > > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > > > >
> > > > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as =
long as we
> > > > > > > > > make it clear how userspace should avoid nesting "VFS fau=
lts" there is
> > > > > > > > > a model that can solve the deadlock correctly.
> > > > > > > >
> > > > > > > > OK, yes, in principle another freeze level which could be u=
sed by handlers
> > > > > > > > of fanotify permission events would solve the deadlock as w=
ell. Just you
> > > > > > > > seem to like to tie this functionality to the particular fd=
 returned from
> > > > > > > > fanotify and I'm not convinced that is a good idea. What if=
 the application
> > > > > > > > needs to do write to some other location besides the one fd=
 it got passed
> > > > > > > > from fanotify event? E.g. imagine it wants to fetch a whole=
 subtree on
> > > > > > > > first access to any file in a subtree. Or maybe it wants to=
 write to some
> > > > > > > > DB file containing current state or something like that.
> > > > > > > >
> > > > > > > > One solution I can imagine is to create an open flag that c=
an be specified
> > > > > > > > on open which would result in the special behavior wrt fs f=
reezing. If the
> > > > > > > > special behavior would be just trylocking the freeze protec=
tion then it
> > > > > > > > would be really easy. If the behaviour would be another fre=
eze protection
> > > > > > > > level, then we'd need to make sure we don't generate anothe=
r fanotify
> > > > > > > > permission event with such fd - autorejecting any such acce=
ss is an obvious
> > > > > > > > solution but I'm not sure if practical for applications.
> > > > > > > >
> > > > > > >
> > > > > > > I had also considered marking the listener process with the F=
SNOTIFY
> > > > > > > context and enforcing this context on fanotify_read().
> > > > > > > In a way, this is similar to the NOIO and NOFS process contex=
t.
> > > > > > > It could be used to both act as a stronger form of FMODE_NONO=
TIFY
> > > > > > > and to activate the desired freeze protection behavior
> > > > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > > > >
> > > > > >
> > > > > > My feeling is that the best approach would be a PF_NOWAIT task =
flag:
> > > > > >
> > > > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > > > - PF_NOWAIT could be auto-set on the reader of a permission eve=
nt
> > > > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > > > > > - We could add user API to set this personality explicitly to a=
ny task
> > > > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > > > > >
> > > > > > Please let me know if you agree with this design and if so,
> > > > > > which of the methods to set PF_NOWAIT are a must for the first =
version
> > > > > > in your opinion?
> > > > >
> > > > > Yeah, the PF flag could work. It can be set for the process(es) r=
esponsible
> > > > > for processing the fanotify events and filling in filesystem cont=
ents. I
> > > > > don't think automatic setting of this flag is desirable though as=
 it has
> > > > > quite wide impact and some of the consequences could be surprisin=
g.  I
> > > > > rather think it should be a conscious decision when setting up th=
e process
> > > > > processing the events. So I think API to explicitly set / clear t=
he flag
> > > > > would be the best. Also I think it would be better to capture in =
the name
> > > > > that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE =
or
> > > > > something like that?
> > > > >
> > > >
> > > > Sure.
> > > >
> > > > > Also we were thinking about having an open(2) flag for this (inst=
ead of PF
> > > > > flag) in the past. That would allow finer granularity control of =
the
> > > > > behavior but I guess you are worried that it would not cover all =
the needed
> > > > > operations?
> > > > >
> > > >
> > > > Yeh, it seems like an API that is going to be harder to write safe =
HSM
> > > > programs with.
> > > >
> > > > > > Do you think we should use this method to fix the existing dead=
locks
> > > > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > > > >
> > > > > No, I think if someone cares about these, they should explicitly =
set the
> > > > > PF flag in their task processing the events.
> > > > >
> > > >
> > > > OK.
> > > >
> > > > I see an exit hatch in this statement -
> > > > If we are going leave the responsibility to avoid deadlock in corne=
r
> > > > cases completely in the hands of the application, then I do not fee=
l
> > > > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > > > providing the first HSM API.
> > > >
> > > > If the HSM application is running in a controlled system, on a file=
system
> > > > where fsfreeze is not expected or not needed, then a fully function=
al and
> > > > safe HSM does not require PF_NOWAIT_FREEZE API.
> > > >
> > > > Perhaps an API to make an fs unfreezable is just as practical and a=
 much
> > > > easier option for the first version of HSM API?
> > > >
> > > > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > > > ioctl. Then no other task can freeze the fs, for as long as the fd =
is open
> > > > apart from the HSM itself using this fd.
> > >
> > > This would mean you also prevent FREEZE_HOLDER_KERNEL requests which =
xfs
> > > uses for filesystem scrubbing iirc. I would reckon that you also run
> > > into problems with device mapper workloads where freeze/thaw requests
> > > from the block layer and into the filesystem layer are quite common.
> >
> > I agree. These cases will not play nicely with EXCLUSIVE_FSFREEZER.
> > The only case where the EXCLUSIVE_FSFREEZER API makes sense
> > is when the admin does not expect to meet any fsfreeze on the target fs=
 and
> > wants to enforce that.
> >
> > >
> > > Have you given any thought to the idea - similar to a FUSE daemon - t=
hat
> > > you could register with a given filesystem as an HSM? Maybe integrati=
on
> > > like this is really undesirable for some reason but that may be an
> > > alternative.
> >
> > I am not sure what you mean by "register with a given filesystem"?
> > The comparison to FUSE daemon buffels me.  The main point with fanotify
> > HSM was for the user to be able to work natively on the target filesyst=
em
> > without any "passthrough".
> >
> > FUSE passthrough is a valid way to implement HSM.
> > Many HSM already use FUSE and many HSM will continue to use FUSE.
> > Improving FUSE passthough performance (e.g. FUSE BPF) is another
> > way to improve HSM.
> >
> > Compared to fanotify HSM, FUSE passthrough is more versalite, but it
> > is also more resource expensive and some native fs features (e.g. ioctl=
s)
> > will never work properly with FUSE passthrough.
> >
> > Not sure if that answers your question?
>
> This isn't about FUSE passthrough. Maybe the analogy doesn't work.
>
> What I just meant is similar to how fanotify registers itself as
> watching an inode or a mount or superblock one could have a new HSM
> watch type that lets the fs detect that it is watched by an HSM and then
> refuse to be frozen or other special behavior you might need. I don't
> know much about HSMs so I might just be talking nonsense.

Implementing mandatory anti-fsfreeze for any fs watches by HSM events
would be trivial and does not require specific filesystem integration.

I've already written a vfs API to advertise that filesystems are watches by
pre-modify HSM events in a later part of the series:
https://github.com/amir73il/linux/commit/88db3054b6bfa5ef4240175fa9efd6b3a8=
71818c

However, if we do choose the solution of anti-fsfreeze,
I much prefer to leave it in the hands of userspace via
EXCLUSIVE_FSFREEZER API over mandatory anti-fsfreeze.

The main reason is that unlike what may be inferred from this thread,
HSM + fsfreeze CAN live quite well together, including HSM + xfs scrub,
HSM + LVM.

After the patches that are now in the vfs.rw branch, it takes much more
than just HSM + fsfreeze to cause a deadlock.

It requires HSM + fsfreeze + splice from a file on:
(
  - a nested overlayfs, whose lower^2 fs is on the "host" fs
  OR
  - a loop mounted filesystem, whose image file is on the "host" fs
)
AND
- the splice is to a file on the "host" fs

These two scenarios are not possible in a container, for example,
when the "host" fs is not exposed for write, directly or indirectly,
to the container.

And of course for many systems, those scenarios do not exist at all,
so there is no need for any anti-fsfreeze, not mandatory, nor user
controlled.

Thanks,
Amir.

