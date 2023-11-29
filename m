Return-Path: <linux-fsdevel+bounces-4207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E27FDD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45591F20FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC973B2B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmTTUFSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBC1BCB
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:41 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-42033328ad0so38110241cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701269081; x=1701873881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXSfL9qJnBzBkcfsfzZ8iKBLzLj/gf5x+AzW0+Vho2U=;
        b=VmTTUFShkd+j1vfh18mY5YdDmY/SGNcUffUuXC1NW1iRDOsS83RUMrKwnhX3UkhEr7
         1C+rVW2LW1+wkkZ80L4aMpzOKKbAGNTCETkbV2viMLkzZvhgkWFGydVRnbtwVekToCil
         1qXa1CnzrviCuJvT38uVq3nX4LpCapjRrtZ3dfJ40W/6qgZbZaJW5fPXIgckx8Kwwnon
         5SmDmFJUv5uDyj3E0RR3XQJx/AcKUJkqU7rx701i7inMo6v8igFRjLIqDWRqit55E12U
         n6/0DC+EzWWTSwQFcKiw9DOsK4jk4A9W7cFVJasbTLTqvaNhKqCXEoAUFYMCAqmqQhQS
         6kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269081; x=1701873881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXSfL9qJnBzBkcfsfzZ8iKBLzLj/gf5x+AzW0+Vho2U=;
        b=JX10Kf66JdHjDUNJgxcWFzKAAf2w+pOAVKu4dxjGO2t4YIHA0XKpMGwmemxYWk4gJQ
         FgUlZo3+7wwifAn0nC/N5RpwNIO8QCtN49UKePM+e0K+nnE6LZBLqo9ouNJocH3yX/t2
         NnEcQepdW1gk8EyCs7c9RaIwESxSvr7uKwj4KIJaSr0Ae7SZMMx57zRxbVVpnKIyR9Zy
         PyI/fbVtSqKPCDYVEj4b63S6yq6P1E9VjTmD3HghhoinNRCL4/jP25ekzZas93tl7F9C
         NsDcbTRoH8ELUPF9C8gAHnztJNLMa2XKSalokl7N0t9+e8I8z0tsMmnn1K+9kuKDV67S
         OkSw==
X-Gm-Message-State: AOJu0YxBHUwgH7RZr/3upd7n1Ra60pPpr4TV4Vq2tmrTXUrWUMPvSOgr
	a5ZlszyHBGdtBRaVp4aEQJxGKBrt/gXh76vyH7M=
X-Google-Smtp-Source: AGHT+IHcrR7L9we4hCWky3C9Slw8Be+AMFHhDJ5dGAQbvziLD6RyJjoq98BJ+NzXBJWo0XEXRgMSJFK2zgqPXPF+mMQ=
X-Received: by 2002:a05:6214:5604:b0:67a:4b63:ca71 with SMTP id
 mg4-20020a056214560400b0067a4b63ca71mr9308989qvb.0.1701269080808; Wed, 29 Nov
 2023 06:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3> <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3> <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
 <20231127191153.GH2366036@perftesting> <CAOQ4uxjLZZavhkKaWFa8T7+bCR+N2VRVsv4VusXvN5UMJjBiRA@mail.gmail.com>
 <20231128145547.GA2382537@perftesting> <CAOQ4uxhjEb-wXjoZDSHoH+bwebQzSSAVnPicEB8y6sJsDHLohQ@mail.gmail.com>
 <20231128214258.GA2398475@perftesting> <CAOQ4uxgGYv0Z4Z4GRsrLB1uaq+4K0=QjaURGQ-7iKpgo5z4UOQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgGYv0Z4Z4GRsrLB1uaq+4K0=QjaURGQ-7iKpgo5z4UOQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 16:44:28 +0200
