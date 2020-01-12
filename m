Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EE13864A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 13:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgALMXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 07:23:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbgALMXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 07:23:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so6644940wmc.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kYqPsqz2fSmAZdne4SFlcuR2jtxZf6MofXvO8TvPMnI=;
        b=E0R3CtXljri8CAk9Vhya8WkN0CcMW+d1Fz3o00KRX42s5Fd6/Jx3Lo8zYwCxdvg8gq
         yCpdCu/Xl1sSau4yLEzsd3GnpwiZ3H5IIjaczBy1y6bqRQtR6sM8CmhkAWioj05sI9tt
         WbV/DdCggnBK3EH4reS1YxWGCU3PAoQSKseCIqZbkQWZRwnP+q7DRS04Rf6bmZvGHh/i
         WpGLoDQvEuzvA+gsCW8AMQyDHKYfm3+yOBgSngFv3+tpQk+n27Ipv5slofQ86iSvgf00
         0mrIHVInItefSKrXSV6dTj/Gq71bc2Zx2+BLThnCtimr/HaGzIX8ptIy1qUv5ib05d8w
         WQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYqPsqz2fSmAZdne4SFlcuR2jtxZf6MofXvO8TvPMnI=;
        b=H5Ht/CDmhA6i3cJKcGAEQdalDy4WBV7kqHRG14gu96YcHwH6X5ZuciEtJQvx+KFKAY
         nqXRvxVmCDJUnugkW50hGam6tLR8elRQEn6RcRMF6mQCnhhEdWLZRgOVA3h9fFY5NNAd
         0B0BtM6v8BUXFta25Knb61Dq6qFzc8UxY2scEiASnWUcAAHOg8kZ9g1tVAuoSYAeV9SD
         +YZBF6bok4FLm1w3kUSGcD3t4hP3Sv11HscoI3NvhUoRFazQNDAHoyMrOuD8BWqOVzPU
         rcWcTyeb9zGqAwzDgy+u2+y4VSseW+zjKBf5J8xTuP063gCpKcW+lEIJxABP0QkiV8pD
         +dDA==
X-Gm-Message-State: APjAAAXJ85OY3IgwayiMF7r0AQSnkaQtsOHysOjhzNLevAAa5lL4jbAm
        o0jmt7HWejFMJykL44E2KzRUaXDL
X-Google-Smtp-Source: APXvYqyF5Fvg2iD7lfd7Pd3QOt7vo5IEmhjRRpn8I0z+4LG7x80YaUqMJL93WnVPi+E2f3QFZZhQJg==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr14914088wmo.13.1578831797652;
        Sun, 12 Jan 2020 04:23:17 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o15sm10578209wra.83.2020.01.12.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 04:23:16 -0800 (PST)
Date:   Sun, 12 Jan 2020 13:23:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix free space reporting for metadata and virtual
 partitions
Message-ID: <20200112122315.v7olirjcunhvo3fo@pali>
References: <20200108121919.12343-1-jack@suse.cz>
 <20200108223240.gi5g2jza3rxuzk6z@pali>
 <20200109124405.GE22232@quack2.suse.cz>
 <20200109125657.ir264jcd6oujox3a@pali>
 <20200109130837.b6f62jpeb3myns64@pali>
 <20200109165324.GA6145@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="glofotv527qexwnu"
