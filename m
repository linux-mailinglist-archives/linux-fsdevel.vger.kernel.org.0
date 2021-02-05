Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD6311541
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhBEW0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhBEOV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:21:57 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B4C0617A9
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 07:59:51 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id t23so733524vsk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+hzPa1F4JAM47t70Roqcz7crnnubahY7MUE4gPkyOc=;
        b=kJkmysqYHrZGs3+fpupO+SdH0WNgec3k/1YXBLzsjRhwhvSzX5Id9iqPsT171m5O6c
         Mosq/QNbyUac50Z0p0hPlSQJc7vKSAqT8m9NZF4kzwxa8D+zV80lXgcCOtu1PBc7ooW3
         VAN8E3DhnankzQz81VQF9GJoXXeBaUWnPRd0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+hzPa1F4JAM47t70Roqcz7crnnubahY7MUE4gPkyOc=;
        b=qDY3myIb0gkQD8h0gQNXqrzZkDMOmkKiPzfmQsLZGC/uGbCAj90SrFdlTa6EJ51l6G
         kvtm0a4pNj+2r0LccFzE/CXggJw+jguV7hbVpfo5FrS88u6M5rXWDdNiHTWftzVfnLw6
         FpYzAlZpHwNTmduTlfRCuBrlxdZN50ow4miazJzNaBx0wakmcm8u5QdkXp9BLAdeUBwK
         UWX3s1r6eZQKH7WHhY6K1fFErhd9Tf+lKgPoxZHpkbeFyHeyP5Cpu1WTrl8AtccjwMmB
         cr3ofcm0TKKibGiUy2ulBaYj6YgiYIx01G4grEDpD6oTpAHf0UWSxQKPwnB+TY4q3nIc
         gBOg==
X-Gm-Message-State: AOAM532yVPPYZ6ostusWlOGZEl23IJK0u9byDkKblKbY2NFJyemqXOxr
        UiPhzAx+GvQg/bBsT6tQCcHmAOjwnwZfD3TYkgnfNJ1lgdE=
X-Google-Smtp-Source: ABdhPJxeWoZ0wWAybWqnxwlr/rJLeHQZqg86VDmAb37maDIyniFgAsX0Q0wwTZ+XuU8gjne6pl4QDillngq5h96qu6U=
X-Received: by 2002:a67:c992:: with SMTP id y18mr3353078vsk.7.1612538917519;
 Fri, 05 Feb 2021 07:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-4-mszeredi@redhat.com>
 <20210204234211.GB52056@redhat.com> <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
In-Reply-To: <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Feb 2021 16:28:26 +0100
Message-ID: <CAJfpegvxb9bfbBpoa6R8UENwL9m6BSU84kr50PBSssUJYc8wFQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] ovl: stack miscattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Feb 5, 2021 at 12:49 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> > > +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > > +{
> > > +     struct inode *inode = d_inode(dentry);
> > > +     struct dentry *upperdentry;
> > > +     const struct cred *old_cred;
> > > +     int err;
> > > +
> > > +     err = ovl_want_write(dentry);
> > > +     if (err)
> > > +             goto out;
> > > +
> > > +     err = ovl_copy_up(dentry);
> > > +     if (!err) {
> > > +             upperdentry = ovl_dentry_upper(dentry);
> > > +
> > > +             old_cred = ovl_override_creds(inode->i_sb);
> > > +             /* err = security_file_ioctl(real.file, cmd, arg); */
> >
> > Is this an comment intended?
>
> I don't remember, but I guess not.  Will fix and test.

Sorry, yes, problem is that there's no file pointer available at this point.

Fix is probably to introduce security_inode_miscattr_perm() hook.

Thanks,
Miklos