Message-ID: <CAOQ4uxg+hqFTHmg-ieo=th5-KaZeZZLEZDjbd9FE19YeJobPPQ@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 7:22=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Nov 28, 2023 at 11:43=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >
> > On Tue, Nov 28, 2023 at 06:52:00PM +0200, Amir Goldstein wrote:
> > > On Tue, Nov 28, 2023 at 4:55=E2=80=AFPM Josef Bacik <josef@toxicpanda=
.com> wrote:
> > > >
> > > > On Tue, Nov 28, 2023 at 01:05:50PM +0200, Amir Goldstein wrote:
> > > > > On Mon, Nov 27, 2023 at 9:11=E2=80=AFPM Josef Bacik <josef@toxicp=
anda.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > > > > > > On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Jan Kara <jack@suse.c=
z> wrote:
> > > > > > > >
> > > > > > > > Hi Amir,
> > > > > > > >
> > > > > > > > sorry for a bit delayed reply, I did not get to "swapping i=
n" HSM
> > > > > > > > discussion during the Plumbers conference :)
> > > > > > > >
> > > > > > > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > > > > > > On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <a=
mir73il@gmail.com> wrote:
> > > > > > > > > > On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@=
suse.cz> wrote:
> > > > > > > > > > > > Recap for new people joining this thread.
> > > > > > > > > > > >
> > > > > > > > > > > > The following deadlock is possible in upstream kern=
el
> > > > > > > > > > > > if fanotify permission event handler tries to make
> > > > > > > > > > > > modifications to the filesystem it is watching in t=
he context
> > > > > > > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > > > > > > >
> > > > > > > > > > > > P1                             P2                  =
    P3
> > > > > > > > > > > > -----------                    ------------        =
    ------------
> > > > > > > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > > > > > > -> sb_start_write(fs1.sb)
> > > > > > > > > > > >   -> do_splice_direct()                         fre=
eze_super(fs1.sb)
> > > > > > > > > > > >     -> rw_verify_area()                         -> =
sb_wait_write(fs1.sb) ......
> > > > > > > > > > > >       -> security_file_permission()
> > > > > > > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > > > > > > >                                  -> do_unlinkat(fs1=
.dfd, ...)
> > > > > > > > > > > >                                    -> sb_start_writ=
e(fs1.sb) ......
> > > > > > > > > > > >
> > > > > > > > > > > > start-write-safe patches [1] (not posted) are tryin=
g to solve this
> > > > > > > > > > > > deadlock and prepare the ground for a new set of pe=
rmission events
> > > > > > > > > > > > with cleaner/safer semantics.
> > > > > > > > > > > >
> > > > > > > > > > > > The cases described above of sendfile from a file i=
n loop mounted
> > > > > > > > > > > > image over fs1 or overlayfs over fs1 into a file in=
 fs1 can still
> > > > > > > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > > > > > > >
> > > > > > > > > > > Yep, nice summary.
> > > > > > > > ...
> > > > > > > > > > > > > As I wrote above I don't like the abuse of FMODE_=
NONOTIFY much.
> > > > > > > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fa=
notify events when using
> > > > > > > > > > > > > this fd. It says nothing about freeze handling or=
 so. Furthermore as you
> > > > > > > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace=
 but practically all
> > > > > > > > > > > > > current fanotify users need to also do IO on othe=
r files in order to handle
> > > > > > > > > > > > > fanotify event. So ideally we'd have a way to do =
IO to other files in a
> > > > > > > > > > > > > manner safe wrt freezing. We could just update ha=
ndling of RWF_NOWAIT flag
> > > > > > > > > > > > > to only trylock freeze protection - that actually=
 makes a lot of sense to
