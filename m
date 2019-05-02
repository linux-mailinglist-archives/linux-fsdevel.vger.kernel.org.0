Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEBF124E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBXEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 19:04:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfEBXEa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 19:04:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA620AF0C;
        Thu,  2 May 2019 23:04:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 03 May 2019 09:04:17 +1000
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
In-Reply-To: <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com> <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com> <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com> <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com> <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com> <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com> <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com> <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name> <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com> <875zqt4igg.fsf@notabene.neil.brown.name> <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com> <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
Message-ID: <87woj831ce.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 02 2019, Miklos Szeredi wrote:

> On Thu, May 2, 2019 at 10:05 AM Andreas Gruenbacher <agruenba@redhat.com>=
 wrote:
>>
>> On Thu, 2 May 2019 at 05:57, NeilBrown <neilb@suse.com> wrote:
>> > On Wed, May 01 2019, Amir Goldstein wrote:
>> > > On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
>> > >> On Tue, Dec 06 2016, J. Bruce Fields wrote:
>> > >> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wro=
te:
>> > >> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.=
hu> wrote:
>> > >> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
>> > >> >> > <andreas.gruenbacher@gmail.com> wrote:
>> > >> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gr=
uenbacher@gmail.com>:
>> > >> >> >
>> > >> >> >>> It's not hard to come up with a heuristic that determines if=
 a
>> > >> >> >>> system.nfs4_acl value is equivalent to a file mode, and to i=
gnore the
>> > >> >> >>> attribute in that case. (The file mode is transmitted in its=
 own
>> > >> >> >>> attribute already, so actually converting .) That way, overl=
ayfs could
>> > >> >> >>> still fail copying up files that have an actual ACL. It's st=
ill an
>> > >> >> >>> ugly hack ...
>> > >> >> >>
>> > >> >> >> Actually, that kind of heuristic would make sense in the NFS =
client
>> > >> >> >> which could then hide the "system.nfs4_acl" attribute.
>>
>> I still think the nfs client could make this problem mostly go away by
>> not exposing "system.nfs4_acl" xattrs when the acl is equivalent to
>> the file mode. The richacl patches contain a workable abgorithm for
>> that. The problem would remain for files that have an actual NFS4 ACL,
>> which just cannot be mapped to a file mode or to POSIX ACLs in the
>> general case, as well as for files that have a POSIX ACL. Mapping NFS4
>> ACL that used to be a POSIX ACL back to POSIX ACLs could be achieved
>> in many cases as well, but the code would be quite messy. A better way
>> seems to be to using a filesystem that doesn't support POSIX ACLs in
>> the first place. Unfortunately, xfs doesn't allow turning off POSIX
>> ACLs, for example.
>
> How about mounting NFSv4 with noacl?  That should fix this issue, right?

No.
"noacl" only affect NFSv3 (and maybe v2) and it disables use of the
NFSACL side-protocol.
"noacl" has no effect on an NFSv4 mount.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzLd3EACgkQOeye3VZi
gbm7ShAAgFO2IV6B0rQjQjJRJNWPCq1/rOKOmOZtssw/B8rl1YZYnMKUeFtNgSuX
KfAs6rK4sntvRkPnc/ObeZiXEQ3kLIqY9UQ8f7+u32eODZZUvJ8UjZTH6slVBpE3
IG2p6y35SRG0kS52l9AE1ktca+ZIGj4QyvBY1XgHZMG1hD/w3joUcoqWqMUofAqG
hedTE7db4rPEiYiBLVdmu/VZ6b6fNanPxD+zuWfYUJEertsPYE42pLbZsofMJKmc
KK4ijv1q33qhrgeZbj0vDGR0RQrSLgKgMa64xM6iYKBwLKuj6Q16gk7WgrMl+wMP
hmcL+3DmhMErwxH+/C7tOlymyrU36kJLQ1GjndMCKRejdh6z8imZC9jbt6pesL9E
DO09nblJ+NEuuvKitKtdnpcPuzMXoP7IM4p3xki9lRw5Cg87zcDlnPQI36x54y9d
4AFiqrKq8qvStl3ZlSLlyCou/UePbzlU3AAV+Pi3bT/o3/O/IgdwDmWqbS/hhJ+z
371LcGReYKVKyaEkCM9uYc9zuklmDkRGAPUyLyzRkR4061VpB9JlrsFoWlK41T1K
5jncgXLZDLmB8H+sXFwFYMFAkOA/0ZbHSGNIuKTetMlpXR2tEJ9GaPNtQmA1aV7k
14cQvKXpVwbY8z0+MTaPrW83lMpNCaLvMGj1lvOx5qjBFEeuVlk=
=JMrR
-----END PGP SIGNATURE-----
--=-=-=--
