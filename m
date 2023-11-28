Return-Path: <linux-fsdevel+bounces-4097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD18B7FC9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C68282D89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E775024C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pa8+4/83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E9A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 13:43:00 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5cce5075bd6so2368937b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 13:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701207780; x=1701812580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HnUiSVOkIal29Y9hmd0Dymn8Btz3VM8pJRLanFIOzMs=;
        b=pa8+4/83bu8He19QZ5BF/hFYclci99eHvd7rq2kQWtnbq61gBZ1i5gaFCot5VPeW6B
         ww2h/zYbk2XdPPkgIU6sS91Y7yY+sOe987HLr+eZmE0Gcr7x38siYH2AvXJof4xEJuF5
         S1YESx8dHFvuGPCoGrkzw/9DQ688tRKS5mQiTr2swXSuCkS9TLX5ti0Re8hjriTzY2p4
         khHk9jLgAGPBqICtaPSW44Id/S+1fKfLXmAGxMr52zsWJ9r/2hB1V0JuAGH+xJaRrmwG
         ugMMwA4Nyl+TEcJQ5ofDjf3RS2k0nVMPuv2lox+vScvQ3ZV+tGAuAA3kRSPo63e9Xs1D
         tvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207780; x=1701812580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnUiSVOkIal29Y9hmd0Dymn8Btz3VM8pJRLanFIOzMs=;
        b=eJq2jz1WFxjok1gpxGOR8yMDZ+Tdrq0ZlABcQFeqOAyO+S9/Iwr5dm3W6WPhO07xaH
         TCuweyImk1PqSVlrNqiXO70DdBXvDV7icwYAKVBOu+eoO/QfKjUWteFQYOa94kunyyva
         GAcj/EA7L2HexrIo08qAkLmgu9qMuppxWbtYggSoP/tEsFxXJC1NSvTn/stM/sLDLxBF
         9Ke+sUXdcDcrNko+X/FRpbMOyERylQ78CqiRNn45roaFrV0tKlYZvxmJ3Wg9MPOtgMVB
         y3hAAhsTOgi4X8Cv/YEHe32+J1NojT5ZrfJvKat7MDPNu51Oc0uZIFrkjuNtpf9y1lx+
         M3nA==
X-Gm-Message-State: AOJu0YxlwpYortzPFT7eK2rAlQizIYxfdcAdPBqGkKGVdkyLTGfW6cp/
	duESMHKkXIh8j5dNS+ZLPfZTOlxbMvyiFafI1dRWrzSr
X-Google-Smtp-Source: AGHT+IHsNk6oqC68YU6f8eG1hdSM9UeboOCp7+MGqILQ6JjA7nQ3IWKPq28T0K8ZZnWNgTaZ4IGfGg==
X-Received: by 2002:a81:8842:0:b0:5cc:69df:7cf with SMTP id y63-20020a818842000000b005cc69df07cfmr14134392ywf.14.1701207779810;
        Tue, 28 Nov 2023 13:42:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g6-20020a81ae46000000b00597e912e67esm3718971ywk.131.2023.11.28.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:42:59 -0800 (PST)
Date: Tue, 28 Nov 2023 16:42:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify HSM open issues
Message-ID: <20231128214258.GA2398475@perftesting>
References: <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3>
 <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3>
 <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
 <20231127191153.GH2366036@perftesting>
 <CAOQ4uxjLZZavhkKaWFa8T7+bCR+N2VRVsv4VusXvN5UMJjBiRA@mail.gmail.com>
 <20231128145547.GA2382537@perftesting>
 <CAOQ4uxhjEb-wXjoZDSHoH+bwebQzSSAVnPicEB8y6sJsDHLohQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhjEb-wXjoZDSHoH+bwebQzSSAVnPicEB8y6sJsDHLohQ@mail.gmail.com>

