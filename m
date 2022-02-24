Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B244C2B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 12:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiBXLob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 06:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiBXLo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:44:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D928DDFB
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 03:43:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f37so3323112lfv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aj1sHJcqKfZb0FtBlcvqwZ+alQwzGOksJeJvrB2n3c=;
        b=lKuEAZnyhHTHhRa8sI+KaAy+L/24jIHphLByYoXbT7Laiv3Pp2hGZx5OkqoRCCwQiB
         G5snGJHKil1n7xQZDv4CkZYg5Oexa2ZeRnkMZGZ9K3qBO72NusQBRomYTmqJx26nK2bl
         k1uSUGzItmiRTTBKKl9kR2We0meBcXcQOJid+4UuFcbyBJ6ZnMFnk+3VVdO40M8QaLXn
         215J84p6I9iqmAxns1anQP0EGVwzk+gvFKfqAt15OfNbp6i5onWDrRyNazdXg3ct2bC9
         2GESHzW5dJ+rx0bqHIv4hXUxUzqVnQxr9B59xRg2RVCmLF+JL9/DauUh+hTdUK82Kyfo
         PgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aj1sHJcqKfZb0FtBlcvqwZ+alQwzGOksJeJvrB2n3c=;
        b=qEFh+3whR++gbt9c+Absw21OlTb/7RuLfW9ucGC2S8OJcqnesQND5zfhJUIfP8hg07
         0xFW4/85VY+FtPlbzU9ZMiHPdT5rnMRY+gzg/h1bpBR25OMJVjZ3nEHTcervy5H4dr3e
         +rf6egb99nndFY1mdyFYvTklm/xtlmsXWIC3p10PC6Vjd7N+zzGLqEmYuKOaxnlpHTcT
         wLbYIcq59Zem/3UmpNjuKGdQvrPd1W5PSCZlJLmdlpqeuZ5I/kajs5BiAxr7He/l8m91
         3QKynAUmKjnAd7LENFzDrhGcIC6Iq0U4cfE1CSQ00kucSdlh/9QWUvHRl6d5h4pUq+xM
         zWDw==
X-Gm-Message-State: AOAM530Td78d6ORQpDK/K9KRvcs3kRQxXLKeh/I8AUrT2GqRwmPNZgNY
        wif6rbDM3DlsyP9trYGfRoFVnfKy9iax3XGa9YBNJw==
X-Google-Smtp-Source: ABdhPJz3iN1wfagflfnHgoSqfOU5YkaziRD5rRzHy7J3nc0KrnbGmpLRrTnVqtp7IHNN091wV5xSs6YsGn582ChCuus=
X-Received: by 2002:a19:e049:0:b0:42f:b0e2:10c4 with SMTP id
 g9-20020a19e049000000b0042fb0e210c4mr1553336lfj.170.1645703037284; Thu, 24
 Feb 2022 03:43:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
 <CAK896s7V7wj0Yiu0NQEFvmS9-oivJUosgMYW5UBJ4cX2YCSh6g@mail.gmail.com> <20220223135755.plbr2fvt66k3xyn5@riteshh-domain>
