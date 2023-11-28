Return-Path: <linux-fsdevel+bounces-4023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87577FB8F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21302B21D9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44A4E632;
	Tue, 28 Nov 2023 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhDrg6pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA51E1B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 03:06:03 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4629afba9acso1685800137.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 03:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701169563; x=1701774363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ8wCLMJ1mVyuf/blbZvbemtdtL6vzTr7sWicHxnUuM=;
        b=hhDrg6pGVzI6BmoHiv7jGY8xwZH0bSMxs3vmo/PmBkQSVrMfPGxXRh9Ae83rNUKWhB
         0aZrBv9tF7gmmSZ6OEM/7GSMcLtJDaSecMM9lwb86nZvylHPgRPEJP/7YY4XUzhP7+gO
         VaVS9/8ooIBYvmGQ4ABJ412QJiDT8zTWFzCvP8cpy8GQN8nB4grXcIM1fIpg+cXZl6xm
         R1wwiU2Ue/3RhT+hBJOuhWUHNqdneUELM8L1gufnDAbLmIQpbpzVHnJCHEHjyUeJ/MZD
         E57CnmPUMPK0+9x/+0FkJhoNJoxCJmMMU72Z9mMHd8ha4DC3GCv64BSyVvRi+QSOrYvs
         HUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169563; x=1701774363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ8wCLMJ1mVyuf/blbZvbemtdtL6vzTr7sWicHxnUuM=;
        b=ECIkU+t7AhbiKGOGcOW18zxQ63kr3kLCcEvL2U/dxf/VV9dzkaP3ZyBezDpJMgohwP
         azLkbEfxV9ltgrOoIeXC72Mqe82/TB85ihkDWgSRZxRhpXnIsY8R3pH59V5pZHXEcAbj
         NUWnOnZ3dWQV4t9s8H8keU+9fMVHXIF6MWFUNcSYG9ZYofqxYBm0wtJ2Af+ZwhN8OBw4
         cKBag+//ysM+H9wdpWzyMH2x/W8QJjdt1uWp6qGdYibpa/M4xSnE9C/oUe7N1csrFphG
         Yo90x6ljrDQMDxJ0IY+26mmBKXfRPf79eTnjVPt35BiZ0xI70FbA4HxvbVr7OxNY+gab
         Fycg==
X-Gm-Message-State: AOJu0YxsbQ5v67vAo0EzYZ/GAP142S45zcZ5ISXPm2N5wMjoJZz5NajD
	Ffw+S3uDc5PcLFMUVdrIfEgZCmDFVbTGM14QOHM=
X-Google-Smtp-Source: AGHT+IFiYMXvu50n7h7RR6Wcc8UZVzPd7MXV6Oy7lI+BmmmbAMxxG5WDYDE7M01UN5L++WSxW7/Z2DT/Jve/8pJlZZg=
X-Received: by 2002:a05:6102:94b:b0:45e:461e:e5a3 with SMTP id
 a11-20020a056102094b00b0045e461ee5a3mr10851958vsi.1.1701169562685; Tue, 28
 Nov 2023 03:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816094702.zztx3dctxvnfeh6o@quack3> <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3> <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3> <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3> <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
 <20231127191153.GH2366036@perftesting>
In-Reply-To: <20231127191153.GH2366036@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Nov 2023 13:05:50 +0200
Message-ID: <CAOQ4uxjLZZavhkKaWFa8T7+bCR+N2VRVsv4VusXvN5UMJjBiRA@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 9:11=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi Amir,
> > >
> > > sorry for a bit delayed reply, I did not get to "swapping in" HSM
> > > discussion during the Plumbers conference :)
> > >
> > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gm=
ail.com> wrote:
> > > > > On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@suse.cz> w=
rote:
> > > > > > > Recap for new people joining this thread.
> > > > > > >
> > > > > > > The following deadlock is possible in upstream kernel
> > > > > > > if fanotify permission event handler tries to make
> > > > > > > modifications to the filesystem it is watching in the context
> > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > >
> > > > > > > P1                             P2                      P3
> > > > > > > -----------                    ------------            ------=
------
> > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > -> sb_start_write(fs1.sb)
> > > > > > >   -> do_splice_direct()                         freeze_super(=
fs1.sb)
> > > > > > >     -> rw_verify_area()                         -> sb_wait_wr=
ite(fs1.sb) ......
> > > > > > >       -> security_file_permission()
> > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > > > > >                                    -> sb_start_write(fs1.sb) =
......
> > > > > > >
> > > > > > > start-write-safe patches [1] (not posted) are trying to solve=
 this