On Tue, Nov 28, 2023 at 06:52:00PM +0200, Amir Goldstein wrote:
> On Tue, Nov 28, 2023 at 4:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 01:05:50PM +0200, Amir Goldstein wrote:
> > > On Mon, Nov 27, 2023 at 9:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > > > > On Mon, Nov 20, 2023 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > Hi Amir,
> > > > > >
> > > > > > sorry for a bit delayed reply, I did not get to "swapping in" HSM
> > > > > > discussion during the Plumbers conference :)
> > > > > >
> > > > > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > > > > On Wed, Aug 23, 2023 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > > On Wed, Aug 23, 2023 at 5:37 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > > > Recap for new people joining this thread.
> > > > > > > > > >
> > > > > > > > > > The following deadlock is possible in upstream kernel
> > > > > > > > > > if fanotify permission event handler tries to make
> > > > > > > > > > modifications to the filesystem it is watching in the context
> > > > > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > > > > >
> > > > > > > > > > P1                             P2                      P3
> > > > > > > > > > -----------                    ------------            ------------
> > > > > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > > > > -> sb_start_write(fs1.sb)
> > > > > > > > > >   -> do_splice_direct()                         freeze_super(fs1.sb)
> > > > > > > > > >     -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ......
> > > > > > > > > >       -> security_file_permission()
> > > > > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > > > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > > > > > > > >                                    -> sb_start_write(fs1.sb) ......
> > > > > > > > > >
> > > > > > > > > > start-write-safe patches [1] (not posted) are trying to solve this
> > > > > > > > > > deadlock and prepare the ground for a new set of permission events
> > > > > > > > > > with cleaner/safer semantics.
> > > > > > > > > >
> > > > > > > > > > The cases described above of sendfile from a file in loop mounted
> > > > > > > > > > image over fs1 or overlayfs over fs1 into a file in fs1 can still
> > > > > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > > > > >
> > > > > > > > > Yep, nice summary.
> > > > > > ...
> > > > > > > > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> > > > > > > > > > > this fd. It says nothing about freeze handling or so. Furthermore as you
> > > > > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace but practically all
> > > > > > > > > > > current fanotify users need to also do IO on other files in order to handle
> > > > > > > > > > > fanotify event. So ideally we'd have a way to do IO to other files in a
> > > > > > > > > > > manner safe wrt freezing. We could just update handling of RWF_NOWAIT flag
> > > > > > > > > > > to only trylock freeze protection - that actually makes a lot of sense to
> > > > > > > > > > > me. The question is whether this is enough or not.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > > > > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > > > > > Eventually, event handler for lookup permission events should be
> > > > > > > > > > able to also create files without blocking on vfs level freeze protection.
> > > > > > > > >
> > > > > > > > > So this is what I wanted to clarify. The lookup permission event never gets
> > > > > > > > > called under a freeze protection so the deadlock doesn't exist there. In
> > > > > > > > > principle the problem exists only for access and modify events where we'd
> > > > > > > > > be filling in file data and thus RWF_NOWAIT could be enough.
> > > > > > > >
> > > > > > > > Yes, you are right.
> > > > > > > > It is possible that RWF_NOWAIT could be enough.
> > > > > > > >
> > > > > > > > But the discovery of the loop/ovl corner cases has shaken my
> > > > > > > > confidence is the ability to guarantee that freeze protection is not
> > > > > > > > held somehow indirectly.
> > > > > > > >
> > > > > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > > > > > > same ovl corner case, because with splice from ovl1 to fs1,
> > > > > > > > fs1 freeze protection is held and:
> > > > > > > >   ovl_splice_read(ovl1.file)
> > > > > > > >     ovl_real_fdget()
> > > > > > > >       ovl_open_realfile(fs1.file)
> > > > > > > >          ... security_file_open(fs1.file)
> > > > > > > >
> > > > > > > > > That being
> > > > > > > > > said I understand this may be assuming too much about the implementations
> > > > > > > > > of HSM daemons and as you write, we might want to provide a way to do IO
> > > > > > > > > not blocking on freeze protection from any hook. But I wanted to point this
> > > > > > > > > out explicitly so that it's a conscious decision.
> > > > > > > > >
> > > > > > >
> > > > > > > I agree and I'd like to explain using an example, why RWF_NOWAIT is
> > > > > > > not enough for HSM needs.
> > > > > > >
> > > > > > > The reason is that often, when HSM needs to handle filling content
> > > > > > > in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
> > > > > > > HSM needs to be able to avoid blocking on freeze protection
> > > > > > > for any operations on the filesystem, not just pwrite().
> > > > > > >
> > > > > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > > > > from the lookup event and uses it in the handling of access events to
> > > > > > > update the metadata files that store which parts of the file were already
> > > > > > > filled (relying of fiemap is not always a valid option).
> > > > > > >
> > > > > > > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > > > > > > is propagated from dirfd to an fd opened with openat(dirfd, ...), so
> > > > > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> > > > > > >
> > > > > > > Another use case is that HSM may want to download content to a
> > > > > > > temp file on the same filesystem, verify the downloaded content and
> > > > > > > then clone the data into the accessed file range.
> > > > > > >
> > > > > > > I think that a PF_ flag (see below) would work best for all those cases.
> > > > > >
> > > > > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not be
> > > > > > enough for all sensible usecases to avoid deadlocks with freezing. However
> > > > > > note that if we want to really properly handle all possible operations, we
> > > > > > need to start handling error from all sb_start_write() and
> > > > > > file_start_write() calls and there are quite a few of those.
> > > > > >
> > > > >
> > > > > Darn, forgot about those.
> > > > > I am starting to reconsider adding a freeze level.
> > > > > I cannot shake the feeling that there is a simpler solution that escapes us...
> > > > > Maybe fs anti-freeze (see blow).
> > > > >
> > > > > > > > > > In theory, I am not saying we should do it, but as a thought experiment:
> > > > > > > > > > if the requirement from permission event handler is that is must use a
> > > > > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > > > > > > > > any filesystem modifications, then instead of aiming for NOWAIT
> > > > > > > > > > semantics using sb_start_write_trylock(), we could use a freeze level
> > > > > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > > > > >
> > > > > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> > > > > > > > > > make it clear how userspace should avoid nesting "VFS faults" there is
> > > > > > > > > > a model that can solve the deadlock correctly.
> > > > > > > > >
> > > > > > > > > OK, yes, in principle another freeze level which could be used by handlers
> > > > > > > > > of fanotify permission events would solve the deadlock as well. Just you
> > > > > > > > > seem to like to tie this functionality to the particular fd returned from
> > > > > > > > > fanotify and I'm not convinced that is a good idea. What if the application
> > > > > > > > > needs to do write to some other location besides the one fd it got passed
> > > > > > > > > from fanotify event? E.g. imagine it wants to fetch a whole subtree on
> > > > > > > > > first access to any file in a subtree. Or maybe it wants to write to some
> > > > > > > > > DB file containing current state or something like that.
> > > > > > > > >
> > > > > > > > > One solution I can imagine is to create an open flag that can be specified
> > > > > > > > > on open which would result in the special behavior wrt fs freezing. If the
> > > > > > > > > special behavior would be just trylocking the freeze protection then it
> > > > > > > > > would be really easy. If the behaviour would be another freeze protection
> > > > > > > > > level, then we'd need to make sure we don't generate another fanotify
> > > > > > > > > permission event with such fd - autorejecting any such access is an obvious
> > > > > > > > > solution but I'm not sure if practical for applications.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I had also considered marking the listener process with the FSNOTIFY
> > > > > > > > context and enforcing this context on fanotify_read().
> > > > > > > > In a way, this is similar to the NOIO and NOFS process context.
> > > > > > > > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > > > > > > > and to activate the desired freeze protection behavior
> > > > > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > > > > >
> > > > > > >
> > > > > > > My feeling is that the best approach would be a PF_NOWAIT task flag:
> > > > > > >
> > > > > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > > > > - PF_NOWAIT could be auto-set on the reader of a permission event
> > > > > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > > > > > > - We could add user API to set this personality explicitly to any task
> > > > > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > > > > > >
> > > > > > > Please let me know if you agree with this design and if so,
> > > > > > > which of the methods to set PF_NOWAIT are a must for the first version
> > > > > > > in your opinion?
> > > > > >
> > > > > > Yeah, the PF flag could work. It can be set for the process(es) responsible
> > > > > > for processing the fanotify events and filling in filesystem contents. I
> > > > > > don't think automatic setting of this flag is desirable though as it has
> > > > > > quite wide impact and some of the consequences could be surprising.  I
> > > > > > rather think it should be a conscious decision when setting up the process
> > > > > > processing the events. So I think API to explicitly set / clear the flag
> > > > > > would be the best. Also I think it would be better to capture in the name
> > > > > > that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
> > > > > > something like that?
> > > > > >
> > > > >
> > > > > Sure.
> > > > >
> > > > > > Also we were thinking about having an open(2) flag for this (instead of PF
> > > > > > flag) in the past. That would allow finer granularity control of the
> > > > > > behavior but I guess you are worried that it would not cover all the needed
> > > > > > operations?
> > > > > >
> > > > >
> > > > > Yeh, it seems like an API that is going to be harder to write safe HSM
> > > > > programs with.
> > > > >
> > > > > > > Do you think we should use this method to fix the existing deadlocks
> > > > > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > > > > >
> > > > > > No, I think if someone cares about these, they should explicitly set the
> > > > > > PF flag in their task processing the events.
> > > > > >
> > > > >
> > > > > OK.
> > > > >
> > > > > I see an exit hatch in this statement -
> > > > > If we are going leave the responsibility to avoid deadlock in corner
> > > > > cases completely in the hands of the application, then I do not feel
> > > > > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > > > > providing the first HSM API.
> > > > >
> > > > > If the HSM application is running in a controlled system, on a filesystem
> > > > > where fsfreeze is not expected or not needed, then a fully functional and
> > > > > safe HSM does not require PF_NOWAIT_FREEZE API.
> > > > >
> > > > > Perhaps an API to make an fs unfreezable is just as practical and a much
> > > > > easier option for the first version of HSM API?
> > > > >
> > > > > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > > > > ioctl. Then no other task can freeze the fs, for as long as the fd is open
> > > > > apart from the HSM itself using this fd.
> > > > >
> > > > > HSM itself can avoid deadlocks if it collaborates the fs freezes with
> > > > > making fs modifications from within HSM events.
> > > > >
> > > > > Do you think that may be an acceptable way out or the corner?
> > > >
> > > > This is kind of a corner case that I think is acceptable to just leave up to
> > > > application developers.  Speaking as a potential consumer of this work we don't
> > > > use fsfreeze so aren't concerned wit this in practice, and arguably if you're
> > > > using this interface you know what you're doing.  As long as the sharp edge is
> > > > well documented I think that's fine for v1.
> > > >
> > >
> > > I agree that this is good enough for v1.
> > > The only question is can we (and should we) do better than good enough for v1.
> > >
> > > > Long term I like the EXCLUSIVE_FSFREEZER option, noting Christian's comment
> > > > about the xfs scrubbing use case.  We all know that "freeze this file system" is
> > > > an operation that is going to take X amount of time, so as long as we provide
> > > > the application a way to block fsfreeze to avoid the deadlock then I think
> > > > that's a reasonable solution.  Additionally it would allow us an avenue to
> > > > gracefully handle errors.  If we race and see that the fs is already frozen well
> > > > then we can go back to the HSM with an error saying he's out of luck, and he can
> > > > return -EAGAIN or something through fanotify to unwind and try again later.
> > > >
> > >
> > > Actually, "fs is already frozen" is not a deadlock case.
> > > If "fs is already frozen" then fsfreeze was successful and HSM should just
> > > wait in line like everyone else until fs is unfrozen.
> > >
> > > The deadlock case is "fs is being frozen" (i.e. sb->s_writers.frozen is
> > > in state SB_FREEZE_WRITE), which cannot make progress because
> > > an existing holder of sb write is blocked on an HSM event, which in turn
> > > is trying to start a new sb write.
> >
> > Right, and now I'm confused.  You have your patchset to re-order the permission
> > checks to before the sb_start_write(), so an HSM watching FAN_OPEN_PERM is no
> > longer holding the sb write lock and thus can't deadlock, correct?
> 
> Correct.
> 
> >
> > The new things you are proposing (FAN_PRE_ACESS and FAN_PRE_MODIFY) also do not
> > happen inside of an sb_start_write(), correct?
> >
> 
> Almost correct.
> 
> The callers of the security_file_permission() hook do not hold sb_start_write()
> *directly*, but it can be held *indirectly* in splice(file_in_fs1, file_in_fs2).
> That is the corner case I was trying to explain.
> 
> When fs1 (splice source fs) is a loop mounted fs and the loop image file
> is on fs2 (a.k.a the "host" fs), which also happens to be to splice dest fs,
> splice grabs sb_start_write() on fs2.
> 
> After the patches in vfs.rw, splice() no longer calls security_file_permission()
> directly on the file in the loop mounted fs1, but the reads from loopdev
> translate to reads on the image file, which can call security_file_permission()
> on the loop image file on the "host" fs (fs2), while sb_start_write() is held.
> 
> IOW, if HSM needs to fill the content on the loop image file and fsfreeze on
> the "host" fs that is the destination of splice, gets in the middle, there is
> a chance for a deadlock, because freeze will never make progress and
> HSM filling of the loop image file is blocked.
> 
> Yes, it is a corner case, but it exists and a similar one exists with a splice
> from an overlayfs file into a file on a "host" fs, which also happens to be the
> lower layer of overlayfs (I have a test case that triggered this).
> 

