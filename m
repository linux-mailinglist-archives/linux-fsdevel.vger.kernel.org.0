Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B955454104
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhKQGoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 01:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhKQGoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:44:07 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A4C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 22:41:09 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id x10so1737009ioj.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 22:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iVK8JRJyhm68OE7PDflDhUDBMxaZsU8Qq50xwjSMVco=;
        b=nki9JZ9gikXSHsLS0RYfoT0cz4prkQglgPbmhPg1BIWmDrfqMGPzLnJkoA04eoy+F/
         B/ZGUuE0exAX3Bs2pDkLsD18N1iWQ1umZNVKjdbZG4YYPXn47Z6O8ELukzZ6nBnDGTNG
         KN7idTyLCEDNGOQU7FJfWiRSLHgLEhRQQTvkQA1hCt7OK8FK/qAXuxBy36m4Ete4n6p9
         9QwIhuTdxkyx25vymEVTQ/Shs+0kmSEdch5GM+kc7GhE4lRW3fZmoQa1ZXAmPNEoiLlZ
         KIdrLDX+lFcCBldRiRhsYfN4mY+zA/fvJdsB5xmUuuUjvjbpuoJtk6m9rCkSHbG9cpZX
         xnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iVK8JRJyhm68OE7PDflDhUDBMxaZsU8Qq50xwjSMVco=;
        b=y3dAi/uDz+fXRY4Egd+prOPzpEnfg3QbRvrNOX4PqyzWpk5lS1oyK6TS8DJvj0UA04
         owjDXm6I2IAGb3/mnc2r0C+zWn8Bcb9fw5lCShci1Q6lzIRVjsbq5mRa8MjxDnOtM72U
         li8DUj9trT91b/IFNfgcvTLF4p378YqvTzmRZiED7T6r0MPMt92zzDlVFeMZ3yZUAnMW
         fAQa4JdgV9Zgowpox/g4m6jBxTRYgiNh2hg5a89V81wJaj8FvzT1yhF0caSJxSMZxwMc
         3eifmZRX1OxiqEpy5eC3enWnnMNJRWiEr1vV9vlmJVmDLQASW1Aj6uvInss8Qoy4PKV4
         uPLA==
X-Gm-Message-State: AOAM5333BxH0JDfrnvN6aXxnKE88CkCMHsCQV2b887n2azN3p5c5093+
        VUu0TF3z3HboxaaJt3YIRikBlYsvxWPQPqG+WNU=
X-Google-Smtp-Source: ABdhPJzGSWESFwQTeGkUZ+BgK9PPw27vjULVp6UqN9muQz/ewual1BpkbX3wJTene4RLZ1DMZLhxhAHTDX4Gc7BGkl0=
X-Received: by 2002:a02:a489:: with SMTP id d9mr10832402jam.47.1637131268667;
 Tue, 16 Nov 2021 22:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz> <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com> <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz> <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com> <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
In-Reply-To: <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Nov 2021 08:40:57 +0200
Message-ID: <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:12 AM Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
>
>
> On Tue, Nov 16, 2021 at 12:10 AM Stef Bon <stefbon@gmail.com> wrote:
>>
>> Hi Ioannis,
>>
>> I see that you have been working on making fsnotify work on virtiofs.
>> Earlier you contacted me since I've written this:
>>
>> https://github.com/libfuse/libfuse/wiki/Fsnotify-and-FUSE
>>
>> and send you my patches on 23 june.
>> I want to mention first that I would have appreciated it if you would
>> have reacted to me after I've sent you my patches. I did not get any
>> reaction from you. Maybe these patches (which differ from what you
>> propose now, but there is also a lot in common) have been an
>> inspiration for you.
>>
>> Second, what I've written about is that with network filesystems (eg a
>> backend shared with other systems) fsnotify support in FUSE has some
>> drawbacks.
>> In a network environment, where a network fs is part of making people
>> collaborate, it's very useful to have information on who did what on
>> which host, and also when. Simply a message "a file has been created
>> in the folder you watch" is not enough. For example, if you are part
>> of a team, and assigned to your team is a directory on a server where
>> you can work on some shared documents. Now in this example there is a
>> planning, and some documents have to be written. In that case you want
>> to be informed that someone in your team has started a document (by
>> creating it) by the system.
>>
> I agree that the out of band approach you propose is actually more powerf=
ul, since it can
> provide the client with more information than remote fsnotify. However, i=
n the virtiofs setup
> your approach might not be as efficient.
>
> Specifically, the information on who did what might not make sense to the=
 guest within QEMU, since all the
