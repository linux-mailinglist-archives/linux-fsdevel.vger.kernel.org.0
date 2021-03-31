Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061403508A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 23:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCaVAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaU7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:59:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A6BC061574;
        Wed, 31 Mar 2021 13:59:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r193so21559029ior.9;
        Wed, 31 Mar 2021 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDePH94ANbIKMvd2G9i+SiGf3YdKE6IhV3WRRwhTQ1M=;
        b=IWVmeOX7iQ92y8O8c9eV9GaxSvV3dCj3ZN7HutzBKfjOOhftW5H/akJxbGAyBO6Jhx
         U8sL1ZkcBMsG3nafESvHhNBcjS0U5H5uR7xmz/tBjCZBLEZpAzz1YU2Pq6GQ0zSCUSot
         xMeUQikPM8H0gM+zN7c6xNsSams3r+TsJlLSuL9qT8SrbNeQYf4B4JxZ6LzX1k5kX7jH
         zj0Sdenp5O6QpTvfsatlSN1m/K1+YvbxytG+YQLMZ/TNW0RplPMSJT+yXc8KKGNgwhzR
         03LVNfOgvkM/Hc4fz9nA5UpjiOIcHoJAoDKJyot2VUBlBHDqT0VBkFKlg7fF/sqO1hao
         XW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDePH94ANbIKMvd2G9i+SiGf3YdKE6IhV3WRRwhTQ1M=;
        b=jbrgicEFwT8NVePtZm7tVvSjgusrGkDvpYxFzPq8t6xoODZZBUCBEbyYeyUw6KtPdL
         WgsYjh5T42V7XZl7InmcmXaCIv4ymvSKLlE94qjdAJ8IPPQz79ePo+pkCojwrss/kj6Z
         3QnKCKC3Nl7hu78OADRsoAra4PhUnVdzwtndkosHjTZvudJU29jS2LoW4F6afIqdggYY
         zfLQbSHSvoocQA26NV4gMu0CN6zHrGIswBm7DAS8JwvUsqqfSqKThQZwRpd4vyh11Fw1
         0iOY9hIswGYWE+5EW9on8CFALFas59/vg30mHetyPlwFCuAsMv+V9tV+GrGCuHc37LQK
         ZAKQ==
X-Gm-Message-State: AOAM532U5Geu+WfutNYD4VknqjQ7js1r4IXMYf9oYZI6c61RbPNYQE9m
        xl83owEl1DZ1tD8lYHuCEBmPetCtEXCYpJLnyqImJP13
X-Google-Smtp-Source: ABdhPJxIRn/hz6bIJY2N1JLMT3DvVU+rzVUIX9bv1z5L1rhkmLldjjpuxnWvCk8ww6Dwn1kRZoymkY+VSflwd0Soe+g=
X-Received: by 2002:a05:6602:2596:: with SMTP id p22mr3826886ioo.186.1617224378554;
 Wed, 31 Mar 2021 13:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 31 Mar 2021 23:59:27 +0300
Message-ID: <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > As long as "exp_export: export of idmapped mounts not yet supported.\n"
> > > I don't think it matters much.
> > > It feels like adding idmapped mounts to nfsd is on your roadmap.
> > > When you get to that we can discuss adding fsnotify path hooks to nfsd
> > > if Jan agrees to the fsnotify path hooks concept.
> >
> > I was looking at the patch and thinking about it for a few days already. I
> > think that generating fsnotify event later (higher up the stack where we
> > have mount information) is fine and a neat idea. I just dislike the hackery
> > with dentry flags.
>
> Me as well. I used this hack for fast POC.
>
> If we stick with the dual hooks approach, we will have to either pass a new
> argument to vfs helpers or use another trick:
>
> Convert all the many calls sites that were converted by Christian to:
>    vfs_XXX(&init_user_ns, ...
> because they do not have mount context, to:
>    vfs_XXX(NULL, ...
>
> Inside the vfs helpers, use init_user_ns when mnt_userns is NULL,
> but pass the original mnt_userns argument to fsnotify_ns_XXX hooks.
> A non-NULL mnt_userns arg means "path_notify" context.
> I have already POC code for passing mnt_userns to fsnotify hooks [1].
>
> I did not check if this assumption always works, but there seems to
> be a large overlap between idmapped aware callers and use cases
> that will require sending events to a mount mark.
>

The above "trick" is pretty silly as I believe Christian intends
to fix all those call sites that pass init_user_ns.

> > Also I'm somewhat uneasy that it is random (from
> > userspace POV) when path event is generated and when not (at least that's
> > my impression from the patch - maybe I'm wrong). How difficult would it be
> > to get rid of it? I mean what if we just moved say fsnotify_create() call
> > wholly up the stack? It would mean more explicit calls to fsnotify_create()
> > from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
> > ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,
>
> 1. I don't think we can do that for all the fsnotify_create() hooks, such as
>     debugfs for example
> 2. It is useless to pass the mount from overlayfs to fsnotify, its a private
>     mount that users cannot set a mark on anyway and Christian has
>     promised to propose the same change for cachefiles and ecryptfs,
>     so I think it's not worth the churn in those call sites
> 3. I am uneasy with removing the fsnotify hooks from vfs helpers and
>     trusting that new callers of vfs_create() will remember to add the high
>     level hooks, so I prefer the existing behavior remains for such callers
>

So I read your proposal the wrong way.
You meant move fsnotify_create() up *without* passing mount context
from overlayfs and friends.

So yeh, I do think it is manageable. I think the best solution would be
something along the lines of wrappers like the following:

static inline int vfs_mkdir(...)
{
        int error = __vfs_mkdir_nonotify(...);
        if (!error)
                fsnotify_mkdir(dir, dentry);
        return error;
}

And then the few call sites that call the fsnotify_path_ hooks
(i.e. in syscalls and perhaps later in nfsd) will call the
__vfs_xxx_nonotify() variant.

I suppose that with this approach I could make all the relevant events
available for mount mark with relatively little churn.
I will try it out.

Thanks,
Amir.
