Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AC4C5EDA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiB0Uwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 15:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiB0Uwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:52:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BC6CA56;
        Sun, 27 Feb 2022 12:52:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id bq11so14860773edb.2;
        Sun, 27 Feb 2022 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1ZiN7+HYTmPnWKRoprEVX0bDh5aoOqwKR44umyuBnc=;
        b=Zf8bWunWTeV2YZSJjRrBN09d5dmBapzHaNBQrsPwqGtJWYYzqN43dRmbrmcB6MS/af
         7qjQMKGpPmTEblVepX+4mJHAmKKWZx+ZVR3A31e3t9eSQ3NviCom+7lLOqIngkinN9dg
         gM8YblLTaOxqldX04nC1ZewAmIG4S6psZK09xFYkrEHW/F+A+qhow57UVdU77fN23Sa6
         Ri60eghsYyPDN/RsE5CbRd6QqEyOXS4fhtlorza6cpqc1vLf1LZdiUH4wBFAkKsCdISn
         pUbzeEY4U46dcP5WuQaJqfkTq2plX11jM4OsyqK7CBRq2RW+P/rlxIQ+R/HtLUTBFAkc
         6tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1ZiN7+HYTmPnWKRoprEVX0bDh5aoOqwKR44umyuBnc=;
        b=iXZ8rg7AZhAjaLCKcp4z0G2lIInS3bcM6yFpAwwhj01EMUyAJm3He4g0GhDS4zrOuF
         dEuNdIvDaLbrs3kRjD8gB7nsajtJmUD4fwW64kmrmz7KoSD4tvVNn8Vj1Xzy75a50qEj
         sgdSAofR8gpzsAipLzDwGkiknuqL+zaPGZG5n5GN0cXgRxLR/3iJQHH4ds5VED0rO5tt
         sH0AXKC7u2KcwUg/Z+7QX7sNkz7YdEtxqcjVYse5TLwnv7/3dqE4+ro9cB1eJr+TtSla
         AHOuNGheU3uu3eXM/Wmt1uAY1Pjp7h8GTwF7e/rHk1wedO+218RkUh5QZ6hr8rE/6oAM
         gO1g==
X-Gm-Message-State: AOAM53344HOImqZSLJX0uui5IAl9XL/pqAc/0zZMSdChCFEE3rV9nrgZ
        GEQ9ZJBOqltYkMwZT8PG/y+B6DR1Bzs8mOxVY2w=
X-Google-Smtp-Source: ABdhPJw9LzCp9nh96a/8BcX1Zoc1Z5NOv4vzNOYAd49IifSS/tujrO1CbuwamzfbKRP5GNeNaQwcYwWM5QwIEMeyYJs=
X-Received: by 2002:a50:d496:0:b0:413:2cf1:efb6 with SMTP id
 s22-20020a50d496000000b004132cf1efb6mr16536681edi.150.1645995123598; Sun, 27
 Feb 2022 12:52:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
 <CAK896s7V7wj0Yiu0NQEFvmS9-oivJUosgMYW5UBJ4cX2YCSh6g@mail.gmail.com>
 <20220223135755.plbr2fvt66k3xyn5@riteshh-domain> <CAK896s7GsY_qGPZpA0KvmfsA7frkP0=nO8Fg3qd-ObmL-g+8AA@mail.gmail.com>
In-Reply-To: <CAK896s7GsY_qGPZpA0KvmfsA7frkP0=nO8Fg3qd-ObmL-g+8AA@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 12:51:52 -0800
Message-ID: <CAD+ocbySFC=fzqotCdg5hsNE8D3H_7eoU2QdHE0jmsa+z_x0qw@mail.gmail.com>
Subject: Re: [External] [RFC 9/9] ext4: fast_commit missing tracking updates
 to a file
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

> > So, yes these are few corner cases which I want to take a deeper look at.
> > I vaugely understand that this reset inode is done since we anyway might have
> > done the full commit for previous tid, so we can reset the inode track range.
> >
> > So, yes, we should carefully review this as well that if jbd2 commit happens for
> > an inode which is still part of MAIN_Q, then does it make sense to still
> > call ext4_fc_reset_inode() for that inode in ext4_fc_track_template()?
What this code assumes here is that if tid != ei->i_sync_tid, then the
fast commit information present in the inode cannot be trusted. This
is useful when the inode is added to the fast commit queue for the
first ever or first time during the current transaction. Also note the
"update" parameter, if update is set to false, then the track
functions know that this is the first time the track function is
called since the last (fast / full) commit.

I think the simple invariant that we need to follow is that, once an
inode is committed (either by fast or full commit)
ext4_fc_reset_inode() should be called exactly once before any track
functions get called. So, if we can ensure that reset gets called on
all inodes that were committed by fast commit / full commit exactly
once before any track functions update the fc info, then we don't
really need this reset call here.

> > > > 2. Also is this an expected behavior from the design perspective of
> > > >    fast_commit. i.e.
> > > >    a. the inode can be part of two tids?
From a design perspective, in fast commits, inode updates are not
strictly tied to tids. We reuse i_sync_tid only to detect if the
updates to an inode are committed or not. But at a high level, inode
can be in 3 states from fc perspective - (1) inode is not modified
since last fast commit / full commit (2) inode is modified since last
fast commit / full commit (3) inode is being committed by fast commit.
Well, this makes me think that these states can also be represented by
inode states, and maybe if we do that we can get rid of reliance on
i_sync_tid altogether? This needs a bit more thought.
> > > >    b. And that while a full commit is in progress, the inode can still
> > > >    receive updates but using a new transaction tid.
Yeah, inode can still receive updates if a full commit is ongoing. If
a fast commit is ongoing on a particular update, then the inode will
not receive updates. EXT4_FC_STATE_COMMITTING will protect against it.
In the new patch that I'm working on (sorry for the delay on that),
what I'm doing is that handles that modify inode wait if the inode is
being committed.

- Harshad
> > > >
> > > > Frankly speaking, since I was also working on other things, so I haven't
> > > > yet got the chance to completely analyze the situation yet.
> > > > Once I have those things sorted, I will spend more time on this, to
> > > > understand it more. Meanwhile if you already have some answers to above
> > > > queries/observations, please do share those here.
> > > >
> > > > Links
> > > > =========
> > > > [1] https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fast_commit/fc_inode_missing_updates_ino_979.txt
> > > >
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > > ---
> > > >  fs/ext4/fast_commit.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > > index 8803ba087b07..769b584c2552 100644
> > > > --- a/fs/ext4/fast_commit.c
> > > > +++ b/fs/ext4/fast_commit.c
> > > > @@ -1252,6 +1252,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> > > >         spin_lock(&sbi->s_fc_lock);
> > > >         list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
> > > >                                  i_fc_list) {
> > > > +               if (full && iter->i_sync_tid > tid)
> > > > +                       continue;
> > > >                 list_del_init(&iter->i_fc_list);
> > > >                 ext4_clear_inode_state(&iter->vfs_inode,
> > > >                                        EXT4_STATE_FC_COMMITTING);
> > > > --
> > > > 2.31.1
> > > >
