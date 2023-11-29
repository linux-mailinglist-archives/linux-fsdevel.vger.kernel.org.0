Return-Path: <linux-fsdevel+bounces-4146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B87FCF36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6147DB20EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC77E5668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC7jKsQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38EC172E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 21:22:45 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a47104064so16361856d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 21:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701235365; x=1701840165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9xYARn9YSfxbNwpSCZNHHF/HHGk+wODw0ifn7HrIkU=;
        b=gC7jKsQuvQLa/vw5+wiX3uYXIuuqaZAG9Gn67np4mDf0Nd8sACFlhCFeUeTIHPZyow
         CxdeSE0JwXPltIz3JKXtucCG5MtLZMjY18q86nu474HtOfM1+q9fSrB1zYqOfCbMkT+Z
         adXdG2EHx3rb51M+/zD6IuHUIg27E+hZx4AuJwUqXW6Q8ISheApK3b11ctbOqPr8SA0k
         d3Q9WlOyW6HsbK5p28DG12lqt/VyMCO2M0Yja/tYMUnnzK+q6wvEJQ1eZeduyS2efZdS
         tY2+EkoJKxAMGULRlvrz0XrGOmWpGtTlsoTwNlUg36KYCJSZoXmoy5F8kLolQaoUfQRA
         13aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701235365; x=1701840165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9xYARn9YSfxbNwpSCZNHHF/HHGk+wODw0ifn7HrIkU=;
        b=tYjTFIXSOYqTWkQAYayAXqrZaaoOwxJwHFoXgVc0nVTY3O68KoRK40U3KOYOFJ4T1p
         VlN76TdK+xFGPQAdPWbZEN6jUyuM1JVnyS8YTp1GLZ0KTVn91vl06rOMdrG1PRN3OjIi
         siZ/QOw/AxbCemODxYU4qtMjkmBfjUHgNTpu8JkzvarcobrZ/TzZ+CKvTPrbDb0swapP
         W5lFNxTrChX8UG0lAWNhRe84D43TQn1aHZLmE7oHDO0b3EbThWEx5HaI1vbajHrH5nGH
         5fyFEZQrFuWJN5qHblVNAEZlwcDrQMJrJCiENo2GtYyWEIghSv5xjSzfoBOTgPeBWly4
         Tw+g==
X-Gm-Message-State: AOJu0YwEGqU4OI68yCO5DFia8yimvft24Kfg9DrwCav1j71u6+YhZ/H3
	zy44D4XqYfWpaXgHVCHqEC1hyLcQ/hm0RVQdy6M=
X-Google-Smtp-Source: AGHT+IH8/FASFDMe9+HK2440Wa2xeVNkGXDy5D1qDicrQ8q374jcJcUjD0rbb9I1Dhb79ecTNZAcroOe1aUhWNyAEFM=
X-Received: by 2002:ad4:4e82:0:b0:67a:234c:2c8e with SMTP id
 dy2-20020ad44e82000000b0067a234c2c8emr12249885qvb.56.1701235364556; Tue, 28
 Nov 2023 21:22:44 -0800 (PST)
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
 <20231128214258.GA2398475@perftesting>
In-Reply-To: <20231128214258.GA2398475@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 07:22:32 +0200
Message-ID: <CAOQ4uxgGYv0Z4Z4GRsrLB1uaq+4K0=QjaURGQ-7iKpgo5z4UOQ@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:43=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> On Tue, Nov 28, 2023 at 06:52:00PM +0200, Amir Goldstein wrote:
> > On Tue, Nov 28, 2023 at 4:55=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Tue, Nov 28, 2023 at 01:05:50PM +0200, Amir Goldstein wrote:
> > > > On Mon, Nov 27, 2023 at 9:11=E2=80=AFPM Josef Bacik <josef@toxicpan=
da.com> wrote:
> > > > >
> > > > > On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > > > > > On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Jan Kara <jack@suse.cz>=
 wrote:
> > > > > > >
> > > > > > > Hi Amir,
> > > > > > >
> > > > > > > sorry for a bit delayed reply, I did not get to "swapping in"=
 HSM
