Return-Path: <linux-fsdevel+bounces-2790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B57E9B67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC6BB20BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C571D523;
	Mon, 13 Nov 2023 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqFf5Qs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C31CFA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 11:50:18 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C94D5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 03:50:15 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7789a4c01easo284173585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 03:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699876215; x=1700481015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSRRpXTFZIQroPTaMyLSjgFmFwGHdLaN1T1FJpIGwl0=;
        b=VqFf5Qs8Fq7W2R/JUbKvctHYjCdAB2rix8Qa/auATmjp2WeO5RjKeCtgEX8kkvjbJu
         dZ2vy63g7/UaWIXA60DsxdHVbcDAtxoooyw5w69lAxTSzmvMJPbo/ZOyRYX4WxS6pfEj
         2lUKw1cAB7t7vSZNqZTWg9XZj2A/xQz1JksR2Zf4iuY89lDWduIOETYIfVC/FGOZYVIa
         p4zMlce21fjoXnoKHTKTc0RTaVdBSAzhfaUcqDtMXJWUnAg9n0lHw5K/QSS5KK4zRQ4r
         zW9J4tIJXojAbt+cT4+uQNtvwI1Xbb+RwlX+YM0CLG2Be6BjrMd1WQXvbHsANj8ZdECn
         0wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699876215; x=1700481015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSRRpXTFZIQroPTaMyLSjgFmFwGHdLaN1T1FJpIGwl0=;
        b=YSMY+4Nf5xWxEa/wqAkY7XS9JrLYV0aq2qNiG+3kp1dzlpxl7jD0j1F4XHRIpF7bsi
         d1jxXvSL2HHU4XVKu/a93tSLqkPxmPNvK3Qnr4HL56McjBBe29VfI16qSjqwO4wW7CtS
         /BJt2ra/a604l/HYJ8nNNVh6WwrM8BSYZc/4oSlr/2iGdSZMrKlqMJblskK0lKRfCw0R
         bJetFmpjtXmKhORMofQ7w+en77K9/DuLNWanwoG+Vs9++nXDAJ3mJrM+mGji4mmf5jDU
         c9W5X/laWhej7+2pPSighlZyQ0rH67XK6anzF05ayg9z9exMxDLqmZuSxmwt+P9W/i8l
         RYbA==
X-Gm-Message-State: AOJu0YwROxC4bKnWhSs/bsbZ+8jhsPmJkM47/a8OLp7LIauT+cM1JGZG
	UH0zoBn0/vZX9R4bpOL8n/gdYj90f/Ih1OgStVI=
X-Google-Smtp-Source: AGHT+IEv5H4NknCHro96D2e+DOH5TOsvmL7Kfoqe0aBBQROu1n9YkAdYRwj35ZgvnGN3sxzNyvzcWqMbl+hQ18UYY8U=
X-Received: by 2002:a05:6214:2e01:b0:66d:173a:aca7 with SMTP id
 mx1-20020a0562142e0100b0066d173aaca7mr6660853qvb.55.1699876214745; Mon, 13
 Nov 2023 03:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629171157.54l44agwejgnquw3@quack3> <CAOQ4uxgxFtBZy4V8vccV2F7Lbg_9=OFNhgdgCP6Hu=o7gjcsVQ@mail.gmail.com>
 <20230703183029.nn5adeyphijv5wl6@quack3> <CAOQ4uxiS6R9hGFmputP6uRHGKywaCca0Ug53ihGcrgxkvMHomg@mail.gmail.com>
 <CAOQ4uxhk_rydFejNqsmn4AydZfuknp=vPunNODNcZ_8qW-AykQ@mail.gmail.com>
 <20230816094702.zztx3dctxvnfeh6o@quack3> <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3> <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3> <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Nov 2023 13:50:03 +0200