> > > > > > > deadlock and prepare the ground for a new set of permission e=
vents
> > > > > > > with cleaner/safer semantics.
> > > > > > >
> > > > > > > The cases described above of sendfile from a file in loop mou=
nted
> > > > > > > image over fs1 or overlayfs over fs1 into a file in fs1 can s=
till
> > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > >
> > > > > > Yep, nice summary.
> > > ...
> > > > > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY m=
uch.
> > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify eve=
nts when using
> > > > > > > > this fd. It says nothing about freeze handling or so. Furth=
ermore as you
> > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace but pract=
ically all
> > > > > > > > current fanotify users need to also do IO on other files in=
 order to handle
> > > > > > > > fanotify event. So ideally we'd have a way to do IO to othe=
r files in a
> > > > > > > > manner safe wrt freezing. We could just update handling of =
RWF_NOWAIT flag
> > > > > > > > to only trylock freeze protection - that actually makes a l=
ot of sense to
> > > > > > > > me. The question is whether this is enough or not.
> > > > > > > >
> > > > > > >
> > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because wri=
ting
> > > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > > Eventually, event handler for lookup permission events should=
 be
> > > > > > > able to also create files without blocking on vfs level freez=
e protection.
> > > > > >
> > > > > > So this is what I wanted to clarify. The lookup permission even=
t never gets
> > > > > > called under a freeze protection so the deadlock doesn't exist =
there. In
> > > > > > principle the problem exists only for access and modify events =
where we'd
> > > > > > be filling in file data and thus RWF_NOWAIT could be enough.
> > > > >
> > > > > Yes, you are right.
> > > > > It is possible that RWF_NOWAIT could be enough.
> > > > >
> > > > > But the discovery of the loop/ovl corner cases has shaken my
> > > > > confidence is the ability to guarantee that freeze protection is =
not
> > > > > held somehow indirectly.
> > > > >
> > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > > > same ovl corner case, because with splice from ovl1 to fs1,
> > > > > fs1 freeze protection is held and:
> > > > >   ovl_splice_read(ovl1.file)
> > > > >     ovl_real_fdget()
> > > > >       ovl_open_realfile(fs1.file)
> > > > >          ... security_file_open(fs1.file)
> > > > >
> > > > > > That being
> > > > > > said I understand this may be assuming too much about the imple=
mentations
> > > > > > of HSM daemons and as you write, we might want to provide a way=
 to do IO
> > > > > > not blocking on freeze protection from any hook. But I wanted t=
o point this
> > > > > > out explicitly so that it's a conscious decision.
> > > > > >
> > > >
> > > > I agree and I'd like to explain using an example, why RWF_NOWAIT is
> > > > not enough for HSM needs.
> > > >
> > > > The reason is that often, when HSM needs to handle filling content
> > > > in FAN_PRE_ACCESS, it is not just about writing to the accessed fil=
e.
> > > > HSM needs to be able to avoid blocking on freeze protection
> > > > for any operations on the filesystem, not just pwrite().
> > > >
> > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > from the lookup event and uses it in the handling of access events =
to
> > > > update the metadata files that store which parts of the file were a=
lready
> > > > filled (relying of fiemap is not always a valid option).
> > > >
> > > > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > > > is propagated from dirfd to an fd opened with openat(dirfd, ...), s=
o
> > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> > > >
> > > > Another use case is that HSM may want to download content to a
> > > > temp file on the same filesystem, verify the downloaded content and
> > > > then clone the data into the accessed file range.
> > > >
> > > > I think that a PF_ flag (see below) would work best for all those c=
ases.
> > >
> > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not b=
e
> > > enough for all sensible usecases to avoid deadlocks with freezing. Ho=
wever
> > > note that if we want to really properly handle all possible operation=
s, we
> > > need to start handling error from all sb_start_write() and
> > > file_start_write() calls and there are quite a few of those.
> > >
> >
> > Darn, forgot about those.
> > I am starting to reconsider adding a freeze level.
> > I cannot shake the feeling that there is a simpler solution that escape=
s us...
> > Maybe fs anti-freeze (see blow).
> >
> > > > > > > In theory, I am not saying we should do it, but as a thought =
experiment:
> > > > > > > if the requirement from permission event handler is that is m=
ust use a
> > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to ma=
ke
> > > > > > > any filesystem modifications, then instead of aiming for NOWA=
IT
> > > > > > > semantics using sb_start_write_trylock(), we could use a free=
ze level
> > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > >
> > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long=
 as we
