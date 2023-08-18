Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3978060F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357988AbjHRHCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 03:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358111AbjHRHBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:01:55 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00AA2D72
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 00:01:52 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79dbd1fb749so402626241.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692342112; x=1692946912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+vpnvifbhzqyAubhOn5Qm26c8ecfGGvYWy9tqPEe84=;
        b=rfxPPSqMpwKSvNqvoJ651br8D9z7cU7DAQ5JBoY623Yf/SYlrSDi3XFATaQ+EdvfDL
         8dtiDvgE5KPDTz3qXd+hdtXWj5XYNf3CDWI+AQyHCfbcw1RaczS+l1DVWLviwEIqat/9
         YMBgzulqdw5tIUPpVLukmhT+KcipWtzcL5WIGx/rZBKjLuYEM0MlvdzkLimJN9H/oMtJ
         qJDunooBF8g973GULCQr4ui84dM9eih0XrUcUDKglrnlgRw/qMqh/G4JKSv5NpC75Ki0
         dm2Gbex/bJkTY0bb6NkpMLiGWByVFIit5kby4p8D2sDgCGcNH3hfv2XNo6XpXX+1fGlV
         o7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342112; x=1692946912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+vpnvifbhzqyAubhOn5Qm26c8ecfGGvYWy9tqPEe84=;
        b=i6X54tDnxuHkMpu/kYvQ7Nlz0WN/lAR8mNVWXq81r0f67ifDvLpPip158LIH2WxRko
         X/qAfl4aeQ2m5sQfMnd/v4F44AolcN4AjP7X4L+qHBG+IAM4XYXnWDpGG5rEiMRaIJs+
         7WgWCNhJ8HxfW736aYwOWC+EXWdaGKfYSVEVjB6XjJPRfLK3haEdAouwCzE3wDZtXhM4
         MIhiqtDCNsHSKArnwoF9A8tRyKGEAu/uRPsR+g68V65/Vila5Pja51si7m3LfjoYTAj5
         Vd0MH4+uQYxCFpOU38AIPPf6BFAUS1UIcUCsMFeMPvSS/DsDO4Jl/+leBsjKOhE5OxXF
         5r4g==
X-Gm-Message-State: AOJu0YwZIllKLh68Qfxj3Q86VgX+7xqmiZc0IMMo7NLEzLjKYYuoxVOn
        VjRn9zvNoRtLC8rwhW6F17P6glxDEFksPMzRuL3VSg9B4/A=
X-Google-Smtp-Source: AGHT+IEkb/bvH7EiGCgBPKphGyuNC+/YmSTYX8v7874X70vVpAEhXtf75SdriD7TCkNtc30XX5+x/Gc8OneyNN1eePI=
X-Received: by 2002:a05:6102:151a:b0:445:4a0c:3afb with SMTP id
 f26-20020a056102151a00b004454a0c3afbmr4933115vsv.8.1692342111655; Fri, 18 Aug
 2023 00:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230629133940.5w255qerlgqeqd7s@quack3> <CAOQ4uxgBMUjNvd3ZPJ1ZCzvhohB6yWe4E52XqEdfLQPHEHw-hA@mail.gmail.com>
 <20230629171157.54l44agwejgnquw3@quack3> <CAOQ4uxgxFtBZy4V8vccV2F7Lbg_9=OFNhgdgCP6Hu=o7gjcsVQ@mail.gmail.com>
 <20230703183029.nn5adeyphijv5wl6@quack3> <CAOQ4uxiS6R9hGFmputP6uRHGKywaCca0Ug53ihGcrgxkvMHomg@mail.gmail.com>
 <CAOQ4uxhk_rydFejNqsmn4AydZfuknp=vPunNODNcZ_8qW-AykQ@mail.gmail.com>
 <20230816094702.zztx3dctxvnfeh6o@quack3> <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com> <20230817182220.vzzklvr7ejqlfnju@quack3>
In-Reply-To: <20230817182220.vzzklvr7ejqlfnju@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Aug 2023 10:01:40 +0300
Message-ID: <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding fsdevel]

