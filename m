Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971D51281B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfECGyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 02:54:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39176 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfECGyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 02:54:44 -0400
Received: by mail-it1-f196.google.com with SMTP id t200so7556269itf.4;
        Thu, 02 May 2019 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cao24xl2yFe5SltfHFGz5MGgv/+P5yaYkgmhi7HPkuw=;
        b=T+4FHa1ZFg52Rhfb9DwMcWtznsj4zO24ZSTq2Vts3OlehNxuq61BmJMtR27KVdXmju
         qUJ9cmhkY5ec8O6lQolH68Qd4VJdCiss+uzRzGgyJwjsgHe/ypyDa9T+7fYVlIsjRS0V
         UVvbXr7f3hBksf32I7KZ1xsZQu7v0DrlsUKq1h/OV0Ve1StP5pTnlwT88tILZGwMn/HX
         KBBdnBy4ufJnx3bO0rBCZ3i9CZawF//dBphNuLKo7GXSixAsJE+s08mTt0ZEFw/z2l1I
         lqsMj+0EBvZKfR08Ecrjky/QmcHnAoXZlJJRlRfp01d38c7aWGkjynbPxXVae8fO8l98
         oYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cao24xl2yFe5SltfHFGz5MGgv/+P5yaYkgmhi7HPkuw=;
        b=nc4HVyBzbtfwcRs5JyyxhUDeiTQJ8Gatogiy6AY6t4fFqMxGmppOXff7g1lHaDAtw9
         qBpvnh5A1Vc6vD8CTKyzLD5LIdqTSk27l5apjecPYuMC7REmP+YMDdwMDtrrm1VyfrJ3
         hNKPFzL0UQSpTqPYT3s78ddi8WjsIR/bMdg4yAFPDAcX1Z8MpKABwNA/q4SqBjabvRrZ
         4xafofPoi9sJ98WjgNKBlNyC1dfSe/rOc4RD60m9Y0Zyy1CJlBpMfl4OCwfE25fQ/HKo
         b1foOOaw0qWvcPNzakkMRi/J+kLvfQ1cO9JdEatda3eDYQlT+9tCx0+IXHWFj02a8AEN
         c5Gg==
X-Gm-Message-State: APjAAAWHSCFBQw5eyfZlpTKPSTPac6EVPS4jx+ylNriPboUlrzEj3R7Y
        n1oEc+9/B6ODG6n/L9Gff/rikDsVNYm+cik+4vQ=
X-Google-Smtp-Source: APXvYqzT+Ml+UmjOoz7khUbNFR0HYm5hMWwKjMpu/gsDPkIgvlRFfi+kdGWZSLEGNSsHTJ6OnBL+KoPcKSJKR4YCj9c=
X-Received: by 2002:a02:c99a:: with SMTP id b26mr5989485jap.32.1556866483274;
 Thu, 02 May 2019 23:54:43 -0700 (PDT)
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
 <87r29g30e8.fsf@notabene.neil.brown.name>
In-Reply-To: <87r29g30e8.fsf@notabene.neil.brown.name>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 3 May 2019 08:54:31 +0200
Message-ID: <CAHpGcMJ34zcm2+MES=yn6a7s6LOwcQorOVHEgQYUHWQbYxavmA@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     NeilBrown <neilb@suse.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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

Am Fr., 3. Mai 2019 um 01:24 Uhr schrieb NeilBrown <neilb@suse.com>:
> On Thu, May 02 2019, Andreas Gruenbacher wrote:
> > On Thu, 2 May 2019 at 05:57, NeilBrown <neilb@suse.com> wrote:
> >> On Wed, May 01 2019, Amir Goldstein wrote:
> >> > On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
> >> >> On Tue, Dec 06 2016, J. Bruce Fields wrote:
> >> >> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wro=
te:
> >> >> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >> >> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
> >> >> >> > <andreas.gruenbacher@gmail.com> wrote:
> >> >> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gr=
uenbacher@gmail.com>:
> >> >> >> >
> >> >> >> >>> It's not hard to come up with a heuristic that determines if=
 a
> >> >> >> >>> system.nfs4_acl value is equivalent to a file mode, and to i=
gnore the
> >> >> >> >>> attribute in that case. (The file mode is transmitted in its=
 own
> >> >> >> >>> attribute already, so actually converting .) That way, overl=
ayfs could
> >> >> >> >>> still fail copying up files that have an actual ACL. It's st=
ill an
> >> >> >> >>> ugly hack ...
> >> >> >> >>
> >> >> >> >> Actually, that kind of heuristic would make sense in the NFS =
client
> >> >> >> >> which could then hide the "system.nfs4_acl" attribute.
> >
> > I still think the nfs client could make this problem mostly go away by
> > not exposing "system.nfs4_acl" xattrs when the acl is equivalent to
> > the file mode.
>
> Maybe ... but this feels a bit like "sweeping it under the carpet".
> What happens if some file on the lower layer does have a more complex
> ACL?
> Do we just fail any attempt to modify that object?  Doesn't that violate
> the law of least surprise?

