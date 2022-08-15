Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60B5929EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 08:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbiHOG4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 02:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiHOG4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:56:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6410FD8
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Aug 2022 23:56:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f22so8486610edc.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Aug 2022 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xfuWih8OGtuPchez4/jI35lWey8+BV3ol1i7mr1x4Xk=;
        b=dS+8MjXNRpFnjmHW4vCUuM9jycNpys9FqOJxdaDRL71ocx+6dhP8VF+kiKdTmsRtts
         bP5Eije/gjXrKBFL8XVxzvBncrpIVEFOoqbk6PPvm/6yVPEyOm8OetDwEz+ogZMdjwC8
         uQ3M8C/GY4rh2onx751eAqz2Hxu20b2jgIBezVih43nSbDHsBppmr2GxRoz/uVUFtoZG
         Ol5nq3iQ4XWRhNAx2HtcsO5D29RH/YkgOFiQhQoE/KrG3T4wLqUxgiz/fnLzL7lhSEQ6
         YyMkO+DL8Fh6q88/FITeeoNS6GoBo6TZ7YvModcy9Gy2MWvrA+RfwPd2xdURA5BvAGx9
         zaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xfuWih8OGtuPchez4/jI35lWey8+BV3ol1i7mr1x4Xk=;
        b=q63PwQPWIp8hvPVYFiEHr2DfiCxZRsbXVQeCZZbQ6SCEMbRlyOhzxsKJgzcdG9KT3x
         +McSqXyKpnwYSua1BJpqMDtfZiEjJ9YaxGrMJv2uFfHIdrAwh0HlHNdxQRKzvbyOg68a
         FBYk5+NDOOpA/9UAL9XIfyOv/idmbhYGqyaAavSowqgeN5dAzxoJ+By+WmYELUArehku
         l6rijurV1OFxhtzbRc2WaVaHQvsXAQ3P31QXS82se6UZX0nLvPxUQZAD4Rghur/ocPgl
         5b0RTGsEZmNRLpewnEhvVgZjezHJFksOk1XpmayoR99+48nBupD9jXVx1hExFc8Mc0Pz
         8kMQ==
X-Gm-Message-State: ACgBeo1rSk5X9QxZ+JmozmO6NQnpdzXBgQ0jUMP4ouUj9rxhcDWdwNqB
        XpC0FFPNoBjwVfZoR7xe6gHKZh8pJFxPz26bGURpWFEDisk=
X-Google-Smtp-Source: AA6agR7Y3GMgPyqc+1zn0WED0kZ6nxpMd2XtlQlXs8g6cYGh9F61ecGdSWckp72LJ+MjmzaJaKYji8qmJIb3ygjSXgc=
X-Received: by 2002:aa7:d8c6:0:b0:43d:b0a1:5266 with SMTP id
 k6-20020aa7d8c6000000b0043db0a15266mr13158780eds.164.1660546588703; Sun, 14
 Aug 2022 23:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <YvYhuH66yfoi8Zxy@autolfshost> <db024202-93f1-7a58-970e-3565dc58c760@infradead.org>
In-Reply-To: <db024202-93f1-7a58-970e-3565dc58c760@infradead.org>
From:   Anup Parikh <parikhanupk.foss@gmail.com>
Date:   Mon, 15 Aug 2022 12:25:51 +0530
Message-ID: <CAH6MFJH1qOvwtDXVAor3J6Cqtd-Fw_dFBiDPk3scHVndsZU_pQ@mail.gmail.com>
Subject: Re: [PATCH] Doc fix for dget_dlock and dget
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org
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

Hello Mr. Randy Dunlap,

I sent the patch as suggested. Thanks.

Regards,
Anup K Parikh.

On Sat, Aug 13, 2022 at 7:14 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 8/12/22 02:47, Anup K Parikh wrote:
> > 1. Remove a warning for dget_dlock
> >
> > 2. Add a similar comment for dget and
> >    add difference between dget and dget_dlock
> >    as suggested by Mr. Randy Dunlap
> >
> > Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
>
> Is Shuah going to merge this patch? I wouldn't expect that,
> so please see Documentation/process/submitting-patches.rst:
> "Select the recipients for your patch" and send the patch to
> the appropriate maintainer(s) as well as the linux-fsdevel
> mailing list.
>
> Thanks.
>
> > ---
> >  include/linux/dcache.h | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > index f5bba5148..c7742006a 100644
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -297,12 +297,15 @@ extern char *dentry_path(const struct dentry *, char *, int);
> >  /* Allocation counts.. */
> >
> >  /**
> > - *   dget, dget_dlock -      get a reference to a dentry
> > - *   @dentry: dentry to get a reference to
> > + * dget_dlock - get a reference to a dentry
> > + * @dentry: dentry to get a reference to
> >   *
> > - *   Given a dentry or %NULL pointer increment the reference count
> > - *   if appropriate and return the dentry. A dentry will not be
> > - *   destroyed when it has references.
> > + * Given a dentry or %NULL pointer increment the reference count
> > + * if appropriate and return the dentry. A dentry will not be
> > + * destroyed when it has references.
> > + *
> > + * The reference count increment in this function is not atomic.
> > + * Consider dget() if atomicity is required.
> >   */
> >  static inline struct dentry *dget_dlock(struct dentry *dentry)
> >  {
> > @@ -311,6 +314,17 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
> >       return dentry;
> >  }
> >
> > +/**
> > + * dget - get a reference to a dentry
> > + * @dentry: dentry to get a reference to
> > + *
> > + * Given a dentry or %NULL pointer increment the reference count
> > + * if appropriate and return the dentry. A dentry will not be
> > + * destroyed when it has references.
> > + *
> > + * This function atomically increments the reference count.
> > + * Consider dget_dlock() if atomicity is not required or manually managed.
> > + */
> >  static inline struct dentry *dget(struct dentry *dentry)
> >  {
> >       if (dentry)
>
> --
> ~Randy