On Thu, Aug 17, 2023 at 9:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 17-08-23 10:13:20, Amir Goldstein wrote:
> > [CC Christian and Jens for the NOWAIT semantics]
> >
> > Jan,
> >
> > I was going to post start-write-safe patches [1], but now that this
> > design issue has emerged, with your permission, I would like to
> > take this discussion to fsdevel, so please reply to the list.
> >
> > For those who just joined, the context is fanotify HSM API [2]
> > proposal and avoiding the fanotify deadlocks I described in my
> > talk on LSFMM [3].
>
> OK, sure. I'm resending the reply which I sent only to you here.
>
> > On Wed, Aug 16, 2023 at 8:18=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > On Wed, Aug 16, 2023 at 12:47=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > On Mon 14-08-23 16:57:48, Amir Goldstein wrote:
> > > > > On Mon, Jul 3, 2023 at 11:03=E2=80=AFPM Amir Goldstein <amir73il@=
gmail.com> wrote:
> > > > > > On Mon, Jul 3, 2023, 9:30 PM Jan Kara <jack@suse.cz> wrote:
> > > > > do_sendfile() or ovl_copy_up() from ovl1 to xfs1, end up calling
> > > > > do_splice_direct() with sb_writers(xfs1) held.
> > > > > Internally, the splice operation calls into ovl_splice_read(), wh=
ich
> > > > > has to call the rw_verify_area() check with the fsnotify hook on =
the
> > > > > underlying xfs file.
> > > >
> > > > Right, we can call rw_verify_area() only after overlayfs has told u=
s what
> > > > is actually the underlying file that is really used for reading. Hu=
m,
> > > > nasty.
> > > >
> > > > > This is a violation of start-write-safe permission hooks and the
> > > > > lockdep_assert that I added in fsnotify_permission() catches this
> > > > > violation.
> > > > >
> > > > > I believe that a similar issue exists with do_splice_direct() fro=
m
> > > > > an fs that is loop mounted over an image file on xfs1 to xfs1.
> > > >
> > > > I don't see how that would be possible. If you have a loop image fi=
le on
> > > > filesystem xfs1, then the filesystem stored in the image is some xf=
s2.
> > > > Overlayfs case is special here because it doesn't really work with
> > > > filesystems but rather directory subtrees and that causes the
> > > > complications.
> > > >
> > >
> > > I was referring to sendfile() from xfs2 to xfs1.
> > > sb_writers of xfs1 is held, but loop needs to read from the image fil=
e
> > > in xfs1. No?
>
> Yes, that seems possible and it would indeed trigger rw_verify_area() in
> do_iter_read() on xfs1 while freeze protection for xfs1 is held.
>

Recap for new people joining this thread.

The following deadlock is possible in upstream kernel
if fanotify permission event handler tries to make
modifications to the filesystem it is watching in the context
of FAN_ACCESS_PERM handling in some cases:

P1                             P2                      P3
-----------                    ------------            ------------
do_sendfile(fs1.out_fd, fs1.in_fd)
-> sb_start_write(fs1.sb)
  -> do_splice_direct()                         freeze_super(fs1.sb)
    -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ..=
....
      -> security_file_permission()
        -> fsnotify_perm() --> FAN_ACCESS_PERM
                                 -> do_unlinkat(fs1.dfd, ...)
                                   -> sb_start_write(fs1.sb) ......

start-write-safe patches [1] (not posted) are trying to solve this
deadlock and prepare the ground for a new set of permission events
with cleaner/safer semantics.

The cases described above of sendfile from a file in loop mounted
image over fs1 or overlayfs over fs1 into a file in fs1 can still deadlock
despite the start-write-safe patches [1].

