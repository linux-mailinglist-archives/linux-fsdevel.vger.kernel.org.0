Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96843C278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 07:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhJ0GBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJ0GBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:01:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04AC061570;
        Tue, 26 Oct 2021 22:59:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i14so2196114ioa.13;
        Tue, 26 Oct 2021 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuRz+OYQVMsScVbvmrIx+5JsyCK+sTWUWuau+Q2qn4s=;
        b=Nq20B0h2nKe5+vdzWT2LlxzQ4Cmtty4hgkMz5EvC2prsFnAoJXVm4QDy3FjJyhbGO8
         XDKVGwsfgT2AJtWkkYzddeRhJThQ5t2ssBu9uqRodKb1hqeapcGeTD4DjQSBd8ddO9Ko
         yh0DIk3zOvo5+Oinyz0FjkqPln/ezDfaR4xUne8OMTGhA8kwTg7pE7OIrG7CvBFfD9NR
         4j2OooZr84h/ehgSyJ3E/OK++Y1YLMSgkdA15fMvjSYk3c+oyHSmfaIHwlUJUFgaJYwM
         ZwhsZ2E/F4bVlg2Yif6QUsKaxiqLo0bdlbe6Pk55G1avErzhNQbMaX8yClQ661Sr5AlH
         633g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuRz+OYQVMsScVbvmrIx+5JsyCK+sTWUWuau+Q2qn4s=;
        b=oRWueSVzpz56uYRodWJXNLXFvIOhrbinKnXvg9vqh/QxXKK2HXPjQqux+rq+h4QXfs
         I4xnhHs8lC5z/pmLBclbpD1tzuql16PPrh1sYYV8zWADIx/yNaFuWJeAuQFOqcJlo9lI
         Kr1KBwONgAYYN4/oJ4MnlnvHF0IGPfQm5Us2G2R28qAMSGQjP7YwdBBUT3dIM4ImlnDl
         dJf6mT07CPfWVMrsiprt4BNopYjANu9kO1iF5czWQtG0A82YGiPTkzJxWrlx//C5DXB7
         wMJTrwgBlwTGoPIGo3j3TQbE167gIf6DqTCELVa+Bop3bsLMAcweSIeikk87/1s6aERz
         JKdQ==
X-Gm-Message-State: AOAM5320YQ1Grn8ZlxevFUu0pCcZ0wRhnNYLepHL2NQ5RI45RyOAxS3Q
        cvm3c6loNc9pKml7rhdgKRHAWxoHX25zeTmOkHdLuzX6bnQ=
X-Google-Smtp-Source: ABdhPJzAcGouJunxLwEmGRXAM5byL65P8M4ZQ72bgADh8UMZBm2e6Ec0jlKfNmdhLHcRis1yx+qEEXtJvnmKaRrQZUE=
X-Received: by 2002:a5e:c018:: with SMTP id u24mr18431719iol.197.1635314367342;
 Tue, 26 Oct 2021 22:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com> <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com> <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
In-Reply-To: <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 08:59:15 +0300
Message-ID: <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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

