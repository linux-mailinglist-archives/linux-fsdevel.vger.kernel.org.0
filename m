Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023954C5E2C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiB0SdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiB0SdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:33:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB75FC9;
        Sun, 27 Feb 2022 10:32:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bq11so14569258edb.2;
        Sun, 27 Feb 2022 10:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TZp34KgRQjyVlG9WRiwZuTYoOOo5zR7Yrl4AzfTbuY=;
        b=LLK3kHkYFU4RecBw2W0N/+jGvQv5W1YQGaP0temkCwFNAcqlUVEThTeYukFXPYoQDE
         jr0WYP0yPYhBfHDDUESI4xUrC9OcGhBQnvv0PjnEK5wtOWXMl4+fX2sEIjg+aappUjBS
         3Y30KXdOeaFA4ppb4lJFZiJcZfcOwqXRuIQcBiOOnHay7REtX1pQUBfjhOYgJ/75xXdT
         OYJ1Q5i2NyCKzRbhlDvF8V+wN1Qf7iVuHLVAlSDKIzG9IbiKcQs+W3QuxENwchwji/rN
         CCAxn/45Flie7GiipjmoQyeFVHT4J8c0iGn/KCRe45z4kuNYV4kdi7NRccVGFU//A3TY
         hq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TZp34KgRQjyVlG9WRiwZuTYoOOo5zR7Yrl4AzfTbuY=;
        b=OK04V/0s+4QvemfLPr6jsPaUzR7iedPRSktakbNmGuBYxMeP3eximEzpsuWageJHnX
         OHwTU5sJeWQ+JjJOUn7bU+wmgOZruCy7+BveDeCRGGEZA5daO1ftSWC0r8cC/30JRYx/
         lTzrx+0dlX8dviIphS6HnkcNbTQgpm/kfXzkCar6fvK/SY23jgkgCjfQRMBbMaPMVQ/k
         y/UlvcF7Zed+pVF+nEe/6FXHbMDJ+CoSbuAfiJhNmYtaoSo89kRRMoV2dnB0RMwpa7Wx
         tdQUPLauAKLfdDBPb7QQmm0+FBQkOD+6Ds3Fe3dH1BskUYbJt0D1G26YPYj5ZE40fmZ4
         BXYg==
X-Gm-Message-State: AOAM531Sx5/Ww0UArZ8fVcieMnTcyhPO6vRA7S3a5lTjPxr2YR7iUGoz
        RcD+nEaD3nbbiAH8S/LB3m00GCFqB5JrX6eg7Ew=
X-Google-Smtp-Source: ABdhPJyHUNfpwOsKi0aeKxcTx+/bopy6WwoASD8Tb/1xc3wyuuUiVdE2nPEFSzUYMnWatsebuBvzL6lZke9z+ZvjEsE=
X-Received: by 2002:aa7:daca:0:b0:410:d02a:1bf3 with SMTP id
 x10-20020aa7daca000000b00410d02a1bf3mr16547217eds.455.1645986760526; Sun, 27
 Feb 2022 10:32:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <9cc1f9ac12ff3dca6b0c18d0bda2245a1264595e.1645558375.git.riteshh@linux.ibm.com>
 <20220223094509.asn3e4dcgs5fokeo@quack3.lan>
In-Reply-To: <20220223094509.asn3e4dcgs5fokeo@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:32:29 -0800
Message-ID: <CAD+ocbwL6jCtUgqjp5VzLkyab6wZurF=cCB9ZJOawJaejJv32A@mail.gmail.com>
Subject: Re: [RFC 7/9] ext4: Fix remaining two trace events to use same printk convention
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

On Wed, 23 Feb 2022 at 01:45, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:15, Ritesh Harjani wrote:
> > All ext4 & jbd2 trace events starts with "dev Major:Minor".
> > While we are still improving/adding the ftrace events for FC,
> > let's fix last two remaining trace events to follow the same
> > convention.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> OK. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  include/trace/events/ext4.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > index 6e66cb7ce624..233dbffa5ceb 100644
> > --- a/include/trace/events/ext4.h
> > +++ b/include/trace/events/ext4.h
> > @@ -2653,7 +2653,7 @@ TRACE_EVENT(ext4_fc_replay_scan,
> >               __entry->off = off;
> >       ),
> >
> > -     TP_printk("FC scan pass on dev %d,%d: error %d, off %d",
> > +     TP_printk("dev %d,%d error %d, off %d",
> >                 MAJOR(__entry->dev), MINOR(__entry->dev),
> >                 __entry->error, __entry->off)
> >  );
> > @@ -2679,7 +2679,7 @@ TRACE_EVENT(ext4_fc_replay,
> >               __entry->priv2 = priv2;
> >       ),
> >
> > -     TP_printk("FC Replay %d,%d: tag %d, ino %d, data1 %d, data2 %d",
> > +     TP_printk("dev %d,%d: tag %d, ino %d, data1 %d, data2 %d",
> >                 MAJOR(__entry->dev), MINOR(__entry->dev),
> >                 __entry->tag, __entry->ino, __entry->priv1, __entry->priv2)
> >  );
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
