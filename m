Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3629E11B66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBO24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 10:28:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55134 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBO24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 10:28:56 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so3624797ite.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BqHJ4mKCqV4ZGSDIdcnHrlBfq1c/O0ILprJjcbsuKxg=;
        b=com3sCaUbNmDKYX9/c5R+Szvf04X7EZ4tn/wfCS/BU0LTNv6c+nRVC4wASCSoqTjhz
         Cn4K7TqAYCy6JbLvppR/ADv/CBq8EBhfNp9GTjKKe96GJewCZvF4Pch1lfqzBBmBFmsC
         hot8x00MO/pDkp48ppQmvOT2nA1ueTrdl+wlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BqHJ4mKCqV4ZGSDIdcnHrlBfq1c/O0ILprJjcbsuKxg=;
        b=HnkeieUfzwKcE/hayrM60sjNfjhwe2xmAadZ5Jes4/uAOtOC7roqjwVMD/9/s3BtfS
         i+o0JHLhA/rvWjM32qop7NBP69c0zet2TCxjSag+cUMt9cGKw4b9F2wE9sXAsQanNYiZ
         IUBBAPcFTtC5/1mmP9MypjfHISdEyS4Y47fmQzjdOT7qjDHJv55u+53Tj1c9jFzyHt8P
         6APw4NNBfaLdRTiCb7YTGb5xDZzlM8V4YDN1b7QwX4apWEdPKCqXmeHax6tfed0md2/A
         cx0xc3SUC9/LKuP6H7+l0NrXBaSlA5Hb+yDeu21IbvQQhfWLkVwJWxm8wuIhoFFniT4T
         2W3w==
X-Gm-Message-State: APjAAAUGfjSNHC09bZ+3okt8WQUTdff7SKrV2FvWeFJ7Kx7gEO9b2I5z
        N2O3oNE5OHGR5Xi5OuyNTHuyf8Xt32mc7vxKNiEThA==
X-Google-Smtp-Source: APXvYqwiDaSe7oR13TqnAe4ifdblvh6sX0UjdKbinWlL2NINaz4O5wVQDsGbSp4jFuCH25uLqaqshcY7ngDOXzPt63U=
X-Received: by 2002:a24:b342:: with SMTP id z2mr2342309iti.121.1556807335385;
 Thu, 02 May 2019 07:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name> <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com>
In-Reply-To: <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 May 2019 10:28:44 -0400
Message-ID: <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
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

On Thu, May 2, 2019 at 10:05 AM Andreas Gruenbacher <agruenba@redhat.com> w=
rote:
>
> On Thu, 2 May 2019 at 05:57, NeilBrown <neilb@suse.com> wrote:
> > On Wed, May 01 2019, Amir Goldstein wrote:
> > > On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
> > >> On Tue, Dec 06 2016, J. Bruce Fields wrote:
> > >> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wrot=
e:
> > >> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
> > >> >> > <andreas.gruenbacher@gmail.com> wrote:
> > >> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gru=
enbacher@gmail.com>:
> > >> >> >
> > >> >> >>> It's not hard to come up with a heuristic that determines if =
a
> > >> >> >>> system.nfs4_acl value is equivalent to a file mode, and to ig=
nore the
> > >> >> >>> attribute in that case. (The file mode is transmitted in its =
own
> > >> >> >>> attribute already, so actually converting .) That way, overla=
yfs could
> > >> >> >>> still fail copying up files that have an actual ACL. It's sti=
ll an
> > >> >> >>> ugly hack ...
> > >> >> >>
> > >> >> >> Actually, that kind of heuristic would make sense in the NFS c=
lient
> > >> >> >> which could then hide the "system.nfs4_acl" attribute.
>
> I still think the nfs client could make this problem mostly go away by
> not exposing "system.nfs4_acl" xattrs when the acl is equivalent to
> the file mode. The richacl patches contain a workable abgorithm for
> that. The problem would remain for files that have an actual NFS4 ACL,
> which just cannot be mapped to a file mode or to POSIX ACLs in the
> general case, as well as for files that have a POSIX ACL. Mapping NFS4
> ACL that used to be a POSIX ACL back to POSIX ACLs could be achieved
> in many cases as well, but the code would be quite messy. A better way
> seems to be to using a filesystem that doesn't support POSIX ACLs in
> the first place. Unfortunately, xfs doesn't allow turning off POSIX
> ACLs, for example.