> > > > > > > discussion during the Plumbers conference :)
> > > > > > >
> > > > > > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > > > > > On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <ami=
r73il@gmail.com> wrote:
> > > > > > > > > On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@su=
se.cz> wrote:
> > > > > > > > > > > Recap for new people joining this thread.
> > > > > > > > > > >
> > > > > > > > > > > The following deadlock is possible in upstream kernel
> > > > > > > > > > > if fanotify permission event handler tries to make
> > > > > > > > > > > modifications to the filesystem it is watching in the=
 context
> > > > > > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > > > > > >
> > > > > > > > > > > P1                             P2                    =
  P3
> > > > > > > > > > > -----------                    ------------          =
  ------------
> > > > > > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > > > > > -> sb_start_write(fs1.sb)
> > > > > > > > > > >   -> do_splice_direct()                         freez=
e_super(fs1.sb)
> > > > > > > > > > >     -> rw_verify_area()                         -> sb=
_wait_write(fs1.sb) ......
> > > > > > > > > > >       -> security_file_permission()
> > > > > > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > > > > > >                                  -> do_unlinkat(fs1.d=
fd, ...)
> > > > > > > > > > >                                    -> sb_start_write(=
fs1.sb) ......
> > > > > > > > > > >
> > > > > > > > > > > start-write-safe patches [1] (not posted) are trying =
to solve this
> > > > > > > > > > > deadlock and prepare the ground for a new set of perm=
ission events
> > > > > > > > > > > with cleaner/safer semantics.
> > > > > > > > > > >
> > > > > > > > > > > The cases described above of sendfile from a file in =
loop mounted
> > > > > > > > > > > image over fs1 or overlayfs over fs1 into a file in f=
s1 can still
> > > > > > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > > > > > >
> > > > > > > > > > Yep, nice summary.
> > > > > > > ...
> > > > > > > > > > > > As I wrote above I don't like the abuse of FMODE_NO=
NOTIFY much.
> > > > > > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fano=
tify events when using
> > > > > > > > > > > > this fd. It says nothing about freeze handling or s=
o. Furthermore as you
> > > > > > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace b=
ut practically all
> > > > > > > > > > > > current fanotify users need to also do IO on other =
files in order to handle
> > > > > > > > > > > > fanotify event. So ideally we'd have a way to do IO=
 to other files in a
> > > > > > > > > > > > manner safe wrt freezing. We could just update hand=
ling of RWF_NOWAIT flag
> > > > > > > > > > > > to only trylock freeze protection - that actually m=
akes a lot of sense to
> > > > > > > > > > > > me. The question is whether this is enough or not.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, bec=
ause writing
> > > > > > > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > > > > > > Eventually, event handler for lookup permission event=
s should be
> > > > > > > > > > > able to also create files without blocking on vfs lev=
el freeze protection.
> > > > > > > > > >
> > > > > > > > > > So this is what I wanted to clarify. The lookup permiss=
ion event never gets
> > > > > > > > > > called under a freeze protection so the deadlock doesn'=
t exist there. In
> > > > > > > > > > principle the problem exists only for access and modify=
 events where we'd
> > > > > > > > > > be filling in file data and thus RWF_NOWAIT could be en=
ough.
> > > > > > > > >
> > > > > > > > > Yes, you are right.
> > > > > > > > > It is possible that RWF_NOWAIT could be enough.
> > > > > > > > >
> > > > > > > > > But the discovery of the loop/ovl corner cases has shaken=
 my