I had to still draw this on my whiteboard to make sure I understood it properly,
so I'm going to draw it here to make sure I did actually understand it, because
it is indeed quite complex if I'm understanding you correctly.

We have the following

File A on FS 1 which is a loopback device backed by File B on FS 2
File B on FS 2 which is a normal file

We have an HSM watching FS1 to populate files.

sendfile(A, B);

This does

file_start_write(FS2);

Then we start to read from A to populate the page, this triggers the HSM, which
then wants to write to FS1.

At this point some other process calls fsfreeze(FS2), and now we're deadlocked,
because the HSM is stuck at sb_start_write(FS2) trying to write to the FS1 which
is backed by FS2, but we're already holding file_start_write(FS2) because of
splice.

Is this correct?

If it is, I think the best thing to do is actually push the file_start_write()
deeper into the splice work.  Do something like the patch I've applied below,
which is wildly untested and uncompiled.  However I think this closes this
deadlock in a nice clean way, because we're reading and then writing, and we
don't have to worry about any shenanigans under the read path because we only
hold the sb_write_start() when we do the actual write part.  Does that make
sense?  Thanks,

Josef

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..f37bb41551fe 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 	return ovl_real_fileattr_set(new, &newfa);
 }
 
+static int ovl_splice_actor(struct pipe_inode_info *pipe,
+			    struct splice_desc *sd)
+{
+	struct file *file = sd->u.file;
+	long ret;
+
+	ovl_start_write(file_dentry(file));
+	ret = vfs_do_splice_from(pipe, file, sd->opos, sd->total_len,
+				 sd->flags);
+	ovl_end_write(file_dentry(file));
+	return ret;
+}
+
 static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			    struct file *new_file, loff_t len)
 {
@@ -309,6 +322,8 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			}
 		}
 