> > > > > > > > > > > > > me. The question is whether this is enough or not=
.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, b=
ecause writing
> > > > > > > > > > > > to a file is not the only thing that HSM needs to d=
o.
> > > > > > > > > > > > Eventually, event handler for lookup permission eve=
nts should be
> > > > > > > > > > > > able to also create files without blocking on vfs l=
evel freeze protection.
> > > > > > > > > > >
> > > > > > > > > > > So this is what I wanted to clarify. The lookup permi=
ssion event never gets
> > > > > > > > > > > called under a freeze protection so the deadlock does=
n't exist there. In
> > > > > > > > > > > principle the problem exists only for access and modi=
fy events where we'd
> > > > > > > > > > > be filling in file data and thus RWF_NOWAIT could be =
enough.
> > > > > > > > > >
> > > > > > > > > > Yes, you are right.
> > > > > > > > > > It is possible that RWF_NOWAIT could be enough.
> > > > > > > > > >
> > > > > > > > > > But the discovery of the loop/ovl corner cases has shak=
en my
> > > > > > > > > > confidence is the ability to guarantee that freeze prot=
ection is not
> > > > > > > > > > held somehow indirectly.
> > > > > > > > > >
> > > > > > > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the ex=
act
> > > > > > > > > > same ovl corner case, because with splice from ovl1 to =
fs1,
> > > > > > > > > > fs1 freeze protection is held and:
> > > > > > > > > >   ovl_splice_read(ovl1.file)
> > > > > > > > > >     ovl_real_fdget()
> > > > > > > > > >       ovl_open_realfile(fs1.file)
> > > > > > > > > >          ... security_file_open(fs1.file)
> > > > > > > > > >
> > > > > > > > > > > That being
> > > > > > > > > > > said I understand this may be assuming too much about=
 the implementations
> > > > > > > > > > > of HSM daemons and as you write, we might want to pro=
vide a way to do IO
> > > > > > > > > > > not blocking on freeze protection from any hook. But =
I wanted to point this
> > > > > > > > > > > out explicitly so that it's a conscious decision.
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I agree and I'd like to explain using an example, why RWF=
_NOWAIT is
> > > > > > > > > not enough for HSM needs.
> > > > > > > > >
> > > > > > > > > The reason is that often, when HSM needs to handle fillin=
g content
> > > > > > > > > in FAN_PRE_ACCESS, it is not just about writing to the ac=
cessed file.
> > > > > > > > > HSM needs to be able to avoid blocking on freeze protecti=
on
> > > > > > > > > for any operations on the filesystem, not just pwrite().
> > > > > > > > >
> > > > > > > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > > > > > > from the lookup event and uses it in the handling of acce=
ss events to
> > > > > > > > > update the metadata files that store which parts of the f=
ile were already
> > > > > > > > > filled (relying of fiemap is not always a valid option).
> > > > > > > > >
> > > > > > > > > That is the reason that in the POC patches [2], FMODE_NON=
OTIFY
> > > > > > > > > is propagated from dirfd to an fd opened with openat(dirf=
d, ...), so
> > > > > > > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any=
 file.
> > > > > > > > >
> > > > > > > > > Another use case is that HSM may want to download content=
 to a
> > > > > > > > > temp file on the same filesystem, verify the downloaded c=
ontent and
> > > > > > > > > then clone the data into the accessed file range.
> > > > > > > > >
> > > > > > > > > I think that a PF_ flag (see below) would work best for a=
ll those cases.
> > > > > > > >
> > > > > > > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon =
need not be
> > > > > > > > enough for all sensible usecases to avoid deadlocks with fr=
eezing. However
> > > > > > > > note that if we want to really properly handle all possible=
 operations, we
> > > > > > > > need to start handling error from all sb_start_write() and
> > > > > > > > file_start_write() calls and there are quite a few of those=
.
> > > > > > > >
> > > > > > >
> > > > > > > Darn, forgot about those.
> > > > > > > I am starting to reconsider adding a freeze level.
> > > > > > > I cannot shake the feeling that there is a simpler solution t=
hat escapes us...
> > > > > > > Maybe fs anti-freeze (see blow).
> > > > > > >
> > > > > > > > > > > > In theory, I am not saying we should do it, but as =
a thought experiment:
> > > > > > > > > > > > if the requirement from permission event handler is=
 that is must use a
> > > > > > > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the e=
vent to make
> > > > > > > > > > > > any filesystem modifications, then instead of aimin=
g for NOWAIT
> > > > > > > > > > > > semantics using sb_start_write_trylock(), we could =
use a freeze level
> > > > > > > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > > > > > > >
> > > > > > > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", =
so as long as we
> > > > > > > > > > > > make it clear how userspace should avoid nesting "V=
FS faults" there is
> > > > > > > > > > > > a model that can solve the deadlock correctly.
> > > > > > > > > > >
> > > > > > > > > > > OK, yes, in principle another freeze level which coul=
d be used by handlers
> > > > > > > > > > > of fanotify permission events would solve the deadloc=
k as well. Just you
> > > > > > > > > > > seem to like to tie this functionality to the particu=
lar fd returned from
> > > > > > > > > > > fanotify and I'm not convinced that is a good idea. W=
hat if the application
> > > > > > > > > > > needs to do write to some other location besides the =
one fd it got passed
> > > > > > > > > > > from fanotify event? E.g. imagine it wants to fetch a=
 whole subtree on
