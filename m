Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3929E3B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 08:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ2HUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2HUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29AAC08EBB2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z5so2340371iob.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYJuh784A+cg3Z8+1Zy80X4u98CkOOu8oSlOndn6LP8=;
        b=ukkHuDX6yvhUUuB02MVOivG/WA5Ojyb5VYHv669wm4UAXDWp5nAXmbtMTBCfLFoPb9
         sVpgKjyc2zqVxegUtGLSbRzLGexJM5lQuzckbt8qF8u/HiyA4E0h7EUabZqAmLhOGN8T
         oEGcB9xpnrhEwAKkcmxDeaZNHBU6zCIIWxMdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYJuh784A+cg3Z8+1Zy80X4u98CkOOu8oSlOndn6LP8=;
        b=qWijuY9a/5WL21AOit9mklqjbyND/XfI4/iOjvyMOdBb7LpP3dxC4mKitKM+Zw0Su1
         jURIMl8rNH1KJOVaXIgS7AUPu9nHGRSa7BcBcQack1z0MZByNZZxokh3nskT4KDe/7+N
         TP4y/1iaEwXlhkYaqbBNLkRi1UjFWPhVk8rEVCV2XnS+dm3zL8qo+Wg9yYMOW4hgi7Dt
         SebX6ZlUqrEx+/76JsDEZIL+/2wsvYAu/VUQSqYLZCUfl8KTOfCNlNFRpR2h3q0v8Vny
         naC+FdqUUPCaahbJVbHcX7G6CNjhBMPHV7V5y5LmhLn7k3ZRt6D6ucdCKUuXHt7hO8Ge
         reIQ==
X-Gm-Message-State: AOAM532FkHKFIPIBfVXRmGvyw+JU7PyR7qsfyV9VFCINkCjV+sUsMDo6
        hI/wceg4YTkyXfFrFBeCp0TWNw==
X-Google-Smtp-Source: ABdhPJyOF/iJB70V4z6Kj5OehxU+n1aNhIuE8pqzjl3KXVgPoawDTq88ZFqqZglnxTR3mWhjdU4O1Q==
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr2361774iof.175.1603956010838;
        Thu, 29 Oct 2020 00:20:10 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id k6sm1247023iov.26.2020.10.29.00.20.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:10 -0700 (PDT)
Date:   Thu, 29 Oct 2020 07:20:08 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Tycho Andersen <tycho@tycho.ws>,
        Miklos Szeredi <miklos@szeredi.hu>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        selinux@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Andy Lutomirski <luto@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029071946.GA29881@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:32:18AM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> I vanished for a little while to focus on this work here so sorry for
