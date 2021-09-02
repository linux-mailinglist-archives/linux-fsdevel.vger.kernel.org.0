Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2603FF2DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbhIBRxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346718AbhIBRxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630605175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGgz/DAvR7xRFawq5YYv7/qKBT6IhTR9s5xg+w37MzM=;
        b=CiQaEVtFmf2ZzRCQF08sk+lu1KXCD5C4wlnGekPPbU87KELbaXVrmOTyGbHG31tYZvjmlp
        Sc2wxSVHeRt+RFmvRhTtEQK61d291DiMD0Z0RHudfJvqO1rio0w62OxqJhcnVkmHsf+gu+
        DSgSp87a6kGQ2/59nbqTcKoKyTQYv/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-WJNs38GUPuS61ys1H3MYNw-1; Thu, 02 Sep 2021 13:52:54 -0400
X-MC-Unique: WJNs38GUPuS61ys1H3MYNw-1
Received: by mail-wm1-f71.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so1006409wmc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 10:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGgz/DAvR7xRFawq5YYv7/qKBT6IhTR9s5xg+w37MzM=;
        b=Ietiqr/Fp3g1mgly7LLHB2fco5MffTE0tH/RaMIfdJGyZpQCLXqZD4cJEE94Ax4qbI
         kMV7KQeIka06i8GJ+Fb9KHtKp6t3CxTx8OyxCgkwZYY1aoSlymH0xcXPYQinWGj3EE8B
         qU/zeGZDsvSbRDwiQlTbd/kxG2fzmN+kjMfd3d75gYySFASZttJKLXFjR4s+lDULSohA
         AVgxIKCgjV+a6R1O7S8v1RUeJxb06iaglvoYRWqhRxI4+pIO1fFuxCNdRPmRJn2FGe1y
         Wv7ketXPya8IzE8TuXEgbDzPin4gkgEnfBnavMc1OkI/HlgPyB+uep8XFaJzxsQDpxX7
         7Knw==
X-Gm-Message-State: AOAM531lt99ytLfbxJ8ddsTKFu9oa/aC9PsjqvR59Z46eiOIQitKuQ24
        +dVUBDebXv+3Xca+05HnOPQqO9EUDqQqYhkmz2H0DJDVXeHlkMMdk/wxhYHWhIRQ1Q0Nb2/JuOM
        aJ6y2I2/f7cJEiLmL6qcMRxZZ0KaFCZvOHAfUTcY8vg==
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr4393824wrx.357.1630605173421;
        Thu, 02 Sep 2021 10:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh60vnYnPsananb52FqQ9yBDe+vklZykFx/lhJt9v1VzExu90P4TAUbNHWr44MGvno31emeutULtDXbJmfXOo=
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr4393813wrx.357.1630605173219;
 Thu, 02 Sep 2021 10:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com>
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Sep 2021 19:52:41 +0200
Message-ID: <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Sep 2, 2021 at 5:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> This is V3 of the patch. Previous versions were posted here.
>
> v2: https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>
> Changes since v2
> ----------------
> - Do not call inode_permission() for special files as file mode bits
>   on these files represent permissions to read/write from/to device
>   and not necessarily permission to read/write xattrs. In this case
>   now user.* extended xattrs can be read/written on special files
>   as long as caller is owner of file or has CAP_FOWNER.
>
> - Fixed "man xattr". Will post a patch in same thread little later. (J.
>   Bruce Fields)
>
> - Fixed xfstest 062. Changed it to run only on older kernels where
>   user extended xattrs are not allowed on symlinks/special files. Added
>   a new replacement test 648 which does exactly what 062. Just that
>   it is supposed to run on newer kernels where user extended xattrs
>   are allowed on symlinks and special files. Will post patch in
>   same thread (Ted Ts'o).
>
> Testing
> -------
> - Ran xfstest "./check -g auto" with and without patches and did not
>   notice any new failures.
>
> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>   filesystems and it works.
>
> Description
> ===========
>
> Right now we don't allow setting user.* xattrs on symlinks and special
> files at all. Initially I thought that real reason behind this
> restriction is quota limitations but from last conversation it seemed
> that real reason is that permission bits on symlink and special files
> are special and different from regular files and directories, hence
> this restriction is in place. (I tested with xfs user quota enabled and
> quota restrictions kicked in on symlink).
>
> This version of patch allows reading/writing user.* xattr on symlink and
> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.

the idea behind user.* xattrs is that they behave similar to file
contents as far as permissions go. It follows from that that symlinks
and special files cannot have user.* xattrs. This has been the model
for many years now and applications may be expecting these semantics,
so we cannot simply change the behavior. So NACK from me.

> Who wants to set user.* xattr on symlink/special files
> -----------------------------------------------------
> I have primarily two users at this point of time.
>
> - virtiofs daemon.
>
> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
>   fuse-overlay as well and he ran into similar issue. So fuse-overlay
>   should benefit from this change as well.
>
> Why virtiofsd wants to set user.* xattr on symlink/special files
> ----------------------------------------------------------------
> In virtiofs, actual file server is virtiosd daemon running on host.
> There we have a mode where xattrs can be remapped to something else.
> For example security.selinux can be remapped to
> user.virtiofsd.securit.selinux on the host.
>
> This remapping is useful when SELinux is enabled in guest and virtiofs
> as being used as rootfs. Guest and host SELinux policy might not match
> and host policy might deny security.selinux xattr setting by guest
> onto host. Or host might have SELinux disabled and in that case to
> be able to set security.selinux xattr, virtiofsd will need to have
> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> guest security.selinux (or other xattrs) on host to something else
> is also better from security point of view.
>
> But when we try this, we noticed that SELinux relabeling in guest
> is failing on some symlinks. When I debugged a little more, I
> came to know that "user.*" xattrs are not allowed on symlinks
> or special files.
>
> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> allow virtiofs to arbitrarily remap guests's xattrs to something
> else on host and that solves this SELinux issue nicely and provides
> two SELinux policies (host and guest) to co-exist nicely without
> interfering with each other.

The fact that user.* xattrs don't work in this remapping scenario
should have told you that you're doing things wrong; the user.*
namespace seriously was never meant to be abused in this way.

You may be able to get away with using trusted.* xattrs which support
roughly the kind of daemon use I think you're talking about here, but
I'm not sure selinux will be happy with labels that aren't fully under
its own control. I really wonder why this wasn't obvious enough.

Thanks,
Andreas

> Thanks
> Vivek
>
> Vivek Goyal (1):
>   xattr: Allow user.* xattr on symlink and special files
>
>  fs/xattr.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.31.1
>

