Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D884104E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhIRHpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIRHpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:45:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BCC061574;
        Sat, 18 Sep 2021 00:44:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso3630964wme.2;
        Sat, 18 Sep 2021 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUX6sgftPvsY8sozGaamnkjHLdKO3bR2I+eKzl5NogU=;
        b=a/OIlEh1Txd3ZHcOE1BZTHaZfm1IPccirIkh/TuYdXJCc+CCpz2i+MS8a4pgOvuVt7
         UD4SL1T71J0L0MACqTA79QTL8bZw9Gta+Zh5shptBD5ajwRqr//HzIUQqqfYBgRCulrn
         pwYDnRGcrd+tfv+hL3GeKOIlC4YGAF867PtCzPKPDWlMnm2qvQcNQpgym12qaSEfEMbi
         2q7R4iG8tvz7VAHJrUvgPNVcpAMc87dHByy6Gbw9jOe12jvgvQjlmSt/CyncBp7X1Wj7
         33xnw7x2kdbcTloecwwniKgESzxBlggE/z5SzOGps46cfVyZm+jlk9u08FxUFKpqU/Ud
         0wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUX6sgftPvsY8sozGaamnkjHLdKO3bR2I+eKzl5NogU=;
        b=hvemC5JHM4cESR3AG6G+5AjyZCVF/pvbcaq0/h+xntKV7kaRsCk1Gy58XvuatulHqL
         c1oaeUdHHZKY/KblW7OhQlsy5Kyv0vj6iWjAzWMqfWyo7aYhKpokQgQQxwX3pDYg/0uy
         0BakBXaGrc0TPz30f4oCYewoz8FiZoYxTOdZRwWkyYzEhd5//oRnTkSOUxWpCEPJ+zhw
         H8h84NjTaXDCgg3tzEE2sovI0QK7W4KsVOjwlcPkZveoY14RcjhwsD+C7ctsTimfaI2q
         /OGNaNkoBpqG53EFB/4uHWWylfOlfoHplkgIqtxjdWobxlAd1vt15gprgk4QkyuJ68uD
         hVNw==
X-Gm-Message-State: AOAM533xXYAjfO+CNl2SfXyh2nuh1oyQ+cgHpEZkT1IeBQX0k0wj9FCa
        34+F9QIgrwfUBjhtn2NMf3nYtVHFNPMRIk7AFU0=
X-Google-Smtp-Source: ABdhPJyKwaJ3CeMDMjQ1fryHk/OOoR1Ic42jUYNnrCsjp94TcwpskrR2iCBifeqvTLWwAUiSpKOpGLgOwPxic0JltIM=
X-Received: by 2002:a1c:403:: with SMTP id 3mr14298578wme.161.1631951053112;
 Sat, 18 Sep 2021 00:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210916013916.GD34899@magnolia> <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz> <20210917093838.GC6547@quack2.suse.cz>
 <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
 <20210917161217.GB10224@magnolia> <20210917231522.GT2361455@dread.disaster.area>
In-Reply-To: <20210917231522.GT2361455@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Sep 2021 10:44:02 +0300
Message-ID: <CAOQ4uxjGLJNA9p-zDS8F1cnGdxiCXYLO4My=qBMHjOF2B55vrQ@mail.gmail.com>
Subject: Re: Alternative project ids and quotas semantics (Was: Shameless plug
 for the FS Track at LPC next week!)
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 2:15 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Sep 17, 2021 at 09:12:17AM -0700, Darrick J. Wong wrote:
> > On Fri, Sep 17, 2021 at 01:23:08PM +0300, Amir Goldstein wrote:
> > > On Fri, Sep 17, 2021 at 12:38 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Fri 17-09-21 10:36:08, Jan Kara wrote:
> > > > > Let me also post Amir's thoughts on this from a private thread:
> > > >
> > > > And now I'm actually replying to Amir :-p
> > > >
> > > > > On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > > > > > We did a small update to the schedule:
> > > > > >
> > > > > > > Christian Brauner will run the second session, discussing what idmapped
> > > > > > > filesystem mounts are for and the current status of supporting more
> > > > > > > filesystems.
> > > > > >
> > > > > > We have extended this session as we'd like to discuss and get some feedback
> > > > > > from users about project quotas and project ids:
> > > > > >
> > > > > > Project quotas were originally mostly a collaborative feature and later got
> > > > > > used by some container runtimes to implement limitation of used space on a
> > > > > > filesystem shared by multiple containers. As a result current semantics of
> > > > > > project quotas are somewhat surprising and handling of project ids is not
> > > > > > consistent among filesystems. The main two contending points are:
> > > > > >
> > > > > > 1) Currently the inode owner can set project id of the inode to any
> > > > > > arbitrary number if he is in init_user_ns. It cannot change project id at
> > > > > > all in other user namespaces.
> > > > > >
> > > > > > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > > > > > code does implement the mapping, VFS quota code maps project ids when using
> > > > > > them. However e.g. XFS does not map project IDs in its calls setting them
> > > > > > in the inode. Among other things this results in some funny errors if you
> > > > > > set project ID to (unsigned)-1.
> > > > > >
> > > > > > In the session we'd like to get feedback how project quotas / ids get used
> > > > > > / could be used so that we can define the common semantics and make the
> > > > > > code consistently follow these rules.
> > > > >
> > > > > I think that legacy projid semantics might not be a perfect fit for
> > > > > container isolation requirements. I added project quota support to docker
> > > > > at the time because it was handy and it did the job of limiting and
> > > > > querying disk usage of containers with an overlayfs storage driver.
> > > > >
> > > > > With btrfs storage driver, subvolumes are used to create that isolation.
> > > > > The TREE_ID proposal [1] got me thinking that it is not so hard to
> > > > > implement "tree id" as an extention or in addition to project id.
> > > > >
> > > > > The semantics of "tree id" would be:
> > > > > 1. tree id is a quota entity accounting inodes and blocks
> > > > > 2. tree id can be changed only on an empty directory
>
> Hmmm. So once it's created, it can't be changed without first
> deleting all the data in the tree?

