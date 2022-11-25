Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB3638A87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKYMqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 07:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYMqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:46:09 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869281706B;
        Fri, 25 Nov 2022 04:46:05 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i11so3044101vsr.7;
        Fri, 25 Nov 2022 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wPivjPzzhpQmrJfAUAvoepLnVMQiqd/mK51ccxFBWCw=;
        b=mTsjbV8sGLd0GO1e9JF/mxRHJYTjOTxWHs4Kso7JEn4fNtLXFDJ5boG2O46pj1nJaL
         MYAdxikxubzRICJloEDJ/5QQAty+hEhefSIZeB4HmkYZhxZslwUdYaLUifNB+P1vjUrX
         mMU4RwRWTZ7qkNY4J+I7L4G94/2lCmEGYwsHMD6s3/rBUQp1qMlwxDe/2clVEWrNYqSw
         YCk7sex29d99CS/Ym1xl/FNiW+eHIEFQkAo2R5gw4ICKJYebKUJ4a+zrzuLBDqiRYRef
         Usr1tbE/6CjeGMu3CmZGCmJ1nUqP6Et0YWG+tD5TtgkROo5xP5VmiJf2u2kh+TLudVD+
         HW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPivjPzzhpQmrJfAUAvoepLnVMQiqd/mK51ccxFBWCw=;
        b=nqDwYgfAmrYbRLvL5wOYBGn25+VikpKj7I0AeQ288ef4dwPPkG8i/T9ZcJXoH2MIn3
         tIa00wq0JMIN7abFdf5P+GynhXJkNqmaAkiJx7946+U67sdlFMw1Zr76js5hd5AxuHOv
         hccQr50BEKLqiSgkWhnM+Je+iaNhChrGM3kxVSmU03rotqCYU064OF5GeD8L5kKUX4vG
         rVLvKkhaBWhVF/h2/90mMoGld5EgVpxxKFetV0c2sPFEhVSkpbhJ3eTRidPZhjKyGS14
         Bq0UjRccMoaRXcDW5GB6gR3sxzKO1UTcfhjgj4FZVWKODaEViRI+91byNmUylNyNLekp
         TrOQ==
X-Gm-Message-State: ANoB5pntVrxYqMBaAUZR0PTetr/QovyLSoxidsEDGrLpAq+EFLlfy2ux
        JXKlWR3QYcD6L+tNDjGJo9Dk9z5fJg5eVrBV3b3bt7YUiJw=
X-Google-Smtp-Source: AA0mqf6Jw6hvKKa/ikOTo7pWpu6epXVSirpNAhczeEA+O+gM2faT2KcJsxQewGdWp83ZAyk3oupTsB2Fp7nRKoaVN+8=
X-Received: by 2002:a05:6102:3bc1:b0:3a7:9b8c:2e4c with SMTP id
 a1-20020a0561023bc100b003a79b8c2e4cmr9720937vsv.72.1669380364526; Fri, 25 Nov
 2022 04:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123114645.3aowv3hw4hxqr2ed@quack3> <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
 <20221124095840.zdcwnge4hbxqcz5d@quack3> <20221124161147.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124174626.lueg3f65ikhp2f3l@quack3>
