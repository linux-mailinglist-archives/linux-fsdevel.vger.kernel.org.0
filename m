Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCD3F26C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 08:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhHTGYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 02:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhHTGYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:24:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B78C061575;
        Thu, 19 Aug 2021 23:23:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r6so8416868ilt.13;
        Thu, 19 Aug 2021 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUsUhEuTLWWcP4Va4eN33ck8pi79n7CztnAZY5/2XT4=;
        b=So1o2CV5txO1d+5JmfwRN+JY3uMBVz41DxXiV3uaHyeQKcjSAcey2d/xpWjFyNT5oV
         OqEh1UoHmyOtUhX8wtnieoom7LJkOWA1llvbDNMa1R/1hhfL+Ya1rSOUtrMxsLv+FwhJ
         40UA6SzgZbv79O+H4YyiAKXZlGyHC98E6tpHyh6rCnOhpFRlSJbA67dG8sFugp/2CSt1
         V8Xo9j6XFfmNX/D91Xx/Ft2qsci01z2MB27ARP9m0nnt0pUoCbx+ESB20909HSNIRhgB
         I159oLsnYPD9cd1SlsXhfAWZYIjwBfbVLXb6eQiw3bfkf4xWKh+9M7lkkBhX3xrA8FJA
         obeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUsUhEuTLWWcP4Va4eN33ck8pi79n7CztnAZY5/2XT4=;
        b=PYsWK+Q8MWcRZgwVZwlM7ZxYPv2YBqYF6xgEjMM4KRIC2M9t6BpbGXwg+XZG2uadbx
         G4JFQHw/ph6vK+q5vsYY0t+zImpV/rktRWSzbr0jY4t0dLbcnynhwBwom3hEn65NKFdN
         x0lTCgjG1Ys2tjuFDAccEvVV81/fBWKALOqUCKR3nmLbVUdwsCLJK0HXdewOciz25DwJ
         ytJi7seyx30N+amg+IWm6SzaEaez9nJtmy/f4SXGDXgUmMprkV5c6Aud7PQFY4u0JNAU
         raJdOr1b6rET0w2Ghs75PvC6jEasMYS4F0/ec0ekb0J/13ZwmKsn3JkikyRdJGU6lbaQ
         kf7w==
X-Gm-Message-State: AOAM530QR2p3aeyyiLuCvClY8rkctpKh389WddQHZUXctb8r+1nCrbmL
        PATue4pIH/CVoCLpsB09R6IkLBHDSfPkh91/vuw=
X-Google-Smtp-Source: ABdhPJzL6uxP36Wx4hSAZcQh1YXMqQWKUIsxhtGZWtbot2TxZq02oYKXZAjGg/8gYWgLHdINOMipV3qbLRcF+t8ElEY=
X-Received: by 2002:a92:cd0a:: with SMTP id z10mr12295877iln.137.1629440606274;
 Thu, 19 Aug 2021 23:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it> <20210816003505.7b3e9861@natsu>
 <162906585094.1695.15815972140753474778@noble.neil.brown.name>
 <CAOQ4uxiry7HcRtqY3DehNi4_PTLjxN0uMrw-oYcX9TgehC6m6w@mail.gmail.com> <162942971499.9892.4386273250573040668@noble.neil.brown.name>
In-Reply-To: <162942971499.9892.4386273250573040668@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Aug 2021 09:23:14 +0300
Message-ID: <CAOQ4uxjTc7amniZtSPWQbysD5YspE5Z=+5T1fC-bFqh56Y3_qQ@mail.gmail.com>
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Goffredo Baroncelli <kreijack@libero.it>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 6:22 AM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 19 Aug 2021, Amir Goldstein wrote:
> > On Mon, Aug 16, 2021 at 1:21 AM NeilBrown <neilb@suse.de> wrote:
> > >
> > > There are a few ways to handle this more gracefully.
> > >
> > > 1/ We could get btrfs to hand out new filehandles as well as new inode
> > > numbers, but still accept the old filehandles.  Then we could make the
> > > inode number reported be based on the filehandle.  This would be nearly
> > > seamless but rather clumsy to code.  I'm not *very* keen on this idea,
> > > but it is worth keeping in mind.
> > >
> >
> > So objects would change their inode number after nfs inode cache is
> > evicted and while nfs filesystem is mounted. That does not sound ideal.
>
> No.  Almost all filehandle lookups happen in the context of some other
> filehandle.  If the provided context is an old-style filehandle, we
> provide an old-style filehandle for the lookup.  There is already code
> in nfsd to support this (as we have in the past changed how filesystems
> are identified).
>

I see. This is nice!
It almost sounds like "inode mapped mounts" :-)


> It would only be if the mountpoint filehandle (which is fetched without
> that context) went out of cache that inode numbers would change.  That
> would mean that the filesystem (possibly an automount) was unmounted.
> When it was remounted it could have a different device number anyway, so
> having different inode numbers would be of little consequence.
>
> >
> > But I am a bit confused about the problem.
> > If the export is of the btrfs root, then nfs client cannot access any
> > subvolumes (right?) - that was the bug report, so the value of inode
> > numbers in non-root subvolumes is not an issue.
>
> Not correct.  All objects in the filesystem are fully accessible.  The
> only problem is that some pairs of objects have the same inode number.
> This causes some programs like 'find' and 'du' to behave differently to
> expectations.  They will refuse to even look in a subvolume, because it
> looks like doing so could cause an infinite loop.  The values of inode
> numbers in non-root subvolumes is EXACTLY the issue.
>

