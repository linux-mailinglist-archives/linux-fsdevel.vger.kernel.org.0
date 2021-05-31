Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA13967F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhEaS2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhEaS2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 14:28:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E0C061574;
        Mon, 31 May 2021 11:26:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d25so12762329ioe.1;
        Mon, 31 May 2021 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtUnQZW7bRjMT039SX5ANZIfTgVGr53nsBKLCQdK8o4=;
        b=qDvTon3hQb/Oqz0dDaTDFR0ikgo4my7j7/kwmUUj2JRXJnF0FpFk6ZSYHw0rowrVLI
         QGrurepkp6LTpsU1/oeskLg0dC0dlNIVf0/m5f5yOosMKXEGyTC1udKzfMELwMFRJv2+
         E0ZjAqyWqQpwKfLs5R4CnrWRqjjlOzi3KZk9Cp4yXcmp7cl6nb+qEMt/AwnAUuMhLHmr
         zwZ6EPoUIVsJGDzGWy6XY3Afz9aKcWSV4BFrGTkjE4bXW0i35GVmwsq+uU7cAIInRgBB
         2sREnHvDJVrINtaAeP1vvqhvBeP8SXy3GLBHYN1ajc4VHfHPFhMxTy3GXN6wzZRYpQuX
         wNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtUnQZW7bRjMT039SX5ANZIfTgVGr53nsBKLCQdK8o4=;
        b=lOUIdSnFAIgeuKPLaQ/vwkiku9UGII8TiBaRh8My8q3NeuH/J9Yj4I40lIa10RYEqz
         ECGpEcJfPE/uYoUK5VjkNFPXyxE1YClajj8PHCID5L3whNtns3WIgyXwpqpBA+diejFk
         UpSZNG626nvMVufY3BFLqIeSfho8HtafzwpLbF4w1LHQ+DGKndQMT2M7XKnq0ykd8vPU
         EVXGP7LEdyXF2Sy5MT/9Q0+9Tr4Ir703iRWVfPR3MNt6iZzp4EOSRnVK/V/g/y1cyqno
         O2Wop5LGNjgQOTmGHNE2ZrcwZNuaENVTzN1kEKtR9rFV/ZJ4PqhTVgXrBR1E/sTmEC/5
         Y3Rg==
X-Gm-Message-State: AOAM532qc9fzjerSZhG3/2y3GoNeAhJc84w8YjyAP7D3K4IYI4c5knFF
        ZDtyuqMWVItni045T7CRj/arqUibrqkUsmSE4Co=
X-Google-Smtp-Source: ABdhPJzrqkvGj+piMxEIazwibZb3HsNyAN1w9XsrTcs7ll9vs6r9IUsYA8dXjkhHGGprFA7at5U+TYbOdoe+JrPGqwE=
X-Received: by 2002:a02:908a:: with SMTP id x10mr21293379jaf.30.1622485607327;
 Mon, 31 May 2021 11:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
 <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
 <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com> <CAJfpegsqqwMgtDKESNVXvtYU=fsu2pZ_nE8UdXQSLudKqK8Xmw@mail.gmail.com>
In-Reply-To: <CAJfpegsqqwMgtDKESNVXvtYU=fsu2pZ_nE8UdXQSLudKqK8Xmw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 May 2021 21:26:35 +0300
Message-ID: <CAOQ4uxiYZfQSZN4avfnNmQv1OxB5+Q=9wr-eSRXK+QkostC66w@mail.gmail.com>
Subject: Re: fsnotify events for overlayfs real file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Marko Rauhamaa <marko.rauhamaa@f-secure.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 6:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 18 May 2021 at 19:56, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, May 18, 2021 at 5:43 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 10 May 2021 at 18:32, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > My thinking was that we can change d_real() to provide the real path:
> > > >
> > > > static inline struct path d_real_path(struct path *path,
> > > >                                     const struct inode *inode)
> > > > {
> > > >         struct realpath = {};
> > > >         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
> > > >                return *path;
> > > >         dentry->d_op->d_real(path->dentry, inode, &realpath);
> > > >         return realpath;
> > > > }
>
> Real paths are internal, we can't pass them (as fd in permission
> events) to userspace.
>
> > > >
> > > >
> > > > Another option, instead of getting the realpath, just detect the
> > > > mismatch of file_inode(file) != d_inode(path->dentry) in
> > > > fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
> > > > with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.
> > > >
> > > > For inotify it should be enough and for fanotify it is enough for
> > > > FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
> > > > so at least permission events listeners can identify the situation and
> > > > be able to block access to unknown paths.
>
> That sounds like a good short term solution.
>

It may be a fine academic solution, but I don't think it solves any real
world problem.
I am not aware of any security oriented solutions that use permission
events on inode or directory (let alone sb).

The security oriented users of fanotify are anti-virus on-access
protection engines and those are using mount marks anyway
(dynamically adding them as far as I know).
[cc Marko who may be able to shed some light]

For those products, creating a bind mount inside a new mount ns
may actually escape the on-access policy or the new mount will
also be marked I am not sure. I suppose cloning mount ns may be
prohibited by another LSM or something(?).

>
> >
> > Is there a reason for the fake path besides the displayed path in
> > /proc/self/maps?
>
> I'm not aware of any.
>
> >
> > Does it make sense to keep one realfile with fake path for mmaped
> > files along side a realfile with private/detached path used for all the
> > other operations?
>
> This should work, but it would add more open files,

True, but only for the mmaped files.

> so needs some good justifications.
>

I'm afraid I don't have one yet..
Let's see what the AV vendors have to say.

Thanks,
Amir.