> > > > > > > make it clear how userspace should avoid nesting "VFS faults"=
 there is
> > > > > > > a model that can solve the deadlock correctly.
> > > > > >
> > > > > > OK, yes, in principle another freeze level which could be used =
by handlers
> > > > > > of fanotify permission events would solve the deadlock as well.=
 Just you
> > > > > > seem to like to tie this functionality to the particular fd ret=
urned from
> > > > > > fanotify and I'm not convinced that is a good idea. What if the=
 application
> > > > > > needs to do write to some other location besides the one fd it =
got passed
> > > > > > from fanotify event? E.g. imagine it wants to fetch a whole sub=
tree on
> > > > > > first access to any file in a subtree. Or maybe it wants to wri=
te to some
> > > > > > DB file containing current state or something like that.
> > > > > >
> > > > > > One solution I can imagine is to create an open flag that can b=
e specified
> > > > > > on open which would result in the special behavior wrt fs freez=
ing. If the
> > > > > > special behavior would be just trylocking the freeze protection=
 then it
> > > > > > would be really easy. If the behaviour would be another freeze =
protection
> > > > > > level, then we'd need to make sure we don't generate another fa=
notify
> > > > > > permission event with such fd - autorejecting any such access i=
s an obvious
> > > > > > solution but I'm not sure if practical for applications.
> > > > > >
> > > > >
> > > > > I had also considered marking the listener process with the FSNOT=
IFY
> > > > > context and enforcing this context on fanotify_read().
> > > > > In a way, this is similar to the NOIO and NOFS process context.
> > > > > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > > > > and to activate the desired freeze protection behavior
> > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > >
> > > >
> > > > My feeling is that the best approach would be a PF_NOWAIT task flag=
:
> > > >
> > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > - PF_NOWAIT could be auto-set on the reader of a permission event
> > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > > > - We could add user API to set this personality explicitly to any t=
ask
> > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > > >
> > > > Please let me know if you agree with this design and if so,
> > > > which of the methods to set PF_NOWAIT are a must for the first vers=
ion
> > > > in your opinion?
> > >
> > > Yeah, the PF flag could work. It can be set for the process(es) respo=
nsible
> > > for processing the fanotify events and filling in filesystem contents=
. I
> > > don't think automatic setting of this flag is desirable though as it =
has
> > > quite wide impact and some of the consequences could be surprising.  =
I
> > > rather think it should be a conscious decision when setting up the pr=
ocess
> > > processing the events. So I think API to explicitly set / clear the f=
lag
> > > would be the best. Also I think it would be better to capture in the =
name
> > > that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
> > > something like that?
> > >
> >
> > Sure.
> >
> > > Also we were thinking about having an open(2) flag for this (instead =
of PF
> > > flag) in the past. That would allow finer granularity control of the
> > > behavior but I guess you are worried that it would not cover all the =
needed
> > > operations?
> > >
> >
> > Yeh, it seems like an API that is going to be harder to write safe HSM
> > programs with.
> >
> > > > Do you think we should use this method to fix the existing deadlock=
s
> > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > >
> > > No, I think if someone cares about these, they should explicitly set =
the
> > > PF flag in their task processing the events.
> > >
> >
> > OK.
> >
> > I see an exit hatch in this statement -
> > If we are going leave the responsibility to avoid deadlock in corner
> > cases completely in the hands of the application, then I do not feel
> > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > providing the first HSM API.
> >
> > If the HSM application is running in a controlled system, on a filesyst=
em
> > where fsfreeze is not expected or not needed, then a fully functional a=
nd
> > safe HSM does not require PF_NOWAIT_FREEZE API.
> >
> > Perhaps an API to make an fs unfreezable is just as practical and a muc=
h
> > easier option for the first version of HSM API?
> >
> > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > ioctl. Then no other task can freeze the fs, for as long as the fd is o=
pen
> > apart from the HSM itself using this fd.
> >
> > HSM itself can avoid deadlocks if it collaborates the fs freezes with
> > making fs modifications from within HSM events.
> >
> > Do you think that may be an acceptable way out or the corner?
>
> This is kind of a corner case that I think is acceptable to just leave up=
 to