How about mounting NFSv4 with noacl?  That should fix this issue, right?

Thanks,
Miklos



>
> Andreas
>
> > >> >> > Even simpler would be if knfsd didn't send the attribute if not
> > >> >> > necessary.  Looks like there's code actively creating the nfs4_=
acl on
> > >> >> > the wire even if the filesystem had none:
> > >> >> >
> > >> >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
> > >> >> >     if (!pacl)
> > >> >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL)=
;
> > >> >> >
> > >> >> > What's the point?
> > >> >>
> > >> >> That's how the protocol is specified.
> > >> >
> > >> > Yep, even if we could make that change to nfsd it wouldn't help th=
e
> > >> > client with the large number of other servers that are out there
> > >> > (including older knfsd's).
> > >> >
> > >> > --b.
> > >> >
> > >> >> (I'm not saying that that's very helpful.)
> > >> >>
> > >> >> Andreas
> > >>
> > >> Hi everyone.....
> > >>  I have a customer facing this problem, and so stumbled onto the ema=
il
> > >>  thread.
> > >>  Unfortunately it didn't resolve anything.  Maybe I can help kick th=
ings
> > >>  along???
> > >>
> > >>  The core problem here is that NFSv4 and ext4 use different and larg=
ely
> > >>  incompatible ACL implementations.  There is no way to accurately
> > >>  translate from one to the other in general (common specific example=
s
> > >>  can be converted).
> > >>
> > >>  This means that either:
> > >>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
> > >>       versa) or
> > >>    2/ overlayfs need to accept that sometimes it cannot copy ACLs, a=
nd
> > >>       that is OK.
> > >>
> > >>  Silently not copying the ACLs is probably not a good idea as it mig=
ht
> > >>  result in inappropriate permissions being given away.
> > >
> > > For example? permissions given away to do what?
> > > Note that ovl_permission() only check permissions of *mounter*
> > > to read the lower NFS file and ovl_open()/ovl_read_iter() access
> > > the lower file with *mounter* credentials.
> > >
> > > I might be wrong, but seems to me that once admin mounted
> > > overlayfs with lower NFS, NFS ACLs are not being enforced at all
> > > even before copy up.
> >
> > I guess it is just as well that copy-up fails then - if the lower-level
> > permission check is being ignored.
> >
> > >
> > >> So if the
> > >>  sysadmin wants this (and some clearly do), they need a way to
> > >>  explicitly say "I accept the risk".  If only standard Unix permissi=
ons
> > >>  are used, there is no risk, so this seems reasonable.
> > >>
> > >>  So I would like to propose a new option for overlayfs
> > >>     nocopyupacl:   when overlayfs is copying a file (or directory et=
c)
> > >>         from the lower filesystem to the upper filesystem, it does n=
ot
> > >>         copy extended attributes with the "system." prefix.  These a=
re
> > >>         used for storing ACL information and this is sometimes not
> > >>         compatible between different filesystem types (e.g. ext4 and
> > >>         NFSv4).  Standard Unix ownership permission flags (rwx) *are=
*
> > >>         copied so this option does not risk giving away inappropriat=
e
> > >>         permissions unless the lowerfs uses unusual ACLs.
> > >>
> > >>
> > >
> > > I am wondering if it would make more sense for nfs to register a
> > > security_inode_copy_up_xattr() hook.
> > > That is the mechanism that prevents copying up other security.*
> > > xattrs?
> >
> > No, I don't think that would make sense.
> > Support some day support for nfs4 acls were added to ext4 (not a totall=
y
> > ridiculous suggestion).  We would then want NFS to allow it's ACLs to b=
e
> > copied up.
> >
> > Thanks,
> > NeilBrown
> >
> >
> > >
> > > Thanks,
> > > Amir.