> > > > > > > > > > > first access to any file in a subtree. Or maybe it wa=
nts to write to some
> > > > > > > > > > > DB file containing current state or something like th=
at.
> > > > > > > > > > >
> > > > > > > > > > > One solution I can imagine is to create an open flag =
that can be specified
> > > > > > > > > > > on open which would result in the special behavior wr=
t fs freezing. If the
> > > > > > > > > > > special behavior would be just trylocking the freeze =
protection then it
> > > > > > > > > > > would be really easy. If the behaviour would be anoth=
er freeze protection
> > > > > > > > > > > level, then we'd need to make sure we don't generate =
another fanotify
> > > > > > > > > > > permission event with such fd - autorejecting any suc=
h access is an obvious
> > > > > > > > > > > solution but I'm not sure if practical for applicatio=
ns.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I had also considered marking the listener process with=
 the FSNOTIFY
> > > > > > > > > > context and enforcing this context on fanotify_read().
> > > > > > > > > > In a way, this is similar to the NOIO and NOFS process =
context.
> > > > > > > > > > It could be used to both act as a stronger form of FMOD=
E_NONOTIFY
> > > > > > > > > > and to activate the desired freeze protection behavior
> > > > > > > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > My feeling is that the best approach would be a PF_NOWAIT=
 task flag:
> > > > > > > > >
> > > > > > > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > > > > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > > > > > > - PF_NOWAIT could be auto-set on the reader of a permissi=
on event
> > > > > > > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_P=
ATH
> > > > > > > > > - We could add user API to set this personality explicitl=
y to any task
> > > > > > > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission even=
ts
> > > > > > > > >
> > > > > > > > > Please let me know if you agree with this design and if s=
o,
> > > > > > > > > which of the methods to set PF_NOWAIT are a must for the =
first version
> > > > > > > > > in your opinion?
> > > > > > > >
> > > > > > > > Yeah, the PF flag could work. It can be set for the process=
(es) responsible
> > > > > > > > for processing the fanotify events and filling in filesyste=
m contents. I
> > > > > > > > don't think automatic setting of this flag is desirable tho=
ugh as it has
> > > > > > > > quite wide impact and some of the consequences could be sur=
prising.  I
> > > > > > > > rather think it should be a conscious decision when setting=
 up the process
> > > > > > > > processing the events. So I think API to explicitly set / c=
lear the flag
> > > > > > > > would be the best. Also I think it would be better to captu=
re in the name
> > > > > > > > that this is really about fs freezing. So maybe PF_NOWAIT_F=
REEZE or
> > > > > > > > something like that?
> > > > > > > >
> > > > > > >
> > > > > > > Sure.
> > > > > > >
> > > > > > > > Also we were thinking about having an open(2) flag for this=
 (instead of PF
> > > > > > > > flag) in the past. That would allow finer granularity contr=
ol of the
> > > > > > > > behavior but I guess you are worried that it would not cove=
r all the needed
> > > > > > > > operations?
> > > > > > > >
> > > > > > >
> > > > > > > Yeh, it seems like an API that is going to be harder to write=
 safe HSM
> > > > > > > programs with.
> > > > > > >
> > > > > > > > > Do you think we should use this method to fix the existin=
g deadlocks
> > > > > > > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > > > > > > >
> > > > > > > > No, I think if someone cares about these, they should expli=
citly set the
> > > > > > > > PF flag in their task processing the events.
> > > > > > > >
> > > > > > >
> > > > > > > OK.
> > > > > > >
> > > > > > > I see an exit hatch in this statement -
> > > > > > > If we are going leave the responsibility to avoid deadlock in=
 corner
