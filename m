Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D214869B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbgAXONP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 09:13:15 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44264 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgAXONP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:13:15 -0500
Received: by mail-il1-f196.google.com with SMTP id f16so1683127ilk.11;
        Fri, 24 Jan 2020 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB10ZZUnLvANYACtUQc8/4YA+sn7LlgmSN6HKCiGQ6M=;
        b=Pn+I8Xq41BYpBqVdsWmiOhei6UG0NvwX+wV2OFNsVsyMuB3YoeEDczR3EtfgvFrgHo
         82PX+tr4KXLYn6wE/eOKuKCMiDULa2ftJQSLT2y7mHX2XEjzMS6uqnMpJc9fd6z4fYne
         aMLcMphFk0PRtvozTEw97qdCG6xHYqYfCsxmwbdpFYuxaqTRVNAhzex5U2pwqkJOzNAC
         8WNcd2KVY0/1wDPVtn91+VS9ZhZooG8rRyytT5j2Tx/eqFz+wjFxIT0EKLxZgFjqg4LQ
         meIYniDCY/vS8fPt+nOGL4mLptPmUEREnKRCtf8UL/tXWTV43TY1lAJN4vDJzzoZBdip
         RJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB10ZZUnLvANYACtUQc8/4YA+sn7LlgmSN6HKCiGQ6M=;
        b=TVnknyLgwoohV/XncYFyKPomYi8Jnd+lTPDx96rwCx99Tyfle4wtGwSwCCa0v2qhWB
         33yh6lav8D/CNINqIlX1CJNRGzrUi2Gy8LlKcSCIXRrEY0RNR0PqtWZbgaHe5LJzzbp4
         lI+i6ao5hIg0BQBNI1aD6e+vLf+ESQne6lfMhrdi13nWm6tJQMatcA9vE/b1kxWBbkza
         MwnfaB62iK7PwUz0Sdm2lUGmzJiwsG5mtVMfftWrY+4iBJzkYdxKb+JUU0VoMxacO0Hg
         9K9kkSzoPc8bF9x33w3Aeq9awJPYMf0pm2tmdSOzWAPJk48HSKftnjeANke+aelvG6jk
         +jlg==
X-Gm-Message-State: APjAAAW/Kk5YCUgiWw84dPC2Fu21aJTT8K47iYtZx9AqOokYePUxnM+m
        fMk1gQfqq10JfCuCGxBfnjrlbEEg9IOCcXQZj8M=
X-Google-Smtp-Source: APXvYqwOn4X0Jn8qWFnH0A345GGiE2LkBFBhptKaDSs2hdLlqosjpR1c25ghcbRjL8VlMHofmAokyAT8Ax4oyDrSLKQ=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr3391684ili.72.1579875194363;
 Fri, 24 Jan 2020 06:13:14 -0800 (PST)
MIME-Version: 1.0
References: <14196.1575902815@warthog.procyon.org.uk> <CAOQ4uxj7RhrBnWb3Lqi3hHLuXNkVXrKio398_PAEczxfyW7HsA@mail.gmail.com>
In-Reply-To: <CAOQ4uxj7RhrBnWb3Lqi3hHLuXNkVXrKio398_PAEczxfyW7HsA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jan 2020 16:13:02 +0200
Message-ID: <CAOQ4uxicFmiFKz7ZkHYuzduuTDaCTDqo26fo02-VjTMmQaaf+A@mail.gmail.com>
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