> > > > > > > > > confidence is the ability to guarantee that freeze protec=
tion is not
> > > > > > > > > held somehow indirectly.
> > > > > > > > >
> > > > > > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exac=
t
> > > > > > > > > same ovl corner case, because with splice from ovl1 to fs=
1,
> > > > > > > > > fs1 freeze protection is held and:
> > > > > > > > >   ovl_splice_read(ovl1.file)
> > > > > > > > >     ovl_real_fdget()
> > > > > > > > >       ovl_open_realfile(fs1.file)
> > > > > > > > >          ... security_file_open(fs1.file)
> > > > > > > > >
> > > > > > > > > > That being
> > > > > > > > > > said I understand this may be assuming too much about t=
he implementations
> > > > > > > > > > of HSM daemons and as you write, we might want to provi=
de a way to do IO
> > > > > > > > > > not blocking on freeze protection from any hook. But I =
wanted to point this
> > > > > > > > > > out explicitly so that it's a conscious decision.
> > > > > > > > > >
> > > > > > > >
> > > > > > > > I agree and I'd like to explain using an example, why RWF_N=
OWAIT is
> > > > > > > > not enough for HSM needs.
> > > > > > > >
> > > > > > > > The reason is that often, when HSM needs to handle filling =
content
> > > > > > > > in FAN_PRE_ACCESS, it is not just about writing to the acce=
ssed file.
> > > > > > > > HSM needs to be able to avoid blocking on freeze protection
> > > > > > > > for any operations on the filesystem, not just pwrite().
> > > > > > > >
> > > > > > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > > > > > from the lookup event and uses it in the handling of access=
 events to
> > > > > > > > update the metadata files that store which parts of the fil=
e were already
> > > > > > > > filled (relying of fiemap is not always a valid option).
> > > > > > > >
> > > > > > > > That is the reason that in the POC patches [2], FMODE_NONOT=
IFY
> > > > > > > > is propagated from dirfd to an fd opened with openat(dirfd,=
 ...), so
> > > > > > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any f=
ile.
> > > > > > > >
> > > > > > > > Another use case is that HSM may want to download content t=
o a
> > > > > > > > temp file on the same filesystem, verify the downloaded con=
tent and
> > > > > > > > then clone the data into the accessed file range.
> > > > > > > >
> > > > > > > > I think that a PF_ flag (see below) would work best for all=
 those cases.
> > > > > > >
> > > > > > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon ne=
ed not be
> > > > > > > enough for all sensible usecases to avoid deadlocks with free=
zing. However
> > > > > > > note that if we want to really properly handle all possible o=
perations, we
> > > > > > > need to start handling error from all sb_start_write() and
> > > > > > > file_start_write() calls and there are quite a few of those.
> > > > > > >
> > > > > >
> > > > > > Darn, forgot about those.
> > > > > > I am starting to reconsider adding a freeze level.
> > > > > > I cannot shake the feeling that there is a simpler solution tha=
t escapes us...
> > > > > > Maybe fs anti-freeze (see blow).
> > > > > >
> > > > > > > > > > > In theory, I am not saying we should do it, but as a =
thought experiment:
> > > > > > > > > > > if the requirement from permission event handler is t=
hat is must use a
> > > > > > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the eve=
nt to make
> > > > > > > > > > > any filesystem modifications, then instead of aiming =
for NOWAIT
> > > > > > > > > > > semantics using sb_start_write_trylock(), we could us=
e a freeze level
> > > > > > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > > > > > >
> > > > > > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so=
 as long as we
> > > > > > > > > > > make it clear how userspace should avoid nesting "VFS=
 faults" there is
> > > > > > > > > > > a model that can solve the deadlock correctly.
> > > > > > > > > >
> > > > > > > > > > OK, yes, in principle another freeze level which could =
be used by handlers
> > > > > > > > > > of fanotify permission events would solve the deadlock =
as well. Just you
> > > > > > > > > > seem to like to tie this functionality to the particula=
r fd returned from
> > > > > > > > > > fanotify and I'm not convinced that is a good idea. Wha=
t if the application
> > > > > > > > > > needs to do write to some other location besides the on=
e fd it got passed
> > > > > > > > > > from fanotify event? E.g. imagine it wants to fetch a w=
hole subtree on
> > > > > > > > > > first access to any file in a subtree. Or maybe it want=
s to write to some
> > > > > > > > > > DB file containing current state or something like that=
.
> > > > > > > > > >
> > > > > > > > > > One solution I can imagine is to create an open flag th=
at can be specified
> > > > > > > > > > on open which would result in the special behavior wrt =
fs freezing. If the
> > > > > > > > > > special behavior would be just trylocking the freeze pr=
otection then it
> > > > > > > > > > would be really easy. If the behaviour would be another=
 freeze protection
