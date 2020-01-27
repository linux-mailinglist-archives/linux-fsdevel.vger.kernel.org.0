Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39C114AA56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 20:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0TSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 14:18:39 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35847 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0TSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:18:38 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so8457458iln.3;
        Mon, 27 Jan 2020 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFmur+uid90vbSF2gCus6MutCACZFozAfACbQ1Tjcc8=;
        b=qjBm+C77Dw+j2maWQDNfdtxyFbcNx8rdXCDWEInJHmNoBzJHCKjAkh2R+NwrAolQjU
         SmH6c6J6fGKG1VNDveBd2ayT4p75VdsuemhQb1P/k7DltGTWlWXau9lmBWT1CVeZwM5S
         GD8s7Di4BYmTFiRfnE4u5L8epknicPap2TgXsZzMyQssj0re4dCKpgDtXfw0Rqc7es4g
         FcS8K36tUdLFlayFIT8JC4c7a3t2DsmGOxrZvFJmNFxWyZ/MDwDVYj4SWlUb37m+C0Su
         XSSuCSNyGyHl7c2aCKxCQTBlzrjalCd1pkO4tdEF5hE86S2HtcKqZqnE68r6Qz3LSFsO
         y/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFmur+uid90vbSF2gCus6MutCACZFozAfACbQ1Tjcc8=;
        b=qilMYxUg0FAj0+f9Wr5jvCn3oN67Usum8Oz2OJAyPMuSkjjcaWylAsE9fSZEKoY0vr
         70ctzC5+wGcIuXp6DYIOta1gJcmQmHz1/13/p3lqIE7wGkRRNyQwuTSVZPXtrPeFiZlE
         To0fby6/8Fh9jzqwDBHScWDOOQSm5y7wINk/r4UXOionYECwBOBPviTZa6JFF0yTrKWn
         vznIUG+TjBt5j/Dp6ZRRsD65ksy4rhieofNuZaTC+6ugt4c1o5JtWpm1nywxvg/ilzME
         FLjOcnv/bnYYuOSv61YqVOZ1kXWjaWZHy0LqbQNRCdsrzb7XtTlbUV78q9LAJrWOhvZA
         MJ2w==
X-Gm-Message-State: APjAAAW5+j6/vMouoIiHbH5AOPghBhuVbHiduYntHVPNtdkWsCR1nM9k
        qgEp05HGSeSUJ4ekHomXafEMEKa9X7AdNaT6wLrEiAxz
X-Google-Smtp-Source: APXvYqxkMFNi7BVyvRFktf+qZaybDHCEKC7xOgdnuytEFsqPqR/VSkklis5UAjXDipJ0+N5rewgdvpF0jDNkSDqbY9Q=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr16186713ilq.250.1580152717809;
 Mon, 27 Jan 2020 11:18:37 -0800 (PST)
MIME-Version: 1.0
References: <14196.1575902815@warthog.procyon.org.uk> <CAOQ4uxj7RhrBnWb3Lqi3hHLuXNkVXrKio398_PAEczxfyW7HsA@mail.gmail.com>
 <CAOQ4uxicFmiFKz7ZkHYuzduuTDaCTDqo26fo02-VjTMmQaaf+A@mail.gmail.com> <1477632.1580142761@warthog.procyon.org.uk>
In-Reply-To: <1477632.1580142761@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 Jan 2020 21:18:26 +0200
Message-ID: <CAOQ4uxgQzOsa-34aTcL7Tm68uMxq1anyC7qL+dHq3+yXAceeEA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] How to make disconnected operation work?
To:     David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:32 PM David Howells <dhowells@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > My thinking is: Can't we implement a stackable cachefs which interfaces
> > with fscache and whose API to the netfs is pure vfs APIs, just like
> > overlayfs interfaces with lower fs?
>
> In short, no - doing it with pure the VFS APIs that we have is not that simple
> (yes, Solaris does it with a stacking filesystem, and I don't know anything
> about the API details, but there must be an auxiliary API).  You need to
[...]
>
> > As long as netfs supports direct_IO() (all except afs do) then the active page
> > cache could be that of the stackable cachefs and network IO is always
> > direct from/to cachefs pages.
>
> What about objects that don't support DIO?  Directories, symbolic links and
> automount points?  All of these things are cacheable objects with AFS.
>