> > > > > My earlier patches had annotated the rw_verify_area() calls
> > > > > in splice iterators as "MAY_NOT_START_WRITE" and the
> > > > > userspace event listener was notified via flag whether modifying
> > > > > the content of the file was allowed or not.
> > > > >
> > > > > I do not care so much about HSM being able to fill content of fil=
es
> > > > > from a nested context like this, but we do need some way for
> > > > > userspace to at least deny this access to a file with no content.
> > > > >
> > > > > Another possibility I thought of is to change file_start_write()
> > > > > do use file_start_write_trylock() for files with FMODE_NONOTIFY.
> > > > > This should make it safe to fill file content when event is gener=
ated
> > > > > with sb_writers held (if freeze is in progress modification will =
fail).
> > > > > Right?
> > > >
> > > > OK, so you mean that the HSM managing application will get an fd wi=
th
> > > > FMODE_NONOTIFY set from an event and use it for filling in the file
> > > > contents and the kernel functions grabbing freeze protection will d=
etect
> > > > the file flag and bail with error instead of waiting? That sounds l=
ike an
> > > > attractive solution - the HSM managing app could even reply with er=
ror like
> > > > ERESTARTSYS to fanotify event and make the syscall restart (which w=
ill
> > > > block until the fs is unfrozen and then we can try again) and thus =
handle
> > > > the whole problem transparently for the application generating the =
event.
> > > > But I'm just dreaming now, for start it would be fine to just fail =
the
> > > > syscall.
> > > >
> > >
> > > IMO, a temporary error from an HSM controlled fs is not a big deal.
> > > Same as a temporary error from a network fs or FUSE - should be
> > > tolerable when the endpoint is not connected.
> > > One of my patches allows HSM returning an error that is not EPERM as
> > > response - this can be useful in such situations.
>
> OK.
>
> > > > I see only three possible problems with the solution. Firstly, the =
HSM
> > > > application will have to be careful to only access the managed file=
system
> > > > with the fd returned from fanotify event as otherwise it could dead=
lock on
> > > > frozen filesystem.
> > >
> > > Isn't that already the case to some extent?
> > > It is not wise for permission event handlers to perform operations
> > > on fd without  FMODE_NONOTIFY.
>
> Yes, it isn't a new problem. The amount of bug reports in our bugzilla
> boiling down to this kind of self-deadlock just shows that fanotify users
> get this wrong all the time.
>
> > > > That may seem obvious but practice shows that with
> > > > complex software stacks with many dependencies, this is far from tr=
ivial.
> > >
> > > It will be especially important when we have permission events
> > > on directory operations that need to perform operations on O_PATH
> > > dirfd with FMODE_NONOTIFY.
> > >
> > > > Secondly, conditioning the trylock behavior on FMODE_NONOTIFY seems
> > > > somewhat arbitary unless you understand our implementation issues a=
nd
> > > > possibly it could regress current unsuspecting users. So I'm thinki=
ng
> > > > whether we shouldn't rather have an explicit open flag requiring er=
roring
> > > > out on frozen filesystem instead of blocking and the HSM applicatio=
n will
> > > > need to use it to evade freezing deadlocks. Or we can just depend o=
n
> > > > RWF_NOWAIT flag (we currently block on frozen filesystem despite th=
is flag
> > > > but that can be viewed as a bug) but that's limited to writes (i.e.=
, no way
> > > > to e.g. do fallocate(2) without blocking on frozen fs).
> > >
> > > User cannot ask for fd with FMODE_NONOTIFY as it is - this is provide=
d
> > > as a means to an end by fanotify - so it would not be much different =
if
> > > the new events would provide an fd with FMODE_NONOTIFY |
> > > FMODE_NOWAIT. It will be up to documentation to say what is and what
> > > is not allowed with the event->fd provided by fanotify.
> > >
> >
> > This part needs clarifying.
> > Technically, we can use the flag FMODE_NOWAIT to prevent waiting in
> > file_start_write() *when* it is combined with FMODE_NONOTIFY.
> >
> > Yes, it would be a change of behavior, but I think it would be a good c=
hange,
> > because current event->fd from FAN_ACCESS_PERM events is really not
> > write-safe (could deadlock with freezing fs).
>
> As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> this fd. It says nothing about freeze handling or so. Furthermore as you
> observe FMODE_NONOTIFY cannot be set by userspace but practically all
> current fanotify users need to also do IO on other files in order to hand=
le
> fanotify event. So ideally we'd have a way to do IO to other files in a
> manner safe wrt freezing. We could just update handling of RWF_NOWAIT fla=
g
> to only trylock freeze protection - that actually makes a lot of sense to
> me. The question is whether this is enough or not.
>

Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
to a file is not the only thing that HSM needs to do.
Eventually, event handler for lookup permission events should be
able to also create files without blocking on vfs level freeze protection.