Thanks for clarifying.

> > If export is of non-root subvolume, then why bother changing anything
> > at all? Is there a need to traverse into sub-sub-volumes?
> >
> > > 2/ We could add a btrfs mount option to control whether the uniquifier
> > > was set or not.  This would allow the sysadmin to choose when to manage
> > > any breakage.  I think this is my preference, but Josef has declared an
> > > aversion to mount options.
> > >
> > > 3/ We could add a module parameter to nfsd to control whether the
> > > uniquifier is merged in.  This again gives the sysadmin control, and it
> > > can be done despite any aversion from btrfs maintainers.  But I'd need
> > > to overcome any aversion from the nfsd maintainers, and I don't know how
> > > strong that would be yet. (A new export option isn't really appropriate.
> > > It is much more work to add an export option than the add a mount option).
> > >
> >
> > That is too bad, because IMO from users POV, "fsid=btrfsroot" or "cross-subvol"
> > export option would have been a nice way to describe and opt-in to this new
> > functionality.
> >
> > But let's consider for a moment the consequences of enabling this functionality
> > automatically whenever exporting a btrfs root volume without "crossmnt":
> >
> > 1. Objects inside a subvol that are inaccessible(?) with current
> > nfs/nfsd without
> >     "crossmnt" will become accessible after enabling the feature -
> > this will match
> >     the user experience of accessing btrfs on the host
>
> Not correct - as above.
>
> > 2. The inode numbers of the newly accessible objects would not match the inode
> >     numbers on the host fs (no big deal?)
>
> Unlikely to be a problem.  Inode numbers have no meaning beyond the facts
> that:
>   - they are stable for the lifetime of the object
>   - they are unique within a filesystem (except btrfs lies about
>     filesystems)
>   - they are not zero
>
> The facts only need to be equally true on the NFS server and client..
>
> > 3. The inode numbers of objects in a snapshot would not match the inode
> >     numbers of the original (pre-snapshot) objects (acceptable tradeoff for
> >     being able to access the snapshot objects without bloating /proc/mounts?)
>
> This also should not be a problem.  Files in different snapshots are
> different things that happen to share storage (like reflinks).
> Comparing inode numbers between places which report different st_dev
> does not fit within the meaning of inode numbers.
>
> > 4. The inode numbers of objects in a subvol observed via this "cross-subvol"
> >     export would not match the inode numbers of the same objects observed
> >     via an individual subvol export
>
> The device number would differ too, so the relative values of the inode
> numbers would be irrelevant.
>
> > 5. st_ino conflicts are possible when multiplexing subvol id and inode number.
> >     overlayfs resolved those conflicts by allocating an inode number from a
> >     reserved non-persistent inode range, which may cause objects to change
> >     their inode number during the lifetime on the filesystem (sensible
> > tradeoff?)
> >
> > I think that #4 is a bit hard to swallow and #3 is borderline acceptable...
> > Both and quite hard to document and to set expectations as a non-opt-in
> > change of behavior when exporting btrfs root.
> >
> > IMO, an nfsd module parameter will give some control and therefore is
> > a must, but it won't make life easier to document and set user expectations
> > when the semantics are not clearly stated in the exports table.
> >
> > You claim that "A new export option isn't really appropriate."
> > but your only argument is that "It is much more work to add
> > an export option than the add a mount option".
> >
> > With all due respect, for this particular challenge with all the
> > constraints involved, this sounds like a pretty weak argument.
> >
> > Surely, adding an export option is easier than slowly changing all
> > userspace tools to understand subvolumes? a solution that you had
> > previously brought up.
> >
> > Can you elaborate some more about your aversion to a new
> > export option.
>
> Export options are bits in a 32bit word - so both user-space and kernel
> need to agree on names for them.  We are currently using 18, so there is
> room to grow.  It is a perfectly reasonable way to implement sensible
> features.  It is, I think, a poor way to implement hacks to work around
> misfeatures in filesystems.
>
> This is the core of my dislike for adding an export option.  Using one
> effectively admits that what btrfs is doing is a valid thing to do.  I
> don't think it is.  I don't think we want any other filesystem developer
> to think that they can emulate the behaviour because support is already
> provided.
>
> If we add any configuration to support btrfs, I would much prefer it to
> be implemented in fs/btrfs, and if not, then with loud warnings that it
> works around a deficiency in btrfs.
>   /sys/modules/nfsd/parameters/btrfs_export_workaround
>

Thanks for clarifying.
I now understand how "hacky" the workaround in nfsd is.

Naive question: could this behavior be implemented in btrfs as you
prefer, but in a way that only serves nfsd and NEW nfs mounts for
that matter (i.e. only NEW filehandles)?

Meaning passing some hint in ->getattr() and ->iterate_shared(),
sort of like idmapped mount does for uid/gid.

Thanks,
Amir.