> > > > > > > > > > level, then we'd need to make sure we don't generate an=
other fanotify
> > > > > > > > > > permission event with such fd - autorejecting any such =
access is an obvious
> > > > > > > > > > solution but I'm not sure if practical for applications=
.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I had also considered marking the listener process with t=
he FSNOTIFY
> > > > > > > > > context and enforcing this context on fanotify_read().
> > > > > > > > > In a way, this is similar to the NOIO and NOFS process co=
ntext.
> > > > > > > > > It could be used to both act as a stronger form of FMODE_=
NONOTIFY
> > > > > > > > > and to activate the desired freeze protection behavior
> > > > > > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > > > > > >
> > > > > > > >
> > > > > > > > My feeling is that the best approach would be a PF_NOWAIT t=
ask flag:
> > > > > > > >
> > > > > > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > > > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > > > > > - PF_NOWAIT could be auto-set on the reader of a permission=
 event
> > > > > > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PAT=
H
> > > > > > > > - We could add user API to set this personality explicitly =
to any task
> > > > > > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > > > > > > >
> > > > > > > > Please let me know if you agree with this design and if so,
> > > > > > > > which of the methods to set PF_NOWAIT are a must for the fi=
rst version
> > > > > > > > in your opinion?
> > > > > > >
> > > > > > > Yeah, the PF flag could work. It can be set for the process(e=
s) responsible
> > > > > > > for processing the fanotify events and filling in filesystem =
contents. I
> > > > > > > don't think automatic setting of this flag is desirable thoug=
h as it has
> > > > > > > quite wide impact and some of the consequences could be surpr=
ising.  I
> > > > > > > rather think it should be a conscious decision when setting u=
p the process
> > > > > > > processing the events. So I think API to explicitly set / cle=
ar the flag
> > > > > > > would be the best. Also I think it would be better to capture=
 in the name
> > > > > > > that this is really about fs freezing. So maybe PF_NOWAIT_FRE=
EZE or
> > > > > > > something like that?
> > > > > > >
> > > > > >
> > > > > > Sure.
> > > > > >
> > > > > > > Also we were thinking about having an open(2) flag for this (=
instead of PF
> > > > > > > flag) in the past. That would allow finer granularity control=
 of the
> > > > > > > behavior but I guess you are worried that it would not cover =
all the needed
> > > > > > > operations?
> > > > > > >
> > > > > >
> > > > > > Yeh, it seems like an API that is going to be harder to write s=
afe HSM
> > > > > > programs with.
> > > > > >
> > > > > > > > Do you think we should use this method to fix the existing =
deadlocks
> > > > > > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > > > > > >
> > > > > > > No, I think if someone cares about these, they should explici=
tly set the
> > > > > > > PF flag in their task processing the events.
> > > > > > >
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > I see an exit hatch in this statement -
> > > > > > If we are going leave the responsibility to avoid deadlock in c=
orner
> > > > > > cases completely in the hands of the application, then I do not=
 feel
> > > > > > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > > > > > providing the first HSM API.
> > > > > >
> > > > > > If the HSM application is running in a controlled system, on a =
filesystem
> > > > > > where fsfreeze is not expected or not needed, then a fully func=
tional and
> > > > > > safe HSM does not require PF_NOWAIT_FREEZE API.
> > > > > >
> > > > > > Perhaps an API to make an fs unfreezable is just as practical a=
nd a much
> > > > > > easier option for the first version of HSM API?
> > > > > >
> > > > > > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > > > > > ioctl. Then no other task can freeze the fs, for as long as the=
 fd is open
> > > > > > apart from the HSM itself using this fd.
> > > > > >
> > > > > > HSM itself can avoid deadlocks if it collaborates the fs freeze=
s with
> > > > > > making fs modifications from within HSM events.
> > > > > >
> > > > > > Do you think that may be an acceptable way out or the corner?
> > > > >
> > > > > This is kind of a corner case that I think is acceptable to just =
leave up to
> > > > > application developers.  Speaking as a potential consumer of this=
 work we don't