> > > > > > > cases completely in the hands of the application, then I do n=
ot feel
> > > > > > > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > > > > > > providing the first HSM API.
> > > > > > >
> > > > > > > If the HSM application is running in a controlled system, on =
a filesystem
> > > > > > > where fsfreeze is not expected or not needed, then a fully fu=
nctional and
> > > > > > > safe HSM does not require PF_NOWAIT_FREEZE API.
> > > > > > >
> > > > > > > Perhaps an API to make an fs unfreezable is just as practical=
 and a much
> > > > > > > easier option for the first version of HSM API?
> > > > > > >
> > > > > > > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > > > > > > ioctl. Then no other task can freeze the fs, for as long as t=
he fd is open
> > > > > > > apart from the HSM itself using this fd.
> > > > > > >
> > > > > > > HSM itself can avoid deadlocks if it collaborates the fs free=
zes with
> > > > > > > making fs modifications from within HSM events.
> > > > > > >
> > > > > > > Do you think that may be an acceptable way out or the corner?
> > > > > >
> > > > > > This is kind of a corner case that I think is acceptable to jus=
t leave up to
> > > > > > application developers.  Speaking as a potential consumer of th=
is work we don't
> > > > > > use fsfreeze so aren't concerned wit this in practice, and argu=
ably if you're
> > > > > > using this interface you know what you're doing.  As long as th=
e sharp edge is
> > > > > > well documented I think that's fine for v1.
> > > > > >
> > > > >
> > > > > I agree that this is good enough for v1.
> > > > > The only question is can we (and should we) do better than good e=
nough for v1.
> > > > >
> > > > > > Long term I like the EXCLUSIVE_FSFREEZER option, noting Christi=
an's comment
> > > > > > about the xfs scrubbing use case.  We all know that "freeze thi=
s file system" is
> > > > > > an operation that is going to take X amount of time, so as long=
 as we provide
> > > > > > the application a way to block fsfreeze to avoid the deadlock t=
hen I think
> > > > > > that's a reasonable solution.  Additionally it would allow us a=
n avenue to
> > > > > > gracefully handle errors.  If we race and see that the fs is al=
ready frozen well
> > > > > > then we can go back to the HSM with an error saying he's out of=
 luck, and he can
> > > > > > return -EAGAIN or something through fanotify to unwind and try =
again later.
> > > > > >
> > > > >
> > > > > Actually, "fs is already frozen" is not a deadlock case.
> > > > > If "fs is already frozen" then fsfreeze was successful and HSM sh=
ould just
> > > > > wait in line like everyone else until fs is unfrozen.
> > > > >
> > > > > The deadlock case is "fs is being frozen" (i.e. sb->s_writers.fro=
zen is
> > > > > in state SB_FREEZE_WRITE), which cannot make progress because
> > > > > an existing holder of sb write is blocked on an HSM event, which =
in turn
> > > > > is trying to start a new sb write.
> > > >
> > > > Right, and now I'm confused.  You have your patchset to re-order th=
e permission
> > > > checks to before the sb_start_write(), so an HSM watching FAN_OPEN_=
PERM is no
> > > > longer holding the sb write lock and thus can't deadlock, correct?
> > >
> > > Correct.
> > >
> > > >
> > > > The new things you are proposing (FAN_PRE_ACESS and FAN_PRE_MODIFY)=
 also do not
> > > > happen inside of an sb_start_write(), correct?
> > > >
> > >
> > > Almost correct.
> > >
> > > The callers of the security_file_permission() hook do not hold sb_sta=
rt_write()
> > > *directly*, but it can be held *indirectly* in splice(file_in_fs1, fi=
le_in_fs2).
> > > That is the corner case I was trying to explain.
> > >
> > > When fs1 (splice source fs) is a loop mounted fs and the loop image f=
ile
> > > is on fs2 (a.k.a the "host" fs), which also happens to be to splice d=
est fs,
> > > splice grabs sb_start_write() on fs2.
> > >
> > > After the patches in vfs.rw, splice() no longer calls security_file_p=
ermission()
> > > directly on the file in the loop mounted fs1, but the reads from loop=
dev
> > > translate to reads on the image file, which can call security_file_pe=
rmission()
> > > on the loop image file on the "host" fs (fs2), while sb_start_write()=
 is held.
