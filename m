Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E64C5E26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiB0ScK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0ScJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:32:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFFD6CA4F;
        Sun, 27 Feb 2022 10:31:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gb39so20681530ejc.1;
        Sun, 27 Feb 2022 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9NiXmxRqD1wbfEvhmJu7XXQT8V6DVwCm34Rrre6qno=;
        b=XfaQflcXKyxbp1i57U8x3PBlfTwwGkpDeP/H16PvWGKj307jSzC3puUuhHeJ9/7rF6
         3XYer/UW3ZuKn6soW7bo8v5STlp0u6ZwUbki0AYO4rClVvlasxpUaBf8W50svrPsvYm2
         WqjLjSHwiNFZBtHFqb9gJSabMML8C+aDryzuEV4izfw1c8SS9PwOjh+DYikPYUDPVa6K
         cwPhT7vmVImZ1P+N/ygj1tTMx3jCrhbT6SNjm/HRF5vTozRxI7+GKSmPxrHcSZpXQ9Of
         H/8Sz6KUcRv26hH078a9SIC7UY3QGZ4q/kf4plIXo+pQLiwHg51DY/WE0poef61UfIUD
         /Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9NiXmxRqD1wbfEvhmJu7XXQT8V6DVwCm34Rrre6qno=;
        b=JBk3Vx38fSjuZf6PGiMzjKNZ7zvo0yTnsfssEjrWzQntHKMAa90PocpZGGI5wvaeJA
         E/Vetvfkfnz+wujQTUWJ/1d4+TrCOaS051ORq14hjmBq5f9Mp7vf9zIZE+cEZMc3ZbOa
         jIUBxlF7/0GZ5e4UrA3NTax85IBntcSeMVitIx74nteY/yNi6W2wkNVgLKfgXjBT/Nx1
         4lpatH69wDrHoGmz2yTyEx4mWhffEXIVi0PRg/fWiYKqqRlfhhZVZoRbO8i636nWYZfx
         znXkYf+Kr3lS4xpRqbIC4hbNEdhYX0Wgb7Uf9bDHjqld0NXeOaRTK1zYbwBdAEGGAGDC
         SPug==
X-Gm-Message-State: AOAM53030S2m4iHz5+vVU4PMwEdfywtd0BLLd8YmzRV6zJID+RQLwp9j
        +7/mMDgpehPsiKDyHMYBUBKwu7D+I66OUh2wzLo=
X-Google-Smtp-Source: ABdhPJwTEIZEUHV3lDwF05oQowbv9I+xLF13ZfXfk238rNNctQr5qyZpy3Ktkmt91KHIGSp3MsOIWgmkR+RGsxX0vh0=
X-Received: by 2002:a17:906:bc46:b0:6ce:3d41:f87e with SMTP id
 s6-20020a170906bc4600b006ce3d41f87emr12562814ejv.283.1645986691022; Sun, 27
 Feb 2022 10:31:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <60daf324eec64f2be0b9ce0e240294d36411037c.1645558375.git.riteshh@linux.ibm.com>
 <20220223094254.fmowjdq4dbig5elz@quack3.lan>
In-Reply-To: <20220223094254.fmowjdq4dbig5elz@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:31:19 -0800
Message-ID: <CAD+ocbxzkWLPnoC5nE7-2fq34=oAcJFyk6U-HZ+NFtEKKDF8Dw@mail.gmail.com>
Subject: Re: [RFC 5/9] ext4: Add commit_tid info in jbd debug log
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

- Harshad

On Wed, 23 Feb 2022 at 01:42, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:13, Ritesh Harjani wrote:
> > This adds commit_tid argument in ext4_fc_update_stats()
> > so that we can add this information too in jbd_debug logs.
> > This is also required in a later patch to pass the commit_tid info in
> > ext4_fc_commit_start/stop() trace events.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/fast_commit.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 7fb1eceef30c..ee32aac0cbbf 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1127,11 +1127,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
> >  }
> >
> >  static void ext4_fc_update_stats(struct super_block *sb, int status,
> > -                              u64 commit_time, int nblks)
> > +                              u64 commit_time, int nblks, tid_t commit_tid)
> >  {
> >       struct ext4_fc_stats *stats = &EXT4_SB(sb)->s_fc_stats;
> >
> > -     jbd_debug(1, "Fast commit ended with status = %d", status);
> > +     jbd_debug(1, "Fast commit ended with status = %d for tid %u",
> > +                     status, commit_tid);
> >       if (status == EXT4_FC_STATUS_OK) {
> >               stats->fc_num_commits++;
> >               stats->fc_numblks += nblks;
> > @@ -1181,14 +1182,16 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> >               if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
> >                       commit_tid > journal->j_commit_sequence)
> >                       goto restart_fc;
> > -             ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0);
> > +             ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
> > +                             commit_tid);
> >               return 0;
> >       } else if (ret) {
> >               /*
> >                * Commit couldn't start. Just update stats and perform a
> >                * full commit.
> >                */
> > -             ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0);
> > +             ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0,
> > +                             commit_tid);
> >               return jbd2_complete_transaction(journal, commit_tid);
> >       }
> >
> > @@ -1220,12 +1223,12 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> >        * don't react too strongly to vast changes in the commit time
> >        */
> >       commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
> > -     ext4_fc_update_stats(sb, status, commit_time, nblks);
> > +     ext4_fc_update_stats(sb, status, commit_time, nblks, commit_tid);
> >       return ret;
> >
> >  fallback:
> >       ret = jbd2_fc_end_commit_fallback(journal);
> > -     ext4_fc_update_stats(sb, status, 0, 0);
> > +     ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
> >       return ret;
> >  }
> >
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
