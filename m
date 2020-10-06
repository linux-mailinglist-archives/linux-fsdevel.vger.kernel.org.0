Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3A284657
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJFGx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 02:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFGx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:53:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F13C0613A7;
        Mon,  5 Oct 2020 23:53:26 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id d66so392959ill.0;
        Mon, 05 Oct 2020 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0+dp4f3ePtjH+bvz+fgSMrbzLb2G05YyXJcIAi4CoM=;
        b=tIspH0Wvzoky/Yo8C9WKQ/cq6Q2KSVKQ814aQl/tzXcgMq7/nX7W0oxmfTlKSxhR5g
         I0c0nX8JdqwIakcIruSrwMU7zEt3NXlm8MjmB5HU/tGuklfcQS6zW9F21wql6umjSUSk
         uWL8pxjFyJds9IkEENhyaiSqiR25a0ZMgbK6BaE7CP/NrjbreQ3FL2DMAlWd3d1r7LO1
         fAOuysta+Ija1x/mlSWlsVYwFywJLw4i81kuyLRLbN4yNPU6GnXejRAtwcpgYeUKDMK6
         RrYsGzK2HcmQx2vPUykVXR45GW4SLFkCkYELrHhaJGHHxESm4CMp134TPDkvdTVVOLXA
         IlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0+dp4f3ePtjH+bvz+fgSMrbzLb2G05YyXJcIAi4CoM=;
        b=TdOJeXVJjXXF1OKyX0EhfM8SFjtPH8p97iOuJy21debhhiwb2Z0bdn2sIHlCaGI8Gr
         deibCDdj8RZGkjNzMTbGLTOBjJKSlUm63Glb+u7A8R8LFxggdSfZLvfEF2pnbdF2r9j3
         HXv5u/I6zYCTZKrUSXc1YBh2KxGG+2MeIfSdE166VKNHqeU+H0VGJ7FsGH3cvVDMmF9I
         JrTUWTHTywbcoAvZVqzBgPNZGLs1Cdh71PuwMRqp95A2xFOMMc7kDahMckUIbVakGm7k
         vhjA0LLxzQFpw3Atw8ALvWCRk54kLme1tZm0+ACTW39rXZcApSum/umdtYAO2LkZ7G4a
         ep6w==
X-Gm-Message-State: AOAM531kFtvem50YRNuILobdJtfnO3Zh104oxgdyXPd7Cs00icwQyxPR
        WmobJ1wXZZjKUJoy2jSGAsX/411RIWnxvbkkq3cENM4Uryg=
X-Google-Smtp-Source: ABdhPJw8QRmKhmDepZiLjWxV+Z6JBqnX0TuFfhHXXXnKJ0RZrcV37wZLtmaAZKuRuiSs8X74eibWondUY4YjBDtxP2o=
X-Received: by 2002:a92:5882:: with SMTP id z2mr2492627ilf.137.1601967205601;
 Mon, 05 Oct 2020 23:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
 <CAOQ4uxjot9f=XZEchRuNopVyZtKGzp7R7j5i2GxO_OuxUE8KMg@mail.gmail.com> <20201005224642.0c23dbb66a637c7581be725f@virtuozzo.com>
In-Reply-To: <20201005224642.0c23dbb66a637c7581be725f@virtuozzo.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Oct 2020 09:53:15 +0300
Message-ID: <CAOQ4uxj=hd+NP6g5P8+Cj71AUnoZpWk8x=SvAZhDv45ApY0Emw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] overlayfs: C/R enhancments (RFC)
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 5, 2020 at 10:47 PM Alexander Mikhalitsyn
<alexander.mikhalitsyn@virtuozzo.com> wrote:
>
> Hi Amir,
>
> On Mon, 5 Oct 2020 10:56:50 +0300
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On Sun, Oct 4, 2020 at 10:25 PM Alexander Mikhalitsyn
> > <alexander.mikhalitsyn@virtuozzo.com> wrote:
> > >
> > > Some time ago we discussed about the problem of Checkpoint-Restoring
> > > overlayfs mounts [1]. Big thanks to Amir for review and suggestions.
> > >
> > > Brief from previous discussion.
> > > Problem statement: to checkpoint-restore overlayfs mounts we need
> > > to save overlayfs mount state and save it into the image. Basically,
> > > this state for us it's just mount options of overlayfs mount. But
> > > here we have two problems:
> > >
> > > I. during mounting overlayfs user may specify relative paths in upperdir,
> > > workdir, lowerdir options
> > >
> > > II. also user may unmount mount from which these paths was opened during mounting
> > >
> > > This is real problems for us. My first patch was attempt to address both problems.
> > > 1. I've added refcnt get for mounts from which overlayfs was mounted.
> > > 2. I've changed overlayfs mountinfo show algorithm, so overlayfs started to *always*
> > > show full paths for upperdir,workdir,lowerdirs.
> > > 3. I've added mnt_id show-time only option which allows to determine from which mnt_id
> > > we opened options paths.
> > >
> > > Pros:
> > > - we can determine full information about overlayfs mount
> > > - we hold refcnt to mount, so, user may unmount source mounts only
> > > with lazy flag
> > >
> > > Cons:
> > > - by adding refcnt get for mount I've changed possible overlayfs usecases
> > > - by showing *full* paths we can more easily reache PAGE_SIZE limit of
> > > mounts options in procfs
> > > - by adding mnt_id show-only option I've added inconsistency between
> > > mount-time options and show-time mount options
> > >
> > > After very productive discussion with Amir and Pavel I've decided to write new
> > > implementation. In new approach we decided *not* to take extra refcnts to mounts.
> > > Also we decided to use exportfs fhandles instead of full paths. To determine
> > > full path we plan to use the next algo:
> > > 1. Export {s_dev; fhandle} from overlayfs for *all* sources
> > > 2. User open_by_handle_at syscall to open all these fhandles (we need to
> > > determine mount for each fhandle, looks like we can do this by s_dev by linear
> > > search in /proc/<pid>/mountinfo)
> > > 3. Then readlink /proc/<pid>/fd/<opened fd>
> > > 4. Dump this full path+mnt_id
> > >
> >
> > Hi Alex,
> >
> > The general concept looks good to me.
> > I will not provide specific comment on the implementation (it looks
> > fine) until the
> > concept API is accepted by the maintainer.
> >
> > The main thing I want to make sure is that if we add this interface it can
> > serve other use cases as well.
>
> Yes, let's create universal interface.
>

