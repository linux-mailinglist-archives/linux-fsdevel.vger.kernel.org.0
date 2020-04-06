Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152B319F267
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDFJWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 05:22:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgDFJWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:22:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so18388437edq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ICZidZS836uKk3f5MYlrKnxf/d24delcy3nSKE9ogi4=;
        b=W3pq5Mo7uZpLVGOq5GAIDI/ai7fUH4IIThQ1nwRczafHnhltyPbRBYi4qNanWLvp69
         +904YhfbA4VWq0KvmJHQkjtbf5BXIa7CMoQ1Fr67ulXZcagefy/tt06DHI28sQAl1Z4o
         hoDv8pLs5dD5DoPrxG3VeoDU6ANvHB8Mx51a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ICZidZS836uKk3f5MYlrKnxf/d24delcy3nSKE9ogi4=;
        b=FoLhN7N+p1d7VvxhHhXPFs/6LLiUaAVk3ygwZko4rSSVcu2Oj0D5KAB6MJH+yQnyN0
         ZLTTOThIosbwdKubvtCq9VOjGRjQT9+GY7c7rEuycbVwwXdM6tj9HjCFfJxRWE4eBz3v
         L8YabEsxjT0/LglqHYRnff53n8l+h6jKefuaWoDdLwwLDXiXVbra7BUz5eBEmhxcbg2B
         owoOKwZycflh75QkFUgYN3DOmqL4chD/BGGOLalfk5aBS8EdSgj45E1bOhuFtO23EVTc
         mq0FF7445O+m2cSFj3+0MeDeYnHckNtUpjdEa77MoXpO9E2LStmYqLup/foYeahHNogm
         /rqg==
X-Gm-Message-State: AGi0Pub2YLxJAvSzjgzXjR/yBe3GQFG/pzJkvMtmwldv66IkcvIVcb2+
        dpe6TQYeOApgFgaJA2EVj+iIN5Hij+CpGUdN+bpx6Q==
X-Google-Smtp-Source: APiQypKhY01mdGI1/JQgHY2uIzhyGBPdhVdoEMLb6wrymVsJFgMONWTk9QGbDBPrwg//+L4NEZ3xqyN3Wn1J9Hi6NTs=
X-Received: by 2002:a17:906:b351:: with SMTP id cd17mr20431593ejb.351.1586164962711;
 Mon, 06 Apr 2020 02:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login>
In-Reply-To: <20200403150143.GA34800@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Apr 2020 11:22:31 +0200
Message-ID: <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
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

On Fri, Apr 3, 2020 at 5:01 PM Lennart Poettering <mzxreary@0pointer.de> wr=
ote:
>
> On Fr, 03.04.20 13:48, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > > > Does that make any sense?
> > >
> > > When all mounts in the init mount namespace are unmounted and all
> > > remaining processes killed we switch root back to the initrd, so that
> > > even the root fs can be unmounted, and then we disassemble any backin=
g
> > > complex storage if there is, i.e. lvm, luks, raid, =E2=80=A6
> >
> > I think it could be done the other way round, much simpler:
> >
> >  - switch back to initrd
> >  - umount root, keeping the tree intact (UMOUNT_DETACHED)
> >  - kill all remaining processes, wait for all to exit
>
> Nah. What I wrote above is drastically simplified. It's IRL more
> complex. Specific services need to be killed between certain mounts
> are unmounted, since they are a backend for another mount. NFS, or
> FUSE or stuff like that usually has some processes backing them
> around, and we need to stop the mounts they provide before these
> services, and then the mounts these services reside on after that, and
> so on. It's a complex dependency tree of stuff that needs to be done
> in order, so that we can deal with arbitrarily nested mounts, storage
> subsystems, and backing services.

That still doesn't explain why you need to keep track of all mounts in
the system.

If you are aware of the dependency, then you need to keep track of
that particular mount. If not, then why?

What I'm starting to see is that there's a fundamental conflict
between how systemd people want to deal with new mounts and how some
other people want to use mounts (i.e. tens of thousands of mounts in
an automount map).

I'm really curious how much the mount notification ring + per mount
query (any implementation) can help that use case.

> Anyway, this all works fine in systemd, the dependency logic is
> there. We want a more efficient way to watch mounts, that's
> all. Subscribing and constantly reparsing /proc/self/mountinfo is
> awful, that's all.

I'm not sure that is all.   To handle storms of tens of thousands of
mounts, my guess is that the fundamental way of dealing with these
changes will need to be updated in systemd.

Thanks,
Miklos