It would at least expose that there is a problem only if there is an
actual problem.

> Maybe if the lower-layer has an i_op->permission method, then overlayfs
> should *always* call that for permission checking - unless a
> chmod/chown/etc has happened on the file.  That way, we wouldn't need to
> copy-up the ACL, but would still get correct ACL testing.

No, the permissions need to stick with the object. Otherwise, what
would you do on rename or when the lower layer changes?

Andreas

> Thanks,
> NeilBrown
>
>
> > The richacl patches contain a workable abgorithm for
> > that. The problem would remain for files that have an actual NFS4 ACL,
> > which just cannot be mapped to a file mode or to POSIX ACLs in the
> > general case, as well as for files that have a POSIX ACL. Mapping NFS4
> > ACL that used to be a POSIX ACL back to POSIX ACLs could be achieved
> > in many cases as well, but the code would be quite messy. A better way
> > seems to be to using a filesystem that doesn't support POSIX ACLs in
> > the first place. Unfortunately, xfs doesn't allow turning off POSIX
> > ACLs, for example.
> >
> > Andreas
> >
> >> >> >> > Even simpler would be if knfsd didn't send the attribute if no=
t
> >> >> >> > necessary.  Looks like there's code actively creating the nfs4=
_acl on
> >> >> >> > the wire even if the filesystem had none:
> >> >> >> >
> >> >> >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
> >> >> >> >     if (!pacl)
> >> >> >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL=
);
> >> >> >> >
> >> >> >> > What's the point?
> >> >> >>
> >> >> >> That's how the protocol is specified.
> >> >> >
> >> >> > Yep, even if we could make that change to nfsd it wouldn't help t=
he
> >> >> > client with the large number of other servers that are out there
> >> >> > (including older knfsd's).
> >> >> >
> >> >> > --b.
> >> >> >
> >> >> >> (I'm not saying that that's very helpful.)
> >> >> >>
> >> >> >> Andreas
> >> >>
> >> >> Hi everyone.....
> >> >>  I have a customer facing this problem, and so stumbled onto the em=
ail
> >> >>  thread.
> >> >>  Unfortunately it didn't resolve anything.  Maybe I can help kick t=
hings
> >> >>  along???
> >> >>
> >> >>  The core problem here is that NFSv4 and ext4 use different and lar=
gely
> >> >>  incompatible ACL implementations.  There is no way to accurately
> >> >>  translate from one to the other in general (common specific exampl=
es
> >> >>  can be converted).
> >> >>
> >> >>  This means that either:
> >> >>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vic=
e
> >> >>       versa) or
> >> >>    2/ overlayfs need to accept that sometimes it cannot copy ACLs, =
and
> >> >>       that is OK.
> >> >>
> >> >>  Silently not copying the ACLs is probably not a good idea as it mi=
ght
> >> >>  result in inappropriate permissions being given away.
> >> >
> >> > For example? permissions given away to do what?
> >> > Note that ovl_permission() only check permissions of *mounter*
> >> > to read the lower NFS file and ovl_open()/ovl_read_iter() access
> >> > the lower file with *mounter* credentials.
> >> >
> >> > I might be wrong, but seems to me that once admin mounted
> >> > overlayfs with lower NFS, NFS ACLs are not being enforced at all
> >> > even before copy up.
> >>
> >> I guess it is just as well that copy-up fails then - if the lower-leve=
l
> >> permission check is being ignored.
> >>
> >> >
> >> >> So if the
> >> >>  sysadmin wants this (and some clearly do), they need a way to
> >> >>  explicitly say "I accept the risk".  If only standard Unix permiss=
ions
> >> >>  are used, there is no risk, so this seems reasonable.
> >> >>
> >> >>  So I would like to propose a new option for overlayfs
> >> >>     nocopyupacl:   when overlayfs is copying a file (or directory e=
tc)
> >> >>         from the lower filesystem to the upper filesystem, it does =
not
> >> >>         copy extended attributes with the "system." prefix.  These =
are
> >> >>         used for storing ACL information and this is sometimes not
> >> >>         compatible between different filesystem types (e.g. ext4 an=
d
> >> >>         NFSv4).  Standard Unix ownership permission flags (rwx) *ar=
e*
> >> >>         copied so this option does not risk giving away inappropria=
te
> >> >>         permissions unless the lowerfs uses unusual ACLs.
> >> >>
> >> >>
> >> >
> >> > I am wondering if it would make more sense for nfs to register a
> >> > security_inode_copy_up_xattr() hook.
> >> > That is the mechanism that prevents copying up other security.*
> >> > xattrs?
> >>
> >> No, I don't think that would make sense.
> >> Support some day support for nfs4 acls were added to ext4 (not a total=
ly
> >> ridiculous suggestion).  We would then want NFS to allow it's ACLs to =
be
> >> copied up.
> >>
> >> Thanks,
> >> NeilBrown
> >>
> >>
> >> >
> >> > Thanks,
> >> > Amir.
