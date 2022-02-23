Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00724C0ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 04:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBWDvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 22:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiBWDvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:51:41 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE0657AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 19:51:12 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so22725495ljh.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 19:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9o8E/GqdYtOTLRG+zZAUd0gtjWhs7Bb1g7AEZ+WmaI=;
        b=aXRcJ4yvHQJyf6hir6XnrojLMAQB6U8jccX70auhmlB1CquPuAxO5Kj/XnwagE3C3m
         iycKRFhvQvlKaLOC+DbDUMYJV9DQQzNhIA6i4Bl8PeEn0ftd7oiSO2awlUmRldWHLEL3
         GvyRwpIEdEZgZ80W4Pu4tDwf4TQK7kvkcExxFkAk6JyDD8nDJ/102TCiXPHGTnE3vfyO
         MLXKstC6hZQtMKEf3G5KhHehXE6zvK0jMK40AncVqK7efTJUCmKafH/MxV4+te+5RNTI
         wtC/Hq3o+rOBi29XVbrlpDeLzJ7zWY2BM1QLQRGR86C3tTwBA83f0QluJ9IHay2GHCuY
         2gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9o8E/GqdYtOTLRG+zZAUd0gtjWhs7Bb1g7AEZ+WmaI=;
        b=0muXa0QZlwfdbES4PAaQuaTd7+Er7MMSdlSV9OfvS41nNLwZ/lbksjKJx3nslZbc3M
         HXi120r0rkGuaWO/2t5OP9gRd6MdjukVR0TZbtihNWtsqxesr+3PBegE5iqb0qYP6N7w
         gc0IirIYbMANknJqrr5j54zMWLS0OQsX5p10P9e9Eh76h4dmWo4lwHxqqgrTGWYENdiN
         gZRp/v/a7OahTawCHyHr77Pea2QXC4TsWTwI7+mL4DTpjxyeZylSxN0vqNJYz8yMlDqN
         Ev+okrSOuqA9pPa5bxCd11bRmEIsIM9NMiIuKlQz3mBoaAM5gZex2bnf4oS9lPYyKDrT
         ZVNg==
X-Gm-Message-State: AOAM533RWuss3D1E1DnPCGCFc8SsdkKx3ISnuTCYpWhmhOaXbtMDLC3B
        /oiNUlTIjxuRzrW+bhYjk4nyx86gMU3dDoUy5Mn26Q==
X-Google-Smtp-Source: ABdhPJzuv0Mz9ZFoYJQKM313P4fWrFMmznEbd/Qc826SeVAFFXm/puIOmIEgAaFTiz4B6KS9LP5DYnS7kpi2DwUdHuY=
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr13863094ljw.291.1645588270878; Tue, 22
 Feb 2022 19:51:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
In-Reply-To: <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Wed, 23 Feb 2022 11:50:59 +0800
Message-ID: <CAK896s7V7wj0Yiu0NQEFvmS9-oivJUosgMYW5UBJ4cX2YCSh6g@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 4:36 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> <DO NOT MERGE THIS YET>
>
> Testcase
> ==========
> 1. i=0; while [ $i -lt 1000 ]; do xfs_io -f -c "pwrite -S 0xaa -b 32k 0 32k" -c "fsync" /mnt/$i; i=$(($i+1)); done && sudo ./src/godown -v /mnt && sudo umount /mnt && sudo mount /dev/loop2 /mnt'
> 2. ls -alih /mnt/ -> In this you will observe one such file with 0 bytes (which ideally should not happen)
>
> ^^^ say if you don't see the issue because your underlying storage
> device is very fast, then maybe try with commit=1 mount option.
>
> Analysis
> ==========
> It seems a file's updates can be a part of two transaction tid.
> Below are the sequence of events which could cause this issue.
>
> jbd2_handle_start -> (t_tid = 38)
> __ext4_new_inode
> ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid = 38)
> <track more updates>
> jbd2_start_commit -> (t_tid = 38)
>
> jbd2_handle_start (tid = 39)
> ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid 39)
>     -> ext4_fc_reset_inode & ei->i_sync_tid = t_tid
>
> ext4_fc_commit_start -> (will wait since jbd2 full commit is in progress)
> jbd2_end_commit (t_tid = 38)
>     -> jbd2_fc_cleanup() -> this will cleanup entries in sbi->s_fc_q[FC_Q_MAIN]
>         -> And the above could result inode size as 0 as  after effect.
> ext4_fc_commit_stop
>
> You could find the logs for the above behavior for inode 979 at [1].
>
> -> So what is happening here is since the ei->i_fc_list is not empty
> (because it is already part of sb's MAIN queue), we don't add this inode
> again into neither sb's MAIN or STAGING queue.
> And after jbd2_fc_cleanup() is called from jbd2 full commit, we
> just remove this inode from the main queue.
>
> So as a simple fix, what I did below was to check if it is a jbd2 full commit
> in ext4_fc_cleanup(), and if the ei->i_sync_tid > tid, that means we
> need not remove that from MAIN queue. This is since neither jbd2 nor FC
> has committed updates of those inodes for this new txn tid yet.
>
> But below are some quick queries on this
> =========================================
>
> 1. why do we call ext4_fc_reset_inode() when inode tid and
>    running txn tid does not match?
This is part of a change in commit:bdc8a53a6f2f,  it fixes the issue
for fc tracking logic while jbd2 commit is ongoing.
If the inode tid is bigger than txn tid, that means this inode may be
in the STAGING queue, if we reset it then it will lose the tack range.
I think it's a similar issue, the difference is this inode is already
in the MAIN queue before the jbd2 commit starts.
And yes , I think in this case we can not remove it from the MAIN
queue, but still need to clear EXT4_STATE_FC_COMMITTING right? it may
block some task still waiting for it.

Thanks,
Xin Yin
>
> 2. Also is this an expected behavior from the design perspective of
>    fast_commit. i.e.
>    a. the inode can be part of two tids?
>    b. And that while a full commit is in progress, the inode can still
>    receive updates but using a new transaction tid.
>
> Frankly speaking, since I was also working on other things, so I haven't
> yet got the chance to completely analyze the situation yet.
> Once I have those things sorted, I will spend more time on this, to
> understand it more. Meanwhile if you already have some answers to above
> queries/observations, please do share those here.
>
> Links
> =========
> [1] https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fast_commit/fc_inode_missing_updates_ino_979.txt
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/fast_commit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 8803ba087b07..769b584c2552 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1252,6 +1252,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>         spin_lock(&sbi->s_fc_lock);
>         list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>                                  i_fc_list) {
> +               if (full && iter->i_sync_tid > tid)
> +                       continue;
>                 list_del_init(&iter->i_fc_list);
>                 ext4_clear_inode_state(&iter->vfs_inode,
>                                        EXT4_STATE_FC_COMMITTING);
> --
> 2.31.1
>