Note that this universal interface contradicts the direction of sysfs
which is a convenient way for getting filesystem instance info, but
not object info.

> >
> > During my talk on LPC, I got a similar request from two developers for two
> > different use cases. They wanted a safe method to iterate "changes
> > since baseline"
> > from either within the container or from the host.
>
> This discussions was on lkml or in private room?
>

The containers track:
https://youtu.be/fSyr_IXM21Y?t=4939

We continued in private channels, but the general idea
is an API to provide some insight about underlying layers

> >
> > Your proposed API is a step in the direction for meeting their requirement.
> > The major change is that ioctl (or whatever method) should expose the
> > layers topology of a specific object, not only the overlay instance.
> >
> > For C/R you would query the layers topology of the overlay root dir.
> >
> > My comments of the specific methods below are not meant to
> > object to the choice of ioctl, but they are meant to give the alternative
> > a fair chance. I am kind of leaning towards ioctl myself.
> >
> > > But there is question. How to export this {s_dev; fhandle} from kernel to userspace?
> > > - We decided not to use procfs.
> >
> > Why not?
> > C/R already uses procfs to export fhandle for fanotify/inotify
> > I kind of like the idea of having /sys/fs/overlay/instances etc.
> > It could be useful to many things.
>
> Ah, sorry. For some reason I've decided that we excluded procfs/sysfs option :)
> Let's take this option into account too.
>
> >
> > > - Amir proposed solution - use xattrs. But after diving into it I've meet problem
> > > where I can set this xattrs?
> > > If I set this xattrs on overlayfs dentries then during rsync, or cp -p=xattr we will copy
> > > this temporary information.
> >
> > No you won't.
> > rsync, cp will only copy xattrs listed with listxattr.
> > Several filesystems, such as cifs and nfs export "object properties"
> > via private xattrs
> > that are not listed in listxattr (e.g. CIFS_XATTR_CIFS_ACL).
> > You are not limited in what you can do in the "trusted.overlay" namespace, for
> > example "trusted.overlay.layers.0.fh"
> >
> > The advantage is that it is very easy to implement and requires
> > less discussions about ABI, but I agree it does feel a bit like a hack.
>
> Ack. I can try to write some draft implementation with xattrs.
>

You don't have to write code before getting an ack from
maintainer on the design, but fine by me.

> >
> > > - ioctls? (this patchset implements this approach)
> > > - fsinfo subsystem (not merged yet) [2]
> > >
> > > Problems with ioctls:
> > > 1. We limited in output data size (16 KB AFAIK)
> > > but MAX_HANDLE_SZ=128(bytes), OVL_MAX_STACK=500(num lowerdirs)
> > > So, MAX_HANDLE_SZ*OVL_MAX_STACK = 64KB which is bigger than limit.
> > > So, I've decided to give user one fhandle by one call. This is also
> > > bad from the performance point of view.
> > > 2. When using ioctls we need to have *fixed* size of input and output.
> > > So, if MAX_HANDLE_SZ will change in the future our _IOR('o', 2, struct ovl_mnt_opt_fh)
> > > will also change with struct ovl_mnt_opt_fh.
> > >
> >
> > The choice of API with fixed output size for a variable length info seems weird.
>
> Yes, and I've proposed option with ioctl syscall where we open file descriptor
> instead of doing direct copy_from_user/copy_to_user.
>
> >
> > I am tempted to suggest extending name_to_handle_at(), for example
> > name_to_handle_at(ovl_root_fd, path, &fhandle, &layer_id, AT_LAYER)
> >
> > Where layer_id can be input/output arg.
> >
> > But I acknowledge this is going to be a much harder sell...
>
> Looks interesting. I'll need to dive and think about it.
>

This API change has a lot more stakeholders.
I think it would be wiser for you to stay within the overlayfs boundaries.

Thanks,
Amir.
