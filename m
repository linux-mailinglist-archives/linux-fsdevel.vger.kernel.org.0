Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0911C30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEBPI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 11:08:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54903 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEBPI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 11:08:27 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so3884735ite.4;
        Thu, 02 May 2019 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vN+j4+nd5BKyao3Lvpqus6B/aYyzpgJNlMx+q2AjsvM=;
        b=maX0kka07S2TirIQcAeXMZI/A78EbHhVEa0CawKgApQa0vMzPqhvAJfIvbkvduHi6K
         Kwht2DoZWwI2uJ1dvudku2iCZlO5bozXFhz5ZovmQedJQBnlBq1WDlJ7ClStqXmfGvSp
         9xSixbuXn21Yb/id8TBTo2yhTHpaR+2Ufj01A6BO64KEMo4l+MkyQ9f11jUwAJMXRmpc
         crROedOFVkDi+CXxFDtzpQeiI146nGbc1L0VesyE5qg1KWzlm5wBedOwTfagEzuoGYKx
         utAO7q71Gz9i7MKYIIumkyof+4nCEYL4axNNMHUdsVtY8C2aTIuyQc91PAcaAuOLKa6z
         2LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vN+j4+nd5BKyao3Lvpqus6B/aYyzpgJNlMx+q2AjsvM=;
        b=qp3lkCQNKjfcvBVxreJNGBjZbEL2BJ/MF1x9mzcUN50Dl+APkcPYmlad8ut6vhl0qw
         ualNFzmfB5uCV/Lt3gIQ/x8sGY4zQikWuH6MlLYNmM/ulaPOAYkmFIITb4mRnFQXGr8w
         3yNp2cyCEKM9nA7ckc4RLNavwEx7hYTDyoNVM92YZfv/GTh5nW4gMugYhnxIjkHPvC45
         SBuF6RPrV6GvrhFqLIOwdKKn08yh6i6qt4acPr25UseUkLyjEfUf++B1AMtwiyWaqDc1
         +uEgmpmCqKyuXtF4SURSK+tn5O/4IMKpFDvXbb5gakNVWRIlieqUFGaKufuSypm7pxeZ
         2Lqw==
X-Gm-Message-State: APjAAAVZrV9eXc/ZuuJEuIcrKvJlbgdCZ+rGaSObO5mr0BsP1BRm3tWp
        pTWrca3ALCAbxJ3SC1btCLVZLMl8A0vmuIIjCFo=
X-Google-Smtp-Source: APXvYqzRXnHs/jp8hUcRI6o4ZSLm1l+dCCRmqIRTdj0/iWnMR+SsBGvCQ1M/uMltF6DPwV8qgJIiNekygPL8hs5lW2M=
X-Received: by 2002:a24:4ace:: with SMTP id k197mr2928742itb.46.1556809706149;
 Thu, 02 May 2019 08:08:26 -0700 (PDT)
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
 <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
In-Reply-To: <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 2 May 2019 17:08:14 +0200
Message-ID: <CAHpGcML0KuoGSyXyyDnXHkSp3nDnSjJPeZeWEmt8CXxQeojxwg@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
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

Am Do., 2. Mai 2019 um 16:28 Uhr schrieb Miklos Szeredi <miklos@szeredi.hu>=
:
> On Thu, May 2, 2019 at 10:05 AM Andreas Gruenbacher <agruenba@redhat.com>=
 wrote:
> > On Thu, 2 May 2019 at 05:57, NeilBrown <neilb@suse.com> wrote:
> > > On Wed, May 01 2019, Amir Goldstein wrote:
> > > > On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
> > > >> On Tue, Dec 06 2016, J. Bruce Fields wrote:
> > > >> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wr=
ote:
> > > >> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > > >> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
> > > >> >> > <andreas.gruenbacher@gmail.com> wrote:
> > > >> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.g=
ruenbacher@gmail.com>:
> > > >> >> >
> > > >> >> >>> It's not hard to come up with a heuristic that determines i=
f a
> > > >> >> >>> system.nfs4_acl value is equivalent to a file mode, and to =
ignore the
> > > >> >> >>> attribute in that case. (The file mode is transmitted in it=
s own
> > > >> >> >>> attribute already, so actually converting .) That way, over=
layfs could
> > > >> >> >>> still fail copying up files that have an actual ACL. It's s=
till an
> > > >> >> >>> ugly hack ...
> > > >> >> >>
> > > >> >> >> Actually, that kind of heuristic would make sense in the NFS=
 client