> application developers.  Speaking as a potential consumer of this work we=
 don't
> use fsfreeze so aren't concerned wit this in practice, and arguably if yo=
u're
> using this interface you know what you're doing.  As long as the sharp ed=
ge is
> well documented I think that's fine for v1.
>

I agree that this is good enough for v1.
The only question is can we (and should we) do better than good enough for =
v1.

> Long term I like the EXCLUSIVE_FSFREEZER option, noting Christian's comme=
nt
> about the xfs scrubbing use case.  We all know that "freeze this file sys=
tem" is
> an operation that is going to take X amount of time, so as long as we pro=
vide
> the application a way to block fsfreeze to avoid the deadlock then I thin=
k
> that's a reasonable solution.  Additionally it would allow us an avenue t=
o
> gracefully handle errors.  If we race and see that the fs is already froz=
en well
> then we can go back to the HSM with an error saying he's out of luck, and=
 he can
> return -EAGAIN or something through fanotify to unwind and try again late=
r.
>

Actually, "fs is already frozen" is not a deadlock case.
If "fs is already frozen" then fsfreeze was successful and HSM should just
wait in line like everyone else until fs is unfrozen.

The deadlock case is "fs is being frozen" (i.e. sb->s_writers.frozen is
in state SB_FREEZE_WRITE), which cannot make progress because
an existing holder of sb write is blocked on an HSM event, which in turn
is trying to start a new sb write.

So far, we have discussed proposals to:
- put sb in state where sb_wait_write(sb, SB_FREEZE_WRITE)
  will not be called (anti-fsfreeze)
- put HSM process (or HSM fd) in a state, where sb_start_write_trylock()
  is called instead of sb_start_write() from within event handler context
- put HSM process (or HSM fd) in a state, where SB_FREEZE_FSNOTIFY
  level is taken instead of sb_start_write() from within event handler cont=
ext

There may be another option:
- on read of HSM event, fanotify calls sb_start_write_trylock() and
  put HSM fd in a "nested sb write" state, where sb_start_write() does not
  take the SB_FREEZE_WRITE freeze level lock at all if
  sb->s_writers.frozen is in SB_FREEZE_WRITE state

But that sounds a bit subtle, specifically, we will need to make sure
that a "nested" sb_start_write() scope must be completed before an
HSM event is completed/canceled. I will not even try to go down this
road unless Jan gives me his blessing and a roadmap...

> But this is a pretty narrow corner case, you've done the due diligence to=
 avoid
> the other deadlocks, I don't feel that coming up with a solution to this =
is a
> necessary pre-requisite to the actual feature.  Documenting it clearly is=
 the
> only thing I would ask.

TBH, I am not at ease with "only documenting" for v1.
Since your use case has no fsfreeze, I would be much more comfortable
with "mandatory anti-freeze" plus documentation for v1,
because it is easy to relax "mandatory anti-freeze" later with finer graine=
d
anti-deadlock mechanisms and for use cases with no fsfreeze at all,
"mandatory anti-freeze" doesn't hurt.

Anyway, I am going to wait for Jan's decision on the minimum requirement fo=
r v1.

Thanks,
Amir.