In-Reply-To: <20221124174626.lueg3f65ikhp2f3l@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 25 Nov 2022 14:45:53 +0200
Message-ID: <CAOQ4uxhL4Rmk1ria2_AEc0rJXPAaHLeuWQj9RKZqSv9TU_paTw@mail.gmail.com>
Subject: Re: SRCU use from different contexts
To:     "Paul E. McKenney" <paulmck@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 24, 2022 at 7:46 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 24-11-22 08:11:47, Paul E. McKenney wrote:
> > On Thu, Nov 24, 2022 at 10:58:40AM +0100, Jan Kara wrote:
> > > On Thu 24-11-22 08:21:13, Amir Goldstein wrote:
> > > > [+fsdevel]
> > > >
> > > > On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > > > > Hello!
> > > > > >
> > > > > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > > > > as a building block we would need a mechanism to make sure write(2) has
> > > > > > completed. For simplicity we could imagine it like a sequence
> > > > > >
> > > > > > write(2)
> > > > > >   START
> > > > > >   do stuff to perform write
> > > > > >   END
> > > > > >
> > > > > > and we need a mechanism to wait for all processes that already passed START
> > > > > > to reach END. Ideally without blocking new writes while we wait for the
> > > > > > pending ones. Now this seems like a good task for SRCU. We could do:
> > > > > >
> > > > > > write(2)
> > > > > >   srcu_read_lock(&sb->s_write_rcu);
> > > > > >   do stuff to perform write
> > > > > >   srcu_read_unlock(&sb->s_write_rcu);
> > > > > >
> > > > > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > > > > >
> > > > > > But the trouble with writes is there are things like aio or io_uring where
> > > > > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > > > > the part with srcu_read_unlock() happens from another context (usually worker
> > > > > > thread triggered by IRQ reporting that the HW has finished the IO).
> > > > > >
> > > > > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > > > > me in principle it should be possible to make this work but maybe there are
> > > > > > some implementation constraints I'm missing...
> > > > >
> > > > > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > > > > will work for this, though that is not their intended purpose.  Plus you
> > > > > might want to trace these functions, which, as their names indicate, is
> > > > > not permitted.  I assume that you do not intend to use these functions
> > > > > from NMI handlers, though that really could be accommodated.  (But why
> > > > > would you need that?)
> > > > >
> > > > > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > > > > (untested) patch below?
> > > > >
> > > > > Note that you do still need to pass the return value from srcu_down_read()
> > > > > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > > > > that this value can be placed.  No idea about aio.
> > > > >
> > > >
> > > > Sure, aio completion has context.
> > > >
> > > > > Thoughts?
> > > >
> > > > That looks great! Thank you.
> > > >
> > > > Followup question:
> > > > Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
> > > > thing:
> > > >
> > > > /*
> > > >  * Open-code file_start_write here to grab freeze protection,
> > > >  * which will be released by another thread in
> > > >  * aio_complete_rw().  Fool lockdep by telling it the lock got
> > > >  * released so that it doesn't complain about the held lock when
> > > >  * we return to userspace.
> > > >  */
> > > > if (S_ISREG(file_inode(file)->i_mode)) {
> > > >     sb_start_write(file_inode(file)->i_sb);
> > > >     __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > > > }
> > > >
> > > > And in write completion:
> > > >
> > > > /*
> > > >  * Tell lockdep we inherited freeze protection from submission
> > > >  * thread.
> > > >  */
> > > > if (S_ISREG(inode->i_mode))
> > > >     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> > > > file_end_write(kiocb->ki_filp);
> > > >
> > > > I suppose we also need to "fool lockdep" w.r.t returning to userspace
> > > > with an acquired srcu?
> > >
> > > So AFAICT the whole point of Paul's new helpers is to not use lockdep and
> > > thus not have to play the "fool lockdep" games.
> >
> > Exactly!  ;-)
> >
> > But if you do return to userspace after invoking srcu_down_read(), it
> > is your responsibility to make sure that -something- eventually invokes
> > srcu_up_read().  Which might or might not be able to rely on userspace
> > doing something sensible.
> >
> > I would guess that you have a timeout or rely on close() for that purpose,
> > just as you presumably do for sb_start_write(), but figured I should
> > mention it.
>
> Yes. We actually do not rely on userspace but rather on HW to eventually
> signal IO completion. For misbehaving HW there are timeouts but the details
> depend very much on the protocol etc.. But as you say it is the same
> business as with sb_start_write() so nothing new here.
>

FYI, here is my POC branch that uses srcu_down,up_read()
for aio writes:

https://github.com/amir73il/linux/commits/sb_write_barrier

Note that NOT all writes take s_write_srcu, but all writes that
generate fsnotify pre-modify events without sb_start_write() held
MUST take s_write_srcu, so there is an assertion in fsnotify():

if (mask & FS_PRE_VFS) {
    /* Avoid false positives with LOCK_STATE_UNKNOWN */
    lockdep_assert_once(sb_write_started(sb) != LOCK_STATE_HELD);
    if (mask & FSNOTIFY_PRE_MODIFY_EVENTS)
        lockdep_assert_once(sb_write_srcu_started(sb));
}

For testing, I've added synchronize_srcu(&sb->s_write_srcu) at
the beginning of syncfs() and freeze_super().

Even though syncfs() is not the intended UAPI, it is a UAPI that could
make sense in the future (think SYNC_FILE_RANGE_WAIT_BEFORE
for the vfs level).

I've run the fstests groups aio and freeze that exercises these code
paths on xfs and on overlayfs and (after fixing all my bugs) I have not
observed any regressions nor any lockdep splats.

So you may add:
Tested-by: Amir Goldstein <amir73il@gmail.com>

Thanks again for the patch Paul!
Amir.
