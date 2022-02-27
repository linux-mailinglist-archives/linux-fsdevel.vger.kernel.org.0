Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118934C5E20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiB0SaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0SaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:30:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95668F8D;
        Sun, 27 Feb 2022 10:29:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s24so14533706edr.5;
        Sun, 27 Feb 2022 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbCkBCdIE/So60XSdai8/3JA7gbz1fMwINxsVfT5pA4=;
        b=DNBg1V4TOyQp8GN8h+WKwujSdLsysm1fsLinl/su3on0HZFokoPCwuTulk+8Ztqa8K
         itPwHUQDl5mOt/REz/FWclhFqG5ux74XNVcXFc0ZtMIUANSKPNQoQ/anoQvYgHAl+1J/
         s7cScaP+Cy2cnbJ0rpwBdoUSsTtK5DqGWxI11ZjwZYaMbkiNj/vBvP6Wc8kzoXBFFUVW
         WHh64HUbzQAz8IEVynt6Qd3Fm+AOjC+Y22xAPgWH9ai0/U7wAQTJ0jiFnZlg/0bRd9pC
         965zBlEgCGFOb+b4EWke1vd6fqNjpfnRabA5HmDcYmzOnnc6Q/X29ZBKVjoiQel6j04l
         kTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbCkBCdIE/So60XSdai8/3JA7gbz1fMwINxsVfT5pA4=;
        b=ZhBq5ZKvlU9TEw9eh/NZMzL5ytyTnu1IcFfyL4lDZRfQHtKQodICdNX0oKfwVXhtlx
         UiKVEdSnY3YvU+X2/QkLNTnhPghtzpRoGtPdDbclHZf9ypVRD2zeDGkVDy4cStwvMOtW
         orEvINNJFG0GOYKR/MuXyVQilDvPasg/Wp8PvW9cr6PGAcOlkd8a4R8QJfJsPl0sifi7
         jsPqRBYsmrQNpZ4ai/WHprMMLxl0Er5kMuHgOdpPwHWnpIG7GZ6wDW7pcbJ+Aq+4afXS
         xm6hnhLojQhUv6wOJKVIRTZam2OEH4ju+idt4MaM6gYgNh6C0Fydz84I8n1FCjonGh5w
         VBmg==
X-Gm-Message-State: AOAM532c0KQ2rqcbHbEJB7EuNnnwUI3G0N8pnFZFnAxumQ7kYt4rlkv4
        FC/zVVx6X9rdMZZxf+0evxLdVW4hdlteXQQ8dKBtp+y8Vn4=
X-Google-Smtp-Source: ABdhPJy9udHj6nzu22pOqBLPnwZs66/GlQGhCbVmxWtnNB7X5ALYMdJueVzSTk3ss5KeCObWgERR3OdGIti15mvw84c=
X-Received: by 2002:a05:6402:4415:b0:410:d28b:1e14 with SMTP id
 y21-20020a056402441500b00410d28b1e14mr16138852eda.211.1645986566039; Sun, 27
 Feb 2022 10:29:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com>
 <20220223095455.3nlxqkem5y7dsniq@quack3.lan>
In-Reply-To: <20220223095455.3nlxqkem5y7dsniq@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:29:14 -0800
Message-ID: <CAD+ocbxW_sRT4iDe6D0aTpiPxMY3xzZqr4NeiB4cqQ9j=2zbdw@mail.gmail.com>
Subject: Re: [RFC 2/9] ext4: Fix ext4_fc_stats trace point
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
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

Thanks for reporting this Steven and thanks Ritesh for fixing this.

Looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

- Harshad