> virtiofs filesystem operations are handled by viritofsd on the host and t=
he guest does not know about the
> server or any other guests. Vivek, correct me here if I am wrong.
>
> Thus, for now at least, it might be sufficient for the guest to know that=
 just a remote event
> occurred.
>
>> This "extended" information will never get through fsnotify.
>>
>> Other info useful to you as team member:
>>
>> -  you have become member of another team: sbon@anotherteam.example.org
>> -  diskspace and/or quota shortage reported by networksystem
>> -  new teammember, teammember left
>> -  your "rights" or role in the network/team have been changed (for
>> example from reader to reader and writer to some documents)
>>
>> What I want to say is that in a network where lots of people work
>> together in teams/projects, (and I want Linux to play a role there, as
>> desktop/workstation) communication is very important, and all these
>> messages should be supported by the system. My idea is the support of
>> watching fs events with FUSE filesystems should go through userspace,
>> and not via the kernel (cause fs events are part of your setup in the
>> network, together with all other tools to make people collaborate like
>> chat/call/text, and because mentioned above extended info about the
>> who on what host etc is not supported by fsnotify).
>> There should be a fs event watcher which takes care of all watches on
>> behalf of applications during a session, similar to gamin and FAM once
>> did (not used anymore?).
>> When receiving a request from one of the applications this fsevent
>> watcher will use inotify and/or fanotify for local fs's only. With a
>> FUSE fs, it should contact (via a socket) this fs that a watch has
>> been set on an inode with a certain mask.
>> If the FUSE fs does not support this, fallback on normal inotify/fanotif=
y.
>> This way extended info is possible.
>>
>> Is this extended information also useful for virtiofs?
>>
> Also based on your explanation, your out of band approach is specific to =
FUSE filesystems.
> Granted, with your approach there is less complexity in the kernel and mo=
re flexibility since
> the event notification occurs solely in user-space.
> However, during the discussion with Amir and Jan about potential routes w=
e could take to support the remote
> fanotify/inotify/fsnotify one important concern was that the API should b=
e able to support other
> network/remote filesystems if needed and not only FUSE filesystems.
> It seems that your approach would require a lot of work (correct me if I =
am wrong) to be adopted
> by other network filesystems.
>
> Finally, user-space applications should also be aware of your new API, wh=
ich will probably result in a non-negligible effort by app developers to ad=
opt it or change their existing apps. The remote inotify/fsnotify ( the cur=
rent implementation) even though it has many limitations, relies on the exi=
sting API and should require less modifications in user space apps. That is=
 why we chose the remote inotify/fsnotify route.
>

The way you depict the options seems like either applications are not
aware of the UAPI
changes or they need to be modified to adapt to the changes.

I actually think that the much better approach would be to deal with
most of the UAPI
complexity in a library, so applications may need to be rebuilt or
adapted to use a new
library, but going forward, the library would abstract most of the
complexity from the
applications.

The holy grail would be a portable library, such as this go library [1].
It is quite hard to design an API that would abstract all the
different capabilities
on Linux-inotify/Linux-fanotify/MacOS-fsevents/Win-USNJournal and more.

The second best would be a library to abstract the ever growing complexity
of Linux inotify/fanotify UAPI from applications.
I had already made the first step with adapting libinotifytools to fanotify=
 [2].
We could continue down that path or start creating/improving a
different library.

The point is that abstracting different capabilities of remote fs notificat=
ions
(i.e. cifs, virtiofs, generic FUSE) is going to be challenging, so starting=
 the
design from a user library API and deriving the needed pieces from the
kernel UAPI is the right way to go IMO.

The library approach will have the advantage that some remote fs capabiliti=
es
(e.g. for cifs) will be available for old kernels as well and in
theory, the library
could also use some standardized OOB notifications channel to get changed
made on the host from VM guest tools as Stef proposed.

> That said, I do not see a reason why both implementations cannot co-exist
> and have the user-space applications choose which approach they want.
>

True, an OOB channel and kernel generic remote fs support can both exist,
but it would be best if the application was not aware of either.
The library would pick the facility based on the requested functionality,
availability of the facilities in the filesystem and sysadmin/user policy.

Thanks,
Amir.

[1] https://github.com/fsnotify/fsnotify
[2] https://github.com/inotify-tools/inotify-tools/pull/134
