Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4205B4C5E30
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiB0SgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0SgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:36:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FA46669;
        Sun, 27 Feb 2022 10:35:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx21so20605688ejb.13;
        Sun, 27 Feb 2022 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2d9/4dkN8Ga7N6Pg0fsTvmJzid5qlHgPkrPf48UlKY=;
        b=Wmr2cbckQqdefsbRJsktXOSqq8FlkTJ/sMC0h0wnW5b6u+6Bx667jFs9vPQQ/FnroI
         Mavd03H1FibbboUqF/1x3n3KQ+86ak6wVioJjJ9BrPW/MnYk3Fms4gtnh5cvM1ZPkl9x
         9CO5A3rYqxircLPWCzaLDYwUXVP6VxdgmeLYoZ+sw2VI4+GHy7nsZc12oKjkIOsvFmzp
         8R5q3yxx8IjnWpbVdkh17/rXYSjC5SN5g22/5G2/RpcIDjlvOyQMhLuNXbjb5DWgMhm8
         zCqt1sACj1kPh8BEuulDNCYcRnIhWxWniZq/VS4WDx4ngIjGgePx1EgsWtBkOht8wMLz
         VXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2d9/4dkN8Ga7N6Pg0fsTvmJzid5qlHgPkrPf48UlKY=;
        b=eA5PkKHzU85Tly/9e/pcOGclGTFmbb0kRUaNyzt8g+FKEbyDkod2VeKg3M2ydO3t96
         61LLz1dUZynY6LViWqMJGgV/ihQQ02tmM0Tc4JfYd0mJ604Of4+Iwu7TcXr4WNA7CbYe
         w0QvPVU2gUHTnzXbwWtQE9mGNiMgF6l8xbw+hcdzJmqRwWo+XnNWshDTmU7kE2aUIn8N
         4LcYTxekPH0NhAebyRMCgZUk51syN5TX54OktWpjlyN5GjWnrwah9NzcpEz/zVp2Uojz
         O8Tqelh4LBmi/vvndX7DoUL0ApvTzGOsUkRXGCKJ3keLH0PGo515h/bCeG3br3gtUZ0K
         A2Og==
X-Gm-Message-State: AOAM5334c0I6cj8p9ehJF9nPQSnG8jLpol2+rnFBa/ot/+tZRawT7Q2h
        R4VtfX7tMg1BsGpgu79LEnscd2Q0Tf3lEYPNZ7Q=
X-Google-Smtp-Source: ABdhPJyZWdawHC1sy9+qyy/et2qc3Bynu89CH87D3JYSeqvZ5yLOMSjVwR4o/N9Vl/7I4wE/8/CA3TUlzL0O8H7q63U=
X-Received: by 2002:a17:907:b590:b0:6c1:c061:d945 with SMTP id
 qx16-20020a170907b59000b006c1c061d945mr12462095ejc.768.1645986942749; Sun, 27
 Feb 2022 10:35:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <bf55f9a22a67f8619ffe5f1af47bebb43f5ed372.1645558375.git.riteshh@linux.ibm.com>
 <20220223094934.wfcmceilhjtnbxjq@quack3.lan>
In-Reply-To: <20220223094934.wfcmceilhjtnbxjq@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:35:31 -0800
Message-ID: <CAD+ocby2Z7AS+5x_AKswpzeSezpoQBp9DHLu+n9jR5P7ZRBWWg@mail.gmail.com>
Subject: Re: [RFC 8/9] ext4: Convert ext4_fc_track_dentry type events to use
 event class
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

Nice! Thanks for fixing this.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


- Harshad

On Wed, 23 Feb 2022 at 01:49, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:16, Ritesh Harjani wrote:
> > One should use DECLARE_EVENT_CLASS for similar event types instead of
> > defining TRACE_EVENT for each event type. This is helpful in reducing
> > the text section footprint for e.g. [1]
> >
> > [1]: https://lwn.net/Articles/381064/
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
> >  include/trace/events/ext4.h | 57 +++++++++++++++++++++----------------
> >  1 file changed, 32 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index 233dbffa5ceb..33a059d845d6 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -2783,33 +2783,40 @@ TRACE_EVENT(ext4_fc_stats,
> >                 __entry->fc_numblks)
> >  );
> >
> > -#define DEFINE_TRACE_DENTRY_EVENT(__type)                            \
> > -     TRACE_EVENT(ext4_fc_track_##__type,                             \
> > -         TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
> > -                                                                     \
> > -         TP_ARGS(inode, dentry, ret),                                \
> > -                                                                     \
> > -         TP_STRUCT__entry(                                           \
> > -                 __field(dev_t, dev)                                 \
> > -                 __field(int, ino)                                   \
> > -                 __field(int, error)                                 \
> > -                 ),                                                  \
> > -                                                                     \
> > -         TP_fast_assign(                                             \
> > -                 __entry->dev = inode->i_sb->s_dev;                  \
> > -                 __entry->ino = inode->i_ino;                        \
> > -                 __entry->error = ret;                               \
> > -                 ),                                                  \
> > -                                                                     \
> > -         TP_printk("dev %d:%d, inode %d, error %d, fc_%s",           \
> > -                   MAJOR(__entry->dev), MINOR(__entry->dev),         \
> > -                   __entry->ino, __entry->error,                     \
> > -                   #__type)                                          \
> > +DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
> > +
> > +     TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),
> > +
> > +     TP_ARGS(inode, dentry, ret),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(dev_t, dev)
> > +             __field(int, ino)
> > +             __field(int, error)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->dev = inode->i_sb->s_dev;
> > +             __entry->ino = inode->i_ino;
> > +             __entry->error = ret;
> > +     ),
> > +
> > +     TP_printk("dev %d,%d, inode %d, error %d",
> > +               MAJOR(__entry->dev), MINOR(__entry->dev),
> > +               __entry->ino, __entry->error
> >       )
> > +);
> > +
> > +#define DEFINE_EVENT_CLASS_TYPE(__type)                                      \
> > +DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,           \
> > +     TP_PROTO(struct inode *inode, struct dentry *dentry, int ret),  \
> > +     TP_ARGS(inode, dentry, ret)                                     \
> > +)
> > +
> >
> > -DEFINE_TRACE_DENTRY_EVENT(create);
> > -DEFINE_TRACE_DENTRY_EVENT(link);
> > -DEFINE_TRACE_DENTRY_EVENT(unlink);
> > +DEFINE_EVENT_CLASS_TYPE(create);
> > +DEFINE_EVENT_CLASS_TYPE(link);
> > +DEFINE_EVENT_CLASS_TYPE(unlink);
> >
> >  TRACE_EVENT(ext4_fc_track_inode,
> >           TP_PROTO(struct inode *inode, int ret),
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