On Wed, 23 Feb 2022 at 01:54, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:10, Ritesh Harjani wrote:
> > ftrace's __print_symbolic() requires that any enum values used in the
> > symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
> > so that the enum value can be encoded in the ftrace ring buffer.
> >
> > This patch also fixes few other problems found in this trace point.
> > e.g. dereferencing structures in TP_printk which should not be done
> > at any cost.
> >
> > Also to avoid checkpatch warnings, this patch removes those
> > whitespaces/tab stops issues.
> >
> > Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Looks good (modulo Steven's nit). Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
>
> > ---
> >  include/trace/events/ext4.h | 76 +++++++++++++++++++++++--------------
> >  1 file changed, 47 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index 19e957b7f941..17fb9c506e8a 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -95,6 +95,16 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
> >       { FALLOC_FL_COLLAPSE_RANGE,     "COLLAPSE_RANGE"},      \
> >       { FALLOC_FL_ZERO_RANGE,         "ZERO_RANGE"})
> >
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_NOMEM);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_SWAP_BOOT);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RESIZE);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
> > +TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
> > +
> >  #define show_fc_reason(reason)                                               \
> >       __print_symbolic(reason,                                        \
> >               { EXT4_FC_REASON_XATTR,         "XATTR"},               \
> > @@ -2723,41 +2733,49 @@ TRACE_EVENT(ext4_fc_commit_stop,
> >
> >  #define FC_REASON_NAME_STAT(reason)                                  \
> >       show_fc_reason(reason),                                         \
> > -     __entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
> > +     __entry->fc_ineligible_rc[reason]
> >
> >  TRACE_EVENT(ext4_fc_stats,
> > -         TP_PROTO(struct super_block *sb),
> > -
> > -         TP_ARGS(sb),
> > +     TP_PROTO(struct super_block *sb),
> >
> > -         TP_STRUCT__entry(
> > -                 __field(dev_t, dev)
> > -                 __field(struct ext4_sb_info *, sbi)
> > -                 __field(int, count)
> > -                 ),
> > +     TP_ARGS(sb),
> >
> > -         TP_fast_assign(
> > -                 __entry->dev = sb->s_dev;
> > -                 __entry->sbi = EXT4_SB(sb);
> > -                 ),
> > +     TP_STRUCT__entry(
> > +             __field(dev_t, dev)
> > +             __array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)
> > +             __field(unsigned long, fc_commits)
> > +             __field(unsigned long, fc_ineligible_commits)
> > +             __field(unsigned long, fc_numblks)
> > +     ),
> >
> > -         TP_printk("dev %d:%d fc ineligible reasons:\n"
> > -                   "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
> > -                   "num_commits:%ld, ineligible: %ld, numblks: %ld",
> > -                   MAJOR(__entry->dev), MINOR(__entry->dev),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> > -                   FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
> > -                   __entry->sbi->s_fc_stats.fc_num_commits,
> > -                   __entry->sbi->s_fc_stats.fc_ineligible_commits,
> > -                   __entry->sbi->s_fc_stats.fc_numblks)
> > +     TP_fast_assign(
> > +             int i;
> >
> > +             __entry->dev = sb->s_dev;
> > +             for (i = 0; i < EXT4_FC_REASON_MAX; i++)
> > +                     __entry->fc_ineligible_rc[i] =
> > +                     EXT4_SB(sb)->s_fc_stats.fc_ineligible_reason_count[i];
> > +             __entry->fc_commits = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
> > +             __entry->fc_ineligible_commits =
> > +                     EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
> > +             __entry->fc_numblks = EXT4_SB(sb)->s_fc_stats.fc_numblks;
> > +     ),
> > +
> > +     TP_printk("dev %d,%d fc ineligible reasons:\n"
> > +               "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
> > +               "num_commits:%lu, ineligible: %lu, numblks: %lu",
> > +               MAJOR(__entry->dev), MINOR(__entry->dev),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> > +               FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
> > +               __entry->fc_commits, __entry->fc_ineligible_commits,
> > +               __entry->fc_numblks)
> >  );
> >
> >  #define DEFINE_TRACE_DENTRY_EVENT(__type)                            \
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