On Mon, Dec 9, 2019 at 7:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 9, 2019 at 4:47 PM David Howells <dhowells@redhat.com> wrote:
> >
> > I've been rewriting fscache and cachefiles to massively simplify it and make
> > use of the kiocb interface to do direct-I/O to/from the netfs's pages which
> > didn't exist when I first did this.
> >
> >         https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
> >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> >
> > I'm getting towards the point where it's working and able to do basic caching
> > once again.  So now I've been thinking about what it'd take to support
> > disconnected operation.  Here's a list of things that I think need to be
> > considered or dealt with:
> >
> >  (1) Making sure the working set is present in the cache.
> >
> >      - Userspace (find/cat/tar)
> >      - Splice netfs -> cache
> >      - Metadata storage (e.g. directories)
> >      - Permissions caching
> >
> >  (2) Making sure the working set doesn't get culled.
> >
> >      - Pinning API (cachectl() syscall?)
> >      - Allow culling to be disabled entirely on a cache
> >      - Per-fs/per-dir config
> >
> >  (3) Switching into/out of disconnected mode.
> >
> >      - Manual, automatic
> >      - On what granularity?
> >        - Entirety of fs (eg. all nfs)
> >        - By logical unit (server, volume, cell, share)
> >
> >  (4) Local changes in disconnected mode.
> >
> >      - Journal
> >      - File identifier allocation
> >      - statx flag to indicate provisional nature of info
> >      - New error codes
> >         - EDISCONNECTED - Op not available in disconnected mode
> >         - EDISCONDATA - Data not available in disconnected mode
> >         - EDISCONPERM - Permission cannot be checked in disconnected mode
> >         - EDISCONFULL - Disconnected mode cache full
> >      - SIGIO support?
> >
> >  (5) Reconnection.
> >
> >      - Proactive or JIT synchronisation
> >        - Authentication
> >      - Conflict detection and resolution
> >          - ECONFLICTED - Disconnected mode resolution failed
> >      - Journal replay
> >      - Directory 'diffing' to find remote deletions
> >      - Symlink and other non-regular file comparison
> >
> >  (6) Conflict resolution.
> >
> >      - Automatic where possible
> >        - Just create/remove new non-regular files if possible
> >        - How to handle permission differences?
> >      - How to let userspace access conflicts?
> >        - Move local copy to 'lost+found'-like directory
> >          - Might not have been completely downloaded
> >        - New open() flags?
> >          - O_SERVER_VARIANT, O_CLIENT_VARIANT, O_RESOLVED_VARIANT
> >        - fcntl() to switch variants?
> >
> >  (7) GUI integration.
> >
> >      - Entering/exiting disconnected mode notification/switches.
> >      - Resolution required notification.
> >      - Cache getting full notification.
> >
> > Can anyone think of any more considerations?  What do you think of the
> > proposed error codes and open flags?  Is that the best way to do this?
> >
>
> Hi David,
>
> I am very interested in this topic.
> I can share (some) information from experience with a "Caching Gateway"
> implementation in userspace shipped in products of my employer, CTERA.
>
> I have come across several attempts to implement a network fs cache
> using overlayfs. I don't remember by whom, but they were asking
> questions on overlayfs list about online modification to lower layer.
>
> It is not so far fetched, as you get many of the requirements for metadata
> caching out-of-the-box, especially with recent addition of metacopy feature.
> Also, if you consider the plans to implement overlayfs page cache [1][2],
> then at least the read side of fscache sounds like it has some things in
> common with overlayfs.
>
> Anyway, you should know plenty about overlayfs to say if you think
> there is any room for collaboration between the two projects.
>
>
> [1] https://marc.info/?l=linux-unionfs&m=154995746503505&w=2
> [2] https://github.com/amir73il/linux/commits/ovl-aops-wip

David,

I have been reading through the fscache APIs and tried to answer this
(maybe stupid) question:

Why does every netfs need to implement fscache support on its own?
fscache support as it is today is extremely intrusive to filesystem code
and your re-write doesn't make it any less intrusive.

My thinking is: Can't we implement a stackable cachefs which interfaces
with fscache and whose API to the netfs is pure vfs APIs, just like
overlayfs interfaces with lower fs?

The only fscache API I could find that really needs to be called from
netfs code is fscache_invalidate() and many of those calls are invoked
from vfs ops anyway, so maybe they could also be hoisted to this cachefs.

As long as netfs supports direct_IO() (all except afs do) then the active page
cache could be that of the stackable cachefs and network IO is always
direct from/to cachefs pages.

If netfs supports export_operations (all except afs do), then indexing
the cache objects could be done in a generic manner using fsid and
file handle, just like overlayfs index feature works today.

Would it not be a maintenance win if all (or most of) the fscache logic
was yanked out of all the specific netfs's?

Can you think of reasons why the stackable cachefs model cannot work
or why it is inferior to the current fscache integration model with netfs's?

Thanks,
Amir.