Content-Disposition: inline
In-Reply-To: <20200109165324.GA6145@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--glofotv527qexwnu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 09 January 2020 17:53:24 Jan Kara wrote:
> On Thu 09-01-20 14:08:37, Pali Roh=C3=A1r wrote:
> > On Thursday 09 January 2020 13:56:57 Pali Roh=C3=A1r wrote:
> > > On Thursday 09 January 2020 13:44:05 Jan Kara wrote:
> > > > On Wed 08-01-20 23:32:40, Pali Roh=C3=A1r wrote:
> > > > > On Wednesday 08 January 2020 13:19:19 Jan Kara wrote:
> > > > > > Free space on filesystems with metadata or virtual partition ma=
ps
> > > > > > currently gets misreported. This is because these partitions ar=
e just
> > > > > > remapped onto underlying real partitions from which keep track =
of free
> > > > > > blocks. Take this remapping into account when counting free blo=
cks as
> > > > > > well.
> > > > > >=20
> > > > > > Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > >  fs/udf/super.c | 19 ++++++++++++++-----
> > > > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > I plan to take this patch to my tree.
> > > > > >=20
> > > > > > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > > > > > index 8c28e93e9b73..b89e420a4b85 100644
> > > > > > --- a/fs/udf/super.c
> > > > > > +++ b/fs/udf/super.c
> > > > > > @@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_tabl=
e(struct super_block *sb,
> > > > > >  static unsigned int udf_count_free(struct super_block *sb)
> > > > > >  {
> > > > > >  	unsigned int accum =3D 0;
> > > > > > -	struct udf_sb_info *sbi;
> > > > > > +	struct udf_sb_info *sbi =3D UDF_SB(sb);
> > > > > >  	struct udf_part_map *map;
> > > > > > +	unsigned int part =3D sbi->s_partition;
> > > > > > +	int ptype =3D sbi->s_partmaps[part].s_partition_type;
> > > > > > +
> > > > > > +	if (ptype =3D=3D UDF_METADATA_MAP25) {
> > > > > > +		part =3D sbi->s_partmaps[part].s_type_specific.s_metadata.
> > > > > > +							s_phys_partition_ref;
> > > > > > +	} else if (ptype =3D=3D UDF_VIRTUAL_MAP15 || ptype =3D=3D UDF=
_VIRTUAL_MAP20) {
> > > > > > +		part =3D UDF_I(sbi->s_vat_inode)->i_location.
> > > > > > +							partitionReferenceNum;
> > > > >=20
> > > > > Hello! I do not think that it make sense to report "free blocks" =
for
> > > > > discs with Virtual partition. By definition of VAT, all blocks pr=
ior to
> > > > > VAT are already "read-only" and therefore these blocks cannot be =
use for
> > > > > writing new data by any implementation. And because VAT is stored=
 on the
> > > > > last block, in our model all blocks are "occupied".
> > > >=20
> > > > Fair enough. Let's just always return 0 for disks with VAT partitio=
n.
> > > >=20
> > > > > > +	}
> > > > > > =20
> > > > > > -	sbi =3D UDF_SB(sb);
> > > > > >  	if (sbi->s_lvid_bh) {
> > > > > >  		struct logicalVolIntegrityDesc *lvid =3D
> > > > > >  			(struct logicalVolIntegrityDesc *)
> > > > > >  			sbi->s_lvid_bh->b_data;
> > > > > > -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> > > > > > +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
> > > > > >  			accum =3D le32_to_cpu(
> > > > > > -					lvid->freeSpaceTable[sbi->s_partition]);
> > > > > > +					lvid->freeSpaceTable[part]);
> > > > >=20
> > > > > And in any case freeSpaceTable should not be used for discs with =
VAT.
> > > > > And we should ignore its value for discs with VAT.
> > > > >=20
> > > > > UDF 2.60 2.2.6.2: Free Space Table values be maintained ... excep=
t ...
> > > > > for a virtual partition ...
> > > > >=20
> > > > > And same applies for "partition with Access Type pseudo-overwrita=
ble".
> > > >=20
> > > > Well this is handled by the 'accum =3D=3D 0xffffffff' condition bel=
ow. So we
> > > > effectively ignore these values.
> > >=20
> > > Ok.
> >=20
> > Now I'm thinking about another scenario: UDF allows you to have two
> > partitions of Type1 (physical) on one volume: one with read-only access
> > type and one with overwritable access type.
> >=20
> > UDF 2.60 2.2.6.2 says: For a partition with Access Type read-only, the
> > Free Space Table value shall be set to zero. And therefore we should
> > ignore it.
>=20
> That's what's going to happen (the code ends up ignoring values -1 and 0).

Ok, this could be enough.

> > But current implementation for discs without Metadata partition (all
> > with UDF 2.01) reads free space table (only) from partition
> >=20
> >   unsigned int part =3D sbi->s_partition;
> >=20
> > So is this s_partition one with read-only or overwritable access type?
>=20
> Well, this is the partition we've got fileset from. I presume that's going
> to be on overwritable partition but who knows. Honestly, I have my doubts
> we'll handle disks with two Type1 partitions correctly since I never met
> such disks :) Do you have some disk image to try? :)

Seems that I do not have such disk image.

But if kernel does not support handling such disks then it does not make
sense to do anything with this function which reports free blocks.

> > And to make it more complicated, UDF 2.60 2.2.10 requires that such dis=
cs
> > (with two partitions) needs to have also Metadata Partition Map.
>=20
> But in this case Metadata Partition Map is presumably over the overwritab=
le
> partition so we should fine, shouldn't we?

In both cases I'm just speculating what may happen... Nothing against
this patch.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--glofotv527qexwnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhsPsQAKCRCL8Mk9A+RD
UkDhAJ0Sxc1wDB1RbtcKeq0sQQxynit8nQCfSyBMoiaLRMMvjHSSKHbOoulzec4=
=awP1
-----END PGP SIGNATURE-----

--glofotv527qexwnu--