direct_IO is for not duplicating page cache.
Not relevant for those objects.
I guess that for those objects the invalidation callbacks is what matters.

> And speaking of automount points - how would you deal with those beyond simply
> caching the contents?  Create a new stacked instance over it?  How do you see
> the automount point itself?
>

I didn't get this far ;-)

> I see that the NFS FH encoder doesn't handle automount points.
>
> > If netfs supports export_operations (all except afs do), then indexing
> > the cache objects could be done in a generic manner using fsid and
> > file handle, just like overlayfs index feature works today.
>
> FSID isn't unique and doesn't exist for all filesystems.  Two NFS servers, for
> example, can give you the same FSID, but referring to different things.  AFS
> has a textual cell name and a volume ID that you need to combine; it doesn't
> have an FSID.
>
> This may work for overlayfs as the FSID can be confined to a particular
> overlay.  However, that's not what we're dealing with.  We would be talking
> about an index that potentially covers *all* the mounted netfs.
>
> Also, from your description that sounds like a bug in overlayfs.  If the
> overlain NFS tree does a referral to a different server, you no longer have a
> unique FSID or a unique FH within that FSID so your index is broken.
>

I misspoke. Overlayfs uses s_uuid for index not fsid.
If s_uuid is null or no export ops, then index cannot be used.
So yeh, it's a challenge to auto index the netfs' objects.

> > Would it not be a maintenance win if all (or most of) the fscache logic
> > was yanked out of all the specific netfs's?
>
> Actually, it may not help enormously with disconnected operation.  A certain
> amount of the logic probably has to be implemented in the netfs as each netfs
> provides different facilities for managing this.
>
> Yes, it gets some of the I/O stuff out - but I want to move some of that down
> into the VM if I can and librarifying the rest should take care of that.
>
> > Can you think of reasons why the stackable cachefs model cannot work
> > or why it is inferior to the current fscache integration model with netfs's?
>
> Yes.  It's a lot more operationally expensive and it's harder to use.  The
> cache driver would also have to get a lot bigger, but that would be
> reasonable.
>
> Firstly, the expense: you have to double up all the inodes and dentries that
> are in use - and that's not counting the resources used inside the cache
> itself.

Good point.

>
> Secondly, the administration: I'm assuming you're suggesting the way I think
> Solaris does it and that you have to make two mounts: firstly you mount the
> netfs and then you mount the cache over it.  It's much simpler if you just
> need make the netfs mount only and then that goes and uses the cache if it's
> available - it's also simple to bring the cache online after the fact meaning
> you can even cache applied retroactively to a root filesystem.
>

All of the above is true is you mount the stacked cachefs to begin with.
You can add/remove the caches later.

> You also have the issue of what happens if someone bind-mounts the netfs mount
> and mounts the cache over only one of the views.  Now you have a coherency
> management problem that the cache cannot see.  It's only visible to the netfs,
> but the netfs doesn't know about the cache.
>

The shotgun to shoot the foot you mean - yap.

> There's also file locking.  Overlayfs doesn't support file locking that I can
> see, but NFS, AFS and CIFS all do.
>

Not sure which locks you mean. flock and leases do work on overlayfs AFAIK.
But yes, every one of those things is a challenge with stacked fs, but overlayfs
has already made a lot of progress.

>
> Anyway, you might be able to guess that I'm really against using stackable
> filesystems for things like this and like UID shifting.  I think it adds more
> expense and complexity than it's necessarily worth.
>

Yes, I figured as much :)

> I was more inclined to go with unionfs than overlayfs and do the filesystem
> union in the VFS as it ought to be cheaper if you're using it (whereas
> overlayfs is cheaper if you're not).
>

I guess competition is good.

Anyway, I am brewing a topic about filesystem APIs for
Hierarchic Storage Managers, such as https://vfsforgit.org/.
There are similarities between the requirements for HSM and for
disconnected operations for netfs - you might even say they are
not two different things. So we may want to bring them up together
in the same session or two adjacent sessions - we'll see.

Thanks,
Amir.
