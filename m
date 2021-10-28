Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56243DAAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 07:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1FN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhJ1FNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:13:53 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487FC061570;
        Wed, 27 Oct 2021 22:11:27 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h20so5489531ila.4;
        Wed, 27 Oct 2021 22:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNaNSPK2tFCuaPgGnBuOhirsrQ+K5lrPPmUgJU2qPtQ=;
        b=Q3KrgUvHOxbzZHZt0LNPZ1DnIlBe+EJB0q5byA3V1yuc1BHnntLtHfbB/DNNR5ht+n
         oNRk6GXgyYzRbjacvHZWKFhkrf4r/wVZz3GuATXGB932G79KmzaDbjmPlZlbUtw5oAb7
         j/ozIUGSwoSP9oc4l0gXtq517wGl5Dd9loCPi+bbP1TH31bnrg1L+a3D0Kl5CFj4wbVW
         DCULzuRq7+RnpTS8T/S/wxPfhmMThv9QgLHU6yzcUAHMrb/Vas42kcAASmwQfsLXql6i
         nm/rlJAaPGaJ86H218B/XPHUwH7fOd1ZEPLxMAGdgQInri5B3Mqs8k5b5cTSc6OUizEc
         TmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNaNSPK2tFCuaPgGnBuOhirsrQ+K5lrPPmUgJU2qPtQ=;
        b=L3BQyZPBsn8gk8a/5tMAlVBOiNtd5uk5Jh7UX3q/toRasKaJwUOAHNXPDMNM2uzGyM
         druZwyWPLiXYpf7wzJ7XHIXKOhY7KS/bXg3kAw7D6N5YDruquTWMAJcYeJdeDh3vzmHk
         o0CdNILKBeZ7I1bdTQn9vK6XBQ//y5dEYji71u8fzoWeEi6Tv9LSz/btV1D+TCC+S/+L
         /h89zbgC2PQyyBUtyyn2HeY76qNB2YLukFmLP0O3hr/iskklWI/dk9g5ceO4GV9QXm6c
         wYjNzor0TidzHv26ZBmHyPxa7ospkTmLdt4CkzKGHP5Q5eMhaPnvGfGbiimibShx4KAX
         Hylg==
X-Gm-Message-State: AOAM532lVK2bfnJtGB2qmgR0djIPE26AT8BVHl5B9dMFI68J7b+njRSb
        ArHCxVSY6/K85EuDjyh2uFWBNgPXZdHC/iBNx0g=
X-Google-Smtp-Source: ABdhPJyHDt1KhxuBRr3yUjW9l0E19XotXcPxreBAy2MyfeIWx3Ynn4YoGCOUlh7J04FRiWL2w5p/12YV152Qp4GA2dw=
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr1719683ilv.254.1635397886467;
 Wed, 27 Oct 2021 22:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com> <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com> <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com> <YXm1gzgRUMIPeBK+@redhat.com>