Message-ID: <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 18-08-23 10:01:40, Amir Goldstein wrote:
> > > [adding fsdevel]
> > >
> > > On Thu, Aug 17, 2023 at 9:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > >
> > > > On Thu 17-08-23 10:13:20, Amir Goldstein wrote:
> > > > > [CC Christian and Jens for the NOWAIT semantics]
> > > > >
> > > > > Jan,
> > > > >
> > > > > I was going to post start-write-safe patches [1], but now that th=
is
> > > > > design issue has emerged, with your permission, I would like to
> > > > > take this discussion to fsdevel, so please reply to the list.
> > > > >
> > > > > For those who just joined, the context is fanotify HSM API [2]
> > > > > proposal and avoiding the fanotify deadlocks I described in my
> > > > > talk on LSFMM [3].
> > > >
> > > > OK, sure. I'm resending the reply which I sent only to you here.
> > > >
> > > > > On Wed, Aug 16, 2023 at 8:18=E2=80=AFPM Amir Goldstein <amir73il@=
gmail.com> wrote:
> > > > > > On Wed, Aug 16, 2023 at 12:47=E2=80=AFPM Jan Kara <jack@suse.cz=
> wrote:
> > > > > > > On Mon 14-08-23 16:57:48, Amir Goldstein wrote:
> > > > > > > > On Mon, Jul 3, 2023 at 11:03=E2=80=AFPM Amir Goldstein <ami=
r73il@gmail.com> wrote:
> > > > > > > > > On Mon, Jul 3, 2023, 9:30 PM Jan Kara <jack@suse.cz> wrot=
e:
> > > > > > > > do_sendfile() or ovl_copy_up() from ovl1 to xfs1, end up ca=
lling
> > > > > > > > do_splice_direct() with sb_writers(xfs1) held.
> > > > > > > > Internally, the splice operation calls into ovl_splice_read=
(), which
> > > > > > > > has to call the rw_verify_area() check with the fsnotify ho=
ok on the
> > > > > > > > underlying xfs file.
> > > > > > >
> > > > > > > Right, we can call rw_verify_area() only after overlayfs has =
told us what
> > > > > > > is actually the underlying file that is really used for readi=
ng. Hum,
> > > > > > > nasty.
> > > > > > >
> > > > > > > > This is a violation of start-write-safe permission hooks an=
d the
> > > > > > > > lockdep_assert that I added in fsnotify_permission() catche=
s this
> > > > > > > > violation.
> > > > > > > >
> > > > > > > > I believe that a similar issue exists with do_splice_direct=
() from
> > > > > > > > an fs that is loop mounted over an image file on xfs1 to xf=
s1.
> > > > > > >
> > > > > > > I don't see how that would be possible. If you have a loop im=
age file on
> > > > > > > filesystem xfs1, then the filesystem stored in the image is s=
ome xfs2.
> > > > > > > Overlayfs case is special here because it doesn't really work=
 with
> > > > > > > filesystems but rather directory subtrees and that causes the
> > > > > > > complications.
> > > > > > >
> > > > > >
> > > > > > I was referring to sendfile() from xfs2 to xfs1.
> > > > > > sb_writers of xfs1 is held, but loop needs to read from the ima=
ge file
> > > > > > in xfs1. No?
> > > >
> > > > Yes, that seems possible and it would indeed trigger rw_verify_area=
() in
> > > > do_iter_read() on xfs1 while freeze protection for xfs1 is held.
> > > >
> > >
> > > Recap for new people joining this thread.
> > >
> > > The following deadlock is possible in upstream kernel
> > > if fanotify permission event handler tries to make
> > > modifications to the filesystem it is watching in the context
> > > of FAN_ACCESS_PERM handling in some cases:
> > >
> > > P1                             P2                      P3
> > > -----------                    ------------            ------------
> > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > -> sb_start_write(fs1.sb)
> > >   -> do_splice_direct()                         freeze_super(fs1.sb)
> > >     -> rw_verify_area()                         -> sb_wait_write(fs1.=
sb) ......
> > >       -> security_file_permission()
> > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > >                                  -> do_unlinkat(fs1.dfd, ...)
> > >                                    -> sb_start_write(fs1.sb) ......
> > >
> > > start-write-safe patches [1] (not posted) are trying to solve this
> > > deadlock and prepare the ground for a new set of permission events
> > > with cleaner/safer semantics.
> > >
> > > The cases described above of sendfile from a file in loop mounted
> > > image over fs1 or overlayfs over fs1 into a file in fs1 can still dea=
dlock
> > > despite the start-write-safe patches [1].
> >
> > Yep, nice summary.
> >
> > > > > > > > My earlier patches had annotated the rw_verify_area() calls
> > > > > > > > in splice iterators as "MAY_NOT_START_WRITE" and the
> > > > > > > > userspace event listener was notified via flag whether modi=
fying
> > > > > > > > the content of the file was allowed or not.
> > > > > > > >
> > > > > > > > I do not care so much about HSM being able to fill content =
of files
> > > > > > > > from a nested context like this, but we do need some way fo=
r
> > > > > > > > userspace to at least deny this access to a file with no co=
ntent.
> > > > > > > >
> > > > > > > > Another possibility I thought of is to change file_start_wr=
ite()
> > > > > > > > do use file_start_write_trylock() for files with FMODE_NONO=
TIFY.
> > > > > > > > This should make it safe to fill file content when event is=
 generated
