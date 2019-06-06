Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8149F37AA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfFFRMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 13:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbfFFRMK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:12:10 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF16208E4
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559841129;
        bh=eGMr7DoLIYR8UAjWgzFrqPiUh2ExP+Mttqzga+MgnkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0hle2nhbR2j30aFu/wj5a0oPnKJKZaOV8Iaj4zpzbUwG5TNgRZ1Y9cEdYTe26tZBj
         NU4NTwPAOst0j9szSsplymqFiuVyIz26Rl29hS116ruQRNEobofla7Fn5qSJ/oY4Jx
         8n+xJ+5eQNp4TG+D3Fmjjbh8SPCHloL2hK8Or5cU=
Received: by mail-wm1-f42.google.com with SMTP id w9so2286859wmd.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 10:12:09 -0700 (PDT)
X-Gm-Message-State: APjAAAX54CJ0b3eJjjQeZfz3yeBB8GkVXKYC1UGm/YAQ5qqkgl0MmFE9
        59U5FxN4FM0+OE1fH4ZKmM20LysPuSyA7WNgddEokA==
X-Google-Smtp-Source: APXvYqxF2/aZhWBhL7/nZs8kAI6o4jWXCnyQL0WIhGhKQNoGeALkczoYjn7lAoJ1sviKMS+lCfqerwAfZZ7eqb0UxSQ=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr802034wmi.0.1559841127574;
 Thu, 06 Jun 2019 10:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
 <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
In-Reply-To: <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 10:11:56 -0700
X-Gmail-Original-Message-ID: <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com>
Message-ID: <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 9:43 AM Casey Schaufler <casey@schaufler-ca.com> wro=
te:
>
> On 6/6/2019 7:05 AM, Stephen Smalley wrote:
> > On 6/6/19 9:16 AM, David Howells wrote:
> >> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> This might be easier to discuss if you can reply to:
> >>
> >>     https://lore.kernel.org/lkml/5393.1559768763@warthog.procyon.org.u=
k/
> >>
> >> which is on the ver #2 posting of this patchset.
> >
> > Sorry for being late to the party.  Not sure whether you're asking me t=
o respond only there or both there and here to your comments below.  I'll s=
tart here but can revisit if it's a problem.
> >>
> >>>> LSM support is included, but controversial:
> >>>>
> >>>>    (1) The creds of the process that did the fput() that reduced the=
 refcount
> >>>>        to zero are cached in the file struct.
> >>>>
> >>>>    (2) __fput() overrides the current creds with the creds from (1) =
whilst
> >>>>        doing the cleanup, thereby making sure that the creds seen by=
 the
> >>>>        destruction notification generated by mntput() appears to com=
e from
> >>>>        the last fputter.
> >>>>
> >>>>    (3) security_post_notification() is called for each queue that we=
 might
> >>>>        want to post a notification into, thereby allowing the LSM to=
 prevent
> >>>>        covert communications.
> >>>>
> >>>>    (?) Do I need to add security_set_watch(), say, to rule on whethe=
r a watch
> >>>>        may be set in the first place?  I might need to add a variant=
 per
> >>>>        watch-type.
> >>>>
> >>>>    (?) Do I really need to keep track of the process creds in which =
an
> >>>>        implicit object destruction happened?  For example, imagine y=
ou create
> >>>>        an fd with fsopen()/fsmount().  It is marked to dissolve the =
mount it
> >>>>        refers to on close unless move_mount() clears that flag.  Now=
, imagine
> >>>>        someone looking at that fd through procfs at the same time as=
 you exit
> >>>>        due to an error.  The LSM sees the destruction notification c=
ome from
> >>>>        the looker if they happen to do their fput() after yours.
> >>>
> >>>
> >>> I'm not in favor of this approach.
> >>
> >> Which bit?  The last point?  Keeping track of the process creds after =
an
> >> implicit object destruction.
> >
> > (1), (2), (3), and the last point.
> >
> >>> Can we check permission to the object being watched when a watch is s=
et
> >>> (read-like access),
> >>
> >> Yes, and I need to do that.  I think it's likely to require an extra h=
ook for
> >> each entry point added because the objects are different:
> >>
> >>     int security_watch_key(struct watch *watch, struct key *key);
> >>     int security_watch_sb(struct watch *watch, struct path *path);
> >>     int security_watch_mount(struct watch *watch, struct path *path);
> >>     int security_watch_devices(struct watch *watch);
> >>
> >>> make sure every access that can trigger a notification requires a
> >>> (write-like) permission to the accessed object,
> >>
> >> "write-like permssion" for whom?  The triggerer or the watcher?
> >
> > The former, i.e. the process that performed the operation that triggere=
d the notification.  Think of it as a write from the process to the accesse=
d object, which triggers a notification (another write) on some related obj=
ect (the watched object), which is then read by the watcher.
>
> We agree that the process that performed the operation that triggered
> the notification is the initial subject. Smack will treat the process
> with the watch set (in particular, its ring buffer) as the object
> being written to. SELinux, with its finer grained controls, will
> involve other things as noted above. There are other place where we
> see this, notably IP packet delivery.
>
> The implication is that the information about the triggering
> process needs to be available throughout.
>
> >
> >> There are various 'classes' of events:
> >>
> >>   (1) System events (eg. hardware I/O errors, automount points expirin=
g).
> >>
> >>   (2) Direct events (eg. automounts, manual mounts, EDQUOT, key linkag=
e).
> >>
> >>   (3) Indirect events (eg. exit/close doing the last fput and causing =
an
> >>       unmount).
> >>
> >> Class (1) are uncaused by a process, so I use init_cred for them.  One=
 could
> >> argue that the automount point expiry should perhaps take place under =
the
> >> creds of whoever triggered it in the first place, but we need to be ca=
reful
> >> about long-term cred pinning.
> >
> > This seems equivalent to just checking whether the watcher is allowed t=
o get that kind of event, no other cred truly needed.
> >
> >> Class (2) the causing process must've had permission to cause them - o=
therwise
> >> we wouldn't have got the event.
> >
> > So we've already done a check on the causing process, and we're going t=
o check whether the watcher can set the watch. We just need to establish th=
e connection between the accessed object and the watched object in some man=
ner.
>
> I don't agree. That is, I don't believe it is sufficient.
> There is no guarantee that being able to set a watch on an
> object implies that every process that can trigger the event
> can send it to you.
>
>         Watcher has Smack label W
>         Triggerer has Smack label T
>         Watched object has Smack label O
>
>         Relevant Smack rules are
>
>         W O rw
>         T O rw
>
> The watcher will be able to set the watch,
> the triggerer will be able to trigger the event,
> but there is nothing that would allow the watcher
> to receive the event. This is not a case of watcher
> reading the watched object, as the event is delivered
> without any action by watcher.

I think this is an example of a bogus policy that should not be
supported by the kernel.
