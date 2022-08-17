Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0EB596A56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiHQHZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 03:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiHQHZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:25:44 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141476BCD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 00:25:43 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id cd25so4866388uab.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wMo5ThSWX4nrkeGLZHvXNCCrrkUrzA7pO4ev7AJ5ntw=;
        b=SJcqxU5wCywK9jX4+U5PQaxnR8/cj+dG02Z3G01RUdLMVGf0Q2cuWjXw4lA83D60GY
         rFFmvASvGdGVFsCXPnmVLM549+wrWIHsfem51lxB/cfQnjKSSzO09Wloe8jRwKqiEY8Y
         voKQKtn1yZYE7RW2XeaDadrHmUz7bcMi3Ujktl6Nm2h01hGcUibMOBJQEz8tiZSOhLrU
         KWXCwP7zdXMsNI/oWTcUb7LvN3gM2KkI/CgoKgkFBNbI1sXOm3Dnb27ehkyEnXMF88cu
         TmP/j2tsoiXeIRMr1qH1UmFuihe5F3FdDy1waEwdTTGpmHL/SF6xpX04vSP5c0kTh1MO
         MCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wMo5ThSWX4nrkeGLZHvXNCCrrkUrzA7pO4ev7AJ5ntw=;
        b=UEQhRAp9AlwPBPYyYx1Okh9HMQKXsplOZZaltgl+xtOS/5GZr0t1hBpJoeKjtlS9Ea
         fhExfUPZybRKs00ZaQBfoWJ5dqTA+/ERysCbHXBfUnaYWBc09RDcHiv/pHo3Q0/lySyW
         oqzWaiaVbq9T3jBrYB5cYzfTtu0bsCEDJQTYtIvxBfJcaBwm2tp/zEMeOMHaIRBUCor9
         /lTekHj5FfR1yGvfOfWRgSBqSTgXNBtL4yPqsGciUyxfij3MMSP34YXRbI775/uuFahQ
         FMWjFw6OP4ZgDedPQ16pIlrSuKFhMsnjgP5XnsvZntO5yn9DBW29ixryfC7QdFgJWwOR
         /I/g==
X-Gm-Message-State: ACgBeo3WIiOyUL6ehgL7b2zMRqZ96qOYkg3YiyrC7WWSfjIxejmNZisv
        x8b7OOuBSlhuE2HsjvMCmuu8JaLRGIw4BP48DjQ=
X-Google-Smtp-Source: AA6agR4uKGpRKFyNkqsXsJaPMXbHMA/CZVH2p7ijaqt28c/f+QmxFmIw5vBIkwnaZ3HzVbbMAN5w0utYGbAY65ch5Dc=
X-Received: by 2002:a9f:2067:0:b0:387:984d:4a8e with SMTP id
 94-20020a9f2067000000b00387984d4a8emr10257663uam.60.1660721142120; Wed, 17
 Aug 2022 00:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
 <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com>
In-Reply-To: <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Aug 2022 10:25:30 +0300
Message-ID: <CAOQ4uxhoAAjKOe4w+z2_NCO9PF5KD=6oKuqQQ8xcMUe=buh89A@mail.gmail.com>
Subject: Re: Switching to iterate_shared
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 2:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 16, 2022 at 1:14 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >
> > So good to know in advance a change like this is coming. I'll have to
> > educate myself on this shared vs non-shared filldir.
>
> Well, that change isn't necessarily "coming" - we've had this horrid
> duality for years. "iterate_shared" goes back to 2016, and has been
> marked "recommended" since then.
>
> But the plain old "iterate" does continue to work, and having both is
> only an ugly wart - I can't honestly claim that it's a big and
> pressing problem.
>

All the "complexity" is really very tidy and neat inside iterate_dir()
I honestly don't see what the big fuss is about.

If filesystems do need to synchronize creates/deletes with readdir
they would need to add a new internal lock and take it for every
dir operation - it seems like a big hustle for little good reason.

Perhaps it would have been more elegant to replace the
iterate_shared/iterate duality with an fs_type flag.
And it would be very simple to make that change.

> But it would be *really* nice if filesystems did switch to it. For
> most filesystems, it is probably trivial. The only real difference is
> that the "iterate_shared" directory walker is called with the
> directory inode->i_rwsem held for reading, rather than for writing.
>
> End result: there can be multiple concurrent "readdir" iterators
> running on the same directory at the same time. But there's still
> exclusion wrt things like file creation, so a filesystem doesn't have
> to worry about that.
>
> Also, the concurrency is only between different 'struct file'
> entities. The file position lock still serializes all getdents() calls
> on any individual open directory 'struct file'.
>

Hmm, I wonder. Can gentents() proceed without f_pos_lock on
single f_count and then a cloned fd created and another gentents()
races with the first one?

A very niche corner case, but perhaps we can close this hole
for filesystems that opt-in with fs_type flag, because... (see below)

> End result: most filesystems probably can move to the 'iterate_shared'
> version with no real issues.
>
> Looking at coda in particular, I don't see any reason to not just
> switch over to 'iterate_shared' with no code modifications at all.
> Nothing in there seems to have any "I rely on the directory inode
> being exclusively locked".
>
> In fact, for coda in particular, it would be really nice if we could
> just get rid of the old "iterate" function for the host filesystem
> entirely. Which honestly I'd expect you could _also_ do, because
> almost all serious local filesystems have long since been converted.
>
> So coda looks like it could trivially move over. But I might be
> missing something.
>
> I suspect the same is true of most other filesystems, but it requires
> people go check and go think about it.
>

I tried to look at ovl_iterate(). The subtlety is regarding the internal
readdir cache.

Compared to fuse_readdir(), which is already "iterate_shared"
and also implements internal readdir cache, fuse adds an internal
mutex (quote) "against (crazy) parallel readdir on same open file".

Considering this protection is already provided by f_pos_lock
99% of the time, perhaps an opt-in flag to waiver the single
f_count optimization would be enough to be able to make
also ovl_iterate() shared?

Thanks,
Amir.
