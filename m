Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94F2F9EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 13:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbhARMCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 07:02:03 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:47018 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391295AbhARMBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:01:52 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 20887241;
        Mon, 18 Jan 2021 15:01:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1610971265;
        bh=vHceS8rgoIK1PXhk2Onpa85/3bo7y8S6c44QIUn8Dvc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=jS4AH8DQGIGzee+RTZzQr1+93TWOpdYVffshauAgsvCmw+ZGAdun0SXEzxVWoJCht
         y+E+f93NL5IEg7UOfLmxKyXwhqg+Ugj1UFks8SWhBrEcjtjJZHznKGUkfrjM6gaC4s
         rpSu9oN5BZRcU/rFozo9JxmTng45o8uOaUxJ+TJU=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 18 Jan 2021 15:01:04 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Mon, 18 Jan 2021 15:01:04 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: RE: [PATCH v17 05/10] fs/ntfs3: Add attrib operations
Thread-Topic: [PATCH v17 05/10] fs/ntfs3: Add attrib operations
Thread-Index: AQHW34lESlOgt0gdi0CCf1q7eejdPqoWbvYAgBbwkNA=
Date:   Mon, 18 Jan 2021 12:01:04 +0000
Message-ID: <4f25e89e96e644cfb0d200332a02efaf@paragon-software.com>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-6-almaz.alexandrovich@paragon-software.com>
 <20210104002554.gdxoyu2q2aaae5ph@kari-VirtualBox>
In-Reply-To: <20210104002554.gdxoyu2q2aaae5ph@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>
Sent: Monday, January 4, 2021 3:26 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de; ebiggers@kernel.org;
> andy.lavr@gmail.com
> Subject: Re: [PATCH v17 05/10] fs/ntfs3: Add attrib operations
>=20
> On Thu, Dec 31, 2020 at 06:23:56PM +0300, Konstantin Komarov wrote:
> > This adds attrib operations
> >
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software=
.com>
> > ---
> >  fs/ntfs3/attrib.c   | 2081 +++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs3/attrlist.c |  463 ++++++++++
> >  fs/ntfs3/xattr.c    | 1072 ++++++++++++++++++++++
> >  3 files changed, 3616 insertions(+)
> >  create mode 100644 fs/ntfs3/attrib.c
> >  create mode 100644 fs/ntfs3/attrlist.c
> >  create mode 100644 fs/ntfs3/xattr.c
> >
> > diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
>=20
> > +/*
> > + * al_find_ex
> > + *
> > + * finds the first le in the list which matches type, name and vcn
> > + * Returns NULL if not found
> > + */
> > +struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
> > +				   struct ATTR_LIST_ENTRY *le,
> > +				   enum ATTR_TYPE type, const __le16 *name,
> > +				   u8 name_len, const CLST *vcn)
> > +{
> > +	struct ATTR_LIST_ENTRY *ret =3D NULL;
> > +	u32 type_in =3D le32_to_cpu(type);
> > +
> > +	while ((le =3D al_enumerate(ni, le))) {
> > +		u64 le_vcn;
> > +		int diff;
> > +
> > +		/* List entries are sorted by type, name and vcn */
>=20
> Isn't name sorted with upcase sort.
>=20

Hi! You are correct. Will be fixed in v18.

> > +		diff =3D le32_to_cpu(le->type) - type_in;
> > +		if (diff < 0)
> > +			continue;
> > +
> > +		if (diff > 0)
> > +			return ret;
> > +
> > +		if (le->name_len !=3D name_len)
> > +			continue;
> > +
> > +		if (name_len &&
> > +		    memcmp(le_name(le), name, name_len * sizeof(short)))
> > +			continue;
>=20
> So does this compare name correctly? So it is caller responsible that
> name is up_cased? Or does it even mater.
>=20
> And this will check every name in right type. Why not use name_cmp and
> then we know if we over. It might be because performance. But maybe
> we can check that like every 10 iteration or something.
>=20

Now name check will be only for list_entry with vcn=3D=3D0.

> > +		if (!vcn)
> > +			return le;
> > +
> > +		le_vcn =3D le64_to_cpu(le->vcn);
> > +		if (*vcn =3D=3D le_vcn)
> > +			return le;
> > +
> > +		if (*vcn < le_vcn)
> > +			return ret;
> > +
> > +		ret =3D le;
>=20
> So we still have wrong vcn at this point. And we save that so we can
> return it. What happens if we will not found right one. Atlest function
> comment say that we should return NULL if we do not found matching entry.
>=20

Can't agree here.
E.g. given list_entry: 0, 67, 89, 110, 137.
The function will return 89 as the similar thread stores the info about vcn=
=3D=3D100.

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * al_find_le_to_insert
> > + *
> > + * finds the first list entry which matches type, name and vcn
>=20
> This comment seems wrong? This seems to find insert point for new
> le.
>=20

Thanks for this. Fixed.

> > + * Returns NULL if not found
> > + */
> > +static struct ATTR_LIST_ENTRY *
> > +al_find_le_to_insert(struct ntfs_inode *ni, enum ATTR_TYPE type,
> > +		     const __le16 *name, u8 name_len, const CLST *vcn)
> > +{
> > +	struct ATTR_LIST_ENTRY *le =3D NULL, *prev;
> > +	u32 type_in =3D le32_to_cpu(type);
> > +	int diff;
> > +
> > +	/* List entries are sorted by type, name, vcn */
> > +next:
> > +	le =3D al_enumerate(ni, prev =3D le);
> > +	if (!le)
> > +		goto out;
> > +	diff =3D le32_to_cpu(le->type) - type_in;
> > +	if (diff < 0)
> > +		goto next;
> > +	if (diff > 0)
> > +		goto out;
> > +
> > +	if (ntfs_cmp_names(name, name_len, le_name(le), le->name_len, NULL) >=
 0)
> > +		goto next;
>=20
> Why not go out if compare is < 0. In my mind this will totally ignore
> name and next just find right vcn (or we come next ID) and call it a day.
>=20

Will be fixed in v18 as well.

> NAME	VCN
> [AAB]	[2] <- Looks insert point for this.
>=20
> [AAA]	[1]
> [AAB]	[1]
> 	    <- This is right point.
> [AAC]	[1]
> 	    <- But we tell that insert point is here.
> [AAD]	[2]
>=20
> I might be totally wrong but please tell me what I'm missing.
>=20
> > +	if (!vcn || *vcn > le64_to_cpu(le->vcn))
> > +		goto next;
> > +
> > +out:
> > +	if (!le)
> > +		le =3D prev ? Add2Ptr(prev, le16_to_cpu(prev->size)) :
> > +			    ni->attr_list.le;
> > +
> > +	return le;
> > +}
>=20
> There seems to be lot of linear list search. Do you think it will be
> benefital to code binary or jump search for them? Just asking for
> intrest. Might be that it will not benefit at all but just thinking
> here.
>=20
> I might try to do that in some point if someone see point of that.

It's nice idea, we will appreciate such patch. But please keep in mind that
binary search will outperform linear dramatically only for heavily fragment=
ed files.
By the way, the same idea of replacing linear with binary search is impleme=
nted in
index.c (please refer to NTFS3_INDEX_BINARY_SEARCH).

Also, your notes on attrlist.c led us to refactor this file. Thanks once ag=
ain!