In-Reply-To: <YXm1gzgRUMIPeBK+@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 28 Oct 2021 08:11:15 +0300
Message-ID: <CAOQ4uxjyR3PBgKV2Dfsm8UCALhWpirmEG+yPdooVoqJfEf2XWw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:24 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Oct 27, 2021 at 08:59:15AM +0300, Amir Goldstein wrote:
> > On Tue, Oct 26, 2021 at 10:14 PM Ioannis Angelakopoulos
> > <iangelak@redhat.com> wrote:
> > >
> > >
> > >
> > > On Tue, Oct 26, 2021 at 2:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >>
> > >> On Tue, Oct 26, 2021 at 08:59:44PM +0300, Amir Goldstein wrote:
> > >> > On Tue, Oct 26, 2021 at 7:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >> > >
> > >> > > On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
> > >> > >
> > >> > > [..]
> > >> > > > > 3) The lifetime of the local watch in the guest kernel is very
> > >> > > > > important. Specifically, there is a possibility that the guest does not
> > >> > > > > receive remote events on time, if it removes its local watch on the
> > >> > > > > target or deletes the inode (and thus the guest kernel removes the watch).
> > >> > > > > In these cases the guest kernel removes the local watch before the
> > >> > > > > remote events arrive from the host (virtiofsd) and as such the guest
> > >> > > > > kernel drops all the remote events for the target inode (since the
> > >> > > > > corresponding local watch does not exist anymore).
> > >> > >
> > >> > > So this is one of the issues which has been haunting us in virtiofs. If
> > >> > > a file is removed, for local events, event is generated first and
> > >> > > then watch is removed. But in case of remote filesystems, it is racy.
> > >> > > It is possible that by the time event arrives, watch is already gone
> > >> > > and application never sees the delete event.
> > >> > >
> > >> > > Not sure how to address this issue.
> > >> >
> > >>
> > >> > Can you take me through the scenario step by step.
> > >> > I am not sure I understand the exact sequence of the race.
> > >>
> > >> Ioannis, please correct me If I get something wrong. You know exact
> > >> details much more than me.
> > >>
> > >> A. Say a guest process unlinks a file.
> > >> B. Fuse sends an unlink request to server (virtiofsd)
> > >> C. File is unlinked on host. Assume there are no other users so inode
> > >>    will be freed as well. And event will be generated on host and watch
> > >>    removed.
> > >> D. Now Fuse server will send a unlink request reply. unlink notification
> > >>    might still be in kernel buffers or still be in virtiofsd or could
> > >>    be in virtiofs virtqueue.
> > >> E. Fuse client will receive unlink reply and remove local watch.
> > >>
> > >> Fuse reply and notification event are now traveling in parallel on
> > >> different virtqueues and there is no connection between these two. And
> > >> it could very well happen that fuse reply comes first, gets processed
> > >> first and local watch is removed. And notification is processed right
> > >> after but by then local watch is gone and filesystem will be forced to
> > >> drop event.
> > >>
> > >> As of now situation is more complicated in virtiofsd. We don't keep
> > >> file handle open for file and keep an O_PATH fd open for each file.
> > >> That means in step D above, inode on host is not freed yet and unlink
> > >> event is not generated yet. When unlink reply reaches fuse client,
> > >> it sends FORGET messages to server, and then server closes O_PATH fd
> > >> and then host generates unlink events. By that time its too late,
> > >> guest has already remove local watches (and triggered removal of
> > >> remote watches too).
> > >>
> > >> This second problem probably can be solved by using file handles, but
> > >> basic race will still continue to be there.
> > >>
> > >> > If it is local file removal that causes watch to be removed,
> > >> > then don't drop local events and you are good to go.
> > >> > Is it something else?
> > >>
> > >> - If remote events are enabled, then idea will be that user space gets
> > >>   and event when file is actually removed from server, right? Now it
> > >>   is possible that another VM has this file open and file has not been
> > >>   yet removed. So local event only tells you that file has been removed
> > >>   in guest VM (or locally) but does not tell anything about the state
> > >>   of file on server. (It has been unlinked on server but inode continues
> > >>   to be alive internall).
> > >>
> > >> - If user receives both local and remote delete event, it will be
> > >>   confusing. I guess if we want to see both the events, then there
> > >>   has to be some sort of info in event which classifies whether event
> > >>   is local or remote. And let application act accordingly.
> > >>
> > >> Thanks
> > >> Vivek
> > >>
> > >
> > > Hello Amir!
> > >
> > > Sorry for taking part in the conversation a bit late.  Vivek was on point with the
> > > example he gave but the race is a bit more generic than only the DELETE event.
> > >
> > > Let's say that a guest process monitors an inode for OPEN events:
> > >
> > > 1) The same guest process or another guest process opens the file (related to the
> > > monitored inode), and then closes and immediately deletes the file/inode.
> > > 2) The FUSE server (virtiofsd) will mimic the operations of the guest process:
> > >      a) Will open the file on the host side and thus a remote OPEN event is going to
> > >      be generated on the host and sent to the guest.
> > >      b) Will unlink the remote inode and if no other host process uses the inode then the
> > >      inode will be freed and a DELETE event is going to be generated on the host and sent
> > >      to the guest (However, due to how virtiofsd works and Vivek mentioned, this step won't
> > >      happen immediately)
> > >
> >
> > You are confusing DELETE with DELETE_SELF.
> > DELETE corresponds to unlink(), so you get a DELETE event even if
> > inode is a hardlink
> > with nlink > 0 after unlink().
> >
> > The DELETE event is reported (along with filename) against the parent directory
> > inode, so the test case above won't drop the event.
>
> Hi Amir,
>
> Agreed that there is confusion between DELETE and DELETE_SELF events. I
> think Ioannis is referring to DELETE_SELF event. With this example he
> is trying to emphasize that due to races, problem is not limited to
> DELETE_SELF events only and other events could arrive little later
> after the local watch in guest has been removed and then all those
> events will be dropped as well. So he gave example of OPEN event. And
> I think remote IN_IGNORED might face the same fate.
>
> In the case of IN_IGNORED, I am wondering is it ok to generate that
> event locally instead.
>

Yes, that is what I meant.
Local watch removed can be used as a hint to applications that
events might have been lost.

> >
> > > The problem here is that the OPEN event might still be travelling towards the guest in the
> > > virtqueues and arrives after the guest has already deleted its local inode.
> > > While the remote event (OPEN) received by the guest is valid, its fsnotify
> > > subsystem will drop it since the local inode is not there.
> > >
> >
> > I have a feeling that we are mixing issues related to shared server
> > and remote fsnotify.
> > Does virtiofsd support multiple guests already?
>
> I would like to think that there are not many basic issues with shared
> directory configuration. So we don't stop users from using it.
>
> > There are many other
> > issues related
> > to cache coherency that should be dealt with in this case, some of
> > them overlap the
> > problem that you describe, so solving the narrow problem of dropped
> > remote events
> > seems like the wrong way to approach the problem.
>
> Dropped remote event problem/race will exist even if it was not shared
> server. Remote events travel through different virtqueue as comapred
> to fuse request reply. So there is no guarantee in what order events
> or replies will processed.
>
> >
> > I think that in a shared server situation, the simple LOOKUP/FORGET protocol
> > will not suffice.
>
> Hmm.., So what's the problem with LOOKUP/FORGET in shared dir case?
>

I guess when we say "shared dir" case, we mean different things.
I was thinking about "shared between different client" and about the
fact the information about the server refcount of objects is obscured from
the client.

For example, LOOKUP_INC/DEC requests that report back the server's
shared object refcount could prevent a guest inode from being evicted
in case inode has a remote watch.

But you were mentioning "shared dir with guest and host", so LOOKUP
refcount is not relevant in that case.

> > I will not even try to solve the generic problem,
> > but will just
> > mentioned that SMB/NFS protocols use delegations/oplocks in the protocol
> > to advertise object usage by other clients to all clients.
>
> I think Miklos was looking into the idea of some sort of file leases
> on fuse for creating equivalent of delegations. Not sure if that work
> made any progress.
>
> >
> > I think this issue is far outside the scope of your project and you should
> > just leave the dropped events as a known limitation at this point.
>
> May be that's what we should do to begin with and just say these events
> can be lost or never arrive.
>
> > inotify has the event IN_IGNORED that application can use as a hint that some
> > events could have been dropped.
>
> That probably will require generating IN_IGNORED locally when local watch
> goes away (and not rely on remote IN_IGNORED), IIUC.
>

Right.

Thanks,
Amir.