> > > >> >> >> which could then hide the "system.nfs4_acl" attribute.
> >
> > I still think the nfs client could make this problem mostly go away by
> > not exposing "system.nfs4_acl" xattrs when the acl is equivalent to
> > the file mode. The richacl patches contain a workable abgorithm for
> > that. The problem would remain for files that have an actual NFS4 ACL,
> > which just cannot be mapped to a file mode or to POSIX ACLs in the
> > general case, as well as for files that have a POSIX ACL. Mapping NFS4
> > ACL that used to be a POSIX ACL back to POSIX ACLs could be achieved
> > in many cases as well, but the code would be quite messy. A better way
> > seems to be to using a filesystem that doesn't support POSIX ACLs in
> > the first place. Unfortunately, xfs doesn't allow turning off POSIX
> > ACLs, for example.
>
> How about mounting NFSv4 with noacl?  That should fix this issue, right?

You'll still see permissions that differ from what the filesystem
enforces, and copy-up would change that behavior.

Andreas

> Thanks,
> Miklos
>
>
>
> >
> > Andreas
> >
> > > >> >> > Even simpler would be if knfsd didn't send the attribute if n=
ot
> > > >> >> > necessary.  Looks like there's code actively creating the nfs=
4_acl on
> > > >> >> > the wire even if the filesystem had none:
> > > >> >> >
> > > >> >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
> > > >> >> >     if (!pacl)
> > > >> >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNE=
L);
> > > >> >> >
> > > >> >> > What's the point?
> > > >> >>
> > > >> >> That's how the protocol is specified.
> > > >> >
> > > >> > Yep, even if we could make that change to nfsd it wouldn't help =
the
> > > >> > client with the large number of other servers that are out there
> > > >> > (including older knfsd's).
> > > >> >
> > > >> > --b.
> > > >> >
> > > >> >> (I'm not saying that that's very helpful.)
> > > >> >>
> > > >> >> Andreas
> > > >>
> > > >> Hi everyone.....
> > > >>  I have a customer facing this problem, and so stumbled onto the e=
mail
> > > >>  thread.
> > > >>  Unfortunately it didn't resolve anything.  Maybe I can help kick =
things
> > > >>  along???
> > > >>
> > > >>  The core problem here is that NFSv4 and ext4 use different and la=
rgely
> > > >>  incompatible ACL implementations.  There is no way to accurately
> > > >>  translate from one to the other in general (common specific examp=
les
> > > >>  can be converted).
> > > >>
> > > >>  This means that either:
> > > >>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vi=
ce
> > > >>       versa) or
> > > >>    2/ overlayfs need to accept that sometimes it cannot copy ACLs,=
 and
> > > >>       that is OK.
> > > >>
> > > >>  Silently not copying the ACLs is probably not a good idea as it m=
ight
> > > >>  result in inappropriate permissions being given away.
> > > >
> > > > For example? permissions given away to do what?
> > > > Note that ovl_permission() only check permissions of *mounter*
> > > > to read the lower NFS file and ovl_open()/ovl_read_iter() access
> > > > the lower file with *mounter* credentials.
> > > >
> > > > I might be wrong, but seems to me that once admin mounted
> > > > overlayfs with lower NFS, NFS ACLs are not being enforced at all
> > > > even before copy up.
> > >
> > > I guess it is just as well that copy-up fails then - if the lower-lev=
el
> > > permission check is being ignored.
> > >
> > > >
> > > >> So if the
> > > >>  sysadmin wants this (and some clearly do), they need a way to
> > > >>  explicitly say "I accept the risk".  If only standard Unix permis=
sions
> > > >>  are used, there is no risk, so this seems reasonable.
> > > >>
> > > >>  So I would like to propose a new option for overlayfs
> > > >>     nocopyupacl:   when overlayfs is copying a file (or directory =
etc)
> > > >>         from the lower filesystem to the upper filesystem, it does=
 not
> > > >>         copy extended attributes with the "system." prefix.  These=
 are
> > > >>         used for storing ACL information and this is sometimes not
> > > >>         compatible between different filesystem types (e.g. ext4 a=
nd
> > > >>         NFSv4).  Standard Unix ownership permission flags (rwx) *a=
re*
> > > >>         copied so this option does not risk giving away inappropri=
ate
> > > >>         permissions unless the lowerfs uses unusual ACLs.
> > > >>
> > > >>
> > > >
> > > > I am wondering if it would make more sense for nfs to register a
> > > > security_inode_copy_up_xattr() hook.
> > > > That is the mechanism that prevents copying up other security.*
> > > > xattrs?
> > >
> > > No, I don't think that would make sense.
> > > Support some day support for nfs4 acls were added to ext4 (not a tota=
lly
> > > ridiculous suggestion).  We would then want NFS to allow it's ACLs to=
 be
> > > copied up.
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > > >
> > > > Thanks,
> > > > Amir.
