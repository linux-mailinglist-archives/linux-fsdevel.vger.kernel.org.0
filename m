Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9222E9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG0KCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0KCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:02:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E86C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 03:02:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so3943619ioe.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AHNGZDZTykJ+1/Y27dtghbTBD3NqB6ChYdcFC+b58w=;
        b=SiHOiDGfrAWjcgoapPfWeuJotJZI5XJM7tjOyKVEBqn1E+jnW72uQ64sdPkQrDKgWc
         CJoPDoyOsI3gXrThKMWTIHvWgFHeIJ3MPKJzh6qULaYr7eqDTrKsoImol9IXULvdOn2K
         gihAnYZe2JV0qdgW/zjKan/IpCZsgv5ZMQiW/x0pckwxMDmtczrA8xtPJqrJAx6LJpQI
         2NXagp70nKzsjlGWbn0eLOWS/5YidOr2InZh28h/CYp+9P5pz/1IDO7SzYkjodACMwyx
         EgOWFmaTiLOkPkWxqljPBfrghX2OC0pEZlGEeCAxVjg8xowHRjOlTTixLIPXiCu0IryG
         NXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AHNGZDZTykJ+1/Y27dtghbTBD3NqB6ChYdcFC+b58w=;
        b=SaUPcgSs0cWoRmLY0VkQ4UE9uMM+0HMnlUhSWB67N/JSRJa7LL1KzYLQPnjT1GGfxs
         t2osrWcBWfv2ShGKwNY04mnpiE6h/enOWCamQV56GxUuOI87okzUmh7wmqBlOvw5fPRe
         156rZHEhgVzVRCaxAUj9uuVF5s8xskx4xx2hWuhaHZ5dY26r17Q5DSZVCk2jsjzXlBA/
         fS3lhQ5YNOkLa3FHh8ZlrYBTAKfWRaBHOoEjAD2yyhxjUCr+bt0RbApEKe5Ww6TVr6Az
         w6Z8lvi7myovBWX8xo4fsMCMCk4T8QRprvANUvWTQ7dmkSQhFyICu81+8XomhmCZ11qu
         FCQA==
X-Gm-Message-State: AOAM533bjI5ppLNkEZ3r0DMlFSZgSFG3OrNXRq0apD9PnZz6qsfvE1kL
        BomNnYyvtnG/TXt/g4AJM9NuOimqtxn6UEyaSxjbYW0x
X-Google-Smtp-Source: ABdhPJzjGkrKv/tts/4PqUuZobWocoIezkI+/NUmQWIm70WasYQZcCnqN36qU15yC895e3Ht/lh6Wxx13+TZ3MM3kmg=
X-Received: by 2002:a02:a986:: with SMTP id q6mr24365012jam.93.1595844152754;
 Mon, 27 Jul 2020 03:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz> <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
 <20200706110526.GA3913@quack2.suse.cz> <CAOQ4uxi5Zpp7rCKdOkdw9Nkd=uGC-K2AuLqOFc0WQc_CgJQP2Q@mail.gmail.com>
 <CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com> <20200727074417.GB23179@quack2.suse.cz>
In-Reply-To: <20200727074417.GB23179@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 Jul 2020 13:02:21 +0300
Message-ID: <CAOQ4uxjc72vm7yqbH+w5mQ=uNbhRjhqFfn8R+LXVZRiExy-NXA@mail.gmail.com>
Subject: Re: fsnotify: minimise overhead when there are no marks related to sb
To:     Jan Kara <jack@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:44 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 26-07-20 18:20:26, Amir Goldstein wrote:
> > On Thu, Jul 9, 2020 at 8:56 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > > > Otherwise the patch looks good. One observation though: The (mask &
> > > > > > FS_MODIFY) check means that all vfs_write() calls end up going through the
> > > > > > "slower" path iterating all mark types and checking whether there are marks
> > > > > > anyway. That could be relatively simply optimized using a hidden mask flag
> > > > > > like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> > > > > > needing special handling of FS_MODIFY... Not sure if we care enough at this
> > > > > > point...
> > > > >
> > > > > Yeh that sounds low hanging.
> > > > > Actually, I Don't think we need to define a flag for that.
> > > > > __fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.
> > > >
> > > > Yes, that would be even more elegant.
> > > >
> > > > > I will take a look at that as part of FS_PRE_MODIFY work.
> > > > > But in general, we should fight the urge to optimize theoretic
> > > > > performance issues...
> > > >
> > > > Agreed. I just suspect this may bring measurable benefit for hackbench pipe
> > > > or tiny tmpfs writes after seeing Mel's results. But as I wrote this is a
> > > > separate idea and without some numbers confirming my suspicion I don't
> > > > think the complication is worth it so I don't want you to burn time on this
> > > > unless you're really interested :).
> > > >
> > >
> > > You know me ;-)
> > > FS_MODIFY optimization pushed to fsnotify_pre_modify branch.
> > > Only tested that LTP tests pass.
> > >
> > > Note that this is only expected to improve performance in case there *are*
> > > marks, but not marks with ignore mask, because there is an earlier
> > > optimization in fsnotify() for the no marks case.
> > >
> >
> > Hi Mel,
> >
> > After following up on Jan's suggestion above, I realized there is another
> > low hanging optimization we can make.
> >
> > As you may remember, one of the solutions we considered was to exclude
> > special or internal sb's from notifications based on some SB flag, but making
> > assumptions about which sb are expected to provide notifications turned out
> > to be a risky game.
> >
> > We can however, keep a counter on sb to *know* there are no watches
> > on any object in this sb, so the test:
> >
> >         if (!sb->s_fsnotify_marks &&
> >             (!mnt || !mnt->mnt_fsnotify_marks) &&
> >             (!inode || !inode->i_fsnotify_marks))
> >                 return 0;
> >
> > Which is not so nice for inlining, can be summarized as:
> >
> >         if (atomic_long_read(&inode->i_sb->s_fsnotify_obj_refs) == 0)
> >                 return 0;
> >
> > Which is nicer for inlining.
>
> That's a nice idea. I was just wondering why do you account only inode
> references in the superblock. Because if there's only say mount watch,
> s_fsnotify_obj_refs will be 0 and you will wrongly skip reporting. Or am I
> misunderstanding something? I'd rather have counter like
> sb->s_fsnotify_connectors, that will account all connectors related to the
> superblock - i.e., connectors attached to the superblock, mounts referring
> to the superblock, or inodes referring to the superblock...
>

Yeh, that is what I did.
Those two commits change the former s_fsnotify_inode_refs
to s_fsnotify_obj_refs which counts objects (inodes/mounts/sb) pointed to
be connectors.
I agree that s_fsnotify_connectors may be a better choice of name ;-)

de1255f8a64c fsnotify: count all objects with attached connectors
5e6c3af6e2df fsnotify: count s_fsnotify_inode_refs for attached connectors

Thanks,
Amir.
