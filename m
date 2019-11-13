Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CEFB4E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfKMQWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:22:18 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33037 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKMQWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:22:18 -0500
Received: by mail-yb1-f195.google.com with SMTP id i15so1183151ybq.0;
        Wed, 13 Nov 2019 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrNEKbAI8SdPL4/nZNWweKCBGdbsKNPBi2tTjgkTk4g=;
        b=dr/pD/ndVpnhQ/dq8vwt31HTFhiLecVsaulHcl8WYtV7IlU6Vk6Q2zoGJoZPO0Q9lg
         0kqoeQhbXKNkDNlyDCfM5Z3Q9cdUg3sBTb/ZvKqQ16U/WLseWLg6mWtPTr1ar4clvrqE
         VchRnBOu+R3jh2MGWvvhXAMpI7He3QdrA6ARhAvsIXN850RnNBNxcmbIzsveOg2oiLU8
         yX4SglKyPb6phah2sZi9ZCKd6Jvf/R9rRPSifGYwYz2gkkO7sqxW9A1QBw6lW4Szd5L8
         CUJSn1m/GKcc4aE1TYmjvsEbUsvDxirufa2cE++pM2XjuQL6VkBhpB2/xipSCRqXh/oD
         hqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrNEKbAI8SdPL4/nZNWweKCBGdbsKNPBi2tTjgkTk4g=;
        b=PJO8V9D9d1s62Dkt1SL2YOXmYcaFc8zYrf70KuUDK5Rio2Txj0XbVvAQ5BU6Em5gSL
         9RAIh+sdu96PRwJVf+3CfBiVL3R9MSUyMPQJtHd4wVQybrkpw9NWhRG2nqZy91MDplwu
         7JBJhdHoqN58mAXeEUwWs99nM7KA3nLS9yhEJ4+TgguiMmSHbWdOXr3DpRxAAkbb8xEf
         lhiY0jcMx4EmJAQ/TNGTiQhErUQckeXgjR3Qa5Idn7Yl4xJNmGYjSMU9F3SSh6xxMc+W
         YKJm9b1nSqWzYu0qxCjmIRTr0ydM7EB1RrwFN1SjY4T0NxIOY7JYnISaUmiTWSbt3Owp
         E+9A==
X-Gm-Message-State: APjAAAX8A8BQ85yCXfaS0bW7q14I82qOTnIlw4DKxsPfZo5A+84a/kgN
        80esdLRsQLhNqGWCdXf7nLf1Yekv30DGGuyKvRo=
X-Google-Smtp-Source: APXvYqzf53BzBYGwZQWzU7OdbtYI8t2gX4zwRnBJBC0//jpJ443Zjiuag9Mi5MgK7DtkD9rouz5Qh4pH5DLzKHfS9xk=
X-Received: by 2002:a25:383:: with SMTP id 125mr3323615ybd.45.1573662136812;
 Wed, 13 Nov 2019 08:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20191022143736.GX26530@ZenIV.linux.org.uk> <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com> <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72> <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk> <20191103182058.GQ26530@ZenIV.linux.org.uk>
 <20191103185133.GR26530@ZenIV.linux.org.uk> <CAOQ4uxiHH=e=Y5Xb3bkv+USxE0AftHiP935GGQEKkv54E17oDA@mail.gmail.com>
 <20191113125216.GF26530@ZenIV.linux.org.uk>
In-Reply-To: <20191113125216.GF26530@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Nov 2019 18:22:05 +0200
Message-ID: <CAOQ4uxifKE2sJE=tCUj3qHFim8xXiwcdf-ugb3_tpHbmm5YnZw@mail.gmail.com>
Subject: Re: [PATCH][RFC] ecryptfs_lookup_interpose(): lower_dentry->d_inode
 is not stable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, wugyuan@cn.ibm.com,
        Jeff Layton <jlayton@kernel.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Nov 13, 2019 at 09:01:36AM +0200, Amir Goldstein wrote:
> > > -       if (d_really_is_negative(lower_dentry)) {
> > > +       /*
> > > +        * negative dentry can go positive under us here - its parent is not
> > > +        * locked.  That's OK and that could happen just as we return from
> > > +        * ecryptfs_lookup() anyway.  Just need to be careful and fetch
> > > +        * ->d_inode only once - it's not stable here.
> > > +        */
> > > +       lower_inode = READ_ONCE(lower_dentry->d_inode);
> > > +
> > > +       if (!lower_inode) {
> > >                 /* We want to add because we couldn't find in lower */
> > >                 d_add(dentry, NULL);
> > >                 return NULL;
> >
> > Sigh!
> >
> > Open coding a human readable macro to solve a subtle lookup race.
> > That doesn't sound like a scalable solution.
> > I have a feeling this is not the last patch we will be seeing along
> > those lines.
> >
> > Seeing that developers already confused about when they should use
> > d_really_is_negative() over d_is_negative() [1] and we probably
> > don't want to add d_really_really_is_negative(), how about
> > applying that READ_ONCE into d_really_is_negative() and
> > re-purpose it as a macro to be used when races with lookup are
> > a concern?
>
> Would you care to explain what that "fix" would've achieved here,
> considering the fact that barriers are no-ops on UP and this is
> *NOT* an SMP race?
>
> And it's very much present on UP - we have
>         fetch ->d_inode into local variable
>         do blocking allocation
>         check if ->d_inode is NULL now
>         if it is not, use the value in local variable and expect it to be non-NULL
>
> That's not a case of missing barriers.  At all.  And no redefinition of
> d_really_is_negative() is going to help - it can't retroactively affect
> the value explicitly fetched into a local variable some time prior to
> that.
>

Indeed. I missed that part of your commit message and didn't
realize the variable was being used later.
The language in the comment "can go positive under us" implied
SMP race so I misunderstood the reason for READ_ONCE().

Sorry for the noise.

Amir.