> > > > > > > > with sb_writers held (if freeze is in progress modification=
 will fail).
> > > > > > > > Right?
> > > > > > >
> > > > > > > OK, so you mean that the HSM managing application will get an=
 fd with
> > > > > > > FMODE_NONOTIFY set from an event and use it for filling in th=
e file
> > > > > > > contents and the kernel functions grabbing freeze protection =
will detect
> > > > > > > the file flag and bail with error instead of waiting? That so=
unds like an
> > > > > > > attractive solution - the HSM managing app could even reply w=
ith error like
> > > > > > > ERESTARTSYS to fanotify event and make the syscall restart (w=
hich will
> > > > > > > block until the fs is unfrozen and then we can try again) and=
 thus handle
> > > > > > > the whole problem transparently for the application generatin=
g the event.
> > > > > > > But I'm just dreaming now, for start it would be fine to just=
 fail the
> > > > > > > syscall.
> > > > > > >
> > > > > >
> > > > > > IMO, a temporary error from an HSM controlled fs is not a big d=
eal.
> > > > > > Same as a temporary error from a network fs or FUSE - should be
> > > > > > tolerable when the endpoint is not connected.
> > > > > > One of my patches allows HSM returning an error that is not EPE=
RM as
> > > > > > response - this can be useful in such situations.
> > > >
> > > > OK.
> > > >
> > > > > > > I see only three possible problems with the solution. Firstly=
, the HSM
> > > > > > > application will have to be careful to only access the manage=
d filesystem
> > > > > > > with the fd returned from fanotify event as otherwise it coul=
d deadlock on
> > > > > > > frozen filesystem.
> > > > > >
> > > > > > Isn't that already the case to some extent?
> > > > > > It is not wise for permission event handlers to perform operati=
ons
> > > > > > on fd without  FMODE_NONOTIFY.
> > > >
> > > > Yes, it isn't a new problem. The amount of bug reports in our bugzi=
lla
> > > > boiling down to this kind of self-deadlock just shows that fanotify=
 users
> > > > get this wrong all the time.
> > > >
> > > > > > > That may seem obvious but practice shows that with
> > > > > > > complex software stacks with many dependencies, this is far f=
rom trivial.
> > > > > >
> > > > > > It will be especially important when we have permission events
> > > > > > on directory operations that need to perform operations on O_PA=
TH
> > > > > > dirfd with FMODE_NONOTIFY.
> > > > > >
> > > > > > > Secondly, conditioning the trylock behavior on FMODE_NONOTIFY=
 seems
> > > > > > > somewhat arbitary unless you understand our implementation is=
sues and
> > > > > > > possibly it could regress current unsuspecting users. So I'm =
thinking
> > > > > > > whether we shouldn't rather have an explicit open flag requir=
ing erroring
> > > > > > > out on frozen filesystem instead of blocking and the HSM appl=
ication will
> > > > > > > need to use it to evade freezing deadlocks. Or we can just de=
pend on
> > > > > > > RWF_NOWAIT flag (we currently block on frozen filesystem desp=
ite this flag
> > > > > > > but that can be viewed as a bug) but that's limited to writes=
 (i.e., no way
> > > > > > > to e.g. do fallocate(2) without blocking on frozen fs).
> > > > > >
> > > > > > User cannot ask for fd with FMODE_NONOTIFY as it is - this is p=
rovided
> > > > > > as a means to an end by fanotify - so it would not be much diff=
erent if
> > > > > > the new events would provide an fd with FMODE_NONOTIFY |
> > > > > > FMODE_NOWAIT. It will be up to documentation to say what is and=
 what
