Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55951401740
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbhIFHq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 03:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239159AbhIFHqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630914318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rz+YR3cHGAdOFamWnxSu+lMEoKqxQcmj2l/gnw8goKw=;
        b=fDE+V3pZARTM4LOvDM8Ua/d/NIx8HmZs0PJWEDIXq1XqEyFXwqwAg4pdPYNUkNo967lQ6t
        Dh+dZHBYY81I4CsjFrwe+ccyCToMf/0i5+O608R1EJKx+bTRvibfUBYJ0kNJwdg99/t9Ib
        dWlplYni76vdHjJ53NAiJxOVZoOF8SU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-lF0kagteMDOLq2xnIz6zwQ-1; Mon, 06 Sep 2021 03:45:17 -0400
X-MC-Unique: lF0kagteMDOLq2xnIz6zwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181111854E26;
        Mon,  6 Sep 2021 07:45:15 +0000 (UTC)
Received: from localhost (unknown [10.33.36.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F63626E73;
        Mon,  6 Sep 2021 07:45:04 +0000 (UTC)
Date:   Mon, 6 Sep 2021 09:45:04 +0200
From:   Sergio Lopez <slp@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, gscrivan@redhat.com,
        tytso@mit.edu, agruenba@redhat.com, miklos@szeredi.hu,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, bfields@redhat.com,
        christian.brauner@ubuntu.com
Subject: Re: [Virtio-fs] [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <20210906074504.2c6ytuw42qyedals@mhamilton>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
 <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5kiechtdhojtrqxg"
Content-Disposition: inline
In-Reply-To: <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5kiechtdhojtrqxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 03:34:17PM -0700, Casey Schaufler wrote:
> On 9/2/2021 1:06 PM, Vivek Goyal wrote:
> > On Thu, Sep 02, 2021 at 11:55:11AM -0700, Casey Schaufler wrote:
> >> On 9/2/2021 10:42 AM, Vivek Goyal wrote:
> >>> On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
> >>>> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
> >>>>> On 9/2/2021 8:22 AM, Vivek Goyal wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> This is V3 of the patch. Previous versions were posted here.
> >>>>>>
> >>>>>> v2:
> >>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoy=
al@redhat.com/
> >>>>>> v1:
> >>>>>> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgo=
yal@redhat.co
> >>>>>> +m/
> >>>>>>
> >>>>>> Changes since v2
> >>>>>> ----------------
> >>>>>> - Do not call inode_permission() for special files as file mode bi=
ts
> >>>>>>   on these files represent permissions to read/write from/to device
> >>>>>>   and not necessarily permission to read/write xattrs. In this case
> >>>>>>   now user.* extended xattrs can be read/written on special files
> >>>>>>   as long as caller is owner of file or has CAP_FOWNER.
> >>>>>> =20
> >>>>>> - Fixed "man xattr". Will post a patch in same thread little later=
=2E (J.
> >>>>>>   Bruce Fields)
> >>>>>>
> >>>>>> - Fixed xfstest 062. Changed it to run only on older kernels where
> >>>>>>   user extended xattrs are not allowed on symlinks/special files. =
Added
> >>>>>>   a new replacement test 648 which does exactly what 062. Just that
> >>>>>>   it is supposed to run on newer kernels where user extended xattrs
> >>>>>>   are allowed on symlinks and special files. Will post patch in=20
> >>>>>>   same thread (Ted Ts'o).
> >>>>>>
> >>>>>> Testing
> >>>>>> -------
> >>>>>> - Ran xfstest "./check -g auto" with and without patches and did n=
ot
> >>>>>>   notice any new failures.
> >>>>>>
> >>>>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
> >>>>>>   filesystems and it works.
> >>>>>> =20
> >>>>>> Description
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> Right now we don't allow setting user.* xattrs on symlinks and spe=
cial
> >>>>>> files at all. Initially I thought that real reason behind this
> >>>>>> restriction is quota limitations but from last conversation it see=
med
> >>>>>> that real reason is that permission bits on symlink and special fi=
les
> >>>>>> are special and different from regular files and directories, hence
> >>>>>> this restriction is in place. (I tested with xfs user quota enable=
d and
> >>>>>> quota restrictions kicked in on symlink).
> >>>>>>
> >>>>>> This version of patch allows reading/writing user.* xattr on symli=
nk and
> >>>>>> special files if caller is owner or priviliged (has CAP_FOWNER) w.=
r.t inode.
> >>>>> This part of your project makes perfect sense. There's no good
> >>>>> security reason that you shouldn't set user.* xattrs on symlinks
> >>>>> and/or special files.
> >>>>>
> >>>>> However, your virtiofs use case is unreasonable.
> >>>> Ok. So we can merge this patch irrespective of the fact whether virt=
iofs
> >>>> should make use of this mechanism or not, right?
> >> I don't see a security objection. I did see that Andreas Gruenbacher
> >> <agruenba@redhat.com> has objections to the behavior.
> >>
> >>
> >>>>>> Who wants to set user.* xattr on symlink/special files
> >>>>>> -----------------------------------------------------
> >>>>>> I have primarily two users at this point of time.
> >>>>>>
> >>>>>> - virtiofs daemon.
> >>>>>>
> >>>>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpri=
viliged
> >>>>>>   fuse-overlay as well and he ran into similar issue. So fuse-over=
lay
> >>>>>>   should benefit from this change as well.
> >>>>>>
> >>>>>> Why virtiofsd wants to set user.* xattr on symlink/special files
> >>>>>> ----------------------------------------------------------------
> >>>>>> In virtiofs, actual file server is virtiosd daemon running on host.
> >>>>>> There we have a mode where xattrs can be remapped to something els=
e.
> >>>>>> For example security.selinux can be remapped to
> >>>>>> user.virtiofsd.securit.selinux on the host.
> >>>>> As I have stated before, this introduces a breach in security.
> >>>>> It allows an unprivileged process on the host to manipulate the
> >>>>> security state of the guest. This is horribly wrong. It is not
> >>>>> sufficient to claim that the breach requires misconfiguration
> >>>>> to exploit. Don't do this.
> >>>> So couple of things.
> >>>>
> >>>> - Right now whole virtiofs model is relying on the fact that host
> >>>>   unpriviliged users don't have access to shared directory. Otherwise
> >>>>   guest process can simply drop a setuid root binary in shared direc=
tory
> >>>>   and unpriviliged process can execute it and take over host system.
> >>>>
> >>>>   So if virtiofs makes use of this mechanism, we are well with-in
> >>>>   the existing constraints. If users don't follow the constraints,
> >>>>   bad things can happen.
> >>>>
> >>>> - I think Smalley provided a solution for your concern in other thre=
ad
> >>>>   we discussed this issue.
> >>>>
> >>>>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3=
x3CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d650020361030209=
d6
> >>>>
> >>>>
> >>>>   "So for example if the host policy says that only virtiofsd can set
> >>>> attributes on those files, then the guest MAC labels along with all
> >>>> the other attributes are protected against tampering by any other
> >>>> process on the host."
> >> You can't count on SELinux policy to address the issue on a
> >> system running Smack.
> >> Or any other user of system.* xattrs,
> >> be they in the kernel or user space. You can't even count on
> >> SELinux policy to be correct. virtiofs has to present a "safe"
> >> situation regardless of how security.* xattrs are used and
> >> regardless of which, if any, LSMs are configured. You can't
> >> do that with user.* attributes.
> > Lets take a step back. Your primary concern with using user.* xattrs
> > by virtiofsd is that it can be modified by unprivileged users on host.
> > And our solution to that problem is hide shared directory from
> > unprivileged users.
>=20
> You really don't see how fragile that is, do you? How a single
> errant call to rename(), chmod() or chown() on the host can expose
> the entire guest to exploitation. That's not even getting into
> the bag of mount() tricks.
>=20
>=20
> > In addition to that, LSMs on host can block setting "user.*" xattrs by
> > virtiofsd domain only for additional protection.
>=20
> Try thinking outside the SELinux box briefly, if you possibly can.
> An LSM that implements just Bell & LaPadula isn't going to have a
> "virtiofs domain". Neither is a Smack "3 domain" system. Smack doesn't
> distinguish writing user xattrs from writing other file attributes
> in policy. Your argument requires a fine grained policy a'la SELinux.
> And an application specific SELinux policy at that.
>=20
> >  If LSMs are not configured,
> > then hiding the directory is the solution.
>=20
> It's not a solution at all. It's wishful thinking that
> some admin is going to do absolutely everything right, will
> never make a mistake and will never, ever, read the mount(2)
> man page.

It's not worse than hoping that every admin is going to set up the
right permissions on a file backing the disk image of a Virtual
Machine.

And I'm no simply justifying one bad thing with another thing that's
even worse, I'm just trying to realign our expectations with the
current threat model of Virtualization in Linux. The host is protected
against the guest, but the guest is *not* implicitly protected against
the host. Everything depends on the host's admin good faith and even
better security practices.

This is the very reason why Virtualization-based Confidential
Computing technologies such as AMD SEV and Intel TDX are attracting so
much attention lately, as they aim to close the gap and also protect
guest against the host (as a necessary step to build trust on its
contents and behavior). But this is outside virtio-fs's scope.

Sergio.

--5kiechtdhojtrqxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAmE1xvgACgkQ9GknjS8M
AjVbUA/9H9sr+WNhWi7imDYQtklzsAHSxBa8w79uML7k/ClaoFmIGpyVTjuongsV
goXou73G5l23oo4NOXqdv3tBqv5kK37FBQvT/FE8+IAuZhfMLvh1Olnl6V62GAv4
SyhkTS9Sgj/G7+5KgYgC1cAsawkIlB8j5YpbyLVrQfbGekzJTWu4KZGOpwyHZpvY
LJAhO59oO88K71WLzNi+PmKQZQaYDhJgsWsCQpYLTQiHZnHK1JK5pq7gzpsZ6D9X
4YCe20Eu+GvYd3LND8dHMdZfva3QXnX7UrFpclGI0+E/mBkYwVMa8X4d0YLOZsl+
0DDldJq73Yo9Jv6o9lK5ksOo2FyaR+G3LveitXAIcCIm+FH5wTPMa29e2jT1DWH/
T4cBSGAVl+oHSIvAZMPU9zXo80oc24Wgad8zLC6YSzeXMCbvIoE+syr/6AzvS8uf
uQIIrUO5jUCslLe8iuO3hMG30Fi+M237df1eKnmWfLGmfaGXzzyk6yzesgoEjl2m
GVI9vQKGsVdgNOmpl7VIGM1SJ257IKj2UIwlSmQ5oYnnbOlx88YKLZS1AzU+Yw30
CelIOkThUNUqIRKzWj/vOU8KNwE2imJWA9HLE3dHshHqE/kmaWoczU3lQvwaG5TQ
6UYEosEbW8gWvaJbNATyZadkFsBsIihj6mgyjrr0q1mZQNhaDiI=
=AxOB
-----END PGP SIGNATURE-----

--5kiechtdhojtrqxg--

