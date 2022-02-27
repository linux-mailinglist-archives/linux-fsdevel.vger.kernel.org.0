Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309A4C5E29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiB0Scp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0Sco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:32:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789536CA58;
        Sun, 27 Feb 2022 10:32:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a23so20639299eju.3;
        Sun, 27 Feb 2022 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uc546s013azn+7de9UVtVeYuLtnBedUZuHFVYaEkNtY=;
        b=C9ZeTTOe7I52JXzYBm9c2AwAZoK6dNPseT9uDXc4gFqaBsFalBA2MI/TWREbSEeymj
         o9XO9HkdKRKL4I2vcbDqvCKNM6J0Uy95uvLlX7VyIEOZVtmRuD3N/+qwmaAuq21lBAHz
         agAPXqEhXMSPl8tx1msjFS1EDIkgJZw/3IhMesUHHyNGM7wIScK6YI/tR+gV9I6Z+Mv+
         nTmNsXOox7ZMzypWJ0ptRdCVoSbDoEh7cqYKHezyAK/tvVCj5+BQsITtOBVMV3ynLrDE
         xVSTaXwKvyz0Vs/2te1oCvV3pQToPr6H44f3ZGunuOWROp1JOubXA+rEwNIRFtt91Abq
         q7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uc546s013azn+7de9UVtVeYuLtnBedUZuHFVYaEkNtY=;
        b=Ih+6pZMoMztEP0PkLcnvNNoruwXYCU8pBKmzWxG7WO1Ljh0pm1vM1yP9qQeVAxqiWH
         XPPZCer7n4LLrYIAqYeacIRO0RJ7ENwB7Gy/CIns0dT72uxbhKr7dukP0AOf1x5MqmY/
         2g00iJYxEyaJtF60Ix2EjpmJDBhugiFlP8u8uR3D3eP8Ly6KkqZKPVuLXLYhajTwS0TS
         +sAuRVR+YdaRfsh6mNYfYN1DAKaXug8PhyHU0W7zD3DIMziTy412DwYQFosJlqBLRsI1
         jmhzhC+CuifDVFDXfBEJJRZzwQ5tIK4Lw4mQpOAiZ8Cjb0RxTupltjH5wjTNRxp0KH8o
         1xlA==
X-Gm-Message-State: AOAM531QgCCW4rUucCk7K7QpDohXK22x1CswoNkwC5cVUFutBur7+YLV
        y4KoxPlrLEK/3dHbSzxkhuS9JasZXUf1lz9G0uflegZa9I4=
X-Google-Smtp-Source: ABdhPJwIBMCv7Q1kaGz+yXfPm0don/sgGlvr6KYXBQgaRRGdcXz/Xen27EF66tIcX55qUbwtAtj8hhSgoJrl/gtbEoc=
X-Received: by 2002:a17:906:3650:b0:6ce:a6e0:3e97 with SMTP id
 r16-20020a170906365000b006cea6e03e97mr13365711ejb.15.1645986725938; Sun, 27
 Feb 2022 10:32:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <dbc43257b4039b4bdba5613cd31fe65528721f3a.1645558375.git.riteshh@linux.ibm.com>
 <20220223094420.de6yx7dvgbux327o@quack3.lan>
In-Reply-To: <20220223094420.de6yx7dvgbux327o@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:31:54 -0800
Message-ID: <CAD+ocbza2KHZX1PYHEC7qZ1GJz+HW0JqOtU=Fb-NzJ-fXn1y=A@mail.gmail.com>
Subject: Re: [RFC 6/9] ext4: Add commit tid info in ext4_fc_commit_start/stop
 trace events
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