In-Reply-To: <20220223135755.plbr2fvt66k3xyn5@riteshh-domain>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Thu, 24 Feb 2022 19:43:46 +0800
Message-ID: <CAK896s7GsY_qGPZpA0KvmfsA7frkP0=nO8Fg3qd-ObmL-g+8AA@mail.gmail.com>
Subject: Re: [External] [RFC 9/9] ext4: fast_commit missing tracking updates
 to a file
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 9:59 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> On 22/02/23 11:50AM, Xin Yin wrote:
> > On Wed, Feb 23, 2022 at 4:36 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> > >
> > > <DO NOT MERGE THIS YET>
> > >
> > > Testcase
> > > ==========
> > > 1. i=0; while [ $i -lt 1000 ]; do xfs_io -f -c "pwrite -S 0xaa -b 32k 0 32k" -c "fsync" /mnt/$i; i=$(($i+1)); done && sudo ./src/godown -v /mnt && sudo umount /mnt && sudo mount /dev/loop2 /mnt'
> > > 2. ls -alih /mnt/ -> In this you will observe one such file with 0 bytes (which ideally should not happen)
> > >
> > > ^^^ say if you don't see the issue because your underlying storage
> > > device is very fast, then maybe try with commit=1 mount option.
> > >
> > > Analysis
> > > ==========
> > > It seems a file's updates can be a part of two transaction tid.
> > > Below are the sequence of events which could cause this issue.
> > >
> > > jbd2_handle_start -> (t_tid = 38)
> > > __ext4_new_inode
> > > ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid = 38)
> > > <track more updates>
> > > jbd2_start_commit -> (t_tid = 38)
> > >
> > > jbd2_handle_start (tid = 39)
> > > ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid 39)
> > >     -> ext4_fc_reset_inode & ei->i_sync_tid = t_tid
> > >
> > > ext4_fc_commit_start -> (will wait since jbd2 full commit is in progress)
> > > jbd2_end_commit (t_tid = 38)
> > >     -> jbd2_fc_cleanup() -> this will cleanup entries in sbi->s_fc_q[FC_Q_MAIN]
> > >         -> And the above could result inode size as 0 as  after effect.
> > > ext4_fc_commit_stop
> > >
> > > You could find the logs for the above behavior for inode 979 at [1].
> > >
> > > -> So what is happening here is since the ei->i_fc_list is not empty
> > > (because it is already part of sb's MAIN queue), we don't add this inode
> > > again into neither sb's MAIN or STAGING queue.
> > > And after jbd2_fc_cleanup() is called from jbd2 full commit, we
> > > just remove this inode from the main queue.
> > >
> > > So as a simple fix, what I did below was to check if it is a jbd2 full commit
> > > in ext4_fc_cleanup(), and if the ei->i_sync_tid > tid, that means we
> > > need not remove that from MAIN queue. This is since neither jbd2 nor FC
> > > has committed updates of those inodes for this new txn tid yet.
> > >
> > > But below are some quick queries on this
> > > =========================================
> > >
> > > 1. why do we call ext4_fc_reset_inode() when inode tid and
> > >    running txn tid does not match?
> > This is part of a change in commit:bdc8a53a6f2f,  it fixes the issue
> > for fc tracking logic while jbd2 commit is ongoing.
>
> Thanks Xin for pointing the other issue too.
> But I think what I was mostly referring to was - calling ext4_fc_reset_inode()
> in ext4_fc_track_template().
>
Understood, I missed something here, then maybe Harshad can give some
directions for this part.

> <..>
>  391         tid = handle->h_transaction->t_tid;
>  392         mutex_lock(&ei->i_fc_lock);
>  393         if (tid == ei->i_sync_tid) {
>  394                 update = true;
>  395         } else {
>  396                 ext4_fc_reset_inode(inode);
>  397                 ei->i_sync_tid = tid;
>  398         }
>  399         ret = __fc_track_fn(inode, args, update);
>  400         mutex_unlock(&ei->i_fc_lock);
>  <..>
>
> So, yes these are few corner cases which I want to take a deeper look at.
> I vaugely understand that this reset inode is done since we anyway might have
> done the full commit for previous tid, so we can reset the inode track range.
>
> So, yes, we should carefully review this as well that if jbd2 commit happens for
> an inode which is still part of MAIN_Q, then does it make sense to still
> call ext4_fc_reset_inode() for that inode in ext4_fc_track_template()?
>
> > If the inode tid is bigger than txn tid, that means this inode may be
> > in the STAGING queue, if we reset it then it will lose the tack range.
> > I think it's a similar issue, the difference is this inode is already
>
> Do you have a test case which was failing for your issue?
> I would like to test that one too.

This issue can be triggered by generic/455 , but this is one failed
case for it. I also do not have a reproducer for this.

>
>
> > in the MAIN queue before the jbd2 commit starts.
> > And yes , I think in this case we can not remove it from the MAIN
>
> Yes. I too have a similar thought. But I still wanted to get few queries sorted
> (like point 1 & 2).
>
> > queue, but still need to clear EXT4_STATE_FC_COMMITTING right? it may
> > block some task still waiting for it.
>
> Sorry I didn't get you here. So I think we will end up in such situation
> (where ext4_fc_cleanup() is getting called for an inode with i_sync_tid > tid)
> only from full commit path right ?
> And that won't set EXT4_FC_COMMITTING for this inode right anyways no?

 I am not sure if there are any other cases, But for now we also clear
EXT4_STATE_FC_COMMITTING in the full commit path right? So maybe some
further tests are needed.

Thanks,
Xin Yin
>
> Do you mean anything else, or am I missing something here?
>
> -ritesh
>
>
> >
> > Thanks,
> > Xin Yin
> > >
> > > 2. Also is this an expected behavior from the design perspective of
> > >    fast_commit. i.e.
> > >    a. the inode can be part of two tids?
> > >    b. And that while a full commit is in progress, the inode can still
> > >    receive updates but using a new transaction tid.
> > >
> > > Frankly speaking, since I was also working on other things, so I haven't
> > > yet got the chance to completely analyze the situation yet.
> > > Once I have those things sorted, I will spend more time on this, to
> > > understand it more. Meanwhile if you already have some answers to above
> > > queries/observations, please do share those here.
> > >
> > > Links
> > > =========
> > > [1] https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fast_commit/fc_inode_missing_updates_ino_979.txt
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  fs/ext4/fast_commit.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 8803ba087b07..769b584c2552 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -1252,6 +1252,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> > >         spin_lock(&sbi->s_fc_lock);
> > >         list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
> > >                                  i_fc_list) {
> > > +               if (full && iter->i_sync_tid > tid)
> > > +                       continue;
> > >                 list_del_init(&iter->i_fc_list);
> > >                 ext4_clear_inode_state(&iter->vfs_inode,
> > >                                        EXT4_STATE_FC_COMMITTING);
> > > --
> > > 2.31.1
> > >
