Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203333976F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhFAPoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhFAPoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:44:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C35C061574;
        Tue,  1 Jun 2021 08:42:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z24so15811449ioi.3;
        Tue, 01 Jun 2021 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/jl7FF0zONs4aFFAvjVG1zzDWVrAeOG8tm6IIw/Zz0=;
        b=JL5+6X5lvC1sJYddcwPfRu0aUobkyw1isBYSaystu03ReFHJYrTs7ZO9CIrwPchc9E
         qJlYmk6IsaITX2ibuWIIswIDflB5FoJ6j/nKvjkwrcUkvF7DGXjpTxQ/ib+7w83r3YaM
         QmAsJvtWZHjDJEQoPFsK0D5ol9dj2SvizG8IBIULs4b2+aOpfFqDXI1N7vbDSLVs8+aB
         tUkOLWhcBYhbCR4zoXYSeLegCNwJltzfRY/bwDXG6HWvDQA3I1h+vSHt3MScvuuWwkNA
         mQEBcCGMjhz2qGgGV1zrV/5KY7SLpha59AuKjRHBJXDqRcJ7R+64cK+tbgWr1HDY4hUv
         dxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/jl7FF0zONs4aFFAvjVG1zzDWVrAeOG8tm6IIw/Zz0=;
        b=XUMMibJmCya2SdCf4z5s3Mz6PFyicJiq/AoGFwDpAJ0lXVkUMZB4UwcWxKlWCbMsF2
         egCtQ2NfLKbMEH3foVE3BL6u3paLQA8qVbdpbmsBzpOFPYpArORZXPjzU0kWjeroYxf0
         5OIKY9Y3WUwy0PQx2+BKxsKNu2eYjqxMVBQvRU8A6sWpP0/vV3NQuyRZx875qDq+1PPv
         ZAwnsubPUZ/5qdD0LaF5AkigXW5386QNmuSdKJqsmU6dnhJE1zxQfQZin+NPtimf8vBV
         D9JBVENveCft+3MWpqmzcX5zybKRfax4pr0a+BFqxOhj7u1JXPIujWYbtm1fNb6Oq6Re
         8Zrw==
X-Gm-Message-State: AOAM530AQmrvLQDo0mYZg6KLge1c0rT2j4XGiRzX8Lzz69EgVQOf0v+V
        liQ0BEIcXWNBMdlBuDvsuJhfT0Jj24ayThkyWjpFGJguJII=
X-Google-Smtp-Source: ABdhPJym+6dIXV5TjB6CvyuBoqf23mIYV+IxrcWdv5+cvpxl3RWqoi9m5ots7EMjZoqqb1twtLbaAkEfR2QwrnqoCzw=
X-Received: by 2002:a5d:8a16:: with SMTP id w22mr21476254iod.186.1622562151302;
 Tue, 01 Jun 2021 08:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
 <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
 <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com>
 <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
 <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com> <20210601144909.GC24846@redhat.com>
