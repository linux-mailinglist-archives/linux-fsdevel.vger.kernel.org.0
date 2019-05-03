Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD91331D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfECR0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 13:26:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34355 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfECR0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 13:26:14 -0400
Received: by mail-yw1-f68.google.com with SMTP id u14so4901288ywe.1;
        Fri, 03 May 2019 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DocVtyuDeHQRG32pg5UwnwTFNToS8yf9UPgc4/qdeYU=;
        b=e0EVyFqETr57jizVPCvWUQZE7uxN6M2tTc+6UdysEiRdPcr1cUNisT47b8063Pc99g
         UOzOrmQa122NOXaPegyqwwhWpRsgnY4VhirbDLzS218imz+LgrEM5hQtIDAsBfl0BC3m
         OGmovcqBiT9YF2y4+QPlnfZhicVEvytgX5iu5ClPNMrbSYh/7TsFDq2/u62EJ2D1lBwv
         RrUBkzMqGsG+usGlzaJSsSYmubj2awu1HoPbW/2IiVdYlh6oRdW0qKj7vyj/RQs87ZUL
         fStnyKsmIJi+HGwogJQtm+woSVwvgBeC5/TWuNpjwt++JQMNG9NpAZZdtp+hrVt9rLwL
         2Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DocVtyuDeHQRG32pg5UwnwTFNToS8yf9UPgc4/qdeYU=;
        b=nSxqj+VRlnu2s41a7q7JhuDSjSDrfiHZYZ1Opk3A5A3PC2RAhRe7IhCxzzBsPH2Qys
         jN4/Nm4O8iUDo4mY/Tb3oAcRdst8vhYyEqvLYjxTmCD+wX10JPoBHEpcmvmq8FZNspp1
         hGGVTaPLhpMA7N9eNYDRgyW9uzZ2ZTs9d4WP0ZyQ+GihULJnl3xxJmsw+UlOi50eawSE
         OSBNsZ8hKudxWjP6t5rcitRlpJYJipS1NEvTrdVCG5jEKQzeWVU1/YxvqzrPCpwFH4q/
         r6egOcGfXaBGqOLJnHzt+EUdJOz6A1Q5chXEmgtG3K6dq8R1XDyT9riM1aFr/piMnjwS
         RkJw==
X-Gm-Message-State: APjAAAVJfRzOjf7u/v/+eb6QHjUsM/lwjttrMoel0nAkRbdUZ2lc9hun
        qkUNzGFLp/YE8CurusfdrxCDTsDwxz0EMWXSWiFVSkJQkik=
X-Google-Smtp-Source: APXvYqxPOL5lm9yxwUgbMIR/AwgPkpjd6Je1pA7eUdFjFpMljhdACsq//C9CApPakzISWWiJLvydO7To7D6ERb3dsHs=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr8777605ybc.507.1556904373293;
 Fri, 03 May 2019 10:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
In-Reply-To: <20190503153531.GJ12608@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 13:26:01 -0400
Message-ID: <CAOQ4uxi6MRT=1nFqPD3cfEfBxHsGdUm=FgTjv3ts2bb4zSYwsw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 12:03 PM J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>
> On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:
> > On Tue, Dec 06 2016, J. Bruce Fields wrote:
> >
> > > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wrote:
> > >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> > >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
> > >> > <andreas.gruenbacher@gmail.com> wrote:
> > >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gruenb=
acher@gmail.com>:
> > >> >
> > >> >>> It's not hard to come up with a heuristic that determines if a
> > >> >>> system.nfs4_acl value is equivalent to a file mode, and to ignor=
e the
> > >> >>> attribute in that case. (The file mode is transmitted in its own
> > >> >>> attribute already, so actually converting .) That way, overlayfs=
 could
> > >> >>> still fail copying up files that have an actual ACL. It's still =
an
> > >> >>> ugly hack ...
> > >> >>
> > >> >> Actually, that kind of heuristic would make sense in the NFS clie=
nt
> > >> >> which could then hide the "system.nfs4_acl" attribute.
> > >> >
> > >> > Even simpler would be if knfsd didn't send the attribute if not
> > >> > necessary.  Looks like there's code actively creating the nfs4_acl=
 on
> > >> > the wire even if the filesystem had none:
> > >> >
> > >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
> > >> >     if (!pacl)
> > >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
> > >> >
> > >> > What's the point?
> > >>
> > >> That's how the protocol is specified.
> > >
> > > Yep, even if we could make that change to nfsd it wouldn't help the
> > > client with the large number of other servers that are out there
> > > (including older knfsd's).
> > >
> > > --b.
> > >
> > >> (I'm not saying that that's very helpful.)
> > >>
> > >> Andreas
> >
> > Hi everyone.....
> >  I have a customer facing this problem, and so stumbled onto the email
> >  thread.
> >  Unfortunately it didn't resolve anything.  Maybe I can help kick thing=
s
> >  along???
> >
> >  The core problem here is that NFSv4 and ext4 use different and largely
> >  incompatible ACL implementations.  There is no way to accurately
> >  translate from one to the other in general (common specific examples
> >  can be converted).
> >
> >  This means that either:
> >    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
> >       versa) or
> >    2/ overlayfs need to accept that sometimes it cannot copy ACLs, and
> >       that is OK.
> >
> >  Silently not copying the ACLs is probably not a good idea as it might
> >  result in inappropriate permissions being given away.  So if the
> >  sysadmin wants this (and some clearly do), they need a way to
> >  explicitly say "I accept the risk".
>
> So, I feel like silently copying ACLs up *also* carries a risk, if that
> means switching from server-enforcement to client-enforcement of those
> permissions.
>
> Sorry, I know we had another thread recently about permissions in this
> situation, and I've forgotten the conclusion.
>
> Out of curiosity, what's done with selinux labels?
>

overlayfs calls security_inode_copy_up_xattr(name) which
can fail (<0) allow (0) or skip(1).

selinux_inode_copy_up_xattr() as well as smack_inode_copy_up_xattr()
skip their own xattr on copy up and fail any other xattr copy up.

Thanks,
Amir.
