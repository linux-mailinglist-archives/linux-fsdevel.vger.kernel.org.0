Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AEC396692
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhEaRLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhEaRJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 13:09:48 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F09C00366F
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:19:00 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id g34so6766841uah.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNltilBZCxZe9ndZGv3YEuGsfBN+sRawj2EzksEgeWg=;
        b=KtjapTzMxSmJ0WXwmWapiKFOcWTFlGwfhXEEp6OgWjsPmSxlrlB+37CiGQFvAtOuk7
         0G2/wUKmx8LvClvh7s3AjghvYB0G7Nz0P49Bk+2JAtiX68mF2sI7GvO3+/JN/wwSPOcg
         hUvopZUSZBgQwt2FE63QBp2EiYSCqzfvDrax4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNltilBZCxZe9ndZGv3YEuGsfBN+sRawj2EzksEgeWg=;
        b=XDZc2jol1Fbr8DmUVC5N0kgUcCj0tkSGC+eIiwWxteaC+rI8SnDuqjYNyE12MPC7by
         laIaXMGNiMShUsvrEfZECr98d2Sv/2Qm3htul5nRNj4peDfOPNbEifWi+uDq1yubJnGT
         61OpAi2TwSPMpV0+YCxpbG2ALDXlr5ugSfdeW7eNJiPQfpkyIJ88iU2O8R+pm06YyR24
         47S1FpkLoldmeY185tthoNBO3Ih6v70AtDaogk/QJYEenXI1Qwd+l8xGGn/6BSgoQ4Om
         8apxSvZ2iPBSIWvKTZkZo3/JEpSuazix0mdp2CFrXGQUfD1lBHOwI4XHjzJI98hUTAl+
         H08Q==
X-Gm-Message-State: AOAM5337D8sU0GhejlF6CZlufpDX09jZTwbMuCE5xlYfQvFR6epDkKsr
        08v6SvVwGVFQDCRwtHR/os5YAYrjkQ9itLtLvju/OJf/Y98=
X-Google-Smtp-Source: ABdhPJwvrtkSbwkPFvA5i7e9osfmP6TxOlHnWxpQ+VqKpH3TnfW6CJQMRstNcRR3WyvrX274nBxxejvuFFqaH+rMBsg=
X-Received: by 2002:a1f:6dc6:: with SMTP id i189mr13672386vkc.19.1622474339475;
 Mon, 31 May 2021 08:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
 <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com> <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 May 2021 17:18:48 +0200
Message-ID: <CAJfpegsqqwMgtDKESNVXvtYU=fsu2pZ_nE8UdXQSLudKqK8Xmw@mail.gmail.com>
Subject: Re: fsnotify events for overlayfs real file
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 May 2021 at 19:56, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, May 18, 2021 at 5:43 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 10 May 2021 at 18:32, Amir Goldstein <amir73il@gmail.com> wrote:

> > > My thinking was that we can change d_real() to provide the real path:
> > >
> > > static inline struct path d_real_path(struct path *path,
> > >                                     const struct inode *inode)
> > > {
> > >         struct realpath = {};
> > >         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
> > >                return *path;
> > >         dentry->d_op->d_real(path->dentry, inode, &realpath);
> > >         return realpath;
> > > }

Real paths are internal, we can't pass them (as fd in permission
events) to userspace.

> > >
> > >
> > > Another option, instead of getting the realpath, just detect the
> > > mismatch of file_inode(file) != d_inode(path->dentry) in
> > > fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
> > > with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.
> > >
> > > For inotify it should be enough and for fanotify it is enough for
> > > FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
> > > so at least permission events listeners can identify the situation and
> > > be able to block access to unknown paths.

That sounds like a good short term solution.


>
> Is there a reason for the fake path besides the displayed path in
> /proc/self/maps?

I'm not aware of any.

>
> Does it make sense to keep one realfile with fake path for mmaped
> files along side a realfile with private/detached path used for all the
> other operations?

This should work, but it would add more open files, so needs some good
justifications.

> While at it, we can also cache both upper and lower realfiles in case
> file was copied up after open.

Right, although this doesn't seem to be an issue (it's a rare corner
case that is being cared for).

Thanks,
Miklos