On Wed, 23 Feb 2022 at 01:44, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:14, Ritesh Harjani wrote:
> > This adds commit_tid info in ext4_fc_commit_start/stop which is helpful
> > in debugging fast_commit issues.
> >
> > For e.g. issues where due to jbd2 journal full commit, FC miss to commit
> > updates to a file.
> >
> > Also improves TP_prink format string i.e. all ext4 and jbd2 trace events
> > starts with "dev MAjOR,MINOR". Let's follow the same convention while we
> > are still at it.
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
> >  fs/ext4/fast_commit.c       |  4 ++--
> >  include/trace/events/ext4.h | 21 +++++++++++++--------
> >  2 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index ee32aac0cbbf..8803ba087b07 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1150,7 +1150,7 @@ static void ext4_fc_update_stats(struct super_block *sb, int status,
> >       } else {
> >               stats->fc_skipped_commits++;
> >       }
> > -     trace_ext4_fc_commit_stop(sb, nblks, status);
> > +     trace_ext4_fc_commit_stop(sb, nblks, status, commit_tid);
> >  }
> >
> >  /*
> > @@ -1171,7 +1171,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> >       if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> >               return jbd2_complete_transaction(journal, commit_tid);
> >
> > -     trace_ext4_fc_commit_start(sb);
> > +     trace_ext4_fc_commit_start(sb, commit_tid);
> >
> >       start_time = ktime_get();
> >
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index cd09dccea502..6e66cb7ce624 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -2685,26 +2685,29 @@ TRACE_EVENT(ext4_fc_replay,
> >  );
> >
> >  TRACE_EVENT(ext4_fc_commit_start,
> > -     TP_PROTO(struct super_block *sb),
> > +     TP_PROTO(struct super_block *sb, tid_t commit_tid),
> >
> > -     TP_ARGS(sb),
> > +     TP_ARGS(sb, commit_tid),
> >
> >       TP_STRUCT__entry(
> >               __field(dev_t, dev)
> > +             __field(tid_t, tid)
> >       ),
> >
> >       TP_fast_assign(
> >               __entry->dev = sb->s_dev;
> > +             __entry->tid = commit_tid;
> >       ),
> >
> > -     TP_printk("fast_commit started on dev %d,%d",
> > -               MAJOR(__entry->dev), MINOR(__entry->dev))
> > +     TP_printk("dev %d,%d tid %u", MAJOR(__entry->dev), MINOR(__entry->dev),
> > +               __entry->tid)
> >  );
> >
> >  TRACE_EVENT(ext4_fc_commit_stop,
> > -         TP_PROTO(struct super_block *sb, int nblks, int reason),
> > +         TP_PROTO(struct super_block *sb, int nblks, int reason,
> > +                  tid_t commit_tid),
> >
> > -     TP_ARGS(sb, nblks, reason),
> > +     TP_ARGS(sb, nblks, reason, commit_tid),
> >
> >       TP_STRUCT__entry(
> >               __field(dev_t, dev)
> > @@ -2713,6 +2716,7 @@ TRACE_EVENT(ext4_fc_commit_stop,
> >               __field(int, num_fc)
> >               __field(int, num_fc_ineligible)
> >               __field(int, nblks_agg)
> > +             __field(tid_t, tid)
> >       ),
> >
> >       TP_fast_assign(
> > @@ -2723,12 +2727,13 @@ TRACE_EVENT(ext4_fc_commit_stop,
> >               __entry->num_fc_ineligible =
> >                       EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
> >               __entry->nblks_agg = EXT4_SB(sb)->s_fc_stats.fc_numblks;
> > +             __entry->tid = commit_tid;
> >       ),
> >
> > -     TP_printk("fc on [%d,%d] nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d",
> > +     TP_printk("dev %d,%d nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d, tid %u",
> >                 MAJOR(__entry->dev), MINOR(__entry->dev),
> >                 __entry->nblks, __entry->reason, __entry->num_fc,
> > -               __entry->num_fc_ineligible, __entry->nblks_agg)
> > +               __entry->num_fc_ineligible, __entry->nblks_agg, __entry->tid)
> >  );
> >
> >  #define FC_REASON_NAME_STAT(reason)                                  \
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