> > > > > > is not allowed with the event->fd provided by fanotify.
> > > > > >
> > > > >
> > > > > This part needs clarifying.
> > > > > Technically, we can use the flag FMODE_NOWAIT to prevent waiting =
in
> > > > > file_start_write() *when* it is combined with FMODE_NONOTIFY.
> > > > >
> > > > > Yes, it would be a change of behavior, but I think it would be a =
good change,
> > > > > because current event->fd from FAN_ACCESS_PERM events is really n=
ot
> > > > > write-safe (could deadlock with freezing fs).
> > > >
> > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events when=
 using
> > > > this fd. It says nothing about freeze handling or so. Furthermore a=
s you
> > > > observe FMODE_NONOTIFY cannot be set by userspace but practically a=
ll
> > > > current fanotify users need to also do IO on other files in order t=
o handle
> > > > fanotify event. So ideally we'd have a way to do IO to other files =
in a
> > > > manner safe wrt freezing. We could just update handling of RWF_NOWA=
IT flag
> > > > to only trylock freeze protection - that actually makes a lot of se=
nse to
> > > > me. The question is whether this is enough or not.
> > > >
> > >
> > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > to a file is not the only thing that HSM needs to do.
> > > Eventually, event handler for lookup permission events should be
> > > able to also create files without blocking on vfs level freeze protec=
tion.
> >
> > So this is what I wanted to clarify. The lookup permission event never =
gets
> > called under a freeze protection so the deadlock doesn't exist there. I=
n
> > principle the problem exists only for access and modify events where we=
'd
> > be filling in file data and thus RWF_NOWAIT could be enough.
>
> Yes, you are right.
> It is possible that RWF_NOWAIT could be enough.
>
> But the discovery of the loop/ovl corner cases has shaken my
> confidence is the ability to guarantee that freeze protection is not
> held somehow indirectly.
>
> If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> same ovl corner case, because with splice from ovl1 to fs1,
> fs1 freeze protection is held and:
>   ovl_splice_read(ovl1.file)
>     ovl_real_fdget()
>       ovl_open_realfile(fs1.file)
>          ... security_file_open(fs1.file)
>
> > That being
> > said I understand this may be assuming too much about the implementatio=
ns
> > of HSM daemons and as you write, we might want to provide a way to do I=
O
> > not blocking on freeze protection from any hook. But I wanted to point =
this
> > out explicitly so that it's a conscious decision.
> >

I agree and I'd like to explain using an example, why RWF_NOWAIT is
not enough for HSM needs.

The reason is that often, when HSM needs to handle filling content
in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
HSM needs to be able to avoid blocking on freeze protection
for any operations on the filesystem, not just pwrite().

For example, the POC HSM code [1], stores the DATA_DIR_fd
from the lookup event and uses it in the handling of access events to
update the metadata files that store which parts of the file were already
filled (relying of fiemap is not always a valid option).

That is the reason that in the POC patches [2], FMODE_NONOTIFY
is propagated from dirfd to an fd opened with openat(dirfd, ...), so
HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.

Another use case is that HSM may want to download content to a
temp file on the same filesystem, verify the downloaded content and
then clone the data into the accessed file range.

I think that a PF_ flag (see below) would work best for all those cases.