In-Reply-To: <20210601144909.GC24846@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Jun 2021 18:42:20 +0300
Message-ID: <CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 1, 2021 at 5:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, May 31, 2021 at 09:12:59PM +0300, Amir Goldstein wrote:
> > On Mon, May 31, 2021 at 5:11 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Sat, 29 May 2021 at 18:05, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 23, 2020 at 2:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Wed, Sep 23, 2020 at 11:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > >
> > > > > > > > I think that the proper was to implement reliable persistent file
> > > > > > > > handles in fuse/virtiofs would be to add ENCODE/DECODE to
> > > > > > > > FUSE protocol and allow the server to handle this.
> > > > > > >
> > > > > > > Max Reitz (Cc-d) is currently looking into this.
> > > > > > >
> > > > > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > > > > normally for all other operations.
> > > > > > >
> > > >
> > > > Miklos, Max,
> > > >
> > > > Any updates on LOOKUP_HANDLE work?
> > > >
> > > > > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > > > > based fs) would be that userspace need not keep a refcounted object
> > > > > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > > > > based cache at any time.   If that happens and a request from the
> > > > > > > client (kernel) comes in with a stale node ID, the server will return
> > > > > > > -ESTALE and the client can ask for a new node ID with a special
> > > > > > > lookup_handle(fh, NULL).
> > > > > > >
> > > > > > > Disadvantages being:
> > > > > > >
> > > > > > >  - cost of generating a file handle on all lookups
> > > > > >
> > > > > > I never ran into a local fs implementation where this was expensive.
> > > > > >
> > > > > > >  - cost of storing file handle in kernel icache
> > > > > > >
> > > > > > > I don't think either of those are problematic in the virtiofs case.
> > > > > > > The cost of having to keep fds open while the client has them in its
> > > > > > > cache is much higher.
> > > > > > >
> > > > > >
> > > > > > Sounds good.
> > > > > > I suppose flock() does need to keep the open fd on server.
> > > > >
> > > > > Open files are a separate issue and do need an active object in the server.
> > > > >
> > > > > The issue this solves  is synchronizing "released" and "evicted"
> > > > > states of objects between  server and client.  I.e. when a file is
> > > > > closed (and no more open files exist referencing the same object) the
> > > > > dentry refcount goes to zero but it remains in the cache.   In this
> > > > > state the server could really evict it's own cached object, but can't
> > > > > because the client can gain an active reference at any time  via
> > > > > cached path lookup.
> > > > >
> > > > > One other solution would be for the server to send a notification
> > > > > (NOTIFY_EVICT) that would try to clean out the object from the server
> > > > > cache and respond with a FORGET if successful.   But I sort of like
> > > > > the file handle one better, since it solves multiple problems.
> > > > >
> > > >
> > > > Even with LOOKUP_HANDLE, I am struggling to understand how we
> > > > intend to invalidate all fuse dentries referring to ino X in case the server
> > > > replies with reused ino X with a different generation that the one stored
> > > > in fuse inode cache.
> > > >
> > > > This is an issue that I encountered when running the passthrough_hp test,
> > > > on my filesystem. In tst_readdir_big() for example, underlying files are being
> > > > unlinked and new files created reusing the old inode numbers.
> > > >
> > > > This creates a situation where server gets a lookup request
> > > > for file B that uses the reused inode number X, while old file A is
> > > > still in fuse dentry cache using the older generation of real inode
> > > > number X which is still in fuse inode cache.
> > > >
> > > > Now the server knows that the real inode has been rused, because
> > > > the server caches the old generation value, but it cannot reply to
> > > > the lookup request before the old fuse inode has been invalidated.
> > > > IIUC, fuse_lowlevel_notify_inval_inode() is not enough(?).
> > > > We would also need to change fuse_dentry_revalidate() to
> > > > detect the case of reused/invalidated inode.
> > > >
> > > > The straightforward way I can think of is to store inode generation
> > > > in fuse_dentry. It won't even grow the size of the struct.
> > > >
> > > > Am I over complicating this?
> > >
> > > In this scheme the generation number is already embedded in the file
> > > handle.  If LOOKUP_HANDLE returns a nodeid that can be found in the
> > > icache, but which doesn't match the new file handle, then the old
> > > inode will be marked bad and a new one allocated.
> > >
> > > Does that answer your worries?  Or am I missing something?
> >
> > It affirms my understanding of the future implementation, but
> > does not help my implementation without protocol changes.
> > I thought I could get away without LOOKUP_HANDLE for
> > underlying fs that is able to resolve by ino, but seems that I still have an
> > unhandled corner case, so will need to add some kernel patch.
> > Unless there is already a way to signal from server to make the
> > inode bad in a synchronous manner (I did not find any) before
> > replying to LOOKUP with a new generation of the same ino.
> >
> > Any idea about the timeline for LOOKUP_HANDLE?
> > I may be able to pick this up myself if there is no one actively
> > working on it or plans for anyone to make this happen.
>
> AFAIK, right now max is not actively looking into LOOKUP_HANDLE.
>
> To solve the issue of virtiofs server having too many fds open, he
> is now planning to store corresonding file handle in server and use
> that to open fd later.
>
> But this does not help with persistent file handle issue for fuse
> client.
>

I see. Yes that should work, but he'd still need to cope with reused
inode numbers in case you allow unlinks from the host (do you?),
because LOOKUP can find a host fs inode that does not match
the file handle of a previously found inode of the same ino.

Quoting Miklos' response above:
> > > If LOOKUP_HANDLE returns a nodeid that can be found in the
> > > icache, but which doesn't match the new file handle, then the old
> > > inode will be marked bad and a new one allocated.

This statement, with minor adjustments is also true for LOOKUP:

"If LOOKUP returns a nodeid that can be found in the icache, but
 whose i_generation doesn't match the generation returned in outarg,
 then the old inode should be marked bad and a new one allocated."

> BTW, one concern with file handles coming from guest kernel was that
> how to trust those handles. Guest can create anything and use
> file server to open the files on same filesystem (but not shared
> with guest).
>
> I am assuming same concern should be there with non-virtiofs use
> cases. Regular fuse client must be sending a file handle and
> file server is running with CAP_DAC_READ_SEARCH. How will it make
> sure that client is not able to access files not exported through
> shared directory but are present on same filesystem.
>

That is a concern.
It's the same concern for NFS clients that can guess file handles.

The ways to address this concern with NFS is the export option
subtree_check, but that uses non unique file handles to an inode
which include a parent handle, so that's probably not a good fit for
LOOKUP_HANDLE.

If there are no plans to go forward with LOOKUP_HANDLE, I may
respin my protosal to add  ENCODE/DECODE to FUSE protocol
in place of the lookup(".") command.

Thanks,
Amir.