That is correct.
Similar to fscrypt_ioctl_set_policy().

>
> > > > > 3. tree id can be set to TID only if quota inode usage of TID is 0
>
> What does this mean? Defining behaviour.semantics in terms of it's
> implementation is ambiguous and open for interpretation.
>

You are right. Let me give it a shot:

For the current use of project quotas in containers as a way to
limit disk usage of container instance, container managers
assign a project id with project quota to some directory that is
going to be used as the root of a bind mount point inside the
container (e.g. /home).

With xfs, that means that a user inside the container gets the df
report on the bind mount based on xfs_qm_statvfs() which provides
the project quota usage, which is intended to reflect the container's
disk usage on the xfs filesystem that is shared among containers.

In practice, the container's disk usage may be contaminated by
usage of other unrelated subtrees or solo files that have been
assigned the same project id on purpose or by mistake.

The current permission model for changing project id does
not always align with how container users should be allowed
to manipulate their own reported disk usage and affect the
disk usage reported or allowed to other containers.

The proposed alternative semantics for project ids and quotas
will allow container managers better control over the disk usage
observed by container users when project quotas are used, by making
sure that project id represents a single fully connected subtree in
the context of a single filesystem.

> I *think* the intent here is that tree ids are unique and can only
> be applied to a single tree, but...
>

You are correct. That is what it means.
Subtree members on a *single filesystem* are all descendants
of a single root.
The subtree root is a directory and it is the only member of the subtree
whose (sb) parent is not a member of the subtree.

> And, of course, what happens if we have multiple filesystems? tree
> IDs are no longer globally unique across the system, right?
>

No requirement for tree id to be unique across the system.
<st_dev, tree_id> should be unique across the system.

> > > > > 4. tree id is always inherited from parent
>
> What happens as we traverse mount points within a tree? If the quota
> applies to directory trees, then there are going to be directory
> tree constructs that don't obviously follow this behaviour. e.g.
> bind mounts from one directory tree to another, both having
> different tree IDs.

We want nothing to do with that.
Quotas and disk usage have always been a filesystem property.
I see no reason to extend them beyond a single filesystem boundary.

Just because Niel chose to use the term "tree" to represent those
entities, does not mean that they are related to mount trees.
If the term is confusing then we can use a different term.
I personally prefer the term "subtree" to represent those entities.

Mind you, the STATX_TREE_ID proposal and the project id proposal
that I derived from it are based on current btrfs subvol semantics.

One difference between xfs/ext4 subtree quota and btrfs subvol
is that subvol is also an isolated inode number namespace.
Another difference is that currently, btrfs subvol has a unique
st_dev, but Neil has proposed some designs to change that.

In the long term, userspace tools could gain option
-xx --one-file-system-subtree (or something) and learn
how to stay within subtree boundaries.

>
> Which then makes me question: are inodes and inode flags the right
> place to track and propagate these tree IDs? Isn't the tree ID as
> defined here a property of the path structure rather than a property
> of the inode?  Should we actually be looking at a new directory tree
> ID tracking behaviour at, say, the vfs-mount+dentry level rather
> than the inode level?
>

That was not my intention with this proposal.

> > > > > 5. No rename() or link() across tree id (clone should be possible)
>
> The current directory tree quotas disallow this because of
> implementation difficulties (e.g. avoiding recursive chproj inside
> the kernel as part of rename()) and so would punt the operations too
> difficult to do in the kernel back to userspace. They are not
> intended to implement container boundaries in any way, shape or
> form. Container boundaries need to use a proper access control
> mechanism, not rely on side effects of difficult-to-implement low
> level accounting mechanisms to provide access restriction.
>
> Indeed, why do we want to place restrictions on moving things across
> trees if the filesystem can actually do so correctly? Hence I think
> this is somewhat inappropriately be commingling container access
> restrictions with usage accounting....
>
> I'm certain there will be filesytsems that do disallow rename and
> link to punt the problem back up to userspace, but that's an
> implementation detail to ensure accounting for the data movement to
> a different tree is correct and not a behavioural or access
> restriction...
>

I did not list the no-cross rename()/link() requirement because
of past project id behavior or because of filesystem implementation
challenges.

I listed it because of the single-fully-connected-subtree requirement.
rename()/link() across subtree boundaries would cause multiple roots
of the same subtree id.

Sorry, Dave, for not writing a mathematical definition of a
singly-connected-subtree-whatever, but by now,
I hope you all understand very well what this beast is.
It is really not that complicated (?).

The reason I started the discussion with implementation rules
is *because* they are so simple to understand, so I figured
everybody could understand what the result is, but I realize
that my initial proposal was missing the wider context.

Is anything not clear now?

Thanks,
Amir.