On Tue, Oct 26, 2021 at 10:14 PM Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
>
>
> On Tue, Oct 26, 2021 at 2:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>> On Tue, Oct 26, 2021 at 08:59:44PM +0300, Amir Goldstein wrote:
>> > On Tue, Oct 26, 2021 at 7:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>> > >
>> > > On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
>> > >
>> > > [..]
>> > > > > 3) The lifetime of the local watch in the guest kernel is very
>> > > > > important. Specifically, there is a possibility that the guest does not
>> > > > > receive remote events on time, if it removes its local watch on the
>> > > > > target or deletes the inode (and thus the guest kernel removes the watch).
>> > > > > In these cases the guest kernel removes the local watch before the
>> > > > > remote events arrive from the host (virtiofsd) and as such the guest
>> > > > > kernel drops all the remote events for the target inode (since the
>> > > > > corresponding local watch does not exist anymore).
>> > >
>> > > So this is one of the issues which has been haunting us in virtiofs. If
>> > > a file is removed, for local events, event is generated first and
>> > > then watch is removed. But in case of remote filesystems, it is racy.
>> > > It is possible that by the time event arrives, watch is already gone
>> > > and application never sees the delete event.
>> > >
>> > > Not sure how to address this issue.
>> >
>>
>> > Can you take me through the scenario step by step.
>> > I am not sure I understand the exact sequence of the race.
>>
>> Ioannis, please correct me If I get something wrong. You know exact
>> details much more than me.
>>
>> A. Say a guest process unlinks a file.
>> B. Fuse sends an unlink request to server (virtiofsd)
>> C. File is unlinked on host. Assume there are no other users so inode
>>    will be freed as well. And event will be generated on host and watch
>>    removed.
>> D. Now Fuse server will send a unlink request reply. unlink notification
>>    might still be in kernel buffers or still be in virtiofsd or could
>>    be in virtiofs virtqueue.
>> E. Fuse client will receive unlink reply and remove local watch.
>>
>> Fuse reply and notification event are now traveling in parallel on
>> different virtqueues and there is no connection between these two. And
>> it could very well happen that fuse reply comes first, gets processed
>> first and local watch is removed. And notification is processed right
>> after but by then local watch is gone and filesystem will be forced to
>> drop event.
>>
>> As of now situation is more complicated in virtiofsd. We don't keep
>> file handle open for file and keep an O_PATH fd open for each file.
>> That means in step D above, inode on host is not freed yet and unlink
>> event is not generated yet. When unlink reply reaches fuse client,
>> it sends FORGET messages to server, and then server closes O_PATH fd
>> and then host generates unlink events. By that time its too late,
>> guest has already remove local watches (and triggered removal of
>> remote watches too).
>>
>> This second problem probably can be solved by using file handles, but
>> basic race will still continue to be there.
>>
>> > If it is local file removal that causes watch to be removed,
>> > then don't drop local events and you are good to go.
>> > Is it something else?
>>
>> - If remote events are enabled, then idea will be that user space gets
>>   and event when file is actually removed from server, right? Now it
>>   is possible that another VM has this file open and file has not been
>>   yet removed. So local event only tells you that file has been removed
>>   in guest VM (or locally) but does not tell anything about the state
>>   of file on server. (It has been unlinked on server but inode continues
>>   to be alive internall).
>>
>> - If user receives both local and remote delete event, it will be
>>   confusing. I guess if we want to see both the events, then there
>>   has to be some sort of info in event which classifies whether event
>>   is local or remote. And let application act accordingly.
>>
>> Thanks
>> Vivek
>>
>
> Hello Amir!
>
> Sorry for taking part in the conversation a bit late.  Vivek was on point with the
> example he gave but the race is a bit more generic than only the DELETE event.
>
> Let's say that a guest process monitors an inode for OPEN events:
>
> 1) The same guest process or another guest process opens the file (related to the
> monitored inode), and then closes and immediately deletes the file/inode.
> 2) The FUSE server (virtiofsd) will mimic the operations of the guest process:
>      a) Will open the file on the host side and thus a remote OPEN event is going to
>      be generated on the host and sent to the guest.
>      b) Will unlink the remote inode and if no other host process uses the inode then the
>      inode will be freed and a DELETE event is going to be generated on the host and sent
>      to the guest (However, due to how virtiofsd works and Vivek mentioned, this step won't
>      happen immediately)
>

You are confusing DELETE with DELETE_SELF.
DELETE corresponds to unlink(), so you get a DELETE event even if
inode is a hardlink
with nlink > 0 after unlink().

The DELETE event is reported (along with filename) against the parent directory
inode, so the test case above won't drop the event.

> The problem here is that the OPEN event might still be travelling towards the guest in the
> virtqueues and arrives after the guest has already deleted its local inode.
> While the remote event (OPEN) received by the guest is valid, its fsnotify
> subsystem will drop it since the local inode is not there.
>

I have a feeling that we are mixing issues related to shared server
and remote fsnotify.
Does virtiofsd support multiple guests already? There are many other
issues related
to cache coherency that should be dealt with in this case, some of
them overlap the
problem that you describe, so solving the narrow problem of dropped
remote events
seems like the wrong way to approach the problem.

I think that in a shared server situation, the simple LOOKUP/FORGET protocol
will not suffice. I will not even try to solve the generic problem,
but will just
mentioned that SMB/NFS protocols use delegations/oplocks in the protocol
to advertise object usage by other clients to all clients.

I think this issue is far outside the scope of your project and you should
just leave the dropped events as a known limitation at this point.
inotify has the event IN_IGNORED that application can use as a hint that some
events could have been dropped.

Thanks,
Amir.