+		do_splice_direct(old_file, &old_pos, new_file, &new_pos,
+				 this_len, SPLICE_F_MOVE, ovl_splice_actor);
 		ovl_start_write(dentry);
 		bytes = do_splice_direct(old_file, &old_pos,
 					 new_file, &new_pos,
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..797ef9e2ecf5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1250,10 +1250,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
 		if (retval < 0)
 			goto fput_out;
-		file_start_write(out.file);
 		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
 					  count, fl);
-		file_end_write(out.file);
 	} else {
 		if (out.file->f_flags & O_NONBLOCK)
 			fl |= SPLICE_F_NONBLOCK;
diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..85a4ed0ad06c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -925,13 +925,14 @@ static int warn_unsupported(struct file *file, const char *op)
 /*
  * Attempt to initiate a splice from pipe to file.
  */
-static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
-			   loff_t *ppos, size_t len, unsigned int flags)
+long vfs_do_splice_from(struct pipe_inode_info *pipe, struct file *out,
+			loff_t *ppos, size_t len, unsigned int flags)
 {
 	if (unlikely(!out->f_op->splice_write))
 		return warn_unsupported(out, "write");
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
+EXPORT_SYMBOL(vfs_do_splice_from);
 
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
@@ -1138,9 +1139,13 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 			       struct splice_desc *sd)
 {
 	struct file *file = sd->u.file;
+	long ret;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len,
-			      sd->flags);
+	file_start_write(file);
+	ret = vfs_do_splice_from(pipe, file, sd->opos, sd->total_len,
+				 sd->flags);
+	file_end_write(file);
+	return ret;
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
@@ -1152,13 +1157,14 @@ static void direct_file_splice_eof(struct splice_desc *sd)
 }
 
 /**
- * do_splice_direct - splices data directly between two files
+ * do_splice_direct_actor - splices data directly between two files
  * @in:		file to splice from
  * @ppos:	input file offset
  * @out:	file to splice to
  * @opos:	output file offset
  * @len:	number of bytes to splice
  * @flags:	splice modifier flags
+ * @actor:	the actor to use for the splice
  *
  * Description:
  *    For use by do_sendfile(). splice can easily emulate sendfile, but
@@ -1167,8 +1173,9 @@ static void direct_file_splice_eof(struct splice_desc *sd)
  *    can splice directly through a process-private pipe.
  *
  */
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags)
+long do_splice_direct_actor(struct file *in, loff_t *ppos, struct file *out,
+			    loff_t *opos, size_t len, unsigned int flags,
+			    splice_direct_actor *actor)
 {
 	struct splice_desc sd = {
 		.len		= len,
@@ -1191,12 +1198,36 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 	if (unlikely(ret < 0))
 		return ret;
 
-	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
+	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
 	return ret;
 }
+EXPORT_SYMBOL(do_splice_direct_actor);
+
+/**
+ * do_splice_direct - splices data directly between two files
+ * @in:		file to splice from
+ * @ppos:	input file offset
+ * @out:	file to splice to
+ * @opos:	output file offset
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    For use by do_sendfile(). splice can easily emulate sendfile, but
+ *    doing it in the application would incur an extra system call
+ *    (splice in + splice out, as compared to just sendfile()). So this helper
+ *    can splice directly through a process-private pipe.
+ *
+ */
+long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+		      loff_t *opos, size_t len, unsigned int flags)
+{
+	return do_splice_direct_actor(in, ppos, out, opos, len, flags,
+				      direct_splice_actor);
+}
 EXPORT_SYMBOL(do_splice_direct);
 
 static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
@@ -1289,7 +1320,7 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			flags |= SPLICE_F_NONBLOCK;
 
 		file_start_write(out);
-		ret = do_splice_from(ipipe, out, &offset, len, flags);
+		ret = vfs_do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
 		if (!off_out)
@@ -1323,7 +1354,7 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 	if (ret > 0) {
 		/*
 		 * Generate modify out before access in:
-		 * do_splice_from() may've already sent modify out,
+		 * vfs_do_splice_from() may've already sent modify out,
 		 * and this ensures the events get merged.
 		 */
 		fsnotify_modify(out);
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 6c461573434d..8583b31135fa 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -85,11 +85,16 @@ extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 extern long do_splice(struct file *in, loff_t *off_in,
 		      struct file *out, loff_t *off_out,
 		      size_t len, unsigned int flags);
+long do_splice_direct_actor(struct file *in, loff_t *ppos, struct file *out,
+			    loff_t *opos, size_t len, unsigned int flags,
+			    splice_direct_actor *actor);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
 extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags);
+extern long vfs_do_splice_from(struct pipe_inode_info *pipe, struct file *out,
+			       loff_t *ppos, size_t len, unsigned int flags);
 
 /*
  * for dynamic pipe sizing

