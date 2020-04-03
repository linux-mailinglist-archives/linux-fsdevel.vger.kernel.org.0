Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDED319D609
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403778AbgDCLtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 07:49:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38480 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbgDCLtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:49:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so8934141edq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2020 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hVNwPy+gt0SiBgbKa4Ts7rYRXhcnznGYRRNUIY7t1Y0=;
        b=VIIzrxvQDZ7sEKA4V9ATLkkGs8/+gHlbWBKNW4Rd9I1h90LdQgpTL351PKl5//Brw9
         Z4DPvYmA0xQ4Pz45YWBOT39ph5ofudPgDnCyMBzS/nygSltVynGbd0xsaf1++4p6dAnG
         pAJ6fupWjxZ3nh1sBkYj4X8ZY0ChUzUkvCGVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hVNwPy+gt0SiBgbKa4Ts7rYRXhcnznGYRRNUIY7t1Y0=;
        b=BNyc7E/YanL53PBsNxbBfu2hB/mwULn7gqzK1KuCGFMmpO60phbk3ZbKPiuvfVlUuY
         3Li39vEuhKi9W23AkoJtxklcSkBL9BcdvD6TcgcZLfYrsR7RlXtjnIpPFHIX9FVsoA6R
         SZFwX2wMUlmXcWz10Rr/y/jsysFCrzwefiFKvA+EAbSduII9uIleT+XTRMN87xgaDtYk
         JWeOgPaVlKhwzm0ESUdD5yv6l+cvJKUc6jrMjxEeLS3ZTJn0ITq/N1NGVKqMtO0LDtvU
         hL/VS3DbfFqnIGbFmf9kT2xTLOr8B5Yb4C8Y+Dk6DlaMStvLE3VBzSCEoDi88yzF37rM
         Tczw==
X-Gm-Message-State: AGi0PuaKmQvAE9eBWByQ65XyWRql2C/QP/8mdK9ll5McIA5d0BXTD93l
        mWO4gyoaIlJ1wu/eTGVSf0KiJFuHebaCBEAYQ4cYtg==
X-Google-Smtp-Source: APiQypI1AuUmWagqGCK3prLz7095VZ+oDaQPI6yUMfzrksdJydfjbCc/ykWeXRA+KV9F6pNuN3rsaoMlYdWz84YjIOU=
X-Received: by 2002:a17:907:271a:: with SMTP id w26mr8098956ejk.195.1585914542881;
 Fri, 03 Apr 2020 04:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login>
In-Reply-To: <20200403110842.GA34663@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 3 Apr 2020 13:48:51 +0200
Message-ID: <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:08 PM Lennart Poettering <mzxreary@0pointer.de> wr=
ote:
>
> On Do, 02.04.20 19:20, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Thu, Apr 2, 2020 at 5:50 PM Lennart Poettering <mzxreary@0pointer.de=
> wrote:
> > >
> > > On Do, 02.04.20 17:35, Miklos Szeredi (miklos@szeredi.hu) wrote:
> > >
> > > > > systemd cares about all mount points in PID1's mount namespace.
> > > > >
> > > > > The fact that mount tables can grow large is why we want somethin=
g
> > > > > better than constantly reparsing the whole /proc/self/mountinfo. =
But
> > > > > filtering subsets of that is something we don't really care about=
.
> > > >
> > > > I can accept that, but you haven't given a reason why that's so.
> > > >
> > > > What does it do with the fact that an automount point was crossed, =
for
> > > > example?  How does that affect the operation of systemd?
> > >
> > > We don't care how a mount point came to be. If it's autofs or
> > > something else, we don't care. We don't access these mount points
> > > ourselves ever, we just watch their existance.
> > >
> > > I mean, it's not just about startup it's also about shutdown. At
> > > shutdown we need to unmount everything from the leaves towards the
> > > root so that all file systems are in a clean state.
> >
> > Unfortunately that's not guaranteed by umounting all filesystems from
> > the init namespace.  A filesystem is shut down when all references to
> > it are gone.  Perhaps you instead want to lazy unmount root (yeah,
> > that may not actually be allowed, but anyway, lazy unmounting the top
> > level ones should do) and watch for super block shutdown events
> > instead.
> >
> > Does that make any sense?
>
> When all mounts in the init mount namespace are unmounted and all
> remaining processes killed we switch root back to the initrd, so that
> even the root fs can be unmounted, and then we disassemble any backing
> complex storage if there is, i.e. lvm, luks, raid, =E2=80=A6

I think it could be done the other way round, much simpler:

 - switch back to initrd
 - umount root, keeping the tree intact (UMOUNT_DETACHED)
 - kill all remaining processes, wait for all to exit

I think that should guarantee that all super blocks have been shut down.  A=
l?

The advantage would be that there's no need to walk the mount tree
unmounting individual leafs, since it's all done automagically.

Thanks,
Miklos