> > > In theory, I am not saying we should do it, but as a thought experime=
nt:
> > > if the requirement from permission event handler is that is must use =
a
> > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > any filesystem modifications, then instead of aiming for NOWAIT
> > > semantics using sb_start_write_trylock(), we could use a freeze level
> > > SB_FREEZE_FSNOTIFY between
> > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > >
> > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> > > make it clear how userspace should avoid nesting "VFS faults" there i=
s
> > > a model that can solve the deadlock correctly.
> >
> > OK, yes, in principle another freeze level which could be used by handl=
ers
> > of fanotify permission events would solve the deadlock as well. Just yo=
u
> > seem to like to tie this functionality to the particular fd returned fr=
om
> > fanotify and I'm not convinced that is a good idea. What if the applica=
tion
> > needs to do write to some other location besides the one fd it got pass=
ed
> > from fanotify event? E.g. imagine it wants to fetch a whole subtree on
> > first access to any file in a subtree. Or maybe it wants to write to so=
me
> > DB file containing current state or something like that.
> >
> > One solution I can imagine is to create an open flag that can be specif=
ied
> > on open which would result in the special behavior wrt fs freezing. If =
the
> > special behavior would be just trylocking the freeze protection then it
> > would be really easy. If the behaviour would be another freeze protecti=
on
> > level, then we'd need to make sure we don't generate another fanotify
> > permission event with such fd - autorejecting any such access is an obv=
ious
> > solution but I'm not sure if practical for applications.
> >
>
> I had also considered marking the listener process with the FSNOTIFY
> context and enforcing this context on fanotify_read().
> In a way, this is similar to the NOIO and NOFS process context.
> It could be used to both act as a stronger form of FMODE_NONOTIFY
> and to activate the desired freeze protection behavior
> (whether trylock or SB_FREEZE_FSNOTIFY level).
>

My feeling is that the best approach would be a PF_NOWAIT task flag:

- PF_NOWAIT will prevent blocking on freeze protection
- PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
- PF_NOWAIT could be auto-set on the reader of a permission event
- PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
- We could add user API to set this personality explicitly to any task
- PF_NOWAIT without FMODE_NONOTIFY denies permission events

Please let me know if you agree with this design and if so,
which of the methods to set PF_NOWAIT are a must for the first version
in your opinion?

Do you think we should use this method to fix the existing deadlocks
with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?

[...]

> > > OK. ATM, the only solution I can think of that is both maintainable
> > > and lets HSM live in complete harmony with fsfreeze is adding the
> > > extra SB_FREEZE_FSNOTIFY level.
> >
> > To make things clear: if the only problems would be with those sendfile=
(2)
> > rare corner-cases, then I guess we can live with that and implement ret=
ry
> > in the kernel if userspace ever complains about unexpected short copy o=
r
> > EAGAIN...  The problem I see is that if we advise that all IO from the
> > fanotify event handler should happen in the freeze-safe manner, then wi=
th
> > the non-blocking solution all HSM IO suddently starts failing as soon a=
s
> > the filesystem is frozen. And that is IMHO not nice.
>
> I see what you mean. The SB_FREEZE_FSNOTIFY design is much more
> clear in that respect.
>
> > > I am not sure how big of an overhead that would be?
> > > I imagine that sb_writers is large enough as it is w.r.t fitting into
> > > cache lines?
> > > I don't think that it adds much complexity or maintenance burden
> > > to vfs?? I'm really not sure.
> >
> > Well, the overhead is effectively one percpu counter per superblock.
> > Negligible in terms of CPU time, somewhat annoying in terms of memory b=
ut
> > bearable. So this may be a way forward.
> >
>

My feeling is that because we only need this to handle very obscure
corner cases, that adding an extra freeze level is an overkill that
cannot be justified, even if the actual impact on cpu and memory are
rather low.

The HSM API documentation will clearly state that EAGAIN may be
expected when writing to the filesystem.

IMO, for all practical matters, it is perfectly fine if HSM just denies
access in those corner cases, but even a simple solution of triggering
async download of file's content and returning a temporary to user
is a decent solution for the rare corner cases.

FYI, I've already gotten requests from people in the community that
are waiting for this feature and are testing the POC patches,
so my plan is to send out the permission hooks cleanup patches [3]
soon and try to get the first part of the HSM API [4]
(FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events)
ready for the next cycle.

In any case, permission hooks cleanup patches are independent
of the solution we will choose for the corner cases that they do
not handle.

Thanks,
Amir.

[2] https://github.com/amir73il/httpdirfs/commits/fan_lookup_perm
[2] https://github.com/amir73il/linux/commits/fan_lookup_perm
[3] https://github.com/amir73il/linux/commits/start-write-safe
[4] https://github.com/amir73il/linux/commits/fan_pre_content