> > > > > use fsfreeze so aren't concerned wit this in practice, and arguab=
ly if you're
> > > > > using this interface you know what you're doing.  As long as the =
sharp edge is
> > > > > well documented I think that's fine for v1.
> > > > >
> > > >
> > > > I agree that this is good enough for v1.
> > > > The only question is can we (and should we) do better than good eno=
ugh for v1.
> > > >
> > > > > Long term I like the EXCLUSIVE_FSFREEZER option, noting Christian=
's comment
> > > > > about the xfs scrubbing use case.  We all know that "freeze this =
file system" is
> > > > > an operation that is going to take X amount of time, so as long a=
s we provide
> > > > > the application a way to block fsfreeze to avoid the deadlock the=
n I think
> > > > > that's a reasonable solution.  Additionally it would allow us an =
avenue to
> > > > > gracefully handle errors.  If we race and see that the fs is alre=
ady frozen well
> > > > > then we can go back to the HSM with an error saying he's out of l=
uck, and he can
> > > > > return -EAGAIN or something through fanotify to unwind and try ag=
ain later.
> > > > >
> > > >
> > > > Actually, "fs is already frozen" is not a deadlock case.
> > > > If "fs is already frozen" then fsfreeze was successful and HSM shou=
ld just
> > > > wait in line like everyone else until fs is unfrozen.
> > > >
> > > > The deadlock case is "fs is being frozen" (i.e. sb->s_writers.froze=
n is
> > > > in state SB_FREEZE_WRITE), which cannot make progress because
> > > > an existing holder of sb write is blocked on an HSM event, which in=
 turn
> > > > is trying to start a new sb write.
> > >
> > > Right, and now I'm confused.  You have your patchset to re-order the =
permission
> > > checks to before the sb_start_write(), so an HSM watching FAN_OPEN_PE=
RM is no
> > > longer holding the sb write lock and thus can't deadlock, correct?
> >
> > Correct.
> >
> > >
> > > The new things you are proposing (FAN_PRE_ACESS and FAN_PRE_MODIFY) a=
lso do not
> > > happen inside of an sb_start_write(), correct?
> > >
> >
> > Almost correct.
> >
> > The callers of the security_file_permission() hook do not hold sb_start=
_write()
> > *directly*, but it can be held *indirectly* in splice(file_in_fs1, file=
_in_fs2).
> > That is the corner case I was trying to explain.
> >
> > When fs1 (splice source fs) is a loop mounted fs and the loop image fil=
e
> > is on fs2 (a.k.a the "host" fs), which also happens to be to splice des=
t fs,
> > splice grabs sb_start_write() on fs2.
> >
> > After the patches in vfs.rw, splice() no longer calls security_file_per=
mission()
> > directly on the file in the loop mounted fs1, but the reads from loopde=
v
> > translate to reads on the image file, which can call security_file_perm=
ission()
> > on the loop image file on the "host" fs (fs2), while sb_start_write() i=
s held.
> >
> > IOW, if HSM needs to fill the content on the loop image file and fsfree=
ze on
> > the "host" fs that is the destination of splice, gets in the middle, th=
ere is
> > a chance for a deadlock, because freeze will never make progress and
> > HSM filling of the loop image file is blocked.
> >
> > Yes, it is a corner case, but it exists and a similar one exists with a=
 splice
> > from an overlayfs file into a file on a "host" fs, which also happens t=
o be the
> > lower layer of overlayfs (I have a test case that triggered this).
> >
>
> I had to still draw this on my whiteboard to make sure I understood it pr=
operly,
> so I'm going to draw it here to make sure I did actually understand it, b=
ecause
> it is indeed quite complex if I'm understanding you correctly.
>
> We have the following
>
> File A on FS 1 which is a loopback device backed by File B on FS 2

B is the normal file on FS2, so I guess you meant to say backed by file C

> File B on FS 2 which is a normal file
>
> We have an HSM watching FS1 to populate files.
>
> sendfile(A, B);
>
> This does
>
> file_start_write(FS2);
>
> Then we start to read from A to populate the page, this triggers the HSM,=
 which
> then wants to write to FS1.
>
> At this point some other process calls fsfreeze(FS2), and now we're deadl=
ocked,
> because the HSM is stuck at sb_start_write(FS2) trying to write to the FS=
1 which
> is backed by FS2, but we're already holding file_start_write(FS2) because=
 of
> splice.
>
> Is this correct?