> > >
> > > IOW, if HSM needs to fill the content on the loop image file and fsfr=
eeze on
> > > the "host" fs that is the destination of splice, gets in the middle, =
there is
> > > a chance for a deadlock, because freeze will never make progress and
> > > HSM filling of the loop image file is blocked.
> > >
> > > Yes, it is a corner case, but it exists and a similar one exists with=
 a splice
> > > from an overlayfs file into a file on a "host" fs, which also happens=
 to be the
> > > lower layer of overlayfs (I have a test case that triggered this).
> > >
> >
> > I had to still draw this on my whiteboard to make sure I understood it =
properly,
> > so I'm going to draw it here to make sure I did actually understand it,=
 because
> > it is indeed quite complex if I'm understanding you correctly.
> >
> > We have the following
> >
> > File A on FS 1 which is a loopback device backed by File B on FS 2
>
> B is the normal file on FS2, so I guess you meant to say backed by file C
>
> > File B on FS 2 which is a normal file
> >
> > We have an HSM watching FS1 to populate files.
> >
> > sendfile(A, B);
> >
> > This does
> >
> > file_start_write(FS2);
> >
> > Then we start to read from A to populate the page, this triggers the HS=
M, which
> > then wants to write to FS1.
> >
> > At this point some other process calls fsfreeze(FS2), and now we're dea=
dlocked,
> > because the HSM is stuck at sb_start_write(FS2) trying to write to the =
FS1 which
> > is backed by FS2, but we're already holding file_start_write(FS2) becau=
se of
> > splice.
> >
> > Is this correct?
>
> Yes, this is correct.
> I was describing a different variant of deadlock when FS2 is watched by H=
SM
> and HSM wants to write to the image file C upon reading from file A.
>
> There are many variants of this, but the root cause is operating of file =
A
> while holding sb_start_write() on file B on another fs.
>
> >
> > If it is, I think the best thing to do is actually push the file_start_=
write()
> > deeper into the splice work.  Do something like the patch I've applied =
below,
> > which is wildly untested and uncompiled.  However I think this closes t=
his
> > deadlock in a nice clean way, because we're reading and then writing, a=
nd we
> > don't have to worry about any shenanigans under the read path because w=
e only
> > hold the sb_write_start() when we do the actual write part.  Does that =
make
> > sense?
>
> That makes a lot of sense!
>
> I think this is the correct way out of the deadlock corner case.
> I will amend the patch and test it.
>
> Thanks for getting me out of tunnel vision ;)
>
> Some comments for myself below...
>
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 4382881b0709..f37bb41551fe 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, =
const struct path *old,
> >         return ovl_real_fileattr_set(new, &newfa);
> >  }
> >
> > +static int ovl_splice_actor(struct pipe_inode_info *pipe,
> > +                           struct splice_desc *sd)
> > +{
> > +       struct file *file =3D sd->u.file;
> > +       long ret;
> > +
> > +       ovl_start_write(file_dentry(file));
> > +       ret =3D vfs_do_splice_from(pipe, file, sd->opos, sd->total_len,
> > +                                sd->flags);
> > +       ovl_end_write(file_dentry(file));
> > +       return ret;
> > +}
> > +

On second look, this custom ovl actor is not needed at all.
ovl_start_write(file_dentry(file)) is completely equivalent to
file_start_write(file) in this context, so no need to export any actor.

OTOH, generic_copy_file_range() and ceph (from ->copy_file_range())
call do_splice_direct() with file_start_write() held and this is a bit hard=
er
to untangle.

The easy solution is to export do_splice_copy_file_range(), which is
a variant of do_splice_direct() with an actor that does not take
file_start_write().

The good thing about copy_file_range() is that it is only allowed across
sb for filesystems with ->copy_file_range(), so if we ban HSM events
on those filesystems, the freeze deadlock is averted.

I don't think we need to support HSM events on fuse/ceph/cifs/nfs/ovl
anyway, even if some of them do not allow cross sb copy.

Thanks,
Amir.