> not being available by mail for a while.
> 
> Since quite a long time we have issues with sharing mounts between
> multiple unprivileged containers with different id mappings, sharing a
> rootfs between multiple containers with different id mappings, and also
> sharing regular directories and filesystems between users with different
> uids and gids. The latter use-cases have become even more important with
> the availability and adoption of systemd-homed (cf. [1]) to implement
> portable home directories.
> 
> The solutions we have tried and proposed so far include the introduction
> of fsid mappings, a tiny overlay based filesystem, and an approach to
> call override creds in the vfs. None of these solutions have covered all
> of the above use-cases.
> 
> The solution proposed here has it's origins in multiple discussions
> during Linux Plumbers 2017 during and after the end of the containers
> microconference.
> To the best of my knowledge this involved Aleksa, Stéphane, Eric, David,
> James, and myself. A variant of the solution proposed here has also been
> discussed, again to the best of my knowledge, after a Linux conference
> in St. Petersburg in Russia between Christoph, Tycho, and myself in 2017
> after Linux Plumbers.
> I've taken the time to finally implement a working version of this
> solution over the last weeks to the best of my abilities. Tycho has
> signed up for this sligthly crazy endeavour as well and he has helped
> with the conversion of the xattr codepaths.
> 
> The core idea is to make idmappings a property of struct vfsmount
> instead of tying it to a process being inside of a user namespace which
> has been the case for all other proposed approaches.
> It means that idmappings become a property of bind-mounts, i.e. each
> bind-mount can have a separate idmapping. This has the obvious advantage
> that idmapped mounts can be created inside of the initial user
> namespace, i.e. on the host itself instead of requiring the caller to be
> located inside of a user namespace. This enables such use-cases as e.g.
> making a usb stick available in multiple locations with different
> idmappings (see the vfat port that is part of this patch series).
> 
> The vfsmount struct gains a new struct user_namespace member. The
> idmapping of the user namespace becomes the idmapping of the mount. A
> caller that is either privileged with respect to the user namespace of
> the superblock of the underlying filesystem or a caller that is
> privileged with respect to the user namespace a mount has been idmapped
> with can create a new bind-mount and mark it with a user namespace. The
> user namespace the mount will be marked with can be specified by passing
> a file descriptor refering to the user namespace as an argument to the
> new mount_setattr() syscall together with the new MOUNT_ATTR_IDMAP flag.
> By default vfsmounts are marked with the initial user namespace and no
> behavioral or performance changes should be observed. All mapping
> operations are nops for the initial user namespace.
> 
> When a file/inode is accessed through an idmapped mount the i_uid and
> i_gid of the inode will be remapped according to the user namespace the
> mount has been marked with. When a new object is created based on the
> fsuid and fsgid of the caller they will similarly be remapped according
> to the user namespace of the mount they care created from.
> 
> This means the user namespace of the mount needs to be passed down into
> a few relevant inode_operations. This mostly includes inode operations
> that create filesystem objects or change file attributes. Some of them
> such as ->getattr() don't even need to change since they pass down a
> struct path and thus the struct vfsmount is already available. Other
> inode operations need to be adapted to pass down the user namespace the
> vfsmount has been marked with. Al was nice enough to point out that he
> will not tolerate struct vfsmount being passed to filesystems and that I
> should pass down the user namespace directly; which is what I did.
> The inode struct itself is never altered whenever the i_uid and i_gid
> need to be mapped, i.e. i_uid and i_gid are only remapped at the time of
> the check. An inode once initialized (during lookup or object creation)
> is never altered when accessed through an idmapped mount.
> 
> To limit the amount of noise in this first iteration we have not changed
> the existing inode operations but rather introduced a few new struct
> inode operation methods such as ->mkdir_mapped which pass down the user
> namespace of the mount they have been called from. Should this solution
> be worth pursuing we have no problem adapting the existing inode
> operations instead.
> 
> In order to support idmapped mounts, filesystems need to be changed and
> mark themselves with the FS_ALLOW_IDMAP flag in fs_flags. In this first
> iteration I tried to illustrate this by changing three different
> filesystem with different levels of complexity. Of course with some bias
> towards urgent use-cases and filesystems I was at least a little more
> familiar with. However, Tycho and I (and others) have no problem
> converting each filesystem one-by-one. This first iteration includes fat
> (msdos and vfat), ext4, and overlayfs (both with idmapped lower and
> upper directories and idmapped merged directories). I'm sure I haven't
> gotten everything right for all three of them in the first version of
> this patch.
> 

Thanks for this patchset. It's been a long-time coming.

I'm curious as to for the most cases, how much the new fs mount APIs help, and 
if focusing on those could solve the problem for everything other than bind 
mounts? Specifically, the idea of doing fsopen (creation of fs_context) under 
the user namespace of question, and relying on a user with CAP_SYS_ADMIN to call 
fsmount[1]. I think this is actually especially valuable for places like 
overlayfs that use the entire cred object, as opposed to just the uid / gid. I 
imagine that soon, most filesystems will support the new mount APIs, and not set 
the global flag if they don't need to.

How popular is the "vfsmount (bind mounts) needs different uid mappings" use 
case?

The other thing I worry about is the "What UID are you really?" game that's been 
a thing recently. For example, you can have a different user namespace UID 
mapping for your network namespace that netfilter checks[2], and a different one 
for your mount namespace, and a different one that the process is actually in.
This proliferation of different mappings makes auditing, and doing things like
writing perf toolings more difficult (since I think bpf_get_current_uid_gid
use the initial user namespace still [3]).

[1]: https://lore.kernel.org/linux-nfs/20201016123745.9510-4-sargun@sargun.me/T/#u
[2]: https://elixir.bootlin.com/linux/v5.9.1/source/net/netfilter/xt_owner.c#L37
[3]: https://elixir.bootlin.com/linux/v5.9.1/source/kernel/bpf/helpers.c#L196