In theory, I am not saying we should do it, but as a thought experiment:
if the requirement from permission event handler is that is must use a
O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
any filesystem modifications, then instead of aiming for NOWAIT
semantics using sb_start_write_trylock(), we could use a freeze level
SB_FREEZE_FSNOTIFY between
SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.

As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
make it clear how userspace should avoid nesting "VFS faults" there is
a model that can solve the deadlock correctly.

> > Then we have two options:
> > 1. Generate "write-safe" FAN_PRE_ACCESS events only for fs that set
> >     FMODE_NOWAIT.
> >     Other fs will still generate the legacy FAN_ACCESS_PERM events
> >     which will be documented as write-unsafe
> > 2. Use a new internal flag (e.g. FMODE_NOSBWAIT) for the stronger
> >     NOWAIT semantics that fanotify will always set on event->fd for the
> >     new write-safe FAN_PRE_ACCESS events
> >
> > TBH, the backing fs for HSM [2] is anyway supposed to be a "normal"
> > local fs and I'd be more comfortable with fs opting in to support fanot=
ify
> > HSM events, so option #1 doesn't seem like a terrible idea??
>
> Yes, I don't think 1) would be really be a limitation that would matter t=
oo
> much in practice.
>
> > > Currently, the documentation is missing, because there are operations
> > > that are not really safe in the permission event context, but there i=
s no
> > > documentation about that.
> > >
> > > > Thirdly, unless we
> > > > propagate to the HSM app the information whether the freeze protect=
ion is
> > > > held in the kernel or not, it doesn't know whether it should just w=
ait for
> > > > the filesystem to unfreeze or whether it should rather fail the req=
uest to
> > > > avoid the deadlock. Hrm...
> > >
> > > informing HSM if freeze protection is held by this thread may be a li=
ttle
> > > challenging, but it is easy for me to annotate possible risky context=
s
> > > like the hooks inside splice read.
> > > I am just not sure that waiting in HSM context is that important and
> > > if it is not better to always fail in the frozen fs case.
>
> Always failing in frozen fs case is certainly possible but that will make
> fs freezing a bit non-transparent - the application may treat such failur=
es
> as fatal errors and abort. So it's ok for the first POC but eventually we
> should have a plan how we could make fs freezing transparent for the
> applications even for HSM managed filesystems.
>

OK. ATM, the only solution I can think of that is both maintainable
and lets HSM live in complete harmony with fsfreeze is adding the
extra SB_FREEZE_FSNOTIFY level.

I am not sure how big of an overhead that would be?
I imagine that sb_writers is large enough as it is w.r.t fitting into
cache lines?
I don't think that it adds much complexity or maintenance burden
to vfs?? I'm really not sure.

> > > I wonder if we go down this path, if we need any of the start-write-s=
afe
> > > patches at all? maybe only some of them to avoid duplicate hooks?
>
> Yes, avoiding duplicate hooks would be nice in any case.

OK. I already posted some patches from the series to vfs [4] and ovl [5].

The rest of the series can be justified also for avoiding duplicate
permission hook and also to greatly reduce the risk of the aforementioned
deadlock, despite the remaining loop/ovl corner cases.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/start-write-safe
[2] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Ma=
nagement-API
[3] https://youtu.be/z3A7mzfceKM
[4] https://lore.kernel.org/linux-fsdevel/20230817141337.1025891-1-amir73il=
@gmail.com/
[5] https://lore.kernel.org/linux-unionfs/20230816152334.924960-1-amir73il@=
gmail.com/
