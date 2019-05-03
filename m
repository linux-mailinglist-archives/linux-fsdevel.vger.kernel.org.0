Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32821333C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfECRli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 13:41:38 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37922 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 13:41:38 -0400
Received: by mail-yw1-f68.google.com with SMTP id b74so4797204ywe.5;
        Fri, 03 May 2019 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p5M/unB0351EktCmdlsfTYqv7wEGQrmXxJ+Scs6yVQc=;
        b=kFuDZSBWEO8l1xntay2cfVEMTDQa1wvYAE1OQwdwbDXRNs0fMP1U0cXxiH7LIpcTUv
         jNCaiX94xhfp/Y69DiOejHn8716trG86YKnhQWH1SVwvrr1vqDHxfm0LAwJS10137egx
         3eIJLGZAbvZmIP1OjDxSFgs5fq4EYaAgj4WK6uwIP/Lo5EnfiTVTpKzcEvDlglPk3cMf
         p9axbDEf4E6UbouMJ048GZz0F3fulolXT4SGRq4/ErH5LqSIqqwY+XL5QozamFOjawCe
         ClTP6v6aA5vLbZ+MoUFEA8D0uFdEpWYLcB+fIWyC/bOdfRTOajuaPChKqI4GLgZLuh+d
         +k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p5M/unB0351EktCmdlsfTYqv7wEGQrmXxJ+Scs6yVQc=;
        b=Gfy1nis42n2y1Ly+hwIodqcwSZ4xfsedDdsDnjbkqyxtJj1De4yEV96SWuyP21A1Pc
         Xp9bzNhPICCSVqRXf3GP7KaNdFOKyyYoVpBnhHUxa7gdLl1peiON6gb0uToqkO54wigM
         lQC6ktLA1SqCTnRN6I2xFFCt1oLnhNJYe2mBmxpykxKVmfNHCg+QzXH8gl3FNtV60utH
         ZG2z40+hdTHlPJC/dPJppsM8oBPNOzvhVuSQFWfCKbtck5SgpboZG1aIIteZWQEEzIJ3
         Hex80BdMvs3aJaz8u9opn1Y2/2dSQf0BOVTDaFK65W9Si2DPfBWi3/xmi3UyzSK4If4p
         7eAg==
X-Gm-Message-State: APjAAAV5zFPbyTCxr6xDbxV43LMB8vlOXXAYBxs6XD1bH1OU4NkkVG2H
        MRYRx1lvFG9MGlNR9cPhj0s+iPYa9zL/vyNuobJgeOaB
X-Google-Smtp-Source: APXvYqyDS9/1YJsbmFIpR5rHO/6h2SdQLqegzeSXpg9gzj7byMyu4kTfBGVddEHqp0M+yBjnYwECLVtURmYABWaC29o=
X-Received: by 2002:a81:7c4:: with SMTP id 187mr8665382ywh.176.1556905297030;
 Fri, 03 May 2019 10:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org> <CAOQ4uxi6MRT=1nFqPD3cfEfBxHsGdUm=FgTjv3ts2bb4zSYwsw@mail.gmail.com>
 <20190503173133.GB14954@fieldses.org>
In-Reply-To: <20190503173133.GB14954@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 13:41:25 -0400
Message-ID: <CAOQ4uxjztNzH7EbK7o2vkhzzjULkEVKnnedep9GbTSyOhRV-3g@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 1:31 PM J. Bruce Fields <bfields@fieldses.org> wrote=
:
>
> On Fri, May 03, 2019 at 01:26:01PM -0400, Amir Goldstein wrote:
> > On Fri, May 3, 2019 at 12:03 PM J. Bruce Fields <bfields@fieldses.org> =
wrote:
> > >
> > > On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:
> > > > On Tue, Dec 06 2016, J. Bruce Fields wrote:
> > > >
> > > > > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wro=
te:
> > > > >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > > > >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
> > > > >> > <andreas.gruenbacher@gmail.com> wrote:
> > > > >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gr=
uenbacher@gmail.com>:
> > > > >> >
> > > > >> >>> It's not hard to come up with a heuristic that determines if=
 a
> > > > >> >>> system.nfs4_acl value is equivalent to a file mode, and to i=
gnore the
> > > > >> >>> attribute in that case. (The file mode is transmitted in its=
 own
> > > > >> >>> attribute already, so actually converting .) That way, overl=
ayfs could
> > > > >> >>> still fail copying up files that have an actual ACL. It's st=
ill an
> > > > >> >>> ugly hack ...
> > > > >> >>
> > > > >> >> Actually, that kind of heuristic would make sense in the NFS =
client
> > > > >> >> which could then hide the "system.nfs4_acl" attribute.
> > > > >> >
> > > > >> > Even simpler would be if knfsd didn't send the attribute if no=
t
> > > > >> > necessary.  Looks like there's code actively creating the nfs4=
_acl on
> > > > >> > the wire even if the filesystem had none:
> > > > >> >
> > > > >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
> > > > >> >     if (!pacl)
> > > > >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL=
);
> > > > >> >
> > > > >> > What's the point?
> > > > >>
> > > > >> That's how the protocol is specified.
> > > > >
> > > > > Yep, even if we could make that change to nfsd it wouldn't help t=
he
> > > > > client with the large number of other servers that are out there
> > > > > (including older knfsd's).
> > > > >
> > > > > --b.
> > > > >
> > > > >> (I'm not saying that that's very helpful.)
> > > > >>
> > > > >> Andreas
> > > >
> > > > Hi everyone.....
> > > >  I have a customer facing this problem, and so stumbled onto the em=
ail
> > > >  thread.
> > > >  Unfortunately it didn't resolve anything.  Maybe I can help kick t=
hings
> > > >  along???
> > > >
> > > >  The core problem here is that NFSv4 and ext4 use different and lar=
gely
> > > >  incompatible ACL implementations.  There is no way to accurately
> > > >  translate from one to the other in general (common specific exampl=
es
> > > >  can be converted).
> > > >
> > > >  This means that either:
> > > >    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vic=
e
> > > >       versa) or
> > > >    2/ overlayfs need to accept that sometimes it cannot copy ACLs, =
and
> > > >       that is OK.
> > > >
> > > >  Silently not copying the ACLs is probably not a good idea as it mi=
ght
> > > >  result in inappropriate permissions being given away.  So if the
> > > >  sysadmin wants this (and some clearly do), they need a way to
> > > >  explicitly say "I accept the risk".
> > >
> > > So, I feel like silently copying ACLs up *also* carries a risk, if th=
at
> > > means switching from server-enforcement to client-enforcement of thos=
e
> > > permissions.
> > >
> > > Sorry, I know we had another thread recently about permissions in thi=
s
> > > situation, and I've forgotten the conclusion.
> > >
> > > Out of curiosity, what's done with selinux labels?
> > >
> >
> > overlayfs calls security_inode_copy_up_xattr(name) which
> > can fail (<0) allow (0) or skip(1).
> >
> > selinux_inode_copy_up_xattr() as well as smack_inode_copy_up_xattr()
> > skip their own xattr on copy up and fail any other xattr copy up.
>
> If it's OK to silently skip copying up security labels, maybe it's OK to
> silently skip NFSv4 ACLs too?
>

I think overlayfs inode security context is taken from overlayfs
mount parameters (i.e. per container context) and therefore
the lower security. xattr are ignored (CC Vivek).

Thanks,
Amir.