Yes, this is correct.
I was describing a different variant of deadlock when FS2 is watched by HSM
and HSM wants to write to the image file C upon reading from file A.

There are many variants of this, but the root cause is operating of file A
while holding sb_start_write() on file B on another fs.

>
> If it is, I think the best thing to do is actually push the file_start_wr=
ite()
> deeper into the splice work.  Do something like the patch I've applied be=
low,
> which is wildly untested and uncompiled.  However I think this closes thi=
s
> deadlock in a nice clean way, because we're reading and then writing, and=
 we
> don't have to worry about any shenanigans under the read path because we =
only
> hold the sb_write_start() when we do the actual write part.  Does that ma=
ke
> sense?

That makes a lot of sense!

I think this is the correct way out of the deadlock corner case.
I will amend the patch and test it.

Thanks for getting me out of tunnel vision ;)

Some comments for myself below...

>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 4382881b0709..f37bb41551fe 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, co=
nst struct path *old,
>         return ovl_real_fileattr_set(new, &newfa);
>  }
>
> +static int ovl_splice_actor(struct pipe_inode_info *pipe,
> +                           struct splice_desc *sd)
> +{
> +       struct file *file =3D sd->u.file;
> +       long ret;
> +
> +       ovl_start_write(file_dentry(file));
> +       ret =3D vfs_do_splice_from(pipe, file, sd->opos, sd->total_len,
> +                                sd->flags);
> +       ovl_end_write(file_dentry(file));
> +       return ret;
> +}
> +
>  static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
>                             struct file *new_file, loff_t len)
>  {
> @@ -309,6 +322,8 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struc=
t dentry *dentry,
>                         }
>                 }
>
> +               do_splice_direct(old_file, &old_pos, new_file, &new_pos,
> +                                this_len, SPLICE_F_MOVE, ovl_splice_acto=
r);
>                 ovl_start_write(dentry);
>                 bytes =3D do_splice_direct(old_file, &old_pos,
>                                          new_file, &new_pos,

Remove this..

> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4771701c896b..797ef9e2ecf5 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1250,10 +1250,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, =
loff_t *ppos,
>                 retval =3D rw_verify_area(WRITE, out.file, &out_pos, coun=
t);
>                 if (retval < 0)
>                         goto fput_out;
> -               file_start_write(out.file);
>                 retval =3D do_splice_direct(in.file, &pos, out.file, &out=
_pos,
>                                           count, fl);
> -               file_end_write(out.file);
>         } else {
>                 if (out.file->f_flags & O_NONBLOCK)
>                         fl |=3D SPLICE_F_NONBLOCK;
> diff --git a/fs/splice.c b/fs/splice.c
> index d983d375ff11..85a4ed0ad06c 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -925,13 +925,14 @@ static int warn_unsupported(struct file *file, cons=
t char *op)
>  /*
>   * Attempt to initiate a splice from pipe to file.
>   */
> -static long do_splice_from(struct pipe_inode_info *pipe, struct file *ou=
t,
> -                          loff_t *ppos, size_t len, unsigned int flags)
> +long vfs_do_splice_from(struct pipe_inode_info *pipe, struct file *out,
> +                       loff_t *ppos, size_t len, unsigned int flags)
>  {
>         if (unlikely(!out->f_op->splice_write))
>                 return warn_unsupported(out, "write");
>         return out->f_op->splice_write(pipe, out, ppos, len, flags);
>  }
> +EXPORT_SYMBOL(vfs_do_splice_from);

My cleanup was trying to distinguish between vfs_XXX helpers
that call permission hooks and take sb_write and do_XXX helpers
that do the rest.

It's true that exporting do_XXX helpers is not nice, but for me,
vfs_do_XXX is too much to endure ;)

If it were up to me, I would either export do_splice_from()
or open code it in overlayfs.

It might be worth making this an inline helper in fs.h
along with warn_unsupported().
I would suggest call_splice_write().
I know how people feel about call_{read,write}_iter(), but perhaps
together with warn_unsupported(), an inline helper is justified.

Anyway, unless there is consensus about call_splice_write(),
I am going to unify the two variants of warn_unsupported(), move
it to fs.h, and open code do_splice_from() in ovl_splice_actor().

Thanks,
Amir.

